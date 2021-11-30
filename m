Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A6FE463E87
	for <lists+linux-pm@lfdr.de>; Tue, 30 Nov 2021 20:17:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343522AbhK3TUV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 30 Nov 2021 14:20:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230100AbhK3TT4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 30 Nov 2021 14:19:56 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4830C061574;
        Tue, 30 Nov 2021 11:16:34 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id u1so46672765wru.13;
        Tue, 30 Nov 2021 11:16:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ef3pNAvFyeJjbNmdet3IMAdRtnds6OW8kq/F+gFt22k=;
        b=CtVOjrOJO/4rb85gtmbkXVMXJA7w5ibhKEfc7HveyKmKxoyIZIho9u4IfdG7rkI4hd
         IDuexFjBYgFiZRmz8K6ypPpB9p3umOb90vOeG6TY7Wwqtfp7ag3hIRYWB9PYproE66dr
         cbxiVaMcSUF8LZm9691lf2QkszzSqaqjyHpWngi7BGVgY2ESMMpe3wVZ7u28A01rlosE
         Er02wUZP6tWouAl6c7XraZlPSMeOf/8O6kW4PB8x/wDmh35onYaRmFrLnuL3U9f/O/E2
         WfoRLVH18Z+adygcSXbc7lZjawn/obmxBc2dJM/CgFAXAerh/zukr5zqXR7ezqkfauc7
         6xEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ef3pNAvFyeJjbNmdet3IMAdRtnds6OW8kq/F+gFt22k=;
        b=l6mGTvFcoyVYiz6o69iBMXsy7+ztqCysr6qzJeAw9hUgVZ+29yTDRptSGcPl4FiafL
         j8mxbKTdB2QDMmkLKJEYqToeJaiEFyEG7iKZkJs1wNtLUchMy9kyCLtEg9U6QIt0KWA2
         0W9X14ukIH09cPiGEoVDP1L0lLjq6BwY1KCnDMKBAtLflY4ID5CPrdNyYJxLT/lSoXMV
         dlVtVEMPYEToxkqR1G5YzjiAL7hBsbSFH6Brc0AN7DiyOGxtxI11RO8uJts8dZoOFeLh
         mewy4Qwdz4/b2uUYvPpbiRVChbtO7bM71Ck4ZhM0+qK6omhA6cZnrV52qS/+UT1sh2LZ
         dJFQ==
X-Gm-Message-State: AOAM530oaWeNfXBvWbCbuXuXOe8cE4TysmKnE+upOBlOkw9w0hnPdhbi
        ClVfPI19UIGeMt5jBBHUBdA=
X-Google-Smtp-Source: ABdhPJyffvNw0qfX1lL78dpOYLQgp+oWkJkRGWN9lsL8P8CbfAHkgVc5i12qejLoXuHogvxwfAwnGg==
X-Received: by 2002:adf:82d3:: with SMTP id 77mr928486wrc.377.1638299793299;
        Tue, 30 Nov 2021 11:16:33 -0800 (PST)
Received: from archbook.localnet (84-72-105-84.dclient.hispeed.ch. [84.72.105.84])
        by smtp.gmail.com with ESMTPSA id o3sm3808644wms.10.2021.11.30.11.16.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 11:16:32 -0800 (PST)
From:   Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
To:     Chris Morgan <macromorgan@hotmail.com>
Cc:     linux-rockchip@lists.infradead.org, lee.jones@linaro.org,
        robh+dt@kernel.org, heiko@sntech.de, sre@kernel.org,
        maccraft123mc@gmail.com, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, Chris Morgan <macroalpha82@gmail.com>
