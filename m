Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA80F39694B
	for <lists+linux-pm@lfdr.de>; Mon, 31 May 2021 23:24:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231571AbhEaVZx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 31 May 2021 17:25:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230433AbhEaVZw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 31 May 2021 17:25:52 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFDD2C061574
        for <linux-pm@vger.kernel.org>; Mon, 31 May 2021 14:24:10 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id 22-20020a17090a0c16b0290164a5354ad0so249581pjs.2
        for <linux-pm@vger.kernel.org>; Mon, 31 May 2021 14:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=FscLwz6JMiCi2UueeqYTypq6VqnFQ6XOOus+Qx9jjHU=;
        b=HlUHKW29vZ02eSq122CYxVV41O/BSR+ng5Rk+FtwXmtFzxthGm8R0Z5PwP1C0uPbvm
         qXlHE68uwfSe5zX3NGUBdA0eeJTYrYVHVwHzZaht3BxYbqSDmvEutJbjUQ9c5gFqG/Qa
         0lNYKchFm4vmxm10yjmtIK+wF8VQv+mrpzggWrhsKXB3mTUmVG6yZxufXZ2fUp96brUA
         vqerwedkPL61U8qONR8rTKbewqQ28rrYphEWMs1qsaLfdLdkIv40BG3lEaFz40bA1zHd
         +N0fvgb29CdcwHpkIKpfRjgo3w8shiU8oOui9I54lkqbf4PvMKWDttRJEx0ggUyVof47
         vw3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=FscLwz6JMiCi2UueeqYTypq6VqnFQ6XOOus+Qx9jjHU=;
        b=DgS1bWDLCx7VCcf0KkC1sY66OnM85idyADlWywEKKDJU45iR1gsugP4q/RqwTtt3/C
         EDQNpKm77gbs/2esB8k/ytPIOGnCJ2TSlFLAczzYvWMB96TnBTfPKSHeRXzD8Gh61P0L
         qPg6vDQI86FrLB/yLOWjK+lFyN5ywpCexXkEhP0neoZQnIL++P3LV3GZc0N3MeW5r4gR
         v5s8drCoq2Z5v1WdMGkqMmPqS2jiKpq6YlhFd4v4YsE/nZh2Lg7Wkgc0WOV9hU9gnb1R
         d9QTWbtkBx3UHn4KnM6XdS5FApcpwcaBy3bzybrGIgGXUepYiC3bu/B1S8FvTuPDhGTu
         670A==
X-Gm-Message-State: AOAM531sFqbj4Nycjae0v7Go7kn6ANYgiWLBdb42NDR6O/d2GLkNKxxr
        G1YSy5eedBwCk3GPFWmZvanphtJyyH76v4lz
X-Google-Smtp-Source: ABdhPJwfMLRsi9RBu15IgGSxVs6pNf6pODY74z9/pcKXyKFgsNwmBgI7OnaSNePme5hx7FErR7kojw==
X-Received: by 2002:a17:90a:cc0e:: with SMTP id b14mr21457271pju.51.1622496250063;
        Mon, 31 May 2021 14:24:10 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id 14sm6001515pfj.25.2021.05.31.14.24.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 May 2021 14:24:09 -0700 (PDT)
Message-ID: <60b553f9.1c69fb81.dbc64.175f@mx.google.com>
Date:   Mon, 31 May 2021 14:24:09 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v5.13-rc4-36-g3931fd6facb6
X-Kernelci-Branch: testing
X-Kernelci-Report-Type: build
Subject: pm/testing build: 7 builds: 0 failed,
 7 passed (v5.13-rc4-36-g3931fd6facb6)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 7 builds: 0 failed, 7 passed (v5.13-rc4-36-g3931fd6facb6)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
13-rc4-36-g3931fd6facb6/

Tree: pm
Branch: testing
Git Describe: v5.13-rc4-36-g3931fd6facb6
Git Commit: 3931fd6facb67570e97b861b6beb5a673c492fda
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
Built: 7 unique architectures

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
multi_v7_defconfig (arm, gcc-8) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sec=
tion mismatches

---------------------------------------------------------------------------=
-----
x86_64_defconfig (x86_64, gcc-8) =E2=80=94 PASS, 0 errors, 0 warnings, 0 se=
ction mismatches

---
For more info write to <info@kernelci.org>
