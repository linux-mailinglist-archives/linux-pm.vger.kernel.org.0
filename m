Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FD8C5604DD
	for <lists+linux-pm@lfdr.de>; Wed, 29 Jun 2022 17:47:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233237AbiF2Pr3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 Jun 2022 11:47:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234332AbiF2Pr2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 29 Jun 2022 11:47:28 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A94C3AE63
        for <linux-pm@vger.kernel.org>; Wed, 29 Jun 2022 08:47:27 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id r1so14486837plo.10
        for <linux-pm@vger.kernel.org>; Wed, 29 Jun 2022 08:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=Fq4JUrTRXbH7wC+H/60nOou889ZrfGQffbYcBRpHa7E=;
        b=cE5aV+5LSwPRHEs33lSeZM2I1uQv7GRAURX2ZKJkO34uWhsMIRN1o4PdrmPDuqRlZh
         d1xhEp9FZ4j2yRET6d045Mm4PKq2/8j8Tkm4Hm3pXZojC4qeHgpP9jV5RRSD1hdcuKya
         12wfviv4gnhaPh/UR7kjzG5C8t2llYC3VOPOw/l0705DSrfgC0DmvTDkQILZ1gEmctwL
         WpdODSGMdG/0C4i3hMTc4Wi0y8qpRfFKqet2VNIsh8VOxgvyq0sgya1ja5M1TEva2RY6
         g0AX80FjmOPEGcOoB9wd4JFQWJAKrJBOlKU2JZEcEXgb2dq+PPD8/LnXH39NRgo/hVS5
         6TiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=Fq4JUrTRXbH7wC+H/60nOou889ZrfGQffbYcBRpHa7E=;
        b=vKQBYbQ+8SmtmtqfyMv7aJzByankJRgJa2ls9ccP+s0P+q9Fnqf+TzMNNqC9dRWXY9
         zFuWV0EBjhWPkaAh6drxbkGtq8GrUT5k0GwsFC2ViuCLCbxr9E+zPZk/zN1n5lXmSW9W
         gty2MsO1kHpamWiTTaIr5k9WgJsHjqUjBrO+n2LGif54CqVgRWZl3H2YTiplQ/mc67jd
         lTlOoR/cO17UpjyD4yOzg0VaWpurtn560G8miv1YQ5mnp7cI+3bO+Ty5l5yG3qXCEzYf
         ioMx/yWmSbMHv82N94Cf78oALu4bHh8maAvbWiKTkQnGoIXOSZAxpW/TM+DG6OKYSBLe
         Rjog==
X-Gm-Message-State: AJIora/q3zVa+oXPdOJavMsTh+QCYLdmqUG43AFmk7GCquh0m9m5PpWR
        7L2BqWyKjIxs/9wwp7gTFshzxIHgX/jVOEh+8G8=
X-Google-Smtp-Source: AGRyM1tpwXVk/wwZl1A2jFJ/eXwG5XY/bPSDcUJ1/PWHxAx1HiYlDHkq6U/Rpdx+0m5tUZwT20DbHA==
X-Received: by 2002:a17:90a:66c1:b0:1e8:43ae:f7c0 with SMTP id z1-20020a17090a66c100b001e843aef7c0mr4403423pjl.245.1656517647229;
        Wed, 29 Jun 2022 08:47:27 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id s1-20020a170902988100b0016a4a57a25asm11519773plp.152.2022.06.29.08.47.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 08:47:26 -0700 (PDT)
Message-ID: <62bc740e.1c69fb81.af400.0906@mx.google.com>
Date:   Wed, 29 Jun 2022 08:47:26 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v5.19-rc4-35-g06cab9aecb43
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
Subject: pm/testing build: 7 builds: 0 failed, 7 passed,
 1 warning (v5.19-rc4-35-g06cab9aecb43)
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

pm/testing build: 7 builds: 0 failed, 7 passed, 1 warning (v5.19-rc4-35-g06=
cab9aecb43)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
19-rc4-35-g06cab9aecb43/

Tree: pm
Branch: testing
Git Describe: v5.19-rc4-35-g06cab9aecb43
Git Commit: 06cab9aecb43a2bac09c7f2fa90df13f29130313
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
