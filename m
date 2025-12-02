Return-Path: <linux-pm+bounces-39043-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B1933C9A732
	for <lists+linux-pm@lfdr.de>; Tue, 02 Dec 2025 08:31:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 93A3B4E2F89
	for <lists+linux-pm@lfdr.de>; Tue,  2 Dec 2025 07:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2561F2989B7;
	Tue,  2 Dec 2025 07:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="bY3TTYiS"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C9261C7012;
	Tue,  2 Dec 2025 07:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764660685; cv=none; b=RaYVFLfOuxVB5r1WC3+/DWlv75AM5iKSTjorZxSrwRA1hu4j9z3CtIY1T7wc+KodNfQjYOcPVi3noRqKwaARY1AIIQ1nGBHAA/7B6xHbXGWJhPPH23+skecptbqgJ9Ssp6qUFoVHUYlLrtgmJ4uk0dbb0ObxwJ1ibpwF20ScAaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764660685; c=relaxed/simple;
	bh=rWht80TdDMbsCZaWcUFcjjhYySkfTb93xasOXU5Ylxc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a3HLIaOZwrfYtozKIAvsRlYQuKmbwvbu3/ugjfxFd+JbYrkV1Tyie0uddKjBQoCh3IJ8WHloEvBYkoZfrb9wiAvmF37+zJqwTBmrms84+PInSdhFjG+fiS7iSux/HTMnR0dUovu8MwQp5D4aBiMXxzonx5FbvNXN7GTD65za+x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=bY3TTYiS; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 07D5A1A1EB5;
	Tue,  2 Dec 2025 07:31:20 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id C3C60606E3;
	Tue,  2 Dec 2025 07:31:19 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 403D9103C8F04;
	Tue,  2 Dec 2025 08:30:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1764660676; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=gutkuk21iRBLBzb9hvOl6cUp6HFUU/VZ7OrEhTRZmwQ=;
	b=bY3TTYiSLFXa5B94KQgeAayt80JXK78ig76Aq2SyfufNuWcT41c/auFS4kPqbVeYIZlJKX
	QrXrN/qRIP4zNsj2m/7od8XOWVPza9ZQvvaa8nia4r3ByMuNdtTuF/t2v7gxBFCMMsW9RB
	i0p/8OBYWY3+n3FRUeyswfCRhz6Fv2at184ftP1FUUlpPAnLeFkqXVNSm5O6zbN24Wre4+
	N8LDjO5ty4mD4BpDEbuBV6eat2hrRdfThqf+Hnymm7a9OslgagnMsXhZ11fV4HVQz7RWeL
	AMcHDMFpAB93S2dU0dURDWQPs1MVtcc1ZnrYa/w6k4129RIITI9OMaZRIN58Wg==
From: Romain Gantois <romain.gantois@bootlin.com>
To: MyungJoo Ham <myungjoo.ham@samsung.com>,
 Chanwoo Choi <cw00.choi@samsung.com>, Guenter Roeck <linux@roeck-us.net>,
 Peter Rosin <peda@axentia.se>, Jonathan Cameron <jic23@kernel.org>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Mariel Tinaco <Mariel.Tinaco@analog.com>,
 Kevin Tsai <ktsai@capellamicro.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Eugen Hristev <eugen.hristev@linaro.org>, Vinod Koul <vkoul@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 Sebastian Reichel <sre@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Hans de Goede <hansg@kernel.org>,
 Support Opensource <support.opensource@diasemi.com>,
 Paul Cercueil <paul@crapouillou.net>, Iskren Chernev <me@iskren.info>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Matheus Castello <matheus@castello.eng.br>,
 Saravanan Sekar <sravanhome@gmail.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Pali =?UTF-8?B?Um9ow6Fy?= <pali@kernel.org>,
 Orson Zhai <orsonzhai@gmail.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Chunyan Zhang <zhang.lyra@gmail.com>, Amit Kucheria <amitk@kernel.org>,
 Thara Gopinath <thara.gopinath@gmail.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Sylwester Nawrocki <s.nawrocki@samsung.com>,
 Olivier Moysan <olivier.moysan@foss.st.com>,
 Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 David Lechner <dlechner@baylibre.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-input@vger.kernel.org,
 linux-phy@lists.infradead.org, linux-pm@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-mediatek@lists.infradead.org,
 linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH] iio: inkern: Use namespaced exports
