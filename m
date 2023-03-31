Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D8816D2834
	for <lists+linux-pm@lfdr.de>; Fri, 31 Mar 2023 20:53:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233134AbjCaSxl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 31 Mar 2023 14:53:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230452AbjCaSxk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 31 Mar 2023 14:53:40 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 437A01025E
        for <linux-pm@vger.kernel.org>; Fri, 31 Mar 2023 11:53:39 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id gp15-20020a17090adf0f00b0023d1bbd9f9eso26445680pjb.0
        for <linux-pm@vger.kernel.org>; Fri, 31 Mar 2023 11:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112; t=1680288819;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2+pcFbUPBt+siOQQXgwAStwWkTgQYeOcONsj2hCXVJM=;
        b=GHQtq4zeaw/ASYjr0JFr8199DjyO8uaN0Ks0qEbGW+xG2VfUBpXsVblnW9i9JEFmbO
         zcUqld0UyD0HV8lzt1+u42PBzkaPQGArfO2vLSLMJsREYBSERsKzMHoFbgcI+cftJn9+
         Cd9VK7Z2D1AU6l6pcsNKJMlbA5fk4psKpwspbh+zk8alczVL7mFNLcm1Fyzwc/2ABjaW
         I+iPuLLEFPac0hNcU34owAl3y3ojcIP524Rjwztcn1T34LFzpMPfrDYBA3zXiIgr1Dpe
         52pvFilvf91/YELmuHZRmplAuf4Y2jtASXZXKIR/M1mbUPk4APtRTIpkm+CmrYFiGOtm
         YSkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680288819;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2+pcFbUPBt+siOQQXgwAStwWkTgQYeOcONsj2hCXVJM=;
        b=fSOTFNj6uXzAoQ6zlguaK6d2yk4Ke4BLl5eIwuZce9P0R0PwkBhf/m/RffKJFWYQ8e
         9HxvrMDCykVEJjNHGyRISoo9Di0G6G3PBPNF6MgNqAFHaabXc7VRwO6MiIOHu9YFCEoC
         d9vk8l/bLUdIYy3aQrVF/koJdQDGRdl8ndjLiFwzqDXFh6f1QpKTWnagQ+1YRCogQopI
         eS08HJCy8HAGrZBuKCx/rO8293fIW3A8zwcqtz3KJGDwwwAbL7CR209CBk0VsJJi7ONt
         Ynv+7cTPrbodz9L0U4k7jINRks7t7NymIZr8Ggj+zbXp+LGwA+lZKCIDLdyAenpq0IC/
         1ifQ==
X-Gm-Message-State: AAQBX9enmB+nNWJgWEJavDObbLqvYsqtrHMqgCyv6Wh7IZppzJZqu0nO
        raLnidR6rkN6oBlmEuz/sVKGLw==
X-Google-Smtp-Source: AKy350ayAw/6aoeExv/FWmqD2BweJaihQAxIkb5BDFXwOSJVDfvO3WN6R9BD1OOEoXY0TXlXtn2Pzw==
X-Received: by 2002:a17:903:18b:b0:19e:8267:9590 with SMTP id z11-20020a170903018b00b0019e82679590mr33577177plg.41.1680288818703;
        Fri, 31 Mar 2023 11:53:38 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id jd12-20020a170903260c00b0019e8915b1b5sm1911226plb.105.2023.03.31.11.53.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Mar 2023 11:53:38 -0700 (PDT)
Message-ID: <64272c32.170a0220.bd821.5189@mx.google.com>
Date:   Fri, 31 Mar 2023 11:53:38 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: thermal-6.3-rc5-71-g56fb1399ba81
Subject: pm/testing build: 8 builds: 4 failed, 4 passed, 4 errors,
 8 warnings (thermal-6.3-rc5-71-g56fb1399ba81)
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

pm/testing build: 8 builds: 4 failed, 4 passed, 4 errors, 8 warnings (therm=
al-6.3-rc5-71-g56fb1399ba81)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/the=
rmal-6.3-rc5-71-g56fb1399ba81/

Tree: pm
Branch: testing
Git Describe: thermal-6.3-rc5-71-g56fb1399ba81
Git Commit: 56fb1399ba81f8f6db1e9d667538fc0210660e55
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
