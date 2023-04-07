Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47E5F6DAC8B
	for <lists+linux-pm@lfdr.de>; Fri,  7 Apr 2023 14:13:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240574AbjDGMNH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 7 Apr 2023 08:13:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbjDGMNG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 7 Apr 2023 08:13:06 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CA785253
        for <linux-pm@vger.kernel.org>; Fri,  7 Apr 2023 05:13:05 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-507e0098f0fso136764a12.1
        for <linux-pm@vger.kernel.org>; Fri, 07 Apr 2023 05:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112; t=1680869585; x=1683461585;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=E5v3HP5V4ztNFhWWB2WsyDqPSk5lcB+GmbRfKPkbj1A=;
        b=0V3GnGs9Y+L+tTfnJV0Kkchg/cWtspU3Gvt1L2S7OMToRKEVsHIF/mC3mEQexkvLIT
         yo8SGgsF+tKlWdy2FdulkSZDVOAxq8UefCBgduqU429aaRpmZ2Pq6KBKIRi0xOFTshyh
         Xrn6ugacnmjhVUnRD25DDb4dnt/+KZJAM5myWc3fvkw1dXY6zkNEo2+5A0QNbGXDcM+T
         HmBWSUoUCk4LuDsTDtuEHnBQpaXX5Y1HAsD3+RrXwtPXtVnbXJ5T+RkcEk28kCokcL/4
         p9P3ixQE8/hsYyy4RGIK3eDhBuG5+5TTHV1Pr/RMr0Pyq2VxWHFb35OBPxQgD9KJE3nM
         LubA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680869585; x=1683461585;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E5v3HP5V4ztNFhWWB2WsyDqPSk5lcB+GmbRfKPkbj1A=;
        b=xn59Ho3T/vuuzygn2z0GLWN/ZdwFiigk3AGK7Xu/wd1s2xkiaqVmw+LzBgrupVr3S3
         hTkis25DObWkh6LsfppyNNRyJwkvO2XS0qMWC7sY8u8zAEFYlCPNg117F8kHkY9Pi08Z
         DoTHsnnEYGOwqbUWGmyTd0tvGqoRtUA4buCMznoi4orFS+/VxWGe/526izW/H7adUKl9
         1hT+wz2Zp+TCiZn3SbvqERb+q85HjHDvsB9MpTWrfxxRWlDehriMkzACDJnH+cH6hMZQ
         yFuzdnBoHb1qf7tIGzl3CtQAgTWefKmQgp4qKhxY/+Amtht9E1zsLQzXypII3zjAhar6
         at9w==
X-Gm-Message-State: AAQBX9c+i+JH92XbdnFYb4e2Q1Bb93CWNehXRgv9nJdg1qRhb8SuPOgW
        IVtYiJ4jwVYZ6XFOhwcJzFa0wEsQMzKzCtVHEMUfr8T5
X-Google-Smtp-Source: AKy350bZGIjMPnnjAF79NN/parpdX86UoQyemwnw30rc8ypy5O1AmZ9B3sZXwy4NOHruFaFlLX2kqw==
X-Received: by 2002:aa7:9608:0:b0:627:ec37:1e69 with SMTP id q8-20020aa79608000000b00627ec371e69mr2228295pfg.8.1680869584831;
        Fri, 07 Apr 2023 05:13:04 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id g6-20020a631106000000b0050fa6546a45sm2579098pgl.6.2023.04.07.05.13.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 05:13:04 -0700 (PDT)
Message-ID: <643008d0.630a0220.1ce46.50ee@mx.google.com>
Date:   Fri, 07 Apr 2023 05:13:04 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: acpi-6.3-rc6-124-g5eb08f42cafd
Subject: pm/testing build: 8 builds: 0 failed, 8 passed,
 4 warnings (acpi-6.3-rc6-124-g5eb08f42cafd)
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

pm/testing build: 8 builds: 0 failed, 8 passed, 4 warnings (acpi-6.3-rc6-12=
4-g5eb08f42cafd)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/acp=
i-6.3-rc6-124-g5eb08f42cafd/

Tree: pm
Branch: testing
Git Describe: acpi-6.3-rc6-124-g5eb08f42cafd
Git Commit: 5eb08f42cafd07b31a459e90c745945372d4f6e8
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
