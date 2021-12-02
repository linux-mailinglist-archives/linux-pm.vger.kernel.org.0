Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AE36465AC4
	for <lists+linux-pm@lfdr.de>; Thu,  2 Dec 2021 01:24:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233617AbhLBA2E (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 Dec 2021 19:28:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232372AbhLBA2D (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Dec 2021 19:28:03 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D263EC061574
        for <linux-pm@vger.kernel.org>; Wed,  1 Dec 2021 16:24:41 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id fv9-20020a17090b0e8900b001a6a5ab1392so3177945pjb.1
        for <linux-pm@vger.kernel.org>; Wed, 01 Dec 2021 16:24:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=3osnKl+f0AiHbBwDb1J4V+an3OPcXXZMm9tDEWVgniM=;
        b=A6YeoRyfnGWLs1x6wSTzsIW35Ev2sXO6PG/RQ9/oAJvvk3inYDF9I6TCz9MNQ/a043
         3Xuie/781/cen6fAcYVK2LpmBzkdJQMdVFiZFtesQEsc27QuNu7JezG0ZJnmvdL4gIT8
         vr/qc9N6WuexUfbyVr8NEGQ7tYXn5hwyvSI4c0IjMIbDSLaMkTVBoBLhM5kHIEO4fWQD
         0h0jgpezMrZa3Lwv1SKYiDC0XZZY/K296IIFbczzwkxsXnvlx0pzwPDD5Wp5qK1vo9B4
         2deUTw3B07wCxvkIUl9BoKXj+4StUjf7CSkQ1/lPXgo4+sW6na8rsFqsgMYTpoiiA/hi
         XlEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=3osnKl+f0AiHbBwDb1J4V+an3OPcXXZMm9tDEWVgniM=;
        b=IjDVH6VB9jZaTfG3Li1r1Sg137mctFU5yqHSVcdkOTfig+yHFAgNCoxUsF86BtR1kZ
         07fY5CvBOjTQnpC79On183K+h9DB8Pa0SqakqBSv1dXYze9GrVhtQ+/kfBYoEYm4mr1Y
         7NVEzArpOFHevigYEq5sFgCNRSFuZCrKC+EgvkGGl5UdwRJomR2VkZl1MNlSr2aJ3e8o
         TtXNy7GtzZFeKO0bVox9IHc2tq4VSHzEOfacV/7Uwh1VfxZOx96JhgUnYVmX9KbjlFB5
         orS1Za3qVwd4BEXykuDykpRkzx95RylbgwcVw1uLF9gYmBw2gClaDUv7y425ZFBdsxB8
         0Tyg==
X-Gm-Message-State: AOAM532CD7BpMXIPfvIoDbJjhbKynl7TdaNM3ZjOCHFlxAeFWuJkVYbY
        E3ouwY5qq5G3ZCmwyDcpdleNDoEHhoHEdW9f
X-Google-Smtp-Source: ABdhPJw/GfSkxMdQnj0bnVv6xa34kvcwcmGw/AivDaa67FKLpRLhOuBjl6s90aJ66qXfsluEffhRMQ==
X-Received: by 2002:a17:90a:d70a:: with SMTP id y10mr2021243pju.36.1638404681406;
        Wed, 01 Dec 2021 16:24:41 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id m15sm406169pjc.35.2021.12.01.16.24.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Dec 2021 16:24:41 -0800 (PST)
Message-ID: <61a81249.1c69fb81.ddb0d.20a0@mx.google.com>
Date:   Wed, 01 Dec 2021 16:24:41 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v5.16-rc3-24-g44e0749b647e4
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
Subject: pm/testing build: 7 builds: 0 failed, 7 passed,
 1 warning (v5.16-rc3-24-g44e0749b647e4)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 7 builds: 0 failed, 7 passed, 1 warning (v5.16-rc3-24-g44=
e0749b647e4)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
16-rc3-24-g44e0749b647e4/

Tree: pm
Branch: testing
Git Describe: v5.16-rc3-24-g44e0749b647e4
Git Commit: 44e0749b647e4086b658e8595add05150f1a167a
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
