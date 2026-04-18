import imagemin from 'imagemin';
import imageminWebp from 'imagemin-webp';

(async () => {
	await imagemin(['images/*.jpg'], {
		destination: 'images',
		plugins: [imageminWebp({ quality: 70 })],
	});

	console.log('Images optimized');
})();
