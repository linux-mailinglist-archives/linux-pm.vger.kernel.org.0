Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65F943E1D8F
	for <lists+linux-pm@lfdr.de>; Thu,  5 Aug 2021 22:49:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231371AbhHEUtS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 5 Aug 2021 16:49:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231712AbhHEUtP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 5 Aug 2021 16:49:15 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4EC7C061765
        for <linux-pm@vger.kernel.org>; Thu,  5 Aug 2021 13:49:00 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id mt6so11904016pjb.1
        for <linux-pm@vger.kernel.org>; Thu, 05 Aug 2021 13:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=dwjmsISkrBRm5LSCKj43ilOGKITngWaq0Q+jbVlqiv8=;
        b=n5XthCIR+jtFN+hI6aUuDKo+OF2eSHm8u61ELJ16fI5cL+CyNKNSAkamUrYY2anUNk
         7ZcYM3Iw8hPKWgPwHikL8rl5m9c0uz5vTEFaJyQVLqEsM+Z/mDaBsfEJrEqh4srYe2tt
         /yozlqRUQ2XVbIhs7ocLSS9gzmei419aezx/J8F5TW4y343UKTYVgibzK7uTmEi+LCmc
         nrO9f/29MrKQeOrNTdM+niUbcmW3vcZB9BKzQn5R3OlbmZWgRLoDe0+UCPn7/4f2H5/N
         NUVEwJkY0lJE9dIk/Xt3nzsBuBoAlWuW+pSsMrVEzTRLnd2Evf1/tssvUpLxdZhMFxAR
         KFlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=dwjmsISkrBRm5LSCKj43ilOGKITngWaq0Q+jbVlqiv8=;
        b=PzQ0z+nwfFFBhhB4XKxjzhKp0ykwy12qhqIKDNjrf8VE9gUJeCBRI0frunS/Tjz4wb
         Vuk3xGBy2eLZ1ZSCjHjANfweHpbLH858clUuO832Gjz8LG/qpPcdzkpTJBHu1+il2qL5
         XD+YfroZQ1N/SOIChRyF/lv01sTsVWwYdgC3UIYHkmfWXbp2mSTy7g8h+FezAgSNwG4H
         tflHivrBxm6YQcutxEsBqsrkPM0Ij2CpPKOweItGTGqf03+30wqVZlcvuI2kIEzCXj/K
         emPTsB884VSFpkD/IGfsUfGc02eza3o/Q96pq+3WxAmykE5LZWaaEv19E9nP4wz17KPB
         96qw==
X-Gm-Message-State: AOAM5338bHk3pV34GeyH4Eamqs2RP+dwztj6w6bov4yfpe2PKs8JYxOu
        B1Hn75LAgDaTeBr6b8ZC7resPg==
X-Google-Smtp-Source: ABdhPJxrlfDDjsWonbR6dmknC4JVjqQHbP+am4zHu/AO3QyoJuwpyvt/bm+zClp1AaB2qc0GkZKr0w==
X-Received: by 2002:a17:902:7042:b029:12c:dda2:39be with SMTP id h2-20020a1709027042b029012cdda239bemr5677932plt.68.1628196540464;
        Thu, 05 Aug 2021 13:49:00 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id z18sm3455013pfn.88.2021.08.05.13.48.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Aug 2021 13:49:00 -0700 (PDT)
Message-ID: <610c4ebc.1c69fb81.76c0d.989c@mx.google.com>
Date:   Thu, 05 Aug 2021 13:49:00 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v5.14-rc4-28-g9ac32de19606
X-Kernelci-Report-Type: build
Subject: pm/testing build: 5 builds: 0 failed,
 5 passed (v5.14-rc4-28-g9ac32de19606)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 5 builds: 0 failed, 5 passed (v5.14-rc4-28-g9ac32de19606)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
14-rc4-28-g9ac32de19606/

Tree: pm
Branch: testing
Git Describe: v5.14-rc4-28-g9ac32de19606
Git Commit: 9ac32de19606940ad29710d22841a906d6dd4799
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
Built: 5 unique architectures

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

---
For more info write to <info@kernelci.org>
