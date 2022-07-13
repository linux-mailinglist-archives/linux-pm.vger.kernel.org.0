Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AFB1573DAC
	for <lists+linux-pm@lfdr.de>; Wed, 13 Jul 2022 22:17:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231907AbiGMUR3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 13 Jul 2022 16:17:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231473AbiGMUR2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 13 Jul 2022 16:17:28 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 801A422BC6
        for <linux-pm@vger.kernel.org>; Wed, 13 Jul 2022 13:17:27 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id j3so11199622pfb.6
        for <linux-pm@vger.kernel.org>; Wed, 13 Jul 2022 13:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=zgn8G1O2TZu3407ejlFbewbhxfSi2i0EjyN0TFr2jUo=;
        b=kXq0jjYyDEdJ7HGhDSRs0mUnq6sqbpYCAhdxAq+94sb1x95ovRMXFHZAFaH9zb/Bg6
         G8KFEQxApJnGPe8ribeNyAwOkzM3OgUfBkVRjTwY9IPWozTkcWO+0clQfy6BEst/qaUG
         bJdaYkRMRC5Meo7vODh8Peyx/iAxVX0CKiEI8ttqo0hLQXGcl7rUPOkYcZcGXMkvdzqM
         NgBMB3TotlS25LKGVMi/fKfkPBtgdPW7tax2OyZzBBI7LYA6V4qVPvpkw3Pe3udZJOpU
         6ECtno50FFTQASwWpHSBwPM9FmW+VhFbtNXg0dhylLAvakDAyJmLo7mpkIl5EgGJpSuG
         XoDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=zgn8G1O2TZu3407ejlFbewbhxfSi2i0EjyN0TFr2jUo=;
        b=J7EWp0JS9+gfz7IWQpvpM3foTXMDkcv7s3RY/Sh00JG3+KLzi8MFlSjL8jFPXIlnA1
         Y86kNQtn80kxuRHrtE8oa8YRYlFZMHD/YEwjbgOPENl3pVD72YShl1PVF4gWEe2/xZcU
         0MQ9faFzw59CHWdcvjJ3/1Tq2FrkxjkRMS52WFfEbHj71tUpCXAb36obIAH+zyDOlYbp
         MW/5Ohx55chyZtNqLyj12kOHEYYiWIQRNYhA+Gm74RE2CEvuvZZxOPgM2DVXLg1aTUIX
         fNuU7OHIoirfKhaRh1bVNOQbd/fajsrje/7TisiXkQeVKyuAY1CRay0sB1OI6QzkfVMV
         UR0g==
X-Gm-Message-State: AJIora9bNR+mOtitYB7vddmMPN9Z/dZ82+Nq6+ZjVUzkY4wb2QcCBiyL
        oPShjW9ohBevulrtSsXW2nH8UA==
X-Google-Smtp-Source: AGRyM1tAKbmrGd3gaRPibnq30diFVEsvqql6dtWEXa3YznKJCCvniJlttfyXB2WnGctDqNZcDXhkDw==
X-Received: by 2002:a63:d94a:0:b0:412:6e04:dc26 with SMTP id e10-20020a63d94a000000b004126e04dc26mr4399365pgj.539.1657743447029;
        Wed, 13 Jul 2022 13:17:27 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id i15-20020a17090332cf00b0016a091eb88esm9284458plr.126.2022.07.13.13.17.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 13:17:26 -0700 (PDT)
Message-ID: <62cf2856.1c69fb81.cf90e.e138@mx.google.com>
Date:   Wed, 13 Jul 2022 13:17:26 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v5.19-rc6-57-g524b6b1a1288
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
Subject: pm/testing build: 7 builds: 0 failed, 7 passed,
 1 warning (v5.19-rc6-57-g524b6b1a1288)
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

pm/testing build: 7 builds: 0 failed, 7 passed, 1 warning (v5.19-rc6-57-g52=
4b6b1a1288)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
19-rc6-57-g524b6b1a1288/

Tree: pm
Branch: testing
Git Describe: v5.19-rc6-57-g524b6b1a1288
Git Commit: 524b6b1a1288721f687931cf457a3216ad14742a
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
