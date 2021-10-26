Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 062B843B407
	for <lists+linux-pm@lfdr.de>; Tue, 26 Oct 2021 16:28:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236535AbhJZOaw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 26 Oct 2021 10:30:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236534AbhJZOas (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 26 Oct 2021 10:30:48 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9079EC061745
        for <linux-pm@vger.kernel.org>; Tue, 26 Oct 2021 07:28:24 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id i5so10451366pla.5
        for <linux-pm@vger.kernel.org>; Tue, 26 Oct 2021 07:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=XgQOjdhWlWS1JTIGhmvX93LnReMyzeiM7Ei0pIfdX20=;
        b=3nf+3J7D+/lbkCimYyf7eSvrWkN3yOEijXaVww8F9eWDpe97dAlpvgBhFoehbrHVi4
         pi9WhFmGL9qlhqv8aBTzVtv73X4J8ENNTcrEVIu8L/T0+JN17AxsFla10WvwsgxKCwJ1
         pBELUv8xjVJWfEHaCUIQkHIsFRgzSqu/yscCjR6vEretdjmxpfVIKG+svBEU3y5ZBAJR
         A1KOsTsPhTFEtOyvApMIY4ekyi226+abTMZGB73noIyLGdXQQRx2jlPh6Jd1sSgDBqfZ
         zf7DUW+tMie6bjyycivR/IaLlgVBlDqDRzHyTBoEkJQbSVyNhBYwXwn4s7lyCopzT3/J
         I9Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=XgQOjdhWlWS1JTIGhmvX93LnReMyzeiM7Ei0pIfdX20=;
        b=EWmFPsuYJZLBfdRPUnRUvFMq8Sc2zwZTcgxjcrcFVkQTCd1e7rJ9RGIykQhmm1waje
         x+4JtQsa7POEObWXSnX2UW1a/Nr9HbREJAC4wLdFQBI4vRsGpCb73k159bmcNgsqFDBB
         AsFg2Edafui4JEApMgyQ0Uk+RznM4hi8S+pCL+DBN60h/iYKA1bK/m90tT59yjklzz2f
         sDGPOWNwGIKGidow72Jnvfc0wCeFusWIWupQUyo/lnjCSG2KNnzqqqkp2lYWHdTzuPO8
         zPczVjWpQaduUrOuiW7t/Cki8nFwcKcB+WaNtBJN6IJ2F0s0vx8gVP0suE/4TaRWI374
         VyYg==
X-Gm-Message-State: AOAM531OJU9m8F6+RS3NLlXtFlHCGPBIEX7fGzgvO5XYObrwaw0MP0oY
        XWbMijWkSGfSM7pwOqcZ42GlWQ==
X-Google-Smtp-Source: ABdhPJzG2pVtci+TPXov7v2h0OChmztgkMs4j5eYXPlfNboVpucnjdBxwg0khdKIkbttk8WSszGriQ==
X-Received: by 2002:a17:902:e849:b0:140:200a:a9e9 with SMTP id t9-20020a170902e84900b00140200aa9e9mr22479032plg.77.1635258504084;
        Tue, 26 Oct 2021 07:28:24 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id o9sm9965795pfu.95.2021.10.26.07.28.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 07:28:23 -0700 (PDT)
Message-ID: <61781087.1c69fb81.3d692.6f0b@mx.google.com>
Date:   Tue, 26 Oct 2021 07:28:23 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v5.15-rc7-95-g5ae5ac40021d
X-Kernelci-Report-Type: build
Subject: pm/testing build: 7 builds: 0 failed, 7 passed,
 1 warning (v5.15-rc7-95-g5ae5ac40021d)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 7 builds: 0 failed, 7 passed, 1 warning (v5.15-rc7-95-g5a=
e5ac40021d)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
15-rc7-95-g5ae5ac40021d/

Tree: pm
Branch: testing
Git Describe: v5.15-rc7-95-g5ae5ac40021d
Git Commit: 5ae5ac40021d00a4ebbfd42bd7f78ea42d613a1a
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
