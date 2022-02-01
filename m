Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D7C74A55A7
	for <lists+linux-pm@lfdr.de>; Tue,  1 Feb 2022 04:34:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233170AbiBADeH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 31 Jan 2022 22:34:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233146AbiBADeH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 31 Jan 2022 22:34:07 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8467AC061714
        for <linux-pm@vger.kernel.org>; Mon, 31 Jan 2022 19:34:06 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id i30so14647352pfk.8
        for <linux-pm@vger.kernel.org>; Mon, 31 Jan 2022 19:34:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=oe167xSYsLXLJ8Fk/LtiS2O4zDS4xbHpv6ZxTGoK2W4=;
        b=Uvcu7q43WHYOs0XPmru3jYqDI6QT7iOKRfDx4wt71oKHmtAhQR7EsFJBwsZRpWaDKm
         9lLE/a6CDXHS/M0RNChPo2vc2PXDLT0YWTy2mkBVH8Twsyh133Q10H7uVnznG/F0nhJL
         BVgBfb733klef+326oukXQ0lL+Ww5VEIBDQwhFPCqTSuuMbAyS6ASmDaDGd1kqL5Z7YQ
         6lv8TWf75liauHI6xBQJK2Tw3Qf3HFghus0aFZHtm1DbzsOanH/ztWsNpvRTc6PWonRX
         4UFT6qali5VGdV0crPZEkBVOifjOEJ/ElSle66zLVhthnyj08uYJR/wb3lwhZE/+zfXp
         gJBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=oe167xSYsLXLJ8Fk/LtiS2O4zDS4xbHpv6ZxTGoK2W4=;
        b=4+L94ZQ6Ei2I9N+vhVp/fnzS2YWe4zE5c8fGq/8wZUgEvlvuDX+0nHxLzUWr6HwPvl
         T5xcYUIe4zpxk6czPcziosXYwrxnDTeojUI6B3qX8mif79OB+Xkb/AI5ps5cdHw6+omq
         nfwMG/jh0UVsMnWD9r0qgw462fyWpeSvgwtICTkDpteKbux0gg43aaAuVBQdnHbUIVDD
         bReID94lkYnuJcGF/Qx5YD7rOIf0uacXBDkZelGolML9DDLsbrXJAtPoS0ncJ4dwLeKQ
         d4yi9O+1SoDRTEHzbphDyo/UTfCq3c0c/DrV9FQept3SF7R5cIVksM32N6B0r8sS85fW
         cBKw==
X-Gm-Message-State: AOAM532BbW5d0C/kihii4F6fSu994uhKl0e/62TA2Es9D5eK0hPJ3ocP
        wSthpRxjbNxJjLMmLX1FiFis+g==
X-Google-Smtp-Source: ABdhPJx5RS0spByt4Atbaw3sVXdXPNcunWrd5w0eadcDQLH1k8ojPRXfY1KPKXoQb0KSv2R8IdbTbg==
X-Received: by 2002:a63:dd4d:: with SMTP id g13mr19311878pgj.202.1643686446070;
        Mon, 31 Jan 2022 19:34:06 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id o5sm20307946pfk.172.2022.01.31.19.34.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 19:34:05 -0800 (PST)
Message-ID: <61f8aa2d.1c69fb81.cf1c.7a37@mx.google.com>
Date:   Mon, 31 Jan 2022 19:34:05 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.17-rc2-6-g601753a2ad1e
X-Kernelci-Tree: pm
X-Kernelci-Report-Type: build
X-Kernelci-Branch: testing
Subject: pm/testing build: 7 builds: 0 failed, 7 passed,
 1 warning (v5.17-rc2-6-g601753a2ad1e)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 7 builds: 0 failed, 7 passed, 1 warning (v5.17-rc2-6-g601=
753a2ad1e)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
17-rc2-6-g601753a2ad1e/

Tree: pm
Branch: testing
Git Describe: v5.17-rc2-6-g601753a2ad1e
Git Commit: 601753a2ad1e94e6d9498c8faefbae61275d045f
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
defconfig (arm64, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section m=
ismatches

---------------------------------------------------------------------------=
-----
defconfig (riscv, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section m=
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
