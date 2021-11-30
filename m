Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 879A3463D6C
	for <lists+linux-pm@lfdr.de>; Tue, 30 Nov 2021 19:12:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245333AbhK3SPf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 30 Nov 2021 13:15:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238080AbhK3SPe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 30 Nov 2021 13:15:34 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA1DAC061574;
        Tue, 30 Nov 2021 10:12:14 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id i8-20020a7bc948000000b0030db7b70b6bso20224604wml.1;
        Tue, 30 Nov 2021 10:12:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1GfV3zta/z9JoKzgmdmEEj9hpTBApmNs4j7cDZBMOGc=;
        b=VPyaZj70LNlfmo8vyq/bdkYc5lM+6a2xPAMr1Tx4rjiSzTAVfo6mUj1NAJhjKCwNDd
         MtIdyee+YfNfMjDrQ/gqmflPr+f770yMKESXCE+jTlfMdhM+q6oiHTVPI83Zfa82oz6z
         +V5PEMWvE2OsKs8NDpQIsOHL8xqoEpFxiiXAYROdczoIj0Y6tuNkj1M4UH91qTRsHG3O
         PGtsc6hmnXnaI4SaQNny5PkEXDejaJMRHVZc/kSVUEXLML7SFGgpv7y8gxaPq5bAJVWQ
         WvAZuFvYmmefFt6sWsgXhVCY6Rbw4C77d1UDQ6S08O+I+qO6QGcd5PkaeRXgvWRXcgVQ
         x6PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1GfV3zta/z9JoKzgmdmEEj9hpTBApmNs4j7cDZBMOGc=;
        b=ZFAHPPbHTKcDef3TX0BGFg7LmcFWT05QrBEiIvf9V4xonQwCCaBpgIcvA2XQdEmZus
         8UNV9AiauhXBZ7cWAJdPRi8qKBBZWNDTHJcpZLFdqQ0Op5B6AU30E4UYYDd5efSlNNia
         y8RU9w26ZCCbyPb53M4V62dgecfqI7i2Suc5SuiC/o57Tyc9GR/ST1fraIuKU7vGLizk
         i3R8+uP8HWwiBnGnwuN7YfB/mNXxRnpGTAqeItc7cRGoGitOQm1kqpqnvyShu7uGEDIW
         qcsedF06W5sUuG70hHigflljldgxga/I2a9X/rq2uOWiiaTMng04TDI54hLSxj8N6ygI
         AslA==
X-Gm-Message-State: AOAM532Im0v6DSPRUyXoB41K2PDS0MLDKjmb+fU3wVQ8mChiQpc2g3fU
        X+6C7zO++X//AFHdxt1/E1I=
X-Google-Smtp-Source: ABdhPJxLLBjy+5pV2Vw7yzKGxAyLHcEUZ/+Cw37st1U6y37HezvYTYbnP5+zZ03FIrQK80aMum5LZg==
X-Received: by 2002:a1c:a711:: with SMTP id q17mr330188wme.158.1638295933311;
        Tue, 30 Nov 2021 10:12:13 -0800 (PST)
Received: from archbook.localnet (84-72-105-84.dclient.hispeed.ch. [84.72.105.84])
        by smtp.gmail.com with ESMTPSA id l4sm16775043wrv.94.2021.11.30.10.12.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 10:12:12 -0800 (PST)
From:   Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
To:     Chris Morgan <macromorgan@hotmail.com>
Cc:     linux-rockchip@lists.infradead.org, lee.jones@linaro.org,
        robh+dt@kernel.org, heiko@sntech.de, sre@kernel.org,
        maccraft123mc@gmail.com, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, Chris Morgan <macroalpha82@gmail.com>
