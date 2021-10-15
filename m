Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FDD042FEEF
	for <lists+linux-pm@lfdr.de>; Sat, 16 Oct 2021 01:36:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239201AbhJOXiX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 15 Oct 2021 19:38:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238908AbhJOXiR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 15 Oct 2021 19:38:17 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BDDBC061570
        for <linux-pm@vger.kernel.org>; Fri, 15 Oct 2021 16:36:10 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id l6so7305592plh.9
        for <linux-pm@vger.kernel.org>; Fri, 15 Oct 2021 16:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=0IYMx2660f/9OFBTs/TiwKQJQhMbnN9oo206eTMLEQ8=;
        b=SCuO/j7q4gkOmTRZeXQdQ300CANs8mJ7i+kSWJQuj8cC6DGgmgTK7rlPlMXg4/W04t
         dx/7NlPYWekpKsYpjk0MxHuHqcRNRAqeQOfhURXj/hMFRrnGs/OXcP6wW3l9k903JqH2
         K3citLfTCp8C3VsJRatxfHSI+Jrg6DW1zkay+8YqQUHKBVAcwYv/d7ShE6gzdvkepMju
         NoOFOk3dPT9KKI/eFtj3rMYVfDPXug9ZrWvS+8y40LxDw0jvtuXaIjugmRTXD7e0dALc
         DB2scovoQ0F1qG4WCaznwhR9dUgQ6ZSMd9YMGmP7PrMHdOjYSEuSb2BYJerObiL9zOYh
         R91w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=0IYMx2660f/9OFBTs/TiwKQJQhMbnN9oo206eTMLEQ8=;
        b=0BXmOmjaafdd3FUnWPJlnkIP+w/xcBAMzyYRPMm1I3ZKpyXQMtsSg34k7pvb6F7/xb
         8QYRgFmz5D9nxAkawUry82t6IjxS8vr3XZr5oThsYcliTx6oEuOPkSPIA0vF6EBTREsp
         6yYQ95H9d7q2IqONKMyg3ynozOtGQb16etxGBP6G35LjsVgRAHiaOIe7D1D/XkrCJU9F
         eauAPeblEJHghXi59CPUsfMRHxf/dBxvExYMOMZJhmin272mhsKF7SgLafq7Nu25fJ13
         ooHnyRL+llwCIhWV/vtj28UBwBXnyiMKc/cCII3gsw0ZLBIOtYtKEdmG8OkVYFAS910X
         bnLg==
X-Gm-Message-State: AOAM530TfzDZJHB7s6Rw7bIC1WaS0yWAi0+VB7hjDuHKSb6J2SSZtkO5
        1AfFO+rQx2bx3RGLaWYC5C1YrOn+XDZbKzqZ
X-Google-Smtp-Source: ABdhPJyf+tutmkg4c6sRVjBkk7ZtgGvXkUyhG1sw7OqllmQbshHrYwr5lYHASR6sc1Nv/GcQ5as3wQ==
X-Received: by 2002:a17:90b:2509:: with SMTP id ns9mr31178420pjb.47.1634340969961;
        Fri, 15 Oct 2021 16:36:09 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id c15sm5889004pfo.178.2021.10.15.16.36.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 16:36:09 -0700 (PDT)
Message-ID: <616a1069.1c69fb81.25a22.2f57@mx.google.com>
Date:   Fri, 15 Oct 2021 16:36:09 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: acpi-5.15-rc6-59-g180a736395e7
X-Kernelci-Report-Type: build
Subject: pm/testing build: 5 builds: 0 failed, 5 passed,
 1 warning (acpi-5.15-rc6-59-g180a736395e7)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 5 builds: 0 failed, 5 passed, 1 warning (acpi-5.15-rc6-59=
-g180a736395e7)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/acp=
i-5.15-rc6-59-g180a736395e7/

Tree: pm
Branch: testing
Git Describe: acpi-5.15-rc6-59-g180a736395e7
Git Commit: 180a736395e7e100b947e3e4a2a5bfe046faacfc
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
Built: 5 unique architectures

Warnings Detected:

arc:

arm:

i386:

mips:
    32r2el_defconfig (gcc-8): 1 warning

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
32r2el_defconfig (mips, gcc-8) =E2=80=94 PASS, 0 errors, 1 warning, 0 secti=
on mismatches

Warnings:
    arch/mips/boot/dts/img/boston.dts:128.19-178.5: Warning (pci_device_reg=
): /pci@14000000/pci2_root@0,0,0: PCI unit address format error, expected "=
0,0"

---------------------------------------------------------------------------=
-----
haps_hs_smp_defconfig (arc, gcc-8) =E2=80=94 PASS, 0 errors, 0 warnings, 0 =
section mismatches

---------------------------------------------------------------------------=
-----
i386_defconfig (i386, gcc-8) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sectio=
n mismatches

---------------------------------------------------------------------------=
-----
multi_v7_defconfig (arm, gcc-8) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sec=
tion mismatches

---------------------------------------------------------------------------=
-----
x86_64_defconfig (x86_64, gcc-8) =E2=80=94 PASS, 0 errors, 0 warnings, 0 se=
ction mismatches

---
For more info write to <info@kernelci.org>
