Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D947C7570FC
	for <lists+linux-pm@lfdr.de>; Tue, 18 Jul 2023 02:32:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbjGRAcY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 17 Jul 2023 20:32:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbjGRAcY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 17 Jul 2023 20:32:24 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1EEBE48
        for <linux-pm@vger.kernel.org>; Mon, 17 Jul 2023 17:32:23 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1b8a8154f9cso31953875ad.1
        for <linux-pm@vger.kernel.org>; Mon, 17 Jul 2023 17:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1689640343; x=1692232343;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=qm7yPmkkDNMNDldI6vlVFTO58nev/KuhrU4NYiUaXqQ=;
        b=yTy+1hHugoLuRJeZFAcSVbLUDV04zoIpdW3w/DcVurAXFryLMi5KPx2MQo3bkjbDld
         s+10/kpTsyU5IiNvTLuh5HrPyffOtUgN8eNnQjeSRc1msWiGM7I86ym5zZ32FmyxTTRw
         DJonyT7WIO4d/atvdDrF2JtAWf2qMyij0jAumVN/IKu6OB81J+dy34QLaAp0T7nEOug3
         r/zuW9da9yRJZxCEQ29VDPVJ7pZAGhws5FmLE4WE309mc6xVXRrHQNXfGzj1Qb3AJkbd
         pQhi1/JPZzGFvrEN3vba+UQMZSzGWhrEQAz9uzcbot/nAEQyZUisPEq3rfIIbo/5ptxT
         7kAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689640343; x=1692232343;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qm7yPmkkDNMNDldI6vlVFTO58nev/KuhrU4NYiUaXqQ=;
        b=OjdZTwVhn1Zmy6J1TNx5KiTjSA78KabfSgqlX2WJJQpQLub5AEFbGbMCw+gpZZZ/Rc
         +SKVY9KhETokLRoYoa/Q2UzVsjNFBdzSheFE1nHiruod0Xddkv4L0FEdZZ+hWKn8Q2/m
         lMcvE1PZZllBmPPRRoSkNtGz9mineOZBOjcf40h6q10K35cS6mT8Lv+xnH6SJb5hbXIF
         /+bchDptGlmw+Vss9Nv75Q7eNL5HEwG/41PmP0Ynf4jpVzwU/G+xxnKNCOVjq43BzP3h
         pmP/vWD3YpOTE4+A0lAWqhhtM2B9zooB8vS/vCAXaMfl7R72C5IIewKuffbq00MSySgb
         saLQ==
X-Gm-Message-State: ABy/qLbKoAeSfkxNNHJYvSlq9PVp8C7+4m8GH7x3kcAlGF3fMCqKQgch
        u/XbwjD8Ow3EcZywjMwH1Jebrg==
X-Google-Smtp-Source: APBJJlEj1Qgb9tKbA7Sfy8vR/zz9JAB7yPlr7o4/FI2Km8FLZaieuXRCN3aiPosJHI0EHoxdtbKCqg==
X-Received: by 2002:a17:902:d502:b0:1b8:865e:44e7 with SMTP id b2-20020a170902d50200b001b8865e44e7mr13591671plg.20.1689640343100;
        Mon, 17 Jul 2023 17:32:23 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id i10-20020a170902eb4a00b001b895a17429sm422711pli.280.2023.07.17.17.32.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 17:32:22 -0700 (PDT)
Message-ID: <64b5dd96.170a0220.b7992.1973@mx.google.com>
Date:   Mon, 17 Jul 2023 17:32:22 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
X-Kernelci-Kernel: v6.5-rc2-32-g540792999344
X-Kernelci-Report-Type: build
Subject: pm/testing build: 7 builds: 0 failed, 7 passed,
 4 warnings (v6.5-rc2-32-g540792999344)
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

pm/testing build: 7 builds: 0 failed, 7 passed, 4 warnings (v6.5-rc2-32-g54=
0792999344)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v6.=
5-rc2-32-g540792999344/

Tree: pm
Branch: testing
Git Describe: v6.5-rc2-32-g540792999344
Git Commit: 540792999344b81838f87e71a835d5791558859c
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
Built: 7 unique architectures

Warnings Detected:

arc:

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