Subject: Re: [PATCH v4 RESEND 0/4] power: supply: Add Support for RK817 Charger
Date:   Tue, 30 Nov 2021 19:12:11 +0100
Message-ID: <2197533.Eh1vGvx6NY@archbook>
In-Reply-To: <SN6PR06MB534222D7CA5732E689F5BA21A5679@SN6PR06MB5342.namprd06.prod.outlook.com>
References: <20210916194208.10387-1-macroalpha82@gmail.com> <2759402.V8G6Gt6Xmj@archbook> <SN6PR06MB534222D7CA5732E689F5BA21A5679@SN6PR06MB5342.namprd06.prod.outlook.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Dienstag, 30. November 2021 17:10:21 CET Chris Morgan wrote:
> On Tue, Nov 30, 2021 at 03:03:03AM +0100, Nicolas Frattaroli wrote:
> > On Donnerstag, 16. September 2021 21:42:04 CET Chris Morgan wrote:
> > > From: Chris Morgan <macromorgan@hotmail.com>
> > > 
> > > This series is to add support for the Rockchip rk817 battery charger
> > > which is present in all Rockchip RK817 PMICs. The driver was written
> > > as a joint effort by Maya Matuszczyk <maccraft123mc@gmail.com> and
> > > myself Chris Morgan <macromorgan@hotmail.com>.
> > 
> > Hi Chris and Maya,
> > 
> > Gave this a whirl on my Quartz64 Model A. I noticed that this will
> > happily let me discharge past voltage_min_design:
> > 
> >  $ cat /sys/class/power_supply/rk817-battery/voltage_min_design 
> >  3625000
> >  $ cat /sys/class/power_supply/rk817-battery/voltage_avg 
> >  3381360
> > 
> > Is this normal? It went all the way to under 3V before the
> > board finally locked up.
> > 
> > Does the minimum voltage not affect some sort of cutout on
> > the RK817? Does it even have one? Is it the driver's job to
> > do something here or not?

Hi Chris,

> It does not look like I coded that, but I can. The PMIC has a
> selectable register (RK817_PMIC_SYS_CFG0 = 0xf1) to automatically shut
> down the system at a certain voltage (between 2.7v and 3.4v in
> increments of 100mv; bits 6-4), a register to set a low voltage value
> (between 2.8v and 3.5v in increments of 100mv; bits 2-0), and a
> register to set a low voltage action (either shut down the machine or
> trigger an interrupt; bit 3 and then I believe the interrupt is read at
> bit 7 of RK817_PMIC_INT_STS0 - 0xf8).

Excellent, I think shutting down the system is definitely the way to
go here, as by reaching this voltage we can assume userspace has gone
missing and we don't know if the kernel is still alive.

> I guess I just assumed userspace would handle it, but that's probably
> a bad assumption.

Yes, I didn't have upower installed, but over discharge protection
shouldn't be handled by userspace at all. Had I connected an unprotected
cell that didn't cut out at below 3V, it would've been irreversibly
damaged due to a simple forgotten package install. Even if unprotected
batteries are a bad idea, I think we best assume the worst case
situation here.

> What if I set the low voltage value to either 3.5v
> or the min design voltage, whichever is less; and then set the low
> voltage trigger to shut down the system? This would prevent your
> battery from dropping below 3.5v or the min design voltage (whichever
> is less, sadly 3.5v is as high as I can go for the minimum) in the
> event userspace doesn't take action first? We could also set the
> shutdown voltage to be 100mv less than the min design voltage and use
> the low voltage interrupt to trigger an action, but I'm not sure what
> action would be appropriate (and if userspace isn't listening it would
> be moot anyway).

A very simple solution would be to simply set the shutoff point to the
voltage reaching less than 3.1V. The RK817 only charges Lithium/Li-Po
batteries, and they should generally not be discharged below 3.0V. Of
the protected batteries I own, over-discharge protection generally
kicks in at the 3V threshold.

This gets rid of a lot of logic that could lead to bugs by simply setting
a known good value to begin with.

I think I can summarise how I understand this is supposed to work as
follows:

 - if battery reaches 0% and the battery alarm is rang, userspace should
   power down the system
     - this prevents unclean shutdowns
 - if the battery reaches a dangerously low voltage for its chemistry,
   the PMIC should cut power to the system as instructed by the kernel
     - last resort measure in case userspace is absent and the battery
       happens to be unprotected
 - there may or may not be battery protection which kicks in at 3V, but
   we should not rely on this working
      - some 18650 cases infamously aren't sized to fit cells with a
        protection circuit connected to it. I shan't name names.

In a freak accident where the kernel is completely locked up and the
battery is unprotected and being drained, I presume that having set
this PMIC register will still make it kick in, which lets me sleep
a little sounder at night.

Regards,
Nicolas Frattaroli

> 
> Thank you.
> 
> > 
> > Regards,
> > Nicolas Frattaroli
> > 
> > 
> 




