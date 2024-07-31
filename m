Return-Path: <linux-pm+bounces-11764-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6A91943447
	for <lists+linux-pm@lfdr.de>; Wed, 31 Jul 2024 18:43:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9849D28551D
	for <lists+linux-pm@lfdr.de>; Wed, 31 Jul 2024 16:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A4BA1BBBF4;
	Wed, 31 Jul 2024 16:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="c8RvytmD"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E761773A;
	Wed, 31 Jul 2024 16:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722444213; cv=none; b=nP30SM80k5HY6BB2HRjIqOIERS/pGT0EKGj1gfgc0G802iRZXDBsR9zSlN0sYdJjUCUN9sSJ+tEUV8w5JrAhi8R53QyrRWIHKd9Sr3tf9B4XT33aj+93X4YGiXUx2/C1ijKkHYq3VakE/nv6+7DLBuvmPo95IwgPgGZRBcLsz+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722444213; c=relaxed/simple;
	bh=8ZYpBCvt2i0jwH+07fKHzqh9A/o3rs6M3lytTmw64OU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bWFZFTh2/6rMmO1WWraIV0kPNpAcn0n5S9AI5/OPueVZaxYnpgRpXl8xTqySmfaxnumALiQdHM4Ge5lT378gUHlNlUeqrNP+Yhul+qYwcqvzZLtJxJCoxFKbDHtnmtMvyPqG5em1XjBbCFSFB+JJCLalggk8sbi6V2D4X6uchOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=c8RvytmD; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1722444124; x=1723048924; i=wahrenst@gmx.net;
	bh=8ZYpBCvt2i0jwH+07fKHzqh9A/o3rs6M3lytTmw64OU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=c8RvytmDsuGD1qMoRMvDVm7e/fkbnBmjPE6iU0f5DDrSFYq3l2taEY9LlZx9C0+d
	 bWH23DxMuUoEg7H5tW2VvFFkfACu7O4iySXegxMLRuXScPlaHSwvxF/QzuT910sKb
	 csYmZA+bQOW7YySAW9tn7lcOoe4nieXY6ZySeI+H0R1NhIr0/SxfGTV7Qege+9+gM
	 2FC21m3U3QA2KF9+Ox1Cu4r3qCO4lIglILnHGQMgqiKKa0kyRV/aat1xZstBfO0va
	 Mm2cpBAvBKsav5VcGhG0WRQ4x3Ts5QZt9CWjsqFloR1wfeufCeAGUM1wMINqDqFQC
	 TZXbmWmLaVNSPWDLtA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.127] ([37.4.248.43]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MZTmO-1smru941VG-00OdA3; Wed, 31
 Jul 2024 18:42:04 +0200
Message-ID: <b34cc73c-721f-48b6-a7a3-da8190d80dd8@gmx.net>
Date: Wed, 31 Jul 2024 18:41:59 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 09/16] drm/vc4: v3d: simplify clock retrieval
To: =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>,
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
 <20240728130029.78279-1-wahrenst@gmx.net>
 <581726ae-dd9c-476f-817d-4140f7217ec7@igalia.com>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <581726ae-dd9c-476f-817d-4140f7217ec7@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1XEsTB1Yz6QIrPhgICNBxgzWJsapsjgGiS8Z3LpAw8WaXEwOW8H
 TY9xd1Y3Gt7tRm7ZGLMeLmOzROUaIxpwJt5gUHRfyXmwKOwiWqOrIFF5feu4mDDpvkJ/WFT
 WBzaxf23DzYY/PwV5nRzoVuxFOniucW/r9qeA3IfdEfg38XlseYE+FAgSpvZt0Z92jsC05A
 ppO3hoEETMjbrYrWmgnBA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:0t+rf2WRA2Y=;g0vn5Zpq/535/wKbDqIMoQuhU4y
 Ugr6e6bL6utv6BqL127QxAh0QZZABiONwtJO1ZBk6Bt8ZoHiVzoDnvObxOxayOnHmXiqN2eI2
 An5IBhQkmy4iKB6LqZacKC5yjPZoOFLEpE/O8Rot9lNLj+yBldRNHhyPfrGjtQdsLpZtCShwL
 3iKOsCTcWg3X5wWmOWvNlMl4SRYyEk0GOsyaiJ/beY33Q5e47o+6Z3mT97KVIeF7aR4rCRy9s
 hB0hOd9gtobYLuSeLFN2lf5mnVWnGdyKCF1a8q64GFk6F+/BJh5Nzd2VSeCLkG2AoJiW8dP/W
 58Cy0F72IzBhpLQg/+DaadLHqePdvPx81lTB7Vu7jWIqDbaFGz/2w+aiCiBGOR7+rprYbFoRB
 oVhZCm6gXQoDwEie8AiPDT3DCrtz7/e8hTllEbKHWcdGoT/5Bq7MrOlkAiGi4pH08RvDxGn/y
 dMW/AWFGbVjaw4lVrVqjaevaDKLVN9A+WbV+jMCNsURJ6oAmxRNp9P6NyRA00+d90+M+QcqvJ
 P0fJbhCkoOeHQspJy/3sUEnPX1bEp2GNf4++0q8GMSvIghhJPvm58M9NBpH+uBgw7TPCuq2yP
 vqLFbH+l2NUeWCoQiQp4ZmXhdXzbm/n1ZtiXkbpNheSSkKD1pkR3qQB09dpiZtUNqhrz7drmv
 kU1nNHud2/HNIYLekf+tOsnJP8R/nPAHXbQrySkyMSjFUPITGFcyygwbwDn5iYR8a5IjuTRG/
 fxfNHwkr6o6wa76enkzqyEIy19WXCJ5ubjCW134abbyna8z4hR7Xr5GL5pmB/2Rt/FoNk/wu8
 57E9E2fz8d9Gf7fLVcPGOEFg==

