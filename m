Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6A0B391CC6
	for <lists+linux-pm@lfdr.de>; Wed, 26 May 2021 18:15:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232198AbhEZQQb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 26 May 2021 12:16:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232193AbhEZQQb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 26 May 2021 12:16:31 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06CF6C061574
        for <linux-pm@vger.kernel.org>; Wed, 26 May 2021 09:15:00 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id f22so1341121pgb.9
        for <linux-pm@vger.kernel.org>; Wed, 26 May 2021 09:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=9Q6+tqYbQ6hbaAPica85mInL8pGjWpM9S4X767/mRLs=;
        b=aOFlCkzeaLLf2VX0TgbXqqRTASWzxVOlVXz1a+E/lY4i10ZQDwhUgCMLHb0xu/p26v
         HmmsVVt8x/LOPUk+MLzBTyKmZxPuzB6VyKRhBv+qQpdV8mnJ+vdD6HJrfdcoFCrSWMWf
         eTk3TqNy2qsOIj9TlL8+9R23NhEMo+XPPLunwhJmoybVcGQhk/AahpYG1ZJ1aIxk8uf8
         Bnas3ghsLRkyA46SEfjM2gTW4fNNgxrZrYRLNBg/leJvgiK5PvT7eovf/XuWllwLnPvT
         yenBbMJsAe5P2o0uUGMSFOZCmXq9hOkqFUu3MkftDfiMhC3SKiTEfqS14iJRHMpVxcqT
         3gXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=9Q6+tqYbQ6hbaAPica85mInL8pGjWpM9S4X767/mRLs=;
        b=FRO37jilQlcEW42Zyc0mENv5/AJkY8TWJY1tIOdQ2UjCxbue6LQds3pK31nquPf52c
         tMrCIcNPmHuzcaG4atIc828KRxnrZ/lxFeWilvE3fSd7BHXg3QEGfo5nzcvZdtEyhwyR
         JMadIJNGLAoenb82naBlAyzwKKU2d9KhRLPvkThWYbgfmGd9ABZ+tWWCQSqOvYO0QPVh
         YWJDzhw7JoMAjU9z/P248skaY1DOTsjdwI9XOWV6bWdzgGQUsQkSmrBUgMNuIXRwX+tS
         e30QL1frStVONCMaT8l0lMin5q/60/j4rnBzwUKdmoc1I5Zdn0tOM6RAIVWOaJn17POH
         92ug==
X-Gm-Message-State: AOAM531P0cZT8QXGej1KIj5lDaAqCfIFgsKmWBha4JbFGpCXtHhCobA5
        dijscN/6aBkrTle3rM+6CSa19twgQ7xlBZzS
X-Google-Smtp-Source: ABdhPJx0SQlGY3l1Iex/uIOj+s7306BKiBjXpe7TNPZYQ93AikBWi2sBD2e0mytRMla9cWtSiQir5g==
X-Received: by 2002:a65:5305:: with SMTP id m5mr25790034pgq.155.1622045699660;
        Wed, 26 May 2021 09:14:59 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id s80sm16458532pfs.59.2021.05.26.09.14.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 09:14:59 -0700 (PDT)
Message-ID: <60ae7403.1c69fb81.94680.5115@mx.google.com>
Date:   Wed, 26 May 2021 09:14:59 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v5.13-rc3-39-gb4a1c81b7736
X-Kernelci-Branch: testing
X-Kernelci-Report-Type: build
Subject: pm/testing build: 7 builds: 0 failed,
 7 passed (v5.13-rc3-39-gb4a1c81b7736)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 7 builds: 0 failed, 7 passed (v5.13-rc3-39-gb4a1c81b7736)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
13-rc3-39-gb4a1c81b7736/

Tree: pm
Branch: testing
Git Describe: v5.13-rc3-39-gb4a1c81b7736
Git Commit: b4a1c81b77364a4a4a03bdd47304a74d95ca4d3b
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
