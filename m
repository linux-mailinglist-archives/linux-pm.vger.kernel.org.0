Return-Path: <linux-pm+bounces-1198-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F63C8144E8
	for <lists+linux-pm@lfdr.de>; Fri, 15 Dec 2023 10:54:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A81491F24233
	for <lists+linux-pm@lfdr.de>; Fri, 15 Dec 2023 09:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5781218C24;
	Fri, 15 Dec 2023 09:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="MmW9aKb9"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898E718B1C
	for <linux-pm@vger.kernel.org>; Fri, 15 Dec 2023 09:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-40c48d7a7a7so4483305e9.3
        for <linux-pm@vger.kernel.org>; Fri, 15 Dec 2023 01:54:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1702634073; x=1703238873; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZaQhIJpC8RnPN69nCWAUDpbxZF8DURVfb/kY7Z31L0E=;
        b=MmW9aKb9cBhK1fkm06ijDsKssiCZuCzW7Us4FR9IMhFPh3/AHi8Xe49wFfxVm/zMnU
         JSfUmPebplSCmkCkdxcOPSfM0cDJmTRplt4iOVfAVt/Z0LMcDPT3mNlAW/iUHbjQSIiF
         F+KS6CZtS2Ln9KbywUfyVy0sb1NaTtBhAYftMYdrXFrDk44ONmQlQGjYj77OIgAjs0Fd
         empZCO1CoDMhDANu0s3EcsNVThxt4+O8U1HvfPvvnyuGdp6ZgyuFT4rzN/cRjLNWzxOJ
         fal7KVICDQXdeZ7ZSLu0KEIJ0VqeS90uFF3nC3fOSetBJ7e1qS3jaQTYL7C/inkO//Ax
         33IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702634073; x=1703238873;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZaQhIJpC8RnPN69nCWAUDpbxZF8DURVfb/kY7Z31L0E=;
        b=Kf8eV3sdThHqG7HAPIwBXN/A5b0vB1nx6AgaxowAl+Q1/Pmth3FUaM1DYjwt7jh595
         dBDS4oRgWNJLK2rpGYB63OjVc8RPairIqL9YYRgo6HXddxhFYYdPRhiPrV26U9mFKGGG
         luPBPSvXsQwGYEbrxXPyYJutvhy5x7T5+yXKZHM+EjCqyxfWLZH4uv0hy+NgV8tBbPxJ
         lCv3VtTnHv1W7qMn6bh0Kn+naCXOJ+6LxFhDXuHlQSUHRThYAZ8zIAAEqL3eekY8PXvC
         xUguDl3g81KmDzVBtr/PXlLHrDaC6AjBOfCbZ+wmtAM1P/TBWxK53E4x4jXI+fACbb9E
         6rTA==
X-Gm-Message-State: AOJu0YxihLkWoIL2BwLVELcIH2TnpZID4sA5Sw5w3AyOsZbClgeKOvDc
	HJWrHmgU2rRCUwFusp3fhCR5EQ==
X-Google-Smtp-Source: AGHT+IFyuXAp+tPAhav4a3ImTRzZILmdqALz+G2oA3xWOMRjoAp1+b20I3piaoNv4URjDTOgIxk8Lg==
X-Received: by 2002:a05:600c:470c:b0:40c:6bb8:17f2 with SMTP id v12-20020a05600c470c00b0040c6bb817f2mr286370wmo.59.1702634072718;
        Fri, 15 Dec 2023 01:54:32 -0800 (PST)
Received: from localhost ([2a01:e0a:3c5:5fb1:6e16:8a51:92cc:c70e])
        by smtp.gmail.com with ESMTPSA id je5-20020a05600c1f8500b0040c6b667ce3sm1461288wmb.1.2023.12.15.01.54.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 01:54:32 -0800 (PST)
References: <cover.1702400947.git.u.kleine-koenig@pengutronix.de>
 <ki5n3rz5n4oxj2hhc3rj6xpn3e2tdi7fcp2q7exjbzilrlqflp@przautvhuy4g>
 <20231213074300.4bq7wkfqd4jhhcr4@pengutronix.de>
 <2nvbag657mlniqwq7fbilapc6vfw5qumab3yd6bqul25ot6wcn@wdlkh5az2fgs>
 <212239ae-60ab-46f3-a838-39a4d61091fe@linaro.org>
