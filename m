Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D35274A9E84
	for <lists+linux-pm@lfdr.de>; Fri,  4 Feb 2022 19:01:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236832AbiBDSBN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 4 Feb 2022 13:01:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377297AbiBDSBM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 4 Feb 2022 13:01:12 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2F0FC061714
        for <linux-pm@vger.kernel.org>; Fri,  4 Feb 2022 10:01:12 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id i30so5741066pfk.8
        for <linux-pm@vger.kernel.org>; Fri, 04 Feb 2022 10:01:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=lVXhFQturG0qA2l+H8bkOCeCPmMjt/R4IDlJBWnCOUg=;
        b=nX57dLahC17NnXLTLssATrFrtVGihr52q9hqyFciT5zZjv7ghNFBtKyoEfyxlfiNKy
         b63iR3/Wl+znL30Wh236G6a7q8HXCYmXthj5hPdNhpQQEC81fZQQ9LmeSxkTlXjRz2B9
         kGP/r0A3W5Z4eD1fMmsk0CDUtHJWg23aDXqLI/K8zksfOM22rNcRI9klXwEGILc7Opg3
         LtU1dSq9z9poynRS+NwuPrucxYqV01q/XLrNCeL7tfFqkVHt4Yhsyw8/HcSqNKFzT15V
         skTkmrG4e6b+PfRa0inH9TaugjjOAE6BwAuj/I3sDAG58ifw7CbOjYuQrx61nh7opoMa
         bCTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=lVXhFQturG0qA2l+H8bkOCeCPmMjt/R4IDlJBWnCOUg=;
        b=ZaeLKPBu3ZBCzl3Qg1KIO6zB7QXHfeI586no4B2KxHSSMA7hxpe/TPyEM5e7jsbf9F
         tAvcWS5R4zPHnDNo7aR3Tj1hHXEI4PptfjCPXCek34yc1oSWvj0i5oRCEfmVx7oQXvBT
         lBvHCn2nER0jpUvJ2OxP/xZyIWl14Ej/mcjP4S/gyo6LHjF1jRa3WQkobOGCN2nCgANC
         f1Td9i6Dyx7E//9ejqzASYA806PSPg8HEQOPs5bdzj6eOQn9OZ0m5SbrxG8PQEEoKkjA
         oO33QwlEHJAmajv5V+glZqj67UIZqFwvA1qW00wM3s3Z5kH+lwMoJ7ZmQUaGQcFVUCPp
         1KXA==
X-Gm-Message-State: AOAM5309jQFClU4jEEOuhqfR4T3sy9OE1c2zepHEmhLKvDP+jupdmIRj
        jeCSl0LKOqob/XQ3mLmUhvCsSw==
X-Google-Smtp-Source: ABdhPJwducmVxqLiF9wUZgLmF3k0KYuYhJjrsIZz2AekpOhrE1M8SULHdLwoPGAsqrpf97Yltynw3w==
X-Received: by 2002:a63:87c3:: with SMTP id i186mr128759pge.311.1643997672119;
        Fri, 04 Feb 2022 10:01:12 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id f12sm2257672pgg.35.2022.02.04.10.01.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 10:01:11 -0800 (PST)
Message-ID: <61fd69e7.1c69fb81.497b3.5f17@mx.google.com>
Date:   Fri, 04 Feb 2022 10:01:11 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: acpi-5.17-rc3-15-g08615cb8c0e1
X-Kernelci-Tree: pm
X-Kernelci-Report-Type: build
X-Kernelci-Branch: testing
Subject: pm/testing build: 7 builds: 0 failed, 7 passed,
 41 warnings (acpi-5.17-rc3-15-g08615cb8c0e1)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 7 builds: 0 failed, 7 passed, 41 warnings (acpi-5.17-rc3-=
15-g08615cb8c0e1)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/acp=
i-5.17-rc3-15-g08615cb8c0e1/

Tree: pm
Branch: testing
Git Describe: acpi-5.17-rc3-15-g08615cb8c0e1
Git Commit: 08615cb8c0e1deeca5489d672213fb205fa53c3b
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
Built: 7 unique architectures

Warnings Detected:

arc:

arm64:
    defconfig (gcc-10): 17 warnings

arm:
    multi_v7_defconfig (gcc-10): 13 warnings

i386:
    i386_defconfig (gcc-10): 5 warnings

mips:
    32r2el_defconfig (gcc-10): 1 warning

riscv:

x86_64:
    x86_64_defconfig (gcc-10): 5 warnings


Warnings summary:

    33   drivers/thermal/thermal_netlink.h:113:71: warning: =E2=80=98struct=
 cpu_capability=E2=80=99 declared inside parameter list will not be visible=
 outside of this definition or declaration
    3    drivers/thermal/tegra/../thermal_netlink.h:113:71: warning: =E2=80=
