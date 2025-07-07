Return-Path: <linux-pm+bounces-30246-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3395DAFACD9
	for <lists+linux-pm@lfdr.de>; Mon,  7 Jul 2025 09:16:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB91E3A3972
	for <lists+linux-pm@lfdr.de>; Mon,  7 Jul 2025 07:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1505E273D89;
	Mon,  7 Jul 2025 07:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DdUQf8Lv"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA03117CA17
	for <linux-pm@vger.kernel.org>; Mon,  7 Jul 2025 07:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751872590; cv=none; b=tZwg75pbzO+OG+h++M2QBkxc2pElsYsdusrSjUxB4jVKMy81/gCPdAD9PL1kbr69MnWhgYMpYpBEiJdJ46uuaSYcHelo6cLgVb4QyiyUAwsrpmufkVBXA+tkGddpjz6p8xdL/TOJyGnR9iIGZLAFTPLfOYNo6aX10cDOqQQHs0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751872590; c=relaxed/simple;
	bh=nXbsMvaba6aiUnJCHdwSQVfHA//I8drvmjZ0+Kh6WXE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DFnVNZ4rzpcCuWdBWx7pEtQrQiPPPfFK8bxvUwTA6sHwudyV1oOawCHVNteZysdty28eMsKIktXxDw6iTcwKVvy+FckzKcuYNNUAcBxkY2l/5T+/ofoKkFveY1px4e7oQclgEpdogtM3NHVt9XPbea7nqpo0eZJuqWnr/S0kaeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DdUQf8Lv; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-73a43d327d6so1646681a34.2
        for <linux-pm@vger.kernel.org>; Mon, 07 Jul 2025 00:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1751872587; x=1752477387; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qUP0DUWzm8NrO7MzcRs7sXfo7Dkll6lZPIJdSpwpNxY=;
        b=DdUQf8Lvtu5no9eim0Pjr/rG+9Zf02pW8U3+zLX0Bo6HLrt7zk/tI8O3LNSEZ4Wt+T
         /Qsu78UDDJ/vBwUBtL1G+YwbVfaR56EHMj+mMTUUU+Dsy42gQhTdFBxRRXVUpQ6piHit
         +c/8myr61dKYzlQG/yzkMNYANmVvkXMuIGWkfPFSHhj35gSF+2iPdEg0Jhs0Ld4HR0aK
         sJdMz5yorwWTy2Ck4F87r78DmzpkRg5HMqWokugVzLW0jW+FrpngZzcptdy6p/LnG7h4
         +skeAQRd3NGh1XpODeVI4kIwME5VzhAUO5gOly4OW+c132ftUEQZM6zglMIHbz/NoFel
         Z5Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751872587; x=1752477387;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qUP0DUWzm8NrO7MzcRs7sXfo7Dkll6lZPIJdSpwpNxY=;
        b=JevuiVnMtpStV423agrnd/4wxENKKp2RhQbYOpEYoc7uzslxFyaZ6SRnG873TjK8t5
         MeNmrjxDMP//lKAl9OEGk2gXqYWJXoWqSsjzbDgfj+V2MRTIo9YZFVXR+UIp0ELGbtcK
         BUAY5qXQumGHNJIfp9j0GiUPObypEsPD63N1CtPL9r9NyIaqOaX+33tqmAysHLfi2POL
         +k/w91cdsA4hRRKKwdlQ+vcgB0gg/Vg9pgL9IMyr/0AkkkVmfDa7MhNiOmFwYV7+4m6w
         Uf7DmMljEZKg+CRhS3/MumGaEhwO3ET+hl5uAJLX/KJwMOgkJK9Wh/AFsJfeCFEpgNN+
         nccA==
X-Forwarded-Encrypted: i=1; AJvYcCUyI06DbB3SlhOSRZj4LNqgZD2se0WTWNmfVX9fS6+YPJNBAMHfmkftc35vKrJEWoBC43E0fxUyIA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzysMDc4a9iVlgGZxGr3i2VQ5c+A3I9MfDW6hkI/1m5HB/TQqg8
	NKeieHyu1ugXW18fYlmmFwwMuFCk3KWsLk6JwRi3CRdOafd/PCA3Ur6W3rApv+LxfSNXvV537cd
	80BtnIyFvOE4LWAcJhYGKZpCJ5Cj39o2WHu/nR/tiXw==
