Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0139F30CE3F
	for <lists+linux-pm@lfdr.de>; Tue,  2 Feb 2021 22:55:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233290AbhBBVzc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 2 Feb 2021 16:55:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233739AbhBBVza (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 2 Feb 2021 16:55:30 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4664C061573
        for <linux-pm@vger.kernel.org>; Tue,  2 Feb 2021 13:54:47 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id w18so15265073pfu.9
        for <linux-pm@vger.kernel.org>; Tue, 02 Feb 2021 13:54:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=WZt0zD8q4XCiP+1FC30PFVdmluA0NPN00vvoLqUWNIk=;
        b=yVnGObElFbSTqsCHQ8iQKxpsc1+1oxOJ2qGgk8fUXCr7lS4ra3u1ZFNLWCx9G2g/Hw
         eEoOqSs9oDK6I+TVlhgqJm5hZ8zTl5zzqdyqGKJJ/5q6106KxibDod4RQFsBJqZqs+L/
         7poAhHmcLg4Oi1Ijad2o0fXbUe93st4vLEs5Ojt+3iv58pL78sYJ3/zFHlySASXyM4Lc
         +gabbM26mGMr/X3/IvK28RdREQxTKVA26ILGGRTKK250p1DSkcp0HmxpIpEJpyajf/JZ
         mbePWEeaWMB+AQjhfEjc1NwIUNiuRUF3iUQbFpE12X52vn61B+jQ+JcpKMC7sfUkpNOw
         3mgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=WZt0zD8q4XCiP+1FC30PFVdmluA0NPN00vvoLqUWNIk=;
        b=pKqEaEw2Fd6xNXXk41peUT4kMC0i4DfnOAUnfd713i+uxnFvaMI+U/9dvc41U5l5I1
         eaKcPHlaSr5FIUI9+sNlNEqL0qIBZp7xmFKTknf71mVGHm5mU+hvkdWqJkSWqN0qdPd+
         ji5VyNH+HfvZQ9JzV+ZvFhNpS7+1oRqIELuvQPMo2HdJpHHT843IVp9kpGI4gtYTPtfk
         0jMDlhFyM6AvaHGj5rh9/ND4x9dyxNmF1sdI+cU/WH/x3j3mDCKfUyFGNFapQ+0oH0n5
         ePac7SX3DaRsYqksOSjujMIxrNRBHefNKiLHQlYdVImR8FqYZpVNH5B4JUfnqH62DW17
         yFeg==
X-Gm-Message-State: AOAM530PqEQ08btAg/w7AUBisaspyMxee47o5jEXgtdXA4atvNo0KnAL
        U59Sv8JKKB+BTAH/9XvPwdQi+Q==
X-Google-Smtp-Source: ABdhPJwoebF1cJ5zkglA256WjTcK7sgS2gj3f1gT1klLD55BEhlkhIJ45+CatuYc2K4dP7bZSypgHw==
X-Received: by 2002:a63:e442:: with SMTP id i2mr176155pgk.12.1612302887518;
        Tue, 02 Feb 2021 13:54:47 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id i36sm23756116pgi.81.2021.02.02.13.54.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 13:54:46 -0800 (PST)
Message-ID: <6019ca26.1c69fb81.b3e8a.868b@mx.google.com>
Date:   Tue, 02 Feb 2021 13:54:46 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v5.11-rc6-72-gc42187278fc1
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
Subject: pm/testing build: 7 builds: 0 failed,
 7 passed (v5.11-rc6-72-gc42187278fc1)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 7 builds: 0 failed, 7 passed (v5.11-rc6-72-gc42187278fc1)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
11-rc6-72-gc42187278fc1/

Tree: pm
Branch: testing
Git Describe: v5.11-rc6-72-gc42187278fc1
Git Commit: c42187278fc107ad17fdaa2def70c451bcfdb6be
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
