Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11398351AE5
	for <lists+linux-pm@lfdr.de>; Thu,  1 Apr 2021 20:07:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237078AbhDASDd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 1 Apr 2021 14:03:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237128AbhDAR7f (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 1 Apr 2021 13:59:35 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72387C08EBB0
        for <linux-pm@vger.kernel.org>; Thu,  1 Apr 2021 06:40:40 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id ot17-20020a17090b3b51b0290109c9ac3c34so3090269pjb.4
        for <linux-pm@vger.kernel.org>; Thu, 01 Apr 2021 06:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=bVDnPlNnjqbgpQGzavlda6brSZnN61XQvhUSzwXhr/8=;
        b=vMuEQRdhiMo7rFdB3dnK4gIvrKvSJ2NR48Y7ft6h6KTCR1agr1cIsJxCODlAFPLs8W
         82LZ/YBoz3mzyp8ydcGJUqu+3kz9kbxxJgV3OYSa7A7fWZtAuLIpcfu8Pd4+IkgB64+q
         pdtwXsznkd929hiROBw6IH6q+RByK1gWzCSkKYgpPLQIVnaZhmRPO+caW9v5wkEX1M0h
         msAvsv9UG3dGsr0HsGSnQ/YNUjIF5mvs6FAOb8DcUwOMOjzz27XtBbir7O/FT1IJVrjZ
         t0DEjpg6P2ljgW9N6KslanxF2BL7YSjtpSFDcZNdbOSHOcyXfb1jkkPa5FlPS5fXdmWh
         OWKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=bVDnPlNnjqbgpQGzavlda6brSZnN61XQvhUSzwXhr/8=;
        b=nCBZ/EqNFqLlYfjakR4dbgoO3zAf64jprmVouVSU0/P6La6G6qOT9I/USc6OvBIqXq
         wiOEzm77g8KtWJXwZWQ0jJ2rF68W7x06mSSj50wKU3ct+Wp6T1WLcrwrZssPYVSAQlne
         wRPua0rBsmU2R1Ti2y4Nb9HQqi1Pn+xgpqT7hrTGzVlaKjGfTLLRL77ycn2YCZYXMnp3
         L/bsNU5m15e+3su5b8tarSuPNHJzs8KNyMLvszqv7ajJntp5KxmCfgXXt18LGHIl17Nt
         josazkDHdE2TiPcA5ETU8GlJg9cZgTNjJBozgn5RZuVSaOa2YBpDNVBLzxEcJWpbRd1a
         h2ig==
X-Gm-Message-State: AOAM5336GMiM0gpBsZTjumrkWvesdoROb/2AFlxIivMaTCnAw5DGJ8hM
        86Poh/j0SrVhFBoXt20yu49u2Q==
X-Google-Smtp-Source: ABdhPJx28qilFkDBFANUYcjrBeA+aUH4MLvmevLvqau/CK2zuVMMEycNSDpcJ8EtWhQFpkhZkItuWA==
X-Received: by 2002:a17:90b:360b:: with SMTP id ml11mr8664142pjb.98.1617284438477;
        Thu, 01 Apr 2021 06:40:38 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id d20sm5857735pjv.47.2021.04.01.06.40.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 06:40:38 -0700 (PDT)
Message-ID: <6065cd56.1c69fb81.7ff93.e5c8@mx.google.com>
Date:   Thu, 01 Apr 2021 06:40:38 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v5.12-rc5-47-g85f34ae663986
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
Subject: pm/testing build: 7 builds: 0 failed, 7 passed,
 1 warning (v5.12-rc5-47-g85f34ae663986)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 7 builds: 0 failed, 7 passed, 1 warning (v5.12-rc5-47-g85=
f34ae663986)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
12-rc5-47-g85f34ae663986/

Tree: pm
Branch: testing
Git Describe: v5.12-rc5-47-g85f34ae663986
Git Commit: 85f34ae663986081df77a1df26e08fd1978573a3
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
Built: 7 unique architectures

Warnings Detected:

arc:

arm64:

arm:

i386:

mips:
    32r2el_defconfig (gcc-8): 1 warning

riscv:

x86_64:


Warnings summary:

    1    WARNING: modpost: Symbol info of vmlinux is missing. Unresolved sy=
mbol check will be entirely skipped.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D

Detailed per-defconfig build reports:

---------------------------------------------------------------------------=
-----
32r2el_defconfig (mips, gcc-8) =E2=80=94 PASS, 0 errors, 1 warning, 0 secti=
on mismatches

Warnings:
    WARNING: modpost: Symbol info of vmlinux is missing. Unresolved symbol =
check will be entirely skipped.

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
