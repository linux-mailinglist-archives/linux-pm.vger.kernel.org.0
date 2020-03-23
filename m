Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B6BE18FF9C
	for <lists+linux-pm@lfdr.de>; Mon, 23 Mar 2020 21:35:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726007AbgCWUfb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 23 Mar 2020 16:35:31 -0400
Received: from mail-pj1-f41.google.com ([209.85.216.41]:51049 "EHLO
        mail-pj1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbgCWUfb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 23 Mar 2020 16:35:31 -0400
Received: by mail-pj1-f41.google.com with SMTP id v13so401679pjb.0
        for <linux-pm@vger.kernel.org>; Mon, 23 Mar 2020 13:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=ITRfh18I7kPa25NQ0WU9lpHnAWnpCO8i/aZB4jX2Wpo=;
        b=OcdejLvY/r/sQSEE45CIxyxrms0e8IHnNplxc8YHhh2GbD8n0tJRdKDG5ONb/WOysA
         TBOihfdvTESGsU1hw98vzK7GbXkrNtMC4A9vUPvgZPK9coIJsef27jt/KjLgy5aZu80Y
         MlhKLEGORf2GfrfArJAHA+H2pA1wTlVbaioI8lbDlF4hGXfoJIHM5QL1Ys8IwoAWUfUn
         qLqQrF/ATXJFFXkPTBhy3ezw4MY4L4NgLvzWk8FJRxDlGyN7ockya33ubwJEKkV/rfQ5
         EaQnoejnxcoIpYzKq08xLwiBOWYF355GxcK00faviAnp3K7MMEAX1T7bT+2G1Y/yCZdn
         r5Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=ITRfh18I7kPa25NQ0WU9lpHnAWnpCO8i/aZB4jX2Wpo=;
        b=bnDFhI9hp89l5URR8lbLKZtt96YuZTrM9SHZArbUPen3vPP1BuzSYkuL3T7mZytNRH
         1jTaz0/gTazIgEH0K21ymW/4hA00rSzRBTZ20Eb93GEuQGAZYBAelZfqUD8Ae3g406mK
         slpcSC89805hAkhoYJfcVA3LUyItUQ5Q7PwetEitbmxhvd/E7+KImf7ghjHWs2loynoR
         +Z8ndIK/LyeusANquHn2xioazUgm2Twh+QvZp4m8PmItydKX2MRoDCJlPABqiWkq2V56
         OKWMNjLDv5SjLuLAT1YENJP3wz9MImNl4TZPyhV6yjbRN6vF9K3naPDfk8EJNm/ih4qr
         mmBg==
X-Gm-Message-State: ANhLgQ237VxS5feb5cD62FUEG4mzwKjZJmcjq6cSgK7D6kAchFtXszM2
        x+sWyBebmXmCNYB9Cg8CpbjZo1oOj24=
X-Google-Smtp-Source: ADFU+vvo82E/atqRFLLa7CNcy05aFWWQEYs39LsU5yzC+4+jRRyE5KThr3nGf2BInm5hk/KNo925Vw==
X-Received: by 2002:a17:90a:bf08:: with SMTP id c8mr1309076pjs.150.1584995730171;
        Mon, 23 Mar 2020 13:35:30 -0700 (PDT)
Received: from [10.0.9.4] ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id a24sm13734467pfl.115.2020.03.23.13.35.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2020 13:35:29 -0700 (PDT)
Message-ID: <5e791d91.1c69fb81.f783d.35b5@mx.google.com>
Date:   Mon, 23 Mar 2020 13:35:29 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v5.6-rc7-113-gc6e2eb7ccc3d
X-Kernelci-Report-Type: build
Subject: pm/testing build: 6 builds: 0 failed,
 6 passed (v5.6-rc7-113-gc6e2eb7ccc3d)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org
From:   "kernelci.org bot" <bot@kernelci.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 6 builds: 0 failed, 6 passed (v5.6-rc7-113-gc6e2eb7ccc3d)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
6-rc7-113-gc6e2eb7ccc3d/

Tree: pm
Branch: testing
Git Describe: v5.6-rc7-113-gc6e2eb7ccc3d
Git Commit: c6e2eb7ccc3d252115a7d8cba393770ec7366063
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
Built: 6 unique architectures

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
multi_v7_defconfig (arm, gcc-8) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sec=
tion mismatches

---------------------------------------------------------------------------=
-----
x86_64_defconfig (x86_64, gcc-8) =E2=80=94 PASS, 0 errors, 0 warnings, 0 se=
ction mismatches

---
For more info write to <info@kernelci.org>
