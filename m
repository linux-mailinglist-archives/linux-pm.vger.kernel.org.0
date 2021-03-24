Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D812734853E
	for <lists+linux-pm@lfdr.de>; Thu, 25 Mar 2021 00:23:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229664AbhCXXWw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 24 Mar 2021 19:22:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbhCXXWS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 24 Mar 2021 19:22:18 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFE24C06174A
        for <linux-pm@vger.kernel.org>; Wed, 24 Mar 2021 16:22:18 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id kr3-20020a17090b4903b02900c096fc01deso134344pjb.4
        for <linux-pm@vger.kernel.org>; Wed, 24 Mar 2021 16:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=VZfSmWuCuNXMEAyB6IrUFh+uCeROTdSJnPFL+3yC9W0=;
        b=b1XzaD241i/ESNe5jPbkqapBKpE1HebDyodbZ03zV7WCX93lLJhvDmX0WD+UZELgv+
         Ip/n7acYN1yvQQdRBOO/55k9Om/vk6y8uLcPJDs4AXLHkWb/PU7tN1tFpTxUT+of2jzN
         0hjGPWHZX0naacVmWDB729G8sjH/via8SZCkQqUF3+4+FLZgoeXPLSdLjCz+j4nX6EoT
         ralwTSt07zLatJfby7kMzoqPIblur6wL1U7/YPkseXMzy7C3J+Dos5siZScNento0Ozi
         FBXxZm85Me17Iwk0dAdaWyv5T3Mf6SGoZlEl2db3IVhgqmpv03pmH8hRaEJ7zH5H6VBZ
         6BwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=VZfSmWuCuNXMEAyB6IrUFh+uCeROTdSJnPFL+3yC9W0=;
        b=TVpRW61T+EEgWTIfWxneGaJe3SXD7q4mnWJrr8ptaULipMDwyml+Y9c9gL83blfayX
         JH9hFZB5UqBSALWTPQtZ95EOOku0QpqBGcPPdKbK4sD5ygx6PDHPvlfX+2tGmJacgpgN
         tKu4YFyKsE5m13wT3cTujH/36j1CZt5p31OC33og83xYK8BzWdJBOwm3cjqnlfRAr2Yj
         im8ud4g0mt/03OSUviYSz7dNMB8ZVqZ0m2i878n49JNwRbUGjUEWZet9Dfms1T7HeiTI
         zWSenrEMXBbhuZ0isL58ojrnwgwaTmosn25kQhdSAEZMA6Bj7KzW2GfEIAN4VqAhqwjt
         oUqA==
X-Gm-Message-State: AOAM533mgTCUuMnvkVrw7pUuFdCAzEnHc0EzkAIkEa67/WyAhJ+i7R43
        tYX3ZNyDM+YNIwOys7DAajAjh9Ujp26JEw==
X-Google-Smtp-Source: ABdhPJzpwu00RGdWWA7CaHC1cK/TDxFJTvXL8csYHXvs5NncvRyHwyQqw17a1QbIoucuE5YCTJMj3g==
X-Received: by 2002:a17:90b:2284:: with SMTP id kx4mr5551980pjb.96.1616628138273;
        Wed, 24 Mar 2021 16:22:18 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id k5sm3759271pfg.215.2021.03.24.16.22.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 16:22:17 -0700 (PDT)
Message-ID: <605bc9a9.1c69fb81.d63ee.9871@mx.google.com>
Date:   Wed, 24 Mar 2021 16:22:17 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v5.12-rc4-45-g972d86381b186
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
Subject: pm/testing build: 7 builds: 0 failed, 7 passed,
 1 warning (v5.12-rc4-45-g972d86381b186)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 7 builds: 0 failed, 7 passed, 1 warning (v5.12-rc4-45-g97=
2d86381b186)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
12-rc4-45-g972d86381b186/

Tree: pm
Branch: testing
Git Describe: v5.12-rc4-45-g972d86381b186
Git Commit: 972d86381b186fde03c69fb4cc0ca70f5255baa7
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
