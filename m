Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 530D13F5049
	for <lists+linux-pm@lfdr.de>; Mon, 23 Aug 2021 20:20:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231421AbhHWSVM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 23 Aug 2021 14:21:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229985AbhHWSVM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 23 Aug 2021 14:21:12 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBCDFC061575
        for <linux-pm@vger.kernel.org>; Mon, 23 Aug 2021 11:20:29 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id om1-20020a17090b3a8100b0017941c44ce4so48323pjb.3
        for <linux-pm@vger.kernel.org>; Mon, 23 Aug 2021 11:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=v6nJKM7oOq1HEpL6VSgZv2xyDV+/RRc4rTukqq1uUu8=;
        b=eBAkLL9pw8jkrhqlMP/CSjuiDfiiHfyCa0EZo8lFGRwk1ZiuaDSk2f73qDoYc/ONxA
         h+hicNgHKYFlX7d4G4Uj8rcp4nB6JZ1R7BUwyGuju9qIvKOycIXMsJ/cMddQwPJekHHV
         pmBZPGptJ5hH2GsAXsj3/3A9lbB01N+xkmwDfrYbIsJ2/Ca+2si0jb/YlOm4xwUhONIf
         z/+CBI6K74/negILu+8Wpb/xvNDdZ5m8FdO7b3Tv+HdARvYFnPcnusvAG/8WdplXWAkh
         WXCvAftukxaomn9ZBiCwHrz/LLQLIgkkq+XfIPYTYAywEgrGgzQcERvMmk82G2w2VsBS
         iMhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=v6nJKM7oOq1HEpL6VSgZv2xyDV+/RRc4rTukqq1uUu8=;
        b=iJ90spxBY2/gHtFbOp07tMBzZl3lsU8efROHbTNMcA8L7RXtXPRGZTQ0vJjweiaEJC
         qjPWg7E2B1BhHGIdRkKDPIm70tBZqOFrUh+5Gnl/0TXFi30/Q5VOKAi/5cHC/lQZapTk
         R9AK8ZDaZ6+KCr3F7mUaPuYOe0BwmQ/WIGs4/B9e/8Vk863AbzxgFIZrn25jAOHKXGre
         rKlLI6pFnu/V78VT11A/h5TrJX5RlxXCXStYSrV297GWtw5gHD9wFDZLCcZZqUXrrSTN
         Vggb3l+HrJFhtylaGmOFvti6xc1mo6U8OfRUMArFAxE3keYou3/+awscc8UgTnK5FD4o
         JM+g==
X-Gm-Message-State: AOAM5315cdrHyKCYyw7YL1GtOGjTfN0zFrcs45WDw5+vOmXqyELLmSVm
        fG/z6SGHePjSEYIc5w7G5rZcdg==
X-Google-Smtp-Source: ABdhPJzPn+ReOxkD6+BJzD0lcgTLhzkH/2bmw/VdJ2vCJw++/6nLqXUWb7k4JWFQcWEeNY7fzodmsw==
X-Received: by 2002:a17:90b:e87:: with SMTP id fv7mr21192059pjb.85.1629742829264;
        Mon, 23 Aug 2021 11:20:29 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id s1sm13283473pfd.13.2021.08.23.11.20.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 11:20:28 -0700 (PDT)
Message-ID: <6123e6ec.1c69fb81.7b012.63aa@mx.google.com>
Date:   Mon, 23 Aug 2021 11:20:28 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Kernel: v5.14-rc7-50-gbd1cb9850313
X-Kernelci-Report-Type: build
X-Kernelci-Tree: pm
Subject: pm/testing build: 7 builds: 0 failed,
 7 passed (v5.14-rc7-50-gbd1cb9850313)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 7 builds: 0 failed, 7 passed (v5.14-rc7-50-gbd1cb9850313)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
14-rc7-50-gbd1cb9850313/

Tree: pm
Branch: testing
Git Describe: v5.14-rc7-50-gbd1cb9850313
Git Commit: bd1cb9850313a606390b4b21b9d07b2ca9ede9b1
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
