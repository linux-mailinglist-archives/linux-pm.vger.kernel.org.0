Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA074367F2C
	for <lists+linux-pm@lfdr.de>; Thu, 22 Apr 2021 13:01:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235782AbhDVLBo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 22 Apr 2021 07:01:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235634AbhDVLBn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 22 Apr 2021 07:01:43 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB787C06174A
        for <linux-pm@vger.kernel.org>; Thu, 22 Apr 2021 04:01:07 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id em21-20020a17090b0155b029014e204a81e6so2514249pjb.1
        for <linux-pm@vger.kernel.org>; Thu, 22 Apr 2021 04:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=W4EbIdXWMDgjhWwKxrFIvhgTcjQEms7X5jvB0Ucl5Dg=;
        b=d04XsJU/ljk5lNE/CwmgMVDZuM+BK0MlKxuS876qJV4YVbQIYpvyhTuyWulb8YB+77
         pUYHOgRcKqMvDkhxh/vArz+jUThbOl6QyGQvN8APi9b9MA51CoLXM0N94c5pye8USEOg
         GhXpiUQdrsM61vjy896IofW7id0cVsND7mT4Q2mah99G8i47dmP3B5OUrohyijS7wQjW
         RDkWk4PEgqBBhWaH5UMmUOIlMGqfMLstgxr3P901fh60dUwcqCxU9s1/I3ZmLmkhhRvc
         +TCh6IfyF769RZRzH+M8ZWnOVeNayI5di7KIKfPCKMbx/6uJSNqpB4MPVRwOuNmCBbb2
         NK4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=W4EbIdXWMDgjhWwKxrFIvhgTcjQEms7X5jvB0Ucl5Dg=;
        b=DargvjxaLvfAH0QXUgJFP5C4vDmy1/4HofQlD/iQegbyiEF28AB+uiZ0i6wPaLZJWF
         lgs93y/NFv48rMYPbosJ3xbQu3RKRpLcCLpi4EXbLeZ+fw7fpdPhzzrDiGCmDW7eWMTh
         cf/IA1tnRN5940YPsVMqVtiyU6DK6has88jKkQmnXUR09fSuyrCNoxDCSqzSbhOQwVmS
         dfZqNdugtMgYHgDkY2sAKI1NPaCXoqKYPamzHvQMYx8K1++CMX/qwcOhtneA2Cf9h5pQ
         +EiowhzvrUOw8QrdNLCL9PoJm0nGThY4ggVpQ+Ci32KSJpXcIK8W9wra88tHAinCmUcK
         JSXg==
X-Gm-Message-State: AOAM5313faUDUxuBnyxqL/dxz/zQlseNqb3uoXGg0S7HaKaecfOEo6r9
        wVGjOGYVCmshLdtk5N9+IoDlag==
X-Google-Smtp-Source: ABdhPJx2X0lkyzoAVrOstwTGMJYDdcuNmuT+Kw3ZM28hhF6WJYtbAFQIbPOHyCO2wJEw4Fed9Mmhhw==
X-Received: by 2002:a17:90a:352:: with SMTP id 18mr3231455pjf.223.1619089267299;
        Thu, 22 Apr 2021 04:01:07 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id u12sm5286310pji.45.2021.04.22.04.01.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Apr 2021 04:01:06 -0700 (PDT)
Message-ID: <60815772.1c69fb81.61962.f3e1@mx.google.com>
Date:   Thu, 22 Apr 2021 04:01:06 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.12-rc8-166-ge5e331f4da127
X-Kernelci-Report-Type: build
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
Subject: pm/testing build: 7 builds: 0 failed, 7 passed,
 1 warning (v5.12-rc8-166-ge5e331f4da127)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 7 builds: 0 failed, 7 passed, 1 warning (v5.12-rc8-166-ge=
5e331f4da127)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
12-rc8-166-ge5e331f4da127/

Tree: pm
Branch: testing
Git Describe: v5.12-rc8-166-ge5e331f4da127
Git Commit: e5e331f4da1273e7bdbc1afaf2a4fb5f7d98acf9
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
