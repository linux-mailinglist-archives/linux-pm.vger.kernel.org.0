Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1843F66651E
	for <lists+linux-pm@lfdr.de>; Wed, 11 Jan 2023 21:54:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231307AbjAKUyQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 11 Jan 2023 15:54:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234534AbjAKUyE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 11 Jan 2023 15:54:04 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 076683FC86
        for <linux-pm@vger.kernel.org>; Wed, 11 Jan 2023 12:54:03 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id z1-20020a17090a66c100b00226f05b9595so3458566pjl.0
        for <linux-pm@vger.kernel.org>; Wed, 11 Jan 2023 12:54:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=WwvpFWYIFHztPrRh/A739QSc3S2L4ur4AW317iNFW8A=;
        b=gJyh7XXQzK49F70lkEkQy9/gQyL6ErkXGmWm2MdmryTLZSuuVBpmkCTUrc97ShaoMD
         6OE4o0xC2hOLh3AQKhyLKESnnbEM8ihKNVtLQ2u8TQBFri53x3EC/HGgwU52Lj993tYG
         hjhQly3235vp9YskbYpvaPdqw62W+W428rl07KhsxSUAV+JGTEgsyeNJcxzj0HFeO7sX
         Yi+clGXEyoFsZJhQ32Xz0VDDGgSBbtnN3/DVh4fmYkNkrCBaLLuzBWI4xDkqPKckZLzk
         5PwuRBpYzPvgoHvSYnCZcb+E6rtwVMYnILZ/2QsOehQzKb4Uw2UbUDHD588zdqvKtUvd
         pb5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WwvpFWYIFHztPrRh/A739QSc3S2L4ur4AW317iNFW8A=;
        b=7TSkxi4ePQosu8+tQr6Iy7YwaI32BY4zyu6WT0nFYrbuuqwT0LbDtvztEjWekaSnAZ
         96nGRwzFM2xOTxIwq/pb/F/R+OZaGtM31d5ZohHNUn4y2GFgS1pCnZGePBkTVLGftPB8
         zCWKwwteXvEAzRL5E8ytEx8bjD0ejiQ8T4WHq+/TcBfy6uxdq9wY3SjejgLCsXjE3IeX
         RnrKgH1bcKTMHhW/e11gZdZnv0bjgvrxe9JY/XjghOQqIJ06n8SuiKOaHPMYgTIVYl2I
         OfWqA9JPvXhwNiAAldhEg/gqya+E3Qk7Hablyq2wzPe4pLDF/dvqvSisEXq6ZDAHXdPI
         4OMg==
X-Gm-Message-State: AFqh2koVhj4G1R4ai8VAu/METnlclN7Rs1Kl6li33tJkuWSkDYHvQqt/
        tnpezJDZGAZ41/Pw1AIeQioTWg==
X-Google-Smtp-Source: AMrXdXtrGAZmU6o1gcfng+RU79YOwlPLjexc22+V7bIZ8VClJaFhzYSUBDkkz/UlT3Er+c0Spd9c6g==
X-Received: by 2002:a05:6a20:5490:b0:9d:efbf:48be with SMTP id i16-20020a056a20549000b0009defbf48bemr106327341pzk.2.1673470442551;
        Wed, 11 Jan 2023 12:54:02 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id a4-20020a63e844000000b004b6c3d7aa21sm1904922pgk.8.2023.01.11.12.54.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jan 2023 12:54:02 -0800 (PST)
Message-ID: <63bf21ea.630a0220.c177f.3692@mx.google.com>
Date:   Wed, 11 Jan 2023 12:54:02 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.2-rc3-79-g837dc62247d5
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
X-Kernelci-Report-Type: build
Subject: pm/testing build: 8 builds: 0 failed, 8 passed,
 5 warnings (v6.2-rc3-79-g837dc62247d5)
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

pm/testing build: 8 builds: 0 failed, 8 passed, 5 warnings (v6.2-rc3-79-g83=
7dc62247d5)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v6.=
2-rc3-79-g837dc62247d5/

Tree: pm
Branch: testing
Git Describe: v6.2-rc3-79-g837dc62247d5
Git Commit: 837dc62247d5e50a0724af2001f070962300c87e
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
