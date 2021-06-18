Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43D343AD37B
	for <lists+linux-pm@lfdr.de>; Fri, 18 Jun 2021 22:18:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231128AbhFRUUk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 18 Jun 2021 16:20:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbhFRUUj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 18 Jun 2021 16:20:39 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28AB7C061574
        for <linux-pm@vger.kernel.org>; Fri, 18 Jun 2021 13:18:29 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id t13so8698171pgu.11
        for <linux-pm@vger.kernel.org>; Fri, 18 Jun 2021 13:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=8AWyzzshR4k2oS7yc5D6YaIVYZ57ineprz/npoCIye0=;
        b=HeuwTD5ZJHbZijVMbg9MSlo0GhM1Ll2jekKT5p3oRPGm1yuMbjHbMvxS09oHiphCL1
         lWhzCqxhrdctomJnya9+GLgJsLRWV5BCUTDWFZj8Oq6SfMvsmNuqKdD3QyWngZxqj5hT
         MSemfqAHdVBkJiUmhF89OeuSVl31wjKzehiHBjAYCR0PSTbsB/AZOlvFIaFrwL/alIjM
         KkUriVNhZUSf+EqEvFnl2o5d+lQ5GKpN6cwWMnsn5mls/BcEw73jP2zSL9LTkHn/MviK
         ORtYvgULa1OCGuj0rUS4du491eGxsmLmscwugFQXq5RBFYhOvlsVf7+kP8Mof3JLo5Ke
         LNtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=8AWyzzshR4k2oS7yc5D6YaIVYZ57ineprz/npoCIye0=;
        b=iUxaUVPMonugkkY4SSspVYQ1IxDMRExRaqIVRQDT2wcDBJR8Wo4vBv+3PxSciSJYiW
         eILpPG3nkcb8C0UHvIag69jWuP+XgNjdQLrxCmUjqV3gtxfEz/UFfkFMoFiQ4EJ7VNVu
         tQ+xff3y1oFXDZk1eBNuRXgUxBwYfOavXXQFWFlVSxq+5asJJcyc6oVr/VQlTPCCJQH1
         022Pr+oSpgicGZwvaO/ul1mJGhzFYqUz03xGjjYuRApgAcbBB9X53fqSPozvKggvcwS+
         AZWaCx2fiqhTDs9iye77EhnlzbH8CHa2VLXtRd65QYSbX9qKDcD4UWbhL10gibsDNVGA
         NG0w==
X-Gm-Message-State: AOAM533FsXHkkw1XVArxhkPGhtZylM0wnR+3ZX4Gh/ux5Cb2QxkDEP3/
        aCOTD6nhZ5HThLLuLUXtC6llmVpTE7V1aXPd
X-Google-Smtp-Source: ABdhPJynnNPC97qwMKp6NfZLasDULQjemzL9UB8ph4A/PWyfMBYPMFi/uglKb7/v8nnZNN4a2kCYaw==
X-Received: by 2002:a62:1583:0:b029:2e9:dcb1:148e with SMTP id 125-20020a6215830000b02902e9dcb1148emr6919513pfv.0.1624047509359;
        Fri, 18 Jun 2021 13:18:29 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id y20sm10068861pfb.207.2021.06.18.13.18.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 13:18:28 -0700 (PDT)
Message-ID: <60ccff94.1c69fb81.3a584.ae64@mx.google.com>
Date:   Fri, 18 Jun 2021 13:18:28 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: pm-5.13-rc7-139-g5469c0cf8416
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
Subject: pm/testing build: 7 builds: 0 failed,
 7 passed (pm-5.13-rc7-139-g5469c0cf8416)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 7 builds: 0 failed, 7 passed (pm-5.13-rc7-139-g5469c0cf84=
16)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/pm-=
5.13-rc7-139-g5469c0cf8416/

Tree: pm
Branch: testing
Git Describe: pm-5.13-rc7-139-g5469c0cf8416
Git Commit: 5469c0cf84167fc90f5a6899df50cffa9ad1ccf9
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
