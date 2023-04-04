Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F1B86D5FF2
	for <lists+linux-pm@lfdr.de>; Tue,  4 Apr 2023 14:14:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234606AbjDDMOT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 4 Apr 2023 08:14:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234674AbjDDMMS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 4 Apr 2023 08:12:18 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 534874232
        for <linux-pm@vger.kernel.org>; Tue,  4 Apr 2023 05:09:22 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id n14so15194825plc.8
        for <linux-pm@vger.kernel.org>; Tue, 04 Apr 2023 05:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112; t=1680610161;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=e8QUQyAcDoAzqAG2M+9YDCtLxllxcfWWjVirh/gTT8k=;
        b=s4ijN0jtAQv3RVhRC6qcBHqqtagICLAiQv38kQvzkx9LeVi8vS/MDDfSoXArx8BMs+
         N+ztrbnF+rMSs0yE5yOVeM9gIAZyflXoNsgYUOy6jHqrbfpZrdTHEchvm7EXlcfFudKX
         5KIpgpyFpRZaXxs73lrV5BdaoPQ7jBwUTYu5vKsrRc51HmeY1sZeIuoiDIEotVaoYhzO
         xHkIOS3xsFrrMLUfehyRe7sfgGEsBV6SM8Dl+xcRLh+mlPmTsiI6Tvi4ZQe3IQrMMfX8
         /DyWEJ/HVZV54ihcDPwI7NCodNsf1wzwvr82kZEZZ5lrhXXmezXROX50+kKOeRfirs4y
         F20A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680610161;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e8QUQyAcDoAzqAG2M+9YDCtLxllxcfWWjVirh/gTT8k=;
        b=CCwN++FtZOugZNJC0zpFpFkpPI7xqHm8kpSU3uv2lqUDI6gDsDgyfT5HJk+O4ENdh5
         9PiN+W+UT4DJ9X2x5eZmHj+SfLzoZSG9/7OVyxeA8CkVv/s7C4xXgBcNr+jpJuwRfRVp
         Zf6CFlnA1m3IHsXMQnScw6CH9C8SMIk5X2YN1drUS6xkvVghkI257uZhAZ8lcuuLOSHn
         MboPVpDiSsrlu9nCU6exdpOwSinDb1bi4gspKj1XS7M/5XqXC8ruuwA7pADqC4jyZ9BY
         KevaQNP3WW2vIAa5xCJguJtaZSefUFcn4Xc1Jm9aG8iaj3UHy5saElQlJpIi2vy7stqf
         eomQ==
X-Gm-Message-State: AAQBX9fiVISzMBuKfNO19qBQBtOgf2YGpduBUd2e4UkEdod5yFARso6F
        YPNktBKysAiGI0+VcDZ3D1A5iOpgRmkXpN7SQO6Cpg==
X-Google-Smtp-Source: AKy350ZSYvFZD9kuqcSYYutuMo1+GpqWawCxBCxMb3nY9Xm5DmUqQrjwVadcJj4Z/squyPHrr9ud+g==
X-Received: by 2002:a17:902:e5c7:b0:19e:29bd:8411 with SMTP id u7-20020a170902e5c700b0019e29bd8411mr2880343plf.30.1680610161630;
        Tue, 04 Apr 2023 05:09:21 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id ju19-20020a170903429300b0019ea9e5815bsm8298169plb.45.2023.04.04.05.09.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 05:09:21 -0700 (PDT)
Message-ID: <642c1371.170a0220.77f67.0700@mx.google.com>
Date:   Tue, 04 Apr 2023 05:09:21 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v6.3-rc5-67-g82c6d94c943f
Subject: pm/testing build: 8 builds: 4 failed, 4 passed, 4 errors,
 8 warnings (v6.3-rc5-67-g82c6d94c943f)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 8 builds: 4 failed, 4 passed, 4 errors, 8 warnings (v6.3-=
rc5-67-g82c6d94c943f)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v6.=
3-rc5-67-g82c6d94c943f/

Tree: pm
Branch: testing
Git Describe: v6.3-rc5-67-g82c6d94c943f
Git Commit: 82c6d94c943f9f8d5ba57ea52dffa0cb7912769d
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
Built: 8 unique architectures