X-Gm-Gg: ASbGnctFsqOp8SfiNNrM0BSpfYewfLLhcX/Lvm9gtbwTzfuERR3hmLfk4PRxfAMTyUs
	m+RNPOLtaUmCQzoirU4VyMZltVPFFOIBAvHu0WsGJliMzKD6EGChuPx+JLIfcAE9hW2QuNhoec8
	Y8AQtfUsqM4Uq7HGcylyREY4mtz6wWMNPEXuLe++PkbLCg
X-Google-Smtp-Source: AGHT+IFMyBczzKElrESwPhgOU1rzzIsdM3cnUOxQm2j1E9L8US6VNieQQzSWClkIoyTpdfs8LiptAVY3dmgeRyhMJ0M=
X-Received: by 2002:a05:6830:6c81:b0:72b:9d8d:5881 with SMTP id
 46e09a7af769-73ca672a595mr6343669a34.28.1751872586592; Mon, 07 Jul 2025
 00:16:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250523-b4-gs101_max77759_fg-v4-0-b49904e35a34@uclouvain.be>
 <20250523-b4-gs101_max77759_fg-v4-2-b49904e35a34@uclouvain.be>
 <CADrjBPqOMOyHP=aQ1+fg2X58NWRp-=MJBRZfpbEhQsTzaZ9LHw@mail.gmail.com> <bc40326f-db40-4657-84a7-152def2ca9e3@uclouvain.be>
In-Reply-To: <bc40326f-db40-4657-84a7-152def2ca9e3@uclouvain.be>
From: Peter Griffin <peter.griffin@linaro.org>
Date: Mon, 7 Jul 2025 08:16:15 +0100
X-Gm-Features: Ac12FXwMRomWxAk899mtr7ERc1Q1HFgMOstsgrsF7Db8eRule70Om9Vs1Zufc88
Message-ID: <CADrjBPo2=FajKA0t7TTMdH6iK_qbWCSJK-hEqh+UWEuzC7wyGQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/5] power: supply: add support for max77759 fuel gauge
To: Thomas Antoine <t.antoine@uclouvain.be>
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Dimitri Fedrau <dima.fedrau@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
	Tudor Ambarus <tudor.ambarus@linaro.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Thomas,

On Tue, 24 Jun 2025 at 16:45, Thomas Antoine <t.antoine@uclouvain.be> wrote=
:
>
>
>
> On 6/6/25 1:40 PM, Peter Griffin wrote:
> > Hi Thomas,
> >
> > Thanks for your patch and working to get fuel gauge functional on
> > Pixel 6! I've tried to do quite an in-depth review comparing with the
> > downstream driver.
> Hi Peter,
>
> Thank you very much for the in-depth review!
>
> > On Fri, 23 May 2025 at 13:52, Thomas Antoine via B4 Relay
> > <devnull+t.antoine.uclouvain.be@kernel.org> wrote:
> >>
> >> From: Thomas Antoine <t.antoine@uclouvain.be>
> >>
> >> The interface of the Maxim MAX77759 fuel gauge has a lot of common wit=
h the
> >> Maxim MAX1720x. A major difference is the lack of non-volatile memory
> >> slave address. No slave is available at address 0xb of the i2c bus, wh=
ich
> >> is coherent with the following driver from google: line 5836 disables
> >> non-volatile memory for m5 gauge.
> >>
> >> Link: https://android.googlesource.com/kernel/google-modules/bms/+/1a6=
8c36bef474573cc8629cc1d121eb6a81ab68c/max1720x_battery.c
> >>
> >> Other differences include the lack of V_BATT register to read the batt=
ery
> >> level. The voltage must instead be read from V_CELL, the lowest voltag=
e of
> >> all cells. The mask to identify the chip is different. The computation=
 of
