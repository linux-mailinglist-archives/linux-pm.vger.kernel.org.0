Return-Path: <linux-pm+bounces-11350-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BC5893A4F2
	for <lists+linux-pm@lfdr.de>; Tue, 23 Jul 2024 19:28:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EBD9283B27
	for <lists+linux-pm@lfdr.de>; Tue, 23 Jul 2024 17:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF429158866;
	Tue, 23 Jul 2024 17:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="Y/KpqwE6"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D8F158848;
	Tue, 23 Jul 2024 17:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721755689; cv=none; b=ZWFyV5cZOJl7sQM8Izw3MECDxoYFuCMdulNxrepJLmgrMumBOL+RSQlPPY1vkMq36qj/X+8wR6LXtbV8tC6wGRShKOkzJnI3g/pJ5IT2I6tQVXc9sJGTgihfxIkfJXQf2LQ8EtQ6LFFCcHV9zY2U5fdJAp4CjTMoXUrZ/RmHxBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721755689; c=relaxed/simple;
	bh=ejYMhhfHckj+3PtMfK7nop2ITFE6angxRFcmJSSjT0I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CX7X/k34R96sTNtPlP+5dncJ68d681c3zXgRjInjeD98ZadcYA3LYEVSbtt8w9e3SvlM+VVQ88BJNOYfJZmgFCrMoXIL3aHv9oJkP42OBFlxn+P+XmqeQc7v1dB5IVzOemVPRtxRDUEMsWBSpDCqR7duSyAcRFcjLG9I8D1d6as=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=Y/KpqwE6; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1721755644; x=1722360444; i=wahrenst@gmx.net;
	bh=80fjjAf9XBmhMPzSq4fA1co69LzROIvpMlHPKGRpFfo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Y/KpqwE6ibEsV6yVHuH8aRQNyQdjStlltEWXEQjuX6Nd/jrbur0r+XmG3qKnkNsZ
	 BTvhsCTzT7W0kBbtv/8Lv5zqADvkjQOExyVSDgvURiNe7WSWT9I5AbTie/oZxGDEP
	 wDv2GAM7so+ZSMDaRmrWlWMbHotwfbAFLYgNK48yTHYc2a4bxukSC73ZA/2ijIbDU
	 AHaNP+MlB/qLmOdL0T7AYtUfcnMLZIoSwWKqtQtwIpOthT00ZcXUwqdMFR7gcf8Pz
	 Uo5TpFLjAdk4/sPEV1LZLhPHO0aKQufqK+qiScRimfuKRyq6CntG1snlkCpZQJvMY
	 jBtoydziH6XXzdqiMA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.127] ([37.4.248.43]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N79uI-1sFai008ei-00vs3P; Tue, 23
 Jul 2024 19:27:24 +0200
Message-ID: <7f498dd6-f21e-481c-bff9-1449327ac94a@gmx.net>
Date: Tue, 23 Jul 2024 19:27:21 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/11] drm/vc4: hdmi: Handle error case of
 pm_runtime_resume_and_get
To: Maxime Ripard <mripard@kernel.org>, =?UTF-8?Q?Ma=C3=ADra_Canal?=
 <mcanal@igalia.com>
Cc: Dave Stevenson <dave.stevenson@raspberrypi.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Lukas Wunner <lukas@wunner.de>,
 Jiri Slaby <jirislaby@kernel.org>, Jassi Brar <jassisinghbrar@gmail.com>,
 Minas Harutyunyan <hminas@synopsys.com>,
 Peter Robinson <pbrobinson@gmail.com>, Ulf Hansson <ulf.hansson@linaro.org>,
 Scott Branden <sbranden@broadcom.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 dri-devel@lists.freedesktop.org, bcm-kernel-feedback-list@broadcom.com,
 Ray Jui <rjui@broadcom.com>, linux-pm@vger.kernel.org,
 linux-serial@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, kernel-list@raspberrypi.com
