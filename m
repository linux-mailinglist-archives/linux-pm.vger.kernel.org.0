Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C34CE3D6773
	for <lists+linux-pm@lfdr.de>; Mon, 26 Jul 2021 21:21:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230488AbhGZSlN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 26 Jul 2021 14:41:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbhGZSlN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 26 Jul 2021 14:41:13 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3FC0C061757
        for <linux-pm@vger.kernel.org>; Mon, 26 Jul 2021 12:21:41 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id f13so2405110plj.2
        for <linux-pm@vger.kernel.org>; Mon, 26 Jul 2021 12:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=kW02NH4JkLTTeQKWGZHEOKD/xfYe3UpcABTowE9yy3Q=;
        b=00rKTMdeG6mMfOEQf6uZHkD0Dz+Ize89AjPZJV2M+TMonfMSdOB7pzmmnesHgzvyTO
         wzgizFp3NrqJvT0+H9SMJSlN/lvk+W4wybf1gohRcoHXkBDHBxPUZsLf8h+zFaQN5AT3
         9k97wZMPlEzBKgRFTjQWRXN6nqSa1GKaEUg6lwdvalUrY0kq7uS8rtdhOSvQKwd0Fo2w
         UgT5LMGGC0K0KFzfBo9C29ZrLE6T+bw9RKsp46wpmbbeqftbyXccoaZKfel/J+ezryO2
         +vYewbiEszkcW6vcU0DCmp8oWFwgOPX1cNlb3l130eH8GC7j0SxWNGvlWVhu3flhm9kR
         a1mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=kW02NH4JkLTTeQKWGZHEOKD/xfYe3UpcABTowE9yy3Q=;
        b=U7yz0LxHmey4/R71940ODSnV41m5WbJG3pWV8evLDFdOO+WhYnVqr4tUdr65ULsVCK
         gO8IuhTHJQX+tVRfkB9rw1Dq/WYXREwUFqel48DPQYBHjb3nR/uDMPwxb2NaiIJ+BW4M
         exERniQdjj3bGDhrydFtn9C7+TcGnwxRx700+0djcrt/FqK8Jrxa+I2mfXumCgjNL0gU
         xaZkqaTf09z0y9c0xJlGgrQTB6eDj4a71+fPm6SlZxzVUq1VFoZS8Aiw7O+v2iwF/DmY
         TtX6Yew/kMDx1PVjgYZVFunJwge956xTHwSE0aZ5efd5VZx91brsVyxJADrxB2D5f7hF
         mOLQ==
X-Gm-Message-State: AOAM530NCesZkz5FijJyf3T58CCjq3GR2f8QUMtXU87pO6VxUS1uMV88
        YfXPs3NYUYFs2TScjbLwlzAPyQ==
X-Google-Smtp-Source: ABdhPJzyrhC6jJm7y2eGc2ejP5omR5jGnycG/iWk224URBOCih5VttIDJ6DCs8AZT853Q17PshCNGw==
X-Received: by 2002:a17:90a:46c2:: with SMTP id x2mr17888002pjg.197.1627327301525;
        Mon, 26 Jul 2021 12:21:41 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id t23sm831138pfe.8.2021.07.26.12.21.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 12:21:41 -0700 (PDT)
Message-ID: <60ff0b45.1c69fb81.9c12a.36ac@mx.google.com>
Date:   Mon, 26 Jul 2021 12:21:41 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Kernel: v5.14-rc3-16-g1dae4a65c011
X-Kernelci-Report-Type: build
X-Kernelci-Tree: pm
Subject: pm/testing build: 7 builds: 0 failed,
 7 passed (v5.14-rc3-16-g1dae4a65c011)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 7 builds: 0 failed, 7 passed (v5.14-rc3-16-g1dae4a65c011)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
14-rc3-16-g1dae4a65c011/

Tree: pm
Branch: testing
Git Describe: v5.14-rc3-16-g1dae4a65c011
Git Commit: 1dae4a65c01109508ee17281b6d92b734d7bc1f3
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