Subject: Re: [PATCH v4 RESEND 0/4] power: supply: Add Support for RK817 Charger
Date:   Tue, 30 Nov 2021 20:16:31 +0100
Message-ID: <5790471.3iNxtBKjHZ@archbook>
In-Reply-To: <SN6PR06MB5342DF2234B8F9599E1AF125A5679@SN6PR06MB5342.namprd06.prod.outlook.com>
References: <20210916194208.10387-1-macroalpha82@gmail.com> <2197533.Eh1vGvx6NY@archbook> <SN6PR06MB5342DF2234B8F9599E1AF125A5679@SN6PR06MB5342.namprd06.prod.outlook.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Dienstag, 30. November 2021 19:33:02 CET you wrote:
> On Tue, Nov 30, 2021 at 07:12:11PM +0100, Nicolas Frattaroli wrote:
> > On Dienstag, 30. November 2021 17:10:21 CET Chris Morgan wrote:
> > > On Tue, Nov 30, 2021 at 03:03:03AM +0100, Nicolas Frattaroli wrote:
> > > > On Donnerstag, 16. September 2021 21:42:04 CET Chris Morgan wrote:
> > > > > From: Chris Morgan <macromorgan@hotmail.com>
> > > > > 
> > > > > This series is to add support for the Rockchip rk817 battery charger
> > > > > which is present in all Rockchip RK817 PMICs. The driver was written
> > > > > as a joint effort by Maya Matuszczyk <maccraft123mc@gmail.com> and
> > > > > myself Chris Morgan <macromorgan@hotmail.com>.
> > > > 
> > > > Hi Chris and Maya,
> > > > 
> > > > Gave this a whirl on my Quartz64 Model A. I noticed that this will
> > > > happily let me discharge past voltage_min_design:
> > > > 
> > > >  $ cat /sys/class/power_supply/rk817-battery/voltage_min_design 
> > > >  3625000
> > > >  $ cat /sys/class/power_supply/rk817-battery/voltage_avg 
> > > >  3381360
> > > > 
> > > > Is this normal? It went all the way to under 3V before the
> > > > board finally locked up.
> > > > 
> > > > Does the minimum voltage not affect some sort of cutout on
> > > > the RK817? Does it even have one? Is it the driver's job to
> > > > do something here or not?
> > 
> > Hi Chris,
> > 
> > > It does not look like I coded that, but I can. The PMIC has a
> > > selectable register (RK817_PMIC_SYS_CFG0 = 0xf1) to automatically shut
> > > down the system at a certain voltage (between 2.7v and 3.4v in
> > > increments of 100mv; bits 6-4), a register to set a low voltage value
> > > (between 2.8v and 3.5v in increments of 100mv; bits 2-0), and a
> > > register to set a low voltage action (either shut down the machine or
> > > trigger an interrupt; bit 3 and then I believe the interrupt is read at
> > > bit 7 of RK817_PMIC_INT_STS0 - 0xf8).
> > 
> > Excellent, I think shutting down the system is definitely the way to
> > go here, as by reaching this voltage we can assume userspace has gone
> > missing and we don't know if the kernel is still alive.
> > 
> > > I guess I just assumed userspace would handle it, but that's probably
> > > a bad assumption.
> > 
> > Yes, I didn't have upower installed, but over discharge protection
> > shouldn't be handled by userspace at all. Had I connected an unprotected
> > cell that didn't cut out at below 3V, it would've been irreversibly
> > damaged due to a simple forgotten package install. Even if unprotected
> > batteries are a bad idea, I think we best assume the worst case
> > situation here.
> > 
> > > What if I set the low voltage value to either 3.5v
> > > or the min design voltage, whichever is less; and then set the low
> > > voltage trigger to shut down the system? This would prevent your
> > > battery from dropping below 3.5v or the min design voltage (whichever
> > > is less, sadly 3.5v is as high as I can go for the minimum) in the
> > > event userspace doesn't take action first? We could also set the
> > > shutdown voltage to be 100mv less than the min design voltage and use
> > > the low voltage interrupt to trigger an action, but I'm not sure what
> > > action would be appropriate (and if userspace isn't listening it would
> > > be moot anyway).
> > 
> > A very simple solution would be to simply set the shutoff point to the
> > voltage reaching less than 3.1V. The RK817 only charges Lithium/Li-Po
> > batteries, and they should generally not be discharged below 3.0V. Of
> > the protected batteries I own, over-discharge protection generally
> > kicks in at the 3V threshold.
> > 
> > This gets rid of a lot of logic that could lead to bugs by simply setting
> > a known good value to begin with.
> > 
> > I think I can summarise how I understand this is supposed to work as
> > follows:
> > 
> >  - if battery reaches 0% and the battery alarm is rang, userspace should
> >    power down the system
> >      - this prevents unclean shutdowns
> >  - if the battery reaches a dangerously low voltage for its chemistry,
> >    the PMIC should cut power to the system as instructed by the kernel
> >      - last resort measure in case userspace is absent and the battery
> >        happens to be unprotected
> >  - there may or may not be battery protection which kicks in at 3V, but
> >    we should not rely on this working
> >       - some 18650 cases infamously aren't sized to fit cells with a
> >         protection circuit connected to it. I shan't name names.
> > 
> > In a freak accident where the kernel is completely locked up and the
> > battery is unprotected and being drained, I presume that having set
> > this PMIC register will still make it kick in, which lets me sleep
> > a little sounder at night.
> > 
> 
> Okay. The default value for automatic shutdown is 2.7v, but that's
> probably too low. I'm wondering though if this should go in the main
> MFD driver, rather than the battery driver? The reason why I ask is
> that without a battery driver to raise the shutdown voltage to 3.1v,
> the shutdown will not happen until 2.7v which risks damage to the
> battery. This means devices in production today (such as anyone running
> the Odroid Go Advance on a mainline kernel) on a battery will
> experience this behavior. Setting that register value shouldn't do
> anything harmful if you don't have a battery, so I assume if it's safe
> to set it 100% of the time for battery users it's safe to set 100% of
> the time in total. Which also begs the question, if this is such a
> danger to the hardware, should we even be doing it in Linux? We could
> be setting it in U-Boot, because if the MFD driver fails to load or the
> kernel freezes before the MFD driver loads there is STILL the risk you
> could undervolt the battery, regardless of fixing this in the MFD driver
> or the battery driver.

I believe 2.7V is still fine. The protection circuits may cut off before
that because they want to keep the longevity of the battery and there
isn't much juice left between 2.7V and 3.0V anyway. If the PMIC always
shuts down at 2.7V then there isn't anything to fear really, that's
still above the 2.5V that Wikipedia states as being the lower end of
the safe voltage range. While that's not the source to end all sources,
the PMIC having a lower cutoff probably means that some engineer did
think of this and pulled up the correct numbers.

Now that I've learned of this, I suspect there isn't really an issue
at all here. If we shut off at 2.7V we're good. Userspace should shut
down before then, and if there's battery protection that kicks in
before that, it makes really no difference to the end result, as
long as there is some cutoff somewhere

Thanks for your quick responses, my concerns regarding this are
alleviated. Devices that are already out there should be fine
in this regard.

> 
> Thank you.
> 
> > Regards,
> > Nicolas Frattaroli
> > 
> > > 
> > > Thank you.
> > > 
> > > > 
> > > > Regards,
> > > > Nicolas Frattaroli
> > > > 
> > > > 
> > > 
> > 
> > 
> > 
> > 
> 




