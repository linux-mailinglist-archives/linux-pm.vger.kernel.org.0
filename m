Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF9847232F0
	for <lists+linux-pm@lfdr.de>; Tue,  6 Jun 2023 00:10:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231386AbjFEWKV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 5 Jun 2023 18:10:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231358AbjFEWKV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 5 Jun 2023 18:10:21 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB0AEAF
        for <linux-pm@vger.kernel.org>; Mon,  5 Jun 2023 15:10:19 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-53f70f7c2d2so3010234a12.3
        for <linux-pm@vger.kernel.org>; Mon, 05 Jun 2023 15:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1686003019; x=1688595019;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=YLNWpF5V2EZVVCkzkxLTQXoD827MlYu4NUkziwuPhjs=;
        b=4EV8bP+NG+BMIWvGkkvbqleY3cGpZjyjtmup5u/YakQuDd/ri137fMg0XlVJlgEBek
         WsL4MrKLXlpcimbSZU4OwDaMxPmJC5KhHPP6IyZi8JPb+cxh1/3eNQREkhq3MnDk8E+d
         KNN1WCtvpNphshL1HM36BhUD9czLuIYf6YQpkmasRzTA+lli7pAOJQlpri2827aw5sWi
         YkUTd3Ji2GFhdqKmtjtNTuGQhlb2Mc3FTpKR0TPf3aGo2iTE6f2kC9VSk2MSeGdPBDn2
         GCZIIqRzz82TkcpMijq7vxX7y6FyMhltQjGzhxx2AOZfXGHJs+v/8th2wMXcDZ96xrBU
         nwIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686003019; x=1688595019;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YLNWpF5V2EZVVCkzkxLTQXoD827MlYu4NUkziwuPhjs=;
        b=VPqLgNh8TNpNIJ8wdGeMuatmohSm0qf8TFuAz0op2YR9iPxkbD08+YZVzSB6qE204D
         Qx8OxHl4Ni8nKlwD4zcxZNZlPB61ml+YVEotwL8YDeuz9Hjh+HiJ029N6IHNXIIXjUee
         xqeDWpBR4B3nvQ24eXhzatcwmhouKGV7l74sBeOPaydwlLI/JVdIzvRnKibWX0whKby3
         1nHjuM2F57dd0tK59e6p13Ee5qHBAklbEtrLxa5zXEJvt5Fq3VLXAyWiR9ovs8w5iPDZ
         ZZ+JEQs3WEpkkaShj2NCul9bPoCgfpLhr2eh8YGYMVYe2rrsLApSbDCMgdHUTaORr9+W
         Z7FQ==
X-Gm-Message-State: AC+VfDwW4lJ/NM9G8qL6+Z3z3uyFCpBoA5rra/zL0sQK2+v93yhGQwX0
        1L6l+J8h4uy4paw1L1SQ4IIFLUvR6ESQlclaZzJJAw==
X-Google-Smtp-Source: ACHHUZ7aA9O5PsWJg1SmFQV+rMe+cavYcSTWiGhQk6uSTGG9aPQDClPfRfvsFfoVaZOeXENpQ20oUw==
X-Received: by 2002:a17:90b:954:b0:253:4e54:6761 with SMTP id dw20-20020a17090b095400b002534e546761mr3961026pjb.34.1686003019177;
        Mon, 05 Jun 2023 15:10:19 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id a14-20020a17090a688e00b0025930e46596sm3231443pjd.55.2023.06.05.15.10.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 15:10:18 -0700 (PDT)
Message-ID: <647e5d4a.170a0220.894fa.5df6@mx.google.com>
Date:   Mon, 05 Jun 2023 15:10:18 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.4-rc5-28-geb13f81a5367
X-Kernelci-Report-Type: build
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
Subject: pm/testing build: 7 builds: 0 failed, 7 passed,
 7 warnings (v6.4-rc5-28-geb13f81a5367)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 7 builds: 0 failed, 7 passed, 7 warnings (v6.4-rc5-28-geb=
13f81a5367)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v6.=
4-rc5-28-geb13f81a5367/

Tree: pm
Branch: testing
Git Describe: v6.4-rc5-28-geb13f81a5367
Git Commit: eb13f81a53677b4a4d8e953f4d66145cf6b01cad
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
Built: 7 unique architectures

Warnings Detected:

arc:

arm:

i386:

mips:

riscv:

sparc:
    sparc64_defconfig (gcc-10): 4 warnings

x86_64:
    x86_64_defconfig (gcc-10): 3 warnings


Warnings summary:

    2    WARNING: modpost: EXPORT symbol "_mcount" [vmlinux] version genera=
tion failed, symbol will not be versioned.
    2    <stdin>:1519:2: warning: #warning syscall clone3 not implemented [=
-Wcpp]
    1    vmlinux.o: warning: objtool: iovec_from_user+0x88: call to copy_io=
vec_from_user.part.0() with UACCESS enabled
    1    vmlinux.o: warning: objtool: __import_iovec+0x147: call to copy_io=
vec_from_user.part.0() with UACCESS enabled
    1    vmlinux.o: warning: objtool: .altinstr_replacement+0x17a8: redunda=
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
x86_64_defconfig (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 3 warnings, 0 s=
ection mismatches

Warnings:
    vmlinux.o: warning: objtool: .altinstr_replacement+0x17a8: redundant UA=
CCESS disable
    vmlinux.o: warning: objtool: iovec_from_user+0x88: call to copy_iovec_f=
rom_user.part.0() with UACCESS enabled
    vmlinux.o: warning: objtool: __import_iovec+0x147: call to copy_iovec_f=
rom_user.part.0() with UACCESS enabled

---
For more info write to <info@kernelci.org>
