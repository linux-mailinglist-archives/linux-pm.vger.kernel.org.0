Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BC6460E98A
	for <lists+linux-pm@lfdr.de>; Wed, 26 Oct 2022 21:48:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233245AbiJZTsb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 26 Oct 2022 15:48:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234000AbiJZTsT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 26 Oct 2022 15:48:19 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CC1431EFB
        for <linux-pm@vger.kernel.org>; Wed, 26 Oct 2022 12:48:18 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id r18so15930741pgr.12
        for <linux-pm@vger.kernel.org>; Wed, 26 Oct 2022 12:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=bLSjQWHZV5CyzoDOQTCtkvP2MJieuvohXadOFgKWMzk=;
        b=6G3fHyZbOebI8LcBnYrKnwYOH2F1DhbHWNG5xBc7K9/lmQv491C4J0ojKKMRmBv9Ln
         ZVpUTrl56SYhNw/Bu4DYl7ltS6W6nGOzwMJRmyun1er0s9QhTf+wfsMl/dQ7Vql6GZR4
         U+ZRr6g0/tqu3UHwqVeYXLOv+kJSuIzNGeObw1gX7LbjLvAftVW9n7sd8+PIuPynIiha
         4EsPYkrEB6fE3HykjTi21lahujz/Lvjz6sSm6fl298UfbHpFESFRja53tdrpuVKU2VN9
         Amu0P2nZMXZttwdPJ2MpK++ggSoClEYSQdH1aIagQ7jrYT+trHeN4wMM68ZWXP/C2Bkk
         HFvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bLSjQWHZV5CyzoDOQTCtkvP2MJieuvohXadOFgKWMzk=;
        b=ErZp6SnBGLdb2TuKJImF5zHV4B/A31D9TaqdL9e2hHxquPEaVogWqDA5tzF5JpuAdP
         VKeogkvLSyenZvf+PG5rO676HZTupRF/Nrj9y+AqL9DTkZ1XHHfaJ0qdBtNSr6iGVYYQ
         bD4eTwVEahRasUyyTgt5cLGdL6Iio1ncGBGnQE7mhIPpOtFJvUWYj8DXzyXiqCd7+a7/
         TdyXhMgFoCvmp6FdgamIP6RXT9m18zeXf1wmaQYtzN4f8Y+5BhPovFgDXT2D7YmfpaY0
         NuIo3UcPc1BTSTzuIV2R6Lv9Uqdl8I6zY6qNoGE9hLaZA9nQJw7PySsj6MKAF2yLlEWY
         3Icw==
X-Gm-Message-State: ACrzQf3CboeGkh0oc6Yx8qN7Oo1Ucuh2NHYiKsSZcQ5H8ISTk9tgCkF/
        MWcCYgp7tyxYbHBjj6Eg5TdBPyUdLHmo0OH6
X-Google-Smtp-Source: AMsMyM4vbcD+3xsAOTzt9ogSAFXvivV83pbjNXIXP450AdBYzdIx//27HByJKefvpujpiLZpVkoXXg==
X-Received: by 2002:a05:6a00:88f:b0:558:8186:3ec3 with SMTP id q15-20020a056a00088f00b0055881863ec3mr44194048pfj.83.1666813687041;
        Wed, 26 Oct 2022 12:48:07 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id f12-20020a170902ce8c00b001869f2120a4sm3292748plg.94.2022.10.26.12.48.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 12:48:06 -0700 (PDT)
Message-ID: <63598ef6.170a0220.997df.7246@mx.google.com>
Date:   Wed, 26 Oct 2022 12:48:06 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v6.1-rc2-12-g77db830e1d3a3
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
Subject: pm/testing build: 8 builds: 0 failed, 8 passed,
 5 warnings (v6.1-rc2-12-g77db830e1d3a3)
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

pm/testing build: 8 builds: 0 failed, 8 passed, 5 warnings (v6.1-rc2-12-g77=
db830e1d3a3)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v6.=
1-rc2-12-g77db830e1d3a3/

Tree: pm
Branch: testing
Git Describe: v6.1-rc2-12-g77db830e1d3a3
Git Commit: 77db830e1d3a3b7ae46801b25de69104aff9ed7a
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
Built: 8 unique architectures

Warnings Detected:

arc:

arm64:

arm:

i386:

mips:
    32r2el_defconfig (gcc-10): 1 warning

riscv:

sparc:
    sparc64_defconfig (gcc-10): 4 warnings

x86_64:


Warnings summary:

    2    WARNING: modpost: EXPORT symbol "_mcount" [vmlinux] version genera=
tion failed, symbol will not be versioned.
    2    <stdin>:1517:2: warning: #warning syscall clone3 not implemented [=
-Wcpp]
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
