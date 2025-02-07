Return-Path: <linux-pm+bounces-21544-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1701FA2C68A
	for <lists+linux-pm@lfdr.de>; Fri,  7 Feb 2025 16:08:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32D293A34C0
	for <lists+linux-pm@lfdr.de>; Fri,  7 Feb 2025 15:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BE5DCA6B;
	Fri,  7 Feb 2025 15:08:33 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE94B238D38;
	Fri,  7 Feb 2025 15:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738940913; cv=none; b=Rs8oyFqj0hdIAsXyqYgNSxqNCIk8RCO3R8l/n6Voyyi2TRNuL/dkzeJqbL8ThlZFaMd+7xAlHSS2dv0a0sAlGxXMS1nxDxphyzZMoeQadkLneEQnMMUTbciY9w7vyV/iufxcahjZFbztrsfnxZ8KcF7sG5d4o3RoH1YIU6+Motc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738940913; c=relaxed/simple;
	bh=zYuf6TUsXT/+dJqMM/PvaXxrdJGQJcs9Oh0qoGLCmIo=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=dVYewE98Do1aEVbvpPG1SesGjAiIU4NktrIEMXG4YKaPTfsoRpp1RjgjJcMHdM1+2H2en22m2NPdjBV4ALS7DVsu/rr94BpHm49iFvnF+dVYmFQ6VcQdwCww/LrPhVxT9zITk4QKJKvyribDSzVqyYiDa4YWPXVqdVocIPKZQWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6e435639b59so14761066d6.3;
        Fri, 07 Feb 2025 07:08:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738940909; x=1739545709;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=01cDeR3Iu0g3SXSPowpC+AUnI029ht/uxmzvpymnUns=;
        b=MfT4TfeUJ+vwDzgkwHSGAcT8QZ2XB/wzPV8PiTVlxY7OkiQIFzqhjmfo9wiM0ctQ3c
         G1RffFzjQTsCszD1hxDkiaiIRyxNbDTfwLSy1DUXoOn/RPf+QwufXt4Bet3AryGZ1diZ
         7DLm1jhe0y86IWcpwHMYO0hbVfSXOcaI4QLFsVNTqM1tKR/t//5DxB6hq+Ji7UfZQc1b
         ojX7n8Ct5fXFhPGLygHmROo1S7WVVITVJQ09xFTATdvo3anoVb+AGYFCRBn5KrIsCFcV
         rFsoS2px4XJSZIfPGDk7UJAZb2ZqAdd4D8rAq1tpLqi76PKQrA0kMJOzy3X9sbfe3LDV
         ijvw==
X-Forwarded-Encrypted: i=1; AJvYcCWfW+1wPBa7aqhX0ufwo45s0c9IL9GPI3a3JLtHU9Jmp8BOU0fhYmxpl87VEGmxZmIm8VX6thZ1pNsa64Tgqw1neSs=@vger.kernel.org, AJvYcCWo2Ua2aqf1bLXVLn7GQhwRUwyv+YPROTR/Ng76IxffjXmHR8QigydwTIMFVln4rctjT7ETauAKAw==@vger.kernel.org
X-Gm-Message-State: AOJu0YydpDpQ1rQ2ifRw9WEe8RGzcyVJFX336iorc36f2EVeFaV6w7Us
	Wy4UNqEqejs2C8syLLG2QJXZyJO+m24ZyUThF+OfHu2hdXd/BeYdQl2vzze2
X-Gm-Gg: ASbGncuyQkenTgn++7oap08rM6juKyrqOxfhbaSl98yIP+X8g3Shlf+YSk68SfMDx2s
	Vjgyu7zuUoOVDfmezzhNdWmQV1iG2DvzN9E2ZGe2ZYZtMLr26Qb6FVytycrB6fxbXRZtnhYSsJb
	yOC8WR8wuMgbyagzb9pdVzE9oZPFZMuz8XCCiNbS8dmB9qp39pWaK+G7AXwxhbZCez8dEQmSqIn
	CclsrLSZdLx6zwXT2FPn1E+2RcoUG8dlWkDwlG/lAidolthjean+w/IXcPlhKZxW+UJSfqgxqqC
	QlQvrf/OOMQk4U3ZrcQ8BY2NtcwqWwN9BpHzyVfw2q0NMLgP8i8TaJMQ5g==