Date: Tue, 02 Dec 2025 08:30:58 +0100
Message-ID: <5948030.DvuYhMxLoT@fw-rgant>
In-Reply-To: <78240755-44dc-4835-aca5-99540cca0304@baylibre.com>
References:
 <20251201-iio-inkern-use-namespaced-exports-v1-1-da1935f70243@bootlin.com>
 <78240755-44dc-4835-aca5-99540cca0304@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart6220005.lOV4Wx5bFT";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
X-Last-TLS-Session-Version: TLSv1.3

--nextPart6220005.lOV4Wx5bFT
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Romain Gantois <romain.gantois@bootlin.com>
Subject: Re: [PATCH] iio: inkern: Use namespaced exports
Date: Tue, 02 Dec 2025 08:30:58 +0100
Message-ID: <5948030.DvuYhMxLoT@fw-rgant>
In-Reply-To: <78240755-44dc-4835-aca5-99540cca0304@baylibre.com>
MIME-Version: 1.0

On Monday, 1 December 2025 18:15:54 CET David Lechner wrote:
> On 12/1/25 4:59 AM, Romain Gantois wrote:
> > Use namespaced exports for IIO consumer API functions.
> > 
> > Signed-off-by: Romain Gantois <romain.gantois@bootlin.com>
> > ---
> 
> ...
> 
> > diff --git a/drivers/iio/dac/ds4424.c b/drivers/iio/dac/ds4424.c
> > index a8198ba4f98a..33d6692f46fe 100644
> > --- a/drivers/iio/dac/ds4424.c
> > +++ b/drivers/iio/dac/ds4424.c
> > @@ -14,7 +14,6 @@
> > 
> >  #include <linux/iio/iio.h>
> >  #include <linux/iio/driver.h>
> >  #include <linux/iio/machine.h>
> > 
> > -#include <linux/iio/consumer.h>
> 
> Unrelated change?

Indeed, I'll leave that out in v2.

> >  #define DS4422_MAX_DAC_CHANNELS		2
> >  #define DS4424_MAX_DAC_CHANNELS		4
> > 
> > @@ -321,3 +320,4 @@ MODULE_AUTHOR("Ismail H. Kose
> > <ismail.kose@maximintegrated.com>");> 
> >  MODULE_AUTHOR("Vishal Sood <vishal.sood@maximintegrated.com>");
> >  MODULE_AUTHOR("David Jung <david.jung@maximintegrated.com>");
> >  MODULE_LICENSE("GPL v2");
> > 
> > +MODULE_IMPORT_NS("IIO_CONSUMER");
> 
> Is this actually needed if we don't use anything from consumer.h?

No, it's not.

Thanks,

-- 
Romain Gantois, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--nextPart6220005.lOV4Wx5bFT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEIcCsAScRrtr7W0x0KCYAIARzeA4FAmkulbIACgkQKCYAIARz
eA6r+A//aMF01GyQ28Vt1qVRnR+uQNAhVi/B2aUu4XYyy1hc2lVzhHwvSjyYiXET
h1jorSaLD9m5MsoTo9Scxhpu1d5KWIy5DaNATac1wmHh9t0IdE8gw1kNaUcNmefr
NFOanFttvVt7e9cko6PsxmX9GOioawS3CVrJuObkGGftqR3KVD3WMOg+n551pkK4
63Xbfe6PPADF06Lyu2kyyxUXLwIsuXQ8Z4dQ+kX4Bky34L0v4w0Yxos4Uhkwv5ur
SOUtezyExAQTgAJi9KW5MPADpCdXfB3moTv29CdWRs1K8XLkxxLeprZnutXRFxOu
CrmiA30lNs2pp7wut+8PfmeYX6btqOCMQ8KENXNV9StrRc9UqD6K6TbbJGE/Vbzg
gxDVp9t0i0nxcQAwhtvnlmAjf3pxeJWXf1iII5ooXoxv2yW1G+FsL9RBztyEnTA1
0iLFg1Yyx/28b7iZsf6oD5luqSRnQ7Qi0js5sAA3rVHfMtOlO/rGcUH1BprrpLPa
m5jycApgp26OuCSxacOhlAZ6iXy1pyepTaDlS9wz1kbdwVJOf3IaWuRhDHrRugCd
zya/579XFCsbobzejkSRHzgwylhuGsDMAniIn0MaeQw3E5wyBTCVJTXx9qebFj3v
sUVcLNhFQBy/G8YWighvreSaPr43mWS4ueBmAMClqYmOzq2nF2k=
=n+bE
-----END PGP SIGNATURE-----

--nextPart6220005.lOV4Wx5bFT--




