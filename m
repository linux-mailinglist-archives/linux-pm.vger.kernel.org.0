Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FA1C72D7F9
	for <lists+linux-pm@lfdr.de>; Tue, 13 Jun 2023 05:09:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239504AbjFMDJC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 12 Jun 2023 23:09:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239527AbjFMDIl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 12 Jun 2023 23:08:41 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFBC41BF4
        for <linux-pm@vger.kernel.org>; Mon, 12 Jun 2023 20:06:26 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-54f87d5f1abso1071642a12.0
        for <linux-pm@vger.kernel.org>; Mon, 12 Jun 2023 20:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1686625544; x=1689217544;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=jjFDRAiBYLSz5BoChNt+MRG7hdz7ShTWuuhyfBIaiZM=;
        b=TMiOP+ruaVgwDtA4ZuCEqWObrG5Oftdz/I4R6CII0q2vQUmI3JVnRY28yIRU2tZnKY
         O9h6eAXb2E/31PDzQPyiykQuO+e1oz97oNMJbn92k1gwQvn+e1OFCSWZ7pkGBTxNrdI7
         7bilytx9X6hNPVJj7hKcwVUo0UV7MAHt4Sz8KmNmefA1Z4AChu0lZAr4Mf2Wr2UOH8yE
         vupSHfJeLyXtdagTowRMPwfd9HJkBSSTfWo7Td73rSnwH7ySjZPTgPITLf+qMysePuoN
         eV0lkwziackAtnWuRgUhBYS7BMMpjygIVV27cGvgK4Bse4KYMZSORk6rcr8pkHCNISR+
         fauA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686625544; x=1689217544;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jjFDRAiBYLSz5BoChNt+MRG7hdz7ShTWuuhyfBIaiZM=;
        b=Qnju9TEwa3vxG4mJl9L6n4WbpLRwW8/gsEDdX4Isw77pNvlAQVeAcrw5W50Y3LIS0A
         5R+6g8NPIjeCf4hOcnENboouc48c015BdYB6swHXk7ibDJOyKvQLGykGsaLBpAHWLseg
         kKZzu9gferdAvz2u/Jh3KeBLYyvyW+18GVgrqZsi3X/HKtO8ImY/ONVKUW5CxIkQPM9e
         lq0ulfxq4a1awh6oGLGcmCSNTcmLumvnClvaupgYGvEBrbSc0935imNdNg60N21qm0z4
         45HK96pQE5q35QA9mDPcmLTweamSlo0dUfGdTt/WJ0H9YseKT8PHEdeq6ZmcAAfo2bY1
         4SRA==
X-Gm-Message-State: AC+VfDymxxeumPJcqipqcM0wnxNfvni0LVH+7zaxctT/dCU3BDTmMmkE
        MOtgqkhVmLA/2f1aF2UHnIfzpA==
X-Google-Smtp-Source: ACHHUZ5hd8z7c7SfQJk3MlPRWm06U1peFlVEKiw5Ajg1MmWAUQ9yg+0MmjGQutv1m75gXZOaovfO7Q==
X-Received: by 2002:a05:6a20:1611:b0:114:7637:3451 with SMTP id l17-20020a056a20161100b0011476373451mr12321992pzj.37.1686625543902;
        Mon, 12 Jun 2023 20:05:43 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id ji18-20020a170903325200b001b20dc1b3c9sm4926544plb.200.2023.06.12.20.05.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 20:05:43 -0700 (PDT)
Message-ID: <6487dd07.170a0220.31cf1.9702@mx.google.com>
Date:   Mon, 12 Jun 2023 20:05:43 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v6.4-rc6-36-g7796be1562e2
Subject: pm/testing build: 7 builds: 0 failed, 7 passed,
 4 warnings (v6.4-rc6-36-g7796be1562e2)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 7 builds: 0 failed, 7 passed, 4 warnings (v6.4-rc6-36-g77=
96be1562e2)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v6.=
4-rc6-36-g7796be1562e2/

Tree: pm
Branch: testing
Git Describe: v6.4-rc6-36-g7796be1562e2
Git Commit: 7796be1562e27d8b9441fe1c2c2ecfc1ebdea55d
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
Built: 7 unique architectures

Warnings Detected:

arc:

arm64:

arm:

i386:

mips:

riscv:

sparc:
    sparc64_defconfig (gcc-10): 4 warnings


Warnings summary:

    2    WARNING: modpost: EXPORT symbol "_mcount" [vmlinux] version genera=
tion failed, symbol will not be versioned.
    2    <stdin>:1519:2: warning: #warning syscall clone3 not implemented [=
-Wcpp]

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D

Detailed per-defconfig build reports:

---------------------------------------------------------------------------=
-----
32r2el_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sec=
tion mismatches

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
sparc64_defconfig (sparc, gcc-10) =E2=80=94 PASS, 0 errors, 4 warnings, 0 s=
ection mismatches

Warnings:
    <stdin>:1519:2: warning: #warning syscall clone3 not implemented [-Wcpp]
    WARNING: modpost: EXPORT symbol "_mcount" [vmlinux] version generation =
failed, symbol will not be versioned.
    <stdin>:1519:2: warning: #warning syscall clone3 not implemented [-Wcpp]
    WARNING: modpost: EXPORT symbol "_mcount" [vmlinux] version generation =
failed, symbol will not be versioned.

---
For more info write to <info@kernelci.org>
