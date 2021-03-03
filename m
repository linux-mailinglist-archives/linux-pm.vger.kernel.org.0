Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD00132C2E2
	for <lists+linux-pm@lfdr.de>; Thu,  4 Mar 2021 01:07:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbhCDAAK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 3 Mar 2021 19:00:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1577592AbhCCRs6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 3 Mar 2021 12:48:58 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01CB6C061756
        for <linux-pm@vger.kernel.org>; Wed,  3 Mar 2021 09:48:17 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id 18so1931319pfo.6
        for <linux-pm@vger.kernel.org>; Wed, 03 Mar 2021 09:48:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=DQdGOAiJkqTPyzLoXEVeKPh/2PQ5YOKkFlSaLqof2c4=;
        b=Xar6N691lsdKt4mB4K1pmdFP0hYMk+z6cleRmjDPcv6ROFLf1frFC2TCsbfavDhY2G
         yX6RG2o529u8kLclmtH31NZ5HuJ/RaxKFSAnthm74cG6AP0w6MXBwHCdBpqpyTKC5NhS
         POr6GwGHxCmpcIKSw3ZdEDp2Oh8R+11bV+2mNXZMK7DqYzuDYu51su4DxgTxIiINEWRc
         FKha5Pg55sUpmuIDh8b+VtOt4m0rren5oMJGprKa4lSNuWqhq+uU04cRTdRvgg1HqClf
         nmBGITdAOOKxkI8Tk90aJiRtKJDZa11oRzipbKxyImA7miDUHZGPrWklh9PmT/IgcUJ2
         suhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=DQdGOAiJkqTPyzLoXEVeKPh/2PQ5YOKkFlSaLqof2c4=;
        b=LRoeyxwdFTiknngrhMnhYOi2iXlDD10aUv4O7svbX8wW9xSboUAcnuwQYy2PKbJCsh
         2RQkG84A+5/YGqGSxhfTfy3i6kHGEJcogJSmtuIFCAD2EWllzn2jBNUf24/xqbL1T6wZ
         7NAH0Thg5bGccuJspt2tk2jgb9j+H71gaiUN9rT7iDXxF54VNgEGQP6hGV1c2n8aPfof
         Vx8jbG95U894jTpbQRAC9qcLyoiTX/yuNehiBBRC4lf894YpQBm2uwzlW1I+BwPF3Dz7
         SfW1SrPUwBrssVxRX57KWuPX1UkCDKNirG9Ycmbiewp9+gkQsl/CJAHtISlxlO5Ke8FD
         an8A==
X-Gm-Message-State: AOAM532K3A8KiiShUSqvNsrRAxeb5zQ9SxMe/tfW9WFjbKUs4wwUKv16
        Vz1s09Hf++JMe1fEIOHUrDY5kKYLD7e8IUPx
X-Google-Smtp-Source: ABdhPJzQX4vxXnERUQT8OdGxbjODd6z7+rUSw+EC1mBoAUs9a3C0AGxH5xqZEXRMgNQSQ/k1aL2m6Q==
X-Received: by 2002:a62:d454:0:b029:1ed:a6d6:539d with SMTP id u20-20020a62d4540000b02901eda6d6539dmr4062720pfl.63.1614793697499;
        Wed, 03 Mar 2021 09:48:17 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id j35sm10925221pgj.45.2021.03.03.09.48.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 09:48:17 -0800 (PST)
Message-ID: <603fcbe1.1c69fb81.891bd.7ec6@mx.google.com>
Date:   Wed, 03 Mar 2021 09:48:17 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.12-rc1-5-g51165d52eceb9
X-Kernelci-Report-Type: build
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
Subject: pm/testing build: 7 builds: 0 failed,
 7 passed (v5.12-rc1-5-g51165d52eceb9)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 7 builds: 0 failed, 7 passed (v5.12-rc1-5-g51165d52eceb9)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
12-rc1-5-g51165d52eceb9/

Tree: pm
Branch: testing
Git Describe: v5.12-rc1-5-g51165d52eceb9
Git Commit: 51165d52eceb9a6a227e39c9b369b4f437e4e620
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
