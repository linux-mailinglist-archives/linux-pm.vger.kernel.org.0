Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E726D678EFC
	for <lists+linux-pm@lfdr.de>; Tue, 24 Jan 2023 04:27:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231733AbjAXD11 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 23 Jan 2023 22:27:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjAXD11 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 23 Jan 2023 22:27:27 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0370713DE0
        for <linux-pm@vger.kernel.org>; Mon, 23 Jan 2023 19:27:26 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id f3so10487890pgc.2
        for <linux-pm@vger.kernel.org>; Mon, 23 Jan 2023 19:27:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8qxvWcnCnvWdT3eJKtloyxk5EqFL0pckgmBu79wF0ew=;
        b=KJnCyiMemQPsKigQePFQ3YxTTJtBRMZvLpzw2YiPOCK29vgI6zn2iI5hsKO8LGP4x9
         DoBw+qJ8JLLnJVIEPbxF5IolujxUuRwxsK8b95Aym4CQJ8NSTbkIKbPxHmr49R6I86bs
         tuTR74GSApy0OJSpXaISGRSbUvGRtQELreM6qj4U0lgl6i8MRr653/wBZrCjiTfIN7n2
         eLkSIEB/fY2yxSnr+z5pRrT/7NEcAMrbrjM8FsrcWcc/SEPrUqO2N7wIm5gQHXyJeONV
         5NpFjLXouq/Gn/Jb6e1G2QWDx4jrlTYBi4W6xw7IITrLlN6ziekDObBJiScXB85vAD65
         jXaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8qxvWcnCnvWdT3eJKtloyxk5EqFL0pckgmBu79wF0ew=;
        b=y4hIReVMNRquUJbkFjmuYghVWEZmehX6ILFoHfVVT6mm9WgqcBIsk57Khes5ww/+St
         JsuN7uzzy68C4N5jZkSpwlbr+w/vAzfBgyaayuKjzDo2JtT7iNgaLFhrEnJgpkl5lOdj
         hHakbrFkbvkahs38PRgGMH/qZbjjWifcJ4ngy0+uKk+v33HEYJxToYr+XyPXDKj3/sEm
         dWmbaeWfJ+fgJ4X63sA4P+xtw8dncH523RhechWefk6SzuSj2JV96wHlOR/mHx6fLU2L
         VNbrIcVRsTeea8sm+AVMz5teVtlrVCW9GNPtqd0SbCoSlImgl57MTxZCy8gvnoXVfttC
         cN2w==
X-Gm-Message-State: AFqh2krdUce4IJ47qyMPRHieyUgdloKZb5rVQ0+HgQF0i1mP2rEpT1FG
        jfcN7mPSfvYtCJ75lxvqWRvJag==
X-Google-Smtp-Source: AMrXdXvFkDJ+FSk2ITBvvUhRCygisoCiKd/x5M+qTq+VP5ZTVPGAerF1JLV3HVGqqcIzZ0NESqh+pg==
X-Received: by 2002:aa7:9f1d:0:b0:585:64d2:54a0 with SMTP id g29-20020aa79f1d000000b0058564d254a0mr28255235pfr.24.1674530845562;
        Mon, 23 Jan 2023 19:27:25 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id w200-20020a627bd1000000b005897f5436c0sm340094pfc.118.2023.01.23.19.27.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 19:27:25 -0800 (PST)
Message-ID: <63cf501d.620a0220.da364.0c96@mx.google.com>
Date:   Mon, 23 Jan 2023 19:27:25 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
X-Kernelci-Kernel: v6.2-rc5-85-gfaa268e6daed
X-Kernelci-Report-Type: build
Subject: pm/testing build: 8 builds: 0 failed, 8 passed,
 5 warnings (v6.2-rc5-85-gfaa268e6daed)
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

pm/testing build: 8 builds: 0 failed, 8 passed, 5 warnings (v6.2-rc5-85-gfa=
a268e6daed)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v6.=
2-rc5-85-gfaa268e6daed/

Tree: pm
Branch: testing
Git Describe: v6.2-rc5-85-gfaa268e6daed
Git Commit: faa268e6daed6058e936eadcafe41f47507a02d2
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
