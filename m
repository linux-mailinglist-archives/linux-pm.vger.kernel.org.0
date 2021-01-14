Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5621E2F6149
	for <lists+linux-pm@lfdr.de>; Thu, 14 Jan 2021 13:55:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726212AbhANMyf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 14 Jan 2021 07:54:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbhANMye (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 14 Jan 2021 07:54:34 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 106A6C061575
        for <linux-pm@vger.kernel.org>; Thu, 14 Jan 2021 04:53:54 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id i7so3723804pgc.8
        for <linux-pm@vger.kernel.org>; Thu, 14 Jan 2021 04:53:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=eXnQAiBbeXDviZp37GV8KmT5y3rwxZmS9zyI+lL9iw0=;
        b=ucMhkMhqcMEOc4TFg7R3xHZdjrfT/iLDk2DzJ+Bm5DrrT5DHkr+iyvnTqJ6neStAYZ
         OKz36evDav9KK6sCROMZBPHVUK21HPPP4/d4jQlXnmd/cAoaicE2xonsXcSI+6YsoGHn
         Bhq/HlMcYKKiI4shoCjKSANyBu447rSGMUWtL6QCn8jN1NelluzxNsnLKysYBIlgU8VS
         4seI+nwMw4s9t+UV9SEWVZoOqTr/9olNQfJpvMQ9Jnx6hRn9wk1xiXEdW54wjHTviS4c
         d49QYAHaIRr+2X0E/ANVPFpqI7Thxg8V6ywzThHyQwrRyLOAK3WOC4T8GAM+EJWoTqao
         kBuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=eXnQAiBbeXDviZp37GV8KmT5y3rwxZmS9zyI+lL9iw0=;
        b=pJ4aNykJV3+IMjDPGRSTmP6At8EhvX3zdsHLH/V4FYLdi0yFXGmUgxQ9bZjW/xxW90
         F44LXTnait4YxBxylqq1jHCeKsO1qEwx7JSc9ICeyUw+158Rt/jPudsaYhoJe01v+k+J
         AhQqzXgLzWPmfLCs5SVNVWVmedQUDKbbtzOtPW9OC+VOj/cIGgajz+y5qtxJ6A25UrYe
         Ihe/FX0CjYv0UPMVxuk1MCHxSPbD7Wf0Z4YBawCpuxxA5xmCmhbDoUv1jnBdAA510fzc
         jaHBYvK6f6F9HWDRD8S94QWT2Q306j+KAlXSseBOGw2eeTlKhO8JElKGpl5mA/+9GV/8
         Bc/w==
X-Gm-Message-State: AOAM531ZPEaWUJyPFaUqSOKrN2REYrNZl5mhI45PdaQNq5lOycc/vN1A
        2ynRH157OoF00edNlZJkn3jGaQ==
X-Google-Smtp-Source: ABdhPJzZPDYn18xksvDy195dCNUg8HL8aEXgn/FmYxJYjAECqq/9SwJGa2XRe6cHwOzi6J9eIxsBQQ==
X-Received: by 2002:a65:6207:: with SMTP id d7mr7528869pgv.92.1610628833701;
        Thu, 14 Jan 2021 04:53:53 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id j20sm5184563pfd.106.2021.01.14.04.53.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jan 2021 04:53:53 -0800 (PST)
Message-ID: <60003ee1.1c69fb81.9c9b6.ce0a@mx.google.com>
Date:   Thu, 14 Jan 2021 04:53:53 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v5.11-rc3-19-g9f0b1e583eac
X-Kernelci-Report-Type: build
Subject: pm/testing build: 7 builds: 0 failed, 7 passed,
 1 warning (v5.11-rc3-19-g9f0b1e583eac)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 7 builds: 0 failed, 7 passed, 1 warning (v5.11-rc3-19-g9f=
0b1e583eac)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
11-rc3-19-g9f0b1e583eac/

Tree: pm
Branch: testing
Git Describe: v5.11-rc3-19-g9f0b1e583eac
Git Commit: 9f0b1e583eac5573c52c2ead2e1f232adae7d044
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
Built: 7 unique architectures

Warnings Detected:

arc:

arm64:

arm:
    multi_v7_defconfig (gcc-8): 1 warning

i386:

mips:

riscv:

x86_64:


Warnings summary:

    1    drivers/pinctrl/nomadik/pinctrl-nomadik.c:952:8: warning: unused v=
ariable =E2=80=98wake=E2=80=99 [-Wunused-variable]

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
multi_v7_defconfig (arm, gcc-8) =E2=80=94 PASS, 0 errors, 1 warning, 0 sect=
ion mismatches

Warnings:
    drivers/pinctrl/nomadik/pinctrl-nomadik.c:952:8: warning: unused variab=
le =E2=80=98wake=E2=80=99 [-Wunused-variable]

---------------------------------------------------------------------------=
-----
x86_64_defconfig (x86_64, gcc-8) =E2=80=94 PASS, 0 errors, 0 warnings, 0 se=
ction mismatches

---
For more info write to <info@kernelci.org>
