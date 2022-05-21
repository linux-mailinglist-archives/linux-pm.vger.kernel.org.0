Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C51E52FFB9
	for <lists+linux-pm@lfdr.de>; Sun, 22 May 2022 00:14:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240017AbiEUWOD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 21 May 2022 18:14:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238709AbiEUWOC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 21 May 2022 18:14:02 -0400
Received: from mail-4022.proton.ch (mail-4022.proton.ch [185.70.40.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA72045079
        for <linux-pm@vger.kernel.org>; Sat, 21 May 2022 15:13:59 -0700 (PDT)
Date:   Sat, 21 May 2022 22:13:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dannyvanheumen.nl;
        s=protonmail2; t=1653171236; x=1653430436;
        bh=4JAE9Oh0BY8oENb13W30eF423VDoDH5ZFiVTrk4dLD4=;
        h=Date:To:From:Reply-To:Subject:Message-ID:Feedback-ID:From:To:Cc:
         Date:Subject:Reply-To:Feedback-ID:Message-ID;
        b=vPBcyKLISk6cGBiK9yoZhtxGyyfuryfR47hIs6BHQG3AXfyS8ek7Ml4o7+H7/cCdm
         R+cglZ2h3SPNtBKKCyRJdaZQQUREBOmz1N2K07ZpNNCSFxFRMm05zm19uhfnsq4bAl
         /oW04Rls8JQ7NSN+qu5L2BUm6kJWwOOqf8f4Kje+LMBxvkpdB1e3ZsVCxTDxLz7r/k
         fN/uOTpGa5VLHYeLm+wAJ1C0FQ5f0b4glglGuLvFqtxS3IHb7TbvUXwx4Z/3qi5Ojc
         LByeGwpBBmrl1Q//CjIkONY/5XX5I5WHRbzYxf0Ebv76WzDA3Qh9bDKT6zIkZdGcKy
         RsVDd2HJ7eKlw==
To:     =?utf-8?Q?=E2=80=9CRafael_J=2E_Wysocki=E2=80=9D?= 
        <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
From:   Danny van Heumen <danny@dannyvanheumen.nl>
Reply-To: Danny van Heumen <danny@dannyvanheumen.nl>
Subject: 'schedutil' (possibly) aberrant behavior surrounding suspend/resume process (timing/delay/run-away CPU issues)
Message-ID: <R6AlCxZca3GET8vtwpOAkzQ4Y9SX-NOVQ05FlJAKDUvNTYCAhsWy1e0q5soCkapaviI8SS-9eC51nwJj6yn6n1rFAlwndEqYqlr_hqz4C_U=@dannyvanheumen.nl>
Feedback-ID: 15073070:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi all,

This is my first report directly to linux kernel mailing lists. I'll do my =
best, but I'll invariably make some mistakes. This bug report is based on "=
educated" guessing, some insight and intuition, so I will do my best to exp=
lain all the curiosities and why I blame `schedutil`. To clarify, I seems b=
ehavior of schedutil triggers issues elsewhere.

I write the message not to say "this is the problem, fix it!" but rather, I=
 hope to check with you if you recognize potential things to look for, *if =
the reports make any sense*.

## short summary

On multiple computers, with kernel builds from distros and also vanilla cus=
tom (minimal) config builds by myself, I have had a number of issues that a=
ll center around suspend/resume with 'schedutil' scaling governor active. S=
ome issues seem to be explained by other causes/bug-reports, but I report t=
his here because `schedutil` is a common denominator.

Characteristics:
- Kabylake, upon suspend, problems with going into suspend, with "runaway p=
rocessor" behavior starting to run at full power causing excessive build-up=
 of heat. (intel_pstate=3Dpassive) (more details follow ...)
- Haswell laptop, upon suspend, sometimes does not suspend, instead screen =
off but then returned to active.
- Pinebook Pro: upon resume from suspend (s2idle, I'm fairly certain): prob=
lems getting "display panel up in time", "eMMC/SDIO failing to initialize",=
 screen-flickering from excessive refreshing many times the blinking rate. =
(more details follow ...)

These issues start to happen upon suspend. The issues do not happen when `s=
chedutil` is not involved.

My interpretation: somewhere just before, or just after entering suspend-st=
ate/initiating restore, `schedutil` messes up something w.r.t. timings: tim=
ings/delays/repeats happen at many times the intended speed.

## `schedutil` before suspend: all good

I have been using `schedutil` for many months. Upon normal operations there=
 never seem to be any issues, or unexpected events. What I describe all hap=
pens centered around the suspension-process, and sometimes as consequence a=
fterwards.

## Pinebook Pro issues

- original Debian kernel,
- custom-built kernel with very minimal config: versions 5.15.{38,39,41} 5.=
17.9
- `schedutil` cpufreq scaling governor
- Debian bullseye (original, no third-party kernels), up-to-date install
- no tlp, manual suspend procedure (either button- or lid-triggered)

The Pinebook Pro does not exhibit issues (AFAICT) upon entering suspend. Ho=
wever, resume will fail often, but not always. I have seen different sympto=
ms exhibited:

1.) 3-line error message regarding analogix_dp_resume about rockchip-module=
 not succeeding (through analogix) to re-initialize the display panel in ti=
me. (It shows on that exact display panel, so clearly it worked.)
Those 3 lines of error message, are being refreshed at many times the neces=
sary rate. The excessive refreshing interferes with the ability to switch t=
erminals (TTY1, TTY2, etc.), because I see a "single frame blink" of the te=
rminal and then gets overridden with the 3-line error message again. Same h=
olds for switch to GUI DISPLAY terminal. Display does not have sufficient t=
ime to refresh and ends up with variations of extra long DPMS-off state bef=
ore returning to the error-message-screen.
Sometimes I am able to "interrupt" this excessive run-away behavior by keep=
ing e.g. CTRL+ALT+1 pressed such that it will try to switch TTY at "key-rep=
eat"-speed.

2.) error message regarding eMMC/SDIO issues. Similar to (1.) issue with fa=
iling to initialize eMMC and consequently I lose access to my persistent st=
orage.

3.) issue also occurs when entering sleep from prolonged idleness with lid =
already closed (DPMS off + locked) as starting-point.

