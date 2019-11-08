Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 120F4F583F
	for <lists+linux-pm@lfdr.de>; Fri,  8 Nov 2019 21:42:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389011AbfKHUIn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 8 Nov 2019 15:08:43 -0500
Received: from mail-il1-f196.google.com ([209.85.166.196]:36942 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388674AbfKHUIm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 8 Nov 2019 15:08:42 -0500
Received: by mail-il1-f196.google.com with SMTP id s5so6226823iln.4;
        Fri, 08 Nov 2019 12:08:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eltmz3pR3Soq+1V6jMFmgjGcnWDU/PywdSSSznftPO8=;
        b=em/ney5+BG/mSj4/tLUCSyIi6YGffQpErAmyo2xXvZj63pMCyXedAt1Ck+Yu+o7KKN
         nHmkcta2DhxLMIlPCzKV8TWLy1j68LJ1tovWEnWvELu07sy4hRyMs2PlCo6O5/e4H1v8
         cEbVYqDEJQjziv2mLoh0O3wJGVX3GB4S+ETNkoq9iIILGbAXjUHkNknaqAk/7TMT+drP
         3wwIfa+nUv7daxm28EFNmdFwelbYicG2Fs4xiH4IBq0JTl98V71pxgkHnHCEZHsG9b/U
         hFmB7DTIuU5LsjLfNim+TUwUGLZRbfrT+zhTgLjkJ1/zc/g7RD+lYhysAZ3xtmyvUM7M
         RBoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eltmz3pR3Soq+1V6jMFmgjGcnWDU/PywdSSSznftPO8=;
        b=CJNqRJXR7nAks6TFNxix8BbcLhi90ma061DN2eXr5kRkr8ccCBAC0l1KdNED0nLh7F
         tYii3Jlzbc7z48Z5IebHyRNU2H86U1nxfc18DWEOvKJZHlyxseRmU9HspGQb4p0FSq4d
         yOHdEfW8zz3uGfBvWO4pJ2sKVHx9JXwG+zD+q7CK0k9FIX3FYuew3PRqEQQ+HXZMbEwu
         oruuj4D3D6DQzwRAnOlMMo5Axodd0NlNryQXQsOOwAB3rMmKKVMImHi4up0n2pdIFcfv
         gdgsH26H2goGJHHZTlZ1j/q9VZHJbav0j43TiFdULI6dZoAGzdUkvsSrsPVO3pBsGYYg
         kPGw==
X-Gm-Message-State: APjAAAX8cRiC2tVFiP9JV72Op0KPQVHSBQKJsMUZevmZL+VJCZ5gllow
        p3rz3uqVxBySxDnlm9XVE3yJLeL+yAxMjdL9zUc=
X-Google-Smtp-Source: APXvYqzlpqxccwG6GmOvqxQWjLmMqeCjkjEvuMNKiJOC5iuogUVoY2OtFXA6DFnWbW2+pVaD6tVfy5dh8N1zzlMwFZ0=
X-Received: by 2002:a92:cb84:: with SMTP id z4mr15604238ilo.78.1573243720775;
 Fri, 08 Nov 2019 12:08:40 -0800 (PST)
MIME-Version: 1.0
References: <cover.1568224032.git.hns@goldelico.com>
In-Reply-To: <cover.1568224032.git.hns@goldelico.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Fri, 8 Nov 2019 14:08:29 -0600
Message-ID: <CAHCN7xLvuj_LkvOV3YG5=0MZYsohbQArE0UCZx6pcRPwM5pkYg@mail.gmail.com>
Subject: Re: [PATCH v3 0/8] OMAP3: convert opp-v1 to opp-v2 and read speed
 binned / 720MHz grade bits
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     =?UTF-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?Q?Andr=C3=A9_Roth?= <neolynx@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Enric Balletbo i Serra <eballetbo@gmail.com>,
        Javier Martinez Canillas <javier@dowhile0.org>,
        Roger Quadros <rogerq@ti.com>,
        Teresa Remmet <t.remmet@phytec.de>,
        Linux-OMAP <linux-omap@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pm@vger.kernel.org,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>, kernel@pyra-handheld.com,
        arm-soc <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Sep 11, 2019 at 12:47 PM H. Nikolaus Schaller <hns@goldelico.com> wrote:
>
> CHANGES V3:
> * make omap36xx control the abb-ldo and properly switch mode
>   (suggested by Adam Ford <aford173@gmail.com>)
> * add a note about enabling the turbo-mode OPPs
>
> PATCH V2 2019-09-07 19:46:58:
> * fix ti-cpufreq to properly describe which compatible string is legacy
> * add some reviewed-by and acked-by Tony Lindgren <tony@atomide.com>
> * include am3517 patches by Adam Ford <aford173@gmail.com>
> * review opp-suspend; and add turbo-mode; opp properties
> * add a note how to disable an OPP in a board.dts file
>
> PATCH V1 2019-09-07 08:56:19:
> * fix typo in omap3-ldp.dts
>   (reported by Tony Lindgren <tony@atomide.com>)
> * extend commit message to describe the bit patterns needed
>   for opp-supported-hw
> * add error check to ioremap()
>   (suggested by Christ van Willegen <cvwillegen@gmail.com>)
> * update Documentation/devicetree/bindings/arm/omap/omap.txt
> * change bulk update to use "ti,omap3430" and "ti,omap3630"
> * update OPP4 of omap3430 to 1275 mV since it was not a valid
>   voltage for the twl4030 driver (reported by Tony Lindgren
>   <tony@atomide.com>)
>
> RFC V2 2019-09-04 10:53:43:
> * merge separate patch to remove opp-v1 table from n950-n9 into
>   the general omap3xxx.dtsi patch
>   (suggested by Viresh Kumar <viresh.kumar@linaro.org>)
> * add legacy compatibility to ti,omap3430 and ti,omap3630 for
>   the ti-cpufreq driver
> * make driver and omap3xxx.dtsi patches pass checkpatch
> * add bulk patch to explicitly define compatibility to ti,omap3430
>   and ti,omap36xx in addition to ti,omap3 of all in-tree boards
>   where it was missing
>
> RFC V1 2019-09-02 12:55:55:
>
> This patch set converts the omap3 opp tables to opp-v2 format
> and extends the ti-cpufreq to support omap3.
>
> It adds 720 MHz (omap34xx) and 1 GHz (omap36xx) OPPs but
> tells the ti-cpufreq driver to disable them if the speed
> binned / 720MHz grade eFuse bits indicate that the chip
> is not rated for that speed.
>
> It has been tested (for chip variant detection, not reliability
> of the high speed OPPs) on:
>
> * BeagleBoard C2 (omap3530 600MHz)
> * BeagleBoard XM B (dm3730 800MHz)
> * GTA04A4 (dm3730 800MHz)
> * GTA04A5 (dm3730 1GHz)
>
>
> Adam Ford (2):
>   cpufreq: ti-cpufreq: Add support for AM3517
>   ARM: dts: Add OPP-V2 table for AM3517
>

Nikolaus,

I am getting some notices sent to me when I apply your series.  It
works, but I want to clean up the notice.  Can you suggest what might
cause this:

     debugfs: Directory 'cpu0-cpu0' with parent
'48070000.i2c:twl@48:regulator-vdd1-VDD1' already present!

It wasn't present before your series.  It's not a big deal, but I'd
like to quiet down the messages if I can.
Thanks.

adam

> H. Nikolaus Schaller (6):
>   cpufreq: ti-cpufreq: add support for omap34xx and omap36xx
>   ARM: dts: omap34xx & omap36xx: replace opp-v1 tables by opp-v2 for
>   DTS: bindings: omap: update bindings documentation
>   ARM: dts: omap3: bulk convert compatible to be explicitly ti,omap3430
>     or ti,omap3630 or ti,am3517
>   cpufreq: ti-cpufreq: omap36xx use "cpu0","vbb" if run in
>     multi_regulator mode
>   ARM: dts: omap36xx: using OPP1G needs to control the abb_ldo
>
>  .../devicetree/bindings/arm/omap/omap.txt     |  30 +++--
>  .../bindings/cpufreq/ti-cpufreq.txt           |   6 +-
>  arch/arm/boot/dts/am3517.dtsi                 |  31 +++++
>  arch/arm/boot/dts/am3517_mt_ventoux.dts       |   2 +-
>  .../boot/dts/logicpd-som-lv-35xx-devkit.dts   |   2 +-
>  .../boot/dts/logicpd-torpedo-35xx-devkit.dts  |   2 +-
>  arch/arm/boot/dts/omap3-beagle-xm.dts         |   2 +-
>  arch/arm/boot/dts/omap3-beagle.dts            |   2 +-
>  arch/arm/boot/dts/omap3-cm-t3530.dts          |   2 +-
>  arch/arm/boot/dts/omap3-cm-t3730.dts          |   2 +-
>  arch/arm/boot/dts/omap3-devkit8000-lcd43.dts  |   2 +-
>  arch/arm/boot/dts/omap3-devkit8000-lcd70.dts  |   2 +-
>  arch/arm/boot/dts/omap3-devkit8000.dts        |   2 +-
>  arch/arm/boot/dts/omap3-gta04.dtsi            |   2 +-
>  arch/arm/boot/dts/omap3-ha-lcd.dts            |   2 +-
>  arch/arm/boot/dts/omap3-ha.dts                |   2 +-
>  arch/arm/boot/dts/omap3-igep0020-rev-f.dts    |   2 +-
>  arch/arm/boot/dts/omap3-igep0020.dts          |   2 +-
>  arch/arm/boot/dts/omap3-igep0030-rev-g.dts    |   2 +-
>  arch/arm/boot/dts/omap3-igep0030.dts          |   2 +-
>  arch/arm/boot/dts/omap3-ldp.dts               |   2 +-
>  arch/arm/boot/dts/omap3-lilly-a83x.dtsi       |   2 +-
>  arch/arm/boot/dts/omap3-lilly-dbb056.dts      |   2 +-
>  arch/arm/boot/dts/omap3-n9.dts                |   2 +-
>  arch/arm/boot/dts/omap3-n950-n9.dtsi          |   7 --
>  arch/arm/boot/dts/omap3-n950.dts              |   2 +-
>  .../arm/boot/dts/omap3-overo-storm-alto35.dts |   2 +-
>  .../boot/dts/omap3-overo-storm-chestnut43.dts |   2 +-
>  .../boot/dts/omap3-overo-storm-gallop43.dts   |   2 +-
>  .../arm/boot/dts/omap3-overo-storm-palo35.dts |   2 +-
>  .../arm/boot/dts/omap3-overo-storm-palo43.dts |   2 +-
>  .../arm/boot/dts/omap3-overo-storm-summit.dts |   2 +-
>  arch/arm/boot/dts/omap3-overo-storm-tobi.dts  |   2 +-
>  .../boot/dts/omap3-overo-storm-tobiduo.dts    |   2 +-
>  arch/arm/boot/dts/omap3-pandora-1ghz.dts      |   2 +-
>  arch/arm/boot/dts/omap3-sbc-t3530.dts         |   2 +-
>  arch/arm/boot/dts/omap3-sbc-t3730.dts         |   2 +-
>  arch/arm/boot/dts/omap3-sniper.dts            |   2 +-
>  arch/arm/boot/dts/omap3-thunder.dts           |   2 +-
>  arch/arm/boot/dts/omap3-zoom3.dts             |   2 +-
>  arch/arm/boot/dts/omap3430-sdp.dts            |   2 +-
>  arch/arm/boot/dts/omap34xx.dtsi               |  66 ++++++++--
>  arch/arm/boot/dts/omap36xx.dtsi               |  65 ++++++++--
>  drivers/cpufreq/cpufreq-dt-platdev.c          |   2 +-
>  drivers/cpufreq/ti-cpufreq.c                  | 119 +++++++++++++++++-
>  45 files changed, 320 insertions(+), 80 deletions(-)
>
> --
> 2.19.1
>
