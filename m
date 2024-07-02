Return-Path: <linux-pm+bounces-10381-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A6469924891
	for <lists+linux-pm@lfdr.de>; Tue,  2 Jul 2024 21:47:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5139E1F226FC
	for <lists+linux-pm@lfdr.de>; Tue,  2 Jul 2024 19:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18C64142E77;
	Tue,  2 Jul 2024 19:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="Gn3N4xBd"
X-Original-To: linux-pm@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA8261CE0BC;
	Tue,  2 Jul 2024 19:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719949627; cv=none; b=un8PWMGyYrvhDe3xH1W3X/VtXiPk0YmyvXkdgGIvTNCHfZLIAIYAXBCko6paBcXt3Av6MZ8ADkQ4aq26TRloMxFjFLBulaOHM2IKs7uaOQ+FP05ttfTcS8ZoHLa8SqpF9OZEHhIe1/PyOGaAGW5EmQTr+Ef5ZJaTOFdCTn1xXwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719949627; c=relaxed/simple;
	bh=K4x11SUOMM6y1zNMKACNbl8folHmYwsL2pwPSCj15uM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OHaWls+VTZTKwoFpyDm0g2vC/h1J7rZvggiFn6sVhHyIM9DzbPHVxvL8FivAWglebw/gbV2SM7LY/wukaskFV5HOaZ/4+QRJMlkqOIk0qLBQT/jwMVszfKCYMw1UFvEdazoIRVCV3Yd5ILl5ak+kUvx2VUuC6imxPENHYiRMJgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=Gn3N4xBd; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=7Y/kIBa4MocqL5VsX4pa8YlTzbYsFHxrleMVSoRGylU=; b=Gn3N4xBdm+qM8pwbIk7A5brYm7
	LexsVZJ2whsJBS+iv3Ia2IW+LxgYzbSkz3gi0Zbtip7pmL3yAxQRAJ8Pe/ejdn3AKXwITEsy4NYUX
	C2vKGo/5jifhIwFVu8HuXl3D0UgDBdW1wfnCHj46j0lEF9YJQldF5U06WiRH7tw5N3KuziY6PI0dt
	HqE6LXEPstM4BUYS6lLqWwjMLoemkOMRlrpL324EFjEJ8fV10h7KuS2l/VnIFJ+XOLxkyizifp5oC
	Njsy0wi0DMtb2QkxqkX1bWiRj1DAEaVdJQn9qZdKZCU6rt/YzLC4Vb3E2v1mQeIkOewXf+gVdAj5y
	NjzTm7tQ==;
Received: from [187.36.213.55] (helo=[192.168.1.212])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1sOjSK-00ARCD-DC; Tue, 02 Jul 2024 21:46:24 +0200
Message-ID: <1e8b7043-b92f-4a91-8b71-48117a2da0c0@igalia.com>
Date: Tue, 2 Jul 2024 16:46:12 -0300
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/11] drm/vc4: hdmi: Handle error case of
 pm_runtime_resume_and_get
To: Stefan Wahren <wahrenst@gmx.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Florian Fainelli <florian.fainelli@broadcom.com>, Ray Jui
 <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Jassi Brar <jassisinghbrar@gmail.com>, Ulf Hansson <ulf.hansson@linaro.org>,
 Jiri Slaby <jirislaby@kernel.org>, Minas Harutyunyan <hminas@synopsys.com>
Cc: Dave Stevenson <dave.stevenson@raspberrypi.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Lukas Wunner <lukas@wunner.de>,
 Peter Robinson <pbrobinson@gmail.com>, dri-devel@lists.freedesktop.org,
 bcm-kernel-feedback-list@broadcom.com, linux-pm@vger.kernel.org,
 linux-serial@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, kernel-list@raspberrypi.com
References: <20240630153652.318882-1-wahrenst@gmx.net>
 <20240630153652.318882-7-wahrenst@gmx.net>
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
In-Reply-To: <20240630153652.318882-7-wahrenst@gmx.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/30/24 12:36, Stefan Wahren wrote:
> The commit 0f5251339eda ("drm/vc4: hdmi: Make sure the controller is
> powered in detect") introduced the necessary power management handling
> to avoid register access while controller is powered down.
> Unfortunately it just print a warning if pm_runtime_resume_and_get()
> fails and proceed anyway.
> 
> This could happen during suspend to idle. So we must assume it is unsafe
> to access the HDMI register. So bail out properly.
> 
> Fixes: 0f5251339eda ("drm/vc4: hdmi: Make sure the controller is powered in detect")
> Signed-off-by: Stefan Wahren <wahrenst@gmx.net>

 From the docs, I see that `DRM_ERROR` was deprecated in favor of
`pr_err()` (although I'm seeing some drivers using `dev_err()`). So,
after this change, this is:

Reviewed-by: Maíra Canal <mcanal@igalia.com>

It would be nice to have a follow-up patch changing other vc4 files,
as they are using `DRM_ERROR` when returning the error from
`pm_runtime_resume_and_get()`.

Best Regards,
- Maíra

> ---
>   drivers/gpu/drm/vc4/vc4_hdmi.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
> index d57c4a5948c8..b3a42b709718 100644
> --- a/drivers/gpu/drm/vc4/vc4_hdmi.c
> +++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
> @@ -429,6 +429,7 @@ static int vc4_hdmi_connector_detect_ctx(struct drm_connector *connector,
>   {
>   	struct vc4_hdmi *vc4_hdmi = connector_to_vc4_hdmi(connector);
>   	enum drm_connector_status status = connector_status_disconnected;
> +	int ret;
> 
>   	/*
>   	 * NOTE: This function should really take vc4_hdmi->mutex, but
> @@ -441,7 +442,11 @@ static int vc4_hdmi_connector_detect_ctx(struct drm_connector *connector,
>   	 * the lock for now.
>   	 */
> 
> -	WARN_ON(pm_runtime_resume_and_get(&vc4_hdmi->pdev->dev));
> +	ret = pm_runtime_resume_and_get(&vc4_hdmi->pdev->dev);
> +	if (ret) {
> +		DRM_ERROR("Failed to retain HDMI power domain: %d\n", ret);
> +		return status;
> +	}
> 
>   	if (vc4_hdmi->hpd_gpio) {
>   		if (gpiod_get_value_cansleep(vc4_hdmi->hpd_gpio))
> --
> 2.34.1
> 

