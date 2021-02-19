Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15CF131FEEE
	for <lists+linux-pm@lfdr.de>; Fri, 19 Feb 2021 19:46:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbhBSSqM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 19 Feb 2021 13:46:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbhBSSqM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 19 Feb 2021 13:46:12 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6E03C061574
        for <linux-pm@vger.kernel.org>; Fri, 19 Feb 2021 10:45:31 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id a9so3839466plh.8
        for <linux-pm@vger.kernel.org>; Fri, 19 Feb 2021 10:45:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=qirvuIrsbL1q+VjYAqZwDmaJBpKw5jYIkK4Aieki2yY=;
        b=mT7hqpXPSh2CMk8DpK1t/Mt5qwtAr0BcMPamOBYDk4mqAOB6DIzoAixlsFWcYaTQjp
         nw2vginTkDpVhJAjt0NqKocKZvo/qhW1n7t88/Gj9q1cogOP2wo0hiHa8LBeQobdtjdt
         w8JiGAPA+Y1STxHoBobC2srrUrCarjtTmqwGuwnLijjjVZaLzZJEgKvOC2P0fkQ5l3wg
         yVzeNijl/dV4gp84Jw0h1Z6ViYcB63rHyv89d+VDGAfoc1n6tmu2Yzp/Z20wjm70/Ijz
         9+egj0Ip4Efe4g+mu3D29yV891vjpw7y9EFgXeLPCchvGNAejPif9zGlmbU9uUTF3n0b
         JEGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=qirvuIrsbL1q+VjYAqZwDmaJBpKw5jYIkK4Aieki2yY=;
        b=pumAb4vM40n36I1QfduAnABdCVmn8eQO4tnpPzzpcaiTOEboDDvtgnMLgDdMXfUifa
         KqectSoJv76PvIwM8AblJfjbEtHeJoPd0TnVmsTDvcAlKS7kvsjn7ucmmI3UN4n2y515
         rFIrdOhZm/1wccgFwRUWVGq8f1PULly2+OL9u8uKL+OM0R+DVxDTcr/5L49rfJdAw7Hy
         0w9uL2T7yDjFBWo3/XzpfD5HdjBiuBI5C0bGl4EmUFDwS1cqRypoGnfWPnZVjIEPhTGZ
         vlB/aAwDGSI6U3SRQZ75c5+TAkujkhd61aLbniUc2P/xnIUNggRY01+4+pZInILdAudX
         MBsQ==
X-Gm-Message-State: AOAM531DVjGZV8c2IVWbE460FAjp3kPD7gkJ7MHN3ZX52Ua+XCpDiUIK
        j86+35snM3ALJe1yGga8VpT08Q==
X-Google-Smtp-Source: ABdhPJx7BX/9CzeRzgrICl8KGNwPM9Ix3HBp+NinoKOOlmb+dmTbSzKx39fTpZx/CFjsk+56Qw9ZKQ==
X-Received: by 2002:a17:90a:31cd:: with SMTP id j13mr5235696pjf.27.1613760331397;
        Fri, 19 Feb 2021 10:45:31 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id jx20sm6587012pjb.30.2021.02.19.10.45.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Feb 2021 10:45:30 -0800 (PST)
Message-ID: <6030074a.1c69fb81.fe536.e91e@mx.google.com>
Date:   Fri, 19 Feb 2021 10:45:30 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: pm-5.11-rc8-205-g4475f0291af9
X-Kernelci-Report-Type: build
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
Subject: pm/testing build: 7 builds: 0 failed,
 7 passed (pm-5.11-rc8-205-g4475f0291af9)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 7 builds: 0 failed, 7 passed (pm-5.11-rc8-205-g4475f0291a=
f9)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/pm-=
5.11-rc8-205-g4475f0291af9/

Tree: pm
Branch: testing
Git Describe: pm-5.11-rc8-205-g4475f0291af9
Git Commit: 4475f0291af9a9a16535123a859e154e35ad2277
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
