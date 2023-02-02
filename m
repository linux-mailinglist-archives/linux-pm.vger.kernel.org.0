Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E71096884A2
	for <lists+linux-pm@lfdr.de>; Thu,  2 Feb 2023 17:40:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231970AbjBBQkY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 2 Feb 2023 11:40:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231895AbjBBQkN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 2 Feb 2023 11:40:13 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08FAA6EDD8
        for <linux-pm@vger.kernel.org>; Thu,  2 Feb 2023 08:40:12 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id b5so2401648plz.5
        for <linux-pm@vger.kernel.org>; Thu, 02 Feb 2023 08:40:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=UzFYk+2vaw0doT3oO8ac7sZkyF9o9zexjbvqz8Rc4vo=;
        b=XtOcLLnx3rYpr5emn9z3AwpCeZrGn0W/D6cQ1LKX3zGECx6DehDpwWAmWHO3GSNZV6
         8BOZh47V5aLtxDh65QaGWy2LfKImX/ykz9blggMFhsabo3VCeXbJZnOm4B7e+YFCW9Cz
         3H1ECDR6QAYUvUYn4lT4Eu2kaQoaT83NrWrccXjfe6jVEki4Y07+P72SX7kORVQxzQVG
         vs0dQLDRF+KrXmh5z3MrTz3IJlT/AU+10r8xVGc9T7KJTKD1lPAAsoMuKiYct1UIyAlA
         dyHu+G2OVspiqkvidj1OcqnFtJQvIVoEK3JF7i3RN3/uXtS5Sa0Ze/np8+FvSXfGwhJg
         iDIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UzFYk+2vaw0doT3oO8ac7sZkyF9o9zexjbvqz8Rc4vo=;
        b=vkhIazupsBs9ZwNfkqvdinUSGzNMZndWBIQsDQQYNHh9CFMdIx51PhOqoUMUEKyhK0
         VxB8rFD+bHogjCRXrUVe+sG4cPnuwxlupGNIOgnDvvanCIP/SwNIGgRVVtaNiplq5vmq
         44pS+4+pGTeQ/CBOiAl8DnWE3E0y+n2NaLioNfB7qF+dgzd5UYm3h2+LFCD8q4nxhu2T
         38OPLE0CP5t60WxZGFenXt5D+8Mxqfj7jmy0TREYsUxpBg/zOzOB50FZDGjj6CYo99Ng
         oWTdZ8z/3Td6FpbZI+mcw4sP15b2GfkuMULtER8qdwXLGsq32/7QMoqtJWUgTu/Xyy5w
         Eozg==
X-Gm-Message-State: AO0yUKWzrXeiA5nTq4Eby5sExW6tMWvIIMHvGSuREQ1sm0vDuz51xBMA
        px00GHeYMbTUZDkryxjGWZIJ7Q==
X-Google-Smtp-Source: AK7set/s6kNM3yKXoOkwW2SAuAM1Ed47917/jMGwYRpgHEy4/YMGrYswzA2xJ3i+ahGAE240mGMIfg==
X-Received: by 2002:a05:6a20:b2a5:b0:bd:13ff:7b46 with SMTP id ei37-20020a056a20b2a500b000bd13ff7b46mr6126123pzb.33.1675356011504;
        Thu, 02 Feb 2023 08:40:11 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id a2-20020a1709027e4200b00192a3e13b39sm13926470pln.264.2023.02.02.08.40.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 08:40:11 -0800 (PST)
Message-ID: <63dbe76b.170a0220.996ea.9256@mx.google.com>
Date:   Thu, 02 Feb 2023 08:40:11 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
X-Kernelci-Kernel: v6.2-rc6-147-ge09c4cd57910
X-Kernelci-Report-Type: build
Subject: pm/testing build: 7 builds: 0 failed, 7 passed,
 5 warnings (v6.2-rc6-147-ge09c4cd57910)
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

pm/testing build: 7 builds: 0 failed, 7 passed, 5 warnings (v6.2-rc6-147-ge=
09c4cd57910)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v6.=
2-rc6-147-ge09c4cd57910/

Tree: pm
Branch: testing
Git Describe: v6.2-rc6-147-ge09c4cd57910
Git Commit: e09c4cd579105a55d4014420fdf8af20378de87a
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
Built: 7 unique architectures

Warnings Detected:

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
