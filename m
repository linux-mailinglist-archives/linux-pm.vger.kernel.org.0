Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE03167B7D3
	for <lists+linux-pm@lfdr.de>; Wed, 25 Jan 2023 18:05:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbjAYRFt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 25 Jan 2023 12:05:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235474AbjAYRFs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 25 Jan 2023 12:05:48 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 979DE4B8A2
        for <linux-pm@vger.kernel.org>; Wed, 25 Jan 2023 09:05:47 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id j5so5533130pjn.5
        for <linux-pm@vger.kernel.org>; Wed, 25 Jan 2023 09:05:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=pH/oHI6fF+XkrnZzk0+8BRGX3ci8zWrIwzFuAniDRGQ=;
        b=gACbS8mM+NrvdIRkmXOsEIFShTN8MYRUqTaKH/XlhK9h+MkgEhihAJlf7WdO3EyYIz
         lTdedvbJa8MRbKNX2CkzXemefg+MTqVfgrChgD4J68A1e1tWy/LTgBXOAZ0GcXBn/yiZ
         atNe1NRDb/k/cyoPiDuVGulk50V1iqEyfW8WrEjt49eIPAuMx3SN1D6H974TzwAdn0Nk
         RooLEP3zK0N1T8hn0e9dpZAkkJwtEaaeFCo9FOomdwF0Kj+HCvB1baQo3IgfMZDmdJUS
         gnMboQw4M9dHomJKVmaKshKaVn9as4a+Byv9UFEYPOJGLC6GhoOcwwVivs7HdHRYAkEe
         lL2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pH/oHI6fF+XkrnZzk0+8BRGX3ci8zWrIwzFuAniDRGQ=;
        b=VwOCm3qZHmB6dVPDA2hGzOTonZxDT0B1NMb1B9KEXL8R2EIC6FTazVJXj583/4VXwT
         E69iilXWoZJ+sokLGbqmxzVLm8lxeT8gvQZAZF8RAEV67DIyAhqu4725USPxC8hBEFoC
         c2wPXRX91J/CHDZ4GJXh/b+AY7hD3fd9rHMKsA95kJP947iMYnEGV8diZfhZJt+XHWou
         v5zvz77JEEmLhszkwgOsDgtt8dWH0Sd9XnLOThHpWOCOTwDeGBLcI5DG1BJQxD/Tw9wU
         IzuWT5uK+5BXcV9jaipjn9CnxOmBvKQEsjOzYrxAPCzblNbvwQLaQC5+yeb8MHGIGKr2
         f/hQ==
X-Gm-Message-State: AO0yUKXJ4duQLQFR+axPVIdf4tRy9F1tJgSD6k6c6GIQXkTon5QKTfAg
        qKf2HkjlWSsNzNqk5aqLI21IcsX43e6oNF2JCbdFBg==
X-Google-Smtp-Source: AK7set+lHiPvBsT1EO6252olyerpiKyexbeJ6Gh6kVXXicvc/wZO5UmekfJHbRB08He03D1EYhVa1Q==
X-Received: by 2002:a17:902:c40b:b0:196:15ad:91ea with SMTP id k11-20020a170902c40b00b0019615ad91eamr7471667plk.63.1674666347100;
        Wed, 25 Jan 2023 09:05:47 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id z15-20020a1709028f8f00b0019607547f29sm3837911plo.304.2023.01.25.09.05.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 09:05:46 -0800 (PST)
Message-ID: <63d1616a.170a0220.487d7.7797@mx.google.com>
Date:   Wed, 25 Jan 2023 09:05:46 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
X-Kernelci-Kernel: v6.2-rc5-97-gf108f07918a9
X-Kernelci-Report-Type: build
Subject: pm/testing build: 8 builds: 0 failed, 8 passed,
 5 warnings (v6.2-rc5-97-gf108f07918a9)
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

pm/testing build: 8 builds: 0 failed, 8 passed, 5 warnings (v6.2-rc5-97-gf1=
08f07918a9)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v6.=
2-rc5-97-gf108f07918a9/

Tree: pm
Branch: testing
Git Describe: v6.2-rc5-97-gf108f07918a9
Git Commit: f108f07918a97e350e08b923311657f0fcf70b0b
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
