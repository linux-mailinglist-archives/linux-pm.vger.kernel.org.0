Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 761BD39DE04
	for <lists+linux-pm@lfdr.de>; Mon,  7 Jun 2021 15:47:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230328AbhFGNsv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 7 Jun 2021 09:48:51 -0400
Received: from mail-pj1-f45.google.com ([209.85.216.45]:56284 "EHLO
        mail-pj1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbhFGNsv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 7 Jun 2021 09:48:51 -0400
Received: by mail-pj1-f45.google.com with SMTP id k7so9866858pjf.5
        for <linux-pm@vger.kernel.org>; Mon, 07 Jun 2021 06:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=udxJkzPiTmRHx91LAjlcrYUcuK2idn8ksJQUCgOz0tM=;
        b=mhZWA2TPsc3/UsyY3bNPGF1BQxQcg1Yz0tGbtt2zP/Js7raGQsr1WCUYV+PwEXV6D9
         p6rTos7xRFKQb3Gti9LKwATpqZ8ieEVhrXM+8HAThGBdi2+G+2wTyJkP/UJkVYS33e1R
         UKDFXDh2STX5x0f/4rS+C8tJuT00nIt3IZUZc41/6qvhoZ86wtJnd3jDCaUxmXGz1LEZ
         daUrVsTVTPzhGLjeX5MPlxpbQLTEgeFAp/+lVW8Rtewj8IPUuG41Nknbwb+e4lKWQIha
         dpsIeDAsKyT0lSYyOli8u1gDFpAqM8hC6SEDGeQKx8bEDWun59idILaeiu39IcRorALo
         A5fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=udxJkzPiTmRHx91LAjlcrYUcuK2idn8ksJQUCgOz0tM=;
        b=VAO9h0PGkzZzNcAMg2LkEEWXqaoBLqA1TIf12F7xUGcmXrcoFf04GQhBtGitkmUsfQ
         kx6Eho5qpaXZVR3Vcv7dxtxKJ0ucNpImq03wJfukqfU2BJvlVnMnzXiOwcX/CasQJ4DW
         s0g+lO9PjfELD+SVEm+hPMit/JK/vtbdeZm0V9EpCbsAm8Tzn3qpZhvGN0k6zKUDTck5
         764pNmUFe0l5kRONnJmzG62Wq8LW8pvkILsDASSTwkXQCZWZFK2dd74dQgbuciseYO4X
         A5sAXbkGHjqZmUeVKhOpENokMAUPGnO7cR/OUJ9cbtRo/8uaY/NPpzNt1jbBZiwiId6r
         wXrQ==
X-Gm-Message-State: AOAM532YFkaLCXKy+itGlysPuBfd1/JvliSwp6C+dgid+pu85SEdoUdC
        2s2fnms+9WLYWray31liYyEfdnPzowUFn+6O
X-Google-Smtp-Source: ABdhPJyhAAy3pk5eWam6JJw7/Tgynyc84UE8QJHESOOsgS/sfL/UDcLEVxzrKOEzz9bHvSdtK3OZKw==
X-Received: by 2002:a17:90a:c485:: with SMTP id j5mr17771943pjt.87.1623073559898;
        Mon, 07 Jun 2021 06:45:59 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id g18sm8228682pfi.199.2021.06.07.06.45.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 06:45:59 -0700 (PDT)
Message-ID: <60be2317.1c69fb81.2074a.9086@mx.google.com>
Date:   Mon, 07 Jun 2021 06:45:59 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.13-rc5-37-gfcbef3bdf3a8
X-Kernelci-Report-Type: build
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
Subject: pm/testing build: 7 builds: 0 failed,
 7 passed (v5.13-rc5-37-gfcbef3bdf3a8)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 7 builds: 0 failed, 7 passed (v5.13-rc5-37-gfcbef3bdf3a8)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
13-rc5-37-gfcbef3bdf3a8/

Tree: pm
Branch: testing
Git Describe: v5.13-rc5-37-gfcbef3bdf3a8
Git Commit: fcbef3bdf3a80dfe325261a837f0abd0b2a1b3f0
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