> >> the charge must also be changed to take into account TASKPERIOD, which
> >> can add a factor 2 to the result.
> >>
> >> Add support for the MAX77759 by taking into account all of those
> >> differences based on chip type.
> >>
> >> Do not advertise temp probes using the non-volatile memory as those ar=
e
> >> not available.
> >>
> >> The regmap was proposed by Andr=C3=A9 Draszik in
> >>
> >> Link: https://lore.kernel.org/all/d1bade77b5281c1de6b2ddcb4dbbd033e455=
a116.camel@linaro.org/
> >
> > I think it would be worth noting in the commit message this is basic
> > initial support for the M5 gauge in MAX77759, and things like loading
> > & saving the m5 model aren't implemented yet.
> >
> > That's important as some values such as the REPSOC register value used
> > for POWER_SUPPLY_PROP_CAPACITY show the result after all processing
> > including ModelGauge mixing etc, so these values won't be as accurate
> > as downstream.
>
> I will add that to the next version.

Ok great :)

>
> >>[...]
> >> +static const enum power_supply_property max77759_battery_props[] =3D =
{
> >> +       POWER_SUPPLY_PROP_PRESENT,
> >
> > I checked the register values match downstream - this looks correct
> >
> >> +       POWER_SUPPLY_PROP_CAPACITY,
> >
> > I checked the register offset matchs downstream. The value reported
> > varies a bit versus downstream. As mentioned above that is likely due
> > to the REPSOC register reporting after mixing with the m5 model which
> > is not loaded currently. Also the application specific values and cell
> > characterization information used by the model isn't configured
> > currently (see link below in _TEMP property below for the initial fuel
> > gauge params used by downstream.
> >
>
> I have dumped the model written to my phone by a userdebug stock android.
> If you think it is necessary, I can implement model loading where the
> model is passed in the devicetree for next version.

See comment a bit further down about using a dedicated compatible.
Also I think it's probably worth thinking about it conceptually as 3
things
1) Ensuring the application specific values and initial registers are
initialized like downstream does from DT (DesignCap, CONFIG register
etc)
2) Loading the M5 model gauge algorithm
3) Saving and restoring the "algorithm configuration" values to nvmem
and re-loading them on a fresh boot.

Most of the code for these features is in the following file
https://android.googlesource.com/kernel/google-modules/bms/+/1a68c36bef4745=
73cc8629cc1d121eb6a81ab68c/max_m5.c
downstream.

>
> >> +       POWER_SUPPLY_PROP_VOLTAGE_NOW,
> >
> > I checked the register offset matchs downstream. Values reported look s=
ensible.
> >
> >> +       POWER_SUPPLY_PROP_CHARGE_FULL,
> >
> > Downstream has a slightly different implementation than upstream for
> > this property. See here
> > https://android.googlesource.com/kernel/google-modules/bms/+/1a68c36bef=
474573cc8629cc1d121eb6a81ab68c/max1720x_battery.c#2244
> >
>
> Indeed, the main difference seems to be to use FULLCAPNOM instead of
> FULLCAP. I will check out to see if both differ in value.
>
>
> >> +       POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN,
> >
> > I checked the register offset value is correct. However this is
> > reporting 3000000 and downstream reports 4524000. I checked and it's
> > just converting the register reset value of DESIGNCAP which is 0xbb8.
> >
> > This is listed as a "application specific" value, so it maybe we just
> > need to write the correct initial value to DESIGNCAP (see TEMP section
> > below)
> >
>
> The value  3000000 is the default value which will be set after a hardwar=
e
> reset. I was able to extract the init sequence from a stock android.
> It indeed writes the DESIGNCAP value. Here is a summary of the registers
> written to upon a hardware reset. When (DTS) is written next to it,
> it means that the value is exactly the same as given by the table in
> maxim,cos-a1-2k at the link
> https://android.googlesource.com/kernel/gs/+/refs/heads/android-gs-raviol=
e-5.10-android15/arch/arm64/boot/dts/google/gs101-oriole-battery-data.dtsi
>
>   "0x05 0x0000" #REPCAP
>   "0x2a 0x0839" #RELAXCFG (DTS)
>   "0x60 0x0080" #COMMAND UNLOCK_CFG
>   "0x48 0x5722" #VFSOC0 (Value read from reg 0xff)
>   "0x28 0x260e" #LEARNCFG (DTS)
>   "0x1d 0x4217" #CONFIG (DTS)
>   "0xbb 0x0090" #CONFIG2 (DTS)
>   "0x13 0x5f00" #FULLSOCTHR (DTS)
>   "0x35 0x08e8" #FULLCAPREP
>   "0x18 0x08d6" #DESIGNCAP (DTS)
>   "0x46 0x0c80" #DPACC
>   "0x45 0x0094" #DQACC
>   "0x00 0x0002" #STATUS
>   "0x23 0x0905" #FULLCAPNOM
>   "0x3a 0xa561" #VEMPTY (DTS)
>   "0x12 0x2f80" #QRTABLE0 (DTS)
>   "0x22 0x1400" #QRTABLE1 (DTS)
>   "0x32 0x0680" #QRTABLE2 (DTS)
>   "0x42 0x0580" #QRTABLE3 (DTS)
>   "0x38 0x03bc" #RCOMP0
>   "0x39 0x0c02" #TCOMPO
>   "0x3c 0x2d00" #TASKPERIOD (DTS)
>   "0x1e 0x05a0" #ICHGTERM (DTS)
>   "0x2c 0xed51" #TGAIN (DTS)
>   "0x2d 0x1eba" #TOFF (DTS)
>   "0x2b 0x3870" #MISCCFG (DTS)
>   "0x04 0x0000" #ATRATE (DTS)
>   "0xb6 0x06c3" #CV_MIXCAP (value =3D 75% of FULLCAPNOM)
>   "0xb7 0x0600" #CV_HALFTIME
>   "0x49 0x2241" #CONVGCFG (DTS)
>   "0x60 0x0000" #COMMAND LOCK_CFG
>   "0xb9 0x0014" #CURVE (DTS)
>   "0x29 0xc623" #FILTERCFG (DTS)
>   "0x2e 0x0400" #CGAIN (hard coded)
>   "0xbb 0x00b0" #CONFIG2 (DTS | 0x0020)

