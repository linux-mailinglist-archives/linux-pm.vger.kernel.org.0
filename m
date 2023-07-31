Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D209376A0ED
	for <lists+linux-pm@lfdr.de>; Mon, 31 Jul 2023 21:12:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229379AbjGaTMq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 31 Jul 2023 15:12:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjGaTMp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 31 Jul 2023 15:12:45 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E35EE4B
        for <linux-pm@vger.kernel.org>; Mon, 31 Jul 2023 12:12:44 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1bbdc05a93bso29597925ad.0
        for <linux-pm@vger.kernel.org>; Mon, 31 Jul 2023 12:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1690830763; x=1691435563;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=jGuiholSGuAHPcr/XP4evNzrf2tznHAI9qDIxniDpss=;
        b=Z4NTvXuKg/UP17Hwl6KvOpiJuDKE/gduezkxHAF1xIYRgNizZIyxPPwOKcePDoM0EF
         5+pbMqa09AVTKkLOE1lLxemB2FaiQZG0KrUdoRj2Yy4fBzYDjInovDJ9nAJ8CRuo+O/X
         Lq5Q9dd2OTHWfjV8a3U6ukLRnI9pJHZhio4J4r2fpBMirGn1G+qWRyV8S7X9FJWNJEU4
         tGfdxh8SVGRqEjMcPdCbFEeQewMUkyAiZi3GzHcIx2mJefkkluQWtkFRalytcaU+M7iS
         E3y4fzZJarsO21MHKCJK+xOhXwKZ2kC8S7M/DdK38OkDYTJEHAl9QI2CzNfRo0kBqmpm
         LNAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690830763; x=1691435563;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jGuiholSGuAHPcr/XP4evNzrf2tznHAI9qDIxniDpss=;
        b=BxR433bUqNPwDQbJUHCOSo+DCaRbHl4De8kLrySAnXumPIK69zVUnvikH4uwacUejl
         woWoV0kr/wQfOfvsC3eO6I3vF2hQIQLrUicKWrgfOOuxMGCgcdj7qf+MbHF4Ey7BQAyM
         MCPD8AuSIo2SZvn2ISYQKLqvOWVc0xt1beUtNJWROuAiNY/jcvifbtN/IlzVDow+icoY
         YsYy78wp7/jGd18QZYl4rYlyU3PzMafWqjaJTHdl/Vo/tg6k8nSSVPFuTPgnWI+B2Kke
         AHEH1v+g+MlayI2EFzm2WpjQci3knLeVeqcAuyA1+UWPAjkIgQbesX+XmZ3arXUBWBhP
         svXQ==
X-Gm-Message-State: ABy/qLblsaHeMnuMYQU5yjirvAlGTbDqddA4J7iKnFUnG1lp2jJ/XcEF
        d8BveoR+j2eKbd6S3DVp4H0pcw==
X-Google-Smtp-Source: APBJJlF8FqUjAOMt4t9C0Tk9fJu89+cD4QzRKJnwhilTzH5/ZAdK3562/FVEY46CATgvbt+8O3F3dQ==
X-Received: by 2002:a17:902:c412:b0:1b6:8a99:4979 with SMTP id k18-20020a170902c41200b001b68a994979mr13023097plk.22.1690830763688;
        Mon, 31 Jul 2023 12:12:43 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id p17-20020a170902ead100b001b8b07bc600sm8911306pld.186.2023.07.31.12.12.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 12:12:43 -0700 (PDT)
Message-ID: <64c807ab.170a0220.c819c.15bc@mx.google.com>
Date:   Mon, 31 Jul 2023 12:12:43 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
X-Kernelci-Kernel: v6.5-rc4-47-g015a64bab2b55
X-Kernelci-Report-Type: build
Subject: pm/testing build: 8 builds: 0 failed, 8 passed,
 4 warnings (v6.5-rc4-47-g015a64bab2b55)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 8 builds: 0 failed, 8 passed, 4 warnings (v6.5-rc4-47-g01=
5a64bab2b55)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v6.=
5-rc4-47-g015a64bab2b55/

Tree: pm
Branch: testing
Git Describe: v6.5-rc4-47-g015a64bab2b55
Git Commit: 015a64bab2b55aca17cb15373d780fde0c869169
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
