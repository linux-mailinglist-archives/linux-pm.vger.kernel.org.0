Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 822946B56E8
	for <lists+linux-pm@lfdr.de>; Sat, 11 Mar 2023 01:44:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbjCKAoP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 10 Mar 2023 19:44:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbjCKAoG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 10 Mar 2023 19:44:06 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 987C8A227B
        for <linux-pm@vger.kernel.org>; Fri, 10 Mar 2023 16:43:40 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id a9so7370231plh.11
        for <linux-pm@vger.kernel.org>; Fri, 10 Mar 2023 16:43:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112; t=1678495416;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=PlOogjRl6HmGWiAL1FFXwlwwCACBFVb9XHbLy+0IBX0=;
        b=hZ6yPezRpP2rXcNWngZgtiHunL+q+eUXpt2fgzCweXrsDfpxdFA38NjBcZ8NPlgM6N
         CarUPmc5iE9+/G/+B943ZZAJVuboRA4jZG0tH5so4ZdJyEEqBDizgoBQ47vKTBQxg46r
         MPH2bbv14fXs+RK5wC8VS4d1C5HX6Y8M+wk0ddNhIgL/c5vj+GSRp81uzhL3Qeq+e537
         MrDDWcAy9NJpjQNSFTzshNfNp7cOK8anzFeB8RP/YpFaneZW1keb+c6KPMX+Rjb98FCB
         savGnf3/0ob7IuwLD560DEZCdo7ck17e1ZbQMBIWhxY+4jbg7Xm/JQ4hkV1gnwESGzHJ
         SG9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678495416;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PlOogjRl6HmGWiAL1FFXwlwwCACBFVb9XHbLy+0IBX0=;
        b=zxURzjVyuCN8l0hjFoxjPt1dKlV1mBbY6y2G1nZ3/p9xhNsjKwnws2b7vlx3Vo6CO1
         wDYMW+ORPXp/TOdiKD/tjwymwbFtr3m6uS+ZGu0X+VHW8JccK3LpcLK+ryFhd35RMCQX
         dbgeIb2Y5nCBn/nk4kLsEyH0p4E3BHDSufLUlXU0cuyh2HRIBbpOJ0Fn3voUsvz4wWma
         emvIyC2KbFWT+JPoJnogCOm6aqjIF7z0KTwU6P/H7kNIeYflgPK/1+V9Jqh53Mc2mgLO
         XmGc1DrAEuCzTycZ5BHVL+rCi7DBSmGQbhoJWlKYHJiezJfjXhNEbwDc0rmyMbEz3F1j
         Csgw==
X-Gm-Message-State: AO0yUKU6Jc7tjWMFR8aAFDmOTq3o7VVKAU7OjdcSAnPepvh6tk7lSPQL
        14WJ/Qh7mIj97KW3UqRYhYkKI6On+mtgq1QD40AYoxi+
X-Google-Smtp-Source: AK7set8lQC/oAvAKWA1wLOa7I3zsm67imBZPLKUfnkbVLGZY8TcABbIFde6i8vhnXN0RUFKkiK6MdQ==
X-Received: by 2002:a05:6a20:6982:b0:cd:ed5c:513 with SMTP id t2-20020a056a20698200b000cded5c0513mr5598102pzk.31.1678495415966;
        Fri, 10 Mar 2023 16:43:35 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id s21-20020aa78d55000000b005a9cb8edee3sm360744pfe.85.2023.03.10.16.43.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 16:43:35 -0800 (PST)
Message-ID: <640bceb7.a70a0220.af8cd.146b@mx.google.com>
Date:   Fri, 10 Mar 2023 16:43:35 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v6.3-rc1-33-g687388eb09d3
X-Kernelci-Report-Type: build
Subject: pm/testing build: 8 builds: 0 failed, 8 passed,
 4 warnings (v6.3-rc1-33-g687388eb09d3)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 8 builds: 0 failed, 8 passed, 4 warnings (v6.3-rc1-33-g68=
7388eb09d3)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v6.=
3-rc1-33-g687388eb09d3/

Tree: pm
Branch: testing
Git Describe: v6.3-rc1-33-g687388eb09d3
Git Commit: 687388eb09d318fb319b2771f1ee426afbf03bc3
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
