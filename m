Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B75286C53BC
	for <lists+linux-pm@lfdr.de>; Wed, 22 Mar 2023 19:28:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbjCVS2K (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 22 Mar 2023 14:28:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbjCVS2J (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 22 Mar 2023 14:28:09 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24E981E29D
        for <linux-pm@vger.kernel.org>; Wed, 22 Mar 2023 11:28:09 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id kc4so5476986plb.10
        for <linux-pm@vger.kernel.org>; Wed, 22 Mar 2023 11:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112; t=1679509688;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=kqYSmzkMoGqvRhXQ4vXJXLNGnt7v+yFaT7OK491JzY4=;
        b=ZeOfQTiEHiwC8zCpUPcfr531j4bv74kLs5y7XYItoeuOO3QArrzBQuwhnNLCDIIk1F
         /y1OKblc4mWfjgyUo0djbxmVHFG2/1NVm/vHy6PqhSZjggPuoh2XYsU3Maw4ZWGOJydU
         VtxLu5zAUKMwIMG618Cu81vMIgbknfBIAZVkGKJmsd4NJ5ChfDCxE14cOLmuJ51grqMQ
         zaOeEhUP7xMty/C0ysLDYs66Pg2TMRHQU5/oQXi7RBUU98oXJeCVRMuTF4xlq9vVsI+u
         VrN4/yRdUQsmH3UAQJz3T0uA2d5zpk9iqE4ZCzAUsK/xHR3SsWA9WO7F6W57w4BshfYr
         yL/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679509688;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kqYSmzkMoGqvRhXQ4vXJXLNGnt7v+yFaT7OK491JzY4=;
        b=ezFsG3Olpv9kFTBf3GmuNtzWMAPKvnMGmdH8s2hGAsoprpUSSg6aZwlXYfmwT8ouu4
         cdBiGaqVmxY3+flCGZHvFcIldFs6b/taH9RTbW+8pRE692yT4F6uaMmByUYwf1MXM8KM
         X+aN0I2yj6KJEMuhhH2yiCxLH5oUqcCkIT1NZCkbPwx2JpAjw/w1UTg43utxmfkuFcH7
         Z0Hmw8ioihFzDU2OmDMl+DU3Z1AjL+kZA1CAYATtV/faX8+KbSxB8y8+4ajNcAXXCwi1
         G1kxQLgFKvgphgJVTLH1runQyXBG4ajdK5scB1wBN8P/jhakftC66PQ0MgdBeiamlyb5
         Kwug==
X-Gm-Message-State: AO0yUKX7h4lSy/3sb811Sn2abG9EvDYR7L8CjfvEG/axhvA3dE83RALI
        26/rIB2SVcOJqWJtXuLsO9YDFQ==
X-Google-Smtp-Source: AK7set+BRuxgrxm08FG4wV8OhhJITcxZScbj5Kwt1aQhS1YTf+cYlq73DrfjXJKYZXszrJ7zQPuqoQ==
X-Received: by 2002:a17:90b:1b0c:b0:23f:3ee2:8ec6 with SMTP id nu12-20020a17090b1b0c00b0023f3ee28ec6mr4751263pjb.11.1679509688610;
        Wed, 22 Mar 2023 11:28:08 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id a19-20020a17090aa51300b00233db0db3dfsm13739512pjq.7.2023.03.22.11.28.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 11:28:08 -0700 (PDT)
Message-ID: <641b48b8.170a0220.b16b8.8c9b@mx.google.com>
Date:   Wed, 22 Mar 2023 11:28:08 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v6.3-rc3-45-gfc5f43f31bdc3
Subject: pm/testing build: 8 builds: 0 failed, 8 passed,
 4 warnings (v6.3-rc3-45-gfc5f43f31bdc3)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 8 builds: 0 failed, 8 passed, 4 warnings (v6.3-rc3-45-gfc=
5f43f31bdc3)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v6.=
3-rc3-45-gfc5f43f31bdc3/

Tree: pm
Branch: testing
Git Describe: v6.3-rc3-45-gfc5f43f31bdc3
Git Commit: fc5f43f31bdc387e18804a52d4a0d28b6282f781
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
defconfig (riscv, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section m=
ismatches

---------------------------------------------------------------------------=
-----
defconfig (arm64, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section m=
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
