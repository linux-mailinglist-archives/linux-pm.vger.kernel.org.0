Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21193437A78
	for <lists+linux-pm@lfdr.de>; Fri, 22 Oct 2021 17:58:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233332AbhJVQAc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 22 Oct 2021 12:00:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232107AbhJVQAb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 22 Oct 2021 12:00:31 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAB21C061764
        for <linux-pm@vger.kernel.org>; Fri, 22 Oct 2021 08:58:13 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id y1so2990021plk.10
        for <linux-pm@vger.kernel.org>; Fri, 22 Oct 2021 08:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=4sndfzRU8pb16Ffjc4smF9baHUuk/g2ApIDB3Hp5VeE=;
        b=bYtfjinzsxnD4/mdKZ5JDCvbm+AVVCNFnSE5sY2qnn2pGGe1OMP7UqVdHsKAlHRrpK
         If0Qs0ptAynOIzn5m76c+G4VlY8XQZlt+wG79Z+qQtDRg6P+OUucVFWxb0+h22yM4muz
         BSUpOxQ1lOwK0h5e9YnwxqDSFDB1BPujZFDWA1agsIGtgC6jJtSYZOItV/sNqzhVb5UJ
         XQ/tXAG77zsqksgrjCH46XlyQz6KfvP2afq5QlShJRsgJTAFW5CxnFQAPw6kv8I3g/iJ
         9m76J5BV0PE7mcMnhRsW/OucPHbS08XWOsj5bEYuegESZto1+cnEYG7sE3Yr7niFvgP5
         B/jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=4sndfzRU8pb16Ffjc4smF9baHUuk/g2ApIDB3Hp5VeE=;
        b=c2+i+bijskGRrlmGDH7qjPA4zb0lXx0zFEoNY1Eyn7nSZLEyEJGTOK0J90z9xDXFe4
         8Hfe/3Kiz+AxePfq51gH+EN9QZyvl0kSHNCxdqTKruiRn4DmZ244hT/3Uf/WbkBdIQZW
         G1xnCelFID/fzbRd4iHIe1kywpZ5kExebrg+DGA4TqM64fSvOQtd8PABHPlnGYbtrpWG
         cIm6PmLAaHnSG+/Wx8ZMPocuDwUx6oq3djzNaoGu6x0ihm/g/l19CzuEgX13aXy8C0bb
         A2IQq7Q44zV6XlF9kNF1658NLO2IvUw5BOl2KcN+JglPue/zFUNOKfrKK9MDpawVg3vU
         9dUQ==
X-Gm-Message-State: AOAM530t+sL9VOZv2bqJ1L8Fng5CcX9I8ofbuC7WFmt4L1UghUZUxiZQ
        bYTKy7mcL4msj17l1ew2xdy1mSFydmCt1TBa
X-Google-Smtp-Source: ABdhPJwY++x3KQs40tisf65F+paOj92pY2NiRktreCq+RGgIRwWTCN8ZrPV5PEoz6/JlOJJKljN+gA==
X-Received: by 2002:a17:90b:4f90:: with SMTP id qe16mr840286pjb.137.1634918293479;
        Fri, 22 Oct 2021 08:58:13 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id u1sm4939259pjy.17.2021.10.22.08.58.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Oct 2021 08:58:13 -0700 (PDT)
Message-ID: <6172df95.1c69fb81.732e8.cca2@mx.google.com>
Date:   Fri, 22 Oct 2021 08:58:13 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v5.15-rc6-80-g30c7771b41dc
X-Kernelci-Report-Type: build
Subject: pm/testing build: 7 builds: 0 failed, 7 passed,
 1 warning (v5.15-rc6-80-g30c7771b41dc)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 7 builds: 0 failed, 7 passed, 1 warning (v5.15-rc6-80-g30=
c7771b41dc)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
15-rc6-80-g30c7771b41dc/

Tree: pm
Branch: testing
Git Describe: v5.15-rc6-80-g30c7771b41dc
Git Commit: 30c7771b41dcb03df34307efbc8783ea4d8c28b7
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
