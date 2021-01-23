Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78F23301201
	for <lists+linux-pm@lfdr.de>; Sat, 23 Jan 2021 02:31:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726305AbhAWBaj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 22 Jan 2021 20:30:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726287AbhAWBab (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 22 Jan 2021 20:30:31 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2D9DC06174A
        for <linux-pm@vger.kernel.org>; Fri, 22 Jan 2021 17:29:43 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id 15so5001885pgx.7
        for <linux-pm@vger.kernel.org>; Fri, 22 Jan 2021 17:29:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=fwMK8hL5GZtK2ukB9hGytscFOxF0z5dBeuZnyFzeGEM=;
        b=gOXUJTORQSiiVCuTD9XX1Xe94jsTezUID2nOq/RqOlUX7RtptWYavSiQrkDWqPXDjX
         Tl2kJfmOchHqo8nse0zVA221fQVzWYQcEzNGkzxaMMWFVsdMzOfK+2DthkAYgnAa6P3u
         rcq3XnPtHT5hWFEXaZG7fHBdN9g098ii49iM3FADXgTM0NLxXHOInL/CHfrNMCfrt4Wo
         15TXtNlPMLxOkJlh5izSJtICG1u+WU0BAxiQPJnoshBgo0uGOKsTCCBAtaNcM4KwCzpz
         JjKMqqLmUoJtuRT3tBDfq92WiJkUs+U5/kkvfQYGlFAWUUFtGdgDuQyOuVJUphNl5HWg
         P+RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=fwMK8hL5GZtK2ukB9hGytscFOxF0z5dBeuZnyFzeGEM=;
        b=thtSWVQQNYJGjAmcjwyKTa771GBHdZ5YrPbXjONljZ/Gkg3ClYdl+LIVGUjWYDvluX
         2STv4mrpMJ3G/nvTgdxQBP2GGKnEQ8nMoVcSRs8xng80SZSQAhDDFAnlyuvm48lXNyKv
         8wDP9LIfzv3JOSl7ZtSR68t5SJtTT4gB30/IB398X3BYC3jtcf3FSsc9gki3QmueOIFq
         WkDzGtEz5SEbzzOHKYa3kYpsPla83g60PrXCwLEmOkaDlAaoZ+4aYUtoJRB8HYXoUQSQ
         vm0RkkQ4atndrIlfgXHzzNOD+x6k0P3/ZRunrQmaIBWdU0afSV1jgMaeo4u4qB9jLMyC
         QAfQ==
X-Gm-Message-State: AOAM531F5ENfaGfwO3ZPR4FF0v17f0hXuwTke+xue2q56lc78k2jbKbo
        m1rQKWolBINaKkhAGK+wsPJlGw==
X-Google-Smtp-Source: ABdhPJxy3YBNoXxW9Pqc9DTj8JI+2vrLdotdipVinXcT4WE2lYlGDIc7cc1f0uFqSi6pOuCxtCLoDg==
X-Received: by 2002:a65:49cf:: with SMTP id t15mr7417427pgs.77.1611365383415;
        Fri, 22 Jan 2021 17:29:43 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id v8sm2131641pfn.114.2021.01.22.17.29.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jan 2021 17:29:42 -0800 (PST)
Message-ID: <600b7c06.1c69fb81.f2ba6.52ec@mx.google.com>
Date:   Fri, 22 Jan 2021 17:29:42 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: acpi-5.11-rc5-27-gad758c58a703
X-Kernelci-Report-Type: build
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
Subject: pm/testing build: 7 builds: 0 failed, 7 passed,
 1 warning (acpi-5.11-rc5-27-gad758c58a703)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 7 builds: 0 failed, 7 passed, 1 warning (acpi-5.11-rc5-27=
-gad758c58a703)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/acp=
i-5.11-rc5-27-gad758c58a703/

Tree: pm
Branch: testing
Git Describe: acpi-5.11-rc5-27-gad758c58a703
Git Commit: ad758c58a7036596aed10b408535d4e0dd16c7d6
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
Built: 7 unique architectures

Warnings Detected:

arc:

arm64:

arm:
    multi_v7_defconfig (gcc-8): 1 warning

i386:

mips:

riscv:

x86_64:


Warnings summary:

    1    drivers/pinctrl/nomadik/pinctrl-nomadik.c:952:8: warning: unused v=
ariable =E2=80=98wake=E2=80=99 [-Wunused-variable]

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D

Detailed per-defconfig build reports:

---------------------------------------------------------------------------=
-----
32r2el_defconfig (mips, gcc-8) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sect=
ion mismatches

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
multi_v7_defconfig (arm, gcc-8) =E2=80=94 PASS, 0 errors, 1 warning, 0 sect=
ion mismatches

Warnings:
    drivers/pinctrl/nomadik/pinctrl-nomadik.c:952:8: warning: unused variab=
le =E2=80=98wake=E2=80=99 [-Wunused-variable]

---------------------------------------------------------------------------=
-----
x86_64_defconfig (x86_64, gcc-8) =E2=80=94 PASS, 0 errors, 0 warnings, 0 se=
ction mismatches

---
For more info write to <info@kernelci.org>
