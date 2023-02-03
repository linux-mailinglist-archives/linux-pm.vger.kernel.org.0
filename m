Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91039689C63
	for <lists+linux-pm@lfdr.de>; Fri,  3 Feb 2023 15:58:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233013AbjBCO57 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 3 Feb 2023 09:57:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233758AbjBCO5s (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 3 Feb 2023 09:57:48 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41803A58CB
        for <linux-pm@vger.kernel.org>; Fri,  3 Feb 2023 06:57:27 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id 7so3808598pga.1
        for <linux-pm@vger.kernel.org>; Fri, 03 Feb 2023 06:57:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=fUFJpcw18eNgBpCFlM5AGN3//6An0pa34T97OZw59OA=;
        b=LgVVz3RZvsz+OUJgd1wXl4XjBcgjTmb/7A9Bk4QEmS1IAfT7otrWas/RfdPwtXFuwf
         j1dnG+TQaJrlA7YAqOqq6i+a3xq//e+MK3FdQva9rA9VNCNF1obN+hvtOKDR8M3Pk2eZ
         m57dLFdTSJ9a3f1OrIRWrQrrEFmLUDPOAm9ReHHMKJ0UNJrM9dJXTZNlhvqeb+5kg9JC
         8VBitOAryPLCasbTorebZliQkbWT6B2mXtzsIYy7CPM26ptmPOWg0nI4e781130PyIpV
         kt/dd6v1Pms+R2ZDiBYprG8EIKu2NOblOqmsg530AanmjS2u4mtqYl0LHB08KmeA71yK
         m3sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fUFJpcw18eNgBpCFlM5AGN3//6An0pa34T97OZw59OA=;
        b=Lejkk6fi+ddGt8Z7V71I2hscwNAkV8tsuwn4ncnsoSwlnLFRHn6Z/cHPbvR+x1WOZi
         1soIYtcDI1+8yj7GFj4aXpyNYFJRiI0Fc/HdQESmhbQ8GPBxOCQ0A4FaiuJi8bZ6v4+p
         SuYMWKqgpbPrRQNx6vgX1oQczT1UStvDtC96GeSIdlP8Mh0d+k2Fx5Nq44qcOcxLB5Z0
         nyCTA73vXUSQbUO4Q++TTvehRIhUeTloiL2fdmm9F9oAVlGnb7T/EGOyYNIn7MDUjK8s
         L+Ni18fy6on0htY4CMkdAaYv5j6MFS9oqmQBa6RSeBJJ/xfWlG/58xypjnk5O3MO/Ssy
         wLcw==
X-Gm-Message-State: AO0yUKXAYLW3QSK83rAzF99urNLXj6O2h5EFgSVD0Bcl1izs3cIdzEaW
        597jmORgyHgacT+7jWGiwIUP9W9AXijuFPsZrNe6dQ==
X-Google-Smtp-Source: AK7set857ozdkgZMYaHNxbO26WVVMSeW0puJ1hVTyIGO1e8je77nErlXVTtbMr4pmb4ROehlampXmQ==
X-Received: by 2002:a62:198d:0:b0:593:d46a:677c with SMTP id 135-20020a62198d000000b00593d46a677cmr3050848pfz.18.1675436246634;
        Fri, 03 Feb 2023 06:57:26 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id 187-20020a6217c4000000b005825b8e0540sm1826573pfx.204.2023.02.03.06.57.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 06:57:26 -0800 (PST)
Message-ID: <63dd20d6.620a0220.45205.3721@mx.google.com>
Date:   Fri, 03 Feb 2023 06:57:26 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
X-Kernelci-Kernel: v6.2-rc6-168-ga9dd827a6e77
X-Kernelci-Report-Type: build
Subject: pm/testing build: 8 builds: 0 failed, 8 passed,
 5 warnings (v6.2-rc6-168-ga9dd827a6e77)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 8 builds: 0 failed, 8 passed, 5 warnings (v6.2-rc6-168-ga=
9dd827a6e77)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v6.=
2-rc6-168-ga9dd827a6e77/

Tree: pm
Branch: testing
Git Describe: v6.2-rc6-168-ga9dd827a6e77
Git Commit: a9dd827a6e77dec5b861c924206d85b63156df16
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
Built: 8 unique architectures

Warnings Detected:

arc:

arm64:

arm:

i386:

mips:
    32r2el_defconfig (gcc-10): 1 warning

riscv:

sparc:
    sparc64_defconfig (gcc-10): 4 warnings

x86_64:


Warnings summary:

    2    WARNING: modpost: EXPORT symbol "_mcount" [vmlinux] version genera=
tion failed, symbol will not be versioned.
    2    <stdin>:1517:2: warning: #warning syscall clone3 not implemented [=
-Wcpp]
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
sparc64_defconfig (sparc, gcc-10) =E2=80=94 PASS, 0 errors, 4 warnings, 0 s=
ection mismatches

Warnings:
    <stdin>:1517:2: warning: #warning syscall clone3 not implemented [-Wcpp]
    WARNING: modpost: EXPORT symbol "_mcount" [vmlinux] version generation =
failed, symbol will not be versioned.
    <stdin>:1517:2: warning: #warning syscall clone3 not implemented [-Wcpp]
    WARNING: modpost: EXPORT symbol "_mcount" [vmlinux] version generation =
failed, symbol will not be versioned.

---------------------------------------------------------------------------=
-----
x86_64_defconfig (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 s=
ection mismatches

---
For more info write to <info@kernelci.org>
