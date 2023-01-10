Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80B2E663C24
	for <lists+linux-pm@lfdr.de>; Tue, 10 Jan 2023 10:04:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231565AbjAJJEa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Jan 2023 04:04:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238113AbjAJJEG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Jan 2023 04:04:06 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E025C6147C
        for <linux-pm@vger.kernel.org>; Tue, 10 Jan 2023 01:02:23 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id s8so4188544plk.5
        for <linux-pm@vger.kernel.org>; Tue, 10 Jan 2023 01:02:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=pKIwW6wVI2N1pEUyDsl0YiGjHzjNxMi8/aiksEQ3WDE=;
        b=Zg19uvoxLqVAENmpDXj6k0EKS8kvVAmhlZvALjkG0uWAJMMvbVg2NTo6rLbAGZOcYt
         K9+vEm1FN5jGBOgkQtxvVGtoV1dZVXSo7LZdni3dLGAio+o0zghyd+I+g6NXOWkwyYt4
         owT8dWr6CsbDDCY57x8OhMUooYJ02WiiWj7t7VY4KN2BBu3xpMSUcvC9/XXSDe47kkRN
         hrvxDt3SWXt4cnqPzTqi9/xzZxlDWPyBNDEn3n2APngzUSPU/G/Rk4ERkv++rqBGz5oO
         7xPgGmkjoLtC9BbyE2p0NuItFlUa2pFjJdB/eyhPgQsBJ6fTm1Xz8TdW5hX8/pMtlXvy
         +C3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pKIwW6wVI2N1pEUyDsl0YiGjHzjNxMi8/aiksEQ3WDE=;
        b=75m9wGDppaLmeciIeILmk95lLFE6HtHUZ6CJL8Xq12x2El5RJxU35CCyx5fDzxo4Nc
         FgIEnn8nXb2cFSt5sUrraZIXIQdij84d80xfbEREN9MWpk8YD2Gs26gwIG6fkXGuZF/6
         2TBZtiGFt/tN05VD5lK//jFVPJPngBX6rlYo6p4cIn0iiTxWp9ixcc0nTGU8jeVuKPhV
         kPwiMEJVclbGX1EA0hm2IBPBxGiOuSU9ibU0xCyG9WqqfYUXq8benYBbvG5O77zPNZjL
         HbpClY5qiSUErY3jpUr4KFk0p9WUii71f5NjUprwjvl2dVGEy3ORYBmG5iic25TMkE+6
         c9FQ==
X-Gm-Message-State: AFqh2kqEMFPgRvXZwBdEgy1N3fBZysBI+Q5kGygcQxQYZ24e2sja6TpW
        NVWLkk+yItGrsK6IVyoWdWn/Vw==
X-Google-Smtp-Source: AMrXdXuii80e9TeAlyIJcFAif8TUQzaX7YM/d4+CJOACStr13ZxQ5uB/PDOeWaLoyJkOlHhePpMLdw==
X-Received: by 2002:a17:902:c245:b0:186:ada3:c1a0 with SMTP id 5-20020a170902c24500b00186ada3c1a0mr71616965plg.45.1673341342162;
        Tue, 10 Jan 2023 01:02:22 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id t5-20020a170902e84500b0017f756563bcsm7594853plg.47.2023.01.10.01.02.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 01:02:21 -0800 (PST)
Message-ID: <63bd299d.170a0220.18e3f.ba00@mx.google.com>
Date:   Tue, 10 Jan 2023 01:02:21 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.2-rc3-50-g4f0d85674885
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
X-Kernelci-Report-Type: build
Subject: pm/testing build: 8 builds: 0 failed, 8 passed,
 5 warnings (v6.2-rc3-50-g4f0d85674885)
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

pm/testing build: 8 builds: 0 failed, 8 passed, 5 warnings (v6.2-rc3-50-g4f=
0d85674885)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v6.=
2-rc3-50-g4f0d85674885/

Tree: pm
Branch: testing
Git Describe: v6.2-rc3-50-g4f0d85674885
Git Commit: 4f0d85674885812931426b0407cda1a33e413e12
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
