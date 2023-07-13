Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B58C175248F
	for <lists+linux-pm@lfdr.de>; Thu, 13 Jul 2023 16:03:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231387AbjGMODL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 13 Jul 2023 10:03:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234909AbjGMODC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 Jul 2023 10:03:02 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FA1D1FF1
        for <linux-pm@vger.kernel.org>; Thu, 13 Jul 2023 07:03:01 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-553ad54d3c6so481863a12.1
        for <linux-pm@vger.kernel.org>; Thu, 13 Jul 2023 07:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1689256980; x=1691848980;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5kPzBXCjQt2n/3Lt7xgpRjAUQlB7B3ZzaOVDMTh7G3c=;
        b=CTR0u5KrZhiYDfQDuC++ojrmeNZVivot/rk4+Ob5hB9t+Q3HO5t99Qm9Jgn4pmL+al
         ocOSTsp03GPv2CWMP8UEAoq80dRco34oRWVVB4iUR78Aj+TcZ5sN9YO4nZ6PYbreCGQg
         f8Z3BltRtHMLo0qfwp0LJZLA6Qe4BjrCHLwd3Ks6S0Zf/t/IzbQbmOBjwtABKouknATN
         pHRDmu8DeIZTyet0OlZorL4aLqmEjEXP4KyNtnxRfj9D7j44r2iRWeAYVPzGrfsvsUx0
         P32ChAtePiiM3bOqfcD3nMJ/wlDnWnv6yAt2SGfp9JRl+WrCBtBPkV8kC8nHEIY5P2Fk
         kFqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689256980; x=1691848980;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5kPzBXCjQt2n/3Lt7xgpRjAUQlB7B3ZzaOVDMTh7G3c=;
        b=FxjcoLq3Z3475W0zJ0PnJEgD6GHgt84OEeRolJEu/7rwaKT8bKi5Sz4qd2PZMPzOf3
         q6xFAUu2ZGMKCNq5/9MupsYvIDf6BlbR0SqpwlnURvrLt1sc1x4Wc+KxXHVrYshr40In
         tde5aKAqQ+CJ/uMtycPjkJili8Ds0pXqsu6ftq6REntp/jxcDya6KqL9wSzS/LeHOdiW
         8ocwQnxBsiMptiXfIrLOdfe2GAgyHMJBO1r6NVPqvhbyxKO9wEtlAOgzFyX8QzIbRLcJ
         axXdggONqcU7oSH3maI+iu/tBuMJD3pMtEiqLvYv+WC2WRp9b36o5QRvJ9hqvvXDFlni
         1puw==
X-Gm-Message-State: ABy/qLaMs/fysW5SN3HkGqyotj8nSoFbd3XG6etmBcXqTi95YCplYk7s
        vPF7CEznDvqkj0JUaVq/jlbKsA==
X-Google-Smtp-Source: APBJJlFjZrUXlYxsC+dp0elD20fVa47UnrBWZ9eVhma42j/gpw9vEh8xNmMid5OXEuXH70UCaiBmog==
X-Received: by 2002:a17:902:8f8a:b0:1a6:b496:4053 with SMTP id z10-20020a1709028f8a00b001a6b4964053mr832728plo.59.1689256980404;
        Thu, 13 Jul 2023 07:03:00 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id d3-20020a170902728300b001b9cdf11764sm5943710pll.31.2023.07.13.07.02.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 07:02:59 -0700 (PDT)
Message-ID: <64b00413.170a0220.c99aa.cab3@mx.google.com>
Date:   Thu, 13 Jul 2023 07:02:59 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
X-Kernelci-Kernel: v6.5-rc1-26-g998829ca60f7
X-Kernelci-Report-Type: build
Subject: pm/testing build: 8 builds: 0 failed, 8 passed,
 11 warnings (v6.5-rc1-26-g998829ca60f7)
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

pm/testing build: 8 builds: 0 failed, 8 passed, 11 warnings (v6.5-rc1-26-g9=
98829ca60f7)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v6.=
5-rc1-26-g998829ca60f7/

Tree: pm
Branch: testing
Git Describe: v6.5-rc1-26-g998829ca60f7
Git Commit: 998829ca60f7d9d396281f6c1276bf991ab8068d
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
Built: 8 unique architectures

Warnings Detected:

arc:

arm64:
    defconfig (gcc-10): 2 warnings

arm:
    multi_v7_defconfig (gcc-10): 2 warnings

i386:

mips:

riscv:

sparc:
    sparc64_defconfig (gcc-10): 4 warnings

x86_64:
    x86_64_defconfig (gcc-10): 3 warnings


Warnings summary:

    2    drivers/thermal/tegra/../thermal_core.h:18:2: warning: #warning Th=
is header can only be included by the thermal core code [-Wcpp]
    2    WARNING: modpost: EXPORT symbol "_mcount" [vmlinux] version genera=
tion failed, symbol will not be versioned.
    2    <stdin>:1519:2: warning: #warning syscall clone3 not implemented [=
-Wcpp]
    2    18 | #warning This header can only be included by the thermal core=
 code
    1    vmlinux.o: warning: objtool: iovec_from_user+0x88: call to copy_io=
vec_from_user.part.0() with UACCESS enabled
    1    vmlinux.o: warning: objtool: __import_iovec+0x147: call to copy_io=
vec_from_user.part.0() with UACCESS enabled
    1    vmlinux.o: warning: objtool: .altinstr_replacement+0x178b: redunda=
nt UACCESS disable

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
defconfig (arm64, gcc-10) =E2=80=94 PASS, 0 errors, 2 warnings, 0 section m=
ismatches

Warnings:
    drivers/thermal/tegra/../thermal_core.h:18:2: warning: #warning This he=
ader can only be included by the thermal core code [-Wcpp]
    18 | #warning This header can only be included by the thermal core code

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
multi_v7_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 2 warnings, 0 se=
ction mismatches

Warnings:
    drivers/thermal/tegra/../thermal_core.h:18:2: warning: #warning This he=
ader can only be included by the thermal core code [-Wcpp]
    18 | #warning This header can only be included by the thermal core code

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
x86_64_defconfig (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 3 warnings, 0 s=
ection mismatches

Warnings:
    vmlinux.o: warning: objtool: .altinstr_replacement+0x178b: redundant UA=
CCESS disable
    vmlinux.o: warning: objtool: iovec_from_user+0x88: call to copy_iovec_f=
rom_user.part.0() with UACCESS enabled
    vmlinux.o: warning: objtool: __import_iovec+0x147: call to copy_iovec_f=
rom_user.part.0() with UACCESS enabled

---
For more info write to <info@kernelci.org>
