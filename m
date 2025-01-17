Return-Path: <linux-pm+bounces-20597-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAB15A14A12
	for <lists+linux-pm@lfdr.de>; Fri, 17 Jan 2025 08:25:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 069493AA8A9
	for <lists+linux-pm@lfdr.de>; Fri, 17 Jan 2025 07:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 477BC1F78F9;
	Fri, 17 Jan 2025 07:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RAokXgxQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A13D1F78F3;
	Fri, 17 Jan 2025 07:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737098721; cv=none; b=miS7oR6CbxOuvZM81h9Oe08oG4e1eVBycQj4ysHsYWrY4Sj/yowISlQJKcS1tIWEwuw8hSJaaUbAlIZh4ErMLXKBdy/S0YfW8kyeUcrmsYbVSCpaiDUhZBTxlA58BQiZBCdXWK7fRI9RTLUyAa3Y/kKwD60d3cVYZzQOn/J3z5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737098721; c=relaxed/simple;
	bh=cGTuzvyXhhbVdzsVpQHI3NbFsG2cU0VrK5fyS3VgK5Q=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=gTGNMJKDBRvG9x/3HZMPw+dmRNiUc4D575XqctZaBrWB1qDc4vRuOiUYfhtr36sg9kLEBk2ico1ketdKKzm8MT4I9ilXxTIDTyBy7AAh0KLvXM+27fCdiOQU6QS5hhKmwoN091C2O/FqBAfQ5Q7dllDL7/PmoihbRqIoAC4KVCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RAokXgxQ; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-aaedd529ba1so245997866b.1;
        Thu, 16 Jan 2025 23:25:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737098717; x=1737703517; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=acBUeSMeLcUwdvAPh7XnIMxupIQjS7s3gcf5z1wzyRw=;
        b=RAokXgxQWI8H4i8pqD939KXCLwyZgQ21n/rEWGvfexCOLdOLwUeX26gvnBLFnOavKV
         dQaAg8AO9Br9t2WkyZxJzi27JUL4QtYJz4qt56ykcUqxMOEokNBHZS2o/LcMOzRzlubP
         Q6AOLjSOj4A9a2eixrKSjeVAioHtVYBKnMpbMdxa7NhGBRRvTXXmsPl+hV+zk8mGJu8+
         5sNkRsjnsudQAJLpgdWI+ph9t6ag/IjJlyS4NYBwXBXhnZj/rQU6/EvasnU4ozJ4H8W+
         dHhY3MuT6xR2nnJPg4fA5wQ8yqK2X3Q0vxy+www1v2+mWHN0Aa7CWOCxn/DoW9zYfM/j
         Itsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737098717; x=1737703517;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=acBUeSMeLcUwdvAPh7XnIMxupIQjS7s3gcf5z1wzyRw=;
        b=q+Li1ukWc3HEOTYY11r/jgydcXwVcuxbTTFMmcW8/mRUJBV7d5hTtChu7ZzGKRwQNy
         UPa0Lf54XnUtrI3bdXM/soBkLnYZxvn4sFC1NP0a22jxt13B0y/t7+tGWtW+IKDqJ8lp
         rViLLJ7dvzTShC4s4zxfIJZAzihu91NAP+9SxfiknIIlpLvoN8vs8WkD/WNSTjV9TleT
         sOjc5bjO0vbilqlnp+9ABiTtaMCbxw5bZnDVBuvtWNDBKr49GS/C46vks4s8oeVegzDi
         pmtwsdIj7e9AKEk3hVOhz2Z1TcmJ0q0R8k/WXSrNAYj8OdycxEjw2GXEWJ0ZwBHL6g3Z
         Sn4w==
X-Forwarded-Encrypted: i=1; AJvYcCVKZetnTmanXhYR6p9+oSlWS2iyINsSMcPDdXxcdOorWHkHdWIgguc7pulmdxrbNP6EQt232sX7th3JhQ==@vger.kernel.org, AJvYcCVf1HBKeFE0Tn5Dc8Pw14SAwXBtiWWzQOXCwQNWB3G6iz5bMapCt+RuOF98mBeWry25dIhl83pdWy+F@vger.kernel.org, AJvYcCWYApwnWfriZQ3ivrzzjRnQq9U9g58/rMMD2gjHTAI5jClt1QkfzqLAN0nSycEdE2rZPVSrxg9kRb3ou48A@vger.kernel.org, AJvYcCXniZY09U1Zkix8ownnz8o1OwcplhxJulAUQgQP0Z7a0vAu+2CUQ029P4RIyG3gK0bJRAvxOm6yzLY=@vger.kernel.org, AJvYcCXoSQPtWcRyLFzhRqQFbcHjsVIAYqsScGSWfHkRHdDCM7SZFeJdhVLAobGYFPoADvAFCxWsgrcOYF+7@vger.kernel.org
X-Gm-Message-State: AOJu0YzvaULFaq+JjgFt+04XxUPQ1NBRywOfDf8zYWl3xYbi8bccZRLJ
	+O47hwd7cXJ/AXZXwTofhVPh1V4Tw0BZ0Mpzujf1xfLMu+FFzjsE
