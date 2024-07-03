Return-Path: <linux-pm+bounces-10526-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40AB09258A5
	for <lists+linux-pm@lfdr.de>; Wed,  3 Jul 2024 12:31:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF9931F28119
	for <lists+linux-pm@lfdr.de>; Wed,  3 Jul 2024 10:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE64D171E60;
	Wed,  3 Jul 2024 10:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="epj26xkK"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CAB116B3A1;
	Wed,  3 Jul 2024 10:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720002557; cv=none; b=V3BOr6bwajet+vykO9RXrDf+MXLexpX+D7dqId17ITQkAQKtULZuPL9ujKGofB9naqOzjY9Gs8tEWDBBBJOAsm8ZY/HwsfFkyM8hqVT4W6qXHJS+5JEMkWEE9wTqNWeCEqZil4Rvu0Wrb1EyyTWdz7XD66F55cLiR5rz/VoUcE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720002557; c=relaxed/simple;
	bh=B4WNw8wXkBCKBFf58QT0zrSvxmAlav4aJPMPgYIbRMk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ka6jBqhqGMV6dyW3y4kb+cJeuAj0ICo4GzxHrRMJiNalWxyF5WuOg5orE0kIVTgHF3pKB9eaPgRzMtXOBrbkHgK53dlS4Az/Ha5mIlnz+Ujt8CdbjsqoyJNZB2LuKl1HzZ7rybeVy52+vCKBgrcTPi3ATV4A3XPM34wl8O0cjFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=epj26xkK; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1720002518; x=1720607318; i=wahrenst@gmx.net;
	bh=jAC02KoradPvzXqRnWmVxtR3gPH1OjzL5CZrr+jt7K4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=epj26xkKFAdLT2ZLpnBFCxpXzXmDA1U1rVUV3gtZjpAd1iltqsS32pAvbySx+pTI
	 TKUHAKcmOi8nDGOmum2qJ3XmZE8OBkwpFK9Jl/y3dPXG1NiVRiIEYRpI4OvsVrgjc
	 /zNi5Kuw7ioThNbdUWVhHXyPEuHEvzOAKEyz/9BNAQhQy18iL4mlytBHwAxUZV/bx
	 QyEROm/F1I6L1RhzcNcqlSPZa2kz4xK6Nj1WfG1NYt6J70v9XgmA1r9ZpVz1BC5Q1
	 Whb/dswGckhGTyvpm/r/V2dKUmEsSH8YaFazFduSeg56rkeH6nDp1vl30d7uoHOgc
	 Yp6GbhOD79JOnXWTeQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.127] ([37.4.248.43]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MLzBj-1sgLUC3E8n-00Xvif; Wed, 03
 Jul 2024 12:28:37 +0200
Message-ID: <b4295be1-6fa4-4118-8554-b8a7cc605f9d@gmx.net>
Date: Wed, 3 Jul 2024 12:28:35 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/11] drm/vc4: hdmi: Disable connector status polling
 during suspend
To: Maxime Ripard <mripard@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Florian Fainelli <florian.fainelli@broadcom.com>, Ray Jui
 <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
 Thomas Gleixner <tglx@linutronix.de>, Jassi Brar <jassisinghbrar@gmail.com>,
 Ulf Hansson <ulf.hansson@linaro.org>, Jiri Slaby <jirislaby@kernel.org>,
 Minas Harutyunyan <hminas@synopsys.com>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Lukas Wunner <lukas@wunner.de>,
 Peter Robinson <pbrobinson@gmail.com>, dri-devel@lists.freedesktop.org,
 bcm-kernel-feedback-list@broadcom.com, linux-pm@vger.kernel.org,
 linux-serial@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, kernel-list@raspberrypi.com
