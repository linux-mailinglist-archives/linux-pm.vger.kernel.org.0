Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 472BF7B07A0
	for <lists+linux-pm@lfdr.de>; Wed, 27 Sep 2023 17:05:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232302AbjI0PFw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 Sep 2023 11:05:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232289AbjI0PFv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 27 Sep 2023 11:05:51 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5BFEF9
        for <linux-pm@vger.kernel.org>; Wed, 27 Sep 2023 08:05:50 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-692ada71d79so7625932b3a.1
        for <linux-pm@vger.kernel.org>; Wed, 27 Sep 2023 08:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1695827150; x=1696431950; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=a++1MA9JjtXKLdVedADfIcPcul9+Y/N32tsRfUXxYfg=;
        b=H/rRZFMwNnmtd78Y4QLz3nO4yWBGG74WLuPqOAPLB3XAudAxijhg25r863eqyOwia5
         wc5kOkqPTreuKw2klE7gCzD28M2ayVtO2rPzaNd3Jh7tDBjJ5wlZv9PrZAaEKcgXey9a
         0MKIAtgxCMcOjlZHft/g8hYz07W3N3s11f61ZlbPvzUJVryfwXZ17hv3bH4nVAUg43lE
         HkS2kcSsVYwJfl4pORWpnIYVs2cEIeHyEWPEvuaXrCuUvjGNzcJ+g8CgybvVkJUmH3q2
         QXqlXybAEPZejEx0QuNsQhAHhMw6j+2P4ljjvnxTF7OOCigT0hWEEKbhbFgmsv7062Iu
         NHdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695827150; x=1696431950;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a++1MA9JjtXKLdVedADfIcPcul9+Y/N32tsRfUXxYfg=;
        b=UJmR85+/nZHjuCY+3OrD7tf3De/gq5kZT8QI2KqqyEwDdF0J0t8FrN/hksOS3rm2OI
         F0nFKwTXjWi5pgl3AMSNiJrJlVcyUjW81P0Zmr7nsYlR/90IZKAEcK/WBj3lMfQh1Zyh
         ZN1yIIbEjA+FMSz13gLdNwoojB8uqIxTzzX18FmxTjHi6yDZEw8eZQmduRrw4mhed19t
         3LaOrfqIXIbXnd7VbdAO+Z56wmZPv2pZhkq+Lk7dNFTtZsqdtZNSFcJOpQ4YVqvViI/I
         XSf8g/5viJMjPQOj1owoM9ij6t2t282D5Fv+8QV2YuarJVDQRi0ach8XtWuWqAMHD5LV
         kQFA==
X-Gm-Message-State: AOJu0YzxDZFc7195FPEt0VWBNgRtd1LaAGuaBleOQcbEGjIGIU2vufMl
        7AbFldHU7pm8UkB8G2i/IFPkxvw3aaWDtBh4XEi/Tg==
X-Google-Smtp-Source: AGHT+IFutOr4QhwD5i8Bsoo2tOxLRtI6EEOIdRuOKD02ngcuIp21HxHm+cexOAmM1I/AtT2rQ81KaQ==
X-Received: by 2002:a05:6a00:319c:b0:693:4143:5145 with SMTP id bj28-20020a056a00319c00b0069341435145mr756480pfb.31.1695827150019;
        Wed, 27 Sep 2023 08:05:50 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id 11-20020aa7910b000000b0068842ebfd10sm4328448pfh.160.2023.09.27.08.05.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 08:05:49 -0700 (PDT)
Message-ID: <651444cd.a70a0220.12cd6.f1a8@mx.google.com>
Date:   Wed, 27 Sep 2023 08:05:49 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v6.6-rc3-47-ga2577d67cb05
X-Kernelci-Report-Type: build
Subject: pm/testing build: 8 builds: 0 failed, 8 passed,
 4 warnings (v6.6-rc3-47-ga2577d67cb05)
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

pm/testing build: 8 builds: 0 failed, 8 passed, 4 warnings (v6.6-rc3-47-ga2=
577d67cb05)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v6.=
6-rc3-47-ga2577d67cb05/

Tree: pm
Branch: testing
Git Describe: v6.6-rc3-47-ga2577d67cb05
Git Commit: a2577d67cb05d6553674e7ddda362d22096a955b
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
