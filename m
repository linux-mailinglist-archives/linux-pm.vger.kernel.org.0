Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8B985AC154
	for <lists+linux-pm@lfdr.de>; Sat,  3 Sep 2022 22:19:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232557AbiICUTW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 3 Sep 2022 16:19:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232026AbiICUTU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 3 Sep 2022 16:19:20 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1269A57565
        for <linux-pm@vger.kernel.org>; Sat,  3 Sep 2022 13:10:41 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id 199so5134242pfz.2
        for <linux-pm@vger.kernel.org>; Sat, 03 Sep 2022 13:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=EvfghXpx773dNfHEgXewcxcLLr9GxGw0JDQFe1doWMw=;
        b=EsGfiEOEvFVCN1E/RK9e1+kcE3rvsJnlVJo0uh90shxO6fMrJ2u5c6HVeZcgJpAiZh
         RxJpdggLVSjWVsZya/5AB6keQKtYpRmsLKm9ueZTjBlTogIglulxuqiTrj/C+ys69ZN+
         lVkznh7Utc+HTWC7e7kCmXGmvhyO8shLkWchK8Ym7ZouH73NULkgNTtnnXnKhbswiWA0
         Jz/PA5u2QkUvZiRBqJ1Eb4BjWl50q5NGakUHKUDYPifQDH6Pa4PDR/i6OVqmZhjCLLRq
         oDClty6mG/C4dXXpLCxzZWsEyQn+N3PjTOMZpoccyRhgSJOtB6J3atISR2dt3b9mnKQW
         VxAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=EvfghXpx773dNfHEgXewcxcLLr9GxGw0JDQFe1doWMw=;
        b=GImmTaJjw5iOx6bTkIo2z2BN8GqJYv971cmMUylizD3VlCKOIWB5G3UCApCgh3/ov2
         h2TFLzBnAODjhdXPiGniSfdi9cOhQL2FyDTUbye9fvUEsg/f9DacI3FHcZXLy2LpteDF
         mrcKXPNG/8/kmZa490OLTK5UK2L2UzKBW0AUj7iqFLqCK029aj6MxE5rxNUKXTH2b+8F
         HPpgoIG0MnLYEm9pO3/UIsNADKQwvMUUwp2MfUDyAWJyeRCE7U60web0VRbpNlYodplx
         4ZjAhdc2VWzhX3SEqQcqXGvlwtvid3ixSHfOM2rJ4Sk+EAWbQwvqe994xQ9qU0QqJTlw
         1YeQ==
X-Gm-Message-State: ACgBeo0fXD2EUylvF3jm/XlFDaITsfa8MZI1xNyvP5ijJRb/OgUpiCAO
        kW8KKTBYBoxoh6VSPGBbo2lIWg==
X-Google-Smtp-Source: AA6agR7UzlVr+zwk9r5F8oEn2ocM6QDuQHV993xIjAN6PLKVERrU/BC0DCSmSCvRnPiXEkxYadyp0g==
X-Received: by 2002:a63:1f1b:0:b0:429:b4be:72f0 with SMTP id f27-20020a631f1b000000b00429b4be72f0mr35042722pgf.622.1662235840589;
        Sat, 03 Sep 2022 13:10:40 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id 136-20020a62158e000000b0052d52de6726sm4375907pfv.124.2022.09.03.13.10.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Sep 2022 13:10:40 -0700 (PDT)
Message-ID: <6313b4c0.620a0220.274ec.6bd9@mx.google.com>
Date:   Sat, 03 Sep 2022 13:10:40 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v6.0-rc3-85-gf6f4c123bfbc
Subject: pm/testing build: 8 builds: 0 failed, 8 passed,
 4 warnings (v6.0-rc3-85-gf6f4c123bfbc)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 8 builds: 0 failed, 8 passed, 4 warnings (v6.0-rc3-85-gf6=
f4c123bfbc)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v6.=
0-rc3-85-gf6f4c123bfbc/

Tree: pm
Branch: testing
Git Describe: v6.0-rc3-85-gf6f4c123bfbc
Git Commit: f6f4c123bfbc88ef6d4aa7ade3c70d57e1cbbcfa
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
    sparc64_defconfig (gcc-10): 3 warnings

x86_64:


Warnings summary:

    2    <stdin>:1517:2: warning: #warning syscall clone3 not implemented [=
-Wcpp]
    1    arch/mips/boot/dts/img/boston.dts:128.19-178.5: Warning (pci_devic=
e_reg): /pci@14000000/pci2_root@0,0,0: PCI unit address format error, expec=
ted "0,0"
    1    WARNING: modpost: EXPORT symbol "_mcount" [vmlinux] version genera=
tion failed, symbol will not be versioned.

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
sparc64_defconfig (sparc, gcc-10) =E2=80=94 PASS, 0 errors, 3 warnings, 0 s=
ection mismatches

Warnings:
    <stdin>:1517:2: warning: #warning syscall clone3 not implemented [-Wcpp]
    WARNING: modpost: EXPORT symbol "_mcount" [vmlinux] version generation =
failed, symbol will not be versioned.
    <stdin>:1517:2: warning: #warning syscall clone3 not implemented [-Wcpp]

---------------------------------------------------------------------------=
-----
x86_64_defconfig (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 s=
ection mismatches

---
For more info write to <info@kernelci.org>
