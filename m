Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EE0564D1DA
	for <lists+linux-pm@lfdr.de>; Wed, 14 Dec 2022 22:35:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229460AbiLNVfC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 14 Dec 2022 16:35:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiLNVfB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 14 Dec 2022 16:35:01 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C58EE389E1
        for <linux-pm@vger.kernel.org>; Wed, 14 Dec 2022 13:35:00 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id u5so8349713pjy.5
        for <linux-pm@vger.kernel.org>; Wed, 14 Dec 2022 13:35:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=SmJdHwrNncv2zg9KAsiw1biNKVUjX6L6HVBX44gKAnY=;
        b=1DwLXnzMnRzJ2tCJ7flk7BtfPmVz0IuKuus2+V+ArbrpEw/gqNiZtdAw5EgDUfxB/7
         CVb7zIJFiWvZGMfs+wXZpv/TyvIDqrIiDq1FNIjlR/oblpf7D1OuEJJLFSzZ0jUuS5Ja
         vqMV/WsuTCGzvilp9XP6IPDqjMSHc/N2gM+TeBGhAFa8T/mxnAE0pCe8coO/cbTcvjKa
         RUhGWq3jbYHHN7WJ0EE+60o59C8USDdZwHZKpLeYC/E8bsUnKz/lvB80whWIAxfH8rOt
         CI9K9+7sju7TdTCkZLO7Exg7XcjICX2Dp1ouQ4ZXpG4bjZS8RNuxJEBZDK+ZVrPEeEEi
         bdBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SmJdHwrNncv2zg9KAsiw1biNKVUjX6L6HVBX44gKAnY=;
        b=HwQx02wmX63xGn7UDTGJNp10AdiBjaf+ESBBXJp+tZfeyE29P52TjfaTXZ0grH4Rmc
         WuqqWqWHQAZ9hU12mgWS/BGFNH4cWdEsfcqlYJu2NPCF5+slRyv2LZSiwhKtO4lXS65Z
         Ah6hkpbd9me8sUv45eUjA04HHTiEIsAOHXT8ruIYmSgNa3E4f/X9pcOTZAoeLvkouY+1
         Enbl4UD8rGArTgFdPh7joOAYjQUM+pVY21iv7wlJ2NL5bWlucv1w70yt4P6uMuuBZxLd
         1z35XINW3MEZiO8CQZBc3T8RZJvpaZlMUgI15uN5p+25kVgbi3aTskTCJKVApsBpJT6x
         D2Dw==
X-Gm-Message-State: ANoB5plWwwC9LbWnRCiI/03SJ3hop1EiqVu1PWvpXMGA7XdjXkQOGHoN
        xb2AJFCl6xmMUOTZZ+Cif1gsVUvYscEinWsaqmRw4Q==
X-Google-Smtp-Source: AA0mqf6kwPK6BAbLHnPvyq9NX1QoXEjWzo65RlVF8W2n4UPSmj19a1zjSN7ESUl2sCbrkUscgiOzBQ==
X-Received: by 2002:a17:90a:9f42:b0:219:36c6:f06d with SMTP id q2-20020a17090a9f4200b0021936c6f06dmr26247882pjv.20.1671053700311;
        Wed, 14 Dec 2022 13:35:00 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id s1-20020a17090a13c100b0021932f01929sm1793052pjf.26.2022.12.14.13.34.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Dec 2022 13:34:59 -0800 (PST)
Message-ID: <639a4183.170a0220.edc26.4134@mx.google.com>
Date:   Wed, 14 Dec 2022 13:34:59 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Kernel: v6.1-rc8-224-g02f29b079520
X-Kernelci-Report-Type: build
X-Kernelci-Tree: pm
Subject: pm/testing build: 8 builds: 0 failed, 8 passed,
 5 warnings (v6.1-rc8-224-g02f29b079520)
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

pm/testing build: 8 builds: 0 failed, 8 passed, 5 warnings (v6.1-rc8-224-g0=
2f29b079520)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v6.=
1-rc8-224-g02f29b079520/

Tree: pm
Branch: testing
Git Describe: v6.1-rc8-224-g02f29b079520
Git Commit: 02f29b079520d658643d9f1cf1d2e815bc38d396
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
defconfig (arm64, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section m=
ismatches

---------------------------------------------------------------------------=
-----
defconfig (riscv, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section m=
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
