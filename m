Return-Path: <linux-pm+bounces-11663-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5C0F9410B0
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jul 2024 13:38:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64EAE1F220E0
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jul 2024 11:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF26419E804;
	Tue, 30 Jul 2024 11:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="UJkpbcTZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0528519B3F9;
	Tue, 30 Jul 2024 11:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722339502; cv=none; b=F4Rkx8p7SCFN/zGSHjqBsEQEgiNqN+Re94QMYjJpQ7wLyQb5gHHwLIqluHIRziJel7TehvAikFKMK6sAN3C5rnUt316nvR1BLPTyVgcAnitlOc/ieGSGHlMW3UB6blzbPDJRh4r/+eP2NBwKIKv3UDuqaIyK0I8yp46bu8TgJLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722339502; c=relaxed/simple;
	bh=TiJNm9C+6IUH432PuhDQhEwXYsUueLlQfTMMK0FDgD4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UEumghNV2uQXgu4buIiC+3r1NcKKs64qbcyGQPcAst1tDImIp+pABsdUCHPqYISCBxijemXsY4TdhqDjRM+Fa9wu0uqEOO967FcafPF1TQMoa5oGwrp8HmCkzFKCz8G7/dWShMaoz00VnLzF25A8QuQJ4Pa2JuwIgknpzZUXr4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=UJkpbcTZ; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=5L/gocOQMZe6co0EPVC+ZcjsICkcAhqhaliJGAeQue4=; b=UJkpbcTZkH/f2Y9iKX2AR9YDXe
	Yc2W0yr9smfZobMe5fgLRV4lu5RjQoaNzasyRKgZhfZZkD1x7aZtj6Bc5DpgQMzN6+TroABgL61Y5
	9VRRbtR1rvMd38F1S0ARnaLU/pKM4EyCt4QpTxpP45o0YZ89bkx3D8hLx6g2J8pIyjBXDvCq+4B/2
	tHr5bW8/zoU5YPLUAU9OA4GkpBca9aHDIrrO+eG06OPOowR1qPr2z5UQ2Muxw91miMF7Qc+4T8IPj
	FWCtsHBEjMIAyp2VCwhCCFOYGfp2ujZfMCZI9Pjqba37xEzuVyHYWWT5b8m/Kj8jaWDcCEM1TuTZv
	FJtkwujg==;
Received: from [187.36.213.55] (helo=[192.168.1.212])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1sYlB6-005Zgc-5O; Tue, 30 Jul 2024 13:38:04 +0200
Message-ID: <0a680c00-f5b7-49f3-9b6e-852d147a5383@igalia.com>
Date: Tue, 30 Jul 2024 08:37:52 -0300
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 06/16] drm/vc4: hdmi: Handle error case of
 pm_runtime_resume_and_get
To: Stefan Wahren <wahrenst@gmx.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Florian Fainelli <florian.fainelli@broadcom.com>, Ray Jui
 <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
 Maxime Ripard <mripard@kernel.org>, Jassi Brar <jassisinghbrar@gmail.com>,
 Ulf Hansson <ulf.hansson@linaro.org>, Jiri Slaby <jirislaby@kernel.org>,
 Minas Harutyunyan <hminas@synopsys.com>
Cc: Dave Stevenson <dave.stevenson@raspberrypi.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Lukas Wunner <lukas@wunner.de>,
 Artur Petrosyan <Arthur.Petrosyan@synopsys.com>,
 Peter Robinson <pbrobinson@gmail.com>, dri-devel@lists.freedesktop.org,
 bcm-kernel-feedback-list@broadcom.com, linux-pm@vger.kernel.org,
 linux-serial@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, kernel-list@raspberrypi.com
References: <20240728114200.75559-1-wahrenst@gmx.net>
 <20240728114200.75559-7-wahrenst@gmx.net>
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
In-Reply-To: <20240728114200.75559-7-wahrenst@gmx.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/28/24 08:41, Stefan Wahren wrote:
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

Reviewed-by: Maíra Canal <mcanal@igalia.com>

Best Regards,
- Maíra

> ---
>   drivers/gpu/drm/vc4/vc4_hdmi.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
> index d57c4a5948c8..cb424604484f 100644
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
> @@ -441,7 +442,12 @@ static int vc4_hdmi_connector_detect_ctx(struct drm_connector *connector,
>   	 * the lock for now.
>   	 */
> 
> -	WARN_ON(pm_runtime_resume_and_get(&vc4_hdmi->pdev->dev));
> +	ret = pm_runtime_resume_and_get(&vc4_hdmi->pdev->dev);
> +	if (ret) {
> +		drm_err_once(connector->dev, "Failed to retain HDMI power domain: %d\n",
> +			     ret);
> +		return connector_status_unknown;
> +	}
> 
>   	if (vc4_hdmi->hpd_gpio) {
>   		if (gpiod_get_value_cansleep(vc4_hdmi->hpd_gpio))
> --
> 2.34.1
> 

