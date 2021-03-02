Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6042232A296
	for <lists+linux-pm@lfdr.de>; Tue,  2 Mar 2021 15:54:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347615AbhCBIKa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 2 Mar 2021 03:10:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378413AbhCBBF6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 1 Mar 2021 20:05:58 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49198C061756
        for <linux-pm@vger.kernel.org>; Mon,  1 Mar 2021 17:05:18 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id q20so12706746pfu.8
        for <linux-pm@vger.kernel.org>; Mon, 01 Mar 2021 17:05:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=mOpnasr3MKvB86pVRQMk8zlvg62l2zaA+fAocEet8RM=;
        b=LANygoznIu4BkjTG+/CpYXpuh5ANnd7YZ7lvKJmmXJ0haoGQOTSw1SGfxxMyYd/L/6
         8baiCRXcxhY64TWWVA6bJ+AgJR9n7/+mB+9fWbv1tjxUzF9H88UnYqbfUWojWKcL8xCO
         zsTV1Tfu9LD7KbYJO3XRZd47wkSNmrn97MnQLP7qf/igjMq+ZzygYCb3JyQW1ND4Wl5z
         pzn/ZdoaIW8dqCR15rhDIBfcul9rsRpREJAcdlxz9m3kX1AtEka1VXWJ2i5gtjg8dZs2
         /ktRUmUl/pe2hwN/wCVGEVoXjp+FJzufqL9AMCbUSV+he1bBABV8R65I/KJVJqdurNwn
         h1ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=mOpnasr3MKvB86pVRQMk8zlvg62l2zaA+fAocEet8RM=;
        b=nPWCD3CUnFOC3LPn/lfBXqoTBeCZtdWvDBAmoaekIjevb1Pj2NKkXHUJy5UcI6s37v
         p7zfxQMeUk7KbV+80mXsFvWK2Z1XOOqZHTcGbd3lhN9t831IjnzcuVphaecijDFTSC24
         A0OyULmhyNH1h+N4FmxIoR+kxfkLggr899ykFnAcPnk2tPvMXLau+jiTuYw2hdhmfFOW
         7p59Pw/hASpP2AAJHn53SkEY43eCmP/fKhauR1eUKw7cADAaPzXO0MZBMsa3nwL5T9QG
         3wkifDyKlExDfVhMFArkWdpRAMP2g7Bcz6GT7/ncupKvc4tumNYsVOAFuray0bmgzv/P
         EFrQ==
X-Gm-Message-State: AOAM531MYLCcehzDDmlhXyhT6qlW3iRwHenPnuhDDg7LqQ1+kbL8nItX
        rgX4VYqupDadycB+1s+KcOPe5Q==
X-Google-Smtp-Source: ABdhPJyOqRuJXs/A8tnMRwlSZ/Yw5Q1YQqK9nrsOAJkTRcHuTqPoXxxv8bTf8flB5yooPQErpt2yaA==
X-Received: by 2002:aa7:875a:0:b029:1ed:aebe:e1e with SMTP id g26-20020aa7875a0000b02901edaebe0e1emr1045167pfo.50.1614647117829;
        Mon, 01 Mar 2021 17:05:17 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id y202sm19672245pfb.153.2021.03.01.17.05.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Mar 2021 17:05:17 -0800 (PST)
Message-ID: <603d8f4d.1c69fb81.b895d.e0df@mx.google.com>
Date:   Mon, 01 Mar 2021 17:05:17 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.12-rc1
X-Kernelci-Report-Type: build
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
Subject: pm/testing build: 7 builds: 0 failed, 7 passed (v5.12-rc1)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 7 builds: 0 failed, 7 passed (v5.12-rc1)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
12-rc1/

Tree: pm
Branch: testing
Git Describe: v5.12-rc1
Git Commit: fe07bfda2fb9cdef8a4d4008a409bb02f35f1bd8
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
