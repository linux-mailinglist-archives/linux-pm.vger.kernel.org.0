Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11BEB38CDF9
	for <lists+linux-pm@lfdr.de>; Fri, 21 May 2021 21:09:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237766AbhEUTKo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 21 May 2021 15:10:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237880AbhEUTKn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 21 May 2021 15:10:43 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E857FC061574
        for <linux-pm@vger.kernel.org>; Fri, 21 May 2021 12:09:19 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id q15so14962616pgg.12
        for <linux-pm@vger.kernel.org>; Fri, 21 May 2021 12:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=483LSWsCG8uJ8CKOWcTW7INSr4bEA9fYphw+rX9q5Fs=;
        b=Oa5Ost8RuENK30GaMttriuSwHNMP7V+sj72hSIvxREpnK0HpMpaD1krKAaqz/PrwOZ
         hYtsn4Wez8CDig6s+sUXIB4Jx/Q4m929vN9Pp6SUGMxlUE8MWn3tUzaHBwsst6pPqMvC
         FFGSW7YyfLC82jiqIQNivHM7M7ZLbEJHBMjcUXsdCKJPQaDpfZ1U7NoPzEL++aTOoFxp
         w/V3uTDbv3qQNwicuJkL81NpcHACndsqG9EFGMAbUR79cYDio83aGwGBHcn/MOp4dmGg
         EDL1XJQCRpgI6zHa+1BeEjG8Yyoo5qFSTEeNSf2VwOqj7Gbf2IUdT2rAwrQGq/4u2skA
         z+FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=483LSWsCG8uJ8CKOWcTW7INSr4bEA9fYphw+rX9q5Fs=;
        b=n781X+FF37Iv6kNE3QvtXpEH3XN3zlcPka6dcD93KTXV0E3VmnIhAwM+0/rWvjGukk
         p239wYDADyDIVLzuIpgBWVr8N9mIdKl3wLtAGV53I+YxZYwOwTaM7PAYhN6fawzhklxM
         Ep9RA+ShseFQR8so7CkZ0i/2j3o2jwd0RHz7uDorOuCb/IgSQhFwQ/c+hJIVtPOjaucz
         yYf7I0JrOPiQlmMyQ4g/sLl/j3V8pZJzGy1D/+GT3xCH1feTzNIpU1J9KDY9EmIMlluE
         BgrLG5LNpqxKC7hkl1k9WBfwar7bV2/tQdh8OV/VjHKJNVobf4lkotc4+JToVNzNcqPr
         8jyw==
X-Gm-Message-State: AOAM530edPttEpxG71PTKwyzqEcIJ6UDrUqdWRUceyIukicp7tDdBs68
        sx02U9EHF94GnCyCHVz9DfIilg==
X-Google-Smtp-Source: ABdhPJyuvXdl5fa2ru2pmZJTVCW3avjjYpg1AGJdQqq7glHC6XtXp5xqzGPhAMwSwBYjmwL9SXOPpQ==
X-Received: by 2002:a63:617:: with SMTP id 23mr175644pgg.409.1621624159559;
        Fri, 21 May 2021 12:09:19 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id q3sm4981394pff.142.2021.05.21.12.09.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 12:09:19 -0700 (PDT)
Message-ID: <60a8055f.1c69fb81.3d0b9.1895@mx.google.com>
Date:   Fri, 21 May 2021 12:09:19 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v5.13-rc2-14-g49f1b0f7d4af
X-Kernelci-Branch: testing
X-Kernelci-Report-Type: build
Subject: pm/testing build: 7 builds: 0 failed,
 7 passed (v5.13-rc2-14-g49f1b0f7d4af)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 7 builds: 0 failed, 7 passed (v5.13-rc2-14-g49f1b0f7d4af)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
13-rc2-14-g49f1b0f7d4af/

Tree: pm
Branch: testing
Git Describe: v5.13-rc2-14-g49f1b0f7d4af
Git Commit: 49f1b0f7d4aff9ebcfdc2d63dd0e94f867d69d9b
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