References: <20240630153652.318882-1-wahrenst@gmx.net>
 <20240630153652.318882-7-wahrenst@gmx.net>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <20240630153652.318882-7-wahrenst@gmx.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Nzd9l7pAHFgSgPujxmJeeQJNfuVnleLtW7GuiqkrRWzJSKop67p
 CkCMyNTcAlgTI6rANC3i6Hr+cwhws5UFKyfxhJYlT+fFiE6H1IKQKNxG30c3ZlcIk8SLEmj
 DiwyUF/125vIN7zUdywBPNMJZf58SsvuGdwiRcWJ9FbzcA9V8CIKdofia2cmgA2Y3PUT+TO
 t8b0OZe6qUAU/9Lo6vaUQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:wpdg22WfDQk=;AKCwxABGI9PRvrQviv1h7ESd+Sp
 o1MZ8bg8S3PJomoQA+DXQ5d+bR0slqcHco8FPUCX5gHvCtYLhYqqimQx9IrVOvaFYr6ZhK+Fu
 Q0d+UQWui6jQfVr6O73GT1zvOJIEYZKED90eo0DgZYPZFw1AYrpreC1gmP05iV8hvdF2ZogHN
 +7mRQZoWKGwOpkL9D/a93huFBvzzuf+qpGKZrEjVM28Gnc2pIEMyFaecMjKCYiLHHeYEkoO6P
 AkSPL9c/z2zPD2Y84gAuDiGoCe7RjIPxLS6ZbhNgPKeCmm+IfBBfbaxesBwxHOOYtLHiPQJ7b
 hdZFeHlP3ydrRtpU0I7isoXu6jJl2E9kLEQB2Y3gIT7UNt79vAdMVvs1vET0U6QqTtK6ssG2u
 EEt9oUWFvcOSCy2dOZEnRL1pDrS3KNMnxizI5c3WGv8K+kVTL8V2IbiLGwLRS4J+za/7sj4XV
 W92kziet+mXRzjRgcwn8o0jnJQF+smk2+arLjtOgeo2u5bHTEFwCNktD+KwBXIHFRg0Lbz+JV
 LrUVR0ri5IaJDVoNOECoTQLhVAUH+GmVb1vp9Az9r6a48N4qr6pDI+7/Em6XcW0n9iT05djGT
 +LTtUyaslE7etrGgLADfvDRwTOoTnHRljG+J2qISrPNHTKBlAcAvMTNq72vecrMF+qEwpAcQf
 aeVf1Q2BKarzFGhxLvGT4WW6MExX/cH065q8CFyiNIUuVxNvxq0suE5RbIHrCl7jpSZTS6u82
 wJuNhGK7fKr9Ti/jCyN50fWRai61FVL+Z2ohG6MH7LeMr34S6kAfv/UUmqmrXhPY9fl+tPg7p
 LkreV75flkZIMi94z3lu7sWA==

Hello,

Am 30.06.24 um 17:36 schrieb Stefan Wahren:
> The commit 0f5251339eda ("drm/vc4: hdmi: Make sure the controller is
> powered in detect") introduced the necessary power management handling
> to avoid register access while controller is powered down.
> Unfortunately it just print a warning if pm_runtime_resume_and_get()
> fails and proceed anyway.
>
> This could happen during suspend to idle. So we must assume it is unsafe
> to access the HDMI register. So bail out properly.
>
> Fixes: 0f5251339eda ("drm/vc4: hdmi: Make sure the controller is powered=
 in detect")
> Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
> ---
>   drivers/gpu/drm/vc4/vc4_hdmi.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hd=
mi.c
> index d57c4a5948c8..b3a42b709718 100644
> --- a/drivers/gpu/drm/vc4/vc4_hdmi.c
> +++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
> @@ -429,6 +429,7 @@ static int vc4_hdmi_connector_detect_ctx(struct drm_=
connector *connector,
>   {
>   	struct vc4_hdmi *vc4_hdmi =3D connector_to_vc4_hdmi(connector);
>   	enum drm_connector_status status =3D connector_status_disconnected;
> +	int ret;
>
>   	/*
>   	 * NOTE: This function should really take vc4_hdmi->mutex, but
> @@ -441,7 +442,11 @@ static int vc4_hdmi_connector_detect_ctx(struct drm=
_connector *connector,
>   	 * the lock for now.
>   	 */
>
> -	WARN_ON(pm_runtime_resume_and_get(&vc4_hdmi->pdev->dev));
> +	ret =3D pm_runtime_resume_and_get(&vc4_hdmi->pdev->dev);
> +	if (ret) {
> +		DRM_ERROR("Failed to retain HDMI power domain: %d\n", ret);
> +		return status;
I noticed today that the enum drm_connector_status also supports
connector_status_unknown. Wouldn't this be a more appropriate return
value in this error case?

Why isn't status initialized with connector_status_unknown at all?

Best regards
> +	}
>
>   	if (vc4_hdmi->hpd_gpio) {
>   		if (gpiod_get_value_cansleep(vc4_hdmi->hpd_gpio))
> --
> 2.34.1
>


