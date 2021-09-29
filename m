Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C438F41CE97
	for <lists+linux-pm@lfdr.de>; Wed, 29 Sep 2021 23:58:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346088AbhI2WAD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 Sep 2021 18:00:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344070AbhI2WAB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 29 Sep 2021 18:00:01 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B672C06161C
        for <linux-pm@vger.kernel.org>; Wed, 29 Sep 2021 14:58:19 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id g13-20020a17090a3c8d00b00196286963b9so5202362pjc.3
        for <linux-pm@vger.kernel.org>; Wed, 29 Sep 2021 14:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=eCxfCyuEV1aPR4bimM9RwTlOgpx7ZEu7MhgoDhJxcoc=;
        b=1NSxl/UCbAfAo2tChLwAZTaS5BOVBK2ntLCbMesl6gNpS9uiegc6PHpPAkTNJwRah1
         ZEULsKvU5DNwju/qAdtjuMGCyq0NKwIdr39zFdteKG4jxbhhlZ0krfHF1Nw6tX6UpQRI
         ePFjzvOGVPeJ8mXsnQVaDELOcHUKSBSvzjIbs4NDEtpwCH0g74piSwQwqq27aByQhg9D
         Z5t3CaJSbt9ZOVfOJgBXhdlvboFEPDsCyUOYW0oljTneFMfAgnblOJahztiDpX/lmA9e
         CGUFQjWwnpURKvQL6DkfrVJqGZjZ+ZDTUJ3J1vhILrX9l/GGFViYUrHEM3NO25UQsj/J
         iL/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=eCxfCyuEV1aPR4bimM9RwTlOgpx7ZEu7MhgoDhJxcoc=;
        b=bigkVoU8nyl8XoQU0vZMX6V0rS4YOJszBRuzqrb0TyOEFsg1cNuecUJRGfO1I+DhT4
         /fz8y+4GtAFRTNShTzJq0sRP2oDDfGXwjf2czEEB1qPdzS8ROSP7GCZL5v3o6E9w86/a
         wg95UDAqPgt6X0WnYlvWSxpSCtdYZkknCfcAE2Fo5fSRojfLOH/lZusxkCRCBxfZT2mj
         YOWna72TTtE/BZEl4/IGPWPmP7ljEYHtuKBdOxekbkzM5pUfyBgVjvAQKrM8sp+a9JeL
         MJQTfAdoi2fZ2cc3Zva7Vesphjtw6iE8mtQwTBpKq+VV8Sdti4+3BwXlgIHUH78Cp9ZL
         IoZA==
X-Gm-Message-State: AOAM531mfvXdxcYv+wQocQhh0U6sZFkFoc0xDKvHoZ/8N1jJyjUO1WQ4
        85ku/Iz5f4fqZmdAAPdAGmKkyQ==
X-Google-Smtp-Source: ABdhPJzh54XVkjlW7ZVV6eLf//dFu/jh4ROyl+ZCqea0zgXFz6ka+8xBaCUCFxDm7F9xyqmPtWjGqw==
X-Received: by 2002:a17:90a:1944:: with SMTP id 4mr8760318pjh.221.1632952698927;
        Wed, 29 Sep 2021 14:58:18 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id e8sm150445pfn.45.2021.09.29.14.58.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Sep 2021 14:58:18 -0700 (PDT)
Message-ID: <6154e17a.1c69fb81.53c25.0b19@mx.google.com>
Date:   Wed, 29 Sep 2021 14:58:18 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.15-rc3-23-gd91db9b878c3
X-Kernelci-Report-Type: build
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
Subject: pm/testing build: 7 builds: 0 failed, 7 passed,
 1 warning (v5.15-rc3-23-gd91db9b878c3)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 7 builds: 0 failed, 7 passed, 1 warning (v5.15-rc3-23-gd9=
1db9b878c3)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
15-rc3-23-gd91db9b878c3/

Tree: pm
Branch: testing
Git Describe: v5.15-rc3-23-gd91db9b878c3
Git Commit: d91db9b878c32d8a746d69b30925174081c951d4
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
Built: 7 unique architectures

Warnings Detected:

arc:

arm64:

arm:

i386:

mips:
    32r2el_defconfig (gcc-8): 1 warning

riscv:

x86_64:


Warnings summary:

    2    arch/mips/boot/dts/img/boston.dts:128.19-178.5: Warning (pci_devic=
e_reg): /pci@14000000/pci2_root@0,0,0: PCI unit address format error, expec=
ted "0,0"

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D

Detailed per-defconfig build reports:

---------------------------------------------------------------------------=
-----
32r2el_defconfig (mips, gcc-8) =E2=80=94 PASS, 0 errors, 1 warning, 0 secti=
on mismatches

Warnings:
    arch/mips/boot/dts/img/boston.dts:128.19-178.5: Warning (pci_device_reg=
): /pci@14000000/pci2_root@0,0,0: PCI unit address format error, expected "=
0,0"

---------------------------------------------------------------------------=
-----
defconfig (riscv, gcc-8) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section mi=
smatches

---------------------------------------------------------------------------=
-----
defconfig (arm64, gcc-8) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section mi=
smatches

---------------------------------------------------------------------------=
-----
haps_hs_smp_defconfig (arc, gcc-8) =E2=80=94 PASS, 0 errors, 0 warnings, 0 =
section mismatches

---------------------------------------------------------------------------=
-----
i386_defconfig (i386, gcc-8) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sectio=
n mismatches

---------------------------------------------------------------------------=
-----
multi_v7_defconfig (arm, gcc-8) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sec=
tion mismatches

---------------------------------------------------------------------------=
-----
x86_64_defconfig (x86_64, gcc-8) =E2=80=94 PASS, 0 errors, 0 warnings, 0 se=
ction mismatches

---
For more info write to <info@kernelci.org>
