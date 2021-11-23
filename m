Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D33145A4B5
	for <lists+linux-pm@lfdr.de>; Tue, 23 Nov 2021 15:10:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237463AbhKWON5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Nov 2021 09:13:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237907AbhKWONw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 Nov 2021 09:13:52 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91F71C061714
        for <linux-pm@vger.kernel.org>; Tue, 23 Nov 2021 06:10:44 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id q16so2747446pgq.10
        for <linux-pm@vger.kernel.org>; Tue, 23 Nov 2021 06:10:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=wuv/KeDLS7Gf/pWTVxTWuzQ5sq4l+ohUEKuoWa75f94=;
        b=zZLWh66XUGMwjyzMY2YK667z2of9+qoiWdW0htGZbyZ7lVz6xSGWaX1pCwuYVEpQX2
         2gg8gupSC7ShawdciX0oHTJK/dofcHX7EaFxWA4MJujTnGNM58gB3bWbAgkHSV+ZKl1z
         Q9pvo9O9d8BW99E39RyyjCvRy5an87uYTK/Hxj94Ql78lVGkTMFcvzbQ7CUWhbrYadIT
         tlBRSejyKAat8VGvGf9t4WUI3O5MG/eaMOYsd2jlKex+4mO9wv7O7bEpeBHvVYXjgjOf
         LitHQbvFLkrSeUFaKirOz/dYXQoG53rRiMrz+R1G+dfktX52cbqlEbD8+5wxJRkg39mR
         BbOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=wuv/KeDLS7Gf/pWTVxTWuzQ5sq4l+ohUEKuoWa75f94=;
        b=tQxs+trDzFFsemVBn8o230hLWhRsP9ILKfOxd75mAbzELyYdwyeJcaX5E3oPTJYZaR
         6VmW4GgpNiFK5inhndet/+pjPtSgsC8aKSmxiSsxZJa5e2M2zVnMG4OnJ32e48YcUlsh
         8kDgo5M84wp79SnsOtQIXfmdSyNZV/MC7l7yEULwwTmDcyQ7r8exgVya3FuSIMmfjhU/
         eCq8GYpFZqpERNokJMhD+Z0xgGyKo1T9Y0cajsZAeTdta9T9ACYUH0/zbkfxQ+vqW/UI
         wIqdGS52yk+c1R+ZoGRV3VFWyhWXvfeQpwc4IyzmLFdNqSz+Sltrlq3J1pBO3baUY6kx
         jEkg==
X-Gm-Message-State: AOAM531Lit1mQdT3TpR9AJn3larS0dbTLbh4siMXn716TYSx46cuGb4F
        UagylTLHIyKn40tFspXyR4YxMw==
X-Google-Smtp-Source: ABdhPJyRi25RjR+/UpzhT6WcQLapK8TgldEO6Em0bdhshTQFXcQFRonlEushIs/dBR2X1Zw32MYufg==
X-Received: by 2002:a63:2364:: with SMTP id u36mr3950702pgm.59.1637676644092;
        Tue, 23 Nov 2021 06:10:44 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id g11sm9005797pgn.41.2021.11.23.06.10.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Nov 2021 06:10:43 -0800 (PST)
Message-ID: <619cf663.1c69fb81.539a2.88b1@mx.google.com>
Date:   Tue, 23 Nov 2021 06:10:43 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.16-rc2-9-gaf8757179e68
X-Kernelci-Report-Type: build
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
Subject: pm/testing build: 7 builds: 0 failed, 7 passed,
 1 warning (v5.16-rc2-9-gaf8757179e68)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 7 builds: 0 failed, 7 passed, 1 warning (v5.16-rc2-9-gaf8=
757179e68)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
16-rc2-9-gaf8757179e68/

Tree: pm
Branch: testing
Git Describe: v5.16-rc2-9-gaf8757179e68
Git Commit: af8757179e68cbbc2e001e3acaddb4bdd9883cd9
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
Built: 7 unique architectures

Warnings Detected:

arc:

arm64:

arm:

i386:

mips:
    32r2el_defconfig (gcc-10): 1 warning

riscv:

x86_64:


Warnings summary:

    1    arch/mips/boot/dts/img/boston.dts:128.19-178.5: Warning (pci_devic=
e_reg): /pci@14000000/pci2_root@0,0,0: PCI unit address format error, expec=
ted "0,0"

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D

Detailed per-defconfig build reports:

---------------------------------------------------------------------------=
-----
32r2el_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sect=
ion mismatches

Warnings:
    arch/mips/boot/dts/img/boston.dts:128.19-178.5: Warning (pci_device_reg=
): /pci@14000000/pci2_root@0,0,0: PCI unit address format error, expected "=
0,0"

---------------------------------------------------------------------------=
-----
defconfig (riscv, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section m=
ismatches

---------------------------------------------------------------------------=
-----
defconfig (arm64, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section m=
ismatches

---------------------------------------------------------------------------=
-----
haps_hs_smp_defconfig (arc, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0=
 section mismatches

---------------------------------------------------------------------------=
-----
i386_defconfig (i386, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 secti=
on mismatches

---------------------------------------------------------------------------=
-----
multi_v7_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 se=
ction mismatches

---------------------------------------------------------------------------=
-----
x86_64_defconfig (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 s=
ection mismatches

---
For more info write to <info@kernelci.org>