References: <20240630153652.318882-1-wahrenst@gmx.net>
 <20240630153652.318882-8-wahrenst@gmx.net>
 <20240702-qualified-archetypal-worm-416a2f@houat>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <20240702-qualified-archetypal-worm-416a2f@houat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:UT5+Yw3VYpcDi8q6bxX8BCK3eK10KEYEuU0gMCBDS36Ky3v9LJS
 RjheGoBf7eRKRfWfYMUMQ6TvroecTcRXQG5eYxLs+cf4cZxgH3b4sqoQ0Qn9Xzhf0nwdbVS
 a1FlBLRfEmsSBj3A/qtP6kO5amazUu8UM1EAvv0N7tlkOALRd48YohXybfIiwTtR9yqUfOF
 Y/BH6DougG2G4ILmVqDZg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:I5jGHXRSDwM=;awFPIeF3O6wHlhyhVR5TIjSRdLj
 +8jbRAvxFK7f8ezP8Hl8y3ZqWH3q7qgAEUoaszJsr+1fvOnys4FIQqThEIw5YmeWgPbXp5s99
 kHtORwpkkK5hgRrvj2SToeBGjttzbummBtK17Fnp8wTsQU1xerPSeywHjiuXDKXxsRL8mQ+s6
 EhSuh6hXgdTU6IwBHdN3QZRGZxnvRvWSk5oQh2/bz5FCZ2sCK6TvHVYiRntqseVhVLuxngj05
 DpV1xsI4hI3dsIswyg57JAe9nI6eFd8iNVrYdxWSktz4emW2YM7kXeK6VZsx3LWbDP0jk5gvY
 ZfKbJavtcVWztldEOAprtD8x0AkrrWvDh4N4uh8Xhp792ze5YxbxOptjq9gHg+wCTVVrcPv1K
 5cJw82qQ6/OdE+3zDNFpmQDrRJZ6sDZZEdHCdmpyIfAJNuOEY/Bdrw/7LtFD8ju4uzFcb7wVZ
 o9FS0nQlsujNIX7Jebp4AtfqfrdHlbGoZXt1GZzQcBqgQUBh9sw5PjB49Y4qe3/DXTcqWBxBr
 5hPg1fE+3k1u0II7jwaTVqYPUVL5ghBFaKiwuWWtHce1mcoB5N2JaVBWuAKWna5D+CFvMbYLw
 +mQnPlQP19RraIdtpZPc0IEiiFzWvII0OGqkgRo9qTISy4v0ApIJa1Z72mvUJgJI4b6Ij2NFu
 i/TruhnFj3B1dpdXh7d1CPNSMkg/x59dcW043EX/vBWQv+tB4Jca8HzQ2xG8RmAiXcPCkLAnx
 Y/qZOuTWrKXO+YiCOx74MGb8SYKcJPxJIPMnYo70x7PO6Qe2BAR6hvA7jdDY2U0Hr7OpDhDTQ
 AYEgnud0LIdC9YqQ+P1BeiPIR3s1Y3Vo7AYH0o+Uzvzf8=

Hi Maxime,

Am 02.07.24 um 15:48 schrieb Maxime Ripard:
> Hi,
>
> On Sun, Jun 30, 2024 at 05:36:48PM GMT, Stefan Wahren wrote:
>> Suspend of VC4 HDMI will likely triggers a warning from
>> vc4_hdmi_connector_detect_ctx() during poll of connector status.
>> The power management will prevent the resume and keep the relevant
>> power domain disabled.
>>
>> Since there is no reason to poll the connector status during
>> suspend, the polling should be disabled during this.
>>
>> It not possible to use drm_mode_config_helper_suspend() here,
>> because the callbacks might be called during bind phase and not all
>> components are fully initialized.
>>
>> Link: https://lore.kernel.org/dri-devel/7003512d-7303-4f41-b0d6-a8af5bf=
8e497@gmx.net/
>> Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
>> ---
>>   drivers/gpu/drm/vc4/vc4_hdmi.c | 11 +++++++++++
>>   1 file changed, 11 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_h=
dmi.c
>> index b3a42b709718..e80495cea6ac 100644
>> --- a/drivers/gpu/drm/vc4/vc4_hdmi.c
>> +++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
>> @@ -3106,6 +3106,13 @@ static int vc5_hdmi_init_resources(struct drm_de=
vice *drm,
>>   static int vc4_hdmi_runtime_suspend(struct device *dev)
>>   {
>>   	struct vc4_hdmi *vc4_hdmi =3D dev_get_drvdata(dev);
>> +	struct drm_device *drm =3D vc4_hdmi->connector.dev;
>> +
>> +	/*
>> +	 * Don't disable polling if it was never initialized
>> +	 */
>> +	if (drm && drm->mode_config.poll_enabled)
>> +		drm_kms_helper_poll_disable(drm);
> Does it make sense to add it to runtime_suspend?
i saw that other drm drivers used drm_mode_config_helper_suspend() in
the RUNTIME_PM_OPS. But i agree, it should be better moved to
SYSTEM_SLEEP_PM_OPS.
> What if the board boots without a display connected, and only after a
> while one is connected? Wouldn't that prevent the driver from detecting
> it?
tbh I noticed that HDMI re-detection didn't worked in my setup 6.10-rcX
before this series. I need to investigate ...
>
> Maxime