User-agent: mu4e 1.10.8; emacs 29.1
From: Jerome Brunet <jbrunet@baylibre.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Maxime Ripard <mripard@kernel.org>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?=
 <u.kleine-koenig@pengutronix.de>, Michael Turquette
 <mturquette@baylibre.com>, dri-devel@lists.freedesktop.org, Krzysztof
 Kozlowski <krzysztof.kozlowski@linaro.org>, Thierry Reding
 <thierry.reding@gmail.com>, David Airlie <airlied@gmail.com>,
 linux-clk@vger.kernel.org, Jerome Brunet <jbrunet@baylibre.com>, Rob
 Herring <robh@kernel.org>, Samuel Holland <samuel@sholland.org>, Kevin
 Hilman <khilman@baylibre.com>, Russell King <linux@armlinux.org.uk>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, Jonathan Hunter
 <jonathanh@nvidia.com>, Chanwoo Choi <cw00.choi@samsung.com>, Chen-Yu Tsai
 <wens@csie.org>, MyungJoo Ham <myungjoo.ham@samsung.com>, Johan Hovold
 <johan+linaro@kernel.org>, linux-sunxi@lists.linux.dev, Thomas Zimmermann
 <tzimmermann@suse.de>, linux-pm@vger.kernel.org, Martin Blumenstingl
 <martin.blumenstingl@googlemail.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, linux-tegra@vger.kernel.org,
 linux-amlogic@lists.infradead.org, kernel@pengutronix.de,
 linux-arm-kernel@lists.infradead.org, Stephen Boyd <sboyd@kernel.org>,
 Kyungmin Park <kyungmin.park@samsung.com>, Daniel Vetter
 <daniel@ffwll.ch>, Georgi Djakov <djakov@kernel.org>
Subject: Re: [PATCH 0/5] clk: Make clk_rate_exclusive_get() return void
Date: Fri, 15 Dec 2023 10:46:29 +0100
In-reply-to: <212239ae-60ab-46f3-a838-39a4d61091fe@linaro.org>
Message-ID: <1ja5qbpz8o.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


On Wed 13 Dec 2023 at 17:44, Neil Armstrong <neil.armstrong@linaro.org> wro=
te:

