Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F84445CC89
	for <lists+linux-pm@lfdr.de>; Wed, 24 Nov 2021 19:54:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244506AbhKXS5o (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 24 Nov 2021 13:57:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236702AbhKXS5o (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 24 Nov 2021 13:57:44 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 975C0C061574
        for <linux-pm@vger.kernel.org>; Wed, 24 Nov 2021 10:54:34 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id iq11so3258185pjb.3
        for <linux-pm@vger.kernel.org>; Wed, 24 Nov 2021 10:54:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=DWs+sfm73Co4/p8zjBCzjIJxKxd+hDr0lk1K3niMt+Q=;
        b=UB1aBuY9pG3JXM7KhviI8oV7AGKwM25frnNIytTR0AXRvilwuGtphkGOcm+zxTZIxW
         iiUHB7jncerMm/ggOc58ABA/RifoaDyZ7oVeBJSCyc4qqsorYDy7L6B8AK15wOxXk+nI
         x0crA4mq1ectczaQ3vKMT2pVWXbzlRqrrvh6x0HLmj5WTjatV5HU1UW3/cZEkWeciVZ8
         jEEcIGWhtCMAXaePzLPwltQx/Ul6Q8g2kUuSmeg4723LVKooMEiJ6yXrWJ6OEM94rghf
         9DCojf0UAZDkRd9JrCTuBu20d+oHomKWaPMFfUQdhiu7XBw9UH0FUWVKyPvR063aURJS
         wStA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=DWs+sfm73Co4/p8zjBCzjIJxKxd+hDr0lk1K3niMt+Q=;
        b=hbUSYN1nL4OhwUIoikIDtK0y6HwywBocsf6IXkdEDI9meV6PRuvF4UgYrMw7NPUgoU
         DOSNXNtqExvxWd6mQQ0Fivh2wysNfvQmn9iSD74E2kUKEVTbArBvR/Pd0anQQ5uTJzb0
         yemdz7QuIWcdCfQR/z9+2PBB+cFXoceTU5VnEngOIXfJ+N5O2JXHEyrX/f+VUhrPH9DN
         RJVvo9MZJyDaRnoPZDDNV8tb9Dibw1o97Rt7pqbVmybNVqdx3SH5qu8S0NXAXH6sbYfQ
         magev6zfcK9AXbRzm3uUFlMkzNuFD/RoFqGqx2PbrCdoX8lvbWxLlVeYRK4YXde+XSSX
         J8kQ==
X-Gm-Message-State: AOAM530dNANFxy0BOf8zjIuG5U6Fqxu3SRMRb92iqTE3kiWGl4qxiw6R
        u2wxkEOcny5C9RRLTHrMmOpCpQ==
X-Google-Smtp-Source: ABdhPJwthS/xAIcGAvNb8R7+YcSQetAa6Aw0kygtk7/45pU78xicADHbr/e0qcosMiCWd7/V1SKd3g==
X-Received: by 2002:a17:902:9888:b0:142:8731:4b55 with SMTP id s8-20020a170902988800b0014287314b55mr21490931plp.51.1637780074160;
        Wed, 24 Nov 2021 10:54:34 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id s38sm322629pga.40.2021.11.24.10.54.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Nov 2021 10:54:33 -0800 (PST)
Message-ID: <619e8a69.1c69fb81.2d99.129b@mx.google.com>
Date:   Wed, 24 Nov 2021 10:54:33 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.16-rc2-16-ga3f78507f993
X-Kernelci-Report-Type: build
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
Subject: pm/testing build: 7 builds: 0 failed, 7 passed,
 1 warning (v5.16-rc2-16-ga3f78507f993)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 7 builds: 0 failed, 7 passed, 1 warning (v5.16-rc2-16-ga3=
f78507f993)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
16-rc2-16-ga3f78507f993/

Tree: pm
Branch: testing
Git Describe: v5.16-rc2-16-ga3f78507f993
Git Commit: a3f78507f9931f5abe2f8273896e002b59eaeb90
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
