Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C7CA416666
	for <lists+linux-pm@lfdr.de>; Thu, 23 Sep 2021 22:11:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242982AbhIWUNP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 23 Sep 2021 16:13:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbhIWUNO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 23 Sep 2021 16:13:14 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3CCFC061574
        for <linux-pm@vger.kernel.org>; Thu, 23 Sep 2021 13:11:42 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id x191so530725pgd.9
        for <linux-pm@vger.kernel.org>; Thu, 23 Sep 2021 13:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=V/Lwc1KdOvR1pXOmtO4TbLc3k9RafiBavX/dO8eyQgM=;
        b=tAW4LLIdV9g2bxVuz3nvqX6uSqWzWIhFDKobdCgrBTAG5YF1TpMNr58zySPaXsb+en
         8qmPg5WuSreqXL5YxE4CenHahlU8w2hK2h1Sugl0Mb3qQrWPuP0VZ3gY5Bl/8kJDqQKI
         1lHT/q5TmneirVua7Sh6ELXI6WKRBDiJXwoU+8iy+FhBfMzqRuAhL+PtR9/iddOrZPAY
         COAh/6m4hPDtpa4FMT888ussBKeNrkY1Vg18o7ISYPXN28FfG4esyZjW6ENc62rBvS7L
         JDPxTEkyrqqD0TW8GTVhduo3DIzS71IRKLi2NmMp7mXJX6IVU3BBU8XClL3w7Y11tjaW
         K6pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=V/Lwc1KdOvR1pXOmtO4TbLc3k9RafiBavX/dO8eyQgM=;
        b=cMFmhO0Y4JvusgjnW3FGiHaRLKXfB8XASApDE3XN9FbF7+TRi78kb8jnOB+jXXr31V
         fMMw6X1I2nHeyaiKvqlUC0s7BfqqiEfD9Iixr72bzCBZxe7kXx9AM6ryagR9dinqK9Pk
         va3apS36wYd061wnVgk4cAI+Ye+pHW4fuFrDHeWqnR9doEQlWwiXTnz5LArB/CqdfFfL
         +haExZ60kNJp06UkhaKQOb/yJB2ZNNpOSdCosne5A5Ylk0eu42q9kvz0+xfvOFOuauT7
         MoUvsC+82bMf0MRdwUzuzIWfbxVHp0FAICvy5UIQQa27vLdNbwYDrtVSzQ5N3iTJ+sKC
         A/SA==
X-Gm-Message-State: AOAM53034NKIQoLAxkhfxOhYxFhKu/jM72w+IqHodmq4E5FqD6+RUtkp
        5Oqh/4IQpmA6UvoDUMNuuGXnug==
X-Google-Smtp-Source: ABdhPJyqHc2/Fxv+PQrnJXk6bzgmlOCrnuP0stMFz9o/HySR8JZxsa+fXik+oCutjEZq/yhmpzxFXg==
X-Received: by 2002:a05:6a00:2a2:b0:43d:ea13:9c06 with SMTP id q2-20020a056a0002a200b0043dea139c06mr6146188pfs.37.1632427902328;
        Thu, 23 Sep 2021 13:11:42 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id c24sm6458679pfd.120.2021.09.23.13.11.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 13:11:42 -0700 (PDT)
Message-ID: <614cdf7e.1c69fb81.4e068.3704@mx.google.com>
Date:   Thu, 23 Sep 2021 13:11:42 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.15-rc2-12-g9fa78c37a2e3
X-Kernelci-Report-Type: build
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
Subject: pm/testing build: 7 builds: 0 failed, 7 passed,
 1 warning (v5.15-rc2-12-g9fa78c37a2e3)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 7 builds: 0 failed, 7 passed, 1 warning (v5.15-rc2-12-g9f=
a78c37a2e3)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
15-rc2-12-g9fa78c37a2e3/

Tree: pm
Branch: testing
Git Describe: v5.15-rc2-12-g9fa78c37a2e3
Git Commit: 9fa78c37a2e340ea8d57b78ae9379a4110a70515
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
Built: 7 unique architectures

Warnings Detected:

arc:

arm64:

arm:

i386:

mips:
    32r2el_defconfig (gcc-8): 1 warning

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
32r2el_defconfig (mips, gcc-8) =E2=80=94 PASS, 0 errors, 1 warning, 0 secti=
on mismatches

Warnings:
    arch/mips/boot/dts/img/boston.dts:128.19-178.5: Warning (pci_device_reg=
): /pci@14000000/pci2_root@0,0,0: PCI unit address format error, expected "=
0,0"

---------------------------------------------------------------------------=
-----
defconfig (riscv, gcc-8) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section mi=
smatches

---------------------------------------------------------------------------=
-----
defconfig (arm64, gcc-8) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section mi=
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
multi_v7_defconfig (arm, gcc-8) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sec=
tion mismatches

---------------------------------------------------------------------------=
-----
x86_64_defconfig (x86_64, gcc-8) =E2=80=94 PASS, 0 errors, 0 warnings, 0 se=
ction mismatches

---
For more info write to <info@kernelci.org>
