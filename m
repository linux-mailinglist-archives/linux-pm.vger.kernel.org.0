Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6D02454E9A
	for <lists+linux-pm@lfdr.de>; Wed, 17 Nov 2021 21:33:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232076AbhKQUg0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 17 Nov 2021 15:36:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231892AbhKQUg0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 17 Nov 2021 15:36:26 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17DECC061570
        for <linux-pm@vger.kernel.org>; Wed, 17 Nov 2021 12:33:27 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id m24so3197242pls.10
        for <linux-pm@vger.kernel.org>; Wed, 17 Nov 2021 12:33:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=pYZnfL2xxsqqjnwi7xugZx485x+n/X8vprlNdeu4lkA=;
        b=dTMPWurQi1NmhyCqnrBmZ9ggpD75XMRiMTZuPdTVuSO9yC2cqu7queW2UkMa7HrQmL
         9534zDJPDDlKzK/xDgp4xiksIbArSptl3CJ2PZfjL2GXg7Ifm9j1EK6ygAUVV88ue5GL
         itmYkdb8TRoKNQ/FQs4N0eQe7l4RQpt0CqbX+n3nBMmwCS73IvbAiOEh1rdBU+rmlNIk
         cYVd7sOruJCpu3ZAM8K2e24xx8XfO+n8h37vD7lUOKV5lSjA2Qk+TpApeASTVXx7tEva
         KvjL+z+ndHpi3kzLS+uLlgD8sJw4hrDdGYS/hZv77KPCTkEsrnM0kIR5x9/hPmAd0elq
         vlWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=pYZnfL2xxsqqjnwi7xugZx485x+n/X8vprlNdeu4lkA=;
        b=PQFMXGWsldzm8kN34/KPIgXU7gUb3wcns8ELrtwRYGwCaR0cmy/o+SHGetET2+SSY3
         t41K6CCz91lS6T17fhcWGVqs+LZVBrPuRz9LZl6YPXPAW5O1fjEHF7RBWsHZvkaFcLji
         1fSVJdJG+W0l9CyIBwAsykYnnkbckOIHE1pf4WhOsf53CCemyEUm7+Ujh8eRewDc1hDV
         6VG41RGNxQ654IAicY1PkqFTpvG3sMrWtlYa4F805wJKFZg7Ai4bFGEbPIgvvdYQVxWw
         D6nwzF71a9xzcoLvmqp2PEzPBdAivke5Z6wTRCRPbsBYuS63hgJ1bPdr4OEmU/dKFeFW
         EfSg==
X-Gm-Message-State: AOAM530hoyNMsEyh1We4r9kDZZNgLbxubWw8r80VWRAs+FeWLjY/vZS9
        5CqzzuI0AblU14qxPQBHMsbswOROL4pyHDkF
X-Google-Smtp-Source: ABdhPJxcJkuzpg/E6M+nqpzeBl7ZC6dtIW86En5SrthnfM+AugeU3bv8YwoDcnGKKZ64Jp44sDIRbA==
X-Received: by 2002:a17:90a:c403:: with SMTP id i3mr3163859pjt.203.1637181206649;
        Wed, 17 Nov 2021 12:33:26 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id g9sm477322pfj.160.2021.11.17.12.33.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 12:33:26 -0800 (PST)
Message-ID: <61956716.1c69fb81.f7539.2527@mx.google.com>
Date:   Wed, 17 Nov 2021 12:33:26 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v5.16-rc1-14-g3b8bfff0a7ef
X-Kernelci-Report-Type: build
Subject: pm/testing build: 7 builds: 0 failed, 7 passed,
 3 warnings (v5.16-rc1-14-g3b8bfff0a7ef)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 7 builds: 0 failed, 7 passed, 3 warnings (v5.16-rc1-14-g3=
b8bfff0a7ef)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
16-rc1-14-g3b8bfff0a7ef/

Tree: pm
Branch: testing
Git Describe: v5.16-rc1-14-g3b8bfff0a7ef
Git Commit: 3b8bfff0a7efce0592d4260b49b79e45dfcf7e5b
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
Built: 7 unique architectures

Warnings Detected:

arc:

arm64:

arm:

i386:

mips:
    32r2el_defconfig (gcc-10): 3 warnings

riscv:

x86_64:


Warnings summary:

    2    <stdin>:1559:2: warning: #warning syscall futex_waitv not implemen=
ted [-Wcpp]
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
32r2el_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 3 warnings, 0 sec=
tion mismatches

Warnings:
    <stdin>:1559:2: warning: #warning syscall futex_waitv not implemented [=
-Wcpp]
    arch/mips/boot/dts/img/boston.dts:128.19-178.5: Warning (pci_device_reg=
): /pci@14000000/pci2_root@0,0,0: PCI unit address format error, expected "=
0,0"
    <stdin>:1559:2: warning: #warning syscall futex_waitv not implemented [=
-Wcpp]

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
