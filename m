Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E0003907B5
	for <lists+linux-pm@lfdr.de>; Tue, 25 May 2021 19:30:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232277AbhEYRbn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 May 2021 13:31:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232753AbhEYRbm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 May 2021 13:31:42 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7721EC061574
        for <linux-pm@vger.kernel.org>; Tue, 25 May 2021 10:30:12 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id lx17-20020a17090b4b11b029015f3b32b8dbso11894880pjb.0
        for <linux-pm@vger.kernel.org>; Tue, 25 May 2021 10:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=Vnx2xXw/f9GYVB5iW4mWwHUyPkkdFKUBGFoNpOHfvcw=;
        b=n1R0DLQNqIJRLuU/KFyMKF21C2+4cIAA3N23P6iF0UJ+KgkdzIgohF/vEkgUe3svga
         pVd2sIx9gnZX7Kx7uvppbJDe0TH0QLTamZMj7ioVk+bkPizxCLTbDlcjKCl9y2TI/dc2
         4+wO56boXodGuYAWrAwww0bAgf+ZFkwzm4m7CQbiozZ5uUZTRvKPxe7/xVg5mAJOHsz+
         SbkL/EmZwgWso6IEOx9JtYcadj9IUGs7i9DzqExxMkEP6p5/16B4glHTIOkrCj8iBMsF
         egYCgoHlX8wByua4DXa9NA+pXtwlVVB7vxa5RekWhJCw1w/QgysuQdcIF8gVP4gcSYgu
         6Gkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=Vnx2xXw/f9GYVB5iW4mWwHUyPkkdFKUBGFoNpOHfvcw=;
        b=RPGw8yChQ7G2Py2XnsXCPp1aNY0IL8cg58H6EdLphJzK09hv/LQgKz3YG0hZ2f7Y6i
         A0wFdUala6Q+uMQ+k/Z2oesOqPjmoelJCLN2hO8/NbRpTTXKK6RS1LHX7PgfudUwfC37
         mL8n/nyIiQWRbu11yKyRcGZeo3g5VVVE/8iIet3ByBCf/JdAzmIohB7YvBtvofapN4i6
         IOfrdq87nRpQMjUQap93Gz+p9hRt1cBY/cuWjc6J9A2nT+gTG+jvRCH4FTTTnZvSdboq
         Qzv98vERbLPLseI+41yuw8mT4HHucbIr5L6H0WD0yksEUGETcBGMV/+tJUdKphShzobF
         GnUA==
X-Gm-Message-State: AOAM5308rTFmUcA34xygtvWLWmES68xS/1sbShd32pX1o9CWyl7e/Q8s
        UcFh2s7jAUDqqIFm6XF+iz7BtA==
X-Google-Smtp-Source: ABdhPJwLPULookAlhjTN98xjDeT7HunHmMwpPg7dtsSRbStiDdjxqnKtNCy5lS4jG4PIjzmobEo6NQ==
X-Received: by 2002:a17:902:fe02:b029:f5:6e58:91c0 with SMTP id g2-20020a170902fe02b02900f56e5891c0mr31650078plj.81.1621963812080;
        Tue, 25 May 2021 10:30:12 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id l126sm3607187pfl.16.2021.05.25.10.30.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 May 2021 10:30:11 -0700 (PDT)
Message-ID: <60ad3423.1c69fb81.c5c14.b7cd@mx.google.com>
Date:   Tue, 25 May 2021 10:30:11 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v5.13-rc3-37-gbf15f94bdcd8
X-Kernelci-Branch: testing
X-Kernelci-Report-Type: build
Subject: pm/testing build: 7 builds: 0 failed,
 7 passed (v5.13-rc3-37-gbf15f94bdcd8)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 7 builds: 0 failed, 7 passed (v5.13-rc3-37-gbf15f94bdcd8)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
13-rc3-37-gbf15f94bdcd8/

Tree: pm
Branch: testing
Git Describe: v5.13-rc3-37-gbf15f94bdcd8
Git Commit: bf15f94bdcd8d77957c0649a2ea7e39705b699a1
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
