Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6018647C631
	for <lists+linux-pm@lfdr.de>; Tue, 21 Dec 2021 19:17:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241117AbhLUSQz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 21 Dec 2021 13:16:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236895AbhLUSQz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 21 Dec 2021 13:16:55 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 538BEC061574
        for <linux-pm@vger.kernel.org>; Tue, 21 Dec 2021 10:16:55 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id v19so11362608plo.7
        for <linux-pm@vger.kernel.org>; Tue, 21 Dec 2021 10:16:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=Ybs7grTQcuj48e/eKq5SQpQP/23TSJ1bRSIFfkiqnEc=;
        b=Fe/7mmH3ZAp8ZVkto8UkSMdCSfyLn4G4LRT0yhVc98dmzidUmUE0eM6wiTnP1h3k7P
         /RiYqMZpOkiCcBuyRIc+c6AyO2XolaKBiIFBXHUjZPnqvhTw/WmrYaZMXEhP51fbO4Ag
         WFSg+blx6bEH7o4VWn83h000tuVphUFjN4hVZATs0PB+NiUprlYd0p9vjrNjvYtx3LCz
         qf2IYxPg5a75jpTRzfXOwyAyRB3hwmudqAsRoirI9hhGv59R7xk70QUcBG9ArVfuqPXO
         dowFe+lIIU1s5ehRzVPRfO/FdYGFZQrVS96OdpItG0bO5VHK4jkfJmZEf38IxFMs64Yb
         wW4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=Ybs7grTQcuj48e/eKq5SQpQP/23TSJ1bRSIFfkiqnEc=;
        b=6VPKZhoBpMd9uLBFnAfkM8/1BR65YPowSmQgXOG+v+0MlfdfInsteyMz3hv+RMEY00
         UNa+w675/eek5zzTqD6ZALJRCol3c9kXoI9L1gV9R2W5wPydMoHy77um60vcSJIcmp2s
         KLuz9s751nXNP77lRZRRKjQBHY+e7K/Kdc7L13US+sLvLr4ygqE1vbos5ihjzbnf7uc5
         VgIfVQ7VodYMCIBE/bJTAS0dmJcGjg9Moh7huHDWkKSXOKKw2QY8XW3AfnmR+2hWYTLs
         pzwOBJAYfrOszX1B1ZM68jAH9O4xsMqPvJW95kHDFJK07XJ2ymi12eg/Q3Wlc1UHCYvP
         6czQ==
X-Gm-Message-State: AOAM5338EYeHDJd2FyhTuy3b2FzMHEFN5hGGbZhbNhQNLmj5d6DNr8L4
        RQJUz8pngj31dyqmV1E00CxWoA==
X-Google-Smtp-Source: ABdhPJygNJwZ3un4Jlx5tFQdex7/tqW35I3QwC9cgcaY4UcBr03CSqyRt1jhvI98rKUmi46LsQ8vYA==
X-Received: by 2002:a17:90a:f192:: with SMTP id bv18mr5416026pjb.110.1640110614894;
        Tue, 21 Dec 2021 10:16:54 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id x31sm8024121pfh.116.2021.12.21.10.16.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 10:16:54 -0800 (PST)
Message-ID: <61c21a16.1c69fb81.3d0b.52d7@mx.google.com>
Date:   Tue, 21 Dec 2021 10:16:54 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.16-rc6-72-gbd982f30deb7
X-Kernelci-Report-Type: build
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
Subject: pm/testing build: 7 builds: 0 failed, 7 passed,
 1 warning (v5.16-rc6-72-gbd982f30deb7)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 7 builds: 0 failed, 7 passed, 1 warning (v5.16-rc6-72-gbd=
982f30deb7)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
16-rc6-72-gbd982f30deb7/

Tree: pm
Branch: testing
Git Describe: v5.16-rc6-72-gbd982f30deb7
Git Commit: bd982f30deb7baab86095fc89f33954f10dcc387
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
defconfig (arm64, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section m=
ismatches

---------------------------------------------------------------------------=
-----
defconfig (riscv, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section m=
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
