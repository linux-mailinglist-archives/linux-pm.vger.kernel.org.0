Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C1673D9BC8
	for <lists+linux-pm@lfdr.de>; Thu, 29 Jul 2021 04:29:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233372AbhG2C3n (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 28 Jul 2021 22:29:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233256AbhG2C3n (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 28 Jul 2021 22:29:43 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6D2AC061757
        for <linux-pm@vger.kernel.org>; Wed, 28 Jul 2021 19:29:40 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id a4-20020a17090aa504b0290176a0d2b67aso13235531pjq.2
        for <linux-pm@vger.kernel.org>; Wed, 28 Jul 2021 19:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=E9TA+nWKlXjyVnoR3JHfAb4l8ybX+Ut0WJ6MpFny7gY=;
        b=qAH76GGU5YxECd96614egoHDpdsmMWmORmWyzqbTt3pZa94KuCqbEHYkznCIitPX49
         56pQs4eWhm5aIle0bKRFPsY0puyZIyX9ZHOzVl/AFNMLtOK0BhoIbZYZj8NsoA7Cx+dT
         FW8QxhPac0TqqwTmEwAP8m6Pnk8xn0nslufpvyHjXLrNDDjiomA432thKpPFrJu59NhK
         nz3zy9v2w/Miiql+/42+dbmB9g5fNdOqPJUoG6vLv1NpU9SRCtLeBxNjatfPv3OIeeM0
         XxIgG93Xo2XvSY094H0QZJBhBgNSdDgF653Y62j6W6lLmOBRo76nQ6mQGieZSxDxBhtk
         uQNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=E9TA+nWKlXjyVnoR3JHfAb4l8ybX+Ut0WJ6MpFny7gY=;
        b=ubKLJZ+sw7rZuyqE4DJaKks0YQcwvtzpSdkOsUbhAfBEFvZrEhoaZnPctwZ+WLvzfP
         cCBA5RjuUCeZdDTmhdVG5MeIXvUDEbNdL7M9Cxpy/JOgks5U8fndKFicvRUxEy9fCTbI
         zSJzHmB8omOXCUoaizqyO6R0L3llr4S4RH0ejAkLDytPTIHPtIGrpn1GiUmkeR2RYj9+
         OlEgjVHqdTpwb7o7614YeN6uvC2W3uoDgjp+Cbx3M8PhpskE6ZgA46d4rKNh7a/EczwI
         dkS1uv0aau28JwLEVBr1zOAxT0McZuVUr1+f0d+SIQr7N16U2VfxzaRsKB7jke1IPKlJ
         TIvQ==
X-Gm-Message-State: AOAM531Iie6xXEpdijiPBvRNNFInKHYZVbMNtvitXGpTQk5crzzzquxc
        JgJ92fGNUbTo3vNuPKdh6IfJUA==
X-Google-Smtp-Source: ABdhPJxng5yDmtBQrG4QnSJhZds1/IqoQrYk8wf0srlZ7UMcikw6ZwsR+lvmXdBhzQVVW/BciY/2pQ==
X-Received: by 2002:a63:c058:: with SMTP id z24mr1798555pgi.220.1627525780307;
        Wed, 28 Jul 2021 19:29:40 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id x10sm1376546pfr.150.2021.07.28.19.29.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jul 2021 19:29:39 -0700 (PDT)
Message-ID: <61021293.1c69fb81.cb9d4.5bf5@mx.google.com>
Date:   Wed, 28 Jul 2021 19:29:39 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v5.14-rc3-20-g604483c9d252
Subject: pm/testing build: 7 builds: 0 failed,
 7 passed (v5.14-rc3-20-g604483c9d252)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 7 builds: 0 failed, 7 passed (v5.14-rc3-20-g604483c9d252)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
14-rc3-20-g604483c9d252/

Tree: pm
Branch: testing
Git Describe: v5.14-rc3-20-g604483c9d252
Git Commit: 604483c9d25283debe498a972c2b4565581e3aaa
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
