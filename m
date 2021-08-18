Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65A8F3F0969
	for <lists+linux-pm@lfdr.de>; Wed, 18 Aug 2021 18:43:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231186AbhHRQoD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 18 Aug 2021 12:44:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbhHRQoC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 18 Aug 2021 12:44:02 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACBC6C061764
        for <linux-pm@vger.kernel.org>; Wed, 18 Aug 2021 09:43:27 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id 18so2723842pfh.9
        for <linux-pm@vger.kernel.org>; Wed, 18 Aug 2021 09:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=p/vDnTxlhSTGLEJgymP1A5k+cGUKBXgkHIuRWP+q7Dg=;
        b=eBBoUYwMu8lYU8d5DXfLolsPO67uRraC9rbubQbjB4EnoZnZpNNkVVSbCD2jyWCW3T
         AUVZexlbpyb5Gf/IZgaZRHJgPLKaNB006ZYt9OB+7eJNp9tFBlRS5f9VEZ+YRkjWf8Ko
         fMhDNBJQhB8ZDR7VG2X5ZW6b7QUVNvnHewLdbFoy2z7Hte/Hk/egHWs4bmrujDUd6fjj
         lhBHK8oOrxpSgot/o38DKi3HjZpyKFsSueJe7oGxrMowLmPNwtzW6cbY1+IagBSTbdmw
         ePLpvPQyeskY21OITxmWKQ34RLaQNq9ho1/HI+qsrHOjpiJHUxYLAGFIWODkeZ9GaM3J
         2UPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=p/vDnTxlhSTGLEJgymP1A5k+cGUKBXgkHIuRWP+q7Dg=;
        b=lPJIVJErCDp4C9LJjdzB/4QTULSGXxbZ32OxFOwv0vwoCVNQ8hpZG3yyxHEVV8EZpS
         CPKI8b6bdWR+xSD4OoX/d91ITWgucWDk5U5haxIBUM4VYdYsro5YSXNDmWsju22rIuOR
         0k7hLYRp9Ph0p6zj/0UGU5kEy97imI+SzLSgGdOC8YvbMXeEb1tR1mXdnnJfqCGWMN8H
         2h+Fldd63R8mANfhch0pqIfR2XOo2kYeZWYSLI9EvG6qMI6PSGFOcdj381+KFX+/J80s
         s9gdPd9P2WN9gTvOVgkTB69fcoZgnl5mXq6RURkwVOvkh9lc7i7K2fBT8gPxJ1RUpybQ
         lbAQ==
X-Gm-Message-State: AOAM530Xs0y3lt/6MZZiw8qJTGMFwQkErtdWH29WDGw66ia1ebMxOukX
        ptrmLuBvqR41XMqKZL2PlmnrWQ==
X-Google-Smtp-Source: ABdhPJyv5p44SB6AF8rfsxMx4UV2USxrX8z0iuncADhrNeyBwC/qf63hETj6CbAsir5ZJg35mktx/A==
X-Received: by 2002:a05:6a00:2411:b029:3b6:2acf:6d16 with SMTP id z17-20020a056a002411b02903b62acf6d16mr10277786pfh.44.1629305007256;
        Wed, 18 Aug 2021 09:43:27 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id s32sm290893pfw.84.2021.08.18.09.43.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 09:43:27 -0700 (PDT)
Message-ID: <611d38af.1c69fb81.4c2d.1486@mx.google.com>
Date:   Wed, 18 Aug 2021 09:43:27 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v5.14-rc6-60-g10bc7fbefe3a
X-Kernelci-Report-Type: build
Subject: pm/testing build: 7 builds: 0 failed,
 7 passed (v5.14-rc6-60-g10bc7fbefe3a)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 7 builds: 0 failed, 7 passed (v5.14-rc6-60-g10bc7fbefe3a)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
14-rc6-60-g10bc7fbefe3a/

Tree: pm
Branch: testing
Git Describe: v5.14-rc6-60-g10bc7fbefe3a
Git Commit: 10bc7fbefe3a9ab4a8e7531752e200ceff5919c7
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
