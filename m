Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1487467CEC
	for <lists+linux-pm@lfdr.de>; Fri,  3 Dec 2021 19:02:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353478AbhLCSGS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 3 Dec 2021 13:06:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236479AbhLCSGS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 3 Dec 2021 13:06:18 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35507C061751
        for <linux-pm@vger.kernel.org>; Fri,  3 Dec 2021 10:02:54 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id x131so3578907pfc.12
        for <linux-pm@vger.kernel.org>; Fri, 03 Dec 2021 10:02:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=lIy+dbTpVSQfqD4YPrbQ6d+23xjXBTs4z50Kil73oGA=;
        b=VdNt3LGhcKIY7hyfVu3E/VheMWYFqG8yPuO3AykFrJ7Vy6yHSUUu/tqaq4Es5tx96e
         /EPwAhm0TD2O5Yq2Nrk9TwZxPsB10m6f3nxeQ5mzxz7V8wgDBxVTJ4wi+pxKOezERuys
         EO2KnxaBHtyA4X8WN15sX+yF2+ly/O/fdBzIsvMy+adBTRnhPjoKWdcPOUVuQfFTcieU
         fxSQlamEwtcdk98OQi/xY2kjHy+S6xUDxXv70q1PYrDE2ZTOHmCt0EE6V0ZAtyg6CGh1
         6lOD6enC8oxCBfZhRE22RmpDwXecWHFCAakLsSAWrEyDCEfUXNphYVwz+vn2I3XnSJDf
         PQ/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=lIy+dbTpVSQfqD4YPrbQ6d+23xjXBTs4z50Kil73oGA=;
        b=vslb6aFIIynONKIHwDKacMMUJY8RAdJOaVjrexIliePGbh34pXAh0DYVKM2r7Iu4r1
         yIndtdZFLvXmyDN8+EAUTXjU6y22uSv9QQgXyWEIjtj++84nPHJyqZdZvHySOB+vHOl7
         5xyfgaXKUQP2aPOkWgCKomgwY6lYhO61QlPAG6GORRRLwG/mGUPUSnOQ6Ze5ui4JZIZT
         WaNEPKgUc9TJNpGiiEfwjP4wdXFb/SA3GFVp9FDr+Yzmf7umBWIdu/CLHRYk3XyDQV5A
         5MQbmJupENOKOFO92FeARkSvPesPfVy1UTRqmJiuWf4RTrw4gGhghguSbQxTll3IuVIY
         JmFg==
X-Gm-Message-State: AOAM533gT+A1N8Oy9ezpnetLaQgHG98Z5LCVYEE95p8Zfe2BRRJVUw9R
        RcEim/d8toL53oxYkJsrlHsfng==
X-Google-Smtp-Source: ABdhPJwBobWH3rjy5/MG2xANkUa9ueI486cst8dodjRQ1+ik38xe/k1qkAcBkMw59m2m7MsfBR5acA==
X-Received: by 2002:a63:135a:: with SMTP id 26mr5641593pgt.87.1638554573624;
        Fri, 03 Dec 2021 10:02:53 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id m15sm807008pgd.44.2021.12.03.10.02.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 10:02:53 -0800 (PST)
Message-ID: <61aa5bcd.1c69fb81.9d1c8.2816@mx.google.com>
Date:   Fri, 03 Dec 2021 10:02:53 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v5.16-rc3-46-gece4fd2617f39
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
Subject: pm/testing build: 7 builds: 0 failed, 7 passed,
 1 warning (v5.16-rc3-46-gece4fd2617f39)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 7 builds: 0 failed, 7 passed, 1 warning (v5.16-rc3-46-gec=
e4fd2617f39)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
16-rc3-46-gece4fd2617f39/

Tree: pm
Branch: testing
Git Describe: v5.16-rc3-46-gece4fd2617f39
Git Commit: ece4fd2617f39375db84639369c9a41baf2b3209
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
