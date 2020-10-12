Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1111128BB6A
	for <lists+linux-pm@lfdr.de>; Mon, 12 Oct 2020 16:55:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729021AbgJLOzr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 12 Oct 2020 10:55:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728269AbgJLOzr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 12 Oct 2020 10:55:47 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99C1AC0613D0
        for <linux-pm@vger.kernel.org>; Mon, 12 Oct 2020 07:55:46 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id g7so17836830iov.13
        for <linux-pm@vger.kernel.org>; Mon, 12 Oct 2020 07:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mail-tau-ac-il.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4/obfqdeqp7VFVq7DZZt7U3+2LbsV41W+FHelr8R4s4=;
        b=Mt3bMFU6SdkDzJeTbnFLjMHQ3ERf1MeuYd9N748Dm/1hmwRTaQwvRUc67qJz4JLz31
         X0ITS2TXOUbXPfSqVydOsfRH1h9YenOqziaEXpvq/KnahIfjitK/0ZwEmu4U2OPTbTWB
         UyAWCfehT/ejKPaAQv0RTIfE9AZpX0jli/jNJzsTzkuyfGjRhRF6EWEz/goajYgi2J5d
         nc0+9HBgyz+/DRdvEDTSBaVgg/3R/HJYn4OZt4EZMoTilo3JIGmeLKHLMQ+06D8GTreq
         ZiiLe+PYIokVfjjn2RTO9+iY9/x+i60nRxnUIKLmIWoyBXRklo3JP91oPHbaWlujCA/3
         SWkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4/obfqdeqp7VFVq7DZZt7U3+2LbsV41W+FHelr8R4s4=;
        b=VepUtkkEfqCQxh5O98fYkWQmMPWDdBVNmQWQX5gR4tMyCnx3StZT27Va2w+Gvx25us
         wy+PYhtw9AbaHhluNF1FvbM0Wsc1ioKuo5hYJPb78AMV1h+VgsSbhIe/atJSEZ5LqlwO
         8bWsi8gAOHENWXJr5a1b9Ugke4AoJmXyZsqia22fT7ugm6vnNKNYmXM9QFp1EeieiAkb
         PRZAThcTTfg8h8gw91gu9Ow2H5N3w6UVg4Obr4329XmDleygfqqijoJYzVp6BV+TISd+
         MwnoSSgKFxY/vzUdphKV4Qy86SdBppYg159KJFVWtZNgA35oEVD8vhewLgmPuY9gKMp3
         xFOQ==
X-Gm-Message-State: AOAM532n9Yo1KPvVg5BnnO3NpR3iTf0qnAV6ZcdY10DtG/6sZkeNujSh
        lzFaLeuymAJgetgu9QJehUyTewrYENmCuywrzYlW+uAHFB5WXw==
X-Google-Smtp-Source: ABdhPJwRTWTke103lYM+L9lZJqIuM6fYw/X3bavbCkPGWpUSsuFnZPHinO1pPCpdxaayDGjisSzTpdV4StazG+cPj6A=
X-Received: by 2002:a6b:e51a:: with SMTP id y26mr16997840ioc.86.1602514545472;
 Mon, 12 Oct 2020 07:55:45 -0700 (PDT)
MIME-Version: 1.0
References: <CANO065DUbjm30Q2sw0-zSd-f68bx5NG63QtXdjCkdqAYkMJwOg@mail.gmail.com>
In-Reply-To: <CANO065DUbjm30Q2sw0-zSd-f68bx5NG63QtXdjCkdqAYkMJwOg@mail.gmail.com>
From:   Ofir Cohen <ofirc1@mail.tau.ac.il>
Date:   Mon, 12 Oct 2020 17:55:34 +0300
Message-ID: <CANO065BQ+e4AWFzN09w+i0yZGg4rt0qYfAfWnjPKn9gThyrWTA@mail.gmail.com>
Subject: Re: Debugging why QCOM ARM msm8909w doesn't enter sleep mode?
To:     linux-pm@vger.kernel.org
Cc:     Ofir Cohen <ofirc1@mail.tau.ac.il>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Ping.
Does anyone have a clue why my msm8909w Qualcomm ARM SoC won't enter
sleep (suspended) mode?

I see these prints in ftrace:
              sh-900   [000] d..1   944.600557: suspend_resume:
machine_suspend[3] begin
              sh-900   [000] d..2   944.600557: cluster_enter:
cluster_name:system idx:2 sync:0xf child:0xf idle:0
              sh-900   [000] d..2   944.600557: pre_pc_cb: tzflag:3
              sh-900   [000] d..2   944.600557: cluster_exit:
cluster_name:system idx:2 sync:0xe child:0xf idle:0
              sh-900   [000] d..1   944.600557: suspend_resume:
machine_suspend[3] end

and these types of wakeup sources:
           <...>-304   [003] d..2   926.163454:
wakeup_source_activate: modem_IPCRTR state=3D0x68c0002
    kworker/u8:7-2166  [003] d..2   926.163513:
wakeup_source_activate: ipc00000055_Loc state=3D0x68d0002
           <...>-304   [003] d..2   926.163578:
wakeup_source_activate: modem_IPCRTR state=3D0x68d0003
...
  irq/246-qcom,s-35    [003] d..4   930.888106:
