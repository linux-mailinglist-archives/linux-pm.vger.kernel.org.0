Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F73C286004
	for <lists+linux-pm@lfdr.de>; Wed,  7 Oct 2020 15:24:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728323AbgJGNYD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 7 Oct 2020 09:24:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728271AbgJGNYD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 7 Oct 2020 09:24:03 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D949EC061755
        for <linux-pm@vger.kernel.org>; Wed,  7 Oct 2020 06:24:02 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id a23so2546864qkg.13
        for <linux-pm@vger.kernel.org>; Wed, 07 Oct 2020 06:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mail-tau-ac-il.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=DNkXUIo0UWmzX3XVaTT+6ANXiN8LoB4UdN6yPaOHlls=;
        b=wa42TSrsHSxH2TMyNoI2dTHuF5lsU/gT/TZEOTdetb1TEpXQ33/sRTi2hRr5W1UX1i
         D7HhJdaU0lnBSpkezDaJo4af5UxzNTsoLMEEcolTZUjKo9mLfvuNcNZTMw0hfClmKhXO
         pPmOmRLx9efZ6G2z9pHTWXkn9KkayMPzH/xA2h8WkIqRMVBvqtllHq8XEAmEkZxWZsyJ
         g5QnZblSqlH1coeNTDYZwDhz0S/eeVmkJ2LDLTJwuu2mk9W09Emiuh9yeTheoEOCJQbG
         HWJH+BtrZKxpXN4me6EfmwV+mBSQQBfgVoUExTHFB5layPJa4SXlMl0lZH1/rz9FYDNN
         R6gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=DNkXUIo0UWmzX3XVaTT+6ANXiN8LoB4UdN6yPaOHlls=;
        b=kIG594sn17qGBXfzuvjuhZjMyaPinu5Sn4wg8/wFRXULmTGBZvip+ydtVr5PdeqS9J
         3rFDmPMKGGDCCECkm39yxuCMNwZDtH+6gJbGvYCMT595n7UgNCRMrcvdz99qSdEW3Hyp
         N57LpI4BqvVKTjPxIf6PPdLVi5KyNo2MSOM/8QGqbo5ohs41V14EI6eGBBWfwxS7popP
         6TUdMUhHv/llgETUiuTNzr3YbVWefK8iD5zY4ZvnCSlrFFyf79FK5y3NSjAUujeY2YJY
         U8P6tdgHvUPwXPhYFu6MuH5S0bBT69G8jGs9puqGnDc1yy0eVYR+6vvd1fwF4UQ0OIJ0
         oFRw==
X-Gm-Message-State: AOAM531b3J0OR4CEn75CoFjhDrHo1E5M6DWOzv2+KT3Gc44LvYPaPW2R
        XRcs0O4kP6taYe3t/gzD6rT0RLVfc1E1Vb67TDO4zzZletVj3Q==
X-Google-Smtp-Source: ABdhPJxW7sBNb0r3Awiag2z/0Q0ouUCchuJQquujbGrprg2Tdl6BmD4vepgFKXHnN7I/VHGoQ/RA3gdDjP2/g635lN4=
X-Received: by 2002:a05:620a:22f2:: with SMTP id p18mr2921134qki.113.1602077041439;
 Wed, 07 Oct 2020 06:24:01 -0700 (PDT)
MIME-Version: 1.0
From:   Ofir Cohen <ofirc1@mail.tau.ac.il>
Date:   Wed, 7 Oct 2020 16:23:50 +0300
Message-ID: <CANO065DUbjm30Q2sw0-zSd-f68bx5NG63QtXdjCkdqAYkMJwOg@mail.gmail.com>
Subject: Debugging why QCOM ARM msm8909w doesn't enter sleep mode?
To:     linux-pm@vger.kernel.org
Cc:     Ofir Cohen <ofirc1@mail.tau.ac.il>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello,
I'm trying to get my Qualcomm msm8909w SoC [1] to enter sleep (to ram)
state but I fail, need your advice on why it would fail / wakeup
continuously.


-----------
Problem
-----------
No matter how hard I try it either:
* Keeps waking up shortly after it goes to suspend mode
(suspend_ops->enter(state)), or
* It doesn't enter sleep mode at all.

