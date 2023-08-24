Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9162E787866
	for <lists+linux-pm@lfdr.de>; Thu, 24 Aug 2023 21:15:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243125AbjHXTPV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 24 Aug 2023 15:15:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243028AbjHXTOw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 24 Aug 2023 15:14:52 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 722CF1BCE
        for <linux-pm@vger.kernel.org>; Thu, 24 Aug 2023 12:14:50 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-68a1af910e0so174302b3a.2
        for <linux-pm@vger.kernel.org>; Thu, 24 Aug 2023 12:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1692904490; x=1693509290;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=T0T3L4UBWS4Ei3VNP47Pn+F05gPvGbch/e781qwl2qg=;
        b=o+OyN+AG/6GQf6yt6sQVU1OA4hWaIB9fnN0LOv1bzID3m1BhqdwuPnUHbakdmkCZ91
         q/bmAcpDWyGTmr5/sN5nXyJbm7sn9mzfyNthisnBbwQKN6+oZivSK/qE04ljSHiUJFFq
         vHD1WOY8QbeNDsaU8PUENEgGd8VRoFZhMk6GRJbctEzk/HPeQD/eo+7VDcBXYNvTAhvR
         07W3dSM8N4Qiu5ZSNyQ5TFID+hOGWT6Wah3Y7B02ZoSK9xLKm9zUZ/mBw0MpsC8ih8e2
         p7t0jl6d+ul+3Wfq/JeSAUVRhhNHlVJjX0d9SsoI0q4Hj6OlEtMHmcWwRnOPElarSTmH
         lLAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692904490; x=1693509290;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T0T3L4UBWS4Ei3VNP47Pn+F05gPvGbch/e781qwl2qg=;
        b=d9a3TQFldXPpL+EM8IQBJzea0etuOlt3ORRsq2mSEooHd68m56cbSyLg/7N1DR4a+F
         Dkqfh7Smi1h8J2o6eRN/wIHpoidseoJvTSFaUffcKr5WqjBnBLmIBntjz3lpsgWbPx4w
         rRXuZqVdbRTt5+Y9KmpCnxxPcLnRcAb7oWXSZc87aVOwmk2p+DJZeLTxgF1gSzKzKYyd
         6bxquLY4/STwbSsjU6Aq/dFiifzi22zvk+lot7+/taWUClUvqoUxlY0AU1O4aYIFr8O+
         qJ3SZEZM6OVGKRNC95ESq5Sv/EdPvmiccDKX65XsFIAbprsILZivyklavepRyLWB3M5a
         Vh6w==
X-Gm-Message-State: AOJu0YxOOCsaXbc0LyGXir4CG0Tbprv36wiPq7WJUlcTRI91KLxGkIYt
        xLOqwLtuLOdTnoZwZvnQW3Hziw==
X-Google-Smtp-Source: AGHT+IGC+y8I1QIT//1uGsZkot+f9n08XzFdwXIzEYs+3PMyqtMsdeuinVgZykNqAdfF7IeKOLWfXA==
X-Received: by 2002:a05:6a20:8f16:b0:14c:4dfc:9766 with SMTP id b22-20020a056a208f1600b0014c4dfc9766mr951357pzk.46.1692904489897;
        Thu, 24 Aug 2023 12:14:49 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id m30-20020a63711e000000b0056365ee8603sm11811362pgc.67.2023.08.24.12.14.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 12:14:49 -0700 (PDT)
Message-ID: <64e7ac29.630a0220.811c4.7793@mx.google.com>
Date:   Thu, 24 Aug 2023 12:14:49 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: acpi-6.5-rc8-154-ge1903ccb69a7c
Subject: pm/testing build: 8 builds: 0 failed, 8 passed,
 4 warnings (acpi-6.5-rc8-154-ge1903ccb69a7c)
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

pm/testing build: 8 builds: 0 failed, 8 passed, 4 warnings (acpi-6.5-rc8-15=
4-ge1903ccb69a7c)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/acp=
i-6.5-rc8-154-ge1903ccb69a7c/

Tree: pm
Branch: testing
Git Describe: acpi-6.5-rc8-154-ge1903ccb69a7c
Git Commit: e1903ccb69a7c4c52d4cb4c8ffeefe18ae36bc0f
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
