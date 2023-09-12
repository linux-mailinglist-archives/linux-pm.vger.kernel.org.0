Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB2CF79D1ED
	for <lists+linux-pm@lfdr.de>; Tue, 12 Sep 2023 15:19:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235383AbjILNTF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 12 Sep 2023 09:19:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235320AbjILNTD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 12 Sep 2023 09:19:03 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 810B010D1
        for <linux-pm@vger.kernel.org>; Tue, 12 Sep 2023 06:18:59 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1c1ff5b741cso50769975ad.2
        for <linux-pm@vger.kernel.org>; Tue, 12 Sep 2023 06:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1694524739; x=1695129539; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ZgUWoG/UzVQo6IZW/jhIiZuxYcRuzB8HaZLWXl+S99A=;
        b=kl8mM6XImC4GAllEx6Ry3M/bufaNHprmGcgMvoAG/l+OWwTx8VN+Sk62JpR4y6QZta
         Skt9WSE5TWnZW1cgyjLc0wrC/R1X4Q7pJkOeYTwu+qMrJQESQJZ48aeZsqvqienK4oIQ
         OVeu2N1gpLLX4SmjlD1RGhhElYl5Adn3vqko7HTS9swnNqzHsH0DUux0joStxPUi19uA
         3rshUpIFQ3DvnXdBWzRWuZh7itmun0ftvRNW4HrFndUfGCSsHZxhj/TLn2r50rQy3zIx
         FNjSwcwkjd1w3pDtst3x6AXbU4b/0I4KLiCjhoyWjaiMXDMpjkRlGt46tzY5xosoAcIv
         g/jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694524739; x=1695129539;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZgUWoG/UzVQo6IZW/jhIiZuxYcRuzB8HaZLWXl+S99A=;
        b=QnYvGYq0pHcq2Q2ItWqbUY2Mu//i90UXJ5SfSxruomtTMxdMgxU4cA6yJ0JjQhSwH6
         9GB5ljOFyoy8hjYtT6X5zY3eXFBfGpecku2xpQ+rQLtujyR7BsiRjxKRrdpF6sxy1kDt
         ZFk23Vnhyy5esoPh+H7i/1NU/kQvMIMMcMbh5BhuKmofn+5ejs+c8XZQulVC3p0/s1tk
         13PdyXlCwPCn5h2bhhtXNAUGozgo9x26li5aE36osxsv9xXeGzgdEFPNfEIqXn64J2Ib
         l1BKGN2ou1R0u8oJf9xt65oRBcuD6/zuaGqboWC5RP6NKsxcAB+4xOW7Las+FtCIF2LU
         HWow==
X-Gm-Message-State: AOJu0YwixJsFUj2kNOLPvC2LavWMBX7eQ02xVN+H1lZfKiMQI45Yoflm
        c6OZdhRSf+s4UjEaSSKTx/RRyQ==
X-Google-Smtp-Source: AGHT+IHuPCCifllZLVVhG1RS0SEov7F7CiO6GUAGJmrDjdteB7eJTakpdW7XNZ7cub5ACw1SoYZCiQ==
X-Received: by 2002:a17:902:9a4b:b0:1c0:bf62:c921 with SMTP id x11-20020a1709029a4b00b001c0bf62c921mr12982236plv.18.1694524738958;
        Tue, 12 Sep 2023 06:18:58 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id o3-20020a170902bcc300b001b801044466sm8389329pls.114.2023.09.12.06.18.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 06:18:58 -0700 (PDT)
Message-ID: <65006542.170a0220.87b6c.594b@mx.google.com>
Date:   Tue, 12 Sep 2023 06:18:58 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v6.6-rc1-5-gb5eda4c9c923
X-Kernelci-Report-Type: build
Subject: pm/testing build: 8 builds: 0 failed, 8 passed,
 4 warnings (v6.6-rc1-5-gb5eda4c9c923)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 8 builds: 0 failed, 8 passed, 4 warnings (v6.6-rc1-5-gb5e=
da4c9c923)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v6.=
6-rc1-5-gb5eda4c9c923/

Tree: pm
Branch: testing
Git Describe: v6.6-rc1-5-gb5eda4c9c923
Git Commit: b5eda4c9c923df3ee79181406652733b3faf2994
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
Built: 8 unique architectures

Warnings Detected:

arc:

arm64:

arm:

i386:

mips:

riscv:

sparc:
    sparc64_defconfig (gcc-10): 4 warnings

x86_64:


Warnings summary:

    2    WARNING: modpost: EXPORT symbol "_mcount" [vmlinux] version genera=
tion failed, symbol will not be versioned.
    2    <stdin>:1519:2: warning: #warning syscall clone3 not implemented [=
-Wcpp]

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D

Detailed per-defconfig build reports:

---------------------------------------------------------------------------=
-----
32r2el_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sec=
tion mismatches

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
sparc64_defconfig (sparc, gcc-10) =E2=80=94 PASS, 0 errors, 4 warnings, 0 s=
ection mismatches

Warnings:
    <stdin>:1519:2: warning: #warning syscall clone3 not implemented [-Wcpp]
    WARNING: modpost: EXPORT symbol "_mcount" [vmlinux] version generation =
failed, symbol will not be versioned.
    <stdin>:1519:2: warning: #warning syscall clone3 not implemented [-Wcpp]
    WARNING: modpost: EXPORT symbol "_mcount" [vmlinux] version generation =
failed, symbol will not be versioned.

---------------------------------------------------------------------------=
-----
x86_64_defconfig (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 s=
ection mismatches

---
For more info write to <info@kernelci.org>
