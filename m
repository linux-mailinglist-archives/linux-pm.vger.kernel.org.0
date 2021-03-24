Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BA5C346EB0
	for <lists+linux-pm@lfdr.de>; Wed, 24 Mar 2021 02:32:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234516AbhCXBbn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Mar 2021 21:31:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234498AbhCXBbQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 Mar 2021 21:31:16 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0ECAC061765
        for <linux-pm@vger.kernel.org>; Tue, 23 Mar 2021 18:31:13 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id l76so1456953pga.6
        for <linux-pm@vger.kernel.org>; Tue, 23 Mar 2021 18:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=jRIinpMxn+rV5hXkSjiBaUwqq9MMud7JExx5rbtqfRo=;
        b=g4CYYcimK+wqbewJ0Mibou8INquFNaTsuUnUY6auPGyQcMQJLA+MH4LKqd1PNzLXV/
         RMdA9MMxZ2qRGpSIQfLVke6KKjPfX83/FDFMMDzY/IgZ6RC8L4T3825kG/i6tEJHs4+l
         329g1L0sE7DEk4/kC/hJzvbU1ZgCJDiR4z1EBn65g7cYuAynLgaRwKvxso/wBO6qAoEN
         D7CAy0pcsraC70QfM2LZ6NhGPN5EdNj9tJLSNBI0JYOLLqpaOaxoRGCW5kSIPCiDQd+8
         5z89lZtd5aBo5ltyj2gsVxl1uX4Gr+zT+rG2eKbeRgH31E13V2eOunZAjx1tiJ8IPaPU
         E+bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=jRIinpMxn+rV5hXkSjiBaUwqq9MMud7JExx5rbtqfRo=;
        b=LVKWce99L9D4lh6TKNuMghiEqlq44FP2yGSakhsZO51O0GyvDYYeI5hpMiQ6yffzw8
         0PKn+L2WMRkN32pnp90hvi1hsP6oJom2cB7geAqBy2LqkLGlpKhbAgdLinSTK8WCpiBM
         OOdUQwvE/JL/JH6yiMb3jx3M2iQfkFTKxGZCH4p6AFDd/sfUoJZha0HbAIa2NBieCC0/
         CYNatmKjY4HVoHsyJs/qaR07wpHkLdL1StB+B8pag5FQtyLCQ1UJU9EJQJIddXvYryzC
         d+hrjVEnPXIg5G+47b59yrg81LUpgIgPSXzjvM6rb9M6bETvSq/gcugJYtSpu5zYrSAT
         nh5Q==
X-Gm-Message-State: AOAM530fyxwDlmOCPn2mtJxRfalBgibNStkN/+B6DWJATBGK/+zibLx+
        HRKs6awSCX2ucnSiEuJIQCRFpQ==
X-Google-Smtp-Source: ABdhPJw7ixT2r/7tkD6U8FDlnT4PpxvbBFhnhn5caqmZN7s84PnJL92GbHWrFHRSFsuUDbP8FgmlMQ==
X-Received: by 2002:a65:428b:: with SMTP id j11mr884906pgp.47.1616549472969;
        Tue, 23 Mar 2021 18:31:12 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id a24sm411242pff.18.2021.03.23.18.31.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 18:31:12 -0700 (PDT)
Message-ID: <605a9660.1c69fb81.51130.1ef0@mx.google.com>
Date:   Tue, 23 Mar 2021 18:31:12 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v5.12-rc4-41-g144389e954ef
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
Subject: pm/testing build: 7 builds: 0 failed, 7 passed,
 1 warning (v5.12-rc4-41-g144389e954ef)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 7 builds: 0 failed, 7 passed, 1 warning (v5.12-rc4-41-g14=
4389e954ef)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
12-rc4-41-g144389e954ef/

Tree: pm
Branch: testing
Git Describe: v5.12-rc4-41-g144389e954ef
Git Commit: 144389e954ef1b556d4f192276f009158faecff7
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
Built: 7 unique architectures

Warnings Detected:

arc:

arm64:

arm:

i386:

mips:
    32r2el_defconfig (gcc-8): 1 warning

riscv:

x86_64:


Warnings summary:

    1    WARNING: modpost: Symbol info of vmlinux is missing. Unresolved sy=
mbol check will be entirely skipped.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D

Detailed per-defconfig build reports:

---------------------------------------------------------------------------=
-----
32r2el_defconfig (mips, gcc-8) =E2=80=94 PASS, 0 errors, 1 warning, 0 secti=
on mismatches

Warnings:
    WARNING: modpost: Symbol info of vmlinux is missing. Unresolved symbol =
check will be entirely skipped.

---------------------------------------------------------------------------=
-----
defconfig (riscv, gcc-8) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section mi=
smatches

---------------------------------------------------------------------------=
-----
defconfig (arm64, gcc-8) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section mi=
smatches

---------------------------------------------------------------------------=
-----
haps_hs_smp_defconfig (arc, gcc-8) =E2=80=94 PASS, 0 errors, 0 warnings, 0 =
section mismatches

---------------------------------------------------------------------------=
-----
i386_defconfig (i386, gcc-8) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sectio=
n mismatches

---------------------------------------------------------------------------=
-----
multi_v7_defconfig (arm, gcc-8) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sec=
tion mismatches

---------------------------------------------------------------------------=
-----
x86_64_defconfig (x86_64, gcc-8) =E2=80=94 PASS, 0 errors, 0 warnings, 0 se=
ction mismatches

---
For more info write to <info@kernelci.org>