wakeup_source_activate: SMD_TTY_APPS_RIVA_BT_CMD_RA state=3D0x6910003
  irq/246-qcom,s-35    [003] d..3   930.888117: softirq_raise: vec=3D0 [act=
ion=3DHI]
  irq/246-qcom,s-35    [003] ..s2   930.888151: softirq_entry: vec=3D0 [act=
ion=3DHI]
  irq/246-qcom,s-35    [003] d.s3   930.888172:
wakeup_source_activate: APPS_RIVA_BT_CMD state=3D0x6910004
...

and would love to know how to disable them.

Thanks,
Ofir


On Wed, Oct 7, 2020 at 4:23 PM Ofir Cohen <ofirc1@mail.tau.ac.il> wrote:
>
> Hello,
> I'm trying to get my Qualcomm msm8909w SoC [1] to enter sleep (to ram)
> state but I fail, need your advice on why it would fail / wakeup
> continuously.
>
>
> -----------
> Problem
> -----------
> No matter how hard I try it either:
> * Keeps waking up shortly after it goes to suspend mode
> (suspend_ops->enter(state)), or
> * It doesn't enter sleep mode at all.
>
> This is what you see from ftrace:
> from ftrace (/sys/kernel/debug/tracing/trace):
>               sh-2073  [001] d..1 23035.549297: suspend_resume:
> machine_suspend[3] begin
>               sh-2073  [001] d..1 23035.549297: suspend_resume:
> machine_suspend[3] end
>
> Notice no diff in the timestamp, the suspend_ops->enter should have
> blocked indefinitely until the next real interrupt arrives (e.g.
> keyboard event / network event / power button press).
>
> It's hard to tell the reason why, really. The only thing I have is the
> ftrace traces (more on that at the bottom of the thread).
>
> Since you won't find a call to WFI ARM instruction to sleep, and the
> sleep is managed by Qualcomm's proprietary closed firmware blob, I
> could really use some advice here from ARM / QCOM people on tracing
> the culprit that keeps the SoC awake.
>
> -------------------------
> SoC + repo details
> -------------------------
> The SoC is msm8909w [1] and I=E2=80=99m using a forked tree of AOSP of An=
droid
> 8.0 (Oreo) [2] with some Qualcomm patches rebased on top (I can
> provide them if needed).
>
> The recipe below will roughly (due to some QCOM/Intrinsyc patches
> rebased on top) get you with the exact code that I'm using:
>
> repo init -q -u git://codeaurora.org/platform/manifest.git -b release
> -m LAW.BR.3.0-12700-8x09w.0.xml
> repo sync -q -c -j $(nproc) --no-tags --no-clone-bundle
>
> Or if you want just the Linux kernel tree:
> git clone https://source.codeaurora.org/quic/la/kernel/msm-3.18
> git checkout 67e59f18c2e
>
> -------------------
> Kernel version
> -------------------
> Beware, it is very old (but this is what the OEM provided me):
> msm8909w:/ # uname -a
> Linux localhost 3.18.107-gcd5254c5d3a-dirty #11 SMP PREEMPT Tue Oct 6
> 19:39:06 IDT 2020 armv7l
> msm8909w:/ #
>
> -------------
> My setup
> -------------
> * A Windows machine connected via PuTTY to the UART serial console
> (COM13) over USB
> * Same Windows machine connected to the ADB port over USB and uses adb
> (Android bridge) to manage the device.
>
> ----------
> My flow
> ----------
> * Disable all wakeup source events
>   Reason: the vanilla setup doesn't enter sleep so I thought let's
> disable whatever can wake up the board.
>
>    find /sys/devices/ -name '*wakeup*'
>    and for each device:
>    echo disabled > /sys/devices/.../device/wakeup
>
> * Unplug USB ADB cable from the board
>    Reason: we don't want the msm USB-OTG driver to prevent the platform f=
rom
>    sleeping (it should enter LPM).
>
> * Keep the UART serial (over USB) connected for tracing
>
> * Force the device into sleep (from the COM13 console)
>    echo mem > /sys/power/state
>
>
> Expected: the board will enter deep sleep until the next real event
>           (e.g. keyboard event, network event, power button press event) =
occurs.
>
> Actual: the board *resumes from sleep promptly*, or doesn't enter sleep a=
t all
>         (evident from the zero diff timestamps between machine_suspend
> begin and end).
>
>
> -------------
> Call stack
> -------------
> #-1 arm_proprietary_secure_firmware()
>     Here we are in the "ARM Secure Zone" with a proprietary closed firmwa=
re blob
>     that is supposed to drive the core to a deep sleep.
>     I'm guessing that under the hood it should call:
>     wfi // for each core sleep mode
>
> #0 scm_call_atomic1 (scm.c), (called with SCM_SVC_BOOT,
> SCM_CMD_TERMINATE_PC, flag)
> #1 msm_pm_collapse (msm-pm.c)
> #2 __cpu_suspend_enter (sleep.S)
> #3 __cpu_suspend (suspend.c)
> #4 msm_pm_spm_power_collapse (msm-pm.c)
> #5 msm_pm_power_collapse (msm-pm.c), (called with mode =3D=3D
> MSM_PM_SLEEP_MODE_POWER_COLLAPSE)
> #6 msm_cpu_pm_enter_sleep (msm-pm.c)
> #7 lpm_suspend_enter (lpm-levels.c)
> #8 suspend_enter (suspend.c) (called with PM_SUSPEND_MEM)
>
>
>
> Appreciate your input.
>
>
> Thanks,
> Ofir
>
>
> [1] https://www.qualcomm.com/products/snapdragon-processors-wear-2100
> [2] https://developer.android.com/about/versions/oreo
