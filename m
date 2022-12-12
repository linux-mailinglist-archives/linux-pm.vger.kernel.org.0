Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DF2364AB8E
	for <lists+linux-pm@lfdr.de>; Tue, 13 Dec 2022 00:29:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232978AbiLLX3o (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 12 Dec 2022 18:29:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232611AbiLLX3n (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 12 Dec 2022 18:29:43 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41DB11AA06
        for <linux-pm@vger.kernel.org>; Mon, 12 Dec 2022 15:29:42 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id c13so1031057pfp.5
        for <linux-pm@vger.kernel.org>; Mon, 12 Dec 2022 15:29:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=kxRCcZeXP5wunzbOgRNWC95RoWdHGih2CvP8S53b49U=;
        b=u1ptlhYqxMpkYuAhNdF+//Qd28uugmDGcNttPBnIHJPiy+BPPntsgGxclDL+k82000
         c6hGuL9LDJi4luBiJrzcPC7iBYNDgfkGNmbh9ZG14nGS3dReexIgNnUUfozGTPMlrLjz
         GR9/fg/CZZ/fGyjjHsnhbt2qX82QxeYANQovwupol6joGoF4Nn3PmZML9Q9rJZJ04BnA
         qMuUey8md0YqaGEuF1AIeq1hIn/xqyfpgA+gqOt5P5eY7ilw5BQGIFF6yhqtMtz89jsO
         bNL9MDaqX+nz6U2AjgiRPNNiVKUsEFY4auSkGl1ICTUq6jVh6MhH/705Rmn46dmwUE3M
         7DTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kxRCcZeXP5wunzbOgRNWC95RoWdHGih2CvP8S53b49U=;
        b=rMn4ynhrj8nj52vgKIPuRZ3EwV0EX9ffO0iqpfqN9ycgpmyyEAygPcl148eogahOzw
         yCUTv3tUgGT9e8h9v8vh6Vu57KpPNLB2XYS+XDUN1m2KE96EKhqcVdNFYcrGZOKyZl95
         jvclwtqJxl0TGOsY72evpD9GYyr0Uu7oRSmklfUtJ4Vw5clts7uUOHYCI1ibUqrXn3mL
         eSoM6Y69SBMUqZdA7jeGSAqSi6ugrs7SQuKrE/MUQcUHT3RD1KPHwxPgLFRZmdNTOgb3
         ApSo50C0/67VsOMPUUkJIXGzUQ2wlo5P4xDZwfOxwo/ghY3ASgyPPioRiWPMFyE2v28C
         EDcw==
X-Gm-Message-State: ANoB5pn2LK/RDJKyJ08E7AdyOvTM0FY89SvDVhCmwYBr66u4tkrGwBQH
        OHpkdidjK93gOpOyLcurIe8JBWJozjXF4yHIeO2Tog==
X-Google-Smtp-Source: AA0mqf5jt1IyJdmTi7ED4cAgNxjK4JMnyj7LR6aX51g4KPmJswNVzLpXDc0gxfs9JUvwwHildywb7w==
X-Received: by 2002:a05:6a00:1411:b0:574:a541:574a with SMTP id l17-20020a056a00141100b00574a541574amr21121386pfu.0.1670887781768;
        Mon, 12 Dec 2022 15:29:41 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id x3-20020aa79ac3000000b00574ffc5976fsm6315827pfp.159.2022.12.12.15.29.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 15:29:41 -0800 (PST)
Message-ID: <6397b965.a70a0220.526ad.b49d@mx.google.com>
Date:   Mon, 12 Dec 2022 15:29:41 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Kernel: v6.1-rc8-185-g25f35436e149
X-Kernelci-Report-Type: build
X-Kernelci-Tree: pm
Subject: pm/testing build: 8 builds: 0 failed, 8 passed,
 5 warnings (v6.1-rc8-185-g25f35436e149)
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

pm/testing build: 8 builds: 0 failed, 8 passed, 5 warnings (v6.1-rc8-185-g2=
5f35436e149)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v6.=
1-rc8-185-g25f35436e149/

Tree: pm
Branch: testing
Git Describe: v6.1-rc8-185-g25f35436e149
Git Commit: 25f35436e1490a17b9e0ed35c727af082cf00069
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
