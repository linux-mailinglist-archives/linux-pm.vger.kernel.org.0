Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 807A052DC73
	for <lists+linux-pm@lfdr.de>; Thu, 19 May 2022 20:11:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229475AbiESSKz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 May 2022 14:10:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236983AbiESSKx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 May 2022 14:10:53 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F11A1201AC
        for <linux-pm@vger.kernel.org>; Thu, 19 May 2022 11:10:52 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id j6so5775738pfe.13
        for <linux-pm@vger.kernel.org>; Thu, 19 May 2022 11:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=6oi2KFNZUi4+0+oB/sR9FTUkCSn+b7PROFWSpAAj09c=;
        b=3i9LyNx8FVaFArgKJBJ7CEz+vK52kX678KE9tuO8+Gzy9W2s+2B+R8Hmlquf3kDsbD
         ZXf0EnwQE2cIyp1GkBF/tShyvgkVXfGWtDCtPOTfaGimPK6lnl6RULKYXx0NDw8pMYEu
         4mH7NDaV0209p2DcSfIITm4ygP23mvQbo4MSstXNSJ2tMH2TUKQUOmns9HalXg6Lz9Js
         BM2/cPle6VNjxN/6J/GOa+oQZXH08//TLCRwxwq294SppTVun5OKj5e6H2+DiGs6eoc5
         wyOd5zHF3m/2OyirKWhZAK+Zj36gtIa++DsYAE0TiprSmXAbDrp3b5TjAspeXOB7lbD2
         XA2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=6oi2KFNZUi4+0+oB/sR9FTUkCSn+b7PROFWSpAAj09c=;
        b=tbP2JrPQ4TH90yHbRlOZcvhJAdMS3/zJHZxfZ7FL/jVxnd1JnaOa1OyDWUkBUQsdKA
         DDWgSUAisF3hFykdsrHYxy0HsabCuEa/SlzH6O9q4SrNlZAJigqEIB1pDxPuZgig/lqh
         oWS5BUKrNrJpStFoaz17S7Rigr1xJDvXBkn8Wy7vpi7vyDLLklfqv32AmsBAVZAxmRja
         m4waZgFoHl/BoeZVipRWOwFQha6Qs5aBnUcusCed60eR5vcPgnHgKLwj5/Wu27mSKklM
         9D6C/ti5dVU0HRBwg1+XnbhPq4Uq+da3Bs0sinN93VOSj74EZyKWmB3qy/mbgASs6KUw
         MQjQ==
X-Gm-Message-State: AOAM531gl7G0jxTMd1aYj1U0RrOfFYMVh6VAQ2Tq/q1KU9NhexxsFtq8
        ZctSWS5nTNRwKleis5yesmm3SLq2Pf2AYaIiDfg=
X-Google-Smtp-Source: ABdhPJwmTJIbUXOmZAqSVsbhUPkkDmBTLDFk4J9kRs6oIqym08rJfscOkbDz7avHbiAnb/9TnUSRUw==
X-Received: by 2002:a63:d152:0:b0:3f6:184c:ecb9 with SMTP id c18-20020a63d152000000b003f6184cecb9mr4952605pgj.278.1652983852498;
        Thu, 19 May 2022 11:10:52 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id b9-20020a17090a5a0900b001d9927ef1desm108115pjd.34.2022.05.19.11.10.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 11:10:52 -0700 (PDT)
Message-ID: <6286882c.1c69fb81.6b429.0596@mx.google.com>
Date:   Thu, 19 May 2022 11:10:52 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v5.18-rc7-183-g45785e0ed597
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
Subject: pm/testing build: 7 builds: 0 failed, 7 passed,
 1 warning (v5.18-rc7-183-g45785e0ed597)
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

pm/testing build: 7 builds: 0 failed, 7 passed, 1 warning (v5.18-rc7-183-g4=
5785e0ed597)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
18-rc7-183-g45785e0ed597/

Tree: pm
Branch: testing
Git Describe: v5.18-rc7-183-g45785e0ed597
Git Commit: 45785e0ed5978d9b2f9ec7f20bc39c3be0f1d37b
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
