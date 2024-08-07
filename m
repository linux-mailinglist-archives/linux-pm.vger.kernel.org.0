Return-Path: <linux-pm+bounces-11971-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ECBF94AA2A
	for <lists+linux-pm@lfdr.de>; Wed,  7 Aug 2024 16:32:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1BFC1F2218C
	for <lists+linux-pm@lfdr.de>; Wed,  7 Aug 2024 14:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A22E27BAE7;
	Wed,  7 Aug 2024 14:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="FRKpzVpD"
X-Original-To: linux-pm@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE9A339B1;
	Wed,  7 Aug 2024 14:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723041141; cv=none; b=PV3zUb6rVMUPhemnndXubgNN/+7vem2ndhhFQa9PYwTdDI4zt+9mixkbVS4BfyOH1wHddVpz6mPEC6ugzC6pMLkLL7cEV+Nj+whIihJT2AE8TRNfsuTa9jA/XYKNB4u3Rhl3kJ+RUCKqO+J7fGP+I/kJsq9FJIubJNhJhSQXe0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723041141; c=relaxed/simple;
	bh=L+lOWayVQSFYbuaQv1b5w2sFe6G9v/berVkLyrb9Tf4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FdYI7iUWNfJJ2c/MeUPnDlyBS76rzjoEt1tt5GCiWFR9Vdb85zgiQoSEdxraNL8zzBImWJDcNhv0iUwoa1QLPRRTGiuYTRNr6VfoZgHgTCWGpBw1Fqtaf1biv1NZMLhTpqOdWUaorMdpHYzL1DaFaJZ0Ir9pyVPT6zVRE/BBqh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=FRKpzVpD; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=/yIq5F1sLYz2Im6abuL/kV0BHEUBUSXsQ6EP5OWWl0Q=; b=FRKpzVpDCAq0/ytJHoZSNvBDRe
	7MZcgfxBe3aMcQs27qDcw7haJgYq0XXey29sTC5+bXP53ATVv32SNBesO5hQLWmky66zjot2V8TH3
	hFZoR9HPDenoUJO6ncQqniUSurHjLCBp/cnJ1B6WHLNIdUSo1Ggp8EaKEz6gaZ/eNIMhlqQ7KDmYl
	PUYfkRGYjbdxIFmS7LSeNtpwk20ZNN/5SEIeLuTFw9mjWHgGwlBx+p4M+DHNamrK/C9zUDm8QJLJU
	7ntvWO45U2UVa91+wL9l0WX8vapuf2+5UO6MP6axGBrjgRctV//myX4elkrmIvh39gGnAleYNFF2M
	a1fdql1Q==;
Received: from [187.36.213.55] (helo=[192.168.1.212])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1sbhhT-0091B7-MS; Wed, 07 Aug 2024 16:31:39 +0200
Message-ID: <c67738d6-9c52-45e3-8053-e7c0b415895d@igalia.com>
Date: Wed, 7 Aug 2024 11:31:28 -0300
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 09/16] drm/vc4: v3d: simplify clock retrieval
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
 <20240728130029.78279-1-wahrenst@gmx.net>
 <581726ae-dd9c-476f-817d-4140f7217ec7@igalia.com>
 <b34cc73c-721f-48b6-a7a3-da8190d80dd8@gmx.net>
 <6047643f-e1f5-4be4-b55d-f59576999d91@igalia.com>
 <a19767c3-c457-4e52-bc66-8f1898a83193@gmx.net>
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
In-Reply-To: <a19767c3-c457-4e52-bc66-8f1898a83193@gmx.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Stefan,

On 8/2/24 10:00, Stefan Wahren wrote:
> Hi Maíra,
> 
> Am 02.08.24 um 14:56 schrieb Maíra Canal:
>> Hi Stefan,
>>
>> On 7/31/24 13:41, Stefan Wahren wrote:
>>> Hi Maíra,
>>>
>>> Am 30.07.24 um 13:23 schrieb Maíra Canal:
>>>> On 7/28/24 10:00, Stefan Wahren wrote:
>>>>> Common pattern of handling deferred probe can be simplified with
>>>>> dev_err_probe() and devm_clk_get_optional(). This results in much
>>>>> less code.
>>>>>
>>>>> Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
>>>>> ---
>>>>>   drivers/gpu/drm/vc4/vc4_v3d.c | 13 ++-----------
>>>>>   1 file changed, 2 insertions(+), 11 deletions(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/vc4/vc4_v3d.c
>>>>> b/drivers/gpu/drm/vc4/vc4_v3d.c
>>>>> index 1ede508a67d3..4bf3a8d24770 100644
>>>>> --- a/drivers/gpu/drm/vc4/vc4_v3d.c
>>>>> +++ b/drivers/gpu/drm/vc4/vc4_v3d.c
>>>>> @@ -441,20 +441,11 @@ static int vc4_v3d_bind(struct device *dev,
>>>>> struct device *master, void *data)
>>>>>       vc4->v3d = v3d;
>>>>>       v3d->vc4 = vc4;
>>>>>
>>>>> -    v3d->clk = devm_clk_get(dev, NULL);
>>>>> +    v3d->clk = devm_clk_get_optional(dev, NULL);
>>>>>       if (IS_ERR(v3d->clk)) {
>>>>>           int ret = PTR_ERR(v3d->clk);
>>>>>
>>>>
>>>> Super nit: you could delete this line ^
>>> Can you please explain? ret is required for dev_err_probe or do you mean
>>> the empty line after the declaration?
>>
>> Just deleting the empty line after the declaration. It is a super small
>> nit indeed.
> AFAIK an empty line after a declaration is part of the coding style. Or
> is different in drm?

TBH I just checked the result of `git grep "dev_err_probe"` and I
noticed that most of the times, we don't add an empty line after the
declaration in this case or we don't even create a variable, something
like:

return dev_err_probe(dev, PTR_ERR(v3d->clk), "Failed to get V3D clock\n");

But it is a pretty small nit. Feel free to ignore it.

Also, let me know if you need me to apply any patches to drm-misc-next.

Best Regards,
- Maíra

> 
> Best regards
>>
>> Best Regards,
>> - Maíra
>>
>>>>
>>>> Reviewed-by: Maíra Canal <mcanal@igalia.com>
>>>>
>>>> Best Regards,
>>>> - Maíra
>>>>
>>>>> -        if (ret == -ENOENT) {
>>>>> -            /* bcm2835 didn't have a clock reference in the DT. */
>>>>> -            ret = 0;
>>>>> -            v3d->clk = NULL;
>>>>> -        } else {
>>>>> -            if (ret != -EPROBE_DEFER)
>>>>> -                dev_err(dev, "Failed to get V3D clock: %d\n",
>>>>> -                    ret);
>>>>> -            return ret;
>>>>> -        }
>>>>> +        return dev_err_probe(dev, ret, "Failed to get V3D clock\n");
>>>>>       }
>>>>>
>>>>>       ret = platform_get_irq(pdev, 0);
>>>>> -- 
>>>>> 2.34.1
>>>>>
>>>>
>>>
> 

