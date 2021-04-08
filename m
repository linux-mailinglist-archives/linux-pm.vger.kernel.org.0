Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CEEB358FBF
	for <lists+linux-pm@lfdr.de>; Fri,  9 Apr 2021 00:21:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232404AbhDHWVo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 8 Apr 2021 18:21:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232265AbhDHWVn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 8 Apr 2021 18:21:43 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D49F9C061760
        for <linux-pm@vger.kernel.org>; Thu,  8 Apr 2021 15:21:31 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id p10so1784342pld.0
        for <linux-pm@vger.kernel.org>; Thu, 08 Apr 2021 15:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=ppoKDAe2+DH0eLVKqWI1JfSJBsC+XuYZtfiqvdcjQhc=;
        b=dXYfUsV0wXOuKW6vgQeNJglgiMmfpcrLtNWUVvYqOvh6ccjExg66R4NOhTSt1b0Vsi
         QiRdCwHUXKyF5jAvBM4XipBcmXVW88vbyXhAahRfcxpBdlk0wu6RbV7r55e0y8wPcFqf
         1UfbxRcMqb471BFaI3H79IeKjuIKSlJQj9LOqGqlyW6VZOIzBljEAQTCfXMJ9aOMCj2N
         3lDrnIDPvz/7gvh2rBIM8lzgB1HgbbQfXio6J27vMlzrXPEaXoa2H/SqUs1begjjbGh6
         4dd+KWAwHp2ETdALqs5KVtbGTMfAr3H5OQxM5KJ+8/P+r+/x+1CsCKLUlOKZlAb+oT3h
         P3lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=ppoKDAe2+DH0eLVKqWI1JfSJBsC+XuYZtfiqvdcjQhc=;
        b=pIqVQfW3BPLmkjnlOiPUz9N/itOLPedjnBpF2zfkPXJvl7WCb7yAl6RqbTe+qiB6XR
         jqL0timwToemAgpTTFcAW6KLcZuRpQxnKox8KcU7TNZrennZzAaG1rpu0HbA4PQOaK6C
         ieC596vztAydnzcB4+W3doB4g8H/sNbnbVAznMv1kx3z/6C53vI5RjMCDoxnEb3kN8j1
         gsXizu3TR0BG1nIOb8H81+bx8syw7f7ji5i4NuI1HyuU9pXEm5ETJVzL2eqDKiNPqMke
         lv8g+idJYjVcCOvl8dA/ssdNVPTA25rPqFN/lMSFTui00bsvCCzdtFwz5QjHFdchJ3Ic
         QClg==
X-Gm-Message-State: AOAM532mJ3YEWGNTfEbu6L1ZR7J74wtSBaaqnAo/gb6JsokFGmqnbTAR
        q/yNk2vmM0Ozfpyq3HtdCY6Aer7hc3h39UOC
X-Google-Smtp-Source: ABdhPJzx21Tp6MtsfZRztnjHPO2welHkJFKSFhlBFzNpJ/VOsfYP5wGlwnuRsX94ui+4rQnfSB66eA==
X-Received: by 2002:a17:90b:1bc1:: with SMTP id oa1mr10189912pjb.45.1617920491453;
        Thu, 08 Apr 2021 15:21:31 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id r26sm315927pgn.15.2021.04.08.15.21.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 15:21:31 -0700 (PDT)
Message-ID: <606f81eb.1c69fb81.db696.1698@mx.google.com>
Date:   Thu, 08 Apr 2021 15:21:31 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v5.12-rc6-72-gea176976603a0
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
Subject: pm/testing build: 7 builds: 0 failed, 7 passed,
 1 warning (v5.12-rc6-72-gea176976603a0)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 7 builds: 0 failed, 7 passed, 1 warning (v5.12-rc6-72-gea=
176976603a0)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
12-rc6-72-gea176976603a0/

Tree: pm
Branch: testing
Git Describe: v5.12-rc6-72-gea176976603a0
Git Commit: ea176976603a0deb74a3453f09a83f21adfde207
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
