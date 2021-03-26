Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6913634AE63
	for <lists+linux-pm@lfdr.de>; Fri, 26 Mar 2021 19:18:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230226AbhCZSR3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 26 Mar 2021 14:17:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbhCZSRW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 26 Mar 2021 14:17:22 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AEA3C0613AA
        for <linux-pm@vger.kernel.org>; Fri, 26 Mar 2021 11:17:22 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id g10so1307494plt.8
        for <linux-pm@vger.kernel.org>; Fri, 26 Mar 2021 11:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=Is/MP8pMWlp9y5Z40bRiWJrv3frfeaUFfVkgfrTgq0s=;
        b=UViCZ7dxkdVyz2+CJ+7wwMtS6Gm+9k1Jb0kT1BTuxNiFfLW0xDgNWyX9mZuwUrjta0
         ws/8RRkcgDngDaKJ4irY4DRjp5WGZYSm1urOMBSV0RyMyZ48gnwxYwGhxp1ZTcGikwDd
         yQRr1zSwRoalxjGxz77YAzz5boP1zK2+OuWAY4Me9krIYvTb/MQmEwa/5pq/VQiT20SV
         wKUIv3Snv8hKrTJtpxrFVddfYTXprsdQsD9dfHeMO3H1Fh5W4Qfw4m2FwJh1EXWXu4M3
         RRLYuQL1bb/rzGYzMzv9SiWQa9cr6A9UXzye8Jm8YNGtv+B/2JMt8yWjXgiafcXgMqjM
         RbAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=Is/MP8pMWlp9y5Z40bRiWJrv3frfeaUFfVkgfrTgq0s=;
        b=iditu7V/d9Q6LJ64A9DiFBfo1bQOL/Evz1SvLNj62bkjuLX/dvOoIcaZloVokUS8ly
         mTJUITmS0986e0W7y6aU/Fphgen80GiPrMrWuuyu1KBd5ClLP++zgDUwRNiGwxOYHCaW
         KByWy2rc5rwESLT0ZhgY2R3XqdH7qhkMJ0E99mueTGgvNY/Zq9PqtCUiSnAAPsaCpTr8
         vy37Bn5g65gsokmAnuQgOltZjlej9H2SEhXJfU6kV1rb7g9/Wvt2yksVw3OtSk74DBqm
         SHPRPupvRqNfwI4oIzMBcZnzJ2xro7hDfQXN3ZvL9IObyC74otB/gS7EBdogYfwetiZJ
         CE6w==
X-Gm-Message-State: AOAM530Gf64agDIL41aJ6etZf5WYnzYvkjBA1lyUo9KK3wtpUqq93cbG
        vTP0/i/SrzvmuZPgoTzwSUor/Hi93sXJSg==
X-Google-Smtp-Source: ABdhPJxgHVEesF9yog+IgozHgy8MOQGqJpc1hi2XrFh5rgJ+lJJwxvSBqNDF6R5j83x8jXgHqp6dmw==
X-Received: by 2002:a17:90a:c004:: with SMTP id p4mr14930503pjt.202.1616782641549;
        Fri, 26 Mar 2021 11:17:21 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id j2sm9171661pgh.39.2021.03.26.11.17.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 11:17:21 -0700 (PDT)
Message-ID: <605e2531.1c69fb81.bbed0.6a69@mx.google.com>
Date:   Fri, 26 Mar 2021 11:17:21 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v5.12-rc4-49-ga78dc08f39195
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
Subject: pm/testing build: 7 builds: 0 failed, 7 passed,
 1 warning (v5.12-rc4-49-ga78dc08f39195)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 7 builds: 0 failed, 7 passed, 1 warning (v5.12-rc4-49-ga7=
8dc08f39195)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
12-rc4-49-ga78dc08f39195/

Tree: pm
Branch: testing
Git Describe: v5.12-rc4-49-ga78dc08f39195
Git Commit: a78dc08f391956cc281a98bc08f41b904ff6c831
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