Bit 5 is "LdMdl" see
https://android.googlesource.com/kernel/google-modules/bms/+/1a68c36bef4745=
73cc8629cc1d121eb6a81ab68c/max_m5_reg.h#1489
It is set to 1 to initiate loading a model, and firmware clears the
bit to zero to indicate model loading is finished. You can see more
info about how this works
https://android.googlesource.com/kernel/google-modules/bms/+/1a68c36bef4745=
73cc8629cc1d121eb6a81ab68c/max_m5.c#459

>   "0x02 0x0780" #TALRTTH
>   "0x00 0x0000" #STATUS
>   "0x17 0x9320" #CYCLES
>
> As can be seen, most values come directly from the devicetree but some
> are not present in there or differ from the value given in the devicetree=
.

Some of those registers like RepCap, Cycles, FullCapNom are ModelGauge
algorithm outputs.

Others like DQACC, DPACC, RCOMP0 are part of the values that should be
saved and restored to some nvmem. You can see the function here that
does this https://android.googlesource.com/kernel/google-modules/bms/+/1a68=
c36bef474573cc8629cc1d121eb6a81ab68c/max_m5.c#657

>
> Without a similar init, charge and temperature will be non-functional
> other values will most likely be wrong.
> The fuel gauge stays powered through reboot so it doesn't reset even
> when switching from android to linux, meaning that without any hardware
> crash (e.g. empty batterry), the chip will look perfectly initialized.
> A hardware reset of the fuel gauge can be forced by writing to
> /proc/sysrq-trigger or by writing 0xf to 0x60.

Ah that explains it then, as Andre mentioned he thought this reported
a correct value in a previous version. It might be worth adding that
info in the cover letter of future versions.

>
> I am unsure about what to do about this initalization, especially for val=
ues
> which slightly differ from the devicetree. I think for next version, I
> will have the same parameters be passed in the devicetree like android.

We don't really pass register values like the downstream driver is
doing in the device tree. I think you will likely need to add a
max77759-gs101-oriole compatible to the driver and then have the
application specific values, and m5 gauge model algorithm as static
info in the driver applied from the dedicated compatible. It would
also be worth checking whether any more of those register values can
be represented by the standard power-supply binding properties that
already exist.