X-Gm-Gg: ASbGncuOdz5P5kpBGXmJHfxG3XrPm0fBOhDe3cjesDmXEY52W6kLwRH1l829S9USSRw
	JMCFs+VICDXkjIGBhclvjOHS1YH6haDF8bEaqpJ7LWW0DDWiaSth5ATggWQu+oFMN1vufuX0mMC
	ljY2FEUjdfouMGBo4bpszrZIpjG1gejBsHBbh+saCmy4uXK4EUYSb7aVDgQvLDfiPGsQV4juJ29
	K71hxkZtLvN/Tp4sEK2xNSLR+cROM5bQNPCmj+N8s5+tzXbo1E+7K5R1aWyafZsvo00ctuggd7n
	dxkwDFVw4DRtX6jDclc=
X-Google-Smtp-Source: AGHT+IGePGJHVWxw4XwLV4zxZAGfulFMMCFa6UxYk4nNAptBEBklprrxVwXwqCG4Gi/JEQo6iRnv6g==
X-Received: by 2002:a05:6402:2745:b0:5d0:bf5e:eb8 with SMTP id 4fb4d7f45d1cf-5db7db07846mr3557485a12.23.1737098717190;
        Thu, 16 Jan 2025 23:25:17 -0800 (PST)
Received: from smtpclient.apple (185.174.17.62.zt.hu. [185.174.17.62])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab384ce1a49sm124381366b.46.2025.01.16.23.25.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Jan 2025 23:25:16 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51\))
Subject: Re: [PATCH 03/12] pinctrl: sunxi: add driver for Allwinner V853.
From: =?utf-8?B?QW5kcsOhcyBTemVtesWR?= <szemzo.andras@gmail.com>
In-Reply-To: <CACRpkdYVTedEon0X-izvaDTGF6yRhD2s=Z6NEM=zBf4vD-T0Pg@mail.gmail.com>
Date: Fri, 17 Jan 2025 08:25:04 +0100
Cc: Andre Przywara <andre.przywara@arm.com>,
 Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Chen-Yu Tsai <wens@csie.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Maxime Ripard <mripard@kernel.org>,
 Vinod Koul <vkoul@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 Ulf Hansson <ulf.hansson@linaro.org>,
 Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>,
 =?utf-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org,
 linux-phy@lists.infradead.org,
 linux-gpio@vger.kernel.org,
 linux-pm@vger.kernel.org,
 linux-riscv@lists.infradead.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <686A634E-147F-4D73-A909-29FC0C20472C@gmail.com>
References: <20250110123923.270626-1-szemzo.andras@gmail.com>
 <20250110123923.270626-4-szemzo.andras@gmail.com>
 <20250114141954.2785879a@donnerap.manchester.arm.com>
 <CACRpkda0nx3SQtdjmXdCEbVJSWM10TM=p-6JbDjbiYcOSF5PxQ@mail.gmail.com>
 <20250115152635.1b89e7f4@donnerap.manchester.arm.com>
 <CACRpkdYVTedEon0X-izvaDTGF6yRhD2s=Z6NEM=zBf4vD-T0Pg@mail.gmail.com>
To: Linus Walleij <linus.walleij@linaro.org>
X-Mailer: Apple Mail (2.3776.700.51)

I=E2=80=99ve actually already converted the pinctrl driver to the new dt =
based pinmux, as Andre
suggested. It=E2=80=99s simple, get rid of those huge pinmux tables, and =
easy to understand to
add the mux settings to the dtsi.


