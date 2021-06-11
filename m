Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77FA53A4913
	for <lists+linux-pm@lfdr.de>; Fri, 11 Jun 2021 21:02:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231461AbhFKTE2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 11 Jun 2021 15:04:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231495AbhFKTEZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 11 Jun 2021 15:04:25 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14CB2C0617AF
        for <linux-pm@vger.kernel.org>; Fri, 11 Jun 2021 12:02:11 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id s17-20020a17090a8811b029016e89654f93so1212784pjn.1
        for <linux-pm@vger.kernel.org>; Fri, 11 Jun 2021 12:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=ViAk/io1VJIHrzPCc7C/xaBvEfKT793J64yAd+Z+Yl0=;
        b=p/XXiMVOCbAQreB1x1SAnc5Xh+lRc44/MaaN9tY2+SDA2+UX+Wc9zg7wtJis+RQUd1
         n0YmTFEVMC2Vygzj5gUSETcuJcD8XsSyy4RGOBh0hc3qKIqq+zE2e6TZ03zytWvlTxqX
         JCNM0igwMkUht46rlJrHTcTrGsydvspjZJJ3sWOWcNWPZfHeTkmyrSYfVClSPdfnVtlZ
         c91UY7C5I+J4OaOHzCwazRwowkoTg3IQnFqrp4t96XvDFVOYftqgWaAWoohx4ZXOYvE+
         GdrzGmEHgzSyXgbGc9O+k1P+vGtpihLiyFHZ+WUETvcMqlx4ye7wVIFHgytgx7f6/jpa
         g6Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=ViAk/io1VJIHrzPCc7C/xaBvEfKT793J64yAd+Z+Yl0=;
        b=AdRL4F/Dl0xPUHGS0vG8Yl27/Ua2K3DAjeCLzMuOfou1GeW5/UMLDVeJZuFviQ6DnA
         nz4eNtK/R7KwJ/rLSKUgAYN+kHmhk61z0SkoyVqSnLSuqylyKWzOsj0+iN4wb0c0m/Eq
         d4oJvwwUn5Gnhd5igL1lMPZZQPqrGcMaUjvhW+1HoUT7t69axVXC6juJ+y5ImG5TEc8s
         RmgKSDCBfL+Ml0WfLtw2qlEzLBmSs4rsMJmIGh09cPegLL425vx9vIHAHM7JenkTNLOV
         lMgrmnGNW9qQ3CiGv8NpBGR+JiFUHm2ZlA1fWhl5ywRsPERCDL6iWz5+xwkfhvCvZB+F
         FL6w==
X-Gm-Message-State: AOAM531PLPdS7cxiRVezpYnn5SPhJ0YE/olMCWvsOxjK7w+93QpBLDwA
        B2rv8OOuFqwqFve5W1/7nk7RDw==
X-Google-Smtp-Source: ABdhPJzYCuSIoE+cyrke+yPcCBa5SZqzZmGnG40dxRANjQGRVwQMyY2iNJplmxOXW9Y9TjHLc8FXdA==
X-Received: by 2002:a17:902:ce8f:b029:114:a0e5:7be1 with SMTP id f15-20020a170902ce8fb0290114a0e57be1mr5106854plg.10.1623438130530;
        Fri, 11 Jun 2021 12:02:10 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id u10sm5607637pfh.123.2021.06.11.12.02.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jun 2021 12:02:10 -0700 (PDT)
Message-ID: <60c3b332.1c69fb81.be1cb.12fd@mx.google.com>
Date:   Fri, 11 Jun 2021 12:02:10 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.13-rc5-112-gfce7d470d0dd
X-Kernelci-Report-Type: build
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
Subject: pm/testing build: 7 builds: 0 failed,
 7 passed (v5.13-rc5-112-gfce7d470d0dd)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 7 builds: 0 failed, 7 passed (v5.13-rc5-112-gfce7d470d0dd)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
13-rc5-112-gfce7d470d0dd/

Tree: pm
Branch: testing
Git Describe: v5.13-rc5-112-gfce7d470d0dd
Git Commit: fce7d470d0dd8960fb8fff2c6adcdea7646a85a9
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
Built: 7 unique architectures

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D

Detailed per-defconfig build reports:

---------------------------------------------------------------------------=
-----
32r2el_defconfig (mips, gcc-8) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sect=
ion mismatches

---------------------------------------------------------------------------=
-----
defconfig (riscv, gcc-8) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section mi=
smatches

---------------------------------------------------------------------------=
-----
defconfig (arm64, gcc-8) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section mi=
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
