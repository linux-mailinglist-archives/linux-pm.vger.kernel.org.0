Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14C0E31F0CE
	for <lists+linux-pm@lfdr.de>; Thu, 18 Feb 2021 21:08:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231570AbhBRUId (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 Feb 2021 15:08:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231896AbhBRUGl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 Feb 2021 15:06:41 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01DE0C061788
        for <linux-pm@vger.kernel.org>; Thu, 18 Feb 2021 12:05:56 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id o38so1832243pgm.9
        for <linux-pm@vger.kernel.org>; Thu, 18 Feb 2021 12:05:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=6dTck9PY3mL5nWCkfn4cWijMA877+yDLpdie40GUDLs=;
        b=F8VcbDZBLF7kGrNeprzEqiZsydP6f1yQ1N8cOe7234VWdYUbbHYslP/F/9Eyc9vd6A
         rppMlRXwdLWToZqBV0F+Onx6GUMpOe4CblmRzGb2hVwT29xc/G0vlqPiRsCHPDZD7TL5
         lWOfY3YPms1x2U/QO1S+fhNgLnef/sqLyyn+8Xky9thyQWVGfBXWmbjmknkzZXKqqzoC
         HGizHAtqT8isMAbxolaPonTNtwhZZbVwN+IBkanyHNzRkRWMLPtRcb1czxpabU8SfjKc
         mH83fYAhmzAUUjIHxDNhla2mO/WGRCjpy273e73ilArjRzIBJLfTn08Z6ilFemy4zrDp
         c2cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=6dTck9PY3mL5nWCkfn4cWijMA877+yDLpdie40GUDLs=;
        b=eE+/T6Lv++HVmhVwyM+D2PckdrstpZG0HYncmR5Afsutff50pAxo9xsDQXLF4ckRZD
         cKrsKfnMLCwlxnOwBI0GYjufVEPYdjRfhMuRgbszeIyE+BK3MJD8wgcPQlQEW5MUxc3i
         V3U0vD3yU29L7WWXc/RzQqJVpTT+ObNNZOnVYz47wensc/S6yuwTWFu4abghPwiPl1vE
         nOOgA8WDUtFh8GAkIqRxFF0DsvfqJcJhQ7q8gHcESvVZNGka3gf3dckIAKIdBTId+noo
         Ba0BZJwtU4yuYZkEnX/DCR7KbRzukkdlatQULRoQw0mnHf4MQ0KjJgVR3OETKkHG2Euq
         zQ2A==
X-Gm-Message-State: AOAM530PJ16DwR17lbIbU7yPlRD9/BDnu1a8oKE8JxUpS7ebm/yw819o
        XgpnrWmUlhvsLehZ6Spz6RMtwgglE0Q3Vw==
X-Google-Smtp-Source: ABdhPJxLfe1vt35g2LumvDz2X9x27dy3OKvbY2FUf5vy5Gg5tK+yLZI2TjsO4m6+Sdggdl9hZaqGpA==
X-Received: by 2002:a63:5c61:: with SMTP id n33mr5509464pgm.153.1613678755556;
        Thu, 18 Feb 2021 12:05:55 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id 8sm3231957pge.92.2021.02.18.12.05.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Feb 2021 12:05:55 -0800 (PST)
Message-ID: <602ec8a3.1c69fb81.b1b94.6a5a@mx.google.com>
Date:   Thu, 18 Feb 2021 12:05:55 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: pm-5.11-rc8-201-g8b72d3aa065c
X-Kernelci-Report-Type: build
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
Subject: pm/testing build: 7 builds: 0 failed,
 7 passed (pm-5.11-rc8-201-g8b72d3aa065c)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 7 builds: 0 failed, 7 passed (pm-5.11-rc8-201-g8b72d3aa06=
5c)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/pm-=
5.11-rc8-201-g8b72d3aa065c/

Tree: pm
Branch: testing
Git Describe: pm-5.11-rc8-201-g8b72d3aa065c
Git Commit: 8b72d3aa065ce33df4f042840078542b1e5d2c45
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
