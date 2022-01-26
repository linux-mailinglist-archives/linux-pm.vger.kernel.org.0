Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54BAD49D3D2
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jan 2022 21:49:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbiAZUtE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 26 Jan 2022 15:49:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiAZUtD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 26 Jan 2022 15:49:03 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 848EAC06161C
        for <linux-pm@vger.kernel.org>; Wed, 26 Jan 2022 12:49:03 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id y17so650197plg.7
        for <linux-pm@vger.kernel.org>; Wed, 26 Jan 2022 12:49:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=A8DeV0/pdrx+2Ob4ZkErYjdVQQiIGwgfTGEE+HcI6C4=;
        b=aoudvhsFeK2i8iUCaRh9DeH7aCJkz6GuhzR6HXCF3xGhUzEH1/5OIEfDpolwNCudYh
         98T2bb7uFyx1Pv5x+lmrRQ60aXbngImGdJbCdv/ltFPawAVXUTa50D0Wav4o8BQIaSNS
         0472JOVbsWGosJodXDsSXbY43piNgLQXxCnMy4P4rz5dzfU66FBLj83gciA9CT4tnLNF
         KESSWPnD2YxOw6ZpnSgvvff0XvFn/yrtKrJkXDQHfCQnt0SNnc0zPFF+oN40BtrMv7Lj
         ljTXtS/9BJwsL9AAlFXccf1LYAsWTMgzim9cqbDdBqraVZuZrr4uMRRhs+bpTzLUtEpZ
         Eagg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=A8DeV0/pdrx+2Ob4ZkErYjdVQQiIGwgfTGEE+HcI6C4=;
        b=dJ35vcgppCFWe5YTGv3TDP0VVCFM7fzOV0bzmJk8/y70Z3Nb8IkjIuwVxPVVXPK5qF
         5yfq2z1vekHN/38P+GPwBD0Ird3yGz+DK4zo7tvre0M4/R44mpQHqPBi2bPgqkyiUVbp
         qQKZHPkO6Z9tYynn6WV8CRQWcGmzdPBdUwi9QILUi9lrLJY/SaWhX8wFFn5EWk/wWSmr
         iKpgbKMZNcSmFWN34jxCFjbGp/Z9jju6MQSrcnSDYhu9oZi58lIDilPLtd9i3JX5G+tQ
         Js+Cx2ADAsdz3vd2PpzDjpQKhKKwCuFzVgHX0ouFRj30tIdX9hhJK0aFZnHOqnD6oeac
         kAUA==
X-Gm-Message-State: AOAM5332g1P1uiaiYPT/Kpyop5kpZUkA0aHO44jYLK5XJrd0ecih/jG0
        tEZ59Z7gyTFuam8isqV9GRKTGrkEaILIRD5SlU8=
X-Google-Smtp-Source: ABdhPJx6sgFk+oqVQz8vRT2h76R0GS0Pz/4pBWy/i2wkAraVIvngQk538iJF+ygoG2CJ3ES1oJ6b3Q==
X-Received: by 2002:a17:90b:b06:: with SMTP id bf6mr10312705pjb.61.1643230143025;
        Wed, 26 Jan 2022 12:49:03 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id qe15sm113353pjb.47.2022.01.26.12.49.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 12:49:02 -0800 (PST)
Message-ID: <61f1b3be.1c69fb81.8530b.07ad@mx.google.com>
Date:   Wed, 26 Jan 2022 12:49:02 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v5.17-rc1-9-g52d883c7bbae
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
Subject: pm/testing build: 7 builds: 0 failed, 7 passed,
 1 warning (v5.17-rc1-9-g52d883c7bbae)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 7 builds: 0 failed, 7 passed, 1 warning (v5.17-rc1-9-g52d=
883c7bbae)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
17-rc1-9-g52d883c7bbae/

Tree: pm
Branch: testing
Git Describe: v5.17-rc1-9-g52d883c7bbae
Git Commit: 52d883c7bbae11e5f06311eae7778db69bc4806e
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
x86_64_defconfig (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 s=
ection mismatches

---
For more info write to <info@kernelci.org>
