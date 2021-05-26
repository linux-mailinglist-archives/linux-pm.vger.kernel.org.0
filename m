Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31B19392254
	for <lists+linux-pm@lfdr.de>; Wed, 26 May 2021 23:49:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234254AbhEZVvN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 26 May 2021 17:51:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234205AbhEZVvN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 26 May 2021 17:51:13 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AA11C061574
        for <linux-pm@vger.kernel.org>; Wed, 26 May 2021 14:49:41 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id l70so2106072pga.1
        for <linux-pm@vger.kernel.org>; Wed, 26 May 2021 14:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=OkNgLgOoV5n0nO7+Ma0yOeBGAMvB9JC9ck4sVe/c+kc=;
        b=C5FxLbcmWt3zCLwmbt54jVjht2ji1TTgLa7wTkBEd0GENaMZ1BzXJ9j35abGhvVa0Q
         aOmlFgoM/KTkeyqp/1o2qUGcmeReHDFfoChi2q8ix/EcrevSSfupm9EQ8ZXsB2j4eeNe
         n2xOQAkaGra6BD+9NLZ71Izd3kE4ZZNm0TD7SQ5704D6RKnG/nVXSWHrgs5ZlWxh8fbl
         cWPGl6YYrpKCcEJ3eofHLYRrumiw1RsAxgaHr5U7d/liRa7p5PE0RvaULzIaXf/o6fw8
         JzEleIiSt0DB8Aqn/iOgykwiszjIpr/Jteyhi3VNMo05bw/0QnStCR3ULX1TOZkWQSxl
         Ndhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=OkNgLgOoV5n0nO7+Ma0yOeBGAMvB9JC9ck4sVe/c+kc=;
        b=KG1jjCc4Jr2GgBd/2Sa9jIQTRKLczVVOcyWOZWoUcXUoS9zATuKrzYFKPXTolXZAOE
         CoQUMXg+rBGQ6N+D6p2J+e75kX4Ce7UHGRZw6c0/pHoDJc0lyL5TrBv0rxkTNxvKu/jj
         Ix+U46DymY/Kt1cfDkv/mEdhW3bm6Dxnatif+k8VIC6V64J/oWsSbogaE5N8XYnvyBrh
         6qic6rvcSWL19APpc84021zU6+9AfaZLuYZeGRLWzA76pVlLJnKRH2ypuNA9nwQhHgME
         J0BB+JLZ5AXKxiTKwzm/LO68AsAdWHyoSFBsa2PdEjTc4uNwUmwkOyiIwrXKgreEIoPV
         eIKg==
X-Gm-Message-State: AOAM530AJCq09KDqzU9jieXllWn3BIEG+KgQFaWkhFFA05cZMNiyS3Gb
        hRYPr34Cc/Pyj0dE9I3yNASWvA==
X-Google-Smtp-Source: ABdhPJwZExCSZGkcklR2YCCWEWtlw5R7BHTgm2wY6c+FyiWKFTnAb849VKhtWpReZzwJZgclkt3H+Q==
X-Received: by 2002:a63:6f8e:: with SMTP id k136mr569294pgc.326.1622065780801;
        Wed, 26 May 2021 14:49:40 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id bo10sm240846pjb.36.2021.05.26.14.49.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 14:49:40 -0700 (PDT)
Message-ID: <60aec274.1c69fb81.9284f.1393@mx.google.com>
Date:   Wed, 26 May 2021 14:49:40 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v5.13-rc3-39-gb2864f8ca01d
X-Kernelci-Branch: testing
X-Kernelci-Report-Type: build
Subject: pm/testing build: 7 builds: 0 failed,
 7 passed (v5.13-rc3-39-gb2864f8ca01d)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 7 builds: 0 failed, 7 passed (v5.13-rc3-39-gb2864f8ca01d)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
13-rc3-39-gb2864f8ca01d/

Tree: pm
Branch: testing
Git Describe: v5.13-rc3-39-gb2864f8ca01d
Git Commit: b2864f8ca01d373c62bbfe71fa01695b039edbbf
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
