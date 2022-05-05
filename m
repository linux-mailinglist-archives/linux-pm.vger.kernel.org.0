Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92EA051C9CE
	for <lists+linux-pm@lfdr.de>; Thu,  5 May 2022 21:59:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241898AbiEEUDf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 5 May 2022 16:03:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383706AbiEEUDe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 5 May 2022 16:03:34 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 584285F261
        for <linux-pm@vger.kernel.org>; Thu,  5 May 2022 12:59:54 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id c1-20020a17090a558100b001dca2694f23so4895661pji.3
        for <linux-pm@vger.kernel.org>; Thu, 05 May 2022 12:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=8QwcM7IIoTc/Q5eytcwoN1yvJ3dCtJjGKyhn+vWEJc0=;
        b=BDhtxITbQYq2HrfqzaAFdOMLZgMhHnJhxZiTa7Bu80Dg01cbPlhuuZvtWMH64uqO6K
         IAt1pkFpjNU/d77KzgqzSrQcbAh4pIDPiNjkmjY+ARpWVyKT23xqWRSmIJVLBiQaLjnp
         kGlZNc6oGTQyU3UbWG+tZQpatVRLOTYpvhXbzk6cbUR9nCSMRn2jvdRn68lfmB6YK3mT
         +OywIxz3FOrN8dkFz9OVEqzVbKlI1lnAX/1DK3jYd+EoXA6vXgBfwXqJUeZN1imTnfCX
         NqccG3aZQNotj4DpsavznVNOucUMBoo0QPTQiYNsIVUbM06cnri4c9mNwyoYl8ES7qhN
         ekYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=8QwcM7IIoTc/Q5eytcwoN1yvJ3dCtJjGKyhn+vWEJc0=;
        b=hMewmsGuUx6fKnGdSK1ScQbA26NUDMso9TRsM6zhGXmjNzkuaEUG4hVB7xSEcl44Rk
         rMwts/id0t8xheoZMQAOkXnmbVYrMbWYbrNL4kcoZoghnHP1k+FZhgUCKBtUwlIImzAA
         wJL/NzD0XPgkP2h7FM9SrkUY13MyX/VLf0AOqmXDIs1Kj2TPVdT+lcgHctD0f/XlvFN7
         vcu/IsQIbKcekbM7kgkLFPSbyZ/7yoJWHSTBWPsTYL/vKfuYZSQnMiOPs7xSW8sdKSlO
         p6sEdIcwxdF8YLcE874Nz/54bJVt1k2Jwcn/wYdnZ7DU0X8mLIhnFCKriBOUwjtC+WVD
         6w1A==
X-Gm-Message-State: AOAM533EZJNHyDuUQufhsfedbUdYj4EQNVAcHVVHbQgy2sn1y+7Y5n4P
        /2B0GKvsWKDCkm9owZ7rFhRb6Q==
X-Google-Smtp-Source: ABdhPJwALyU7KIqN+zFxmPm0cJyZk0FF7YfXIZ7bT6REF9IOMKigUPJfcIdn81TdUXCQu8H12YY9Lg==
X-Received: by 2002:a17:90a:8044:b0:1d9:7a6c:38dd with SMTP id e4-20020a17090a804400b001d97a6c38ddmr8023677pjw.156.1651780793895;
        Thu, 05 May 2022 12:59:53 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id be12-20020a056a001f0c00b0050dc76281basm1773910pfb.148.2022.05.05.12.59.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 12:59:53 -0700 (PDT)
Message-ID: <62742cb9.1c69fb81.9a3d0.3cc8@mx.google.com>
Date:   Thu, 05 May 2022 12:59:53 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
X-Kernelci-Kernel: v5.18-rc5-102-g1fb89757668a
Subject: pm/testing build: 7 builds: 0 failed, 7 passed,
 1 warning (v5.18-rc5-102-g1fb89757668a)
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

pm/testing build: 7 builds: 0 failed, 7 passed, 1 warning (v5.18-rc5-102-g1=
fb89757668a)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
18-rc5-102-g1fb89757668a/

Tree: pm
Branch: testing
Git Describe: v5.18-rc5-102-g1fb89757668a
Git Commit: 1fb89757668ad3301992968960e204ee09c07a09
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
