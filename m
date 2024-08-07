Return-Path: <linux-pm+bounces-11972-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F5FF94AA9D
	for <lists+linux-pm@lfdr.de>; Wed,  7 Aug 2024 16:50:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8CEE281A6E
	for <lists+linux-pm@lfdr.de>; Wed,  7 Aug 2024 14:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2C4B7B3F3;
	Wed,  7 Aug 2024 14:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="BOnDnU0Z"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F7C72B9A1;
	Wed,  7 Aug 2024 14:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723042231; cv=none; b=UstchGq7VJbD1P5lTcBUjPgpLzP5FOT61uur+h5rV5cunuSnUTUkOWFLaUwxTHO4iFyg5pOoPEpwmmd5vCh6CvisWKMekzAefACHQS/I1VC3vyRzSjNO0sWotXwk02DOSU5RHDfzk59IMxjmbfuoGcw9Ba+Eo0R/zF78ENRuDEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723042231; c=relaxed/simple;
	bh=rMx76zKxMOPzp24PguqX0jeCjn4OlHKA2gs/welMniI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NsifsRgunScFtOh+f2uadNYPgSKMB82LiiQqB8C4VBwcPwGdPNWfBM3Gg3tYb1n0S1PnvWStOUjcUo7yY7vWxN5jb2uUbRYHYX4+pq+cv5tcdYYxrqCtvnS1A3FzboC8yZhd2eGqKWNrrunGt6Ug7nvrRH0aMAu3K8u3hkJichQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=BOnDnU0Z; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1723042193; x=1723646993; i=wahrenst@gmx.net;
	bh=rMx76zKxMOPzp24PguqX0jeCjn4OlHKA2gs/welMniI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=BOnDnU0ZzrskIWsS+4bDgrPJzSR9TjYckwhb8JorHJJH3eMu6f7FYQW3HzdAhexb
	 Z868n7nH+Gma3EfPTnbN2IKQO+dc/niQ2FjEu+Db0gg4kP8uG5481A64Tv/oDPXeX
	 CbPsWS0W7iFjyiiUi4BoP8ew/X0wnR7KOMwsAeT16B8FVWebP6Q5u2pW9sQxkQ88b
	 lO9RQH5OSc8vmIZumJAeXlt2JPHEZFEg5CCuhK0+VFvbecXqCHLghOaOE29EoTA8G
	 1cBDHpcL9PS9kxJOmyPOpcCdyVESZ6kyupLkXOzkQOOwb9i/SsdY0Z7AK5TCrqmmT
	 uvbRTnc9Qz5q+M57NQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.127] ([37.4.248.43]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MysRu-1sF6tH1vWs-011VX2; Wed, 07
 Aug 2024 16:49:53 +0200
Message-ID: <993211b6-0f82-4a2a-8945-1f639420cc9a@gmx.net>
Date: Wed, 7 Aug 2024 16:49:50 +0200
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
 <b34cc73c-721f-48b6-a7a3-da8190d80dd8@gmx.net>
 <6047643f-e1f5-4be4-b55d-f59576999d91@igalia.com>
 <a19767c3-c457-4e52-bc66-8f1898a83193@gmx.net>
 <c67738d6-9c52-45e3-8053-e7c0b415895d@igalia.com>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <c67738d6-9c52-45e3-8053-e7c0b415895d@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:CYwNydeHeq0V98558uKEvLQMPHhjIzHWuz6zqvcltEd6g/VSUVW
 8/R4X4gsmOTbbbzv+zttJPfgHbnpg8qBe8n1GJf68eRz2xnxXKbQBI5KHBh1bnpIC3dLG/g
 k0N+eNKXlgrID4LLCQN5Ht2QOVmuI209zSH/53kfJ5ZJXmOk+BxsHpyU0SUyESom9r0MY2U
 L0sF0kFbfu8bnuE7JcLNg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:4f6cE+rhEzo=;yhm4aalApDxwJIoZSxtjXzJvchX
 cIZa4djERQ88OmNdQdgqnLeqHoz+a6LrVLal2VqRiczFl9+7S8epl3MnZWbvmVZV9H5fUp4NC
 n9su8D1xZv5R+XnrmpPQESXsoGYz6IEjwhBgR6g0kaeSVCPT/rrEhBur1uVj2w0RKCyZiBJqH
 1B3uDTbhpVyWPTtK+uO9IuOStfSaNCtvcurt2XmxAENp/MjUKkfknTWLT2PjepRaf2nYEjfxG
 bzFReuep76RU7XyNv2D8Ciz+1jiI2ONX8WlTQUzfctiY3rhTM/dTZ++RpjCeoemso8inYG4A6
 xNnx5jjt6ERhA6/roqSbHOWxSQ5YjvbsaF8XWvZsXTNGhKvqnhST+7qCuHHkBPw4rLDSHyiN8
 ka/+ugVH9z21EUH2ZXVZngqKg9sUrBuzrNBFjLTTWSagvOZg3SPlZmydeaFFeh5JPuAC3Fw0o
 s6mhMvPsg6rwmB4SkpnxHzYIow5BAertaxdtktuVSOdWkb1km+zkr5h/+pTyaPKZnenBtzjVp
 KjOAB3ubN0CcqumjUu2fBbWyseMADl/l1V0ODlUvX5I9/Mnd5uQl8fv7da+UhIWsTAPA/YC42
 yctqVuSP7cBmqXmhiuZAhLqdOMWXiYgSAaUpyWl2RUVkpUGg47m6r764QjE8jXU0mdTzG/Cg8
 i6UNnglvKRfSycpVaEDArZh1vhMg0aqADxTdrLMO7bxQIpA49BC1iFx9VeXGaliSugg8OzXvi
 8lLlmyRAmuG+0FaqQPHDar4z/5mIWikMOJky38vWPsVkzJm3xuFB2cTbYoh9CuNyHR/CVNZO3
 mFCTswuR5GQt64u0Lsk89/KA==

Hi Ma=C3=ADra,

Am 07.08.24 um 16:31 schrieb Ma=C3=ADra Canal:
> Hi Stefan,
>
> On 8/2/24 10:00, Stefan Wahren wrote:
>> Hi Ma=C3=ADra,
>>
>> Am 02.08.24 um 14:56 schrieb Ma=C3=ADra Canal:
>>> Hi Stefan,
>>>
>>> On 7/31/24 13:41, Stefan Wahren wrote:
>>>> Hi Ma=C3=ADra,
>>>>
>>>> Am 30.07.24 um 13:23 schrieb Ma=C3=ADra Canal:
>>>>> On 7/28/24 10:00, Stefan Wahren wrote:
>>>>>> Common pattern of handling deferred probe can be simplified with
>>>>>> dev_err_probe() and devm_clk_get_optional(). This results in much
>>>>>> less code.
>>>>>>
>>>>>> Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
>>>>>> ---
>>>>>> =C2=A0 drivers/gpu/drm/vc4/vc4_v3d.c | 13 ++-----------
>>>>>> =C2=A0 1 file changed, 2 insertions(+), 11 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/gpu/drm/vc4/vc4_v3d.c
>>>>>> b/drivers/gpu/drm/vc4/vc4_v3d.c
>>>>>> index 1ede508a67d3..4bf3a8d24770 100644
>>>>>> --- a/drivers/gpu/drm/vc4/vc4_v3d.c
>>>>>> +++ b/drivers/gpu/drm/vc4/vc4_v3d.c
>>>>>> @@ -441,20 +441,11 @@ static int vc4_v3d_bind(struct device *dev,
>>>>>> struct device *master, void *data)
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vc4->v3d =3D v3d;
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 v3d->vc4 =3D vc4;
>>>>>>
>>>>>> -=C2=A0=C2=A0=C2=A0 v3d->clk =3D devm_clk_get(dev, NULL);
>>>>>> +=C2=A0=C2=A0=C2=A0 v3d->clk =3D devm_clk_get_optional(dev, NULL);
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (IS_ERR(v3d->clk)) {
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int ret =3D =
PTR_ERR(v3d->clk);
>>>>>>
>>>>>
>>>>> Super nit: you could delete this line ^
>>>> Can you please explain? ret is required for dev_err_probe or do you
>>>> mean
>>>> the empty line after the declaration?
>>>
>>> Just deleting the empty line after the declaration. It is a super smal=
l
>>> nit indeed.
>> AFAIK an empty line after a declaration is part of the coding style. Or
>> is different in drm?
>
> TBH I just checked the result of `git grep "dev_err_probe"` and I
> noticed that most of the times, we don't add an empty line after the
> declaration in this case or we don't even create a variable, something
> like:
>
> return dev_err_probe(dev, PTR_ERR(v3d->clk), "Failed to get V3D clock\n"=
);
i will go for the latter variant.

I will send a new version which also addresses your comments regarding
patch 7, so they can be applied at once.

But i still need to wait for some feedback for patch 14 before sending
v3, which is the most important part of the series. But I also hope that
some of the firmware/mailbox/pmdomain patches at the beginning are also
applied before.

>
> But it is a pretty small nit. Feel free to ignore it.
>
> Also, let me know if you need me to apply any patches to drm-misc-next.

Yes, this would be nice to apply the vc4/v3d stuff in the next version,
so the series becomes shorter and easier to handle.

Best regards