X-Google-Smtp-Source: AGHT+IGcXBC3lgO/lSFdVMSbYjiSbqcc23UGH4oY8BsTfKEhP4FERAO9dQf0EwFCbgJ1Gi9WVZmPwA==
X-Received: by 2002:ad4:5caf:0:b0:6e2:55b5:91d1 with SMTP id 6a1803df08f44-6e4453f58demr50669926d6.0.1738940909151;
        Fri, 07 Feb 2025 07:08:29 -0800 (PST)
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com. [209.85.160.180])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e43ba368a9sm17882536d6.29.2025.02.07.07.08.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Feb 2025 07:08:28 -0800 (PST)
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4679eacf25cso12530871cf.3;
        Fri, 07 Feb 2025 07:08:28 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVStjtFLxzfHYMfS3hlBkdtwCCl4pJDobRH1dxArJQrKJeDbb9k83kn9+BQxzS0bhue5939TiC1WQ==@vger.kernel.org, AJvYcCX4XZk/cYKu+mEfs5mYMDejDLH4y6635PSifotP8blPHpCmtalHliAw9n4nmTDh8Pb/9p0rZWOVmnB/yO+aFRfkSb8=@vger.kernel.org
X-Received: by 2002:ac8:578a:0:b0:467:86fa:6b72 with SMTP id
 d75a77b69052e-47167a153ecmr41919931cf.12.1738940908576; Fri, 07 Feb 2025
 07:08:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 7 Feb 2025 16:08:16 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXN9A-1P_qe=BwKjLaoqxU8iJUQK6h8=s-apR4Y0em_0Q@mail.gmail.com>
X-Gm-Features: AWEUYZnfmu9ofX_U8GML-ED_GiKpQUNGLT-ryiYdtSrvpzE9zKK6M0UBLhLvj7M
Message-ID: <CAMuHMdXN9A-1P_qe=BwKjLaoqxU8iJUQK6h8=s-apR4Y0em_0Q@mail.gmail.com>
Subject: s2idle blocked on dev->power.completion
To: Saravana Kannan <saravanak@google.com>
Cc: Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>, 
	Linux PM list <linux-pm@vger.kernel.org>, 
	Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Saravana,

I am investigating a hang during resume from s2idle on the Gray
Hawk Single development board[1].  It was reported first in [2].
The issue was detected when support for DisplayPort was added, due to
DTS and driver updates following different paths to upstream.

When using a DTS with DisplayPort support, but booting a kernel that
lacks support for the DSI block, the display and DSI-DP bridge drivers
fail to probe, as expected:

    # cat /sys/kernel/debug/devices_deferred
    feb00000.display        rcar-du: failed to initialize encoders
    ti_sn65dsi86.bridge.0   ti_sn65dsi86.bridge: failed to attach dsi host

However, when using s2idle, the system fails to wake-up, which is
not expected.

The issue can be reproduced by reverting commit c303814c38cde135
("drm/rcar-du: dsi: Add r8a779h0 support") on top of v6.14-rc1.

Instrumenting all dev->power.completion accesses in
drivers/base/power/main.c reveals that resume is blocked in dpm_wait()
in the call to wait_for_completion() for regulator-1p2v, which is
indeed a dependency for the SN65DSI86 DSI-DP bridge.  Comparing
this to plain v6.14-rc1 (where resume works fine) shows that the regulator
is woken by complete_all() there.  As the logs are rather large,
I made them available at [3] and [4] (I added "----" sync markers for
"diff -y"). The important difference bad vs. good is:

    -ti_sn65dsi86 1-002c: PM: dpm_wait:241: wait_for_completion
    -i2c i2c-0: PM: device_resume_noirq:700: complete_all
    -i2c i2c-1: PM: device_resume_noirq:700: complete_all
    -i2c i2c-1: PM: dpm_wait:241: completed
    -i2c i2c-0: PM: dpm_wait:241: completed
    +rcar-mipi-dsi fed80000.dsi-encoder: PM: device_resume_noirq:700:
complete_all
    +platform fff00044.chipid: PM: device_resume_noirq:700: complete_all
    +platform timer: PM: device_resume_noirq:700: complete_all
    +gpio-keys keys: PM: device_resume_noirq:700: complete_all
    +leds-gpio leds: PM: device_resume_noirq:700: complete_all
    +display-connector mini-dp-con: PM: device_resume_noirq:700: complete_all
    +reg-fixed-voltage regulator-1p2v: PM: device_resume_noirq:700: complete_all
    +reg-fixed-voltage regulator-1p8v: PM: device_resume_noirq:700: complete_all
    +reg-fixed-voltage regulator-3p3v: PM: device_resume_noirq:700: complete_all
    +simple-mux sound-mux: PM: device_resume_noirq:700: complete_all
    +workqueue writeback: PM: device_resume_noirq:700: complete_all
    +graphics fbcon: PM: device_resume_noirq:700: complete_all
    +regulator regulator.1: PM: device_resume_noirq:700: complete_all
    +regulator regulator.2: PM: device_resume_noirq:700: complete_all
    +regulator regulator.3: PM: device_resume_noirq:700: complete_all
    +net lo: PM: device_resume_noirq:700: complete_all
    +misc vga_arbiter: PM: device_resume_noirq:700: complete_all
    +mem mem: PM: device_resume_noirq:700: complete_all
    +mem null: PM: device_resume_noirq:700: complete_all
    +mem port: PM: device_resume_noirq:700: complete_all
    +mem zero: PM: device_resume_noirq:700: complete_all
    +mem full: PM: device_resume_noirq:700: complete_all
    +mem random: PM: device_resume_noirq:700: complete_all
    +mem urandom: PM: device_resume_noirq:700: complete_all
    +mem kmsg: PM: device_resume_noirq:700: complete_all
    +tty tty: PM: device_resume_noirq:700: complete_all
    +tty console: PM: device_resume_noirq:700: complete_all
    +tty tty0: PM: device_resume_noirq:700: complete_all
    +vc vcs: PM: device_resume_noirq:700: complete_all
    +vc vcsu: PM: device_resume_noirq:700: complete_all
    +vc vcsa: PM: device_resume_noirq:700: complete_all
    +vc vcs1: PM: device_resume_noirq:700: complete_all
    +vc vcsu1: PM: device_resume_noirq:700: complete_all
    +vc vcsa1: PM: device_resume_noirq:700: complete_all
    +tty tty1: PM: device_resume_noirq:700: complete_all
    +tty tty2: PM: device_resume_noirq:700: complete_all
    +tty tty3: PM: device_resume_noirq:700: complete_all
    +tty tty4: PM: device_resume_noirq:700: complete_all
    +tty tty5: PM: device_resume_noirq:700: complete_all
    +tty tty6: PM: device_resume_noirq:700: complete_all
    +tty tty7: PM: device_resume_noirq:700: complete_all
    +tty tty8: PM: device_resume_noirq:700: complete_all
    +tty tty9: PM: device_resume_noirq:700: complete_all
    +tty tty10: PM: device_resume_noirq:700: complete_all
    +tty tty11: PM: device_resume_noirq:700: complete_all
    +tty tty12: PM: device_resume_noirq:700: complete_all
    +tty tty13: PM: device_resume_noirq:700: complete_all
    +tty tty14: PM: device_resume_noirq:700: complete_all
    +tty tty15: PM: device_resume_noirq:700: complete_all
    +i2c i2c-0: PM: dpm_wait:241: wait_for_completion
    +i2c i2c-0: PM: dpm_wait:241: wait_for_completion
     i2c i2c-0: PM: dpm_wait:241: completed
     regulator regulator.0: PM: dpm_wait:241: wait_for_completion
     regulator regulator.0: PM: dpm_wait:241: completed
    -at24 0-0051: PM: device_resume_noirq:700: complete_all
    +pca953x 0-0021: PM: device_resume_noirq:700: complete_all
    +i2c i2c-0: PM: dpm_wait:241: wait_for_completion
     i2c i2c-0: PM: dpm_wait:241: completed
     regulator regulator.0: PM: dpm_wait:241: wait_for_completion
     regulator regulator.0: PM: dpm_wait:241: completed
    -at24 0-0050: PM: device_resume_noirq:700: complete_all
    +pca953x 0-0022: PM: device_resume_noirq:700: complete_all
    +i2c i2c-0: PM: dpm_wait:241: wait_for_completion
     i2c i2c-0: PM: dpm_wait:241: completed
     regulator regulator.0: PM: dpm_wait:241: wait_for_completion
     regulator regulator.0: PM: dpm_wait:241: completed
    -at24 0-0052: PM: device_resume_noirq:700: complete_all
    -i2c i2c-0: PM: dpm_wait:241: completed
    +at24 0-0051: PM: device_resume_noirq:700: complete_all
    +tty tty16: PM: device_resume_noirq:700: complete_all
     i2c i2c-0: PM: dpm_wait:241: completed
    -regulator regulator.0: PM: dpm_wait:241: wait_for_completion
    -regulator regulator.0: PM: dpm_wait:241: completed
    +tty tty17: PM: device_resume_noirq:700: complete_all
     gpio_rcar e6050180.gpio: PM: dpm_wait:241: wait_for_completion
    -at24 0-0053: PM: device_resume_noirq:700: complete_all
    +tty tty18: PM: device_resume_noirq:700: complete_all
     gpio_rcar e6050180.gpio: PM: dpm_wait:241: completed
    +tty tty19: PM: device_resume_noirq:700: complete_all
    +i2c i2c-0: PM: dpm_wait:241: wait_for_completion
    +i2c i2c-0: PM: dpm_wait:241: wait_for_completion
    +i2c-rcar e6508000.i2c: PM: dpm_wait:241: wait_for_completion
     i2c i2c-0: PM: dpm_wait:241: completed
    +i2c-rcar e6508000.i2c: PM: dpm_wait:241: completed
    +i2c i2c-1: PM: device_resume_noirq:700: complete_all
     regulator regulator.0: PM: dpm_wait:241: wait_for_completion
    -regulator regulator.0: PM: dpm_wait:241: wait_for_completion
    +i2c i2c-0: PM: dpm_wait:241: wait_for_completion
     regulator regulator.0: PM: dpm_wait:241: completed
    +i2c i2c-0: PM: dpm_wait:241: completed
    +regulator regulator.0: PM: dpm_wait:241: wait_for_completion
     regulator regulator.0: PM: dpm_wait:241: completed
    -pca953x 0-0020: PM: device_resume_noirq:700: complete_all
    -pca953x 0-0021: PM: device_resume_noirq:700: complete_all
    +at24 0-0052: PM: device_resume_noirq:700: complete_all
    +at24 0-0053: PM: device_resume_noirq:700: complete_all
    +mmc_host mmc0: PM: dpm_wait:241: wait_for_completion
    +tty tty20: PM: device_resume_noirq:700: complete_all
    +i2c i2c-0: PM: dpm_wait:241: completed
    +tty tty21: PM: device_resume_noirq:700: complete_all
    +regulator regulator.0: PM: dpm_wait:241: wait_for_completion
    +tty tty22: PM: device_resume_noirq:700: complete_all
    +i2c i2c-1: PM: dpm_wait:241: completed
    +tty tty23: PM: device_resume_noirq:700: complete_all
     sh-pfc e6050000.pinctrl: PM: dpm_wait:241: wait_for_completion
    +tty tty24: PM: device_resume_noirq:700: complete_all
    +regulator regulator.0: PM: dpm_wait:241: completed
    +tty tty25: PM: device_resume_noirq:700: complete_all
    +at24 0-0050: PM: device_resume_noirq:700: complete_all
    +tty tty26: PM: device_resume_noirq:700: complete_all
     regulator regulator.0: PM: dpm_wait:241: wait_for_completion
    -sh-pfc e6050000.pinctrl: PM: dpm_wait:241: completed
    +tty tty27: PM: device_resume_noirq:700: complete_all
     regulator regulator.0: PM: dpm_wait:241: completed
    +tty tty28: PM: device_resume_noirq:700: complete_all
    +sh-pfc e6050000.pinctrl: PM: dpm_wait:241: completed
    +tty tty29: PM: device_resume_noirq:700: complete_all
     reg-fixed-voltage regulator-1p2v: PM: dpm_wait:241: wait_for_completion
    -pca953x 0-0022: PM: device_resume_noirq:700: complete_all
    +tty tty30: PM: device_resume_noirq:700: complete_all
    +pca953x 0-0020: PM: device_resume_noirq:700: complete_all

