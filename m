Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98C6A2FDAA5
	for <lists+linux-pm@lfdr.de>; Wed, 20 Jan 2021 21:20:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387789AbhATUSr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 20 Jan 2021 15:18:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388255AbhATUSn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 20 Jan 2021 15:18:43 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77736C061575
        for <linux-pm@vger.kernel.org>; Wed, 20 Jan 2021 12:18:01 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id x18so13140941pln.6
        for <linux-pm@vger.kernel.org>; Wed, 20 Jan 2021 12:18:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=9s0lNYGOLKxB00+xV/C3Jl4+9XUvHC83RBRw0aqYRvc=;
        b=pnq9WgPx9aqXaaRTYlIGv7xzyB3FJSu3aB61fPCC8J2vv3SaY087sfejaaYZrpNFL4
         +Va9lQFMAHN/W+RCzjz7PuVP++9e2LbVGJV2nD2uY9M+kAvw5wxEJsIDKM4z9QROQvM2
         1sxOWsbrwPnqEOcg/IxcnmyTDaimIqtDYVGWMk48WGlKtWcPADe8galK7YtT+nOvc47C
         /INc34WjFzRbNs6GOC4/jLTNfdKWtA4J4SnXZEJKFHVeA5Hp8p8c74thKAZVcBokMeZ4
         mrpCgsx7SbmQF1BVX6vMZf8fY3xGOAEG7ZMCHIyqcBAG5UiEJcPyGlwT5qdAt2M6w3XF
         8VIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=9s0lNYGOLKxB00+xV/C3Jl4+9XUvHC83RBRw0aqYRvc=;
        b=e7uh7ap2DDQ5AyZD/Dh2u6oT8tSwz6zpuS4qETeh+FOGFdO/1rouGtBPid51q7Gb3M
         HVd5xrvPQNCvOf8IpIUWv8L37OyvwtVhBUzlPLvVgJHRBh3omIcupKsTSYOqUVinEGbP
         6tQyJspaYvVbaQzWw/5wbszXocUu0DEWdYZ3VxRSFVv9RenD0PtuQgpr6JAFPUDJg4RZ
         8/ua+s4y1YzJQjWdCLMSb98W9gB6HFj/ditIANXfQPScm/79nsbr1zv4s28XpSf9nsOE
         4P3PgigsJQuonaVMktDenT0GbmQOFMLNvr5fgWTiBBlQ9tg4dF31PbSYXP5cuKdPBr9S
         4GHQ==
X-Gm-Message-State: AOAM533bg9h3btTpkIoXAkjugU5JPOyaepvczev0GDHvmhOMeq8Ya2Zw
        K5/3q74Tc3QMJqbIlPsRBC5N9w==
X-Google-Smtp-Source: ABdhPJw0w5qWHPUGi7vXYF5MZ21zwx0CZxg5bejUkh6EM+pjdnt+ZKOKhvbTeLLFzDKCCwBYhVf+3g==
X-Received: by 2002:a17:90b:3805:: with SMTP id mq5mr7534658pjb.93.1611173881075;
        Wed, 20 Jan 2021 12:18:01 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id w21sm2411525pff.220.2021.01.20.12.18.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 12:18:00 -0800 (PST)
Message-ID: <60088ff8.1c69fb81.18e3b.4d18@mx.google.com>
Date:   Wed, 20 Jan 2021 12:18:00 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v5.11-rc4-28-ga31400ec480e
Subject: pm/testing build: 7 builds: 0 failed, 7 passed,
 1 warning (v5.11-rc4-28-ga31400ec480e)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 7 builds: 0 failed, 7 passed, 1 warning (v5.11-rc4-28-ga3=
1400ec480e)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
11-rc4-28-ga31400ec480e/

Tree: pm
Branch: testing
Git Describe: v5.11-rc4-28-ga31400ec480e
Git Commit: a31400ec480e8a579467fbe36d7ea49c952109dc
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
Built: 7 unique architectures

Warnings Detected:

arc:

arm64:

arm:
    multi_v7_defconfig (gcc-8): 1 warning

i386:

mips:

riscv:

x86_64:


Warnings summary:

    1    drivers/pinctrl/nomadik/pinctrl-nomadik.c:952:8: warning: unused v=
ariable =E2=80=98wake=E2=80=99 [-Wunused-variable]

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D

Detailed per-defconfig build reports:

---------------------------------------------------------------------------=
-----
32r2el_defconfig (mips, gcc-8) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sect=
ion mismatches

---------------------------------------------------------------------------=
-----
defconfig (riscv, gcc-8) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section mi=
smatches

---------------------------------------------------------------------------=
-----
defconfig (arm64, gcc-8) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section mi=
smatches

---------------------------------------------------------------------------=
-----
haps_hs_smp_defconfig (arc, gcc-8) =E2=80=94 PASS, 0 errors, 0 warnings, 0 =
section mismatches

---------------------------------------------------------------------------=
-----
i386_defconfig (i386, gcc-8) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sectio=
n mismatches

---------------------------------------------------------------------------=
-----
multi_v7_defconfig (arm, gcc-8) =E2=80=94 PASS, 0 errors, 1 warning, 0 sect=
ion mismatches

Warnings:
    drivers/pinctrl/nomadik/pinctrl-nomadik.c:952:8: warning: unused variab=
le =E2=80=98wake=E2=80=99 [-Wunused-variable]

---------------------------------------------------------------------------=
-----
x86_64_defconfig (x86_64, gcc-8) =E2=80=94 PASS, 0 errors, 0 warnings, 0 se=
ction mismatches

---
For more info write to <info@kernelci.org>
