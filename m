Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4DF360DE11
	for <lists+linux-pm@lfdr.de>; Wed, 26 Oct 2022 11:29:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbiJZJ34 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 26 Oct 2022 05:29:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232844AbiJZJ3z (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 26 Oct 2022 05:29:55 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D25A3868D
        for <linux-pm@vger.kernel.org>; Wed, 26 Oct 2022 02:29:53 -0700 (PDT)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1oncjM-0003K0-Ax; Wed, 26 Oct 2022 11:29:48 +0200
Message-ID: <9e747f87-1854-dbd7-ef3a-1effc2b90e3b@leemhuis.info>
Date:   Wed, 26 Oct 2022 11:29:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: Regression after recent changes to drivers/thermal/thermal_of.c
 #forregzbot
Content-Language: en-US, de-DE
Cc:     Linux PM list <linux-pm@vger.kernel.org>
References: <CACRpkdbB5hgkrPZVb-+9tuKErvwjTKNaBQ1LvH1==fR7bndjSQ@mail.gmail.com>
To:     "regressions@lists.linux.dev" <regressions@lists.linux.dev>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <CACRpkdbB5hgkrPZVb-+9tuKErvwjTKNaBQ1LvH1==fR7bndjSQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1666776593;f23cd270;
X-HE-SMSGID: 1oncjM-0003K0-Ax
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

[Note: this mail is primarily send for documentation purposes and/or for
regzbot, my Linux kernel regression tracking bot. That's why I removed
most or all folks from the list of recipients, but left any that looked
like a mailing lists. These mails usually contain '#forregzbot' in the
subject, to make them easy to spot and filter out.]

[TLDR: I'm adding this regression report to the list of tracked
regressions; all text from me you find below is based on a few templates
paragraphs you might have encountered already already in similar form.]

Hi, this is your Linux kernel regression tracker.

On 25.10.22 23:13, Linus Walleij wrote:
> Hi Folks,
> 
> I have this in my dmesg in v6.1-rc1:
> 
> [    3.879229] ab8500-fg ab8500-fg.0: line impedance: 36000 uOhm
> [    3.892793] power_supply ab8500_usb: Samsung SDI EB-L1M7FLU battery 1500 mAh
> [    3.901663] thermal_sys: Failed to find 'trips' node
> [    3.906635] thermal_sys: Failed to find trip points for thermistor id=0
> [    3.913427] ntc-thermistor thermistor: unable to register as hwmon device.
> [    3.920350] ntc-thermistor: probe of thermistor failed with error -22
> 
> The device tree looks like this
> (arch/arm/boot/dts/ste-ux500-samsung-golden.dts):
> 
>         thermal-zones {
>                 battery-thermal {
>                         /* This zone will be polled by the battery
> temperature code */
>                         polling-delay = <0>;
>                         polling-delay-passive = <0>;
>                         thermal-sensors = <&bat_therm>;
>                 };
>         };
> 
> This is a thermal zone without trip points, which it seems like the new
> code does not allow, also the bindings were patched to not allow this,
> in commit 8c596324232d22e19f8df59ba03410b9b5b0f3d7
> "dt-bindings: thermal: Fix missing required property"
> but this broke my systems. The requirement to have trip points also
> broke my device trees.
> [...]

Thanks for the report. To be sure below issue doesn't fall through the
cracks unnoticed, I'm adding it to regzbot, my Linux kernel regression
tracking bot:

#regzbot ^introduced 8c596324232d22e19f
#regzbot title dt-bindings: thermal: thermal zone without trip points broke
#regzbot ignore-activity

This isn't a regression? This issue or a fix for it are already
discussed somewhere else? It was fixed already? You want to clarify when
the regression started to happen? Or point out I got the title or
something else totally wrong? Then just reply -- ideally with also
telling regzbot about it, as explained here:
https://linux-regtracking.leemhuis.info/tracked-regression/

Reminder for developers: When fixing the issue, add 'Link:' tags
pointing to the report (the mail this one replies to), as explained for
in the Linux kernel's documentation; above webpage explains why this is
important for tracked regressions.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)

P.S.: As the Linux kernel's regression tracker I deal with a lot of
reports and sometimes miss something important when writing mails like
this. If that's the case here, don't hesitate to tell me in a public
reply, it's in everyone's interest to set the public record straight.
