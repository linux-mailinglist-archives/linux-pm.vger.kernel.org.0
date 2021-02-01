Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26B9130B35F
	for <lists+linux-pm@lfdr.de>; Tue,  2 Feb 2021 00:21:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231243AbhBAXUw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 1 Feb 2021 18:20:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbhBAXUv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 1 Feb 2021 18:20:51 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DE19C061573
        for <linux-pm@vger.kernel.org>; Mon,  1 Feb 2021 15:20:11 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id j2so11626842pgl.0
        for <linux-pm@vger.kernel.org>; Mon, 01 Feb 2021 15:20:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=E7bwQSB7d+b8IzbMBunDK76c97AoZayq2NB6+XWoI0c=;
        b=sVHQ1tGTNos6qr8slCZY27HDZpbF24n8qA/RxxULALUmnpaNCv615wwvQbmge2xXM6
         X4xKU9FA6KepHlnkfVX0HahL/jsFSAiFlP3nW4osF8A/QrZRHe0c2zGvpM2Tgof+ydt0
         oVxsVsBAEkWjAartxn8U0+Yg5efMzO7nQXcZ89mPUVWcBYP3jJORU2Zv++0+S28ihKvH
         2w+OKvyQ43+B6n9H+bxlPCoSQEkd8FrpbeXtON/dp/YjssvoVLJD6eGWnQ9k9whjlhGa
         Gvn8QcRoB77XaJFfQT07P3N/f9nmfCby0e/VkuFFnwXvay35QdRyO2Hc4JGLMpw6mvNt
         02Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=E7bwQSB7d+b8IzbMBunDK76c97AoZayq2NB6+XWoI0c=;
        b=sEK75zCUXDZXrs6OlPOZzAwWB9y5idkeDvXnzzo+qKdI/zIdvzuknY5nXYNYeKzJlW
         BjUWcj+vzg1YuMMtWnV9IOyRu07vjbGm9+sHqVztD5cLTfvBUCsvum+sXQw6tJlsiZ/O
         7zhpfO2l681M5PEK+PW4wZ/puWYkRO/ih8jQIkxYccStFF+FVgxgjUbv9ocwdcrsjyYC
         yd50lLB7pYqoCa24pvFFMUSXX7hZ1fUK3U00EwjbDfhee0uyLdFFPtSDz5SCnEjhHb9x
         OTYoo2xJ+sJUP8PYU/kyn/1FeGIjOHvHjrrHuOdt2bNd+xA0wryhE9JquWUbYB0C16Pm
         jq2A==
X-Gm-Message-State: AOAM530mnUXMv33P1HRNrK07lbZpZNHB97Yvvv6muO1E7S+Y+roKDCfh
        M5Q9ok2zE6lS4e9sIm2ddVxntQ==
X-Google-Smtp-Source: ABdhPJxAOf7OVtY197bSKxqCgaz6BcRtgXFaRacjVAv9Y7bnBWqDg9t1+YkLe3s6mTlmY5T4wczymA==
X-Received: by 2002:aa7:808b:0:b029:1ce:8a32:f5e8 with SMTP id v11-20020aa7808b0000b02901ce8a32f5e8mr3396532pff.34.1612221610901;
        Mon, 01 Feb 2021 15:20:10 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id 17sm19989791pgy.53.2021.02.01.15.20.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 15:20:10 -0800 (PST)
Message-ID: <60188caa.1c69fb81.dcf88.f423@mx.google.com>
Date:   Mon, 01 Feb 2021 15:20:10 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.11-rc6-68-gd613f8c46696
X-Kernelci-Report-Type: build
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
Subject: pm/testing build: 7 builds: 0 failed,
 7 passed (v5.11-rc6-68-gd613f8c46696)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 7 builds: 0 failed, 7 passed (v5.11-rc6-68-gd613f8c46696)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
11-rc6-68-gd613f8c46696/

Tree: pm
Branch: testing
Git Describe: v5.11-rc6-68-gd613f8c46696
Git Commit: d613f8c46696a27f2198385e1e2e671b834472f8
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
