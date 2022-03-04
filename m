Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C45E4CCF49
	for <lists+linux-pm@lfdr.de>; Fri,  4 Mar 2022 08:52:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236903AbiCDHwp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 4 Mar 2022 02:52:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236579AbiCDHwo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 4 Mar 2022 02:52:44 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21401194156
        for <linux-pm@vger.kernel.org>; Thu,  3 Mar 2022 23:51:54 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id t19so3482987plr.5
        for <linux-pm@vger.kernel.org>; Thu, 03 Mar 2022 23:51:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=osndf1nmJuCHWBExkawVSUdoerXS+4FULBI02/OJEpU=;
        b=j+PIojWRlvcx3q+vmXA5hucF1bhy4eNjunNsR75ll5LSU6ixcQfQB429kRBKS0bpDA
         sCWI2O6K6ustk+7Myq09RLr5vnORcW4/O44bdBYR4IyNvylgV8yf8yspVe0kdpZIFh47
         W+9IQyQCMQkSYgyUO6ti9WqXteYKkUeSLhfAREsi0VRArnTBo/apF0ltd/ptkrHrrBYU
         +en0AJyJ4qwmPBHJrI7wb/qFqYbtWZKhnU6k47Q4KrEPfvCZQxXbeeIGJwDAdOlE5kEb
         de7jod3O4ABWd8FZ7ZiVYKbFVWMLdk5nC8zE6iXYx2RawOFs/HTeSy/w9RmmV2hLjGri
         dddQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=osndf1nmJuCHWBExkawVSUdoerXS+4FULBI02/OJEpU=;
        b=2c9Mazr8QZf4dXfQojE/YVUIerueoK5/KSeC7IGfNmZRCdWxlakxDYEqDcwFZjzDGm
         cYKeMHqVKOT4F3LuNGnbWdyOW7V2028j9IZOSL6jcZeBAdWM4vKC77H39HsHLyovhkO/
         E+TZYCifWP+ugalhYeGpc+X4FGL9JfaxbaydKUQHcz7k27fhoVp4heX+/M2aVn/jQrS+
         8RXyCeFiHJ+KC6d7JgsMsF4ljmDgv5KzEn8MInyRd6jRbGsgDm589kvsabq5qKZtS454
         DFGqZAnC5btVMtIHp/U4mPgcS+hzXShag6Vl86CiweON24JGxB10q4zWg52Kynl2sdUr
         0kXg==
X-Gm-Message-State: AOAM532da3SXHUZb0hRewmj5mxIIPSRnGU9P+98nyQATFTDJHQoMEVgE
        628X2Ub4y1htcqd1LbPZyNujhYt0e2s64zYTTlM=
X-Google-Smtp-Source: ABdhPJzzgbP9w9WLi1SCAheQgswhZYj2zOOXE0VX+RJvsVi5jnUaKrX7r6vybr/O9DrzEx19gynqbg==
X-Received: by 2002:a17:902:ce8c:b0:151:8c12:2ce3 with SMTP id f12-20020a170902ce8c00b001518c122ce3mr15441995plg.135.1646380313618;
        Thu, 03 Mar 2022 23:51:53 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id bd35-20020a056a0027a300b004f63bca32e7sm4195108pfb.208.2022.03.03.23.51.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 23:51:53 -0800 (PST)
Message-ID: <6221c519.1c69fb81.8e1a.bebf@mx.google.com>
Date:   Thu, 03 Mar 2022 23:51:53 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
X-Kernelci-Kernel: v5.17-rc6-115-g7c2ca3c76b25
Subject: pm/testing build: 7 builds: 0 failed, 7 passed,
 1 warning (v5.17-rc6-115-g7c2ca3c76b25)
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

pm/testing build: 7 builds: 0 failed, 7 passed, 1 warning (v5.17-rc6-115-g7=
c2ca3c76b25)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
17-rc6-115-g7c2ca3c76b25/

Tree: pm
Branch: testing
Git Describe: v5.17-rc6-115-g7c2ca3c76b25
Git Commit: 7c2ca3c76b25e3d304c689a75025f4ba28746543
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
