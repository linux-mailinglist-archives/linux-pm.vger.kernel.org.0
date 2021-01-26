Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50B0F304E93
	for <lists+linux-pm@lfdr.de>; Wed, 27 Jan 2021 02:19:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729702AbhA0Aje (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 26 Jan 2021 19:39:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391717AbhAZTde (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 26 Jan 2021 14:33:34 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90019C061573
        for <linux-pm@vger.kernel.org>; Tue, 26 Jan 2021 11:32:42 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id n25so12126464pgb.0
        for <linux-pm@vger.kernel.org>; Tue, 26 Jan 2021 11:32:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=zu1edfOTzrSNV8MarHjsK8aa8ZA1YL1qwnd6yXr4tWc=;
        b=WH7/k0Sf8jlPtcEJ74vhpEWfg6dN2ExeswwwDUiXdNNPQasA9Bh8V0GawX4e1fKvXt
         Z+fxMFu6VLD6VNhwZbG6NYLQrxk8MWXfGak9ijwipTWAbIHtVfkx/USyDLOXXId3pouu
         xMuUfTscU749OZLIiulOBr2orwUqfqjAX3QPjIAS6mna1za+trqJT4Rpq4GfSzhmzmJY
         SqKtSzIpgJrNX/BmYnWrgpJIQhMskFNL5hUk5TpesFkpiOESf4apXeoILXa/tqI88HSg
         /HF4PCiOer7lGqQokQI0K23HLDui4YtWKP7Q7HrtXo2WFoDm+VM5jLiqD+NHdqiT2scn
         pYtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=zu1edfOTzrSNV8MarHjsK8aa8ZA1YL1qwnd6yXr4tWc=;
        b=liTaLUOTFHqasBa8DLsvc0s7xphWwF5w/gmE1sgjPqW1k4XquJ91mhipEH1CPKbDrj
         x3NacTZsLc4KsaSveq3Lk4TAxyCq4Dgnn5W7nc/b9NkO4yM+T1JQmHRgwQyQ4P/eq9uf
         gzHorjt1K1lrxlcYv02ECAtpkDrnDRloDmOo5m05xwJCN18xk/LK+zorp/mxlf6nG7X7
         wtc3DTob7nA/rux+HzzgWQ2dTy+j4Y7iFErAwo6T2zFtifcU99CXIUGq+tGwP4WuFAS4
         UfWdYp76XS4CBtn0gnpQw22ALrmcvTTAL3CAT3i8Z+lCmQOXUgBGJJX3RQHUSaFJf5K/
         S/5Q==
X-Gm-Message-State: AOAM530nc+r/pvEDhO9DwLIc/d3G8O59Qzsw98koYO5QqZVT6sU5Uj1N
        Gqkzi7UsYY77PtFu+gEgRXufwA==
X-Google-Smtp-Source: ABdhPJwSq/uCoBKTR7o7tbxVQNv7SiNbs3Wha8HDkSRLdGf/mAwwbsAeeJfBLBhF7EA8iePUznQHHg==
X-Received: by 2002:a63:5453:: with SMTP id e19mr7084216pgm.439.1611689562090;
        Tue, 26 Jan 2021 11:32:42 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id u126sm18935529pfu.113.2021.01.26.11.32.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 11:32:41 -0800 (PST)
Message-ID: <60106e59.1c69fb81.6260b.ddbd@mx.google.com>
Date:   Tue, 26 Jan 2021 11:32:41 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.11-rc5-48-gfeb0d85db3fd2
X-Kernelci-Report-Type: build
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
Subject: pm/testing build: 6 builds: 0 failed,
 6 passed (v5.11-rc5-48-gfeb0d85db3fd2)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 6 builds: 0 failed, 6 passed (v5.11-rc5-48-gfeb0d85db3fd2)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
11-rc5-48-gfeb0d85db3fd2/

Tree: pm
Branch: testing
Git Describe: v5.11-rc5-48-gfeb0d85db3fd2
Git Commit: feb0d85db3fd2da4a4a0d9f09eece2a3e111ebdc
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
Built: 6 unique architectures

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
