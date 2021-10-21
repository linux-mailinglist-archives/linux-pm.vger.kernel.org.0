Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AADC435987
	for <lists+linux-pm@lfdr.de>; Thu, 21 Oct 2021 05:49:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230308AbhJUDwI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 20 Oct 2021 23:52:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230155AbhJUDwH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 20 Oct 2021 23:52:07 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE3D1C06161C
        for <linux-pm@vger.kernel.org>; Wed, 20 Oct 2021 20:49:52 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id q2-20020a17090a2e0200b001a0fd4efd49so4951161pjd.1
        for <linux-pm@vger.kernel.org>; Wed, 20 Oct 2021 20:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=Bzsb/Q6r1Zi5rdVjHI+KqXAiBXXQlbcZyUdL2/Kj+CY=;
        b=FGRA4DViWQCCQUQP38kX2cAImAAWJEgYVyeExhDm/BnXEhkg6I+OkXAFkGFzYHh66d
         5MJie56COMrqEZBrUJ/VV5SM+4sKTSsdlWyUroOdkr+eAusz/FW4BwK/MbP2qqJrM4ai
         4x+VnLAc7qn0ohdRJn0emszioaimT7/5qJfAYYHHhgJFSlTtL5gT5RiQdWd6vmVRYtig
         NgOARlWkpAui3X1fC6oNqduc+90RrJPZ1hH+wAML5DcZuO93kJ6OCku2Q4d1H6XUDhNY
         ZkBz6q51J5THO7y1z6b65rOOAIDXjm2lyc6QNZgo1NGDkOvq+dW4+P2WLej/60Brulf3
         5vOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=Bzsb/Q6r1Zi5rdVjHI+KqXAiBXXQlbcZyUdL2/Kj+CY=;
        b=GjuayJEADN4gnZ8K/02qDo5p5vDf2UpGxoRPv/rUHx0fv422zfQf4+57CEd6H84G0p
         gCeubhmrov8OoY6z8IKV7GahqMMXjDAxVPRUXiNAkcSE09qhoCOJeKGUMaESQTrrVOvB
         qwhcqvFaVls8YACgNrc+h9VwfMKgEbutHBnfkG/3agyrrthHK1XGEX9/vGnnZAgIQsin
         vcBnyZP4dY5haKX8/VjN28YHH6UV2JE99G3WikqnOr7FyXTOSP0v9dkOfBM8ncc6g7AE
         HQfY5ZQfp9UsCDiDr4UMe8FQ6SSTc9IhHlchcfxwTswjExKKA53E3w468h0ugD90zMoP
         u4gg==
X-Gm-Message-State: AOAM533aQdTbA/w4EVX3hVm1rtOXOC0YuOjl2505Mrpqm23XEIp/Cp+S
        48O9+Zvkxs6twsjoPNKx1R8C3w==
X-Google-Smtp-Source: ABdhPJxdp6Sjp+RDmqITAHT8Gr5y6s5BP1FkfrJxodvEwHYAViNxlrdz6SKAr3LRXwRwQ8rpM3u1Sg==
X-Received: by 2002:a17:90b:3687:: with SMTP id mj7mr3747650pjb.196.1634788192190;
        Wed, 20 Oct 2021 20:49:52 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id a27sm4017169pfl.20.2021.10.20.20.49.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 20:49:51 -0700 (PDT)
Message-ID: <6170e35f.1c69fb81.c6615.c78c@mx.google.com>
Date:   Wed, 20 Oct 2021 20:49:51 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v5.15-rc6-67-g7f01eda12647
X-Kernelci-Report-Type: build
Subject: pm/testing build: 7 builds: 0 failed, 7 passed,
 1 warning (v5.15-rc6-67-g7f01eda12647)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 7 builds: 0 failed, 7 passed, 1 warning (v5.15-rc6-67-g7f=
01eda12647)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
15-rc6-67-g7f01eda12647/

Tree: pm
Branch: testing
Git Describe: v5.15-rc6-67-g7f01eda12647
Git Commit: 7f01eda12647cb419b7cc23b206423de75b7eefa
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
