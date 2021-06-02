Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44F0F399361
	for <lists+linux-pm@lfdr.de>; Wed,  2 Jun 2021 21:16:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbhFBTSB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 2 Jun 2021 15:18:01 -0400
Received: from mail-pj1-f41.google.com ([209.85.216.41]:54206 "EHLO
        mail-pj1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbhFBTSB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 2 Jun 2021 15:18:01 -0400
Received: by mail-pj1-f41.google.com with SMTP id ei4so2197344pjb.3
        for <linux-pm@vger.kernel.org>; Wed, 02 Jun 2021 12:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=pi4C5WtnKoCT0uKkj96EhmRGcZjNEHS9ddtNkNKCxnQ=;
        b=04rX9b4IswVwbc/swVJAlKvluGRYV2jSYFfnrIvsvLJ8BGLnO51d1SCG0z/SatFCrd
         U+X6/lWrUbTXIow9TWXJz9guH4yrjZC0PBA6vwSbaOTvWF9L7bvnbQXq4t6XE4am2R+e
         O+U7XIOjgUx9TuuzhKxr+/tmAhbxuO+ARNpLBKbJcP1PXbwHD3ZwLvINDp2ZiLEKbXKx
         lsvkrP3n94XQztLHAK/C6XhQVe7D3Qa3xciemG4pv04d3BWVTOqo6RBSK44O8+Y1MH1n
         Noa6c3mg6lpoI4lHdJaNzpnPJyRe1wpsHmlZmq8+eIIgPrIbRgG0k1ZpYoGdz1Ug8X51
         c2hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=pi4C5WtnKoCT0uKkj96EhmRGcZjNEHS9ddtNkNKCxnQ=;
        b=iRgVkdKQAVcV+XvfIODVKE0nVEq7vMn0ts47jXY7d9pRpURNQd+WPbViUD8eq57UNM
         Yz3HENPGLku72seTRrl3s5KM7wWCaHVyrWPFziD+7C6IJ9WmCaWwg40lF6AJthhQ1tli
         ydJ0MQpAIfzLIMY0TxhAd9Gk1PWtNDZ/VMZRNxmBO7A6/OpA9MOXCID8DU3JiLKZLvbO
         U7ZOosHPxlyGE2WXiOjQGhnHnf2MJT/cNtVP5V+REcfTQo/UCB261JjcSLcbWRxzZckb
         kg9xGF0MW+Y8XQJ83Nm9u8/QF4bMyZR2diko96dFH1mdlbUVtCSPPhFbtZ7v50kBkX7c
         dtuQ==
X-Gm-Message-State: AOAM532cvj5JhgRutJS0sqNruIuIozxfbk7KLzgng34CpH+FTAYX45N5
        EbQ/tbhICzBX4729dzEMMp835w==
X-Google-Smtp-Source: ABdhPJzQILbcOFmjr6Ma/lysZ2FCFoy59SFjJGn8CHuNkaB5dqAlSy/Hxyy2veATzVaHBjV5aV3krQ==
X-Received: by 2002:a17:90a:7c4b:: with SMTP id e11mr7230678pjl.73.1622661317641;
        Wed, 02 Jun 2021 12:15:17 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id i21sm314433pfd.219.2021.06.02.12.15.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 12:15:17 -0700 (PDT)
Message-ID: <60b7d8c5.1c69fb81.ac188.1397@mx.google.com>
Date:   Wed, 02 Jun 2021 12:15:17 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: pm
X-Kernelci-Kernel: acpi-5.13-rc5-42-ga25ea0c642c2
X-Kernelci-Branch: testing
X-Kernelci-Report-Type: build
Subject: pm/testing build: 7 builds: 0 failed,
 7 passed (acpi-5.13-rc5-42-ga25ea0c642c2)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 7 builds: 0 failed, 7 passed (acpi-5.13-rc5-42-ga25ea0c64=
2c2)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/acp=
i-5.13-rc5-42-ga25ea0c642c2/

Tree: pm
Branch: testing
Git Describe: acpi-5.13-rc5-42-ga25ea0c642c2
Git Commit: a25ea0c642c2fa68ced9d7e9cfc85ed4ea470deb
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
Built: 7 unique architectures

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
multi_v7_defconfig (arm, gcc-8) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sec=
tion mismatches

---------------------------------------------------------------------------=
-----
x86_64_defconfig (x86_64, gcc-8) =E2=80=94 PASS, 0 errors, 0 warnings, 0 se=
ction mismatches

---
For more info write to <info@kernelci.org>
