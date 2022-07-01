Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1E3356399B
	for <lists+linux-pm@lfdr.de>; Fri,  1 Jul 2022 21:14:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231430AbiGATN4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 1 Jul 2022 15:13:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbiGATNz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 1 Jul 2022 15:13:55 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B154B2B1A3
        for <linux-pm@vger.kernel.org>; Fri,  1 Jul 2022 12:13:53 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id g4so5605372ybg.9
        for <linux-pm@vger.kernel.org>; Fri, 01 Jul 2022 12:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0QS+dcPV5O8kLzr2+REcEkzxVnC/iy1E7v+r8knheu0=;
        b=YxJMJqn/vOk+95wW9H3XyxhU7b6ot8wJfR5j/hJXXANi9ACWI8OWpYLc7idqKtR70V
         I3f03mBuDThOJwgTtewRvSXUMPEEQyG2ilkW3LrxcIy7/7G+z/lvGEKEHqAw36hYhA+D
         6ECYWOChAVa+UxOkE+iS+daPXf69U0SflOW9HtDhl9SR2FAyXKxcYvKm3CgyTVMStMHC
         d3loWbDJUvP5cApZmY9sk39gsPipm7VWUwXpJ6tYDGtPK2MW5LBo5X+RScgoYXv7fbLo
         O9phoX29OCjJ0I+QGlNLfK3+Itz44Me8/dSf5Psw1rGo4PvdspD0oJiqYd3r+D2c9F2x
         uSLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0QS+dcPV5O8kLzr2+REcEkzxVnC/iy1E7v+r8knheu0=;
        b=BGGs46b+W3oy3w2M/7IvsGf9kBN4LKgV6h5TUcl8HMH5Pb5GCE5PkM8JAlvz3GNt94
         4+bO6FnLaXsrdz1io5kz5eJiOuDSIglK8d9Nmynf6R84BpMpXlGpRsk8f/4ceWZ9b2ap
         BZsQ9YMYFxgvnNoBPpzjqSPhEbUKoe4kHaxm0FtqMyhuI9BBB9XE3vNHrw32dOgdkzsy
         yNRHNLnK8OyRrnBr4BlnNFFBuwvitMMZmZXAbB8pbfdJXsGy6/JdfhfKp4cpwQg4LBsl
         bGqoGdry2CdmXg1DSnko4ozBVORojqXZ18muiR2jBJDbluGnxbGyynBvIULeLVaUFxY7
         nzdQ==
X-Gm-Message-State: AJIora/jMbju06LVuq6CHWz9Vho62ywzqXFngmEMhu/plpTv+WTmE1rF
        pnvzDw7CURVkGGcFxUmJALqfjVT3DSAj15pSJQKoJA==
X-Google-Smtp-Source: AGRyM1tQv6CCDFx3u07LEvOjaGIhnXAU5l72oCC5MmwYKS+JqS6dGPS426l3v4HvKqgb/fUO3PdDTLb3hZ+49n67IRs=
X-Received: by 2002:a25:5bc3:0:b0:669:b722:beb8 with SMTP id
 p186-20020a255bc3000000b00669b722beb8mr16783331ybb.447.1656702832727; Fri, 01
 Jul 2022 12:13:52 -0700 (PDT)
MIME-Version: 1.0
References: <YrQP3OZbe8aCQxKU@atomide.com> <CAGETcx9aFBzMcuOiTAEy5SJyWw3UfajZ8DVQfW2DGmzzDabZVg@mail.gmail.com>
 <Yrlz/P6Un2fACG98@atomide.com> <CAGETcx8c+P0r6ARmhv+ERaz9zAGBOVJQu3bSDXELBycEGfkYQw@mail.gmail.com>
 <CAL_JsqJd3J6k6pRar7CkHVaaPbY7jqvzAePd8rVDisRV-dLLtg@mail.gmail.com>
 <CAGETcx9ZmeTyP1sJCFZ9pBbMyXeifQFohFvWN3aBPx0sSOJ2VA@mail.gmail.com>
 <Yr6HQOtS4ctUYm9m@atomide.com> <Yr6QUzdoFWv/eAI6@atomide.com>
 <CAGETcx-0bStPx8sF3BtcJFiu74NwiB0btTQ+xx_B=8B37TEb8w@mail.gmail.com>
 <CAGETcx-Yp2JKgCNfaGD0SzZg9F2Xnu8A3zXmV5=WX1hY7uR=0g@mail.gmail.com> <20220701150848.75eeprptmb5beip7@bogus>
