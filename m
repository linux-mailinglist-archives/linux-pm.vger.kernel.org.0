Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C0AA41BADE
	for <lists+linux-pm@lfdr.de>; Wed, 29 Sep 2021 01:14:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231235AbhI1XQL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 28 Sep 2021 19:16:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbhI1XQK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 28 Sep 2021 19:16:10 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9D28C06161C
        for <linux-pm@vger.kernel.org>; Tue, 28 Sep 2021 16:14:30 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id s75so685049pgs.5
        for <linux-pm@vger.kernel.org>; Tue, 28 Sep 2021 16:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=Wd/7wWNk46mblm+Cbo2f0Wjp9VISeWv8uB9t8ErdF3o=;
        b=nEs9oSfARI+tuKYhKHUHWJA2W1oEw448sOQf99Du1w9jwcZL1AjQ1JcxtXA55iwfKh
         6VKxPNQIo5FOo1M7V4cxwUX9iK8HhjoKmapiEwUkjk1d1YPzw+5qOoJYajRwn/BLkJya
         mE3rreewZMpEvhoi2niFfrXYYZzTfJ30aj7Li0GGjf0wx/Bg70InG8WHBtn2yOBMsti3
         ZFWOL9SixyB4WG/yJtuJR2e0QeDpeEfi/bZN3KLAnLBPMkZm4vi+FDtbjv5Jj9L2LogK
         31VGylIOj+8K6Enzz0XqzNN1j0a3KLynBcVTYLOEd79q0+UMMQvJsGfqwuRzpov6i7aL
         JL1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=Wd/7wWNk46mblm+Cbo2f0Wjp9VISeWv8uB9t8ErdF3o=;
        b=B2kRjLfUkMwoGAnL6tApH1eJzyeIl0OfYADTq9KkXJJBcI6OYCq6Iln49LEVRuJEva
         tbt+8OIBzOIbpJXWmtcbZtL7QpYF4WR2453C53XeMSG0Mfq/Tf29ujYXka77CvlM5sIU
         +vvSqeRjIQlnxbXvFaDgDWD7HUDpMcWZ5d+/ej4OXWnRwa81X74ZzYZQsZb8yQ5kunbJ
         iBzO6wahGhaInVXN8iUCnD9V7eYpbNUgui3oTcsaY1yInUsn4CrBytp8iPcDC9JVyLxu
         DkdYbw+3eYK9G7XXLC1Fv5p11TWgh2t8RJswY4bICuwOD4UbU3zEJFbhi6t8ywK30sPc
         6ozQ==
X-Gm-Message-State: AOAM532jVSF8Qvqp53Fi8Em5jtkVDtnaTKanKFnegyuL7X4P1x2bUrwU
        p+GHrjG26va3nY4/CykkUBl3fw==
X-Google-Smtp-Source: ABdhPJw/n4HKehiJ6WVbeAuKpPpPmbCYdkurNZhH1ZFbL6fc7CWSxkg1Mlc39N7gU9J/KQGaTNDq4w==
X-Received: by 2002:a62:641:0:b0:44b:74bb:294c with SMTP id 62-20020a620641000000b0044b74bb294cmr7946504pfg.12.1632870870265;
        Tue, 28 Sep 2021 16:14:30 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id k3sm3512023pjg.43.2021.09.28.16.14.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 16:14:30 -0700 (PDT)
Message-ID: <6153a1d6.1c69fb81.22c8f.c2b7@mx.google.com>
Date:   Tue, 28 Sep 2021 16:14:30 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.15-rc3-23-g5264d800ffd5
X-Kernelci-Report-Type: build
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
Subject: pm/testing build: 7 builds: 0 failed, 7 passed,
 1 warning (v5.15-rc3-23-g5264d800ffd5)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 7 builds: 0 failed, 7 passed, 1 warning (v5.15-rc3-23-g52=
64d800ffd5)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
15-rc3-23-g5264d800ffd5/

Tree: pm
Branch: testing
Git Describe: v5.15-rc3-23-g5264d800ffd5
Git Commit: 5264d800ffd532b515f32ad3a3439b5611438157
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
Built: 7 unique architectures

Warnings Detected:

arc:

arm64:

arm:

i386:

mips:
    32r2el_defconfig (gcc-8): 1 warning

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
32r2el_defconfig (mips, gcc-8) =E2=80=94 PASS, 0 errors, 1 warning, 0 secti=
on mismatches

Warnings:
    arch/mips/boot/dts/img/boston.dts:128.19-178.5: Warning (pci_device_reg=
): /pci@14000000/pci2_root@0,0,0: PCI unit address format error, expected "=
0,0"

---------------------------------------------------------------------------=
-----
defconfig (riscv, gcc-8) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section mi=
smatches

---------------------------------------------------------------------------=
-----
defconfig (arm64, gcc-8) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section mi=
smatches

---------------------------------------------------------------------------=
-----
haps_hs_smp_defconfig (arc, gcc-8) =E2=80=94 PASS, 0 errors, 0 warnings, 0 =
section mismatches

---------------------------------------------------------------------------=
-----
i386_defconfig (i386, gcc-8) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sectio=
n mismatches

---------------------------------------------------------------------------=
-----
multi_v7_defconfig (arm, gcc-8) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sec=
tion mismatches

---------------------------------------------------------------------------=
-----
x86_64_defconfig (x86_64, gcc-8) =E2=80=94 PASS, 0 errors, 0 warnings, 0 se=
ction mismatches

---
For more info write to <info@kernelci.org>
