Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 603DB544003
	for <lists+linux-pm@lfdr.de>; Thu,  9 Jun 2022 01:43:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234574AbiFHXmD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 Jun 2022 19:42:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235383AbiFHXl6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 8 Jun 2022 19:41:58 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1AED1BE64A
        for <linux-pm@vger.kernel.org>; Wed,  8 Jun 2022 16:41:36 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id y187so20341944pgd.3
        for <linux-pm@vger.kernel.org>; Wed, 08 Jun 2022 16:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=bptLTT3dH/tatgoIl0nwGfi61ndG5D6r8YsV+A9Z0lU=;
        b=WxhEX+tzqrpIaxEZb/76W0ltul+ymUQA5ZLWyhVXv9EMoxU16+wjkHros2mz4MMM+/
         gIOGR1H2It7Z3Zzj1AsRJJV9eqqlbC7FpLa/yXx9SRqfW1DkBdCGumLnJclczAkgVpif
         00vJOFMKhARxDQ5BUGzq5PddnBh4lOozJmh1KcjOKK70kucU61PSl7WWn6YBolJg0oGF
         P+OrQWnlkCap35j59L8LkRpSPlFRmw22ZsbjCG0xNLwTFKy0e53PJYEUXchx8NEtv2y/
         TOryNDYr6mGwxSJ/gnKM8AkKrbh+Yq0h7qE/oE6gfxZ4nUIS7d4nF0EJHXvfmUnsv2nw
         I21A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=bptLTT3dH/tatgoIl0nwGfi61ndG5D6r8YsV+A9Z0lU=;
        b=3+XTGgJgRTcpQzTcbnt6EwIXl/30QLHh7nUOBdVdC7vNAzUpBbG4PzSbTNm8Doj4qT
         RUewSeUlFm5yoDYVT+KiLqZTVg9rpjjMZoJh3uD3qabzKXmZcUs95+Xq/qGLINWA77j9
         nZg0xTiYMs2WGKpyl9SVS+W2rvtgUGW8yZh8nJ0GCMFhWQe2qPsFrQH6G1rABD49o+MF
         OfMbMY4ychseG5B9aeJBd4tS3lUHplPvzzE72x+u6F0mKOxCiM+kr0ZKl3wt/K+it4U1
         OiU/Qk5vExmrF3LcPsZ46XZ+od/2I/orxx1kHiHW7oaXcn+T1cqJoCj28V5bOd9VwNEr
         /VcA==
X-Gm-Message-State: AOAM530Hzb9vIn9hNImfjUiQf1Ft5ZHymYAy8eSWYalmgXG571oxyuRC
        E/AQYvxcah3Eq/X/4lmWvSPtfg==
X-Google-Smtp-Source: ABdhPJwPFajNfRSbI+LiO3mDoDFLUi8R9nR7Cvfd2I0+259/gOvhjLEOB/y1R9jIxL/JCGma+zHmFw==
X-Received: by 2002:a05:6a00:3491:b0:51c:1d3b:b0b0 with SMTP id cp17-20020a056a00349100b0051c1d3bb0b0mr17364707pfb.68.1654731696467;
        Wed, 08 Jun 2022 16:41:36 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id 20-20020a17090a005400b001ea5d9ae7d9sm57623pjb.40.2022.06.08.16.41.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jun 2022 16:41:36 -0700 (PDT)
Message-ID: <62a133b0.1c69fb81.4a8ea.0201@mx.google.com>
Date:   Wed, 08 Jun 2022 16:41:36 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v5.19-rc1-4-g28e0b92ca611b
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
Subject: pm/testing build: 7 builds: 0 failed, 7 passed,
 1 warning (v5.19-rc1-4-g28e0b92ca611b)
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

pm/testing build: 7 builds: 0 failed, 7 passed, 1 warning (v5.19-rc1-4-g28e=
0b92ca611b)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
19-rc1-4-g28e0b92ca611b/

Tree: pm
Branch: testing
Git Describe: v5.19-rc1-4-g28e0b92ca611b
Git Commit: 28e0b92ca611bf10dda3570b0d43a0c5b62afda0
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
