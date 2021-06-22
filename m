Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ED9F3B045D
	for <lists+linux-pm@lfdr.de>; Tue, 22 Jun 2021 14:28:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231181AbhFVMat (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 22 Jun 2021 08:30:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231598AbhFVM3K (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 22 Jun 2021 08:29:10 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10F49C061574
        for <linux-pm@vger.kernel.org>; Tue, 22 Jun 2021 05:26:55 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id e20so16983791pgg.0
        for <linux-pm@vger.kernel.org>; Tue, 22 Jun 2021 05:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=rn23lz9+ZsFBagDuO6GXp2Y6h6QY+oC/QFMT8WiVZ9w=;
        b=goLfY1Yx56kumnREB0xvGwtIFtB2RW0ogyxwEs9GuRz9c0f0S/xxdIakEMjxz2lKOh
         4Md55FU4yt0tO3Md3AUbU9iGbZ8abuxNIN8MbPTKA3oupSdQdmjhJBxXN8b1VDZjjPmH
         Um+0TZFZ9AuCe6Z5cE6AHl6nrimLMbj+RdXdwfK8tRDzNdkKNSBPWrrXMv+u7E/RtHTs
         gBwLk8Pl0K/vMxW8k48qNUDeOmkmZiFqftn/RWgF0YcaPFa4fdlHrs+f6EUbzCXJkOtq
         vb1aD/Oj4bDQhxrMRhQQCm0aOn6HpJxR/LMgkl0FJX3H2vHvaZrucDL5NRJlldIT2e5D
         MlNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=rn23lz9+ZsFBagDuO6GXp2Y6h6QY+oC/QFMT8WiVZ9w=;
        b=mZ1dCCKZWNypuFH3f+yG4RXst8xV8kLqGuoNjmrCaRG3u4bZV7fUy6nqKZb1gPwluw
         +g4oggDmmMUxhPsbDkiwt6LAhZUXgZymMkxOu8K2Rhim6tYbEopAo4Rz7rfG6JJBP+aF
         EC9v+Dpubo5GNWYKnKoNR55HZrec/sLuzbEJUGUrmNWnGGxpp7qpZ0lW02xRQOh+A1wP
         F/aWYb/V/qQrZHaF8eI1b1qfb2Fm+i4ZqVYTtQqVcNMpEnfjF7XJ89NMvyznaQpcMeGd
         zU8MrB1f6m0FdHBR2xf8EkaKrcbsoAbXtwDgFzOt/45Ugz1xKdA6jPYM0UTja/HCAvLz
         JSAg==
X-Gm-Message-State: AOAM530cVZs5AZFFKq3ofn+PgX1yaRBcbhRnlBHbKLqQ2+0r6OCaMgBr
        OCOQ0wn4oXkpFWNBNzwi7G+NqA==
X-Google-Smtp-Source: ABdhPJzSDQ8Guim3I3F8WXbXSIcesoPwv/cvlh0sbS1aWXSmaFBCWtp5c8J8zF1jJwhiVkiK55R/Yg==
X-Received: by 2002:a63:aa07:: with SMTP id e7mr3537869pgf.170.1624364814621;
        Tue, 22 Jun 2021 05:26:54 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id r134sm14869976pfc.68.2021.06.22.05.26.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jun 2021 05:26:54 -0700 (PDT)
Message-ID: <60d1d70e.1c69fb81.856a7.6371@mx.google.com>
Date:   Tue, 22 Jun 2021 05:26:54 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v5.13-rc7-145-g1b02478a82ab
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
Subject: pm/testing build: 7 builds: 0 failed,
 7 passed (v5.13-rc7-145-g1b02478a82ab)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 7 builds: 0 failed, 7 passed (v5.13-rc7-145-g1b02478a82ab)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
13-rc7-145-g1b02478a82ab/

Tree: pm
Branch: testing
Git Describe: v5.13-rc7-145-g1b02478a82ab
Git Commit: 1b02478a82abb3950fbd9d64cf8c7d404ffe08d6
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
