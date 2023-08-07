Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05C23772EF6
	for <lists+linux-pm@lfdr.de>; Mon,  7 Aug 2023 21:38:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230135AbjHGTiS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 7 Aug 2023 15:38:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230095AbjHGTiN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 7 Aug 2023 15:38:13 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69F6D19B4
        for <linux-pm@vger.kernel.org>; Mon,  7 Aug 2023 12:37:57 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-686f1240a22so4748082b3a.0
        for <linux-pm@vger.kernel.org>; Mon, 07 Aug 2023 12:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1691437077; x=1692041877;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+qgFNy3nELPAuJo99S1k77EJ5TcngVYSO1aPXDeb5/I=;
        b=TSSsFs5az932zNFbbvNe5qanRSRUl5DqPWldVNV6r/AaB0VLqVA/gniliiyfzwc1l2
         7qtLNNxgMRJxXQVTm/kySSt7Zt3GLwirEMBHIgjVHQg5IuFJQA3G7xD+39iEwIchWZK2
         UEIlRDCKHRIKve/mfFEv5dGnY1BZl7JfiMoD8ERZXAPpvTNBy+8iTObwEKhxCt36dbgQ
         +5feYYmONs6/1zx6bUKGLhhDJNYkUkK9ELcRoebD/Ws3Z+Q7nCy1j4uWkUdfNf4uHjmi
         IelzRoz6RMu1QwNe/v5HZQG7Xg4vtc4uhtJDMqGHkCTq8PVH5tahXLCSEwIdaID48QWw
         S2bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691437077; x=1692041877;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+qgFNy3nELPAuJo99S1k77EJ5TcngVYSO1aPXDeb5/I=;
        b=HWTfdv+/L7wsWF3isxwQweyO3hfA8pt7Hs6i6+s15a+iKj9RpCUM0VNHcKHBMJku8T
         6MyUqF+0h20b2t+7cF//NNIfiWU52WMeoW3/Wr3DvD+m0EPaAfQKJBHlyHb/d/pkX2AI
         k2pSvPSg31tWfaaDL0fbQ7tvz/OT8Ie0tru1NpSoiv4KKWquk6fDy0uR4zXkvlt2hRzH
         iGHT4+Y4HJKRLy9n+oPvUzOJREDZmT9ubLOgZb4efXGNSFJmVFuOxWiMaRk+6lU92mqW
         Zz6gYQWU33MnC5SG85AhqfnnceOb9r17HT/sn8srI2UomJAW8LhKq+kbGzH6ny7hhHmg
         rlQQ==
X-Gm-Message-State: AOJu0YxnBvmM4okiZm0doP2LPuKhRjJXmxkV3QlZj77prK5PyZs/7buB
        RpAr4dYaPAmQ7C5GWXYnb9OjkQ==
X-Google-Smtp-Source: AGHT+IFjKQJ3Bq3KbYp6B9NFcgTNWlMqhgl2+cd33APu740MwVHwrd+50cKPMtyBL7HkHzgd/Kgi0A==
X-Received: by 2002:a05:6a21:498a:b0:13f:a69c:53af with SMTP id ax10-20020a056a21498a00b0013fa69c53afmr11181157pzc.61.1691437076913;
        Mon, 07 Aug 2023 12:37:56 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id l2-20020a62be02000000b00686f9789064sm6744586pff.12.2023.08.07.12.37.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 12:37:56 -0700 (PDT)
Message-ID: <64d14814.620a0220.f3df2.cfc5@mx.google.com>
Date:   Mon, 07 Aug 2023 12:37:56 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v6.5-rc5-70-g1ce1d2ec8fc3
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
Subject: pm/testing build: 8 builds: 0 failed, 8 passed,
 4 warnings (v6.5-rc5-70-g1ce1d2ec8fc3)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 8 builds: 0 failed, 8 passed, 4 warnings (v6.5-rc5-70-g1c=
e1d2ec8fc3)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v6.=
5-rc5-70-g1ce1d2ec8fc3/

Tree: pm
Branch: testing
Git Describe: v6.5-rc5-70-g1ce1d2ec8fc3
Git Commit: 1ce1d2ec8fc34809aa5b55619bbb6dc9577165e9
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
