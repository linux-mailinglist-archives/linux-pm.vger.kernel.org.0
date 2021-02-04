Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FC453100FB
	for <lists+linux-pm@lfdr.de>; Fri,  5 Feb 2021 00:48:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231286AbhBDXrd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 4 Feb 2021 18:47:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231254AbhBDXr1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 4 Feb 2021 18:47:27 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35FC4C0613D6
        for <linux-pm@vger.kernel.org>; Thu,  4 Feb 2021 15:37:47 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id a16so2599461plh.8
        for <linux-pm@vger.kernel.org>; Thu, 04 Feb 2021 15:37:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=/w7sZOIByAjRaoebtQFL0fDDQeJInEUxk36q3cZwmd0=;
        b=SMiXG6XcqnaHl/IBjGVX2Qq2uJLjqTCs2iofm6LjGSuCe/eQJ1x+ByHQ0vH23BWeN3
         iM6e1xHkzhkbZK62TlbJFRCc45uHBkKL8TYUNhl7iu/ubA9xy/Pgg2j4j7IwUYXUM29P
         VHo70ECkwbMTEkzHMJirsdYUtla/3Xw40aV3cXMdCKQxmIgNOItVag/OrlCkgZg/eU0w
         F53XvcMbnHyYqjooqebe2PJi9S6yKi5FWLuzEGCoDwVZ6klNe6JfgYs0lEYN3KZvv9C5
         HdJZVL0pDSjN7VcMH+cCro9+prQvQdkKrcGLKouq4C2aDKMPHpfoOBvPC81mvTQy1jGO
         JTGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=/w7sZOIByAjRaoebtQFL0fDDQeJInEUxk36q3cZwmd0=;
        b=sSBwzFia346tgD8IP5UV9Vc1Wyna1Wra+NzLRyr/OoMDm9NchKtrQIjI6b4kKrH2Eo
         2UoVrgXnsCVnSMI7cjw1lw/mx2sDb8p5hjx+418Wb7yfixA3JXCiA/LQpUu11LVEVf2O
         aHHvpOtIs6gjCqRai/ZyFhzRuv+bAPf+XQAE/ivsr+Q7rlVZXGhp1dBfqLl9xX5FJLsJ
         xhQd+YYlFZctr3BH13wwaJo1Y5nr67J45iELcYUCB3bAmJfj4qK+zZKLlgscw/bOB/pF
         FQFQU+0R3fLxfZBlqnZr4GIYMlg4qhXhNpAH6A1gcRoQZYSjg1+84PnMEEkmArTHJE/U
         oNIw==
X-Gm-Message-State: AOAM531Ixsy/Nv4R9qzA0xOzTZylrRhBJfMEHhoyqCc0nB8titUfJ0Uz
        T2A7bnLIAO5c37GJMBKVf7nIWA==
X-Google-Smtp-Source: ABdhPJwxEWpZfksvTNVrIvyWQ/I9IczC33BfC7/TMjTj//uAX8zmxqSp3XwKeEE8eXg/xzhMUzo3QQ==
X-Received: by 2002:a17:90b:3805:: with SMTP id mq5mr1324205pjb.93.1612481866817;
        Thu, 04 Feb 2021 15:37:46 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id gc13sm6309202pjb.11.2021.02.04.15.37.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 15:37:46 -0800 (PST)
Message-ID: <601c854a.1c69fb81.64695.e17f@mx.google.com>
Date:   Thu, 04 Feb 2021 15:37:46 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: acpi-5.11-rc7-89-g5f8da9ef1c5d8
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
Subject: pm/testing build: 7 builds: 0 failed,
 7 passed (acpi-5.11-rc7-89-g5f8da9ef1c5d8)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 7 builds: 0 failed, 7 passed (acpi-5.11-rc7-89-g5f8da9ef1=
c5d8)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/acp=
i-5.11-rc7-89-g5f8da9ef1c5d8/

Tree: pm
Branch: testing
Git Describe: acpi-5.11-rc7-89-g5f8da9ef1c5d8
Git Commit: 5f8da9ef1c5d88b9a6de64ad33d98e2edd58ce89
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
