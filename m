Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 963DD4D7227
	for <lists+linux-pm@lfdr.de>; Sun, 13 Mar 2022 03:05:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232118AbiCMCGk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 12 Mar 2022 21:06:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231222AbiCMCGj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 12 Mar 2022 21:06:39 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EA4726120
        for <linux-pm@vger.kernel.org>; Sat, 12 Mar 2022 18:05:33 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id e3so11291955pjm.5
        for <linux-pm@vger.kernel.org>; Sat, 12 Mar 2022 18:05:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=T71jV/Wu/1wjs4JaWF9uvFCkZ7HyEP3fPSWpUPvlh/k=;
        b=qZYfVcraAtG8HHRdN0o7/zOnwZYdvTa3clrQPNI08zAWeUaOeld37KXZFazSyJKoU2
         ugRZuPqU/u3yYVegO39CRYVgkT1prvs4k/l3x9AMoT39Ch6jEO0tw3LmXO1wXeaJ/dCI
         5/OcdY33tnkB9Ekn5pW+DnNwDWmpTejH9qPPFlVGE0+vQ3FQyjlQgcQ+mJOK6c40O4Pz
         e8v1QUv+k+dDhuFODblceXN1A3w1C0Cq6GdNdDoyze2fEEofgtj9cXuM/B9Ms/97wSBd
         pqbpo8a497me0Kr8UUgU55BdIFrwpVKttMUM21cdUm82HMcE768HJZ62aVZ/oDtl5J2T
         cGjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=T71jV/Wu/1wjs4JaWF9uvFCkZ7HyEP3fPSWpUPvlh/k=;
        b=xZ+fadLp/coXfPAmddh5s0UDfl4Q558jUhvkUCN/xWxjdfrHoeNLG20zbdl4/1B0KM
         X+qSI7Zi89zz1VUyS9zb8pTpcPvHnnzrfFVyFC88fVPhSjAoAC4UKN15VWzjgJpLL+v5
         ce92ykO5dCxDaXS6ixT99wDrNwfQpdlvHG+NI2urth8Mu11y0GPp9G2d5qojIX9JM2Sa
         r2qz1M5zOKdKDF3CalP+P6ogDUVjtHzu+rvdn/z/SYMM1o5BCDblDbEpHcsEYM197xjR
         I0XfOpkwow7LmrxSOqw+E0rI4Oo8Yc3waRvTRzIBLrU7Rfv5s+whwWbGz+qi7dIfXu08
         UmnQ==
X-Gm-Message-State: AOAM531RSJtkY1eEw+wnVIB9b6sFUCvHV/LnTzmrpY+CsR+VRZbMOizb
        4OzM0hfbWGHGL7B6zwJKjiKKrg==
X-Google-Smtp-Source: ABdhPJzCJH3fzUQCASK+jGirgAzJZZFU1atEHSYBw/ZGsLWSTr1N+2IEJxfuovryImJCJNh5F3rKuw==
X-Received: by 2002:a17:90b:3716:b0:1bf:691f:52ad with SMTP id mg22-20020a17090b371600b001bf691f52admr29149667pjb.202.1647137132743;
        Sat, 12 Mar 2022 18:05:32 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id d9-20020a056a0010c900b004f774c13e96sm11394650pfu.19.2022.03.12.18.05.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Mar 2022 18:05:32 -0800 (PST)
Message-ID: <622d516c.1c69fb81.5dd27.d3a3@mx.google.com>
Date:   Sat, 12 Mar 2022 18:05:32 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
X-Kernelci-Kernel: v5.17-rc7-161-gbda0a27564ac
Subject: pm/testing build: 7 builds: 0 failed, 7 passed,
 1 warning (v5.17-rc7-161-gbda0a27564ac)
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

pm/testing build: 7 builds: 0 failed, 7 passed, 1 warning (v5.17-rc7-161-gb=
da0a27564ac)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
17-rc7-161-gbda0a27564ac/

Tree: pm
Branch: testing
Git Describe: v5.17-rc7-161-gbda0a27564ac
Git Commit: bda0a27564ac6b8ddd5972a7d630a62fde44ce51
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
