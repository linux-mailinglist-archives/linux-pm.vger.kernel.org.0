Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 648A74CDEBC
	for <lists+linux-pm@lfdr.de>; Fri,  4 Mar 2022 21:26:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbiCDUJ3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 4 Mar 2022 15:09:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231289AbiCDUIA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 4 Mar 2022 15:08:00 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3CA526F67E
        for <linux-pm@vger.kernel.org>; Fri,  4 Mar 2022 12:02:29 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id g1so8490232pfv.1
        for <linux-pm@vger.kernel.org>; Fri, 04 Mar 2022 12:02:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=0Ln32sfHU6BUNoembv2HmltrGK4AIEBMq0l3u4f7pRI=;
        b=vx3D8ScKGO5/TZcRnKV42xZQnxIfgbVZhpbkaP+jE54N3dyXNJkI2pHnv5JE7Cdi0S
         pLs/f2eA6uqlpjMaVGxJjDAV9gEZPWG/RM3gfoHoYmPXGhqtCmLoDnUJz6gGVXuqQAPI
         DGu08mMDQZzUO4UYBXWhLXqoGP2XXhztGvWHZfBN/++V6EhKk/NWd+2Cs+FPaa0d6E9a
         YypY80i9gcjOgrubo6K4ToNTC9cAkCVwu5LxFmXvsZ17pF9lV9joMYcmHG4RKfgwsdVS
         2AsHw7w82I3UeatkYQGK2TGiBkf5tuEqrYtResQcybjmJTdHM9VQLUJOFsHJKh2xyF/8
         GzHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=0Ln32sfHU6BUNoembv2HmltrGK4AIEBMq0l3u4f7pRI=;
        b=YCcQRJLvmb7R7fC7tmqaMekXFgyng5nsy32mCem38K6ieqV429xUhmFtMBBBmMSmCh
         B3U1pk5+bBZAMzFYUIGax5A/ZTeYSaF06KCCR2INm/MWfY1wDUcWYpgTK7pk+pWHTpay
         Cv35CWLnuUX+4STh9cCQ8IdoRzWB/ZQeIRA/122MZ9OEf4MUTf+2TqkcT8vlK4g+34eh
         wh31v5EKR7RRkv1Jy22Bn7b/XgCGPQC1MEofhYnGL+EEb5V0Urktp+a2nZZPflg+xRHy
         MOxi6sHAVgxREtV9a3nldowhnYz4mOkU9TP2x1u2KyLaYwVmzuL/vqjUT4s7u9qYwF7u
         3ydg==
X-Gm-Message-State: AOAM533KI5Do91f6AEpwgkiRGLEEDGsYqhBnrZaW0rU8wlkGNbR5UTam
        v8XnmHKjC44mgi9/gkDis6diulG7zIvSmYN5BVI=
X-Google-Smtp-Source: ABdhPJyLvgTns0Ik1YJo2BMS1Ddk+6TPxEV3MqoEXQqvfhmIKsiDCKRm0NhX4U1wP4YV/PfKdytL2w==
X-Received: by 2002:a05:6a00:2485:b0:4f6:b5c5:ee8e with SMTP id c5-20020a056a00248500b004f6b5c5ee8emr347587pfv.21.1646424089995;
        Fri, 04 Mar 2022 12:01:29 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id p28-20020a056a000a1c00b004f6519e61b7sm7237588pfh.21.2022.03.04.12.01.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 12:01:29 -0800 (PST)
Message-ID: <62227019.1c69fb81.d4b58.3df9@mx.google.com>
Date:   Fri, 04 Mar 2022 12:01:29 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
X-Kernelci-Kernel: thermal-5.17-rc7-127-g87852f90dc5a
Subject: pm/testing build: 7 builds: 0 failed, 7 passed,
 1 warning (thermal-5.17-rc7-127-g87852f90dc5a)
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

pm/testing build: 7 builds: 0 failed, 7 passed, 1 warning (thermal-5.17-rc7=
-127-g87852f90dc5a)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/the=
rmal-5.17-rc7-127-g87852f90dc5a/

Tree: pm
Branch: testing
Git Describe: thermal-5.17-rc7-127-g87852f90dc5a
Git Commit: 87852f90dc5a429bfc19d3d0f909f00fda55a0f0
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