Looking at /sys/devices/virtual/devlink, the non-working case has the
following extra entries:

    /sys/devices/virtual/devlink/i2c:1-002c--platform:fed80000.dsi-encoder:
    -r--r--r-- 1 root root 4096 Feb  7 HH:MM auto_remove_on
    lrwxrwxrwx 1 root root    0 Feb  7 HH:MM consumer ->
../../../platform/soc/fed80000.dsi-encoder
    -r--r--r-- 1 root root 4096 Feb  7 HH:MM runtime_pm
    -r--r--r-- 1 root root 4096 Feb  7 HH:MM status
    lrwxrwxrwx 1 root root    0 Dec  1 HH:MM subsystem ->
../../../../class/devlink
    lrwxrwxrwx 1 root root    0 Feb  7 HH:MM supplier ->
../../../platform/soc/e6508000.i2c/i2c-1/1-002c
    -r--r--r-- 1 root root 4096 Feb  7 HH:MM sync_state_only
    -rw-r--r-- 1 root root 4096 Dec  1 HH:MM uevent

    /sys/devices/virtual/devlink/platform:feb00000.display--platform:fed80000.dsi-encoder:
    -r--r--r-- 1 root root 4096 Feb  7 HH:MM auto_remove_on
    lrwxrwxrwx 1 root root    0 Feb  7 HH:MM consumer ->