Hi Ma=C3=ADra,

Am 30.07.24 um 13:23 schrieb Ma=C3=ADra Canal:
> On 7/28/24 10:00, Stefan Wahren wrote:
>> Common pattern of handling deferred probe can be simplified with
>> dev_err_probe() and devm_clk_get_optional(). This results in much
>> less code.
>>
>> Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
>> ---
>> =C2=A0 drivers/gpu/drm/vc4/vc4_v3d.c | 13 ++-----------
>> =C2=A0 1 file changed, 2 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/vc4/vc4_v3d.c
>> b/drivers/gpu/drm/vc4/vc4_v3d.c
>> index 1ede508a67d3..4bf3a8d24770 100644
>> --- a/drivers/gpu/drm/vc4/vc4_v3d.c
>> +++ b/drivers/gpu/drm/vc4/vc4_v3d.c
>> @@ -441,20 +441,11 @@ static int vc4_v3d_bind(struct device *dev,
>> struct device *master, void *data)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vc4->v3d =3D v3d;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 v3d->vc4 =3D vc4;
>>
>> -=C2=A0=C2=A0=C2=A0 v3d->clk =3D devm_clk_get(dev, NULL);
>> +=C2=A0=C2=A0=C2=A0 v3d->clk =3D devm_clk_get_optional(dev, NULL);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (IS_ERR(v3d->clk)) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int ret =3D PTR_=
ERR(v3d->clk);
>>
>
> Super nit: you could delete this line ^
Can you please explain? ret is required for dev_err_probe or do you mean
the empty line after the declaration?
>
> Reviewed-by: Ma=C3=ADra Canal <mcanal@igalia.com>
>
> Best Regards,
> - Ma=C3=ADra
>
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret =3D=3D -ENOENT) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* =
bcm2835 didn't have a clock reference in the DT. */
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret=
 =3D 0;
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 v3d=
->clk =3D NULL;
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if =
(ret !=3D -EPROBE_DEFER)
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 dev_err(dev, "Failed to get V3D clock: %d\n",
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret);
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret=
urn ret;
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return dev_err_probe(dev, r=
et, "Failed to get V3D clock\n");
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D platform_get_irq(pdev, 0);
>> --
>> 2.34.1
>>
>


