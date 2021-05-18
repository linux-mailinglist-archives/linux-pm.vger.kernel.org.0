Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24D2F386FF4
	for <lists+linux-pm@lfdr.de>; Tue, 18 May 2021 04:36:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237460AbhERCh4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 17 May 2021 22:37:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230228AbhERCh4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 17 May 2021 22:37:56 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3CB9C061573
        for <linux-pm@vger.kernel.org>; Mon, 17 May 2021 19:36:38 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d16so6299537pfn.12
        for <linux-pm@vger.kernel.org>; Mon, 17 May 2021 19:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=nKa84xb+3/AF1nIoA1hmwNH8sSGPzz754RqGpwfKmyE=;
        b=tvYajf/aCFjIP/Stq2Rsat+VvXOtkYE3TNa/EogdhjiYYKIQVefr/x/KO2QFmxsNln
         YmLFzmzrX1buTc0X1pHUAFnbv8ThKu6RE5mZNlGvUe7VJGdZl8R3AU9JYRlXCH26aXWj
         dxXFKH7L9cjW3DxXE8tbbjEg0T02jiCAI2tbmu7fyU7+uFlopsbbFJ5Iu25sHKNm6EoU
         Xn+YaXc+aT26up2Fn94wZoc9uH6FYbE3ROrEQDAp8nU/ycKli8Sa4bjqRCBhd2nD+EhZ
         v3+gF3W1UMWBsbCviQ6J/ZJWrbv2s2oYK8Je0yzxYbxOrSJNKhTFQgJt1qGy+ufuZGHg
         hwpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=nKa84xb+3/AF1nIoA1hmwNH8sSGPzz754RqGpwfKmyE=;
        b=LzWnInEpu2Zka9n/79Mcn/sciw30/QgLKSxP6aZsGv10pzKL/NSKUnXYkit8Z5HUuN
         3teLybTm12Qhd21+xxFPEukMNUGbysHJql1UbC4yWArUeuxzxvPHUvG71IvJvjQHmtsP
         wxz1pB3DpEQlW6Z5vWFoHZsBDS5YcIwmteF4DqeCWAgB+am3CxxbXQsRVFn4Cw98X4Ii
         nC6Q6gO9sYocnnabzrPPZq/2idkpm1ykXf7GktDPq/ut18p+7s1uFNirb0bSSsJm6sBC
         rbljUceGJYBPZY6KiBWkCdU5LgP2u0YrwtpahKrGQLTmubZ8eUMTfTIjXdecLz7n2cg/
         vh7Q==
X-Gm-Message-State: AOAM531tUhVJVFKKItlJu2guAIltYrqf73TqVfOMUZvhV8BfsVV09H8H
        C7Rs9dWuMiGh4ZKprs+QWfLFPw==
X-Google-Smtp-Source: ABdhPJzxTY+AULrfyktTIfsYF3EGJa7i4Hh37nmKpi9xl/fx4Uuo9ymiYYnS1T1lDxFACZ8pyXpX0g==
X-Received: by 2002:a63:9d43:: with SMTP id i64mr2629345pgd.205.1621305398455;
        Mon, 17 May 2021 19:36:38 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id x133sm11132448pfc.19.2021.05.17.19.36.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 19:36:38 -0700 (PDT)
Message-ID: <60a32836.1c69fb81.f274f.646b@mx.google.com>
Date:   Mon, 17 May 2021 19:36:38 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v5.13-rc2-4-g3da05329d571
X-Kernelci-Branch: testing
X-Kernelci-Report-Type: build
Subject: pm/testing build: 7 builds: 0 failed,
 7 passed (v5.13-rc2-4-g3da05329d571)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 7 builds: 0 failed, 7 passed (v5.13-rc2-4-g3da05329d571)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
13-rc2-4-g3da05329d571/

Tree: pm
Branch: testing
Git Describe: v5.13-rc2-4-g3da05329d571
Git Commit: 3da05329d57186b0e0d4e510ac5f38bd12c4f70c
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
