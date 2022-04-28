Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE497513C1F
	for <lists+linux-pm@lfdr.de>; Thu, 28 Apr 2022 21:34:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234019AbiD1Th6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 28 Apr 2022 15:37:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231975AbiD1Th5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 28 Apr 2022 15:37:57 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A0565AED6
        for <linux-pm@vger.kernel.org>; Thu, 28 Apr 2022 12:34:42 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id p6so5227878plf.9
        for <linux-pm@vger.kernel.org>; Thu, 28 Apr 2022 12:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=sblGdKLBs6vKIYGKb8j0yrpysabjJvjQtk16BpTjBeU=;
        b=G+oaZXZ61Ff1BDikkAuNsbuqXjTPAR5lKhYazCd7CmjAs/RWHi+SRk8Sskb0RoH6Ua
         bmANJJ7j57aWKTDHStxBmHMNOBjOSpaF77gf0pwc22Jpy4UjSAV/Q3kYDtBUhuWDaNMO
         kPG5BLTHIn32wfPYTTUTAcUYfJ644dC9Gz6SyeEsCPR1LVDAE29JQmTr+Rf1wRGZDOg4
         DRoCA1JyclXLZvqDgxzYDPch2/NDF3hOPZPtgjFSP3+Y3Xrc+8GnLwghgVVeFTpvta+4
         j8bE8vNdwkLkFV9RysExF2JYRM6IlN3Qemdq/eRBwtrgpEIkz7KB15hKVcRzTofhSAnl
         3hqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=sblGdKLBs6vKIYGKb8j0yrpysabjJvjQtk16BpTjBeU=;
        b=yra1iZjvcfl3vQfxHDYDTn7dd4ivREj5MCWlpXUqHh6eSdLK3yvfD/wBDkLjDDLPPV
         b7pb1lTB+G2R+4X/XR61syBo3SR3XhkyKFMhvSTz4Vs8qUljNDw4foz8fgIEbi15BLDU
         +24ou8JFzE3Wa7BQDuYaxm7CfSuJ0tSfN7CaL9atsvsIgT0qtMszjFfJjBgmiYBOIVDS
         2VAdxsvBsnTDa7h2el2JledIDskBtq9w9W+jeedVbsNOYv+3YKNOwvu9ZHBeRJdfq5EC
         aobAppNWGf7p2m7p87SrIkIjUq8LZkb+1Cv2R59LfLSjMQMu7eN8IB7El1dZAnJvmWyn
         0bkw==
X-Gm-Message-State: AOAM532G3ERM16cLpBfdWfYj8uu7f1Pay1Qp2h3TZkR3G3RDkSukiMIb
        HDRIFChaKt1aVIzIN+mqjBQpqjvzDzkDgbX33+w=
X-Google-Smtp-Source: ABdhPJzNEZOV/jedAtx9ZdiMyUUGefVddafaUdW/AqXofjIReUMqC4oiG92McDHPj+0LO5olO+5EiQ==
X-Received: by 2002:a17:90b:3843:b0:1db:c847:623 with SMTP id nl3-20020a17090b384300b001dbc8470623mr7026568pjb.52.1651174481694;
        Thu, 28 Apr 2022 12:34:41 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id a28-20020a637f1c000000b003c14af50630sm3630019pgd.72.2022.04.28.12.34.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Apr 2022 12:34:41 -0700 (PDT)
Message-ID: <626aec51.1c69fb81.85721.93aa@mx.google.com>
Date:   Thu, 28 Apr 2022 12:34:41 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.18-rc4-115-gd3fa656ae5f38
X-Kernelci-Report-Type: build
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
Subject: pm/testing build: 7 builds: 0 failed, 7 passed,
 1 warning (v5.18-rc4-115-gd3fa656ae5f38)
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

pm/testing build: 7 builds: 0 failed, 7 passed, 1 warning (v5.18-rc4-115-gd=
3fa656ae5f38)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
18-rc4-115-gd3fa656ae5f38/

Tree: pm
Branch: testing
Git Describe: v5.18-rc4-115-gd3fa656ae5f38
Git Commit: d3fa656ae5f38da2890e3c0d538b397d9afacea2
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