This is what you see from ftrace:
from ftrace (/sys/kernel/debug/tracing/trace):
              sh-2073  [001] d..1 23035.549297: suspend_resume:
machine_suspend[3] begin
              sh-2073  [001] d..1 23035.549297: suspend_resume:
machine_suspend[3] end

Notice no diff in the timestamp, the suspend_ops->enter should have
blocked indefinitely until the next real interrupt arrives (e.g.
keyboard event / network event / power button press).

It's hard to tell the reason why, really. The only thing I have is the
ftrace traces (more on that at the bottom of the thread).

Since you won't find a call to WFI ARM instruction to sleep, and the
sleep is managed by Qualcomm's proprietary closed firmware blob, I
could really use some advice here from ARM / QCOM people on tracing
the culprit that keeps the SoC awake.

-------------------------
SoC + repo details
-------------------------
The SoC is msm8909w [1] and I=E2=80=99m using a forked tree of AOSP of Andr=
oid
8.0 (Oreo) [2] with some Qualcomm patches rebased on top (I can
provide them if needed).

The recipe below will roughly (due to some QCOM/Intrinsyc patches
rebased on top) get you with the exact code that I'm using:

repo init -q -u git://codeaurora.org/platform/manifest.git -b release
-m LAW.BR.3.0-12700-8x09w.0.xml
repo sync -q -c -j $(nproc) --no-tags --no-clone-bundle

Or if you want just the Linux kernel tree:
git clone https://source.codeaurora.org/quic/la/kernel/msm-3.18
git checkout 67e59f18c2e

-------------------
Kernel version
-------------------
Beware, it is very old (but this is what the OEM provided me):
msm8909w:/ # uname -a
Linux localhost 3.18.107-gcd5254c5d3a-dirty #11 SMP PREEMPT Tue Oct 6
19:39:06 IDT 2020 armv7l
msm8909w:/ #

-------------
My setup
-------------
* A Windows machine connected via PuTTY to the UART serial console
(COM13) over USB
* Same Windows machine connected to the ADB port over USB and uses adb
(Android bridge) to manage the device.

----------
My flow
----------
* Disable all wakeup source events
  Reason: the vanilla setup doesn't enter sleep so I thought let's
disable whatever can wake up the board.

   find /sys/devices/ -name '*wakeup*'
   and for each device:
   echo disabled > /sys/devices/.../device/wakeup

* Unplug USB ADB cable from the board
   Reason: we don't want the msm USB-OTG driver to prevent the platform fro=
m
   sleeping (it should enter LPM).

* Keep the UART serial (over USB) connected for tracing

* Force the device into sleep (from the COM13 console)
   echo mem > /sys/power/state


Expected: the board will enter deep sleep until the next real event
          (e.g. keyboard event, network event, power button press event) oc=
curs.

Actual: the board *resumes from sleep promptly*, or doesn't enter sleep at =
all
        (evident from the zero diff timestamps between machine_suspend
begin and end).


-------------
Call stack
-------------
#-1 arm_proprietary_secure_firmware()
    Here we are in the "ARM Secure Zone" with a proprietary closed firmware=
 blob
    that is supposed to drive the core to a deep sleep.
    I'm guessing that under the hood it should call:
    wfi // for each core sleep mode

#0 scm_call_atomic1 (scm.c), (called with SCM_SVC_BOOT,
SCM_CMD_TERMINATE_PC, flag)
#1 msm_pm_collapse (msm-pm.c)
#2 __cpu_suspend_enter (sleep.S)
#3 __cpu_suspend (suspend.c)
#4 msm_pm_spm_power_collapse (msm-pm.c)
#5 msm_pm_power_collapse (msm-pm.c), (called with mode =3D=3D
MSM_PM_SLEEP_MODE_POWER_COLLAPSE)
#6 msm_cpu_pm_enter_sleep (msm-pm.c)
#7 lpm_suspend_enter (lpm-levels.c)
#8 suspend_enter (suspend.c) (called with PM_SUSPEND_MEM)



Appreciate your input.


Thanks,
Ofir


[1] https://www.qualcomm.com/products/snapdragon-processors-wear-2100
[2] https://developer.android.com/about/versions/oreo
