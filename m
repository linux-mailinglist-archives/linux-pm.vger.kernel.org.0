Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69A514DE0C5
	for <lists+linux-pm@lfdr.de>; Fri, 18 Mar 2022 19:07:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240032AbiCRSI6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 18 Mar 2022 14:08:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240044AbiCRSI4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 18 Mar 2022 14:08:56 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77BA32EDC0C
        for <linux-pm@vger.kernel.org>; Fri, 18 Mar 2022 11:07:36 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id h5so7575845plf.7
        for <linux-pm@vger.kernel.org>; Fri, 18 Mar 2022 11:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=+pC4HBZfdIoJVQ2R2+fitO3uhQ+SNNKUUeZOg4vz/PY=;
        b=iUnZMlQNcwSVVFUVosg6BUK2m8hbiFhWhNlmJlIlCDntbR33kZecbjhPHqxaUOrIxk
         Khb0JaDkSYuqcmbpXgsXkpaLydFa+9R+2c1jWoV0KiFz6DwL2BmEN4vQa9A3EnOYKbPL
         dEdtitNIQ8DaaJfqRfyYt4V9H7SEeomRExLRgluLd0VG7bB7E6uicZvzD1vDPdMUfcpU
         lbtI6f6lT1l+q23If58ZiNh5cTnb8qj+Yrq0ymBzvgvPkwkrBHv202eNCpa3EaNkwsQZ
         0ia/6jCHWSisdkV3qDg89V7x7/64JrUQe0ndIY/DzUTPv9cf8bwyV/IXoR4VtKHgh0wG
         5d5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=+pC4HBZfdIoJVQ2R2+fitO3uhQ+SNNKUUeZOg4vz/PY=;
        b=aWRs47nFUeA70psdBrsx+mUKvuWxin0w0OWixynxk/IPFhC2VjrkC+7M1myI7Mseoq
         kV1PmTSwz4xQ7Lw3kCQoldiaOoOX8dyYFkVFBnXSHIvi3D59MqG8SdcvbsjqgJUTKGJh
         hb7Zd+eP83S+W0Uw0JNO6uQG6p/a80/iSqFHdROQglMFzGvB74jRL5zcY2t7yzY7fVH6
         DyX9dvraFonF0PTekkN957Cf4hNJJSzIP8FszXcuis2ok2SND/cktU+k8eWTmVs/p5zu
         mzkkbtpMJXvV0PhMfdZ+iFfiZEmgqdakNNROJEu+jiZIiEsV2XrWhZi2VaTlLrg+CswT
         lxFw==
X-Gm-Message-State: AOAM530FXk+YIK8dBklC4vMSLqO5+dhsfzzYoBn2uqTHn6ghcUIwLEY2
        JTXLjmZ87zwynTp5ILbi4APtYQ==
X-Google-Smtp-Source: ABdhPJxl8tyRNTPpk2u2FZIlJqSAvDMsYwpJfBb7a0LFDsFUnmv7HfuYn/ByGAS7H13pLNPF93urcg==
X-Received: by 2002:a17:90b:3ece:b0:1bf:841e:930b with SMTP id rm14-20020a17090b3ece00b001bf841e930bmr22634079pjb.212.1647626855941;
        Fri, 18 Mar 2022 11:07:35 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id on15-20020a17090b1d0f00b001bfa3e36086sm13425152pjb.54.2022.03.18.11.07.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Mar 2022 11:07:35 -0700 (PDT)
Message-ID: <6234ca67.1c69fb81.e8dc7.2e3d@mx.google.com>
Date:   Fri, 18 Mar 2022 11:07:35 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: acpi-5.17-rc9-173-g4560f59dc554
X-Kernelci-Report-Type: build
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
Subject: pm/testing build: 7 builds: 0 failed, 7 passed,
 1 warning (acpi-5.17-rc9-173-g4560f59dc554)
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

pm/testing build: 7 builds: 0 failed, 7 passed, 1 warning (acpi-5.17-rc9-17=
3-g4560f59dc554)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/acp=
i-5.17-rc9-173-g4560f59dc554/

Tree: pm
Branch: testing
Git Describe: acpi-5.17-rc9-173-g4560f59dc554
Git Commit: 4560f59dc55401a9b00f450ae7d97f9dfa916d74
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
