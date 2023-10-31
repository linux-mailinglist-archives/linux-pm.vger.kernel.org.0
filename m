Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06B087DD69F
	for <lists+linux-pm@lfdr.de>; Tue, 31 Oct 2023 20:18:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231844AbjJaTSG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 31 Oct 2023 15:18:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbjJaTSF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 31 Oct 2023 15:18:05 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D625EF4
        for <linux-pm@vger.kernel.org>; Tue, 31 Oct 2023 12:18:03 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-6c10f098a27so2134325b3a.2
        for <linux-pm@vger.kernel.org>; Tue, 31 Oct 2023 12:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1698779883; x=1699384683; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=gaOdVV28en+bigehZXIS6mwlGAf/xiDNfB+PWkvzx7Q=;
        b=dhsd1mRzHEfJEyoUOlyN69RCXR+5SK1mr47C3bly6xIOIo8jR5pBFrsPviU3VXE3Jl
         s/g8TATr32Tl+WCH6cX1y2Pxd2/hwwQ4uRN61j3Lg/fSVjsSp0GmBT2W1z3QArjTzDYi
         R9hC+cfyqGGasVJf89COKEu7Bc6njRJ3CzxMQixW5t5OepQkyTZ6oF4cnjYa8CdxhII1
         Me9JnoAC9sqGiHBPiQU8OVhXEx65j2isNh3I8X/ZqxHUicmVhLB/6n9Y2TIUCMUY0Ds1
         WaSQA+hrYWO49ECegGVOCtIZbckVCQmGdyeMamkquLsPeSjgzPUSTyShcDMArGKIT38s
         9y/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698779883; x=1699384683;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gaOdVV28en+bigehZXIS6mwlGAf/xiDNfB+PWkvzx7Q=;
        b=B6e4X6c3rZjBf/yOkL2HDBOj9oZ2u4xBFAU2S2qSnOd1E5psZINJBMBm7ozktAIXhB
         ywqJ5l9BAXx20+cTSmYa3IjF3tICvz5hWv6pSEi1qrBHdpN7ww//Zs1SrjiXOfhc9L5S
         k2FoiOnjJhhUITCJxZCsc+vSfyQBDATJZUK0L79aAn73XrUv5X/gAgg4FG+QFBjgV6gd
         nmKixRVU6yVOV2toRe/qcEvn3H1vWSQZO8SYV5yWxDwTmQVX5sw3Noftl82zTuCskqHJ
         P0aL5khvxDl4DupNrT+WenM+a2XmNULkOEgwh0NfHKXwNSR1WIqGtqYk6lNXvARvRFaW
         obNw==
X-Gm-Message-State: AOJu0YxkoFMyhsacDyOgixdkey1DHe1Siz2y78p7kZJlfAN/zyf/SqN3
        FVeZ4mZoh8wBQsLqvTyq+3kuzA==
X-Google-Smtp-Source: AGHT+IGDnMPah92yK4OA7oaucruAr2zF4IZ2StQNXXGGVkMVuTIHTTgOp6Lh9AMnrTQBNmJZ3WJyjQ==
X-Received: by 2002:a05:6a20:a12b:b0:17a:e03f:5665 with SMTP id q43-20020a056a20a12b00b0017ae03f5665mr12196448pzk.31.1698779883354;
        Tue, 31 Oct 2023 12:18:03 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id b8-20020a17090ae38800b002805740d668sm1461929pjz.4.2023.10.31.12.18.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Oct 2023 12:18:02 -0700 (PDT)
Message-ID: <654152ea.170a0220.bd24d.3abf@mx.google.com>
Date:   Tue, 31 Oct 2023 12:18:02 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: acpi-6.7-rc1-200-g25839bdc2530
X-Kernelci-Report-Type: build
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
Subject: pm/testing build: 8 builds: 0 failed, 8 passed,
 4 warnings (acpi-6.7-rc1-200-g25839bdc2530)
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

pm/testing build: 8 builds: 0 failed, 8 passed, 4 warnings (acpi-6.7-rc1-20=
0-g25839bdc2530)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/acp=
i-6.7-rc1-200-g25839bdc2530/

Tree: pm
Branch: testing
Git Describe: acpi-6.7-rc1-200-g25839bdc2530
Git Commit: 25839bdc2530446faa0704f1bc6119ba6f161415
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
