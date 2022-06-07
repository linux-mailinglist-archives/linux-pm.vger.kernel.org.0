Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60F1D53F34C
	for <lists+linux-pm@lfdr.de>; Tue,  7 Jun 2022 03:22:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232641AbiFGBWf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 6 Jun 2022 21:22:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbiFGBWd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 6 Jun 2022 21:22:33 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D20A36408
        for <linux-pm@vger.kernel.org>; Mon,  6 Jun 2022 18:22:32 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id g186so5524362pgc.1
        for <linux-pm@vger.kernel.org>; Mon, 06 Jun 2022 18:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=zu660xJI+WSDALJvMPwylwZXg9Zr4jSCuQb1dtcYGHA=;
        b=lfmDugkPcX+35FGF1H5blWTxiHlHKzhZ0jpZ2We0PV+3yRLIclA0aonw6D65qADffB
         rfBzoH0O+TPOjf6p6jhVH/Xnv2rzusQb7foIsPLiWD1ZG1lv2f+gkl3kgfCs9kPlX7Ru
         tD5SMR8ysdjqriaPATkgiR60Lyw6/4V91wjb8Tw16z6CR8A0gxFo7lRegSvfUwRG+GFz
         jbqtPwWlSRYzbY7SRYH79E7YNIvTHe13VuPivpaIPKaNWrM5tBVStDF+5MH39eKlgymc
         ecySIGNmMfr+pc+fnrliXVfdmc0OfmJ7W870BQTvWhJdhbAMI6J+ya4cAud/QtdobmuI
         54Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=zu660xJI+WSDALJvMPwylwZXg9Zr4jSCuQb1dtcYGHA=;
        b=Zc4NFfmfnVAJK246wbFCmAyC38chszFFENfvHVKwSgHRGlKZqN8bykw8gfOxhXsAH9
         avD8feQa/BbgO7SCS13gStyO5GZJcwkxJcc6f9gsSUPe7tI6mQO30+vJI4ZUYreECkZv
         Oei3usHuXrhmR4fuo/pN8SzU7p226dSMHjYmD5SNFEokjNPWpBI/HBk5syNnNVHUozh+
         uURutQexSAWQhd2GUZ223UKq1FaxpzzyfLU3kAZclLfcFWDFpZA9LX63fhU2KTbP7y4N
         lymHeSiX/aSBwv5wRHTgYG78mshX04gceJl9A5WpAfHhD7Yxvvxht+vxCbXmLgGxnSEa
         ErPA==
X-Gm-Message-State: AOAM5326aAt1EU6PIcpdVhsJJy9B/akLxpSafO7UUnJi17Bey3lsmzU3
        D/l/YiQ2oFRcmeSEDRzIdghTL1+/wIkEZbBK
X-Google-Smtp-Source: ABdhPJxgbGsoeJNDVi3U7f9TCWJ4t1AmjTcSdWzbbDoQQ2O0qEGapettjRjZpq6MVFXQNmFUeBRNow==
X-Received: by 2002:aa7:9103:0:b0:519:3150:6b3f with SMTP id 3-20020aa79103000000b0051931506b3fmr27113874pfh.67.1654564952206;
        Mon, 06 Jun 2022 18:22:32 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id s194-20020a6377cb000000b003fd1111d73csm8097894pgc.4.2022.06.06.18.22.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 18:22:31 -0700 (PDT)
Message-ID: <629ea857.1c69fb81.6e301.2169@mx.google.com>
Date:   Mon, 06 Jun 2022 18:22:31 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v5.19-rc1-2-g6a8964e282382
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
Subject: pm/testing build: 7 builds: 0 failed, 7 passed,
 1 warning (v5.19-rc1-2-g6a8964e282382)
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

pm/testing build: 7 builds: 0 failed, 7 passed, 1 warning (v5.19-rc1-2-g6a8=
964e282382)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
19-rc1-2-g6a8964e282382/

Tree: pm
Branch: testing
Git Describe: v5.19-rc1-2-g6a8964e282382
Git Commit: 6a8964e282382ab8f2e64355d2ce8eda80e8fe30
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
