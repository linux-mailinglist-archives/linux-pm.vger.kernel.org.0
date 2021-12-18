Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23789479A9D
	for <lists+linux-pm@lfdr.de>; Sat, 18 Dec 2021 12:49:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231137AbhLRLth (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 18 Dec 2021 06:49:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232991AbhLRLth (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 18 Dec 2021 06:49:37 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92D11C061574
        for <linux-pm@vger.kernel.org>; Sat, 18 Dec 2021 03:49:36 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id c6so4106024plg.3
        for <linux-pm@vger.kernel.org>; Sat, 18 Dec 2021 03:49:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=gv65Duvx2Y99dWDLMlW05+ysE1U8ybGp55XshbPddVA=;
        b=sYPQxeO7E98jozbxnWF+PgqQQOWTkPKP5enEfR+XX8vOET3jBGxpo3K4xPWz8pY6OZ
         +Yk6uUrHu3sNR/JH0m2cTJdKq8F3JdCAqTjumqbqlI0Ja92/0AhNcRNAcFmivPIgApYN
         uaChVmN92Hn81PdmBWa3IxqXG4o4MZQU8jb0lyUaAPAi7oR5OnCoj9kwAH7uxWtvHlhr
         /PV/IOwkwmNog5lFy2S2Iu5YoThY3ZbhuBucYylOxnYm7d2DpIqG0NkQI4hiwhD+Qdqp
         QYOHgzhAs8qv++JJsW+Cd1EZW14lZQLUiNiljS6aBCckxclYHc7La0gL87fFRQPW/lWC
         nWbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=gv65Duvx2Y99dWDLMlW05+ysE1U8ybGp55XshbPddVA=;
        b=E+nMY96u1we3bn6QIymXe0cZbAknOXgx3hpOQsTZ1uZYrYgaH9OS6M2g/O9KvZmMD9
         Z7B3W4vASIhFQm6UuW3zz/mqNIpYad53gFXxOt4ntl/W3U7dlRBPcOFj0QI2VoZplrfy
         E4zcAXp3S3R2FTloyQ3v44fpaeN9OP36xrs7M6+6oLmH5Dun41ziw0EotyYD/A/ySD+8
         9+v/ABv+co63OLQOrS0EZhaNI8PQCSbLx1SESYeXJP5tKxArFpj2PY0SByM5MaOs5wp3
         avuW3j4QBIZ7uG7IoZSBisDa8Sa7CCKvVZFdrCEqrZDxzFY7uk0u9NTZNEQgMy2D8caC
         /tIQ==
X-Gm-Message-State: AOAM531iWq96NR72HMU6B7czB53VZCCKKpK8hOVzr7J2M+ldXxSGY3NK
        Hsu6vMC9P3sTUHk8rbHyGFzONzQvr8664RT3
X-Google-Smtp-Source: ABdhPJypuoeJY7qrJCdZYkX3XTEET+JcjxjiLOT6zeQe20c2FDBCb/JndW/Xw5cLcy/1shmmC3bRdA==
X-Received: by 2002:a17:902:d489:b0:148:f311:7c1a with SMTP id c9-20020a170902d48900b00148f3117c1amr1560783plg.128.1639828176026;
        Sat, 18 Dec 2021 03:49:36 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id j11sm13327370pfj.35.2021.12.18.03.49.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Dec 2021 03:49:35 -0800 (PST)
Message-ID: <61bdcacf.1c69fb81.21632.3e1c@mx.google.com>
Date:   Sat, 18 Dec 2021 03:49:35 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.16-rc5-47-gd56e7f8e2a45
X-Kernelci-Report-Type: build
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
Subject: pm/testing build: 7 builds: 0 failed, 7 passed,
 1 warning (v5.16-rc5-47-gd56e7f8e2a45)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 7 builds: 0 failed, 7 passed, 1 warning (v5.16-rc5-47-gd5=
6e7f8e2a45)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
16-rc5-47-gd56e7f8e2a45/

Tree: pm
Branch: testing
Git Describe: v5.16-rc5-47-gd56e7f8e2a45
Git Commit: d56e7f8e2a454abe4a106bcf04153d8c48dad7b1
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
Built: 7 unique architectures

Warnings Detected:

arc:

arm64:

arm:

i386:

mips:
    32r2el_defconfig (gcc-10): 1 warning

riscv:

x86_64:


Warnings summary:

    1    arch/mips/boot/dts/img/boston.dts:128.19-178.5: Warning (pci_devic=
e_reg): /pci@14000000/pci2_root@0,0,0: PCI unit address format error, expec=
ted "0,0"

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D

Detailed per-defconfig build reports:

---------------------------------------------------------------------------=
-----
32r2el_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sect=
ion mismatches

Warnings:
    arch/mips/boot/dts/img/boston.dts:128.19-178.5: Warning (pci_device_reg=
): /pci@14000000/pci2_root@0,0,0: PCI unit address format error, expected "=
0,0"

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
x86_64_defconfig (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 s=
ection mismatches

---
For more info write to <info@kernelci.org>
