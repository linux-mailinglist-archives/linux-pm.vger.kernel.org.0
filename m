Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2780878485D
	for <lists+linux-pm@lfdr.de>; Tue, 22 Aug 2023 19:23:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbjHVRXL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 22 Aug 2023 13:23:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjHVRXK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 22 Aug 2023 13:23:10 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A98F373D9
        for <linux-pm@vger.kernel.org>; Tue, 22 Aug 2023 10:23:04 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1bdc243d62bso30450535ad.3
        for <linux-pm@vger.kernel.org>; Tue, 22 Aug 2023 10:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1692724983; x=1693329783;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=hELDA8551olfIAdO27kvJ3qAOxncVUT1yTzbXgt6YFE=;
        b=OJsLBYUxapwShfG8a0SInFiDUDR45uKktOaUqwsHZmuupnUDl6zqCWUcgrl7atWeNe
         jvsiILtC7gcJlCfEO+SABLpA+JiIY8bkMHLP/4CoO+KyH8LBB55vEjhDe4C52D1VTdHA
         qFYUDnWX4YrqoBB+2wjEeedVbP7NHZYI71nsEUmCwBkX3918Zc2FuE+6EgOZcFDOk8Sx
         zx4Z5zm587hUMhGPyE+IM/o1cvqmBiOGw7StEQqXN3pPiQdIlvLY0CiMPdu/3ghMmSaF
         GXPIDjyULxvQVOtYx0W1f6rPtvzpHNLXqv336p9cSAeCti3Q/ICbrULIlcdqtJITf+SD
         Ov+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692724983; x=1693329783;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hELDA8551olfIAdO27kvJ3qAOxncVUT1yTzbXgt6YFE=;
        b=Yf5ODOIplJtG/mIO4e8FMY+b3u90zWylcb9z3ffE1561oxgS0orR49TSZpZ3cnYRVY
         7R0JSpYdN5xJLJ0MYkqM8QL8EChSx69IiTbzEj49UXNvwccI4LtSxZ2077oYAiu3xRCh
         PXRZWuik6+QEIm83Zr9Eg4cEL9TKill3NZZhP1VoYihkUcA2g5xmYGyDi48Zyfoaiqph
         aK+tfdX3FVf5R9DhTTi5kflOccUPolIZEbJA8CK0Ezie5u9VHgl/J3JiYZXDlKgI1ZP+
         upXrqzxSSCxphNCKxLGTtHzxgk6lePeyPvSxnDk4heNFBtSzLfnrawxpFDrKrKxdz/5h
         lrpg==
X-Gm-Message-State: AOJu0Ywe0RCgecudBwaIB65E1QiherGRikEOwhEt1/1K6fnlNa/blft6
        P0ARcC4dQEk3HvdMP3nJYkuzzw==
X-Google-Smtp-Source: AGHT+IEXsfXSOAfncfwV0CxYrIvmhJT9t0DfyZvH8MbN5ZZ5+t2oNMt++cEBNXW5g6sbMcFl6olhJA==
X-Received: by 2002:a17:902:a416:b0:1bf:46ee:9c6 with SMTP id p22-20020a170902a41600b001bf46ee09c6mr6930802plq.48.1692724983525;
        Tue, 22 Aug 2023 10:23:03 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id d2-20020a170903230200b001bc6536051bsm9260070plh.184.2023.08.22.10.23.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 10:23:02 -0700 (PDT)
Message-ID: <64e4eef6.170a0220.58c14.1701@mx.google.com>
Date:   Tue, 22 Aug 2023 10:23:02 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v6.5-rc7-123-g85ad73d0eb586
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
Subject: pm/testing build: 8 builds: 0 failed, 8 passed,
 4 warnings (v6.5-rc7-123-g85ad73d0eb586)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 8 builds: 0 failed, 8 passed, 4 warnings (v6.5-rc7-123-g8=
5ad73d0eb586)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v6.=
5-rc7-123-g85ad73d0eb586/

Tree: pm
Branch: testing
Git Describe: v6.5-rc7-123-g85ad73d0eb586
Git Commit: 85ad73d0eb5866c72af45341e30533e3066b3d9c
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
