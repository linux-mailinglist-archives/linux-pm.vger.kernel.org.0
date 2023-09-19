Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1F9A7A617B
	for <lists+linux-pm@lfdr.de>; Tue, 19 Sep 2023 13:39:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230466AbjISLj7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 19 Sep 2023 07:39:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbjISLj7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 19 Sep 2023 07:39:59 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD669ED
        for <linux-pm@vger.kernel.org>; Tue, 19 Sep 2023 04:39:53 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id 5614622812f47-3adc3d94f66so2012277b6e.1
        for <linux-pm@vger.kernel.org>; Tue, 19 Sep 2023 04:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1695123593; x=1695728393; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6B+lv2o6Nr3Z6QPJl9hlNW0XPVLDd+ZZqLQCCjrPUbQ=;
        b=G8Y0GpaNCdWbtBDJMz4UsUhjx61VgYuVSSEiKJjbGMbwxCnzSwOnqRuKwN5esv1LFK
         dZ86CmioWw7RPsHU8ORttGjguV9fIISlJTDfWEbZa5ZQgBYp/w1wO4zAa/eXAwYxBI8o
         7518p+ME9S53crV6FBnLD2ayEPE+AHxyulrbYmH5UI3z3agSR750uUqNuONyIbf8m+2I
         WVPgslGXgVwlgCxelHQVKFcA5eymPeoC4aRy5xltsPlstYY2c1LHsC/7vY5QxM2GOPFI
         yLR4v9wj6vQsYEnVE8uv7LjpjiwR98+ZYgF5+Zozhq7rKcmkFYD78HrgMrYgD6cpBOjY
         a/AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695123593; x=1695728393;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6B+lv2o6Nr3Z6QPJl9hlNW0XPVLDd+ZZqLQCCjrPUbQ=;
        b=Nr+cBEDTunbtV/k2at5kdp+q8WIUgc4YiDLfVAggfQACSpyeg1zbd1zXcQ8WIYUg3R
         iZrvR46ROiuQpZOjlYOZvE+4MLUHc3v+hwo4hq0mrlAtavCPYg8BOL09KTmbVu5kbldJ
         icFM6uVXUfu/qwcz6aruG5DfwGrzjwYBKD/30DA3nzX8CThoOHJ1xfYYK02e4MTkL64C
         d7cZ6INCO3pDbohzYZ0sxYkZSD3VE0NAQ7GbBA9XABP9pqWUJIF1Qoydp5XUsxINGsE8
         ySXj/mnOU40ZqcBl2KPFxJqHCbP+60WxfAVt3ZMgPaJvzX9xu8HCwe8K4McCt7bAOxj3
         ZIhg==
X-Gm-Message-State: AOJu0YwVm/7M0I5QdudSbTqmJ8YQ1HJhY4aSoYz7zyHP+0n/ZpOglpjM
        pYvBK2oMYq8rE73afAYNz2YIWAP2a+OQFXFr5XDA7A==
X-Google-Smtp-Source: AGHT+IHUq33ifb/JNxZXQ95rwdayorDl2r1XsWilaq4zPzugOdttRkNJ0OT0eUeZZHoCfklqEV9kOQ==
X-Received: by 2002:a05:6358:8812:b0:141:bfc:b11d with SMTP id hv18-20020a056358881200b001410bfcb11dmr13498803rwb.16.1695123592862;
        Tue, 19 Sep 2023 04:39:52 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id n17-20020a639711000000b0057412d84d25sm7993612pge.4.2023.09.19.04.39.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 04:39:52 -0700 (PDT)
Message-ID: <65098888.630a0220.6ae75.b047@mx.google.com>
Date:   Tue, 19 Sep 2023 04:39:52 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v6.6-rc2-21-g23aa512f7cfb
X-Kernelci-Report-Type: build
Subject: pm/testing build: 8 builds: 0 failed, 8 passed,
 4 warnings (v6.6-rc2-21-g23aa512f7cfb)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 8 builds: 0 failed, 8 passed, 4 warnings (v6.6-rc2-21-g23=
aa512f7cfb)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v6.=
6-rc2-21-g23aa512f7cfb/

Tree: pm
Branch: testing
Git Describe: v6.6-rc2-21-g23aa512f7cfb
Git Commit: 23aa512f7cfb35df3681128dba3b9bef597fcd6c
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
