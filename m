Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B0EA331CBF
	for <lists+linux-pm@lfdr.de>; Tue,  9 Mar 2021 03:08:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbhCICID (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 8 Mar 2021 21:08:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbhCICHm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 8 Mar 2021 21:07:42 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 361E7C06174A
        for <linux-pm@vger.kernel.org>; Mon,  8 Mar 2021 18:07:31 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id x7so4999272pfi.7
        for <linux-pm@vger.kernel.org>; Mon, 08 Mar 2021 18:07:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=ecCAL53qdq9jOLcVm2PmZe52aHKlJf4FVz7ptPstWXo=;
        b=C4/klo8g4i6PribLyKHmfJ5Jr7jPPaPY5yw98jMapZXhc9sHlL3dmAoM8Ui2nzx4Sq
         aOGvx4ku0Y1GSITHxnJ2WNAApwDtih0bsIRKYnCXZrqMhFVoFPGUc/qjiwaO8D+0N5Rp
         HrSE9zyF0zLBYnlxT9VQQ3l1EKL1CjNsu9qiEPB76HwwZ/kmmxgggmSnCZZr9CJuK4z5
         iwWA5TXqp7X6Gw0UQo7GIRPzf5lTXxu2MTiJKC2BcULIxZ2KcrY/qGXP7lOoFq2JwoSV
         Bw55nOECXNslus0n8Swb7UOi4PmFrQ69/mXbpWO+Xd8mObWMVBmvV+VGq6kXiw/Ml2VE
         R1Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=ecCAL53qdq9jOLcVm2PmZe52aHKlJf4FVz7ptPstWXo=;
        b=DKdweNrHdKxNiePuyOKaJony8zR4IH6T6+PwwubbgJvYzIwM7Q4BkjxA0jSbmiNrnr
         YnU+G0d4C3BBgGu295QDxIGEG1dj7mrjRdAh5GT4UvlKYXXuVt/ZRl6R8Pn0EIWtTfTI
         dgkwHk/beE4IMPE40c7xilzUjTZ5sciCl57GOyH4nyx70hApBNt2JVy+OjeYVmCnj40q
         xDX9dWd81NvboNwSTc+rAUzqLh6lE86APgpXns4A2v0yy00hjJNjGz9ZTE1eyC7GjNaF
         tghzdH2Qcqoo7r0E+j+G0KZqMeUk69tqHwULouJJFA9zz6Omih5x1EplEpl8GJnNm51e
         tR3A==
X-Gm-Message-State: AOAM532UG1y24CXsBQuFj5bTv90Fmeb1M7coKmGz0kGOsN2wjILYw48B
        kzkJaaZaI/ApudNsuJk7k0Twnw==
X-Google-Smtp-Source: ABdhPJzbkGyYX1jA5Mb2P/xlVrnijF7rZYDDzwIYmwbMj5ShHJkrAhLYEdims/VLkT3Z+1f08TU1yQ==
X-Received: by 2002:a63:f921:: with SMTP id h33mr22623717pgi.419.1615255650743;
        Mon, 08 Mar 2021 18:07:30 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id z2sm8520740pfq.198.2021.03.08.18.07.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 18:07:30 -0800 (PST)
Message-ID: <6046d862.1c69fb81.a5ad4.4bba@mx.google.com>
Date:   Mon, 08 Mar 2021 18:07:30 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.12-rc2-18-gf15befeb2bc3
X-Kernelci-Report-Type: build
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
Subject: pm/testing build: 7 builds: 0 failed,
 7 passed (v5.12-rc2-18-gf15befeb2bc3)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 7 builds: 0 failed, 7 passed (v5.12-rc2-18-gf15befeb2bc3)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
12-rc2-18-gf15befeb2bc3/

Tree: pm
Branch: testing
Git Describe: v5.12-rc2-18-gf15befeb2bc3
Git Commit: f15befeb2bc3590b212cdec60241a25b78450bc4
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