=98struct cpu_capability=E2=80=99 declared inside parameter list will not b=
e visible outside of this definition or declaration
    2    drivers/thermal/samsung/../thermal_netlink.h:113:71: warning: =E2=
=80=98struct cpu_capability=E2=80=99 declared inside parameter list will no=
t be visible outside of this definition or declaration
    1    drivers/thermal/st/../thermal_netlink.h:113:71: warning: =E2=80=98=
struct cpu_capability=E2=80=99 declared inside parameter list will not be v=
isible outside of this definition or declaration
    1    drivers/thermal/qcom/../thermal_netlink.h:113:71: warning: =E2=80=
=98struct cpu_capability=E2=80=99 declared inside parameter list will not b=
e visible outside of this definition or declaration
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
defconfig (arm64, gcc-10) =E2=80=94 PASS, 0 errors, 17 warnings, 0 section =
mismatches

Warnings:
    drivers/thermal/samsung/../thermal_netlink.h:113:71: warning: =E2=80=98=
struct cpu_capability=E2=80=99 declared inside parameter list will not be v=
isible outside of this definition or declaration
    drivers/thermal/thermal_netlink.h:113:71: warning: =E2=80=98struct cpu_=
capability=E2=80=99 declared inside parameter list will not be visible outs=
ide of this definition or declaration
    drivers/thermal/thermal_netlink.h:113:71: warning: =E2=80=98struct cpu_=
capability=E2=80=99 declared inside parameter list will not be visible outs=
ide of this definition or declaration
    drivers/thermal/thermal_netlink.h:113:71: warning: =E2=80=98struct cpu_=
capability=E2=80=99 declared inside parameter list will not be visible outs=
ide of this definition or declaration
    drivers/thermal/thermal_netlink.h:113:71: warning: =E2=80=98struct cpu_=
capability=E2=80=99 declared inside parameter list will not be visible outs=
ide of this definition or declaration
    drivers/thermal/thermal_netlink.h:113:71: warning: =E2=80=98struct cpu_=
capability=E2=80=99 declared inside parameter list will not be visible outs=
ide of this definition or declaration
    drivers/thermal/thermal_netlink.h:113:71: warning: =E2=80=98struct cpu_=
capability=E2=80=99 declared inside parameter list will not be visible outs=
ide of this definition or declaration
    drivers/thermal/thermal_netlink.h:113:71: warning: =E2=80=98struct cpu_=
capability=E2=80=99 declared inside parameter list will not be visible outs=
ide of this definition or declaration
    drivers/thermal/thermal_netlink.h:113:71: warning: =E2=80=98struct cpu_=
capability=E2=80=99 declared inside parameter list will not be visible outs=
ide of this definition or declaration
    drivers/thermal/thermal_netlink.h:113:71: warning: =E2=80=98struct cpu_=
capability=E2=80=99 declared inside parameter list will not be visible outs=
ide of this definition or declaration
    drivers/thermal/thermal_netlink.h:113:71: warning: =E2=80=98struct cpu_=
capability=E2=80=99 declared inside parameter list will not be visible outs=
ide of this definition or declaration
    drivers/thermal/thermal_netlink.h:113:71: warning: =E2=80=98struct cpu_=
capability=E2=80=99 declared inside parameter list will not be visible outs=
ide of this definition or declaration
    drivers/thermal/qcom/../thermal_netlink.h:113:71: warning: =E2=80=98str=
uct cpu_capability=E2=80=99 declared inside parameter list will not be visi=
ble outside of this definition or declaration
    drivers/thermal/tegra/../thermal_netlink.h:113:71: warning: =E2=80=98st=
ruct cpu_capability=E2=80=99 declared inside parameter list will not be vis=
ible outside of this definition or declaration
    drivers/thermal/thermal_netlink.h:113:71: warning: =E2=80=98struct cpu_=
capability=E2=80=99 declared inside parameter list will not be visible outs=
ide of this definition or declaration
    drivers/thermal/thermal_netlink.h:113:71: warning: =E2=80=98struct cpu_=
capability=E2=80=99 declared inside parameter list will not be visible outs=
ide of this definition or declaration
    drivers/thermal/thermal_netlink.h:113:71: warning: =E2=80=98struct cpu_=
capability=E2=80=99 declared inside parameter list will not be visible outs=
ide of this definition or declaration

