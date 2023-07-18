Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 848FC75885F
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jul 2023 00:24:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbjGRWYX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 18 Jul 2023 18:24:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjGRWYV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 18 Jul 2023 18:24:21 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1FBFBD
        for <linux-pm@vger.kernel.org>; Tue, 18 Jul 2023 15:24:17 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-6687466137bso4136626b3a.0
        for <linux-pm@vger.kernel.org>; Tue, 18 Jul 2023 15:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1689719057; x=1692311057;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Njm4OZMFGbz9kj2acOQenVAP6K4V8zxn1UEaaH8iSVo=;
        b=EIcPsZGAjudB9VkPgbB0bChs4NrnzXZ2nvLrjll2GHtFaYlwkd5iENDo69UjHxYpCr
         lMZ3HMy0qVcpsaldmXe4limDQw1yLny0g+qDQeo+BcuW1vHFKburORz5PubrVHwx/TSw
         iBWSzN8W6FcWolgf1o+nlG5JkcNVe3KOaTxkWCf7RxupA9zcb7fub84+Uent+H4AxUbI
         2jQ7UIzFMTSZ9FrAGFdWj1CJ1M3WhXPkqNFIQi1LHiCEBX+PB9n4RRwjtdZDxiBbJ/Gw
         h7t6AJwbB7fdi8vALLXzuMlol1lT6UHTsEzJUBCCfxpXRJ57kckJcQd8Ll3VO1lbLjBO
         xvMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689719057; x=1692311057;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Njm4OZMFGbz9kj2acOQenVAP6K4V8zxn1UEaaH8iSVo=;
        b=l5sqjDTVshZxplLjlmVEs1Inj6OGkVegx3uKeM8WgumF36eqvIvyPsCgAH6Ycbe8qy
         Ba6XWsTdjmbrOunqsLGyekchnHo/VK6tezmS8WfT6+ITwXPOgevvY3B5ZI1IOjKKy6BC
         EjNVQ9Grf3ECLxvMZNIYnZMCoEx7knfeSbuwCNXGJ4hK7Pz7BXiBH4K20mfhWTAlEqm5
         TXkjFmM4xqd43f3rXGlUt0lm+Jt6VJE0jGSgN3K1WSRIi23LLz9+jjM5VEGv5qwPLNiF
         yJsyprbl42wqwiH58usmitwstPrJrpfDYoAHshXuHMTV23iUIOULa4t3A0iGjL+wXy5F
         FO0Q==
X-Gm-Message-State: ABy/qLYznsaZY/l469NixsMa/B405DHuckEdaCX9xGyst6Ez31cD7Ggb
        39bjPzXXW639CSQnZCbc0R0/sg==
X-Google-Smtp-Source: APBJJlHSvooChuFu1dwfU87PGi5Krd2A3WOyAOejRkrLbfAz2hYt9eo5Ym3VaOewtuJlVer3ORqBkA==
X-Received: by 2002:a05:6a20:3d17:b0:12f:8755:96ba with SMTP id y23-20020a056a203d1700b0012f875596bamr623431pzi.28.1689719057248;
        Tue, 18 Jul 2023 15:24:17 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id v11-20020aa7808b000000b0064f95bc04d3sm1999516pff.20.2023.07.18.15.24.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 15:24:16 -0700 (PDT)
Message-ID: <64b71110.a70a0220.3bee.4908@mx.google.com>
Date:   Tue, 18 Jul 2023 15:24:16 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
X-Kernelci-Kernel: v6.5-rc2-42-g6e9908abf1d1
X-Kernelci-Report-Type: build
Subject: pm/testing build: 8 builds: 0 failed, 8 passed,
 4 warnings (v6.5-rc2-42-g6e9908abf1d1)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 8 builds: 0 failed, 8 passed, 4 warnings (v6.5-rc2-42-g6e=
9908abf1d1)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v6.=
5-rc2-42-g6e9908abf1d1/

Tree: pm
Branch: testing
Git Describe: v6.5-rc2-42-g6e9908abf1d1
Git Commit: 6e9908abf1d156c4be5736acfdbd73974b8af772
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
