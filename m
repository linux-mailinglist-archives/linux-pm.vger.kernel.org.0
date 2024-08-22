Return-Path: <linux-pm+bounces-12722-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8A9A95B622
	for <lists+linux-pm@lfdr.de>; Thu, 22 Aug 2024 15:13:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41E54283C34
	for <lists+linux-pm@lfdr.de>; Thu, 22 Aug 2024 13:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B39E41C9EC6;
	Thu, 22 Aug 2024 13:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="jgV3uVRJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54D526AC1;
	Thu, 22 Aug 2024 13:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724332378; cv=none; b=kx+HXhmb+p7tM1yhMhv0NR3EbxUQEeoK+ag9JBq12TGxPS638vscZn0hVwoFab3nSPoFqr0xNBQ1dxZe9xm2NsGHU6ERc3zQeiyulcea7OAwfQSuP7k05XUxBJPOHejmvV9SHS2eDaT9U5r9RFMqOTmWgaHrDHtdUApx6D2OE2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724332378; c=relaxed/simple;
	bh=BnaQ9eK+wnBm/srVyRBJuFCTDEaSzdJHOex12u1gADE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d78faJYH4INJyK6n031SYM+nghDaJsfkUNvFBXWuZMRuKN0IKBgYBj+R7cYNdDQDW5x5DWICuc8beGqgn7fLjoNGZVoCXPzkKjTw+SdV9jpCByD41fBKqz4hR3tzh+BXF15DN03i2FVREuYITunOzW+C9ALL+JP9vug3uVQv948=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=jgV3uVRJ; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=wObj0euxx2b3n2yWXhu+gvJpX19pu26o3+soT2tlK6g=; b=jgV3uVRJFLvxpxUGD/y0zq9lb6
	7bqCUeM1j/B/b0EcukTCpnRbltCzIu18AvW9tv8ukZjLDmHD2FIQoyCa7+I2CtZd5jmkE/wnNZ+T+
	kcms8B/RNSzcg4x3s7NegGqd7BFVUVgjINR651YzOd6XH5ruMzN/fjT1QIyGH1ucTCdWeNgf3/Uhg
	bqXjtCckYtYlkfeDM5Y0kQdn8GakcyE/h81QG5nY7oZXjYT8vYuLF/yItd8l5YmFt0BmSD+2L9gc5
	CMKQZsbpIqf+S9boavV7R0om8CUHknr2PspFQE2D/ysjphhElRkj4+ilk39w45t9MVQ1tIVFKPBoH
	KZgImsEw==;
Received: from [187.36.213.55] (helo=[192.168.1.212])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1sh7cH-003Z5P-N9; Thu, 22 Aug 2024 15:12:41 +0200
Message-ID: <85fbee77-4457-449a-b85a-342a67f9f5e4@igalia.com>
Date: Thu, 22 Aug 2024 10:12:31 -0300
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 5/9] drm/vc4: v3d: simplify clock retrieval
To: Stefan Wahren <wahrenst@gmx.net>, Russell King <linux@armlinux.org.uk>,
 Doug Anderson <dianders@chromium.org>,
 Florian Fainelli <florian.fainelli@broadcom.com>, Ray Jui
 <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
 Maxime Ripard <mripard@kernel.org>, Jassi Brar <jassisinghbrar@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Minas Harutyunyan <hminas@synopsys.com>
Cc: Dave Stevenson <dave.stevenson@raspberrypi.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Lukas Wunner <lukas@wunner.de>,
 Artur Petrosyan <Arthur.Petrosyan@synopsys.com>,
 Peter Robinson <pbrobinson@gmail.com>, dri-devel@lists.freedesktop.org,
 bcm-kernel-feedback-list@broadcom.com, linux-pm@vger.kernel.org,
 linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 kernel-list@raspberrypi.com
References: <20240821214052.6800-1-wahrenst@gmx.net>
 <20240821214052.6800-6-wahrenst@gmx.net>
Content-Language: en-US
From: =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Autocrypt: addr=mcanal@igalia.com; keydata=
 xjMEZIsaeRYJKwYBBAHaRw8BAQdAGU6aY8oojw61KS5rGGMrlcilFqR6p6ID45IZ6ovX0h3N
 H01haXJhIENhbmFsIDxtY2FuYWxAaWdhbGlhLmNvbT7CjwQTFggANxYhBDMCqFtIvFKVRJZQ
 hDSPnHLaGFVuBQJkixp5BQkFo5qAAhsDBAsJCAcFFQgJCgsFFgIDAQAACgkQNI+cctoYVW5u
 GAEAwpaC5rI3wD8zqETKwGVoXd6+AbmGfZuVD40xepy7z/8BAM5w95/oyPsHUqOsg/xUTlNp
 rlbhA+WWoaOXA3XgR+wCzjgEZIsaeRIKKwYBBAGXVQEFAQEHQGoOK0jgh0IorMAacx6WUUWb
 s3RLiJYWUU6iNrk5wWUbAwEIB8J+BBgWCAAmFiEEMwKoW0i8UpVEllCENI+cctoYVW4FAmSL
 GnkFCQWjmoACGwwACgkQNI+cctoYVW6cqwD/Q9R98msvkhgRvi18fzUPFDwwogn+F+gQJJ6o
 pwpgFkAA/R2zOfla3IT6G3SBoV5ucdpdCpnIXFpQLbmfHK7dXsAC
In-Reply-To: <20240821214052.6800-6-wahrenst@gmx.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Stefan,

On 8/21/24 18:40, Stefan Wahren wrote:
> Common pattern of handling deferred probe can be simplified with
> dev_err_probe() and devm_clk_get_optional(). This results in much
> less code.
> 
> Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
> Reviewed-by: Maíra Canal <mcanal@igalia.com>

Applied to drm/misc/kernel/drm-misc-next!

Best Regards,
- Maíra

> ---
>   drivers/gpu/drm/vc4/vc4_v3d.c | 18 +++---------------
>   1 file changed, 3 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/gpu/drm/vc4/vc4_v3d.c b/drivers/gpu/drm/vc4/vc4_v3d.c
> index 6e566584afbf..bf5c4e36c94e 100644
> --- a/drivers/gpu/drm/vc4/vc4_v3d.c
> +++ b/drivers/gpu/drm/vc4/vc4_v3d.c
> @@ -441,21 +441,9 @@ static int vc4_v3d_bind(struct device *dev, struct device *master, void *data)
>   	vc4->v3d = v3d;
>   	v3d->vc4 = vc4;
> 
> -	v3d->clk = devm_clk_get(dev, NULL);
> -	if (IS_ERR(v3d->clk)) {
> -		int ret = PTR_ERR(v3d->clk);
> -
> -		if (ret == -ENOENT) {
> -			/* bcm2835 didn't have a clock reference in the DT. */
> -			ret = 0;
> -			v3d->clk = NULL;
> -		} else {
> -			if (ret != -EPROBE_DEFER)
> -				dev_err(dev, "Failed to get V3D clock: %d\n",
> -					ret);
> -			return ret;
> -		}
> -	}
> +	v3d->clk = devm_clk_get_optional(dev, NULL);
> +	if (IS_ERR(v3d->clk))
> +		return dev_err_probe(dev, PTR_ERR(v3d->clk), "Failed to get V3D clock\n");
> 
>   	ret = platform_get_irq(pdev, 0);
>   	if (ret < 0)
> --
> 2.34.1
> 