> (except maybe IAvgEmpty which seems to be unused in the downsteam driver?=
)
>
> >> +       POWER_SUPPLY_PROP_CHARGE_AVG,
> >
> > This property isn't reported downstream. The value is changing and not
> > just the reset value. I noticed REPSOC is an output of the ModelGauge
> > algorithm so it is likely not to be completely accurate.
> >
> >> +       POWER_SUPPLY_PROP_TEMP,
> >
> > I checked the register offset value is correct. However the
> > temperature is always being reported as the register reset value of
> > 220. This is for obvious reasons quite an important one to report
> > correctly.
> >
> > I started debugging this a bit, and it is caused by an incorrectly
> > configured CONFIG (0x1D) register. In particular the TEX[8] bit is 1
> > on reset in this register which means temperature measurements are
> > written from the host AP. When this bit is set to 0, measurements on
> > the AIN pin are converted to a temperature value and stored in the
> > Temperature register (I then saw values of 360 and the value
> > changing).
> >
> > See here for the bits in that CONFIG register
> > https://android.googlesource.com/kernel/google-modules/bms/+/1a68c36bef=
474573cc8629cc1d121eb6a81ab68c/max_m5_reg.h#403
> >
> > In downstream all these initial register settings are taken from DT
> > here  https://android.googlesource.com/kernel/google-modules/raviole-de=
vice/+/refs/heads/android14-gs-pixel-6.1/arch/arm64/boot/dts/google/gs101-f=
ake-battery-data.dtsi#27
> >
> > For temperature when TEX=3D0, TGAIN, TOFF and TCURVE registers should
> > also be configured to adjust the temperature measurement.
> >
> > I think it would likely be worth initialising all the fuel gauge
> > registers referenced in maxim,fg-params as that includes some of the
> > application specific values for DESIGNCAP, also some of the cell
> > characterization information, and hopefully we will get more accurate
> > values from the fuel gauge generally.
> >
>
> See previous comment.
>
> >> +       POWER_SUPPLY_PROP_CURRENT_NOW,
> >
> > I checked the register offset matches downstream. Values reported look
> > reasonable.
> >
> >> +       POWER_SUPPLY_PROP_CURRENT_AVG,
> >
> > I checked the register offset matches downstream. Values reported look
> > reasonable.
> >
> >> +       POWER_SUPPLY_PROP_MODEL_NAME,
> >
> > This property isn't reported downstream.
>
> Is this a problem?

Nope, that was more for my own benefit when doing the review :)

Thanks,

Peter


>
> >> [...]
> >>  /*
> >>   * Current and temperature is signed values, so unsigned regs
> >>   * value must be converted to signed type
> >> @@ -390,16 +507,36 @@ static int max1720x_battery_get_property(struct =
power_supply *psy,
> >>                 val->intval =3D max172xx_percent_to_ps(reg_val);
> >>                 break;
> >>         case POWER_SUPPLY_PROP_VOLTAGE_NOW:
> >> -               ret =3D regmap_read(info->regmap, MAX172XX_BATT, &reg_=
val);
> >> -               val->intval =3D max172xx_voltage_to_ps(reg_val);
> >> +               if (info->id =3D=3D MAX1720X_ID) {
> >> +                       ret =3D regmap_read(info->regmap, MAX172XX_BAT=
T, &reg_val);
> >> +                       val->intval =3D max172xx_voltage_to_ps(reg_val=
);
> >
> > I think MAX1720X using MAX172XX_BATT register is likely a bug as the
> > downstream driver uses MAX172XX_VCELL for that variant  see here
> > https://android.googlesource.com/kernel/google-modules/bms/+/1a68c36bef=
474573cc8629cc1d121eb6a81ab68c/max1720x.h#304
> >
>
> Based on the comments from Sebastian Reichel, it seems that it is
> downstream which is wrong:
> https://lore.kernel.org/all/4cahu6dog7ly4ww6xyjmjigjfxs4m55mrnym2bjmzsksc=
fvk34@guazy6wxbzfh/
>
> > Having said that, if we do need to cope with differing register
> > offsets for the different fuel gauge variants it would be nicer to
> > abstract them in a way similar to the downstream driver. See here
> > https://android.googlesource.com/kernel/google-modules/bms/+/1a68c36bef=
474573cc8629cc1d121eb6a81ab68c/max_m5.c#1235
> > I think that would be more scalable in supporting multiple variants in
> > one driver. Otherwise we will have an explosion of if(id=3D=3Dblah) els=
e
> > if (id=3D=3Dblah) in the driver.
> >
> > kind regards,
> >
> > Peter
>
>
> I completely agree about the need for abstraction if we want to keep both
> chips in the same driver. I will try to implement that for next version.
> Best regards,
> Thomas

