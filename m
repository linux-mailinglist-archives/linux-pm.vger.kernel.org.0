Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C44506D8943
	for <lists+linux-pm@lfdr.de>; Wed,  5 Apr 2023 23:07:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232683AbjDEVHx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 5 Apr 2023 17:07:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234012AbjDEVHu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 5 Apr 2023 17:07:50 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EE7561BA
        for <linux-pm@vger.kernel.org>; Wed,  5 Apr 2023 14:07:49 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id fy10-20020a17090b020a00b0023b4bcf0727so38617127pjb.0
        for <linux-pm@vger.kernel.org>; Wed, 05 Apr 2023 14:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112; t=1680728868;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=VBJpwOFp3ku4jVcQ5brTCTHQwJGZA4DUI5choGz4DIg=;
        b=nb9B0hN0UZS0WZOCMBPRrA0OEN0o6HmMMiDGvszitY5YIt18CVLxjZAwg5SywkLWiB
         COM0P768etQUBisLuP/Nith+msT1+OML2ljlP2+0jEP/CusPi5j+RLnta0kPKL3EVR1W
         4u1nRbwRPpbnjb7SNI24S8vt+KUXR5NUvIN1eilbKTjQLGyoLrovQB9PTdnA5IyIOqe8
         Ek51lpRtErgPKBYWWKefFwVLZgmVKgC2iZF7nhFDZGF3S1+4B5PJQCXPTGTNFu93wGTf
         9LXkRHbJpJ6TLtC/V7AGuZPS8/l501l5I0+w3599vXQ2IfyNOvyx1YlSXJ7I4zPCNau+
         1h7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680728868;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VBJpwOFp3ku4jVcQ5brTCTHQwJGZA4DUI5choGz4DIg=;
        b=UxNskHTJhMGbfRQNxl6EUszz28zimt1jRNOKdCx/aMedrtDvb4/RpwsP4xDIH1828t
         KUjU8H2c+UvUw5FtmDPJcJJKx60OwN+Uy/BuMFpo7BEjMIdgpGjW/T1MTTcgk889ME0z
         g814TuyIdGjIjIu360U0QSk5NJnsoToqabTSRDBbpRMTZ+aXEwfvdfjAuU5DvrVb6iPc
         rGwN7R4HBiA8HhmLl0Gqvz1/ou/YJAI5uOrBD4QV/+5gVA5vITIrKVENCYov3hMVdASk
         rEmX/UFgsqA/c93wcLnw8Hgw+ryH7uaLAvU0Su/KcknKnI4A5XY2OB2yoNvS71aa9iNI
         t4iA==
X-Gm-Message-State: AAQBX9ecTQGIPsmZArqnbzidePqQ/kXNcB5DwjSFpAZl/TOot7OSB3qh
        2jV8VsCtYljLSTO799y5eEFoDQ==
X-Google-Smtp-Source: AKy350YzMzop3LSlu/KNAt0I9relkhGlW7R/++PwkdQDrA3LHhcvd4DE5q5gA3Df1csENSpmSdE/tg==
X-Received: by 2002:a17:902:f2cd:b0:1a1:f051:4f59 with SMTP id h13-20020a170902f2cd00b001a1f0514f59mr6170818plc.15.1680728868655;
        Wed, 05 Apr 2023 14:07:48 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id k2-20020a170902694200b001a21a593008sm10506601plt.306.2023.04.05.14.07.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 14:07:48 -0700 (PDT)
Message-ID: <642de324.170a0220.8ddc2.63d1@mx.google.com>
Date:   Wed, 05 Apr 2023 14:07:48 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v6.3-rc5-82-g1a2117acfb4f
Subject: pm/testing build: 8 builds: 0 failed, 8 passed,
 4 warnings (v6.3-rc5-82-g1a2117acfb4f)
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

pm/testing build: 8 builds: 0 failed, 8 passed, 4 warnings (v6.3-rc5-82-g1a=
2117acfb4f)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v6.=
3-rc5-82-g1a2117acfb4f/

Tree: pm
Branch: testing
Git Describe: v6.3-rc5-82-g1a2117acfb4f
Git Commit: 1a2117acfb4fb4dfa4c5c8f0185bc88c553a4f08
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
