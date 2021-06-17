Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 533433AA96D
	for <lists+linux-pm@lfdr.de>; Thu, 17 Jun 2021 05:13:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbhFQDQC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Jun 2021 23:16:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbhFQDQC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Jun 2021 23:16:02 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 614F9C061574
        for <linux-pm@vger.kernel.org>; Wed, 16 Jun 2021 20:13:55 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id e1so2163227plh.8
        for <linux-pm@vger.kernel.org>; Wed, 16 Jun 2021 20:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=1UkZIjrVFVA+7wFZqS424S7XJLGg8Ir1lMWkJx0j3Es=;
        b=K1mAgGmonL9zlxmZv6dotKXjAzWeztUVJqu5zcRiDOgy+3dpOjDqI2Dp0wNSL0TswI
         7XLoSUXFBAI9FRTs7GJDFqWGjRqJ3P1T1z4zHIt1r/yR9j0vnpGpSzUNevzrTp/WBWGk
         WvXlVPHys4gX2AFEoIcGeV+QpcQK9CepDgtynv3rb0H0ddm58xUvUMCf6RKh2vF9BNwm
         C0naYS3w5cGh9RL05r2X13weaF44tOY4AAZdBIg1DsC+1AaaHstNpmIXRkLrejJgocOw
         Azgub74NPvuNbYyR1YnrVuUGrg9F482FApqE7N8/HooxuPkM6erpVs1MhSHKQv6P1sso
         wQ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=1UkZIjrVFVA+7wFZqS424S7XJLGg8Ir1lMWkJx0j3Es=;
        b=uTmGY1DGzm2DxkdaZXM7eMzG9/iMDDS/bJH/iJT8yNqVAj0lrv4gJ0tEEAXa7MERfv
         /bP94kWJfnLO3pU6pJ9Lh6nEVAio4Ofner1b8+VxQWt1hPa9d0KBGvcTMCBRLyX8z2Nj
         NAIDXkZQqn0z8quuA6HEvyNYAaqnhMystdX438wz4q0IC1xLB14f2h3SK8BZZJX08b+8
         pvDmK8QZPO5eG6nuKB8YvPdYU046vm6LjAVR0eC4MIuKa2O2ac0WYCOBsicVXSvmqRZC
         zenci1+fWkyZCwQsYnCgCbpK8kXAvTWvcept7BZnmch047+yU5QkiKWSdX48vrzen6uU
         Di+A==
X-Gm-Message-State: AOAM532S/y9r9EAR257FxE35pkC1JkNCBpDSOKPaqGJLkkjAWtNeV2SQ
        ItuGKZ/JxfZ/TEda9G7PzulM/A==
X-Google-Smtp-Source: ABdhPJzW78qS6DUiMOUwBcWyFm6dRgnv3TqbuiU51xpXiglb5cCFys3eJB2zaGo1tbysOc5nqPgMUg==
X-Received: by 2002:a17:90a:5b0a:: with SMTP id o10mr14322338pji.143.1623899634979;
        Wed, 16 Jun 2021 20:13:54 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id d3sm3514418pfn.141.2021.06.16.20.13.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 20:13:54 -0700 (PDT)
Message-ID: <60cabdf2.1c69fb81.59b9.ae0a@mx.google.com>
Date:   Wed, 16 Jun 2021 20:13:54 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v5.13-rc6-122-gb7fd255fd200
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
Subject: pm/testing build: 6 builds: 0 failed,
 6 passed (v5.13-rc6-122-gb7fd255fd200)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 6 builds: 0 failed, 6 passed (v5.13-rc6-122-gb7fd255fd200)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
13-rc6-122-gb7fd255fd200/

Tree: pm
Branch: testing
Git Describe: v5.13-rc6-122-gb7fd255fd200
Git Commit: b7fd255fd2005d382ea1e26d3a6cd98028802541
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
Built: 6 unique architectures

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
