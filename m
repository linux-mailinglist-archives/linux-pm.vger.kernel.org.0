Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52E8B39FEC3
	for <lists+linux-pm@lfdr.de>; Tue,  8 Jun 2021 20:15:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233682AbhFHSR0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 8 Jun 2021 14:17:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230100AbhFHSRZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 8 Jun 2021 14:17:25 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F09B1C061574
        for <linux-pm@vger.kernel.org>; Tue,  8 Jun 2021 11:15:30 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id m7so3415042pfa.10
        for <linux-pm@vger.kernel.org>; Tue, 08 Jun 2021 11:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=u+K7LdbdThKCg+E48LtoqwJG5Is1Qqw3DLz00Vk8hqA=;
        b=DruLSHwTmAhqQUJ/1HicOUhRBkFHf96ajZd2zY94K16nlMefTuDHVhjxNnB7wIzPIR
         wLe3xGFLgKaGjhfrENOynIoDUYuoj9uJREqi5blYc4HN6qBhlq0et4T3dKdTmMgFzIUp
         AJHMOV4LwoWex38UL1m3hLW908S/mkhb5grDOzkvAi3GgoSPWQVkYcku4xZUtLz2oU++
         3OQ7ASeKfGUF418jAa6pqgVtcYbo/alX0sEGzUfXxaSWIC20beOF27wQ7nxzCDbcVOGx
         KnslOqVJIWhQ73wyIm66J3laJkWbH4oiNo+Darl9jrcAvpd1+t+Si1X9/RBOPybSz4Bl
         Pekg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=u+K7LdbdThKCg+E48LtoqwJG5Is1Qqw3DLz00Vk8hqA=;
        b=a7EsUW2q2m+Jo4W8SHqKW2xYDv4/KZ3PPeKYq0LuuAR6XqRGSGbKLhjnmgTQ7lC5GF
         elw9bz+NvEOeIVzwLcdnRwF5XrY5zFzedoCaqB9vmb3grLFlPEgdsBKAv7+3uehIqhQm
         nqN8z1LqZgvSc9HXAczj6lp4oohAy3/Zp7aekM9crbIMjdRB+5Wa+bF0bL3lTjsoq4of
         fi5wvLhTQ5/pAT0fo+rdexTJishebT9icTfq1sEuX/DjtMav1DKRMfQi9Bl7d/DC5Q77
         qfqLguJFMzRV6sVSbS9oBTwrRNi1q2k3UZMWJFmOhLNU2OHehOXbMMgaEV+UwiuDpnby
         TISw==
X-Gm-Message-State: AOAM530DDU5ioSdDhrf1GtdPmzQi0DmlNhvGb5dQRiegsEKw00boZUzE
        EWxXTuOtsrwLKGp88XU3mmnbcQ==
X-Google-Smtp-Source: ABdhPJzJ5OS/2UT/iWQsZEytwqHnrYYajtNWhHRXV0qQjLsKSOVsdffzXISmnnRmAdgFTgSBu0fOpw==
X-Received: by 2002:aa7:952b:0:b029:2e9:eef1:8e17 with SMTP id c11-20020aa7952b0000b02902e9eef18e17mr1146493pfp.70.1623176130535;
        Tue, 08 Jun 2021 11:15:30 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id e17sm11278406pfi.131.2021.06.08.11.15.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 11:15:30 -0700 (PDT)
Message-ID: <60bfb3c2.1c69fb81.97200.2aae@mx.google.com>
Date:   Tue, 08 Jun 2021 11:15:30 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.13-rc5-93-g5a32725a7531
X-Kernelci-Report-Type: build
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
Subject: pm/testing build: 7 builds: 0 failed,
 7 passed (v5.13-rc5-93-g5a32725a7531)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 7 builds: 0 failed, 7 passed (v5.13-rc5-93-g5a32725a7531)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
13-rc5-93-g5a32725a7531/

Tree: pm
Branch: testing
Git Describe: v5.13-rc5-93-g5a32725a7531
Git Commit: 5a32725a7531b9d4ecec3acb3d13458f10b71690
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
