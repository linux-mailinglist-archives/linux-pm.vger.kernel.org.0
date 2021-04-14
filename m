Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C8E335F8E5
	for <lists+linux-pm@lfdr.de>; Wed, 14 Apr 2021 18:25:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233550AbhDNQXJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 14 Apr 2021 12:23:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233512AbhDNQXI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 14 Apr 2021 12:23:08 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8100CC061574
        for <linux-pm@vger.kernel.org>; Wed, 14 Apr 2021 09:22:47 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id p12so14772800pgj.10
        for <linux-pm@vger.kernel.org>; Wed, 14 Apr 2021 09:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=jsGAeHtpDvbGQIyLixXt7BumQuaBDTL4O1aVaShCs0E=;
        b=ftZ1EGyzzq/kSbN6HCPYiazOwNRyF0TsHYyaQv1Gz829n0jkAVrDpOVzDE7mK0CkFB
         NJYdGbJRQC0Bdj48r0uyIMWF0gYJ8T+x7OW1O8CmpgWACmhKeXa3eE4EVjZieDK07Ie5
         9sLop4ISIopqO2sdE0nbzo1+E7J0Y3u2ppXp6rmfz2LhGBkJicplsOjC0+FiYdAiu5bp
         O+Km9ktH/jyZpFUXFvjZyr3sa9pdBywIP92WIHv8qqk7j7eQVKKOjIL6gwey4USEBJ3u
         ZX9snqcrwcTYMqXATU3pweDU1zB9Ih8yD66rvuEiSZ6bXBQYvDPwE+sI1S4hSGHSIE2t
         pqdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=jsGAeHtpDvbGQIyLixXt7BumQuaBDTL4O1aVaShCs0E=;
        b=NhmlrbkZOXzqqzk3XCxiKPWP0eXt1Mu61DS04iOfN2iG86UXPiQz5+ePDCi6kS8KhL
         8UdmRELtOHfquiOul5DPMnbG67D/IIhI+IzWZaiWEARGPVkAJZS3JTq2GNXyUQjgTsA2
         AY6q8PHBbunkJvmOJwCvgL5wSkxjPE5m+oIOudFcSkwpWXaxOcEEyGhF4tn+cZhjMT8B
         9poDFG3QEyEmJblf1B6AJD5iWbmySj5rukRVojL6yFOaHlzWD2AqiYtFtVfiYxO7FcmQ
         BZeShbxh4thFNjFGE9XCvUXNxPWLEGmVrG8EPdydzRGMpPQ/Bwx6pv1x2AJeImx01qTT
         elhw==
X-Gm-Message-State: AOAM532jqjLZdvFdhCm1KeoTuD0GkbMnylEl2NviPhQjiZJ+tnvYHxQx
        RC3sC5vlx6A05Kv3Csyd3xuhNUIfIU1RLw==
X-Google-Smtp-Source: ABdhPJygSImkG9Mc2UqGsnV/w8CLGetgYTIdDfy0zStLb/dDXLEhf3vP6RBMVsVHacVKwEpqN6JoHA==
X-Received: by 2002:a63:2c8a:: with SMTP id s132mr38371718pgs.165.1618417367014;
        Wed, 14 Apr 2021 09:22:47 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id y68sm74495pgy.5.2021.04.14.09.22.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 09:22:46 -0700 (PDT)
Message-ID: <607716d6.1c69fb81.9479b.0438@mx.google.com>
Date:   Wed, 14 Apr 2021 09:22:46 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v5.12-rc7-162-ga5b1c231c4a84
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
Subject: pm/testing build: 7 builds: 0 failed, 7 passed,
 1 warning (v5.12-rc7-162-ga5b1c231c4a84)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 7 builds: 0 failed, 7 passed, 1 warning (v5.12-rc7-162-ga=
5b1c231c4a84)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
12-rc7-162-ga5b1c231c4a84/

Tree: pm
Branch: testing
Git Describe: v5.12-rc7-162-ga5b1c231c4a84
Git Commit: a5b1c231c4a84cae19849db076b8a56ffbc8a079
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