---------------------------------------------------------------------------=
-----
haps_hs_smp_defconfig (arc, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0=
 section mismatches

---------------------------------------------------------------------------=
-----
i386_defconfig (i386, gcc-10) =E2=80=94 PASS, 0 errors, 5 warnings, 0 secti=
on mismatches

Warnings:
    drivers/thermal/thermal_netlink.h:113:71: warning: =E2=80=98struct cpu_=
capability=E2=80=99 declared inside parameter list will not be visible outs=
ide of this definition or declaration
    drivers/thermal/thermal_netlink.h:113:71: warning: =E2=80=98struct cpu_=
capability=E2=80=99 declared inside parameter list will not be visible outs=
ide of this definition or declaration
    drivers/thermal/thermal_netlink.h:113:71: warning: =E2=80=98struct cpu_=
capability=E2=80=99 declared inside parameter list will not be visible outs=
ide of this definition or declaration
    drivers/thermal/thermal_netlink.h:113:71: warning: =E2=80=98struct cpu_=
capability=E2=80=99 declared inside parameter list will not be visible outs=
ide of this definition or declaration
    drivers/thermal/thermal_netlink.h:113:71: warning: =E2=80=98struct cpu_=
capability=E2=80=99 declared inside parameter list will not be visible outs=
ide of this definition or declaration

---------------------------------------------------------------------------=
-----
multi_v7_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 13 warnings, 0 s=
ection mismatches

Warnings:
    drivers/thermal/samsung/../thermal_netlink.h:113:71: warning: =E2=80=98=
struct cpu_capability=E2=80=99 declared inside parameter list will not be v=
isible outside of this definition or declaration
    drivers/thermal/st/../thermal_netlink.h:113:71: warning: =E2=80=98struc=
t cpu_capability=E2=80=99 declared inside parameter list will not be visibl=
e outside of this definition or declaration
    drivers/thermal/thermal_netlink.h:113:71: warning: =E2=80=98struct cpu_=
capability=E2=80=99 declared inside parameter list will not be visible outs=
ide of this definition or declaration
    drivers/thermal/thermal_netlink.h:113:71: warning: =E2=80=98struct cpu_=
capability=E2=80=99 declared inside parameter list will not be visible outs=
ide of this definition or declaration
    drivers/thermal/thermal_netlink.h:113:71: warning: =E2=80=98struct cpu_=
capability=E2=80=99 declared inside parameter list will not be visible outs=
ide of this definition or declaration
    drivers/thermal/thermal_netlink.h:113:71: warning: =E2=80=98struct cpu_=
capability=E2=80=99 declared inside parameter list will not be visible outs=
ide of this definition or declaration
    drivers/thermal/thermal_netlink.h:113:71: warning: =E2=80=98struct cpu_=
capability=E2=80=99 declared inside parameter list will not be visible outs=
ide of this definition or declaration
    drivers/thermal/thermal_netlink.h:113:71: warning: =E2=80=98struct cpu_=
capability=E2=80=99 declared inside parameter list will not be visible outs=
ide of this definition or declaration
    drivers/thermal/thermal_netlink.h:113:71: warning: =E2=80=98struct cpu_=
capability=E2=80=99 declared inside parameter list will not be visible outs=
ide of this definition or declaration
    drivers/thermal/thermal_netlink.h:113:71: warning: =E2=80=98struct cpu_=
capability=E2=80=99 declared inside parameter list will not be visible outs=
ide of this definition or declaration
    drivers/thermal/thermal_netlink.h:113:71: warning: =E2=80=98struct cpu_=
capability=E2=80=99 declared inside parameter list will not be visible outs=
ide of this definition or declaration
    drivers/thermal/tegra/../thermal_netlink.h:113:71: warning: =E2=80=98st=
ruct cpu_capability=E2=80=99 declared inside parameter list will not be vis=
ible outside of this definition or declaration
    drivers/thermal/tegra/../thermal_netlink.h:113:71: warning: =E2=80=98st=
ruct cpu_capability=E2=80=99 declared inside parameter list will not be vis=
ible outside of this definition or declaration

---------------------------------------------------------------------------=
-----
x86_64_defconfig (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 5 warnings, 0 s=
ection mismatches

Warnings:
    drivers/thermal/thermal_netlink.h:113:71: warning: =E2=80=98struct cpu_=
capability=E2=80=99 declared inside parameter list will not be visible outs=
ide of this definition or declaration
    drivers/thermal/thermal_netlink.h:113:71: warning: =E2=80=98struct cpu_=
capability=E2=80=99 declared inside parameter list will not be visible outs=
ide of this definition or declaration
    drivers/thermal/thermal_netlink.h:113:71: warning: =E2=80=98struct cpu_=
capability=E2=80=99 declared inside parameter list will not be visible outs=
ide of this definition or declaration
    drivers/thermal/thermal_netlink.h:113:71: warning: =E2=80=98struct cpu_=
capability=E2=80=99 declared inside parameter list will not be visible outs=
ide of this definition or declaration
    drivers/thermal/thermal_netlink.h:113:71: warning: =E2=80=98struct cpu_=
capability=E2=80=99 declared inside parameter list will not be visible outs=
ide of this definition or declaration

---
For more info write to <info@kernelci.org>