In-Reply-To: <20220701150848.75eeprptmb5beip7@bogus>
From:   Saravana Kannan <saravanak@google.com>
Date:   Fri, 1 Jul 2022 12:13:16 -0700
Message-ID: <CAGETcx_Y-9WBeRwf22v3NSuY8PGpPrTxtx_uBqe_Q7rD6mEQMQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/9] PM: domains: Delete usage of driver_deferred_probe_check_state()
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Tony Lindgren <tony@atomide.com>, Rob Herring <robh@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        David Ahern <dsahern@kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        Linux IOMMU <iommu@lists.linux-foundation.org>,
        netdev <netdev@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Alexander Stein <alexander.stein@ew.tq-group.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Jul 1, 2022 at 8:08 AM Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> Hi, Saravana,
>
> On Fri, Jul 01, 2022 at 01:26:12AM -0700, Saravana Kannan wrote:
>
> [...]
>
> > Can you check if this hack helps? If so, then I can think about
> > whether we can pick it up without breaking everything else. Copy-paste
> > tab mess up warning.
>
> Sorry for jumping in late and not even sure if this is right thread.
> I have not bisected anything yet, but I am seeing issues on my Juno R2
> with SCMI enabled power domains and Coresight AMBA devices.
>
> OF: amba_device_add() failed (-19) for /etf@20010000
> OF: amba_device_add() failed (-19) for /tpiu@20030000
> OF: amba_device_add() failed (-19) for /funnel@20040000
> OF: amba_device_add() failed (-19) for /etr@20070000
> OF: amba_device_add() failed (-19) for /stm@20100000
> OF: amba_device_add() failed (-19) for /replicator@20120000
> OF: amba_device_add() failed (-19) for /cpu-debug@22010000
> OF: amba_device_add() failed (-19) for /etm@22040000
> OF: amba_device_add() failed (-19) for /cti@22020000
> OF: amba_device_add() failed (-19) for /funnel@220c0000
> OF: amba_device_add() failed (-19) for /cpu-debug@22110000
> OF: amba_device_add() failed (-19) for /etm@22140000
> OF: amba_device_add() failed (-19) for /cti@22120000
> OF: amba_device_add() failed (-19) for /cpu-debug@23010000
> OF: amba_device_add() failed (-19) for /etm@23040000
> OF: amba_device_add() failed (-19) for /cti@23020000
> OF: amba_device_add() failed (-19) for /funnel@230c0000
> OF: amba_device_add() failed (-19) for /cpu-debug@23110000
> OF: amba_device_add() failed (-19) for /etm@23140000
> OF: amba_device_add() failed (-19) for /cti@23120000
> OF: amba_device_add() failed (-19) for /cpu-debug@23210000
> OF: amba_device_add() failed (-19) for /etm@23240000
> OF: amba_device_add() failed (-19) for /cti@23220000
> OF: amba_device_add() failed (-19) for /cpu-debug@23310000
> OF: amba_device_add() failed (-19) for /etm@23340000
> OF: amba_device_add() failed (-19) for /cti@23320000
> OF: amba_device_add() failed (-19) for /cti@20020000
> OF: amba_device_add() failed (-19) for /cti@20110000
> OF: amba_device_add() failed (-19) for /funnel@20130000
> OF: amba_device_add() failed (-19) for /etf@20140000
> OF: amba_device_add() failed (-19) for /funnel@20150000
> OF: amba_device_add() failed (-19) for /cti@20160000
>
> These are working fine with deferred probe in the mainline.
> I tried the hack you have suggested here(rather Tony's version),

Thanks for trying that.

> also
> tried with fw_devlink=0 and fw_devlink=1

0 and 1 aren't valid input to fw_devlink. But yeah, I don't expect
disabling it to make anything better.

> && fw_devlink.strict=0
> No change in the behaviour.
>
> The DTS are in arch/arm64/boot/dts/arm/juno-*-scmi.dts and there
> coresight devices are mostly in juno-cs-r1r2.dtsi

Thanks

> Let me know if there is anything obvious or you want me to bisect which
> means I need more time. I can do that next week.

I'll let you know once I poke at the DTS. We need to figure out why
fw_devlink wasn't blocking these from getting to the error (same as in
Tony's case). But since these are amba devices, I think I have some
guesses.

This is an old series that had some issues in some cases and I haven't
gotten around to looking at it. You can give that a shot if you can
apply it to a recent tree.
https://lore.kernel.org/lkml/20210304195101.3843496-1-saravanak@google.com/

After looking at that old patch again, I think I know what's going on.
For normal devices, the pm domain attach happens AFTER the device is
added and fw_devlink has had a chance to set up device links. And if
the suppliers aren't ready, really_probe() won't get as far as
dev_pm_domain_attach(). But for amba, the clock and pm domain
suppliers are "grabbed" before adding the device.

So with that old patch + always returning -EPROBE_DEFER in
amba_device_add() if amba_read_periphid() fails should fix your issue.

-Saravana
