Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56EE42FF580
	for <lists+linux-pm@lfdr.de>; Thu, 21 Jan 2021 21:10:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726943AbhAUUJy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 21 Jan 2021 15:09:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726587AbhAUUIw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 21 Jan 2021 15:08:52 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78F7BC0613D6
        for <linux-pm@vger.kernel.org>; Thu, 21 Jan 2021 12:08:12 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id i7so2066807pgc.8
        for <linux-pm@vger.kernel.org>; Thu, 21 Jan 2021 12:08:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=GqRCi+y1spNswoFiwX+flezPi2864HDBX4dlc2oqbCI=;
        b=zYgknaNKBt2Cvu1moNkY7mvQzYqptM3Yc3aBC3vUfpSSH5GKWs2iEgCd0bqqyLBwVp
         CCFrDM4uVD/JcfnOJ5DAqvEG+A340nEvsqRbQtdy/Q3ALq8WDMi6dpMJW8NUlnG/LFc8
         4epwg+N3N/ar6myOnJNaeYeJnJlF6QpIHx5nVIxUFN9/WkKJgCouSRdVfaoVok2MGFAR
         u77jCTOAzB7DXbAjpNSBXJXCYjjcysKFeWMbOK+wucsK30pRjXwkALSYawt3vo/hq4LG
         Ag5/oxCcieTahCAcsy22p+PayeP663+5O+P2xWO3MJXFWOSVN47lmXX5StAVVEn9JjDk
         rnHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=GqRCi+y1spNswoFiwX+flezPi2864HDBX4dlc2oqbCI=;
        b=N0d0wIr+J6kJylTusy2YLzj1wOBn2T8O1IRPltFNE5OI+q6o5bQW8D/1vxJoTJkkMz
         mHL+gE9fc/SvG1kWbclzEmSC66KTQnbhGIh734ZUphdVfxOsG+jZE5Cyk66IgOaouTFW
         yPKWJzOIny+saZJhAXM5OJWjrbOu9MtN5xN2bcnHclvedfuRMnJFSycgZaTB5Ka96Boc
         pAm/htCy2zKYPpNOXzGDjrIns0LYSrurQTqv3/YTKb7r4o7V9Z+FKWMHcnoYjsLnu5O+
         OG2r77faVMQ+GOSHI/mxNrozpLkeNYZdzT3WPkssdtJNTGudLagnS7QYbYPC3O5P6aN1
         dUYw==
X-Gm-Message-State: AOAM531zoxrRo7JgY6pU615rFrOEjBMpIOgiCPJlYb4hZ0DOCaSzdvbo
        f6ig56K8SGDNpUQSaHpqgu88KQ==
X-Google-Smtp-Source: ABdhPJxxaAinyaAMOQjPXaxDN5FQm4tXEr3AJL/UYaoFop+cSVcA4CDgbch00L8mkNB4la3cdrcJDA==
X-Received: by 2002:a62:1d46:0:b029:1b7:fe6e:4bb4 with SMTP id d67-20020a621d460000b02901b7fe6e4bb4mr1384944pfd.4.1611259692062;
        Thu, 21 Jan 2021 12:08:12 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id j9sm6383156pgb.47.2021.01.21.12.08.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jan 2021 12:08:11 -0800 (PST)
Message-ID: <6009df2b.1c69fb81.9ff86.e6a6@mx.google.com>
Date:   Thu, 21 Jan 2021 12:08:11 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: acpi-5.11-rc5-27-gd9ac95f54ba88
Subject: pm/testing build: 6 builds: 0 failed, 6 passed,
 1 warning (acpi-5.11-rc5-27-gd9ac95f54ba88)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 6 builds: 0 failed, 6 passed, 1 warning (acpi-5.11-rc5-27=
-gd9ac95f54ba88)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/acp=
i-5.11-rc5-27-gd9ac95f54ba88/

Tree: pm
Branch: testing
Git Describe: acpi-5.11-rc5-27-gd9ac95f54ba88
Git Commit: d9ac95f54ba88454a0ff889028149b802118a89b
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
Built: 6 unique architectures

Warnings Detected:

arc:

arm:
    multi_v7_defconfig (gcc-8): 1 warning

i386:

mips:

riscv:

x86_64:


Warnings summary:

    1    drivers/pinctrl/nomadik/pinctrl-nomadik.c:952:8: warning: unused v=
ariable =E2=80=98wake=E2=80=99 [-Wunused-variable]

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D

Detailed per-defconfig build reports:

---------------------------------------------------------------------------=
-----
32r2el_defconfig (mips, gcc-8) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sect=
ion mismatches

---------------------------------------------------------------------------=
-----
defconfig (riscv, gcc-8) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section mi=
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
multi_v7_defconfig (arm, gcc-8) =E2=80=94 PASS, 0 errors, 1 warning, 0 sect=
ion mismatches

Warnings:
    drivers/pinctrl/nomadik/pinctrl-nomadik.c:952:8: warning: unused variab=
le =E2=80=98wake=E2=80=99 [-Wunused-variable]

---------------------------------------------------------------------------=
-----
x86_64_defconfig (x86_64, gcc-8) =E2=80=94 PASS, 0 errors, 0 warnings, 0 se=
ction mismatches

---
For more info write to <info@kernelci.org>