Build Failures Detected:

arm64:
    defconfig: (gcc-10) FAIL

arm:
    multi_v7_defconfig: (gcc-10) FAIL

mips:
    32r2el_defconfig: (gcc-10) FAIL

riscv:
    defconfig: (gcc-10) FAIL

Errors and Warnings Detected:

arc:

arm64:
    defconfig (gcc-10): 1 error, 1 warning

arm:
    multi_v7_defconfig (gcc-10): 1 error, 1 warning

i386:

mips:
    32r2el_defconfig (gcc-10): 1 error, 1 warning

riscv:
    defconfig (gcc-10): 1 error, 1 warning

sparc:
    sparc64_defconfig (gcc-10): 4 warnings

x86_64:

Errors summary:

    4    drivers/virtio/virtio_mmio.c:492:6: error: implicit declaration of=
 function =E2=80=98of_property_read_bool=E2=80=99; did you mean =E2=80=98fw=
node_property_read_bool=E2=80=99? [-Werror=3Dimplicit-function-declaration]

Warnings summary:

    4    cc1: some warnings being treated as errors
    2    WARNING: modpost: EXPORT symbol "_mcount" [vmlinux] version genera=
tion failed, symbol will not be versioned.
    2    <stdin>:1519:2: warning: #warning syscall clone3 not implemented [=
-Wcpp]

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D

Detailed per-defconfig build reports:

---------------------------------------------------------------------------=
-----
32r2el_defconfig (mips, gcc-10) =E2=80=94 FAIL, 1 error, 1 warning, 0 secti=
on mismatches

Errors:
    drivers/virtio/virtio_mmio.c:492:6: error: implicit declaration of func=
tion =E2=80=98of_property_read_bool=E2=80=99; did you mean =E2=80=98fwnode_=
property_read_bool=E2=80=99? [-Werror=3Dimplicit-function-declaration]

Warnings:
    cc1: some warnings being treated as errors

---------------------------------------------------------------------------=
-----
defconfig (riscv, gcc-10) =E2=80=94 FAIL, 1 error, 1 warning, 0 section mis=
matches

Errors:
    drivers/virtio/virtio_mmio.c:492:6: error: implicit declaration of func=
tion =E2=80=98of_property_read_bool=E2=80=99; did you mean =E2=80=98fwnode_=
property_read_bool=E2=80=99? [-Werror=3Dimplicit-function-declaration]

Warnings:
    cc1: some warnings being treated as errors

---------------------------------------------------------------------------=
-----
defconfig (arm64, gcc-10) =E2=80=94 FAIL, 1 error, 1 warning, 0 section mis=
matches

Errors:
    drivers/virtio/virtio_mmio.c:492:6: error: implicit declaration of func=
tion =E2=80=98of_property_read_bool=E2=80=99; did you mean =E2=80=98fwnode_=
property_read_bool=E2=80=99? [-Werror=3Dimplicit-function-declaration]

Warnings:
    cc1: some warnings being treated as errors

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
multi_v7_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 1 warning, 0 sect=
ion mismatches

Errors:
    drivers/virtio/virtio_mmio.c:492:6: error: implicit declaration of func=
tion =E2=80=98of_property_read_bool=E2=80=99; did you mean =E2=80=98fwnode_=
property_read_bool=E2=80=99? [-Werror=3Dimplicit-function-declaration]

Warnings:
    cc1: some warnings being treated as errors

---------------------------------------------------------------------------=
-----
sparc64_defconfig (sparc, gcc-10) =E2=80=94 PASS, 0 errors, 4 warnings, 0 s=
ection mismatches

Warnings:
    <stdin>:1519:2: warning: #warning syscall clone3 not implemented [-Wcpp]
    WARNING: modpost: EXPORT symbol "_mcount" [vmlinux] version generation =
failed, symbol will not be versioned.
    <stdin>:1519:2: warning: #warning syscall clone3 not implemented [-Wcpp]
    WARNING: modpost: EXPORT symbol "_mcount" [vmlinux] version generation =
failed, symbol will not be versioned.

---------------------------------------------------------------------------=
-----
x86_64_defconfig (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 s=
ection mismatches

---
For more info write to <info@kernelci.org>
