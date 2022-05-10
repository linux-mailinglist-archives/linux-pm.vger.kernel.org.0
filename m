Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66CFD5212A5
	for <lists+linux-pm@lfdr.de>; Tue, 10 May 2022 12:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240146AbiEJKwv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 May 2022 06:52:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240080AbiEJKwh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 May 2022 06:52:37 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DBD22ABBCC
        for <linux-pm@vger.kernel.org>; Tue, 10 May 2022 03:48:33 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id c1-20020a17090a558100b001dca2694f23so1803643pji.3
        for <linux-pm@vger.kernel.org>; Tue, 10 May 2022 03:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=RmY4Du8Nvs6alfFWh2qW6nu7nxQ97kHdJXS5k70cTzM=;
        b=mQUU2+FT2dewytO9DkfnAAUXtO2FlX1UQdIbMzpbwFTCky3d0NkWMyGmEIQr1M9DcM
         Yr5Lsrem0pJMIncRUwS+UcbsOGDJKD5IDOT4c1phP7yhqtDbf0i25AJYtrhS+2cild6G
         y2iRpEpuIu4lNuK7IvFAARXHwtCS7aUTFJQe/B7SojXRX8KaIVuXV8ZSfY+QELJ6WuIt
         rwj90Y8zXuZmwQMleLH129JidMEJJZ/GlIzfgYjT8JbVuon8DJ+GWUl0bEqFu9+7s4bQ
         dtNON1w4zT75pJxY/N62jvtcPcI5VW95Imd22nRVJtT9JWZd8O10Oo6qCck19vVhoY/X
         FWxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=RmY4Du8Nvs6alfFWh2qW6nu7nxQ97kHdJXS5k70cTzM=;
        b=dje7qus2Zwk9AoU4IMmpoRoGt5lbJuYvtGtWibCPs/QlGenvsPOxb+4XwlcY+2NNfw
         9YwArvJpfWhaPM11ntGLPuPUZrgpCvBgtY0H075PuH5kbJSQ6suwqdEIqizFFi5uvI1G
         1/pguffjGcM2qvFbZ+fXHti3Dvy3tdDwgrVfyDs0HhIMwX7Q+DG55gS+D02TBh14avkZ
         wpCUYKPiU0z/8sjYJoOwqJ365VS/upKV4qwaaCv9T2SBEGzLpEnjTajxxwhl0DCzpZQ3
         73Pr8UiLl9X8m09G9PMS940pev3fousL5743eY3fY4Hts1xmKd9PNZZ+V2d4RryvBg6u
         l7yA==
X-Gm-Message-State: AOAM5313sAlBZwuBv9aZT8Kgc5kUYEedm4nbNC+QPFd7FX3AAl3G5+hb
        aW451wTXIaWJO81Nj7fBwC1kIA==
X-Google-Smtp-Source: ABdhPJyEtOk7xXU1y6Nwx5GmD7oXKSBW2mXf4MS1xj4V4mEtVu7N+Bmg6G/uyXGRzvvV90CdInXG0A==
X-Received: by 2002:a17:902:ea53:b0:15b:1bb8:ac9e with SMTP id r19-20020a170902ea5300b0015b1bb8ac9emr19596767plg.45.1652179712814;
        Tue, 10 May 2022 03:48:32 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id x7-20020a170902b40700b0015e8d4eb258sm1643400plr.162.2022.05.10.03.48.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 03:48:32 -0700 (PDT)
Message-ID: <627a4300.1c69fb81.264dd.3fc6@mx.google.com>
Date:   Tue, 10 May 2022 03:48:32 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
X-Kernelci-Kernel: v5.18-rc6-113-g96a231dae3ae
Subject: pm/testing build: 7 builds: 0 failed, 7 passed,
 1 warning (v5.18-rc6-113-g96a231dae3ae)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 7 builds: 0 failed, 7 passed, 1 warning (v5.18-rc6-113-g9=
6a231dae3ae)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
18-rc6-113-g96a231dae3ae/

Tree: pm
Branch: testing
Git Describe: v5.18-rc6-113-g96a231dae3ae
Git Commit: 96a231dae3ae94ca45a8788eebc11cd68a5b906b
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
