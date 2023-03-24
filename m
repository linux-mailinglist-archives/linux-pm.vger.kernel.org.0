Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACC1A6C8330
	for <lists+linux-pm@lfdr.de>; Fri, 24 Mar 2023 18:18:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232049AbjCXRS1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 24 Mar 2023 13:18:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232131AbjCXRSV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 24 Mar 2023 13:18:21 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04B8B10D5
        for <linux-pm@vger.kernel.org>; Fri, 24 Mar 2023 10:17:56 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id r7-20020a17090b050700b002404be7920aso1680258pjz.5
        for <linux-pm@vger.kernel.org>; Fri, 24 Mar 2023 10:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112; t=1679678272;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=9Osa8c7aNp+EbaRiI/YLmONGU4R0aweZEOKfqyWr+Iw=;
        b=H8ALnSObdCt0h7zmryu/hNHLRgXRzVeBePTTwGaazKtvcwngvEIev1uKcWtpU4B1h5
         MkomyeAfe5AYK5DqjbgD1jdCOEDEUBZVtue5B4bJka4Twl78v8WiFZmgsvWiHtsxAWo2
         uVsabL4ax1reJBKptKKPSOqu+Brrx8dpzWXYhFpyRz8GaLIt/EQTs7wkMDM8XctwwZU1
         4xj6lgAfT3QsstmWtJ1jBOFoGZ6rDwM7FqRWTu3ulub8vkwBaluFMZuGKyFLNR6nRUNP
         +MG8M1hqC6i5CdDcklASFSuzHtDXLf4NYx92n7ltOSGZyBMCp859iHfB9pph/qc/Vjkc
         tWZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679678272;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9Osa8c7aNp+EbaRiI/YLmONGU4R0aweZEOKfqyWr+Iw=;
        b=3tDMBHR3fCSZDQZGSDAp+t2wUx/biQW4OzSzjxgkLycx8bUn2DWz2mLZCmHt0Kjj6F
         8g/iqkC4Yoq7ir7MtcvAYnIhZqurNxzvP8GEj07zgta1oK/XsW931XZSh7P9xG57eTGy
         5eDr2IF/xi516XSsFDbfMME3PvrDvDPhD1JxNFpRzCVZyAm3vNuG2qWL24NDf/gHSaxs
         2Ed3j03X6s9fx4qTwbKgDpkLbE73bSAz9EPr9Myuk5qqLQbge6RYfR1rsJNBDQ8gVDnx
         ZWGt50b63EEFx0yi6HISFKRqaqrgwZBPn5U3f5EZbRNcvnp6uNmCSSpnUpNK7+Mzst3O
         GmnQ==
X-Gm-Message-State: AAQBX9eIxYqbBamGewaXDtXepq3zOKUiXDqvtG1x+SA5qIXBcp4PHPfh
        gzGKiU/9amz7dZgLQge3K+6UDQ==
X-Google-Smtp-Source: AKy350ZWJTSjGLUX21VO8wexNGUVQOZQ6rtNk34eMqmmVEVDB1atqL8lQgle+z1QnUdBjfP1Y9izFA==
X-Received: by 2002:a05:6a20:1d60:b0:de:a889:c58b with SMTP id cs32-20020a056a201d6000b000dea889c58bmr1008053pzb.25.1679678272217;
        Fri, 24 Mar 2023 10:17:52 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id x16-20020aa784d0000000b006280676b8b4sm8826038pfn.220.2023.03.24.10.17.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 10:17:51 -0700 (PDT)
Message-ID: <641ddb3f.a70a0220.4c99c.11a7@mx.google.com>
Date:   Fri, 24 Mar 2023 10:17:51 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v6.3-rc3-53-g7473086579df3
Subject: pm/testing build: 8 builds: 0 failed, 8 passed,
 4 warnings (v6.3-rc3-53-g7473086579df3)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 8 builds: 0 failed, 8 passed, 4 warnings (v6.3-rc3-53-g74=
73086579df3)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v6.=
3-rc3-53-g7473086579df3/

Tree: pm
Branch: testing
Git Describe: v6.3-rc3-53-g7473086579df3
Git Commit: 7473086579df355c73c562503a622866052017fe
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
    2    <stdin>:1517:2: warning: #warning syscall clone3 not implemented [=
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
    <stdin>:1517:2: warning: #warning syscall clone3 not implemented [-Wcpp]
    WARNING: modpost: EXPORT symbol "_mcount" [vmlinux] version generation =
failed, symbol will not be versioned.
    <stdin>:1517:2: warning: #warning syscall clone3 not implemented [-Wcpp]
    WARNING: modpost: EXPORT symbol "_mcount" [vmlinux] version generation =
failed, symbol will not be versioned.

---------------------------------------------------------------------------=
-----
x86_64_defconfig (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 s=
ection mismatches

---
For more info write to <info@kernelci.org>
