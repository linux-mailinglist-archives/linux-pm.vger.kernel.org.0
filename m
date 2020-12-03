Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E6202CD2ED
	for <lists+linux-pm@lfdr.de>; Thu,  3 Dec 2020 10:51:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730228AbgLCJv1 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Thu, 3 Dec 2020 04:51:27 -0500
Received: from mail-ej1-f65.google.com ([209.85.218.65]:39602 "EHLO
        mail-ej1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730201AbgLCJv0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 3 Dec 2020 04:51:26 -0500
Received: by mail-ej1-f65.google.com with SMTP id n26so2514465eju.6;
        Thu, 03 Dec 2020 01:51:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=zIi/0Gk+POPxQXzfzK/flFDHb00Mu6VDDpn3MrPay+U=;
        b=aWNzq4+85ljJnLKH565CqtDhKRnEpSNx1tA+6Mg1X/tps9i4Eorp6bMy6YTpqRKXwV
         DvR5YgBqaRSUes24Hq3NxzF/0baDvFxtmFEPbLk13ZXxQvzTlgurzFDNgPKTQCJdA8Om
         6U0PKM8LGbRkBC4z3cGwEzbgw9xuOvWETQpD6cFOXJiYGITdmTbEWkKRS9lzyANK6HUS
         NkY9Wlhg9f9YlwV4y3++CoU6p8ZdrV1+YGqseLlvL7Xii4W7HSU/mASOhX4ceTUE9JiY
         GB2nmMlyzrkGbiGwsWIBnpwkkANvo7RQdjzPd3GgyUNiQBB8GSY2naOsH51Bftyim1iI
         A7SA==
X-Gm-Message-State: AOAM532KRSNw3780xZQcYJhX220xBeBQbzU8fWsmeeofjupxl4pqmAKb
        2dposUiwQMg/nHE8CAxDCqU=
X-Google-Smtp-Source: ABdhPJxzs5zlrR2KVLdPKT32M/bDkg6bGqfhyrosRE+ocveA3Ul8/IKXaWh6g33OKKEI5YiRRypB8A==
X-Received: by 2002:a17:907:2131:: with SMTP id qo17mr1742622ejb.546.1606989043852;
        Thu, 03 Dec 2020 01:50:43 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id b14sm782174edx.0.2020.12.03.01.50.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 01:50:42 -0800 (PST)
Date:   Thu, 3 Dec 2020 11:50:41 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Timon =?utf-8?B?QsOkdHo=?= <timon.baetz@protonmail.com>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kukjin Kim <kgene@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "~postmarketos/upstreaming@lists.sr.ht" 
        <~postmarketos/upstreaming@lists.sr.ht>
Subject: Re: [PATCH 3/3] ARM: dts: exynos: Fix charging regulator voltage and
 current for i9100
Message-ID: <20201203095041.GA14508@kozik-lap>
References: <20201202203516.43053-1-timon.baetz@protonmail.com>
 <20201202203516.43053-3-timon.baetz@protonmail.com>
 <20201202220430.GB135888@kozik-lap>
 <dDjo3R2SJ6CBCjg0YhsCPdh5JfEGhA--DHNNDqbWjVtTjZC5v7g7_523vqAzu_Ybf1Q-xfKeK47H483YQoVtpO3DI83OaR6c6mbvtC9S1Us=@protonmail.com>
 <20201203082301.GA3999@kozik-lap>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20201203082301.GA3999@kozik-lap>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Dec 03, 2020 at 10:23:01AM +0200, Krzysztof Kozlowski wrote:
> On Thu, Dec 03, 2020 at 05:46:03AM +0000, Timon Bätz wrote:
> > On Wednesday, December 2, 2020 11:04 PM, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> > 
> > > On Wed, Dec 02, 2020 at 09:07:28PM +0000, Timon Baetz wrote:
> > >
> > > > Set CHARGER current and CHARGER_CV voltage according to Galaxy S2 kernel
> > > > fork.
> > > >
> > > > Signed-off-by: Timon Baetz timon.baetz@protonmail.com
> > > >
> > > > ------------------------------------------------------
> > > >
> > > > arch/arm/boot/dts/exynos4210-i9100.dts | 8 ++++----
> > > > 1 file changed, 4 insertions(+), 4 deletions(-)
> > > > diff --git a/arch/arm/boot/dts/exynos4210-i9100.dts b/arch/arm/boot/dts/exynos4210-i9100.dts
> > > > index 9f8d927e0d21..2700d53ea01b 100644
> > > > --- a/arch/arm/boot/dts/exynos4210-i9100.dts
> > > > +++ b/arch/arm/boot/dts/exynos4210-i9100.dts
> > > > @@ -558,14 +558,14 @@ safe2_sreg: ESAFEOUT2 {
> > > >
> > > >       	charger_reg: CHARGER {
> > > >       		regulator-name = "CHARGER";
> > > >
> > > >
> > > > -       		regulator-min-microamp = <60000>;
> > > >
> > > >
> > > > -       		regulator-max-microamp = <2580000>;
> > > >
> > > >
> > > >
> > > > -       		regulator-min-microamp = <200000>;
> > > >
> > > >
> > > > -       		regulator-max-microamp = <950000>;
> > > >         	};
> > > >
> > > >         	chargercv_reg: CHARGER_CV {
> > > >         		regulator-name = "CHARGER_CV";
> > > >
> > > >
> > > >
> > > > -       		regulator-min-microvolt = <3800000>;
> > > >
> > > >
> > > > -       		regulator-max-microvolt = <4100000>;
> > > >
> > > >
> > > >
> > > > -       		regulator-min-microvolt = <4200000>;
> > > >
> > > >
> > > > -       		regulator-max-microvolt = <4200000>;
> > > >
> > > >
> > >
> > > I am looking at my sources of Android 3.0 for GT-I9100 but I cannot find
> > > charger voltages for it. Where did you find it?
> > >
> > > Best regards,
> > > Krzysztof
> > 
> > Thanks all the feedback Krzysztof,
> > 
> > Voltage is set in the charger probe function of the downstream kernel fork: https://github.com/LineageOS/android_kernel_samsung_smdk4412/blob/lineage-17.0/drivers/power/max8997_charger_u1.c#L390-L391
> 
> You need to fix your email client to wrap lines.
> 
> The fork cannot be used as a reference because of poor quality of
> explanations for origins of the code.
> 
> The commit which added 4.2 V is described as "samsung update 1" which
> basically means nothing. If at least it was "drop sources of
> GT-I9105"... but in this form it is useless.
> 
> For the things we are not sure how they should be implemented, we
> sometimes accept the reason "vendor sources do like this". However Lineage
> or any other fork are not vendor sources.
> 
> Therefore you need to provide a valid explanation for this voltage
> change.

I checked vendor sources for Samsung Galaxy S2 Epic 4G Touch (SPH-D710)
and indeed it uses the max8997 charger U1 which sets v4.2 volts.

You can use it to fix up the commit msg.

Unfortunately it seems Samsung started to remove most of older
kernel source code from their OS compliance page. S1, S2 and S3 are
mostly gone. I was able to find just few remaining sources and I am now
updating my vendor-dump with them. I'll upload them later to
https://github.com/krzk/linux-vendor-backup .

Best regards,
Krzysztof

