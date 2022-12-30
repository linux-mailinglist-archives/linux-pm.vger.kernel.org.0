Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09D54659BCD
	for <lists+linux-pm@lfdr.de>; Fri, 30 Dec 2022 21:02:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231210AbiL3UC4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 30 Dec 2022 15:02:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbiL3UCw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 30 Dec 2022 15:02:52 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D2A11A82E
        for <linux-pm@vger.kernel.org>; Fri, 30 Dec 2022 12:02:51 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id v13-20020a17090a6b0d00b00219c3be9830so22490098pjj.4
        for <linux-pm@vger.kernel.org>; Fri, 30 Dec 2022 12:02:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=KCtHQv7egI4yDRWdmllnbTeY5btpcZgxBUVKEqzSb7I=;
        b=mqlFk2TlTnv3isl3LfA7icES6SQ4Yu0kUlrPHVDAJv+/veCxGWt3CCQDzoywRLb1xM
         I+boelOh+Yxn3DpGtLCNEmO/GzIt+i82b9hqdtgT4I91ylYKAwxeuY5Bl0JOpVz5MuJd
         i0LcnKIDz8BvD8xr5y87P1x7HhVeVH7kQZ7PjwOn6r9iP5PIOEXx4hQsyGhRO1FYq1O0
         ryqQpao09pLzdIeWQ5o+Q8wLnS/P5tYi2bq3rsh9f+xPU9S3GF4CT7nIt+g4tTQR9PiI
         OOCBgSrrPRUs171E0IKruSbrEXNonCsQDhAzh4PAMCER03xRHBwJ98JOSTzJaoiJK2dN
         /e0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KCtHQv7egI4yDRWdmllnbTeY5btpcZgxBUVKEqzSb7I=;
        b=2yf0Y9y+z2On1bAS5md1hynjhIKKZJgjPQ588sOLPkSo/bE4qwKeozIW2WLbPszzwI
         UGvy2tqt0N1dT9y0cJTD+02oaGVET/dETt767UXt87KyUvundsfJM/HDv3dYmMvxktbM
         zSiX/TyslJx2bLlyUv5DoiKHhqz97GEp6D3PMt0v66sTgpdN8SHqe+tqBnPepI5ntT3/
         y/Qrzyp2nPIhUbZJGyHb+4ap0Hl97rcUQrAsSgiaID13XIoMXI0xuDBZXuHSzVSJt5qC
         PCb7E3zRVmXPWOvECCeMcrj0jHS40C+MbX98aLXRTqFE8f8Nxzc59NuEWaNqNVVvj2DT
         Nj3w==
X-Gm-Message-State: AFqh2kqb91myFi6xKvsVZ89sumEyJEX5bsG5SEzzQCBFDKxD0yhritd9
        URVORGaFv1ksvsOLznClwj0b5qt5Y8HSzwZiCIU=
X-Google-Smtp-Source: AMrXdXv58d6PVmOkdv9KdEVrN39m5zkzE6BNq+mbUe/eILUDuYeM4JWCFhae2obso6oqWwzbsZHFhQ==
X-Received: by 2002:a17:903:3013:b0:192:8424:c36e with SMTP id o19-20020a170903301300b001928424c36emr14857699pla.19.1672430571130;
        Fri, 30 Dec 2022 12:02:51 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id s7-20020a170902988700b0018f6e4e425dsm15260917plp.198.2022.12.30.12.02.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Dec 2022 12:02:50 -0800 (PST)
Message-ID: <63af43ea.170a0220.66044.9cc8@mx.google.com>
Date:   Fri, 30 Dec 2022 12:02:50 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.2-rc1-10-gba02147ea7c73
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
X-Kernelci-Report-Type: build
Subject: pm/testing build: 8 builds: 0 failed, 8 passed,
 5 warnings (v6.2-rc1-10-gba02147ea7c73)
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

pm/testing build: 8 builds: 0 failed, 8 passed, 5 warnings (v6.2-rc1-10-gba=
02147ea7c73)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v6.=
2-rc1-10-gba02147ea7c73/

Tree: pm
Branch: testing
Git Describe: v6.2-rc1-10-gba02147ea7c73
Git Commit: ba02147ea7c73fe7728b71fd055c9446021910e9
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
