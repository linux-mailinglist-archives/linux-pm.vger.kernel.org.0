Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B11548BDED
	for <lists+linux-pm@lfdr.de>; Wed, 12 Jan 2022 05:40:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237114AbiALEkr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 11 Jan 2022 23:40:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231799AbiALEkr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 11 Jan 2022 23:40:47 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46897C06173F
        for <linux-pm@vger.kernel.org>; Tue, 11 Jan 2022 20:40:46 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id l16-20020a17090a409000b001b2e9628c9cso2462317pjg.4
        for <linux-pm@vger.kernel.org>; Tue, 11 Jan 2022 20:40:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=SuiLlpoF/0TAU/DArhiv7DTsAJJj1t4m4kdUgsBR67w=;
        b=2FnPjapL5XmboXP0JG3RsVpLgFpg1W3JeFm9a2xxwU+ccSFHPkj5I7oVPNTBBnUWlt
         Pd9z1UN41AKe4asDp1KWkl0e5m56iQbyJeYLJOhWYNv9e2zn8/uEYGVnm3zBEwzxYggy
         iiSIvopR22zoHnWrr0jzt1CqyjrEhY8jsGIaLPC5/aPPHY1IDxYJ8/CTUXmntSCHUIyA
         ikIDsbAiLITx6U+2+AwfF1e2cAZoEd+TZpG9fghn4nYkCDhab+82MQCnWi6LIa5ounqF
         W4E6sT+nMe/AR/C1JUuah1O58h5+eJy/9V1caibs8920b86VOXFc9zv40glhEsLs0pm0
         lZ4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=SuiLlpoF/0TAU/DArhiv7DTsAJJj1t4m4kdUgsBR67w=;
        b=FFU9zxXjhFYgeCOVbKIieHT8L2YCqGWxa27Jtxhnlus9PtSgJkPqh2Z3DP1TKXrDRG
         utXstv2guG+t0XzIYI0DaVnDWz45vBgLBOwCEuy9HzmuG6C/PvQ5HITIwcWng5CuvLX4
         hwkAzMTypAr0Ug8XpFOpV1nECSozgGLQEgkwlMfWwYhxlbXRYLG2ISt0JNt1xtocFkWj
         ZGsCrdrCKygis3M03sULCEM0x+hNnREb8xdCeKjhSJVe9uuY7Ce6jQhYiq3Nix9sSnXh
         KFnhPzH2JS/xjymOGoku6T2tkklvnqgnJZpOZSU0a7A/jyjNEVhgnRAzwUf2G8YmgkL2
         KaaQ==
X-Gm-Message-State: AOAM531RWMd8yEboR2x3Ytawmt3CjnxCxCNd9ekp1uRQsE8unXJErgnl
        qU1IlsqGWWJOJGKhpRCQDgHvGQ==
X-Google-Smtp-Source: ABdhPJxBQ9/i1ur0154fLz0jA8Oce9ekNitgLhRHGcsk/HIs/TuyBy6UW90iN6NJeegXmPuiTm/e9w==
X-Received: by 2002:a17:90a:4fa5:: with SMTP id q34mr6777343pjh.101.1641962445713;
        Tue, 11 Jan 2022 20:40:45 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id b4sm12776984pfl.101.2022.01.11.20.40.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 20:40:45 -0800 (PST)
Message-ID: <61de5bcd.1c69fb81.265c9.0c34@mx.google.com>
Date:   Tue, 11 Jan 2022 20:40:45 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v5.16-rc8-173-g00759929cccb
X-Kernelci-Branch: testing
Subject: pm/testing build: 7 builds: 0 failed, 7 passed,
 1 warning (v5.16-rc8-173-g00759929cccb)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 7 builds: 0 failed, 7 passed, 1 warning (v5.16-rc8-173-g0=
0759929cccb)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
16-rc8-173-g00759929cccb/

Tree: pm
Branch: testing
Git Describe: v5.16-rc8-173-g00759929cccb
Git Commit: 00759929cccbf2e508326f2d9139ca708195d8f1
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
