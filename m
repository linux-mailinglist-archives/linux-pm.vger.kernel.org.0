Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B48805EFF5B
	for <lists+linux-pm@lfdr.de>; Thu, 29 Sep 2022 23:41:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbiI2Vlp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 29 Sep 2022 17:41:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbiI2Vlo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 29 Sep 2022 17:41:44 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6E4E127C9B
        for <linux-pm@vger.kernel.org>; Thu, 29 Sep 2022 14:41:42 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id z3so1395027plb.10
        for <linux-pm@vger.kernel.org>; Thu, 29 Sep 2022 14:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=+tmmVMQIEvaUOyHizHHbvmGvhWUsKswCgzvDR2aTDBw=;
        b=WiFLoBtIO+noJncOLfpyox7S5UkLqA10l3QuicSn5JTGpRk73RDKQFpAE9rRvsEzHl
         f94Vlsfftcg7AMtKWitHm/V0uhm0HpYxaRWBlEpYllSQgPOOoTYqkNBFAQLf57F4QXar
         foUattrqgan6XVWqR1BY/BPUFwdjooYyVLIQ5ULTj5QtypcryVV/3sDBf+o/VeWICq3B
         mUcVNwQPLXQCwwnKH538Lx0vyHIrEGcmHeKNZLWCmL5gU6hRoB6APm08yGj7jeitPq83
         aASTJFmxjJqapLmYL1aXARaMVAh2V15cZELcyBeNgep9Mprs8v6AqLgZilBuZGRdaZgt
         4u+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=+tmmVMQIEvaUOyHizHHbvmGvhWUsKswCgzvDR2aTDBw=;
        b=7z2SVNlp9tyrOw62GGeRTdeljoo/cRpnQBAfw6J4DRv1ImZUDOyFrTCH+Y36YY1GEQ
         d3FBKeCQDapoNKWAGGkUhQwwTOHNuXnFhmOZUCKrPz+5wuEA3RwoZuMtPeR8oxcxXOEC
         GyGuP8hsVW4b7kmahc0h/hXYLpkTXtHcUCMvSkoHywwX+9KrS3JDqQ5ozyTH38VikwyZ
         GwtiZJSYX+oE1lqgu0aJK54VOvaqKdx55/lojM1BZHlGxhBss9g4yjnT88bTLKs4c6WM
         oth8dUyBKXjfpPPHVlelqIYEBslC7LK0SEJGnIVVszN4HunS8XKd1HKZYZAdDQkzxpTp
         epvg==
X-Gm-Message-State: ACrzQf3SAQCPnoH+7ItWsjgpOBQgEhb8nWAcQiWBfbHciM5TeFLKnHGF
        TXnVoye7GS7OLBK2+3LywZCIMw==
X-Google-Smtp-Source: AMsMyM5NAGWvW5StSYLgOkg8LMBjveehpA8BRA24eYpOb43ob+BdISSBsZfdDiMr32JRRAAJcpDCjA==
X-Received: by 2002:a17:902:6bc8:b0:178:81db:c6d9 with SMTP id m8-20020a1709026bc800b0017881dbc6d9mr5561802plt.56.1664487702366;
        Thu, 29 Sep 2022 14:41:42 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id g14-20020aa79dce000000b00536097dd45bsm141551pfq.134.2022.09.29.14.41.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 14:41:42 -0700 (PDT)
Message-ID: <63361116.a70a0220.7f9bf.0588@mx.google.com>
Date:   Thu, 29 Sep 2022 14:41:42 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v6.0-rc7-186-gfa11712315997
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
Subject: pm/testing build: 8 builds: 0 failed, 8 passed,
 4 warnings (v6.0-rc7-186-gfa11712315997)
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

pm/testing build: 8 builds: 0 failed, 8 passed, 4 warnings (v6.0-rc7-186-gf=
a11712315997)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v6.=
0-rc7-186-gfa11712315997/

Tree: pm
Branch: testing
Git Describe: v6.0-rc7-186-gfa11712315997
Git Commit: fa117123159976b3799c5738677e0489f8537abc
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
    sparc64_defconfig (gcc-10): 3 warnings

x86_64:


Warnings summary:

    2    <stdin>:1517:2: warning: #warning syscall clone3 not implemented [=
-Wcpp]
    1    arch/mips/boot/dts/img/boston.dts:128.19-178.5: Warning (pci_devic=
e_reg): /pci@14000000/pci2_root@0,0,0: PCI unit address format error, expec=
ted "0,0"
    1    WARNING: modpost: EXPORT symbol "_mcount" [vmlinux] version genera=
tion failed, symbol will not be versioned.

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
sparc64_defconfig (sparc, gcc-10) =E2=80=94 PASS, 0 errors, 3 warnings, 0 s=
ection mismatches

Warnings:
    <stdin>:1517:2: warning: #warning syscall clone3 not implemented [-Wcpp]
    WARNING: modpost: EXPORT symbol "_mcount" [vmlinux] version generation =
failed, symbol will not be versioned.
    <stdin>:1517:2: warning: #warning syscall clone3 not implemented [-Wcpp]

---------------------------------------------------------------------------=
-----
x86_64_defconfig (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 s=
ection mismatches

---
For more info write to <info@kernelci.org>
