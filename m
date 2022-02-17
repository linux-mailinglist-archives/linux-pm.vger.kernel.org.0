Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BE5E4BA7F4
	for <lists+linux-pm@lfdr.de>; Thu, 17 Feb 2022 19:16:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232007AbiBQSQx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 17 Feb 2022 13:16:53 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243213AbiBQSQx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 17 Feb 2022 13:16:53 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A122EC428A
        for <linux-pm@vger.kernel.org>; Thu, 17 Feb 2022 10:16:37 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id u5so5228167ple.3
        for <linux-pm@vger.kernel.org>; Thu, 17 Feb 2022 10:16:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=y+pLR3LyXdDu4SqOLrKBsMoUpASpAk656btEcmLOjd8=;
        b=AsAVpQaaI7bTrS4nPB4YbueBJXfmEiee3UJULuyXn44HYkMLZccfEFgYl65Hoo4EXb
         azjdvb8JrDtImSRs2iiYDV5b3cQY88itLcXhikSzObL/PletSU90mFNiE8PqxC7pgaHt
         alX1e8XVhm3ir9BtTW3xRs+oNCDfJigCFvOxiFdDUgXqaQiH3JZRQb+pUzok5qlL0Okl
         TGuRuRZvMQ+EnIeqr/9RA4RVkZYg5IYXiCQsOzVgs1OPJ8eWaswW7EdkH9uFMnsJzGR/
         Achz6JTodV0SpTFGbN21eXoUlItUCuo/011zxrkJHBX9+DPyfhVjko7xPUkFJOgjqhyE
         XoHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=y+pLR3LyXdDu4SqOLrKBsMoUpASpAk656btEcmLOjd8=;
        b=cFC2RcEt1g8IUMOge43iKf5BDorMyTJt8NSAHIoITgWwhj/obILXXnej+oKd99wa4i
         bIkBr/Bq4zoIIlwr6+zutoaxeCUoiDSs/Wzbmf2zFDaTkpHq6GbZPI8psBf4eSM57CYC
         ZrH1s43Y3XPCzMU88nBM1FvibKiGg/z0fReqXykEknCZpTgnLMr3gAfB4aXnFOjY6HQo
         bMcKZyZOIApjpCxA+31nsKKxW/ZH6ToaRDnFPKI95sfmHI7mArgzJLod7VAO2D3PwBVR
         Ik7CRPHkbRE8rJm/Wlw/jEHw/ltAaEuZ3Pz+ylfa97Mj+ZIpc9WJAHctCWsxQ9Tb3Ua1
         XCaw==
X-Gm-Message-State: AOAM533B7w1QPflf9j9GRVPmVCv3fMNb+2LKFCYXD+WqQ8LuaMZiI2Tv
        tPU2soXS7SNkBG6gNcMY9w9ync7c2dNEo7b6
X-Google-Smtp-Source: ABdhPJwImJ1TSRhnSXpECF3mIFJZkjMe2vHOKBeeVz4GbMqbIB+HfjRnt9RkUcds9wlEa3qpJZcntA==
X-Received: by 2002:a17:90a:2b0d:b0:1b5:8087:4b4e with SMTP id x13-20020a17090a2b0d00b001b580874b4emr4291100pjc.70.1645121797160;
        Thu, 17 Feb 2022 10:16:37 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id g17sm250767pfc.193.2022.02.17.10.16.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 10:16:36 -0800 (PST)
Message-ID: <620e9104.1c69fb81.1a095.14a9@mx.google.com>
Date:   Thu, 17 Feb 2022 10:16:36 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
X-Kernelci-Kernel: v5.17-rc4-51-ga6df857665e6
Subject: pm/testing build: 7 builds: 0 failed, 7 passed,
 1 warning (v5.17-rc4-51-ga6df857665e6)
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

pm/testing build: 7 builds: 0 failed, 7 passed, 1 warning (v5.17-rc4-51-ga6=
df857665e6)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
17-rc4-51-ga6df857665e6/

Tree: pm
Branch: testing
Git Describe: v5.17-rc4-51-ga6df857665e6
Git Commit: a6df857665e68dd113761a7f5d8935995d1be237
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
defconfig (arm64, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section m=
ismatches

---------------------------------------------------------------------------=
-----
defconfig (riscv, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section m=
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
