Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D16C4F696E
	for <lists+linux-pm@lfdr.de>; Wed,  6 Apr 2022 20:53:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbiDFScN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 6 Apr 2022 14:32:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240494AbiDFS2S (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 6 Apr 2022 14:28:18 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60CA3B53F4
        for <linux-pm@vger.kernel.org>; Wed,  6 Apr 2022 10:07:01 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id s2so3029170pfh.6
        for <linux-pm@vger.kernel.org>; Wed, 06 Apr 2022 10:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=0pM4vEZHOKtzImGgmR8xnEHDKEFyOepKp5yWeBMlMU0=;
        b=Uod0CwSCPT0os9IkpZg/Ly2RChWcBABEM4qzvsC18DvHSI96nlM8o9JpFHNwE3uWs7
         4o9/RxERGX+vkFhTnLCLSmdpY29b8jlVMnNdCzaOjFXBiYZinbLr3ohuQ4/hGFsCFmKm
         3wFEIgkfPF9Z/y5rFdZfhCiSpkklA+/PzeFxJmy1LNoHu5Svltu7YSqY0REMy2vnFOHY
         qMZvjJ4fhaHOnMy84fE8n31OPY0UW1k6RGnxVAEbyVaVDYj8pBLQiO4y3AW1LkKdp53B
         YMH0+vZHDPNifKRnKqsoBcPeHIezE+wHt+z0byr3QUqjuLl0Ey/ozy7cKohljaqx9qEq
         5ExA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=0pM4vEZHOKtzImGgmR8xnEHDKEFyOepKp5yWeBMlMU0=;
        b=xAMlBTgGZ6WO02IUmYpcgFDgL5Brl/6vdtfuefSmqcAy8rz624glQqe7RJwIQep2rU
         kDqLSKMBaKJQF5Ew8dJTi5ZIh7wn5njRtCDaxg6+Kq8Xd3tSQLb2lK4hxQnQyw4FyZm+
         gSOOCaw/m3mNvhRJ97mOShqo8NVYFuDg0hPk0guHSz4awMVvsRSUZpkGRViNcH/+E706
         8UgIQe+aKreIcyTS/7WiP93xeUkqN35GPJUBly8J1S6HWPr1IhOS4LJDC/6jVYGWqYDT
         WPa1EhkcVnYYfCvnpt2W2GfTAroUEAEn1pPW5regNUp6Ulg74SOhXImPQFtJG//0nS8Q
         8dEg==
X-Gm-Message-State: AOAM531AMuuYeYP4RHUwotdarqXhQ9nCryV+Yz7ZAVfeDtQi65KRbk9+
        eiOTGnTkn1cjDg4p2p2HUB5DdAUrfUFeB2lJ
X-Google-Smtp-Source: ABdhPJwnJ2YPWgX4DKoSvCkuVhoZ0Y1HmnXvLY34UXHfYlvFWC3HyHZDUP2epVWzmWI0+dAg3X0E2A==
X-Received: by 2002:a05:6a00:1687:b0:4e1:45d:3ded with SMTP id k7-20020a056a00168700b004e1045d3dedmr9930399pfc.0.1649264820876;
        Wed, 06 Apr 2022 10:07:00 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id q9-20020a056a0002a900b004fde4893cf8sm14929055pfs.200.2022.04.06.10.07.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 10:07:00 -0700 (PDT)
Message-ID: <624dc8b4.1c69fb81.d7160.6531@mx.google.com>
Date:   Wed, 06 Apr 2022 10:07:00 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
X-Kernelci-Kernel: v5.18-rc1-17-g2f7fc67b4d3f4
X-Kernelci-Report-Type: build
Subject: pm/testing build: 7 builds: 0 failed, 7 passed,
 1 warning (v5.18-rc1-17-g2f7fc67b4d3f4)
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

pm/testing build: 7 builds: 0 failed, 7 passed, 1 warning (v5.18-rc1-17-g2f=
7fc67b4d3f4)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
18-rc1-17-g2f7fc67b4d3f4/

Tree: pm
Branch: testing
Git Describe: v5.18-rc1-17-g2f7fc67b4d3f4
Git Commit: 2f7fc67b4d3f454beaa41b6c98671e9fd289b16f
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
