Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EC5646BD0A
	for <lists+linux-pm@lfdr.de>; Tue,  7 Dec 2021 14:56:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237407AbhLGOAO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 7 Dec 2021 09:00:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233006AbhLGOAO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 7 Dec 2021 09:00:14 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01E8CC061574
        for <linux-pm@vger.kernel.org>; Tue,  7 Dec 2021 05:56:44 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id g19so13553802pfb.8
        for <linux-pm@vger.kernel.org>; Tue, 07 Dec 2021 05:56:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=hAvyi+spPmg68xAq95o9TIFWNnvNCb1DDFqYvtVgI9w=;
        b=JNLzw+Ek0GHpkT8f+0YpMABN5rjxUHT3BTndz5VU5/ZkKeoyTx2XJTkRk4duuPgEOK
         LTq0Tv6ICNnegMQtFSegYLvQ/Y66+UUVXndoT2UFIpOZsL2BoMf3qZOf+JuRBXtVie0s
         HyIjqyKccJnnHxsUMRClpiER/jfG+a5PMzbIdxLrs35PmSy2h6jhIWue02+rIKYVCiAy
         2tx/KEnUnr171mnhzBc3e4bSHN3vcTQtH/HPGVecvI9huUkiz4oL8487aCedqbJLyYxA
         l5dB1eo4fDrj21kJzWJXHVSUBwokmyoWCrt4q76XYYUxuc3fEWN7tg1hLEd5R7GZQ4BO
         Bd9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=hAvyi+spPmg68xAq95o9TIFWNnvNCb1DDFqYvtVgI9w=;
        b=b1kvWVeWzhsQF+mgJhhwDDUQdWkcwfzpmaKoLAgHCPJVLxX5nVo46HaYfmW2QByFte
         7Qszyqq124x3STUpLQp+H5IdllBfD1XOXPHe9xYCzfFJIZ4RdEMzra1abwUsijV0h3jY
         DzkWEER+dvKKi4QilxMJZ2tpXXD4PpjEVhyUc4BZpJg0mxAgai+eqh7rhMg0n3E3V4L6
         obogFEaT5KQVbKZPlXrMgbc/Va+Akey8imdgJrHQ3PuHpHWjY/G36n4d6a+fUIvfJx8V
         v+9A+t/QFhgJ5Lr0f/+gXgA7ksmshtXeBMbDIPBVgnHuZW2Rywjmn69IlT2LU6JXD7On
         JvxA==
X-Gm-Message-State: AOAM530LsyIZxjm5zhaq9eWI1YOkfBHXwEd2D+o67Au6qJM4IVSZPd1y
        aCyGiz4OFHzTTAov8gBxfDGRlg==
X-Google-Smtp-Source: ABdhPJxV6LnSiDJqjynvB/fWtlbkUqHMmQrQNmdGnMCb1XuFNK/UTeNYxmG//sN+NF3X6ySpyv3VrQ==
X-Received: by 2002:a05:6a00:1a4f:b0:4a3:3c4a:b708 with SMTP id h15-20020a056a001a4f00b004a33c4ab708mr43064586pfv.29.1638885403419;
        Tue, 07 Dec 2021 05:56:43 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id g22sm17414407pfj.29.2021.12.07.05.56.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 05:56:43 -0800 (PST)
Message-ID: <61af681b.1c69fb81.90589.0412@mx.google.com>
Date:   Tue, 07 Dec 2021 05:56:43 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v5.16-rc4-36-g3a18d25cb836
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
Subject: pm/testing build: 7 builds: 0 failed, 7 passed,
 1 warning (v5.16-rc4-36-g3a18d25cb836)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 7 builds: 0 failed, 7 passed, 1 warning (v5.16-rc4-36-g3a=
18d25cb836)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
16-rc4-36-g3a18d25cb836/

Tree: pm
Branch: testing
Git Describe: v5.16-rc4-36-g3a18d25cb836
Git Commit: 3a18d25cb8362cb785028df7691a63325aaba356
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
