Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61C7E3AB442
	for <lists+linux-pm@lfdr.de>; Thu, 17 Jun 2021 15:05:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231284AbhFQNHX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 17 Jun 2021 09:07:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbhFQNHX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 17 Jun 2021 09:07:23 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00E78C061574
        for <linux-pm@vger.kernel.org>; Thu, 17 Jun 2021 06:05:15 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id h1so2910927plt.1
        for <linux-pm@vger.kernel.org>; Thu, 17 Jun 2021 06:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=xXb6ysTHd/ldBtSj8TJOjPTrB+rrNcdfi9gp9W1Lnmc=;
        b=1/YldkYWtyG3bI9CSkSc9LBaL5kQb/YVPUwAMQ1LUvnYdG3+LmhkGMd06eht5EhpD1
         PLVzO/XoLCmTln+Su/Jz8UnsUhm0E/6enGdN9KY3VFTd+HnTUzWk5dvr9uSmPi4Xlwoe
         BLDibiItdAGavUz6joOJr29oVczCEOmKT++W4Awn/M97VwdcinnEUdzVumyOghm6XPmV
         vEztL3HrU0zgWqtvw64iDQR4KQ1VItVTsn9RV5G3wRsRfpqxsGfFaj8PuDpiqf8awY4C
         jDaZki7DGPk2KtOvqE1Vd7YKwUQMQy2HjqLnQbKQESp+FeNpFgkAl7lc1X3Krk4jbgED
         aHOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=xXb6ysTHd/ldBtSj8TJOjPTrB+rrNcdfi9gp9W1Lnmc=;
        b=So+5a2pANN4cf1CU2YFbB51lDAtPW92AWhbM8ufJitmd3GofgrrH379L0dB+hzM7vF
         UqRAYjAyK7Pf73IogAEJLJEeGckiOt1wbElfKxN1zi4cUcYsqfklbkQsoS+BYgu3GPS6
         Y9xHHpXZvugqb5C0TQSOA8hJ47BbufIU2wcYSPBPIhKvWWz7hs0h+9BM0mPMnrgaOTeE
         QyS+qZMM5rTQhkx3xJX5uSSTHNFhiPMArdkPkV5h0Y63s29+xHV4mxRtafdfwnl3cMwv
         EDPrrkWQbjAckzujP3JLEWaDiCBWr7aXqRXzc6BL8s1yiBfysxC5jrPfuYx+KaAFzJ0X
         DyyQ==
X-Gm-Message-State: AOAM5335YZFDzLeJ7vp09ZIXHTw15zLuQ0mPJ5g2PzEt/MX060ft8dF+
        2VuDUGgbo9pi29lNkUMMETvLfe5lFiU5+KY0
X-Google-Smtp-Source: ABdhPJwpTrGIPJigDPfMc6NBT5MuxHwWU692D5FHwyhemEUg913mt+lU1NGF2Atic4Gx01VkauwXNw==
X-Received: by 2002:a17:90a:9282:: with SMTP id n2mr5457467pjo.204.1623935114556;
        Thu, 17 Jun 2021 06:05:14 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id q12sm5990587pgc.25.2021.06.17.06.05.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 06:05:14 -0700 (PDT)
Message-ID: <60cb488a.1c69fb81.26fb.fcc5@mx.google.com>
Date:   Thu, 17 Jun 2021 06:05:14 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v5.13-rc6-122-g0b73405aa81a
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
Subject: pm/testing build: 7 builds: 0 failed,
 7 passed (v5.13-rc6-122-g0b73405aa81a)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 7 builds: 0 failed, 7 passed (v5.13-rc6-122-g0b73405aa81a)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
13-rc6-122-g0b73405aa81a/

Tree: pm
Branch: testing
Git Describe: v5.13-rc6-122-g0b73405aa81a
Git Commit: 0b73405aa81ad62f871420cad57e669976db08bc
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
