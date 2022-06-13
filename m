Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4419549DEC
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jun 2022 21:43:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243063AbiFMTnA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 Jun 2022 15:43:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244954AbiFMTmh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 Jun 2022 15:42:37 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21B0F29CA3
        for <linux-pm@vger.kernel.org>; Mon, 13 Jun 2022 11:10:48 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id w21so6487321pfc.0
        for <linux-pm@vger.kernel.org>; Mon, 13 Jun 2022 11:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=YuzzcNPOTQoO/Ym3FKKMePrB7VOqlrLweIwG/yrAl2E=;
        b=mQzcHIegYOXsSS0EagLD3I0E1jRitSrqFsMwJjcZd+uevQNTcnef8Hd7x+Tc1ihvix
         6iDq/3Uwfj35lOnw+6JZW9wIH6WCWQjj0f8v+GD1svgNeX9Rhf4Vcg3LYMisF661q9Zy
         3oKIybg7Cwq6+V1wSMKZRJz/on31h/YoeS7G3pzI3PEnAuwNRgg0IzISjEKNpvXV1reT
         otKVIbzhRSRm3yEGn6dx33imA1MWQJmVpmQSupOwUMMMUWY4mLJlK/jEuWRpWExaa/i6
         S+6H91BLX6GWDo9ruQgTwo3REPuDJWcp3UAuX/vdgZW/qoUBU9LfBcPVL9iXXO7v65TG
         RYkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=YuzzcNPOTQoO/Ym3FKKMePrB7VOqlrLweIwG/yrAl2E=;
        b=Wh4ZbFkP8az2CinGG4tHB7/77whp6ftYEPXKSefCIt45BV//iLYSy621faRcxb7g7U
         RbNCNqvn8blpCQ/wNY9t397bcoWQFW1sbwAdt1kUdcFRCmglhK8SIuaRMyGgmo6jpvda
         esPV07c+Skrpi2uppatr1h1wvvIf7vh9GNu9Kl8k/ElcPiVOzCz7Rbuf6+ME5VF4pSpI
         capCN64lCnPBecWgsGmbhh2V0pUofDjudwUkpT8E9ZeXCkgQlg53WVVcD3K3vFSlOEVx
         QfQ00VfGVP79t4un8zZEytB02RErta9eYjwKwkGVBhruXl3zS168WU6o+dheJbYd5eGX
         nHlg==
X-Gm-Message-State: AOAM531fahlHTMRZ1LMc3cGp6dJUwKq6LBV4f5o91tkboKvRHTf5M8g/
        xcne7+wrzkH2cpU4mihDRpCBew==
X-Google-Smtp-Source: ABdhPJxynFwxn5IvglcBQT6IIJkWttpyVjxdExfV0tPFNR6KKPSujc5spGZVJ1JuRTwUFmBS8FTV/w==
X-Received: by 2002:a63:155:0:b0:3fd:1b8e:16ca with SMTP id 82-20020a630155000000b003fd1b8e16camr716124pgb.407.1655143847620;
        Mon, 13 Jun 2022 11:10:47 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id f125-20020a62db83000000b0051be7a8c008sm5727406pfg.30.2022.06.13.11.10.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 11:10:47 -0700 (PDT)
Message-ID: <62a77da7.1c69fb81.14058.6ab9@mx.google.com>
Date:   Mon, 13 Jun 2022 11:10:47 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v5.19-rc2-3-gd3104995c5831
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
Subject: pm/testing build: 7 builds: 0 failed, 7 passed,
 1 warning (v5.19-rc2-3-gd3104995c5831)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 7 builds: 0 failed, 7 passed, 1 warning (v5.19-rc2-3-gd31=
04995c5831)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
19-rc2-3-gd3104995c5831/

Tree: pm
Branch: testing
Git Describe: v5.19-rc2-3-gd3104995c5831
Git Commit: d3104995c583179bd2018b049a834319969baa80
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
