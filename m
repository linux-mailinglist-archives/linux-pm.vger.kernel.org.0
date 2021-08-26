Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 066943F8DAC
	for <lists+linux-pm@lfdr.de>; Thu, 26 Aug 2021 20:14:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243228AbhHZSOT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 26 Aug 2021 14:14:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232729AbhHZSOS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 26 Aug 2021 14:14:18 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48FC3C061757
        for <linux-pm@vger.kernel.org>; Thu, 26 Aug 2021 11:13:31 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id u15so2284164plg.13
        for <linux-pm@vger.kernel.org>; Thu, 26 Aug 2021 11:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=zOmabilDP60tVZ2h8tDboTOIj0RspMl+SzkRdXq/zlY=;
        b=lRpYQWfYyq271R3TrUyJwojST+q/y7iDZHpJVf9PNg3tx7cblZdYc21QNNCfeigfXr
         WBAY9UsBbtBeYI9t7X9tH/cObSQK8GO3RVxN8TkhmUCnvo0XziQJc0N9M/YJRLZF/FBF
         gksDJsXMTss4uiPKkj0+PlM1/BL4kVZzYj2dF8aBDKw5ZUcDHcbOzrZ6TmGtRBGo1cy8
         jgNqr8DwvD1JU0ryLhP7ZWE39FGrxy3MJO14CWJa9XkyuzJRLm7Hc08I29Q9OTRILVhm
         c7gcaFFixEVYPMeeg2JZgkkLV4rBK/Vk28bfVJ7W0QSZ6lAh+FwiYyf+T97/MlKBoVMy
         3oZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=zOmabilDP60tVZ2h8tDboTOIj0RspMl+SzkRdXq/zlY=;
        b=TEmnhB+2QvVBxCpCxqhGA3fY/e9FpGvJIYTBgviUJKm/2ZWuGtJuuw1oakQb4mYNYX
         tWt1hgHv6onvM143ies+oYvHbWo6ItNtskzS7juCe5JkAw/w/I20ypHWBfVyCupCZi8G
         vcsOPM5nZYscw5r8VR/sY+Eg5loEW2E7h1PKBb3gx3O6oEx4wFGbbg61TzKdwCcTlgNB
         n14++dH+udfBucB2qdX1nSX8zL+8z54HqIfj9OP5dNOV4tfsFeKqLhQDoWH487UtzMWr
         jhDR86kq6aAj8yXJ9/m3U/I8slhSK7/+4xpHIT3eDN1lz6nbaClBXfUOD284DKXhARl5
         d2AA==
X-Gm-Message-State: AOAM533T38LrOltTUxwmlc2Rx8nO+MK//hAyAB3iseDXTwFKN1Ln5NyV
        +w53aDfPodKIGAWqSZxDuhtGklY07XvCvsCy
X-Google-Smtp-Source: ABdhPJwWs4xlmkyhsPJ91zCIwDZXPVrtodBLqxokXWt10R2Rg+Lda/uLAgGbzPlScFCiysdGMIZakw==
X-Received: by 2002:a17:902:8e88:b029:11e:b703:83f1 with SMTP id bg8-20020a1709028e88b029011eb70383f1mr4714822plb.79.1630001610731;
        Thu, 26 Aug 2021 11:13:30 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id t18sm3486509pfg.111.2021.08.26.11.13.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Aug 2021 11:13:30 -0700 (PDT)
Message-ID: <6127d9ca.1c69fb81.710de.983c@mx.google.com>
Date:   Thu, 26 Aug 2021 11:13:30 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Kernel: v5.14-rc7-64-g2a7254aa7491
X-Kernelci-Report-Type: build
X-Kernelci-Tree: pm
Subject: pm/testing build: 7 builds: 0 failed,
 7 passed (v5.14-rc7-64-g2a7254aa7491)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 7 builds: 0 failed, 7 passed (v5.14-rc7-64-g2a7254aa7491)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
14-rc7-64-g2a7254aa7491/

Tree: pm
Branch: testing
Git Describe: v5.14-rc7-64-g2a7254aa7491
Git Commit: 2a7254aa7491b3da13bb3fa15a3972f5660cd32e
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
