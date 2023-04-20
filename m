Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B8116E9C7C
	for <lists+linux-pm@lfdr.de>; Thu, 20 Apr 2023 21:32:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231728AbjDTTcA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 20 Apr 2023 15:32:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231206AbjDTTb7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 20 Apr 2023 15:31:59 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5655940CD
        for <linux-pm@vger.kernel.org>; Thu, 20 Apr 2023 12:31:58 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-51b5490c6f0so1277115a12.0
        for <linux-pm@vger.kernel.org>; Thu, 20 Apr 2023 12:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1682019118; x=1684611118;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=WER/nU89Ds0CeipEjZ+yNlToHS1oQRuSI1pBkQGV5j4=;
        b=ZhX7Mz688PSsrMVjW8yuHIg4V8nALp3ZuJqsMkDbGH9dz6k8FmznmhMenFoOFTNXo7
         HB6l5VPjiSoMqRzaiCK/8UB8tQ9PgusGf7PeLmki4hQOlS+8JsH+81xHXjeOI7yU4xey
         B0CulREdZT/7M6/uMWf6ZVETZPL/n0jVLSwP8PheTeH9CXyvcXPAo5GLQT8+3RieF8RV
         q+ewAEcFriflgUxnCcZjgweEBjfOoYGdMLknWWkAe0RSL9tAEv5UZUDXmSMn+Q4ogxAT
         vhXD3za9YdHoc6KVieWJNhWZojWTf7SSOp1PxZgL5sgLXuKpgX6V2u1k7ChBx64snpyT
         k7Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682019118; x=1684611118;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WER/nU89Ds0CeipEjZ+yNlToHS1oQRuSI1pBkQGV5j4=;
        b=elKxUYYWhEnp4UMQfMEQwqZ0R2VVcG/+k3c+zSW1o01Hs+pPwMEmP+dM83RBoSa7WH
         hOa6+trk74xRmmDJTDNeXqVd2v1581cF9iby1TycKlRnFkZDTTghnnfpjzGyqRdX+YZU
         /6WEQerySVQ3vfSYazVD/N3Az/TCrnx7tmhjn8UTSVzRFA8J6RmfVVLS/pyymPvvENDa
         M+3ofnlqHX6yBbED2gZAQ1yVsE9E6Ykg/GQ7MrkjDpY4szb6McUP9UIMgoa6A5RwmvVi
         H3AbR5bw/upAm2ZfEUpZek/NVd2wp5efjWFKDdiAejJQkzZhpJ48Y1f66plHO6vSXncv
         rKuw==
X-Gm-Message-State: AAQBX9eePJg/jTSBa1Y4DWIrMioL12pZuqvRlOCrXCfJ7HBXtoWDtwwe
        mSXYFJ0nEce/m+HhkoO0bWaWkw==
X-Google-Smtp-Source: AKy350ZBYgYEqTJD4RJdvL0ntrcmUwIKX0EgpIpSjOShbnmDKYl4LoqRqPkUw0pFQlq1q1PBw1hxbg==
X-Received: by 2002:a17:90b:1e0c:b0:246:f9f1:ad17 with SMTP id pg12-20020a17090b1e0c00b00246f9f1ad17mr2599603pjb.40.1682019117841;
        Thu, 20 Apr 2023 12:31:57 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id g2-20020a17090adb0200b00246f9725ffcsm1503206pjv.33.2023.04.20.12.31.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 12:31:57 -0700 (PDT)
Message-ID: <6441932d.170a0220.9b2ab.3c00@mx.google.com>
Date:   Thu, 20 Apr 2023 12:31:57 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v6.3-rc7-189-g704d7a52a540b
X-Kernelci-Report-Type: build
Subject: pm/testing build: 8 builds: 0 failed, 8 passed,
 4 warnings (v6.3-rc7-189-g704d7a52a540b)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 8 builds: 0 failed, 8 passed, 4 warnings (v6.3-rc7-189-g7=
04d7a52a540b)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v6.=
3-rc7-189-g704d7a52a540b/

Tree: pm
Branch: testing
Git Describe: v6.3-rc7-189-g704d7a52a540b
Git Commit: 704d7a52a540b6ab2f6cc6a0c10d3b9fe851a459
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
    2    <stdin>:1519:2: warning: #warning syscall clone3 not implemented [=
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
