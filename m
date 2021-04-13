Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08F4035DD7D
	for <lists+linux-pm@lfdr.de>; Tue, 13 Apr 2021 13:11:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243281AbhDMLLj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 13 Apr 2021 07:11:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244634AbhDMLLj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 13 Apr 2021 07:11:39 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BD91C061574
        for <linux-pm@vger.kernel.org>; Tue, 13 Apr 2021 04:11:18 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id t22so11698289pgu.0
        for <linux-pm@vger.kernel.org>; Tue, 13 Apr 2021 04:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=cZRb0dsYP+RERx6qvY1dGbHIqiObOCxPRFA4+sUaIwc=;
        b=g7Z0QuR+azBBNeiUCGGfdFzFt5JRk3tBcFMtPq1VSisiSfijml2YvpDdLhLMw75SEd
         uCvin3qJTUCwrEpq86ijXytCZ8BWe/yrJYWDSUtYe5JL5m8lbVtQz6xjA4ambdqqkWJi
         OQGUfkROOPtzmi3t0Z0mmNgBtwn7ntn3KfmIU7JIUjbxKk3TM15luy7SZjjTb1rN2Wmi
         bwgzffdUIr0RpfMC4lbUmEYnpd0RgUEMaTFpTLHXrEE6Ok9cGsI3GpcatFxKxIwVamPu
         9WK0v4y/+i3Xei3IG4x7y7TvBPFLZKAu/OjcZf2yTYEHGxS9xB5yiQ5M/Ge6VJ5a4fqx
         kGsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=cZRb0dsYP+RERx6qvY1dGbHIqiObOCxPRFA4+sUaIwc=;
        b=Z49CiGplDVCFP+kKBTOPRPMmYfZyRPHNYbjLjfkQ3LGYGzEyvpX3plfhAAftmqWME4
         YSd4RgZCXKJlELXSZX1DDCwjawylxDU45nDjYA72aATf1aNtEDhNGETNIc7/I4eI39JO
         +xfYHRoFxn40zU7r/vYx+YMRP37Kp9K0STpwokQxuYAtfic/dOVOlbiSwTLChIrIMjR6
         6s3OKPeci+z7I3FHu7qBDyEivlWeFDyUAcYJytIHp67D0G6/b+pQ1XTNUg6rGuZ3RJMt
         C2G21OOJ0HCzIjxB+wSIM6vgzSZm46ZJaoVmhVg5k6n34eD4ntcYpUWnX97kQcGSFrk4
         Y+rw==
X-Gm-Message-State: AOAM531cD6Rld6olC5C3+Tb/VSIbxXjBS+Hiol+jlgYAZ1vdfbxIyDuE
        0qLWn48fJ7DOKjQxlbRIUJaGrnzpHihfTA1C
X-Google-Smtp-Source: ABdhPJyP+6nw05EsvssrjrSfvQizRtd/Gc7s3gWirYuGM2Y0w95ZPs+FJhC73WKZXWcL3x6heysUeg==
X-Received: by 2002:a65:6496:: with SMTP id e22mr32169095pgv.46.1618312277694;
        Tue, 13 Apr 2021 04:11:17 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id l1sm14131176pgt.29.2021.04.13.04.11.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 04:11:17 -0700 (PDT)
Message-ID: <60757c55.1c69fb81.691fe.3205@mx.google.com>
Date:   Tue, 13 Apr 2021 04:11:17 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v5.12-rc7-154-g3bf8ef9db350
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
Subject: pm/testing build: 6 builds: 0 failed, 6 passed,
 1 warning (v5.12-rc7-154-g3bf8ef9db350)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 6 builds: 0 failed, 6 passed, 1 warning (v5.12-rc7-154-g3=
bf8ef9db350)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
12-rc7-154-g3bf8ef9db350/

Tree: pm
Branch: testing
Git Describe: v5.12-rc7-154-g3bf8ef9db350
Git Commit: 3bf8ef9db35001dd1aede362ee0cf26bdd11412b
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
Built: 6 unique architectures

Warnings Detected:

arc:

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
