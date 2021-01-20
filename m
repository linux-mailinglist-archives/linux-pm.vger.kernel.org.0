Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EF5C2FC95E
	for <lists+linux-pm@lfdr.de>; Wed, 20 Jan 2021 04:47:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730420AbhATDqz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 19 Jan 2021 22:46:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730222AbhATDoh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 19 Jan 2021 22:44:37 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 353BCC0613C1
        for <linux-pm@vger.kernel.org>; Tue, 19 Jan 2021 19:43:54 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id w14so4628568pfi.2
        for <linux-pm@vger.kernel.org>; Tue, 19 Jan 2021 19:43:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=RmIbevJLti+B0r0QkUZmPDTRtdNwZ9i1tIt+2/r6lwk=;
        b=e99btfWFqG2vmHaZC87kVR7eiKxmRlwvMNv2hdrfB+t5lxPFYPd5M0vVsIBuTrCcMI
         biEHxIJ5CcaVNunHL+pMsH/7Vu0s0WjNa9mmWipjdsYu5G74C9LEKQz1qs7n56MQAgGC
         oOUKODVAUc54c8BQwdOQ/KYTlY2eMcMMOjelGsaF3zzlBR58Hb0LGlcTsrRxBC8vFggi
         myD9Kigt8K5jYWcjzsvRMr4eauxPdFZyXLaRkj5NlqR2/ahN//JxR+2Q2gAx4PyknP7H
         atkeyCaAI1FP/lzKds+AWDxQWwnHJF+qw0tdDCLeSmSuhRBI+cLJBxwTCiHGjDl0XSNP
         Z0jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=RmIbevJLti+B0r0QkUZmPDTRtdNwZ9i1tIt+2/r6lwk=;
        b=Aj0F66j++7e+PpZeHhjk1XRG8I2t+jayFHCZpSyCbbEEgOkFxABbjpeC+CFwqF1iCH
         NMIXOC9L03HMbP4qQTPKM5xsVn3jRmyRgPuzs0ohXYjaDE2TRvvHIXm7BoUds0WBYLXj
         8XYBMolky5rDQTYKjbEADopUS2AYN709n+Fr9+gkgiLgUAIvCYWP5Z3+Pm441FjBkYZ6
         0JxWX3nxMPvPSjK6N80VxGZYxJzKZYn3ipdAaLfVC59EAovtihfI4LacB4nAi7/CHqab
         SxJiuUQ6LqB+1fH6pGzSuXcJT/1GUl8AkfhvXTd6zCoW9H1UfxLO/+zRaIL9AQ/81yYZ
         O7YA==
X-Gm-Message-State: AOAM533Wq/MPKru7Oq8BXKhX/nVt1yUGYpU4b7BzVaD7QWZ2T7GhGV/T
        pTjJGiTCxSwlo2SOeRl/+7vfn4a0TEalvA==
X-Google-Smtp-Source: ABdhPJw5NSQZzLfGaDLZ5u+b5NJtaCtVtjq0+Gasd6t59rxgXlRbld7kWkQ4vkbX+SfqQuDo4tKr5A==
X-Received: by 2002:a63:db54:: with SMTP id x20mr7397392pgi.200.1611114233766;
        Tue, 19 Jan 2021 19:43:53 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id a18sm507422pfg.107.2021.01.19.19.43.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jan 2021 19:43:53 -0800 (PST)
Message-ID: <6007a6f9.1c69fb81.add92.23c8@mx.google.com>
Date:   Tue, 19 Jan 2021 19:43:53 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v5.11-rc4-26-ga2ab445613e2
Subject: pm/testing build: 6 builds: 0 failed, 6 passed,
 1 warning (v5.11-rc4-26-ga2ab445613e2)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 6 builds: 0 failed, 6 passed, 1 warning (v5.11-rc4-26-ga2=
ab445613e2)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
11-rc4-26-ga2ab445613e2/

Tree: pm
Branch: testing
Git Describe: v5.11-rc4-26-ga2ab445613e2
Git Commit: a2ab445613e2ef8a14a759e53a883b87215e737f
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
Built: 6 unique architectures

Warnings Detected:

arc:

arm:
    multi_v7_defconfig (gcc-8): 1 warning

i386:

mips:

riscv:

x86_64:


Warnings summary:

    1    drivers/pinctrl/nomadik/pinctrl-nomadik.c:952:8: warning: unused v=
ariable =E2=80=98wake=E2=80=99 [-Wunused-variable]

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D

Detailed per-defconfig build reports:

---------------------------------------------------------------------------=
-----
32r2el_defconfig (mips, gcc-8) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sect=
ion mismatches

---------------------------------------------------------------------------=
-----
defconfig (riscv, gcc-8) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section mi=
smatches

---------------------------------------------------------------------------=
-----
haps_hs_smp_defconfig (arc, gcc-8) =E2=80=94 PASS, 0 errors, 0 warnings, 0 =
section mismatches

---------------------------------------------------------------------------=
-----
i386_defconfig (i386, gcc-8) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sectio=
n mismatches

---------------------------------------------------------------------------=
-----
multi_v7_defconfig (arm, gcc-8) =E2=80=94 PASS, 0 errors, 1 warning, 0 sect=
ion mismatches

Warnings:
    drivers/pinctrl/nomadik/pinctrl-nomadik.c:952:8: warning: unused variab=
le =E2=80=98wake=E2=80=99 [-Wunused-variable]

---------------------------------------------------------------------------=
-----
x86_64_defconfig (x86_64, gcc-8) =E2=80=94 PASS, 0 errors, 0 warnings, 0 se=
ction mismatches

---
For more info write to <info@kernelci.org>
