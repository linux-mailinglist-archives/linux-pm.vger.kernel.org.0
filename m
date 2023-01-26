Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB6E867D2E2
	for <lists+linux-pm@lfdr.de>; Thu, 26 Jan 2023 18:17:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbjAZRR1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 26 Jan 2023 12:17:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbjAZRR1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 26 Jan 2023 12:17:27 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91B0B69B26
        for <linux-pm@vger.kernel.org>; Thu, 26 Jan 2023 09:17:20 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id 88so2147337pjo.3
        for <linux-pm@vger.kernel.org>; Thu, 26 Jan 2023 09:17:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3LdgpTlEgty1WnHkAxeI7hHxiUlX7CMtzCAZFT80kVo=;
        b=dBQOuCT+f5rAuaJgafkIxH5eUXKdTq0I1XZ0XkHxe3iL6PGy9KSZZg15IoUlBEno+B
         rZ9v6tq8c7H4RrcGawC2jb5XYV+Bllzm5vQRKIb64qgDflMNwMNonzfnfYMHkRk8fWR8
         GSPXWFJJI0subQGjZWLCLeJUpjbg/mR6jbXLshLiOST6KY+qZzY8mj58YuKMFbA33BTK
         KcYgNnxUb+tjwo0JE2oNNcTf5gXiS5PNY+Yptwq4Mw+X6Mj3I0ixjN127ZZK+LeONC6D
         n8tZeYmhZcPKJ4i/Il8ySnoo3yzUpPSr+Xua5rTCGYXGKoE3VijSem+JUxImtxXiFpqc
         4Wig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3LdgpTlEgty1WnHkAxeI7hHxiUlX7CMtzCAZFT80kVo=;
        b=3SwihfWbjXB9Fk17VtsutLmnpFQ0ipXer775tOrMd4cdpmhJZ4wBEEnJNrOvWDxqJM
         3MgWUxr/yMGh6yGJkGGuqD1olSgKvMGBBhC3iUziBBfgPPXHLmhdb1j/mgatT+7o5ifY
         YKq7K9pEb4dOjr7V542+T/nrW6ummrckfgKkkzdbBJ1GNTo7PvnZW5sAdtQFXZkMMAac
         HzsVePmCOQIFYxefqmxDgLVTii0l3SZJqpBUpITI56GnB+nd4Yo3X1Woc2tfMw98U58K
         h7vs6ajfokeEfjbC/NRLajpnrdCAtK59Xu/8PbAa8E7bTNRnB0bB+Nk39mhx0njiPT18
         YDRw==
X-Gm-Message-State: AFqh2kqsxFQKMKSQd1GUVZbSAU88ses0PAlbr+mEf+Rf/NQk9kD2eh/M
        Y9azISvEXQRAtl9FVtrQ2EikLw==
X-Google-Smtp-Source: AMrXdXsl2ZkpqCJXn8efjbAeLKqEm4t6woQp7cZUbGGnEdcVR3RbQcpvFXPN3CBjPVsXAMJSzc05ag==
X-Received: by 2002:a05:6a20:3a8f:b0:af:74f5:93a3 with SMTP id d15-20020a056a203a8f00b000af74f593a3mr36406329pzh.61.1674753440033;
        Thu, 26 Jan 2023 09:17:20 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id q9-20020a656249000000b0048f8efc53a6sm913023pgv.80.2023.01.26.09.17.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 09:17:19 -0800 (PST)
Message-ID: <63d2b59f.650a0220.2f1d9.12fa@mx.google.com>
Date:   Thu, 26 Jan 2023 09:17:19 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
X-Kernelci-Kernel: v6.2-rc5-104-ga91e079a2f6a
X-Kernelci-Report-Type: build
Subject: pm/testing build: 8 builds: 0 failed, 8 passed,
 5 warnings (v6.2-rc5-104-ga91e079a2f6a)
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

pm/testing build: 8 builds: 0 failed, 8 passed, 5 warnings (v6.2-rc5-104-ga=
91e079a2f6a)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v6.=
2-rc5-104-ga91e079a2f6a/

Tree: pm
Branch: testing
Git Describe: v6.2-rc5-104-ga91e079a2f6a
Git Commit: a91e079a2f6a26dd09fbd45d53e03e7c089282c0
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
