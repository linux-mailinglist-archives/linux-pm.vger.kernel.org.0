Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A629A6390C4
	for <lists+linux-pm@lfdr.de>; Fri, 25 Nov 2022 21:38:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbiKYUi6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 25 Nov 2022 15:38:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbiKYUiu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 25 Nov 2022 15:38:50 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 908F953EFF
        for <linux-pm@vger.kernel.org>; Fri, 25 Nov 2022 12:38:49 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id z17so246282pff.1
        for <linux-pm@vger.kernel.org>; Fri, 25 Nov 2022 12:38:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=oP5qF/yJBwC7Un40qezeecPuUXmokcNpLXMO5mDLPlk=;
        b=I9TxmmqLvatoR+vlWTVl0p7xCQhPABk0XPV8NZvqvogdm+li/EbveAFefFyB/lMpHp
         7T1hZ6wnIeTIt6xxOnH9/B5YUlc3UBMnmTy9vmmabTuzwuWQ1vX9HqngrRcc2LoofB4m
         iLeh/NnZw4L80TcECmAx95nrJzsZzVVsdegWcRT1L8McfIZ4KJnFA0vf5A07pppEO8nG
         oCoO6C/SrkMNIoPBoTpxWp0ZiKYX1++ob5L/WZvb+jirp5Tr8945usFf4xxS0fRlSQLn
         p9rO/GWbg/zcWiFxtJqYRSTuHjzeYkPM51wihINZ2tXQwWjnq7dppPRVoU6uCvu9mxnj
         tY+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oP5qF/yJBwC7Un40qezeecPuUXmokcNpLXMO5mDLPlk=;
        b=4lhEZBb7+ykca4IIX0dkY2lVCJJXuQaE5qNWCs7j3uXNMa7FbjBmoOyYWhuBH1co/R
         7/wn9Zl9mMT8Jy+D0ziSpI9IIShlSD2UpanA+rOpue40LkBRGD6O7QkimI/N7Y9MFKDy
         ZhLgGmpK1hhIHsTHQ90F0+t6RiPmLKwkbQNFsCeVBSTt5rROH4TUPnSVDLgPcBK7HUND
         kiK7jBe54YYXxBG2vnm2bS/1WYMJGwLuqLFKin1WJVr8ksqTxTXVGy72ToMsQlK+bvZi
         69yrEejQe32dVJY3AYV7JmgWVNpML99JGstDR32DKhc/WezmwVxRCM1LfZj9pXZM9mpx
         4eww==
X-Gm-Message-State: ANoB5pnn1qWquQDHeiaNT8VkdReDy87R3b6E4Mtwkqyv/zLrSCC0km8x
        R5I95nN0M362bx9I8ja6uI8DEhXVCQEDMX6YSD8=
X-Google-Smtp-Source: AA0mqf5O1sTRa6gGjJeDLyr96GE4k0uHVlSk3bTd+GqB8e0W4JjdmXBAawxeQxv4Yo+EDFD6x2WyFw==
X-Received: by 2002:a63:5c23:0:b0:46f:b6e1:1966 with SMTP id q35-20020a635c23000000b0046fb6e11966mr26819078pgb.625.1669408729045;
        Fri, 25 Nov 2022 12:38:49 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id k4-20020a63d844000000b00476e84c3530sm2949032pgj.60.2022.11.25.12.38.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Nov 2022 12:38:48 -0800 (PST)
Message-ID: <638127d8.630a0220.989b5.3dc5@mx.google.com>
Date:   Fri, 25 Nov 2022 12:38:48 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Kernel: pm-6.1-rc7-97-g0b54caa6f14b
X-Kernelci-Report-Type: build
X-Kernelci-Tree: pm
Subject: pm/testing build: 8 builds: 0 failed, 8 passed,
 5 warnings (pm-6.1-rc7-97-g0b54caa6f14b)
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

pm/testing build: 8 builds: 0 failed, 8 passed, 5 warnings (pm-6.1-rc7-97-g=
0b54caa6f14b)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/pm-=
6.1-rc7-97-g0b54caa6f14b/

Tree: pm
Branch: testing
Git Describe: pm-6.1-rc7-97-g0b54caa6f14b
Git Commit: 0b54caa6f14bd6a3817debcba6285aaa870a2835
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
