Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C84304B03E8
	for <lists+linux-pm@lfdr.de>; Thu, 10 Feb 2022 04:26:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231439AbiBJD0f (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 9 Feb 2022 22:26:35 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231271AbiBJD0f (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 9 Feb 2022 22:26:35 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76F6323BC2
        for <linux-pm@vger.kernel.org>; Wed,  9 Feb 2022 19:26:37 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id ki18-20020a17090ae91200b001b8be87e9abso876524pjb.1
        for <linux-pm@vger.kernel.org>; Wed, 09 Feb 2022 19:26:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=XFZkWxim7VdP/PEfjigEYZA7VSIE/poVQxiUGtKILUU=;
        b=lijW57eMVpMN1XcRpWAiq0M4vHJE8eb0H9bHNMsb8dFvIFfDheFoBSu6t4/6KdVKFl
         qCBpc8IOut0KzRpWFz67ZWDyhCXEW3kC5TjAoXK8+cgosuKDH2tHLxfutfG97N2HBPIr
         1HaUsd3tEXtFHgmIRjJOC8fvj7a7OFAHhXLIeS2AMZ2rxwBDpvR4j9ZoZsc3KiE1+LxF
         vEofl7AMPWbw6TBgVkwuchhNR5UTEYgaTgutMaWBY7OuyNtpqNkoney5a5ML26r1HUl4
         hCbqTBPrZcuQVqpHWyUOzjFtRHGUZ1ZouLTIDfaO66VKZfle3WsaoojC+goE0biVz5Dl
         H8yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=XFZkWxim7VdP/PEfjigEYZA7VSIE/poVQxiUGtKILUU=;
        b=DiBoJI+HgGBomPV6x/9TlBQ6Qgly1CJFw+oQwRQNf7uB6I6EmsIPFUzXyQIzdJRh4j
         zWr0I/qwFx0vWi0MrpCeakwT7xj8+UMvzoa8AmtKjz/7KkanHN9ZdVz98hwemWfxpTQm
         UK34Ujq3h9Ui3JA7jPutwa3Rr4UmWekC26RwWOjxgpGsAPd6BSvZzQh3SMQ4S5hVc4Iv
         +20ZkmOEKf60hlx4CM1qUjrgp6h17AFV7dvST5FzFD90eJGc8osdixcuuvk97zLIbUzK
         N0OJF7oTDaMb4rLpMymdCXw5ZZxgt6RkWvUtbNRra/ru9WoxXiTOpiI9p6H5QOp2AVCS
         m5eQ==
X-Gm-Message-State: AOAM532npAzFu7l2Y6lacmIraJTLClZHFvoIB3ySyrym+E7qCi+cXG/A
        YBkduUdkzkX+gV9hB5utE4ZY4FAWwDvXZrj5cXg=
X-Google-Smtp-Source: ABdhPJyiwklP81CXYYzHVJwlx5L3NCUi5pLHC2sbTx0XpzakjMVvPaM0xSL+BHqVMP4JiXGg/Q7bnw==
X-Received: by 2002:a17:903:2344:: with SMTP id c4mr2186615plh.55.1644463596986;
        Wed, 09 Feb 2022 19:26:36 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id s11sm23200096pfu.58.2022.02.09.19.26.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 19:26:36 -0800 (PST)
Message-ID: <620485ec.1c69fb81.c7c93.9f61@mx.google.com>
Date:   Wed, 09 Feb 2022 19:26:36 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
X-Kernelci-Kernel: v5.17-rc3-37-gf2edd5978acc
Subject: pm/testing build: 7 builds: 0 failed, 7 passed,
 1 warning (v5.17-rc3-37-gf2edd5978acc)
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

pm/testing build: 7 builds: 0 failed, 7 passed, 1 warning (v5.17-rc3-37-gf2=
edd5978acc)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
17-rc3-37-gf2edd5978acc/

Tree: pm
Branch: testing
Git Describe: v5.17-rc3-37-gf2edd5978acc
Git Commit: f2edd5978accce27c47f14e94f420b7fc5922266
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