../../../platform/soc/fed80000.dsi-encoder
    -r--r--r-- 1 root root 4096 Feb  7 HH:MM runtime_pm
    -r--r--r-- 1 root root 4096 Feb  7 HH:MM status
    lrwxrwxrwx 1 root root    0 Dec  1 HH:MM subsystem ->
../../../../class/devlink
    lrwxrwxrwx 1 root root    0 Feb  7 HH:MM supplier ->
../../../platform/soc/feb00000.display
    -r--r--r-- 1 root root 4096 Feb  7 HH:MM sync_state_only
    -rw-r--r-- 1 root root 4096 Dec  1 HH:MM uevent

    /sys/devices/virtual/devlink/platform:fed80000.dsi-encoder--platform:feb00000.display:
    -r--r--r-- 1 root root 4096 Feb  7 HH:MM auto_remove_on
    lrwxrwxrwx 1 root root    0 Feb  7 HH:MM consumer ->
../../../platform/soc/feb00000.display
    -r--r--r-- 1 root root 4096 Feb  7 HH:MM runtime_pm
    -r--r--r-- 1 root root 4096 Feb  7 HH:MM status
    lrwxrwxrwx 1 root root    0 Dec  1 HH:MM subsystem ->
../../../../class/devlink
    lrwxrwxrwx 1 root root    0 Feb  7 HH:MM supplier ->
../../../platform/soc/fed80000.dsi-encoder
    -r--r--r-- 1 root root 4096 Feb  7 HH:MM sync_state_only
    -rw-r--r-- 1 root root 4096 Dec  1 HH:MM uevent

Do you have a clue, or suggestions for further investigation?
Thanks!

[1] arch/arm64/boot/dts/renesas/r8a779h0-gray-hawk-single.dts
[2] https://lore.kernel.org/CAMuHMdXkXx6+0nJn+uLCAWOXvEYWLJXzLu9J7ksinn_z3bEfHQ@mail.gmail.com
[3] https://drive.google.com/file/d/1yH_PjihKIauK44NZhVHtZeka6PaIPY78/view?usp=sharing
[4] https://drive.google.com/file/d/1zjGSQhEqsSLRw5cxP_xsBDcy3t3dkpcj/view?usp=sharing

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

