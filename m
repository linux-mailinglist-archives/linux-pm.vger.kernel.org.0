Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D862463B266
	for <lists+linux-pm@lfdr.de>; Mon, 28 Nov 2022 20:38:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233666AbiK1Ti6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 28 Nov 2022 14:38:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233652AbiK1Ti5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 28 Nov 2022 14:38:57 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7A9325296
        for <linux-pm@vger.kernel.org>; Mon, 28 Nov 2022 11:38:56 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id w37so5720520pga.5
        for <linux-pm@vger.kernel.org>; Mon, 28 Nov 2022 11:38:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wPzmsECpWTLQDu+6fp8RIE8LB+MbjYxSbHfiJcH+2TU=;
        b=rvWGqRFJNSaPhzBGyWCMJjzktGB14wCDnTi8IXy1dnTJxQ/D3dZamRmWvpyLVxIA5X
         VeHK83DxpT4qq/ECXVSWFsTvYCdiFq04q3TSaCNiYGsw0XbG54OEfjpuhPrxBZZZhLub
         Dk/A2yR2Rp4raIsexyik1UoMr1aB7uI031+akP5Tlzz066AlinYEtsJ1eVGG2Ah7Li2C
         0cfJQyki67Xz5etCtFxqC7pb0JOadI6ZrlIVxreT0VbtdLE9shBKXCE75JofK/SpE7IM
         dLR6vkfyaSt0Ef+rJZEVMRkYUxEWHlDKhYN8uhjz+XsNsro3NHfT9ymTnz4hi2j0Kyf7
         yT3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wPzmsECpWTLQDu+6fp8RIE8LB+MbjYxSbHfiJcH+2TU=;
        b=KkUzPVaiuO/XgVLkJMlB8qsptqFOEadNIi8iZg8Pf75ErAhkrciYWna7qD15BglGMf
         7PQwKmbTh8rWlFiuPLh9XHr9JMWaFTkqkCw1xCOWwTq6JiqpqUnS8P8ay7Fa9ZwlX+Wj
         Y7MvkrbN62dC3s69wEvsppnRRIzJuoCGDfop2OuuIBSqp87eaA84DW0sslNvc8TkW9LD
         ih/1GHo5hOsziSMhxhOJcpC5mlINeoCY28k5gkaFK/hw1fpZp4Jd0wE9TmYTMV1wFCtu
         kQSIFfKlBDXhGbdIw8lpHtMZc0EJK4ww+lFyFRHhGssBQF26yGAje7vrz/0nrvNIATZc
         8PyQ==
X-Gm-Message-State: ANoB5pnYbIv1bMDpPe/HFKxGGGDn5pFEGPPcz6dyq4mfSF4j8bGayNYy
        J9JdvhCtrWW5LyOiFXmwYu0DBg==
X-Google-Smtp-Source: AA0mqf6UhOK8fli0+TWiNx4AyIEN5omQE8py/axypbBURaEWOBIjLSTmsjjnU1llrylDdk+o3dq/dA==
X-Received: by 2002:a63:d14f:0:b0:476:95a8:de78 with SMTP id c15-20020a63d14f000000b0047695a8de78mr32663401pgj.66.1669664336415;
        Mon, 28 Nov 2022 11:38:56 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id p68-20020a625b47000000b0057555d35f79sm1338268pfb.101.2022.11.28.11.38.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 11:38:55 -0800 (PST)
Message-ID: <63850e4f.620a0220.81446.2ba1@mx.google.com>
Date:   Mon, 28 Nov 2022 11:38:55 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Kernel: v6.1-rc7-96-gdee69e7005ce
X-Kernelci-Report-Type: build
X-Kernelci-Tree: pm
Subject: pm/testing build: 8 builds: 0 failed, 8 passed,
 5 warnings (v6.1-rc7-96-gdee69e7005ce)
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

pm/testing build: 8 builds: 0 failed, 8 passed, 5 warnings (v6.1-rc7-96-gde=
e69e7005ce)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v6.=
1-rc7-96-gdee69e7005ce/

Tree: pm
Branch: testing
Git Describe: v6.1-rc7-96-gdee69e7005ce
Git Commit: dee69e7005ce309e619155eb6372f287212e27f7
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
