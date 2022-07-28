Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F5EB584890
	for <lists+linux-pm@lfdr.de>; Fri, 29 Jul 2022 01:12:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233352AbiG1XMK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 28 Jul 2022 19:12:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233490AbiG1XMJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 28 Jul 2022 19:12:09 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D9E0606A0
        for <linux-pm@vger.kernel.org>; Thu, 28 Jul 2022 16:12:08 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id 15-20020a17090a098f00b001f305b453feso6733574pjo.1
        for <linux-pm@vger.kernel.org>; Thu, 28 Jul 2022 16:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=S0lwp6g8km9IQP8dALEfoeTQk7vHN06GSgK6/EqOBjQ=;
        b=jMVwvTaXfI7rlspB1y/EBSx+2EmIyLz3j3BtDMZFOPCYIGYTWb6bH4A9QoIPpqCy9H
         F1EOMTm+Av1/D3mlDey6InTTJHt5vTSWj/Sy8yL7rOtvpKFUeQ/U3PZTdqO2alzrvL3a
         94GPoH/lWaZkYDkQVFfIal7xBZujDHjt9Opg4epsVbPrfHbg6IdaO/HzDvkiH1oxTg2R
         Ny85eLR7X8Bhg2ikFhZj1plYyvVpWKjzMkhthT/Cu4By/Jgh/x2gxXB5Q5/Y3VDFXGHW
         T+rdIgcxqiOISmpPN0mTO4e/ilV7/a4wBYyVbsLF3VAjg7yfGrwVbQDxJtpmnV2rK8Ut
         gSig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=S0lwp6g8km9IQP8dALEfoeTQk7vHN06GSgK6/EqOBjQ=;
        b=7Gxcc75uSiLlv3QMz7hIRw5XlHaSPcp86WpkKPtxqHvB90jk/2aH2U9LbCPW6J8wJS
         FF1a/wA3Iy0cfphFRTcRSOqpeINJMwKE9TdPbXIDVyUVCSUd9KceAvdF1a9xpLIEA+s0
         YNME9ktovkcRm7gSD0XFbArOyb1hXLH+MhwujWVTXOcvoz5MKLJWx1nh8CDHgKZAC5q3
         4hp7TeG6ijRd88pFdBQ8Zdn3Kwye6uKxg8w7xUYR6lEy3GS9YS+/y7zctrWqlcsHaJ3Q
         WpkSaKpT9xJfBVFXbrhYf8b8yO3/mkIwwsXU5p9eUPbJVHVebNxwLw45lWiSZG950jlF
         IPaw==
X-Gm-Message-State: ACgBeo3V6u1vcHIabnJQq+dWkR6WsAYoiDnEnjVE6u6AtNMRCL57eD63
        gBqdAExD6UdIdm5LxGcCFZ+sq3TKHimO8XAu
X-Google-Smtp-Source: AA6agR7nhNuQL4h51dTnuorrYLWuFL5iftp7LcQwOkbmBWPgaJ690c0X0nw5zFMJ6EJk0pzl7LhTuA==
X-Received: by 2002:a17:902:a382:b0:16d:9b15:83d5 with SMTP id x2-20020a170902a38200b0016d9b1583d5mr1050349pla.101.1659049927534;
        Thu, 28 Jul 2022 16:12:07 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id j6-20020a17090ae60600b001eff36b1f2asm1659213pjy.0.2022.07.28.16.12.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 16:12:07 -0700 (PDT)
Message-ID: <62e317c7.170a0220.33271.260c@mx.google.com>
Date:   Thu, 28 Jul 2022 16:12:07 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v5.19-rc8-92-ge240a33f1bc48
Subject: pm/testing build: 7 builds: 0 failed, 7 passed,
 1 warning (v5.19-rc8-92-ge240a33f1bc48)
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

pm/testing build: 7 builds: 0 failed, 7 passed, 1 warning (v5.19-rc8-92-ge2=
40a33f1bc48)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
19-rc8-92-ge240a33f1bc48/

Tree: pm
Branch: testing
Git Describe: v5.19-rc8-92-ge240a33f1bc48
Git Commit: e240a33f1bc480e5ff7a39d07ab3ba0c8ed34df8
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