> On 16 Jan 2025, at 10:34, Linus Walleij <linus.walleij@linaro.org> =
wrote:
>=20
> Hi Andre,
>=20
> some nice talk here, actually the following is just opinions, I will
> be likely happy with whatever approach is taken eventually.
>=20
> On Wed, Jan 15, 2025 at 4:26=E2=80=AFPM Andre Przywara =
<andre.przywara@arm.com> wrote:
>=20
>>> pio: pinctrl@1c20800 {
>>>                        compatible =3D "allwinner,sun8i-r40-pinctrl";
>>> (...)
>>>                        i2c0_pins: i2c0-pins {
>>>                                pins =3D "PB0", "PB1";
>>>                                function =3D "i2c0";
>>>                        };
>>>=20
>>> abstract, strings, nice. The driver handles the particulars.
>>=20
>> What bugs me about this it that this has quite some seemingly =
redundant
>> information (Who would have thought that the i2c0 pins use function
>> "i2c0"?), but misses out on the actual 4 bits(!) of information.
>=20
> the pins in this example are called PB0 and PB1 though. The =
designation
> on the package. And often pins actually named "i2c0_1" "i2c0_2" are
> for that primary function, but muxable to a few other functions,
> at least GPIO in most cases. So it's just some name for the pin
> really.
>=20
>>> That is like so because we are designing for users which are
>>> let's say customization engineers. If these engineers jump from
>>> project to project matching function strings to group strings will
>>> be a common way to set up pins, and easy to understand and
>>> grasp, and it makes the DTS very readable.
>>=20
>> That's an interesting view, and I see the point of it being easy to =
read,
>> but this is partly because it doesn't convey too much actual =
information,
>> does it, as it requires another lookup or two.
>> And the pinctrl group nodes are actually in the .dtsi file, which are
>> typically written once during the initial SoC enablement, and new =
board
>> .dts files normally just reference the existing pingroup nodes. So =
anyone
>> dealing with just a new board is not bothered by this.
>=20
> You have a point, and when working with a system the application
> engineer often finds bugs in the pin control driver, and has to go
> and fix the actual driver and then all the information hiding and
> simplification is moot.
>=20
> This can become an expensive lesson for the current attempts
> to push pin control into firmware where the configuration is
> mostly "dead simple" (and just using strings) - the bugs will be
> in the firmware instead, and impossible or really hard to fix.
>=20
>> Also in my experience most people have no problems in understanding =
the
>> concept of pinmuxing and that there is a selector number, also where =
to
>> find this.
>=20
> Yeah the ambition with the strings was to avoid forcing application
> engineers to know all about that. If they do, they are then
> developing the driver, not just using it.
>=20
>>> Mediatek and STM32 made a compromise by using pinmux
>>> and adding some macros to define them so it looks more
>>> pleasant:
>>>=20
>>>      i2c0_pins_a: i2c0-default {
>>>                pins-i2c0 {
>>>                        pinmux =3D <MT7623_PIN_75_SDA0_FUNC_SDA0>,
>>>                                 <MT7623_PIN_76_SCL0_FUNC_SCL0>;
>>=20
>> Well, I don't really get why they don't use the (MTK_PIN_NO(75) | 1)
>> definition directly, seems to be more telling to me?
>=20
> That's what STM32 does as well and it's usable.
>=20
> But of course it drives a truck through the initial ambition that pins
> on all systems be configured the same way, with strings. So now
> there are some families of drivers all "necessarily different" which
> is not so nice for people jumping between different SoCs, but
> very compelling for people focusing on just one SoC.
>=20
> Well, unless this way of doing things becomes so prevalent that
> it's the new black.
>=20
>> So the plan for sunxi would be: <SUNXI_PINMUX(PORTC, 23, MUX_1)>, ...
>> And this would not be really "opaque", since it has a fixed known =
mapping:
>>        (port << 16) | (pin << 8) | (mux << 0))
>> I find this both technically elegant, because it combines all the
>> information into just one compact cell, but also readable by =
outsiders,
>> thanks to the macro.
>=20
> And a new standard, to add to the other standards, so that
> is my problem as maintainer. It makes sense on its own, and it
> complicates the bigger picture.
>=20
>> My main arguments against the current (string-based) approach:
>> - They require the mapping table to be in every DT user, so not only =
the
>>  Linux kernel, but also U-Boot, FreeBSD, you name it...
>=20
> That's true.
>=20
> This comes from the DT ambition to describe hardware and config,
> but not *define* hardware, i.e. to stop device tree to turn into
> Verilog or SystemC, which is what will happen if we take the
> 1:1 reflection of hardware to device tree too far.
>=20
> I don't think anyone really knows where to cut the line.
>=20
>> - The tables are getting quite large, and they pollute the single =
image
>>  Linux kernel, with tons of very specific information for a number of =
very
>>  pitiful Allwinner SoCs. At the moment the tally is at 145KB of =
code+data
>>  for the existing arm64 SoCs, with the newer SoCs ever growing (H616 =
alone
>>  is 27KB, A523 would be quite larger even, I guess 40K). The new A523
>>  specific pinctrl support adds 872 Bytes.
>=20
> This is a generic problem though, look at GPU drivers.
>=20
> The community (especially Android) seem set on fixing this by using
> modules.
>=20
>> - Most of the mappings are untested at pinctrl driver commit time, =
since we
>>  don't have the device drivers ready yet - by a margin. The new =
approach
>>  would add the pinmux values when we need them and can test them.
>=20
> I like this argument the best.
>=20
> However this also reads "upfront firmware to handle pin control is a
> dead end" yet there are people dedicatedly working on exactly that.
> (Not that its' the Allwinner developers' problem...)
>=20
>> - The comments in the table give away that something is not quite =
right:
>>                  SUNXI_FUNCTION(0x2, "i2c0")),         /* SDA */
>>  This is just a comment, so has no relevance for the code, but it's =
not
>>  meant for humans either. Yet we try to make this correct and =
maintain
>>  it. Odd.
>=20
> So i2c0 is SDA and i2c1 is SCL or something?
> It seems common, but yeah it can be confusing.
>=20
> Yours,
> Linus Walleij


