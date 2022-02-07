Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A8A84ACBD8
	for <lists+linux-pm@lfdr.de>; Mon,  7 Feb 2022 23:10:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236427AbiBGWJ7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 7 Feb 2022 17:09:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230500AbiBGWJ6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 7 Feb 2022 17:09:58 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 376E0C061355
        for <linux-pm@vger.kernel.org>; Mon,  7 Feb 2022 14:09:58 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id x4so4633469plb.4
        for <linux-pm@vger.kernel.org>; Mon, 07 Feb 2022 14:09:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=t8E3EHjUkZdtKNuyODTLNgXbLhxLk/8J6rwV/b6yS7E=;
        b=cqmh5gGnebutO8xV+D5DuH7JXG/jJuxwpWt/4pcgVhG2qmuzfbho9iRVbLO/AVpWbD
         Xh5AcGjRcve3/P7mZKLCmRJc4udL+ucxvwh1frr8aK2cFc8XNa3r/382uCsDYJt7Eve8
         xsCJE6tVNolEkfC8Tdh7UwcwB3RgFeA+63PLLRM5yOEGXUFx9ZRniySrg2n97QeY/3OG
         28ZUptsWwWNr/+/PvuzU6KSz/9JItJj3MTWOFQ7nDFffI82SG+a9lvxGXgfwXsrN/Mmi
         JeEk9hG/L86fHhdKFFohRwuKVnlTE3Xa0KT+bf9S+SqULR+FOi3Lu4JhxuTvA20xOFJP
         rIVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=t8E3EHjUkZdtKNuyODTLNgXbLhxLk/8J6rwV/b6yS7E=;
        b=GUc4KP3kEPbWd0hH8wRvYzxbGhgWs4liiIbG3fPgxddgt5RAv71tFqnNpqU1Pe+brX
         LqeC6vk6VohNggk3Atq79MCaTvVrT+9TCn9r4mPmUQb+jA/GsbebJu4dcu3QIg4ntgP7
         iwGWQKKw1Ut7t9ZC7PqmWMvQZWBpyFQjKQPtOlYIRKDm5GCAkY3bOz0KX6ctQK5LW3B8
         Ec9QBUNkFcadAvule25LHLrrPxo4V5tlvoqvgShivcu4JTcRxi8VcLy6YeeQUgy1cQIb
         wHn/9Yq+stQ6888pqPRhzevOik5/55ZcFJtFJqZoFEcSyPianHeMIgMkgi3G079ob60B
         DSxg==
X-Gm-Message-State: AOAM5311uHAd1/rqY3ix5ur8wrDVlYD6BadBxwE/xDsiVsWjLubefFB1
        foazIed2H2sejDcRtnXQZuZXlQ==
X-Google-Smtp-Source: ABdhPJxVuETMm/BfgGdSYqP4hoI6RBEHVvAZbHhjwu3j5za9h9cQM7HvEffrANOTwQCLPPxbL2n4dw==
X-Received: by 2002:a17:902:7e0a:: with SMTP id b10mr1475164plm.17.1644271797713;
        Mon, 07 Feb 2022 14:09:57 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id l12sm313457pjq.57.2022.02.07.14.09.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 14:09:57 -0800 (PST)
Message-ID: <620198b5.1c69fb81.bd1c1.14d6@mx.google.com>
Date:   Mon, 07 Feb 2022 14:09:57 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.17-rc3-33-g4e3e936b36f6
X-Kernelci-Tree: pm
X-Kernelci-Report-Type: build
X-Kernelci-Branch: testing
Subject: pm/testing build: 7 builds: 0 failed, 7 passed,
 1 warning (v5.17-rc3-33-g4e3e936b36f6)
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

pm/testing build: 7 builds: 0 failed, 7 passed, 1 warning (v5.17-rc3-33-g4e=
3e936b36f6)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
17-rc3-33-g4e3e936b36f6/

Tree: pm
Branch: testing
Git Describe: v5.17-rc3-33-g4e3e936b36f6
Git Commit: 4e3e936b36f69b2f9cd7417564b0f54111df9a7e
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
