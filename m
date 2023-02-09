Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CE266912CC
	for <lists+linux-pm@lfdr.de>; Thu,  9 Feb 2023 22:52:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbjBIVwW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 9 Feb 2023 16:52:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbjBIVwV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 9 Feb 2023 16:52:21 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F6736310B
        for <linux-pm@vger.kernel.org>; Thu,  9 Feb 2023 13:52:20 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id n2so2289350pfo.3
        for <linux-pm@vger.kernel.org>; Thu, 09 Feb 2023 13:52:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=FWTOyz2CLbQ/zey1DyekquaFYsUKvJK0C5giEgiFGNU=;
        b=jI8PdoiYbLnAMDnfDaxzpv+tQXQBTmzGteGkNsEdv5Kiit8Dlb2olIPFiOYJA+Ca6e
         shKdnokgDKVFYs2lpqVWaSHAd6RZpldx9KqpW0eYVH/EFFtr1Z0Zf3Y5M2SvCOWwTl82
         vLi9tcHUUh4jFoacGwPIx4bNYI3OFagQ1AT8bbbyPUmSwlgNeqGNtJzJcVP+5QBeBU6I
         pDoaHbpVNjnY8W53yHoG5lz1xjpLj3BzooSR7uLqKPCeWz0hA+I9EuocOmcYnXEFeMIE
         ssgv0K0fo0WHZkddd9B4EWwjovBoZQJk0LruVlq7rEHQli4k8hofRUVg3zaEw9gLRnvc
         L8dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FWTOyz2CLbQ/zey1DyekquaFYsUKvJK0C5giEgiFGNU=;
        b=BXdaBoRi9awF0P02JkLDHnN2pbRn9jQL+21wSfkl2/fP9cIs3I2pv8hX26JfHQ74vC
         EFDtFraxkLImahh6gDo41uTY5iDpWqzlO1u1uHUHZAATQ9YKnlnUaE/28gtu4xmFsByC
         Bm2GuJl8DGcaKTfhS/79pvy8XzO6yDx0UdiuA7OcnNkXebB3BZFxe1ujYHYZ9oRUxb4g
         d2BHV/PknctHliFi0P5aOLDCsbYmRPlDN6/eWUgwsXPLO2+VgwULGQxeOAu/k0VSLyVo
         nPKXDSURs+u0Y6QAOzi9OF8GsHfObbrZbudwS16Aiv4R2QsT8eWvgLU5S64OtwQTLl21
         4XFw==
X-Gm-Message-State: AO0yUKUtWrhw6Q2uoTmIRysoV+PQ4nHAnlnqSY/mmPsCdu496xdXp4oG
        yH46H8GKu4Y30fFE6PnA/FTXNA==
X-Google-Smtp-Source: AK7set/lezCgC9/ut+3UZcLrYGUERnFaV2+wgidfqFDQ+JNIjHos06K6ViluzKEswUaNRHQIEKlVKw==
X-Received: by 2002:a62:646:0:b0:5a8:513f:233d with SMTP id 67-20020a620646000000b005a8513f233dmr3708206pfg.23.1675979540161;
        Thu, 09 Feb 2023 13:52:20 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id f5-20020aa78b05000000b005a8512c9988sm1962220pfd.93.2023.02.09.13.52.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 13:52:19 -0800 (PST)
Message-ID: <63e56b13.a70a0220.9ac51.377d@mx.google.com>
Date:   Thu, 09 Feb 2023 13:52:19 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: pm-6.2-rc8-185-g61b7614c114c
X-Kernelci-Report-Type: build
Subject: pm/testing build: 8 builds: 0 failed, 8 passed,
 5 warnings (pm-6.2-rc8-185-g61b7614c114c)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 8 builds: 0 failed, 8 passed, 5 warnings (pm-6.2-rc8-185-=
g61b7614c114c)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/pm-=
6.2-rc8-185-g61b7614c114c/

Tree: pm
Branch: testing
Git Describe: pm-6.2-rc8-185-g61b7614c114c
Git Commit: 61b7614c114c817f9f326282c2f7a728bf0051a8
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
Built: 8 unique architectures

Warnings Detected:

arc:

arm64:

arm:

i386:

mips:
    32r2el_defconfig (gcc-10): 1 warning

riscv:

sparc:
    sparc64_defconfig (gcc-10): 4 warnings

x86_64:


Warnings summary:

    2    WARNING: modpost: EXPORT symbol "_mcount" [vmlinux] version genera=
tion failed, symbol will not be versioned.
    2    <stdin>:1517:2: warning: #warning syscall clone3 not implemented [=
-Wcpp]
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
sparc64_defconfig (sparc, gcc-10) =E2=80=94 PASS, 0 errors, 4 warnings, 0 s=
ection mismatches

Warnings:
    <stdin>:1517:2: warning: #warning syscall clone3 not implemented [-Wcpp]
    WARNING: modpost: EXPORT symbol "_mcount" [vmlinux] version generation =
failed, symbol will not be versioned.
    <stdin>:1517:2: warning: #warning syscall clone3 not implemented [-Wcpp]
    WARNING: modpost: EXPORT symbol "_mcount" [vmlinux] version generation =
failed, symbol will not be versioned.

---------------------------------------------------------------------------=
-----
x86_64_defconfig (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 s=
ection mismatches

---
For more info write to <info@kernelci.org>
