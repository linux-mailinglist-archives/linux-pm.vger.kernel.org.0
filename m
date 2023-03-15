Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8FEE6BBF41
	for <lists+linux-pm@lfdr.de>; Wed, 15 Mar 2023 22:41:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231971AbjCOVl6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 Mar 2023 17:41:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231725AbjCOVl5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Mar 2023 17:41:57 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 077CA30E81
        for <linux-pm@vger.kernel.org>; Wed, 15 Mar 2023 14:41:57 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id p20so21527232plw.13
        for <linux-pm@vger.kernel.org>; Wed, 15 Mar 2023 14:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112; t=1678916516;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=qYIDlQcpLkh3pWcUqXZGZ7GZW9eWGJwASiBKlku9Dkk=;
        b=rJgmv/oW6xCWAMMcJdBUgiEWWHn6T8bF3OkUX029L99GvV4vwP8VbC6rR/6Phq7ov3
         QydFP+HzwE7otU6sBoi9OZO2s+f2EMe/ct7rWhx4CrYL99zdGTjii7uGt0YuY/SLzYwa
         DPIyJPFMe0UAw3eRVonaRErgys94lrY5aeGci2vz8KcwEClyYcv0Qy+OGj4g7dRlcqSW
         VQ7VXETvvCB/r5aILehtWWeErGgW2T/MWDoVUl9L92s9FCPPd868GcRsm0ZGk3Stj2MP
         m9gp90XSJlY2DJEXYxhKO2azpnGFhdPvu2rQj38fhihtp85ItcAFOPWRQ4954ZkwTeQ7
         2LeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678916516;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qYIDlQcpLkh3pWcUqXZGZ7GZW9eWGJwASiBKlku9Dkk=;
        b=TGiEdYR+vgun80DT0zdtD/DmBwwPgrrkJh8102sEM7KauhwdLWNVy5LZQGf07wLE8B
         4z7FhWWw9eICfeX4wcpOJW7KaEQCvLTl0WmDvLpQtDkgi29+SRAn23x4r8gBP7X/0Oxd
         Vbh73MlshcUPvpP0FMAeBpUL2EnQxsUzSltkfXMVkBASgc9XTHDtJanwqUnkdstIIc3G
         TuS6x3HQcJMZ6OEGmAKkperLIlYzm0q0Gv9Z0hLFlKazdNSsD+7a4X7V4r44p+TwRxlj
         kr3bh2AeFuytJXWGBiSzuFcG8aVS6WgERGlP0b326GhWziNYCGaHmuUipmJjG46G0UhL
         b5OA==
X-Gm-Message-State: AO0yUKUL5E2fEWnJUwBPiWcEakVXjBcu5GI0IwEOxvGs9/ZPO138b5FA
        lTjdiwIABjp4EbYnAntRV/rFHguu3JvfA0haXdX6brId
X-Google-Smtp-Source: AK7set8Pyuqxj4puH3qHtQqhXKobmoyXnRT/chc/h4ppcwbPFESeV3QLnkviPh6ruRW4Xdre8ui6Mg==
X-Received: by 2002:a17:902:e742:b0:1a0:6eb4:3871 with SMTP id p2-20020a170902e74200b001a06eb43871mr1025428plf.20.1678916516490;
        Wed, 15 Mar 2023 14:41:56 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id e23-20020a170902ed9700b0019aa6bf4450sm1831237plj.188.2023.03.15.14.41.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 14:41:56 -0700 (PDT)
Message-ID: <64123ba4.170a0220.75c3.40ac@mx.google.com>
Date:   Wed, 15 Mar 2023 14:41:56 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v6.3-rc2-33-g1240ce78c05e
X-Kernelci-Report-Type: build
Subject: pm/testing build: 8 builds: 0 failed, 8 passed,
 4 warnings (v6.3-rc2-33-g1240ce78c05e)
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

pm/testing build: 8 builds: 0 failed, 8 passed, 4 warnings (v6.3-rc2-33-g12=
40ce78c05e)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v6.=
3-rc2-33-g1240ce78c05e/

Tree: pm
Branch: testing
Git Describe: v6.3-rc2-33-g1240ce78c05e
Git Commit: 1240ce78c05e340f533341148739ee126219afcb
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
