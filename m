Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0BE236BC70
	for <lists+linux-pm@lfdr.de>; Tue, 27 Apr 2021 02:03:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234084AbhD0AET (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 26 Apr 2021 20:04:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232295AbhD0AET (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 26 Apr 2021 20:04:19 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E798DC061574
        for <linux-pm@vger.kernel.org>; Mon, 26 Apr 2021 17:03:36 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id a12so297381pfc.7
        for <linux-pm@vger.kernel.org>; Mon, 26 Apr 2021 17:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=6CO/qBybp0G4NJrUV4cZTlF0+zC5Qrj1zoMXonuni8w=;
        b=Y/IYOUr+geEC3MlHN1KdckMVF7M6d9eNK04fnOejVAERzaScyjsPB2ryzWvueHufXm
         zhm+/vt51x9f/dsuL5GDZxslI1xWAQ8NvOfa3+UVLHXASdTd1OHlqEdIO4cJVqoK8gd/
         5ak6zzbjFmURs1inihsNFYoOhs74Nq3Ya1jxD2qpJq+nwX7NlYHdu1+74+lXt7XoCC8C
         fu+gnB9khd3c8pgZYcmKag4yl0ULdPpmararkAMsqe5vk3Nny7Jjun6aer7VpGBZBaih
         3o7KI/FMZL6EC9WoIlhyrNN2lGRoUc43/t1Mjh63gkrb6GD/Jjs5Qd5IQdnwrSA0E1fl
         m6qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=6CO/qBybp0G4NJrUV4cZTlF0+zC5Qrj1zoMXonuni8w=;
        b=GYYWyGSugK2xJjEdTMQyDr8EFdJzXP2jUp7LqXEdmwAXZgSbte0IQ9CQsE1sKsNe3e
         Pd7qZkNvjGKTv8oV5szHejQiTquqj9agltb01Tv9XOAFYb7XO3mNUVcZE9T6jPhDmY+v
         EFvv9BfRiHDqnKGfJr5ZXdKjoqzPm4R+Zr9Qvsio7z8r0HwupSNFvIXmDgAiNhUwGjt0
         W2vf9D8uG0mm+KSCVrzn4zlAO2mUUT08k3nUmpfK0+/ork0zHXO45/5Iju/0TxFydV8L
         WzMCIazgiQVk4nC17NieSPz8976Lnl1DwecyS2ARCg6buHswBq/T2YTrhv1whNL0LC+t
         iwRg==
X-Gm-Message-State: AOAM530xZZ1QZ2eLIMK567r74L/BWOHYcsPtHx29hwnnzkI/JtVa8u+e
        FqJzlTNqzE7D8xR4TaGpfDW54w==
X-Google-Smtp-Source: ABdhPJxYWQLoPu8l1heC0F9gSPFfkE1GSmAxwiH6wUBcFMw8Lywa6EIULcCTZd5s6SLJ9hf65PJgrg==
X-Received: by 2002:a62:1608:0:b029:25a:1e4c:cdab with SMTP id 8-20020a6216080000b029025a1e4ccdabmr20562247pfw.33.1619481816507;
        Mon, 26 Apr 2021 17:03:36 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id j20sm12263679pgk.74.2021.04.26.17.03.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Apr 2021 17:03:36 -0700 (PDT)
Message-ID: <608754d8.1c69fb81.cb160.49ec@mx.google.com>
Date:   Mon, 26 Apr 2021 17:03:36 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.12-rc8-168-g3c44d15e5ffdb
X-Kernelci-Report-Type: build
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
Subject: pm/testing build: 7 builds: 0 failed, 7 passed,
 1 warning (v5.12-rc8-168-g3c44d15e5ffdb)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 7 builds: 0 failed, 7 passed, 1 warning (v5.12-rc8-168-g3=
c44d15e5ffdb)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
12-rc8-168-g3c44d15e5ffdb/

Tree: pm
Branch: testing
Git Describe: v5.12-rc8-168-g3c44d15e5ffdb
Git Commit: 3c44d15e5ffdbc1b9d31d098b65c5cb50211d802
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
Built: 7 unique architectures

Warnings Detected:

arc:

arm64:

arm:

i386:

mips:
    32r2el_defconfig (gcc-8): 1 warning

riscv:

x86_64:


Warnings summary:

    1    WARNING: modpost: Symbol info of vmlinux is missing. Unresolved sy=
mbol check will be entirely skipped.

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
    WARNING: modpost: Symbol info of vmlinux is missing. Unresolved symbol =
check will be entirely skipped.

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
