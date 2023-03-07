Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B7626AEAE8
	for <lists+linux-pm@lfdr.de>; Tue,  7 Mar 2023 18:38:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231866AbjCGRia (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 7 Mar 2023 12:38:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231785AbjCGRiP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 7 Mar 2023 12:38:15 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3211A94A5B
        for <linux-pm@vger.kernel.org>; Tue,  7 Mar 2023 09:33:57 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id oj5so13947261pjb.5
        for <linux-pm@vger.kernel.org>; Tue, 07 Mar 2023 09:33:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112; t=1678210437;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=p0/1cscr9G2un+Z09dJP9re9zu64DxxHPfXNrB6Wfsw=;
        b=Y4iHvveqSBaU4VLZ9lsTT0heMmFJnnO486I7w71RhoMvsLnVys0Hjfdm91o0Bm0mJU
         gIhV+3df1eNef5LMaw8Y2iZwOjjIIooBaf+EmqXhNwG/q/W3kRFNbNgNZBfnZUUmMQTS
         GqIB8k1fOcfEQs9psMDNkA9QoyqmQrehOT3hKmzl/hv0NXZlIicOS1oj3+wBs+KOGsqL
         LFCehjB6ZgPi10stEc+TUo7OtmXYKDJ5wRC+7rBV7i9kA71QpNIj/Cq3cLmZjD4U59wX
         kmzxDbn8qNGRWZELA66a0AJJyjg/gr4lSlEEFUyj/QpdjIrrDO9jvMiQ5wb1+aLryXCK
         +W/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678210437;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p0/1cscr9G2un+Z09dJP9re9zu64DxxHPfXNrB6Wfsw=;
        b=f+476TsWXSBihjf7Ortcbp6GPthqYmVBW5FGW0+BPqMgyB0H9al6+oN1ztAzSj2Yf8
         R6b1eS9suhh+N9oPC75THYi+KfmXRsE38YvFfJYooBg2HFtxxenwasGAM//NxRmTkdvN
         fD4uapai5HEpH91Qi75l1Km3VFUSZp1PW7/fXISeuYUEuroLWLYOwA8Nmg8YEGwr9T3Q
         QyP//CHBXnIfKx58IEnY3JN/gP8XKMrV0yE5uwmb5qA3IdpG51MLJzwMi38fzTO48CaA
         +3YslY67UGIG6yvlSqW5Rw7qn5FdKiNAX7OK6Tzbs4CvLrLitz29cp7mxzjIYYeYugfH
         K1yA==
X-Gm-Message-State: AO0yUKVRmBH5OVYmGcn4TTLFkd4MZOeHQYpdN3vG8vtl4w449kb/cW8z
        3mpX1Gk8L/GWh74vj9NzgZuXSdJ/EHjckh5mqCHdFw03
X-Google-Smtp-Source: AK7set9e7snmq9MHIBYKP5bBQ7NnaM0MVJ8muRou9fCJAm2M0epX+ALTVNKLj6FSzoww5qURgG+RAA==
X-Received: by 2002:a17:903:485:b0:19e:898f:8815 with SMTP id jj5-20020a170903048500b0019e898f8815mr13050805plb.9.1678210437102;
        Tue, 07 Mar 2023 09:33:57 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id li6-20020a170903294600b0019e6a3c13a7sm8631078plb.211.2023.03.07.09.33.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 09:33:56 -0800 (PST)
Message-ID: <64077584.170a0220.dc704.f7bd@mx.google.com>
Date:   Tue, 07 Mar 2023 09:33:56 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v6.3-rc1-23-g06401c1b98b0
X-Kernelci-Report-Type: build
Subject: pm/testing build: 8 builds: 0 failed, 8 passed,
 4 warnings (v6.3-rc1-23-g06401c1b98b0)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 8 builds: 0 failed, 8 passed, 4 warnings (v6.3-rc1-23-g06=
401c1b98b0)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v6.=
3-rc1-23-g06401c1b98b0/

Tree: pm
Branch: testing
Git Describe: v6.3-rc1-23-g06401c1b98b0
Git Commit: 06401c1b98b0d0ba33789b770c3c0083deaa652f
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
Built: 8 unique architectures

Warnings Detected:

arc:

arm64:

arm:

i386:

mips:

riscv:

sparc:
    sparc64_defconfig (gcc-10): 4 warnings

x86_64:


Warnings summary:

    2    WARNING: modpost: EXPORT symbol "_mcount" [vmlinux] version genera=
tion failed, symbol will not be versioned.
    2    <stdin>:1517:2: warning: #warning syscall clone3 not implemented [=
-Wcpp]

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D

Detailed per-defconfig build reports:

---------------------------------------------------------------------------=
-----
32r2el_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sec=
tion mismatches

---------------------------------------------------------------------------=
-----
defconfig (arm64, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section m=
ismatches

---------------------------------------------------------------------------=
-----
defconfig (riscv, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section m=
ismatches

---------------------------------------------------------------------------=
-----
haps_hs_smp_defconfig (arc, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0=
 section mismatches

---------------------------------------------------------------------------=
-----
i386_defconfig (i386, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 secti=
on mismatches

---------------------------------------------------------------------------=
-----
multi_v7_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 se=
ction mismatches

---------------------------------------------------------------------------=
-----
sparc64_defconfig (sparc, gcc-10) =E2=80=94 PASS, 0 errors, 4 warnings, 0 s=
ection mismatches

Warnings:
    <stdin>:1517:2: warning: #warning syscall clone3 not implemented [-Wcpp]
    WARNING: modpost: EXPORT symbol "_mcount" [vmlinux] version generation =
failed, symbol will not be versioned.
    <stdin>:1517:2: warning: #warning syscall clone3 not implemented [-Wcpp]
    WARNING: modpost: EXPORT symbol "_mcount" [vmlinux] version generation =
failed, symbol will not be versioned.

---------------------------------------------------------------------------=
-----
x86_64_defconfig (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 s=
ection mismatches

---
For more info write to <info@kernelci.org>
