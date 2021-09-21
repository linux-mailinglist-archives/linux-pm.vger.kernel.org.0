Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7343641397D
	for <lists+linux-pm@lfdr.de>; Tue, 21 Sep 2021 20:05:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232072AbhIUSGs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 21 Sep 2021 14:06:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231351AbhIUSGs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 21 Sep 2021 14:06:48 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3485C061574
        for <linux-pm@vger.kernel.org>; Tue, 21 Sep 2021 11:05:19 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id dw14so191267pjb.1
        for <linux-pm@vger.kernel.org>; Tue, 21 Sep 2021 11:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=GNtXUHVdneB9mmx4gfKZTIBwwuHhL0VUXf2Ru1ziV1w=;
        b=kFCYjm2bfVAIik4sxMl5p95oFEVljE+AtfFrMk8O7MJ/go1zzLNIfRqJhxtzpoXxl+
         E/1JkcmEHubuDi1RpqQTKJqNsB2eqUlPmrPQVc9O3n7rOTxMXWf2AMwT48ruoM3fGuZL
         uQGQU3PWbyOb4Xsd+WXKp/kdDzEp6/DA30fSrSibXq+sJ3GH6U/pDfliEG4VP477lhC4
         Rjwl00ThL3OdMX7ELxYY7Aw1rqSAyBQv3qar0GMlSr6i3zrvwitQfka8/pkQhvj5p0Rq
         UX2jilLF3tejK/0PxsN+49r9BK5nkDjLiaefOTX7d6HBkKUf63SNiE5MyEds2jYDXJXu
         XQfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=GNtXUHVdneB9mmx4gfKZTIBwwuHhL0VUXf2Ru1ziV1w=;
        b=k6ZYUa5liCGOsmbXoTHJv4IFyV6Lf8sdKO1L7Bo7jW137h1SuGgpNYnOPOh8QXDvjp
         8t9fItP/7u+B4G8n4XqafUkMNcgY9+g2htGgsWVyyzr9TqgPlQAxRiytdHG0NSTRadua
         7BPmtU3zXRjsyAJ69fzJhlShVORkc5yLilDu9H3QYCnH7NFFq58xj5LkYEjidgpJohUT
         yPkj5+WWos6E8ncxBtujLdRMVGRfjrnjK1yQ7PVeWfAwW7rmvKLPUxAUgfGiZ9usLat6
         VLbE63CCQ/esIMJZoI5I3gjORL6m7LwRHI7IXO+tQtSPGDUoHmiZmXobWpHAE2SLKcDM
         t38Q==
X-Gm-Message-State: AOAM532vuyX8PSVDsURHGQcdpHZhstc5DohN7Cfs8vQJB5WWorzEiEJ/
        c1Er2u1WpOT0Kt4+0lKyuPxFJQ==
X-Google-Smtp-Source: ABdhPJziKB9QfrerZQSFnipSkd1SMmfYHOqMpStOXghNSV9Ukfy7sUFM1AnTb+mBF0PbXn+s7W0/RQ==
X-Received: by 2002:a17:90a:a386:: with SMTP id x6mr6720490pjp.56.1632247519378;
        Tue, 21 Sep 2021 11:05:19 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id o20sm3279776pgd.31.2021.09.21.11.05.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 11:05:18 -0700 (PDT)
Message-ID: <614a1ede.1c69fb81.46c86.a947@mx.google.com>
Date:   Tue, 21 Sep 2021 11:05:18 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.15-rc2-10-g163807478ffd
X-Kernelci-Report-Type: build
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
Subject: pm/testing build: 6 builds: 0 failed, 6 passed,
 1 warning (v5.15-rc2-10-g163807478ffd)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 6 builds: 0 failed, 6 passed, 1 warning (v5.15-rc2-10-g16=
3807478ffd)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
15-rc2-10-g163807478ffd/

Tree: pm
Branch: testing
Git Describe: v5.15-rc2-10-g163807478ffd
Git Commit: 163807478ffdb2ab198066e36d25d516e20544b9
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
Built: 6 unique architectures

Warnings Detected:

arc:

arm:

i386:

mips:
    32r2el_defconfig (gcc-8): 1 warning

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
32r2el_defconfig (mips, gcc-8) =E2=80=94 PASS, 0 errors, 1 warning, 0 secti=
on mismatches

Warnings:
    arch/mips/boot/dts/img/boston.dts:128.19-178.5: Warning (pci_device_reg=
): /pci@14000000/pci2_root@0,0,0: PCI unit address format error, expected "=
0,0"

---------------------------------------------------------------------------=
-----
defconfig (riscv, gcc-8) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section mi=
smatches

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
