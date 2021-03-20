Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1967A342A2B
	for <lists+linux-pm@lfdr.de>; Sat, 20 Mar 2021 04:16:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbhCTDQG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 19 Mar 2021 23:16:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbhCTDQG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 19 Mar 2021 23:16:06 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1487AC061761
        for <linux-pm@vger.kernel.org>; Fri, 19 Mar 2021 20:16:06 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id c17so277447pfn.6
        for <linux-pm@vger.kernel.org>; Fri, 19 Mar 2021 20:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=92bIOsnUSlLy7LUOcHzEbyCRuNHVI9Gwb93VKNiHO14=;
        b=llARcuytjEHU/jAQB3GX6ZWI9ODBNZzuqUauFDsjrwsCJ/nmxdZRJZrtnk5aLONRkg
         1PdOuSLm4Sxin2ckNlI8VhAjYSN09oz+rFvfnMvMEQVeWo0MRDQNyuxYbxNaws//RkXP
         iHVHHTwyv66KdH1fNyjJIdrsMv7xwtSCr0tQpxqzIjZsFoNMUdbRBBrpm069dKu7Y3B8
         Asq89cJ5PvytEd4ajep2l3HOTVBA4sSLCrnQfcwH8ZHJWnIl6KRy+emT+FUqsqA2ZbPO
         Meg2IqDhimLol0CHUwz7DqW3gz2AC3sU1AltpD6jnoyUPHIGbagevNTQDuuSsNbnfxTt
         OKhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=92bIOsnUSlLy7LUOcHzEbyCRuNHVI9Gwb93VKNiHO14=;
        b=JAAhTt879l5OJbA9+wX7RtWnCIXDTorUn03hh1qETSGIj2Ff+SRubKJHvoXGQNymvh
         Yq8HWUUFyf+fQ2VWyoOVjVCoVhTpAoW5SjIlOgOqm3eiIuZ+lJycmznRp1PhiPFPKd1/
         Uo9WgZ/BbF0i9Qvp6simOjXerv06Yv1ubRa/3DMR/Hrj8nQ01GJzWADdzvxYF2mX56/F
         ls9oyR/o6Ddgfa0JgsTwtJL3CbCJwoCX8BhdrErAEY6FIJq7F+z0DKToJQFMRsdJXki/
         aDdw2vvnTzd2kJPxvorbeKG3ZXP6WAxp1flc0yzjHH/lJ0MKodmzdMvWiz7f2+GWlYnW
         i9AA==
X-Gm-Message-State: AOAM530LdiYwKXPJHkONKcqJ6M8JO+chRSV+eQ7X3pzsLz0lj81lvCqi
        r7BXG83hFyojrNHdCOpvNwOjrg==
X-Google-Smtp-Source: ABdhPJwu3RXuJwTXpyfNOvYlrHgnBFbz+b1YUQDwqdElSZ5k+2jSIXknaMHhJLyJlxiYs7jHFUP4sg==
X-Received: by 2002:a63:e04d:: with SMTP id n13mr13948236pgj.185.1616210165418;
        Fri, 19 Mar 2021 20:16:05 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id z22sm6434975pfa.41.2021.03.19.20.16.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 20:16:05 -0700 (PDT)
Message-ID: <605568f5.1c69fb81.fa99.0ea7@mx.google.com>
Date:   Fri, 19 Mar 2021 20:16:05 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.12-rc3-29-g4bcad1ff6cfa
X-Kernelci-Report-Type: build
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
Subject: pm/testing build: 7 builds: 0 failed, 7 passed,
 1 warning (v5.12-rc3-29-g4bcad1ff6cfa)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 7 builds: 0 failed, 7 passed, 1 warning (v5.12-rc3-29-g4b=
cad1ff6cfa)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
12-rc3-29-g4bcad1ff6cfa/

Tree: pm
Branch: testing
Git Describe: v5.12-rc3-29-g4bcad1ff6cfa
Git Commit: 4bcad1ff6cfaa94d624c70322135621042c25124
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
