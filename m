Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F06B4AE6D2
	for <lists+linux-pm@lfdr.de>; Wed,  9 Feb 2022 03:41:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242102AbiBICke (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 8 Feb 2022 21:40:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231366AbiBIBdM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 8 Feb 2022 20:33:12 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C15CBC061576
        for <linux-pm@vger.kernel.org>; Tue,  8 Feb 2022 17:33:11 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id h14-20020a17090a130e00b001b88991a305so3618733pja.3
        for <linux-pm@vger.kernel.org>; Tue, 08 Feb 2022 17:33:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=ct/RJbYUwFZkoRE18bAj6uTwFLYzCqHbCB/35ggLiRE=;
        b=klxArvQH+DMPfAELOmn+cDdMM2IKTnrnGS6l4aaUw3zjuk8mR1ZZXLiMBdV9kKj7U3
         cpJAvlwcixy3nSrKk8nkHRhOqYGQ82LjlVW48B1JvSSsYvWSbTh0j/MkCY5c+DFfKCCz
         hdICsgrgaPlzomaZn9IQ5g0k7JzSjktooZHkYsiXzlrEF1ALobpk8BoZVngRoMW3uSUT
         wLnTPWYL1HnQlPN4B9DhSMZRisSJLAU8dTjjroZC86lR63i9SkoY+/FxR/C4hEQBAOo5
         Lu3hJ375uLzZqsVUiyTLfDskrZ0XpwhEOZQQfAs3drAIB3myoayIIC3zkJ4MGBVlQHxM
         Wjkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=ct/RJbYUwFZkoRE18bAj6uTwFLYzCqHbCB/35ggLiRE=;
        b=ABurpA1jTvjhaNd21idEkpBh7LLhMsU5SLsvJvwy15ht3+IJZyeXTPFAgJM1C9eWbX
         4HsuKCxew9kbQBuLJyQHGzFYtpiZE3B9mdjZsmORztLP53mLt9nTONubG/sB3d+SQEaD
         OBZNsCFOzmbxoAyOvta8H/UTGXoOTMRkFzdtlfolSYHMHye70vRw7bnO+BYRzxIDwPlX
         xPTe+HuL4fTDnhRgzI3c5TX/f7U2/QKzNrlk5vf3FN5cgUBaiuecNqR/PimrvnEADllx
         x+4Arv0ja+YiavVf1YfgQyuIqhr61D7yTFqksrZ18AdcyTjytMd/OePXqcc3KSFY19FU
         JGjQ==
X-Gm-Message-State: AOAM530Im3fuAzN05oBa4w42oYe8rP7c0Gcxz+8+8D8jyWoGvM0s6S7/
        KMyy+L6aaDG6DkcoZ1fJ9jQsLw==
X-Google-Smtp-Source: ABdhPJx246M+7MtCsPc4MXA6GUT6dc3HOLWElk226ENt+hIt7t46KheZzMLBAVUYImxkUlPbVxZFmw==
X-Received: by 2002:a17:903:11d0:: with SMTP id q16mr7171382plh.134.1644370391269;
        Tue, 08 Feb 2022 17:33:11 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id e28sm12408767pgm.23.2022.02.08.17.33.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 17:33:10 -0800 (PST)
Message-ID: <620319d6.1c69fb81.bd9db.06a0@mx.google.com>
Date:   Tue, 08 Feb 2022 17:33:10 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
X-Kernelci-Kernel: v5.17-rc3-35-g1e2d75f89fc7
Subject: pm/testing build: 7 builds: 0 failed, 7 passed,
 1 warning (v5.17-rc3-35-g1e2d75f89fc7)
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

pm/testing build: 7 builds: 0 failed, 7 passed, 1 warning (v5.17-rc3-35-g1e=
2d75f89fc7)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
17-rc3-35-g1e2d75f89fc7/

Tree: pm
Branch: testing
Git Describe: v5.17-rc3-35-g1e2d75f89fc7
Git Commit: 1e2d75f89fc7f3cf192049c10594d9535a64b6ea
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
