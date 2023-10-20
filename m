Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C49FB7D1470
	for <lists+linux-pm@lfdr.de>; Fri, 20 Oct 2023 18:57:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbjJTQ5x (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 20 Oct 2023 12:57:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbjJTQ5w (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 20 Oct 2023 12:57:52 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 208D4CA
        for <linux-pm@vger.kernel.org>; Fri, 20 Oct 2023 09:57:50 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id e9e14a558f8ab-3573dc94399so3956495ab.0
        for <linux-pm@vger.kernel.org>; Fri, 20 Oct 2023 09:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1697821069; x=1698425869; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vVSgnemG0fkvACIhRpNEKpzulQeyAsHvSU99xpy+hlg=;
        b=RcCCiBGHf+JnQ9d173ecPRSQ+KyBe8ufkVcBGqBfr0Sb6RlhonqjCrVNeiXqsnud4S
         ycJOVa+jLQXbPPGuz7m6OkL2XgohaGjXhzA3tecVIr2i//P73tcMfnLMYljvGWcdgOu5
         KYC8moa9dE8rFgq1aJljzMgXJMbxUWJtj4wKQIAER+sKlTKRgI1xBexKXFgOwt3xvckS
         7S6BAuJh1uGlObUbEe48SK5APEZC4M2Sou9jI5Au393fk+Nq7vH5whg1KHajraIiT66/
         CV1hZgnCR/GVmQt1uZmSpzgTqG0Rhdul6CsJ03qndSGvZbtRPwQAV0Qd9YOxfVvo7EgL
         dCVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697821069; x=1698425869;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vVSgnemG0fkvACIhRpNEKpzulQeyAsHvSU99xpy+hlg=;
        b=hKMPIoFG54p2UIkwGPa+aLN8YEEsoSg+S+G92BpEGZRIQvvdithAMSFzzO9ZiWCq+f
         j51UNDpisq0g2KHK/XkJTBW2SCfXLliv6ms5pZh6fgOrZsTBuAkzsfDwu8tmrW8j9pW9
         gW0fhg7xpD3ZuwUOzZvf/l7TyFDHKdgJTcpZSyGb8oT/hm4t9OSH2Ds/BrCPXrY3xUYN
         vPulymM2xPtAP5dJ9Cm442ui+goLayjGePXZpwtbDopQdIcQkgIPLRK/v9H3aydMYNxc
         33z9KBbacCj0fd3/L7H00nPTT8FOPl7i3o4xIXrryfRiLT/CrEJf4SXCNMD2K2jXKyu/
         oPVw==
X-Gm-Message-State: AOJu0YwtkrWuWZrRBPfeV3C/cnh/xYJCGbekRaGXhrYOhvLfc3nE95Iq
        F86PqMTTuGnlLZ3y9T8c0Xb9sg==
X-Google-Smtp-Source: AGHT+IEoRS+okYcKYJFWkFZTsg8YvT1cjQjYEJMEunCcCi4BtyUhdR9BaUUCHqdqDdn2+XQfQnAyoQ==
X-Received: by 2002:a92:ce52:0:b0:357:5d18:a47b with SMTP id a18-20020a92ce52000000b003575d18a47bmr2947437ilr.17.1697821069518;
        Fri, 20 Oct 2023 09:57:49 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id y1-20020a63ce01000000b005aa800c149bsm1716855pgf.39.2023.10.20.09.57.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 09:57:48 -0700 (PDT)
Message-ID: <6532b18c.630a0220.bdb39.65c4@mx.google.com>
Date:   Fri, 20 Oct 2023 09:57:48 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.6-rc6-162-g10a07821099f
X-Kernelci-Report-Type: build
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
Subject: pm/testing build: 8 builds: 0 failed, 8 passed,
 4 warnings (v6.6-rc6-162-g10a07821099f)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 8 builds: 0 failed, 8 passed, 4 warnings (v6.6-rc6-162-g1=
0a07821099f)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v6.=
6-rc6-162-g10a07821099f/

Tree: pm
Branch: testing
Git Describe: v6.6-rc6-162-g10a07821099f
Git Commit: 10a07821099f90ca90922f7dd011a4b630e2c702
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