> Hi Maxime,
>
> Le 13/12/2023 =C3=A0 09:36, Maxime Ripard a =C3=A9crit=C2=A0:
>> Hi,
>> On Wed, Dec 13, 2023 at 08:43:00AM +0100, Uwe Kleine-K=C3=B6nig wrote:
>>> On Wed, Dec 13, 2023 at 08:16:04AM +0100, Maxime Ripard wrote:
>>>> On Tue, Dec 12, 2023 at 06:26:37PM +0100, Uwe Kleine-K=C3=B6nig wrote:
>>>>> clk_rate_exclusive_get() returns zero unconditionally. Most users "kn=
ow"
>>>>> that and don't check the return value. This series fixes the four use=
rs
>>>>> that do error checking on the returned value and then makes function
>>>>> return void.
>>>>>
>>>>> Given that the changes to the drivers are simple and so merge conflic=
ts
>>>>> (if any) should be easy to handle, I suggest to merge this complete
>>>>> series via the clk tree.
>>>>
>>>> I don't think it's the right way to go about it.
>>>>
>>>> clk_rate_exclusive_get() should be expected to fail. For example if
>>>> there's another user getting an exclusive rate on the same clock.
>>>>
>>>> If we're not checking for it right now, then it should probably be
>>>> fixed, but the callers checking for the error are right to do so if th=
ey
>>>> rely on an exclusive rate. It's the ones that don't that should be
>>>> modified.
>>>
>>> If some other consumer has already "locked" a clock that I call
>>> clk_rate_exclusive_get() for, this isn't an error. In my bubble I call
>>> this function because I don't want the rate to change e.g. because I
>>> setup some registers in the consuming device to provide a fixed UART
>>> baud rate or i2c bus frequency (and that works as expected).
>> I guess it's a larger conversation, but I don't see how that can
>> possibly work.
>> The way the API is designed, you have no guarantee (outside of
>> clk_rate_exclusive_*) that the rate is going to change.
>> And clk_rate_exclusive_get() doesn't allow the rate to change while in
>> the "critical section".
>> So the only possible thing to do is clk_set_rate() +
>> clk_rate_exclusive_get().
>
> There's clk_set_rate_exclusive() for this purpose.
>
>> So there's a window where the clock can indeed be changed, and the
>> consumer that is about to lock its rate wouldn't be aware of it.
>> I guess it would work if you don't care about the rate at all, you just
>> want to make sure it doesn't change.
>> Out of the 7 users of that function, 3 are in that situation, so I guess
>> it's fair.
>> 3 are open to that race condition I mentioned above.
>> 1 is calling clk_set_rate while in the critical section, which works if
>> there's a single user but not if there's multiple, so it should be
>> discouraged.
>>=20
>>> In this case I won't be able to change the rate of the clock, but that
>>> is signalled by clk_set_rate() failing (iff and when I need awother
>>> rate) which also seems the right place to fail to me.
>> Which is ignored by like half the callers, including the one odd case I
>> mentioned above.
>> And that's super confusing still: you can *always* get exclusivity, but
>> not always do whatever you want with the rate when you have it? How are
>> drivers supposed to recover from that? You can handle failing to get
>> exclusivity, but certainly not working around variable guarantees.
>>=20
>>> It's like that since clk_rate_exclusive_get() was introduced in 2017
>>> (commit 55e9b8b7b806ec3f9a8817e13596682a5981c19c).
>> Right, but "it's always been that way" surely can't be an argument,
>> otherwise you wouldn't have done that series in the first place.
>>=20
>>> BTW, I just noticed that my assertion "Most users \"know\" that
>>> [clk_rate_exclusive_get() returns zero unconditionally]" is wrong. As of
>>> next-20231213 there are 3 callers ignoring the return value of
>>> clk_rate_exclusive_get() and 4 that handle (imaginary) returned errors.
>>> I expected this function to be used more extensively. (In fact I think
>>> it should be used more as several drivers rely on the clk rate not
>>> changing.)
>> Yes, but also it's super difficult to use in practice, and most devices
>> don't care.
>> The current situation is something like this:
>>    * Only a handful of devices really care about their clock rate, and
>>      often only for one of their clock if they have several. You would
>>      probably get all the devices that create an analog signal somehow
>>      there, so audio, display, i2c, spi, uarts, etc. Plus the ones doing
>>      frequency scaling so CPU and GPUs.
>>    * CPUs and GPUs are very likely to have a dedicated clock, so we can
>>      rule the "another user is going to mess with my clock" case.
>>    * UARTs/i2c/etc. are usually taking their clock from the bus interface
>>      directly which is pretty much never going to change (for good
>>      reason). And the rate of the bus is not really likely to change.
>>    * SPI/NAND/MMC usually have their dedicated clock too, and the bus
>>      rate is not likely to change after the initial setup either.
>> So, the only affected devices are the ones generating external signals,
>> with the rate changing during the life of the system. Even for audio or
>> video devices, that's fairly unlikely to happen. And you need to have
>> multiple devices sharing the same clock tree for that issue to occur,
>> which is further reducing the chances it happens.
>
> Well, thanks for HW designers, this exists and some SoCs has less PLLs th=
an
> needed, and they can't be dedicated for some hw blocks.

Indeed. Even if there are enough PLLs, the exclusive API might help.
The idea is to force the second consumer to pick another "free" PLL if
it needs another rate.

If it can work with the rate currently locked by the first consumer,
then CCF may just pick that one, saving a PLL for future use. If it cant,
the protection will force the use of another PLL.

Without the exclusive API, the second consummer may just wreck the PLL of
the first consummer, regardless of the other PLL available.

Of course, if there is enough PLL, the other solution is manual
allocation, using assigned-parent and CLK_NO_REPARENT.

>
>> Realistically speaking, this only occurs with multi-head display outputs
>> where it's somewhat likely to have all the display controllers feeding
>> from the same clock, and the power up of the various output is done in
>> sequence which creates that situation.
>> And even then, the clk_rate_exclusive_* interface effectively locks the
>> entire clock subtree to its current rate, so the effect on the rest of
>> the devices can be significant.
>> So... yeah. Even though you're right, it's trying to address a problem
>> that is super unlikely to happen with a pretty big hammer that might be
>> too much for most. So it's not really surprising it's not used more.
>
> Honestly I tried my best to find a smart way to set the DSI clock tree
> with only 2 endpoints of the tree, but CCF will explore all possibilities
> and since you cannot set constraints, locking a sub-tree is the smartest
> way I found.
> In this case, the PLL is common between the DSI controller and video gene=
rator,
> so to keep the expected clock ratio, the smart way is to set the freq on
> one side, lock the subtree and set the rate on the other side.
> An API permitting to set multiple rates to multiple clocks in a single ca=
ll
> would be the solution, but not sure if we could possibly write such algor=
ithm.
>
>> Maxime
>
> Neil


--=20
Jerome