[x.] Not sure if relevant at all: "crashes with wifi firmware". A buggy ear=
ly firmware version for a broadcom wifi chip would occasionally crash. Howe=
ver, in particular around the suspend process there would be issues.
I don't want to attribute this to schedutil, but maybe schedutil's behavior=
 significantly increases the chance of this happening.

NOTE: I tried switching back to 'ondemand' scheduler after first issues had=
 occurred with 'schedutil' active. However, reverting to 'ondemand' did not=
 resolve the outstanding issues at that point.

## Kabylake-laptop

- Distro-kernel (i.e. not vanilla)
- `intel_pstate=3Dpassive` kernel parameter
- `schedutil` as cpufreq scaling governor (udev-rule)

1.) Trigger suspend on the laptop. System goes into suspend state as expect=
ed. Then (in about 2 seconds) fans start spinning and apparently excessive =
heat is being produced. (This was reported somewhere already as being an is=
sue with PCH temp being too high, w.r.t. `S0ix` `intel_pch_thermal`.) Howev=
er, I suspect that high-temperature may be caused through `schedutil`, beca=
use the laptop did not run any intensive tasks of any kind. (idling)
Upon resuming, the laptop has lost significant amounts of battery, correspo=
nding with the excessive CPU usage and cooling fans.

## Haswell laptop

1.) Not much to say: enter suspend, find out later that it did not truly en=
ter suspend, but was kept back and is rather active.

## Without `schedutil`

In all cases, when taking schedutil out of the loop, these issues disappear=
. In case of the Kabylake laptop, I do set intel_pstate=3Dactive. All have =
`ondemand` governor. Suspend/resume works, repeated many times over. Even i=
f some errors are still shown, they no longer pose a problem. The excessive=
 screen blinking behavior is not exhibited, for example.

## Other things I have tried

As mentioned before, I have tried looking for other bugs. However, the issu=
es seem to be too persistent. I have tried removing all external devices, t=
ried using different USB ports, tried different suspend/resume settings in =
`/etc/systemd/sleep.conf`. Tried using 'tlp' package for additional power-m=
anagement tricks. Tried switching governors, ... and probably more.

I realize this bug report is far from perfect. I'm afraid I cannot make the=
 report much more exact/clear. I am happy to answer any questions you may h=
ave. I will keep an eye out for further peculiarities.

Regards,
Danny

PS: I hope I address this to the right maintainers. I checked here: https:/=
/docs.kernel.org/process/maintainers.html#cpu-frequency-scaling-framework
