Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5937C622C40
	for <lists+linux-pm@lfdr.de>; Wed,  9 Nov 2022 14:18:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbiKINSY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 9 Nov 2022 08:18:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbiKINSX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 9 Nov 2022 08:18:23 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D092BF2
        for <linux-pm@vger.kernel.org>; Wed,  9 Nov 2022 05:18:22 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id b62so16235662pgc.0
        for <linux-pm@vger.kernel.org>; Wed, 09 Nov 2022 05:18:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/jUBUyxQHIG4WhRgeEK5Yj2PwwA3VU62q2IOEn8x+kU=;
        b=Xcgwl4LuOAOdF4oMz3ZEYtmIptZqpdW3wOb+CnZS+FT/S3yeE1s9CPtm9zNR0D5nRh
         TsyvsvpFCN4LIN5eW9H3CwRANl5PBj3EoDTcZEI1HITWHvp4xdMLn8fpHeBBYnvW2viq
         7r770nBdUbnQyussxeEegxxPPb0QiYf4L14+ERTLjUyKVntFWA+CXs05poZ2D/mRBVdM
         vIMj+RmfHVbW4jBy9REcIyvtBb3jGf3ca/IgPpMUUKCUOZ7+pTI5kfOtHMplrfZQB7wS
         g7s7YLH8gG+rlKpC7GYU1uYFp+67CJzzUQP9Ay+T+45xGcYq/W9DPIVKb1pM9cb88/X8
         P5cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/jUBUyxQHIG4WhRgeEK5Yj2PwwA3VU62q2IOEn8x+kU=;
        b=RmyOP3mqUkWnRLtuOOgKgU3iK6w7oN1blsC+CQzARjPqyUTD8dEv+rTdvakagWpnQh
         Rhcudk8BrdF7Rr5WdDFP86ytr5SN3NM9ycM1SuU1jrt1fPg2ZrGk2KmSuSiLCYW42VKW
         8UXJWNykjyUwM/Etr8uOkkosbzz+3E80QC3SlEaIQoRNJcuNvrk7C/+7OVVT1AiLAjYA
         4mEWECV3XS+8QjN5G32MDNUS0iUL1p9Qr53hqF6ziFmRDkZ7rCU6by/JAwvEu/naWBqu
         vdPsLHFMx9+KxggBRSS3IVUEWsrSAC0SK3IxXsnYxd7JiKTVX6UR2fmgOVyBFskobqYH
         WrAA==
X-Gm-Message-State: ACrzQf2LZp3u/Q+WzsbLNW0omOxiEH9oDEGe6728s7tEJNB3aG5Rrb3G
        XsWV06uNra6cRz8ASgcDiEOrBA==
X-Google-Smtp-Source: AMsMyM4tDWnDDIsRvo5BMfby85zp6tXrfvznyWlYW5K2Jf8DqphJ1fcpS/4Wnqv7picXrA9zSi328Q==
X-Received: by 2002:a63:1944:0:b0:455:bea0:97ee with SMTP id 4-20020a631944000000b00455bea097eemr53181691pgz.258.1667999901564;
        Wed, 09 Nov 2022 05:18:21 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id mg7-20020a17090b370700b00212d4cbcbfdsm1203000pjb.22.2022.11.09.05.18.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 05:18:21 -0800 (PST)
Message-ID: <636ba89d.170a0220.82d8.1925@mx.google.com>
Date:   Wed, 09 Nov 2022 05:18:21 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v6.1-rc4-50-gc4279b9e39bd
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
Subject: pm/testing build: 8 builds: 0 failed, 8 passed,
 5 warnings (v6.1-rc4-50-gc4279b9e39bd)
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

pm/testing build: 8 builds: 0 failed, 8 passed, 5 warnings (v6.1-rc4-50-gc4=
279b9e39bd)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v6.=
1-rc4-50-gc4279b9e39bd/

Tree: pm
Branch: testing
Git Describe: v6.1-rc4-50-gc4279b9e39bd
Git Commit: c4279b9e39bddbeecdc7f7cc65826a0b72e10fc3
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
