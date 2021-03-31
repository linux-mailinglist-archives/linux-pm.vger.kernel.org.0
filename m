Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0C6234F64B
	for <lists+linux-pm@lfdr.de>; Wed, 31 Mar 2021 03:41:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbhCaBlN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 30 Mar 2021 21:41:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbhCaBlE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 30 Mar 2021 21:41:04 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06C86C061574
        for <linux-pm@vger.kernel.org>; Tue, 30 Mar 2021 18:41:04 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id f17so7091205plr.0
        for <linux-pm@vger.kernel.org>; Tue, 30 Mar 2021 18:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=Z6yHNoK7Znb7eTep6Ce90/HFIqX/4vVJbde6LITuLi0=;
        b=z43ymiPoUx1g8sbPVGQ+AMdQbvwEAEPyGBVM7aLgjv3f496dVfeLtuUQ68DH+lNhDU
         9ONVnOFqfou768Sad7vsoNv/M7ruFNqaZjAY1zDInaxDnDF+HphhuTrHzLL2B5vMDsHV
         tm7ktuz18Mg+7aXWLlwRQ8/hplmv++K5mE4hnO+ueZjJKbxtahVe5TcDP6WDsTG/dZD0
         fU92VqTjt3iTuboLwmSJrXaylGtFtH/1YBLT9+st6EmUGG9eoWOYpJ9GZVEEmWniLROp
         7RV0o3W3Q5P8GT+cUoVJ/l6pXQsrMK9LSi+Z2+TXyx21WH1c/e8MCqrs5k3WL8OqQVa5
         mvLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=Z6yHNoK7Znb7eTep6Ce90/HFIqX/4vVJbde6LITuLi0=;
        b=Ot6kZWovl/nFb0gel+jUCl5uTbKvB8r+h0ztW8x7Onwa3RkUDA1DlDc7iydKhCY/iO
         hXUY49AfIrognoRTCUnT0w7UGV91ckVdNquzAE2iXBZMS3o4qRwWa8fXcOxbiRiU+FSE
         Ntc3oaEZEhOtKS6GSuNYk0a1CCb8hDoSNP6U+QwvbEhCIY01+TpB9RSX6QZPDozOpmgB
         5xXA/xQcz1gXZ0ws2DAUkDe+h6v/uwwDmKoo2hpn+T4gqbC7petSWsMALC0M+s1Y1k70
         QxapGxTwlBRbYi4qOGhAAby4Xq00N+2YXeB9X0Wy6oz6A0MkHXK30BMBsjhm0TwgpNf2
         Yn9A==
X-Gm-Message-State: AOAM5302PotZDVFsDCRMG06bMnPttXjWWgv2ZxKQaxv8Iehe623ZwHiS
        f2nGDKv/8sAFqzAzB8RmTwY2ng==
X-Google-Smtp-Source: ABdhPJziBywT/8wNs6/9oC8X1PA/d0woYEeG1FaymNMbCowHWUzN1cJNtFYVZioWybwIqtVtYIgraQ==
X-Received: by 2002:a17:90a:ee84:: with SMTP id i4mr1074664pjz.116.1617154863535;
        Tue, 30 Mar 2021 18:41:03 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id s22sm240355pfe.150.2021.03.30.18.41.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 18:41:03 -0700 (PDT)
Message-ID: <6063d32f.1c69fb81.38508.1266@mx.google.com>
Date:   Tue, 30 Mar 2021 18:41:03 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v5.12-rc5-47-g506a524e05e2
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
Subject: pm/testing build: 7 builds: 0 failed, 7 passed,
 3 warnings (v5.12-rc5-47-g506a524e05e2)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 7 builds: 0 failed, 7 passed, 3 warnings (v5.12-rc5-47-g5=
06a524e05e2)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
12-rc5-47-g506a524e05e2/

Tree: pm
Branch: testing
Git Describe: v5.12-rc5-47-g506a524e05e2
Git Commit: 506a524e05e240d2878cf86a56c47e72e09d329f
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
Built: 7 unique architectures

Warnings Detected:

arc:

arm64:

arm:

i386:
    i386_defconfig (gcc-8): 1 warning

mips:
    32r2el_defconfig (gcc-8): 1 warning

riscv:

x86_64:
    x86_64_defconfig (gcc-8): 1 warning


Warnings summary:

    2    drivers/acpi/processor_idle.c:542:15: warning: extra tokens at end=
 of #ifdef directive
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
i386_defconfig (i386, gcc-8) =E2=80=94 PASS, 0 errors, 1 warning, 0 section=
 mismatches

Warnings:
    drivers/acpi/processor_idle.c:542:15: warning: extra tokens at end of #=
ifdef directive

---------------------------------------------------------------------------=
-----
multi_v7_defconfig (arm, gcc-8) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sec=
tion mismatches

---------------------------------------------------------------------------=
-----
x86_64_defconfig (x86_64, gcc-8) =E2=80=94 PASS, 0 errors, 1 warning, 0 sec=
tion mismatches

Warnings:
    drivers/acpi/processor_idle.c:542:15: warning: extra tokens at end of #=
ifdef directive

---
For more info write to <info@kernelci.org>
