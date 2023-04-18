Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC50E6E6D9C
	for <lists+linux-pm@lfdr.de>; Tue, 18 Apr 2023 22:42:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230465AbjDRUmw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 18 Apr 2023 16:42:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbjDRUmw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 18 Apr 2023 16:42:52 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 501E75FDA
        for <linux-pm@vger.kernel.org>; Tue, 18 Apr 2023 13:42:49 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id w1so5291606plg.6
        for <linux-pm@vger.kernel.org>; Tue, 18 Apr 2023 13:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1681850569; x=1684442569;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=aMylopIdACvf3cihCzzjJ37/pMBX735qkH3WV7hdVck=;
        b=DOQyasOWs6zUT66gHsdpsLLiGt2BdZyrnuPMGYQDsuhc9h0yygKzan73M7OsnqodNC
         TEGTu4FVxxQxNT5Vm7KSGl5qKqScpKNhC+Un8+WeBFmHfnzdwWCDwT52frO/lvjYAgFW
         lWsMlyuR+nTuFK1x04fv/xcbiRufa0vvfx90JplC/DNdKZxxIdZ5/QBB0tijWCpCAxj1
         lrQNxy4i0GV0acT7ZxdUSQ0FveSUY/8r7U6on8zj/DefTbmsFnfW0i4inqfWnkCctUTg
         3es5WJaXSRtfa/HOBgLeTnX1U/yznGoW+NUFi1lrJwOEoe1jNKBUdnkRxMvWRjCBQh6b
         NksQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681850569; x=1684442569;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aMylopIdACvf3cihCzzjJ37/pMBX735qkH3WV7hdVck=;
        b=E0fM9uF24ZDsGfMAclbM45beJ16tdE07gz0Q/glUQIGPscQWTeuoCqrbCc8fHZsGU5
         o5no0A8guTgE5QtVC+PQgSV2c893Ff9sg7La58n98n7Y6ix/jHysmm6jdZieK91GhAb6
         DcGVFH8ep5h9W54FkmP0JWOujgupS5bgPNEumtaytvRryJpag6d1af3fr9KTFTPNbhzH
         XKcls3JQ/3vvWDVhpIkLvch3gyBW8SwI1kpDhZf42Gs0/WUe5OG8enZz/t0V3EmjWX18
         ogYe0ipHerpRov/dEk1RwCEiegekIlra5HpkcbF6sU4ZjIrDaAjfnV2jJfN+g6tnTjQU
         5y/w==
X-Gm-Message-State: AAQBX9dw9GhVTtHfg0cARQsdjOjibSV59jCJDAzCI0jX5K++bWSz40cz
        EbdP8BzbdGoLW/Hp3tvgDmt0pg==
X-Google-Smtp-Source: AKy350bwaJ4Ndw3xqdtf09W17dZNddLRhGDK7yFAx4ZH0tnmeGG4ipy4AMhNRGAF58evKgdQxs5J7w==
X-Received: by 2002:a05:6a21:998c:b0:ef:a696:993a with SMTP id ve12-20020a056a21998c00b000efa696993amr1071436pzb.22.1681850568737;
        Tue, 18 Apr 2023 13:42:48 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id r11-20020a65498b000000b004e28be19d1csm9270645pgs.32.2023.04.18.13.42.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 13:42:48 -0700 (PDT)
Message-ID: <643f00c8.650a0220.9093b.5422@mx.google.com>
Date:   Tue, 18 Apr 2023 13:42:48 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v6.3-rc7-158-ga55dbec19157
X-Kernelci-Report-Type: build
Subject: pm/testing build: 8 builds: 0 failed, 8 passed,
 4 warnings (v6.3-rc7-158-ga55dbec19157)
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

pm/testing build: 8 builds: 0 failed, 8 passed, 4 warnings (v6.3-rc7-158-ga=
55dbec19157)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v6.=
3-rc7-158-ga55dbec19157/

Tree: pm
Branch: testing
Git Describe: v6.3-rc7-158-ga55dbec19157
Git Commit: a55dbec19157d83e21eb1b8f0cf5a8195d405005
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
Built: 8 unique architectures

Warnings Detected:

arc:

arm64:

arm:

i386:

mips:

riscv:

sparc:
    sparc64_defconfig (gcc-10): 4 warnings

x86_64:


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

---------------------------------------------------------------------------=
-----
x86_64_defconfig (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 s=
ection mismatches

---
For more info write to <info@kernelci.org>
