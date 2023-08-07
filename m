Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3DB27721F6
	for <lists+linux-pm@lfdr.de>; Mon,  7 Aug 2023 13:27:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232638AbjHGL1e (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 7 Aug 2023 07:27:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232580AbjHGL1J (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 7 Aug 2023 07:27:09 -0400
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 674924C15
        for <linux-pm@vger.kernel.org>; Mon,  7 Aug 2023 04:24:17 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-1a1fa977667so3324569fac.1
        for <linux-pm@vger.kernel.org>; Mon, 07 Aug 2023 04:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1691407412; x=1692012212;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=aLgELn4ZqhG/EdL0sIeMzz+czSgs8BVrHZ3DTKNB1+M=;
        b=1YkHCOTpQrOB+siAi/CgilOKtf+SAzU0NizHrbNEEDrpxg+jnTeYuk/zSfG03WL4Qi
         5q0LKyOHR1b0hq7KD+tCsJGnhBN8OioK+nkHcAnWbZuqjVvBFiFhoAhPXg6kSDRUL0zF
         zDMRSU4oJtjW2nZ2llZQoX3ZNkzUZZAlGrhrYGajojlzUL2s3dZVh8TGjcNk6Bi7L4aS
         HdCtcqeU3BzgvnhqK5T0vTRxpR4k+jpZRiBp9hBEsjeiqWzW/PcaIA/z+S0eOWcC3C4n
         Pfmh4OFUElmTH8GzpMOMV4xhbtAgBRxM043Y6gw+HJTmhF2dRf5ADVDpjGq5T2ACKba8
         e+0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691407412; x=1692012212;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aLgELn4ZqhG/EdL0sIeMzz+czSgs8BVrHZ3DTKNB1+M=;
        b=lrVCp9nZXdJBL9KRKVAu3f1OGtvwSHkHLhipV55KwTX4IPtRcXBULWvVIgaCl76s1t
         TzL8CJEOgYuRQ/2brAfi82e1ndWz3CqggVAFpAu8bm24k1DGA1yMaXPmcmMm4L2AgcaK
         htSKVsBuHq+7MJ0nAt5IuQdL2OZj/tAlT7hINIi/ySuqSZd+TxN47YZzp/duwdBofuNY
         MIszvxc6phnJ7U3QCYqBAHIcWaWZrP/b4iC83aK6qt7beJeJFN74CqUg51P8/gYko5Jk
         kktnIAARU79wzFbguAkH8JdtyqNVAFSk3rujoLamKz60gZzyYRr6LXyVeKMIExeeKUrz
         HrFw==
X-Gm-Message-State: AOJu0Yxmv12eMsteREZfWh02+KtoI0+Iy6O07OcPIvmTXedc3muYf+x0
        sbjkYj5e/uQT4euUbQ4pd1RlZw==
X-Google-Smtp-Source: AGHT+IF1cxxYdIJaS1HuYUtxsSahQYIfBlDYuVYI2IzCq/1lydH/Mn8iU5cuEB1aOxgW4bCvNSGWSQ==
X-Received: by 2002:a05:6870:8089:b0:1be:fdae:601b with SMTP id q9-20020a056870808900b001befdae601bmr10629059oab.52.1691407411268;
        Mon, 07 Aug 2023 04:23:31 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id gx19-20020a17090b125300b002684b837d88sm5895195pjb.14.2023.08.07.04.23.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 04:23:30 -0700 (PDT)
Message-ID: <64d0d432.170a0220.a0b49.9bc0@mx.google.com>
Date:   Mon, 07 Aug 2023 04:23:30 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v6.5-rc5-68-g5fed5528c8fd
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
Subject: pm/testing build: 8 builds: 0 failed, 8 passed,
 4 warnings (v6.5-rc5-68-g5fed5528c8fd)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 8 builds: 0 failed, 8 passed, 4 warnings (v6.5-rc5-68-g5f=
ed5528c8fd)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v6.=
5-rc5-68-g5fed5528c8fd/

Tree: pm
Branch: testing
Git Describe: v6.5-rc5-68-g5fed5528c8fd
Git Commit: 5fed5528c8fd31ae431594b5da0b3dfa7642d23d
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
