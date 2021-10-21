Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DFFA4360EC
	for <lists+linux-pm@lfdr.de>; Thu, 21 Oct 2021 14:01:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbhJUMDz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 21 Oct 2021 08:03:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230459AbhJUMDt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 21 Oct 2021 08:03:49 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1EEAC06174E
        for <linux-pm@vger.kernel.org>; Thu, 21 Oct 2021 05:01:33 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id s1so210758plg.12
        for <linux-pm@vger.kernel.org>; Thu, 21 Oct 2021 05:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=aHgcOY9eoot29UHhiujcK5hlJq12fPUSeuxyMssLu2c=;
        b=PCejRw2+NztcHBEghbevAb2kh+BmPgy4lsHY+VBX+dIEailvljlVxdYd8Ioppq3hGS
         VyUxldXzymQJ64OG0hVM6gAVrWFsoPTM2IXaD/aWDFkYjswUAQJFylJ2SSATb3LLPiKS
         DUql/7o6WTuZNB03R90Bcd8QDn+cbEpYs9I1Ac7dEhGIQuUJlBZTnn9uPQ4kpij9G1RM
         rL/VjruCR9Mnf4imUbCYDGVVAx79YtmgUOnlhUg8dtTws11RcSBvH9hr5v70DFO9PUiI
         IuWY+l3Kyacmw8lamIdrAtE23bnNq7b58WJ5js5sCMeqt8L55r3+wwlMMFLelIH/nnJa
         XJtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=aHgcOY9eoot29UHhiujcK5hlJq12fPUSeuxyMssLu2c=;
        b=FdnuTzd6YgFKb8DVCwXuNLPHBHQ8gcz+LD+wJ1s5k8P2mttDsziYQyOobt97h7bcm0
         rqMoi9+16GDqxstdieOJYysSTWTh8areTM+rvWVVM70afkTx/7I+ck2yva45m97O1t04
         3vrKV+d6ssW2y93N+iYFwRyQUseQ426UAZteVGYCWsy0M5aO5JN21VJfvKmNLE0YgKL/
         c1Pl2rrlY0jZJxzPQHVmv6GOx8X+99UNY+gZk8R9m+Y0EKapTAiksVgOpkeUaYhcoUFg
         RxB/+oMiizGg7VpHAjpeqJK0mWG/TnXAiBlEKS4JH6JtVZqMTLcoaT78UJfyw5aTQafK
         xdsw==
X-Gm-Message-State: AOAM532v1Q5eT/jv42pYvqrGZny1E26Y50OiYNvVHCAraGNdjNLOExo6
        8a0sX5fRFJFXAYri9MAgAji1XA==
X-Google-Smtp-Source: ABdhPJzm/pro1naGjQLwi8GpBP9Bhj9ozUqAHqkiTSRuBWwQJG6m5fdPj8Uw0ciZ1bZRvJ1rYH+1AA==
X-Received: by 2002:a17:902:c102:b0:13f:5507:bdc9 with SMTP id 2-20020a170902c10200b0013f5507bdc9mr4789979pli.8.1634817693187;
        Thu, 21 Oct 2021 05:01:33 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id s35sm2352781pjd.32.2021.10.21.05.01.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 05:01:32 -0700 (PDT)
Message-ID: <6171569c.1c69fb81.d27bb.5661@mx.google.com>
Date:   Thu, 21 Oct 2021 05:01:32 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v5.15-rc6-69-g8b39e976f0f8
X-Kernelci-Report-Type: build
Subject: pm/testing build: 7 builds: 0 failed, 7 passed,
 1 warning (v5.15-rc6-69-g8b39e976f0f8)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 7 builds: 0 failed, 7 passed, 1 warning (v5.15-rc6-69-g8b=
39e976f0f8)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
15-rc6-69-g8b39e976f0f8/

Tree: pm
Branch: testing
Git Describe: v5.15-rc6-69-g8b39e976f0f8
Git Commit: 8b39e976f0f81dd610ea1d7930dc8ba662b639b5
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
