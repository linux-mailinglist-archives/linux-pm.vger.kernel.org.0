Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A1D2364FBB
	for <lists+linux-pm@lfdr.de>; Tue, 20 Apr 2021 03:12:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbhDTBM6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 19 Apr 2021 21:12:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbhDTBM5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 19 Apr 2021 21:12:57 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A703C06174A
        for <linux-pm@vger.kernel.org>; Mon, 19 Apr 2021 18:12:27 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id s20so2908633plr.13
        for <linux-pm@vger.kernel.org>; Mon, 19 Apr 2021 18:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=8g0JzsK7cq8mWu+AkXO+6191wq3TcmAs3V7NDlrXdf0=;
        b=WbzIQ0c2BgjwgtvFZFWdbKagDs/yZqiVQAgxNi2SEH/GQU0+nVC8s2skHNcsUyJGYj
         S/cqPUc2jrQstoDPH9j1BaerGkLA9FeakeNkr6j9AJCOh8Dj2SRpvrrQECPABT8pmh+n
         +TfEN3lZrXdTLW6o4tAUEpjBS60MUQNXT8+2o20IrsEiILtSsTIgkG1M3vNWmQZdAcxq
         QMsC091xBnv7bVHfbswz3D22Il3SAKTh2zV4fHFrFrLrJIGdcKQjO0Wa1bCCBgvG2FZK
         RVeoXT/XFoMx+IFSpatarUQH39kM9q+rBzew+rQbw4cacBArP8wGZFBkDs6jN7iDV1oi
         GpPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=8g0JzsK7cq8mWu+AkXO+6191wq3TcmAs3V7NDlrXdf0=;
        b=Oqe8kByvGJQKiTvcMlWHqVXkH8vf6DwLV/3IANBTsmIEHFGAYnxKFhU1mcA3jodgz4
         /q16F0UHkpPy46UZmpvnKAp2MBnc69F1cffDUUev5pt9Xjj+HcoI+UJ7JzgKwm01837E
         /0GFlNyxeuk3eSf9weJGgGZ7reSISf3LaXkaZhA5LSacmkFs7gYjWRoZRleVPcKyXR3v
         lJ6CKmzN7YaQLQnLyd60pqUiuGc81UEH8QQzeVCkul4thQfjtsWydI7eX3Wf1bVZHJZD
         3GQuoxQHERZ6bO/BBmxWrp1n0LS1O84LaiZjBnjcbv8/a28dKgee9P+oqh3MrcofYE5M
         3dig==
X-Gm-Message-State: AOAM530+UwTMxu3hn8cJPOvWeUbADKohuFWCJWuyDbXyn+FmWg+mL0Qj
        ZD2RsHk6+K131bDkmCI/JoGn+w==
X-Google-Smtp-Source: ABdhPJxuEby89ASRsgnsYTjXImcDK+Ckx+xnJ3Wr/GDFWr24D0RcVxKhR2fqs+bQ32ijjfGEwrbH9Q==
X-Received: by 2002:a17:902:fe91:b029:eb:ad8:c5f with SMTP id x17-20020a170902fe91b02900eb0ad80c5fmr26293437plm.63.1618881147114;
        Mon, 19 Apr 2021 18:12:27 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id b3sm557594pjo.37.2021.04.19.18.12.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 18:12:26 -0700 (PDT)
Message-ID: <607e2a7a.1c69fb81.c0458.2d1c@mx.google.com>
Date:   Mon, 19 Apr 2021 18:12:26 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.12-rc8-160-g304bbea920d32
X-Kernelci-Report-Type: build
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
Subject: pm/testing build: 7 builds: 0 failed, 7 passed,
 1 warning (v5.12-rc8-160-g304bbea920d32)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 7 builds: 0 failed, 7 passed, 1 warning (v5.12-rc8-160-g3=
04bbea920d32)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
12-rc8-160-g304bbea920d32/

Tree: pm
Branch: testing
Git Describe: v5.12-rc8-160-g304bbea920d32
Git Commit: 304bbea920d32fc73cdc144d3db268dba0b585df
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
