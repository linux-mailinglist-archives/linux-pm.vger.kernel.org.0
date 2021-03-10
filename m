Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B0C333475F
	for <lists+linux-pm@lfdr.de>; Wed, 10 Mar 2021 20:04:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233424AbhCJTER (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 10 Mar 2021 14:04:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233724AbhCJTDz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 10 Mar 2021 14:03:55 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97761C061760
        for <linux-pm@vger.kernel.org>; Wed, 10 Mar 2021 11:03:55 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id l7so12774276pfd.3
        for <linux-pm@vger.kernel.org>; Wed, 10 Mar 2021 11:03:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=xnc9kC5T1Z9px5v861w1II3/xpAACSlgB5w7w7ODSac=;
        b=FAwaqAeulkEJdB53+o+SJnGzpbqGs1htgOBuCobv/qjz66BpfIW8VUz0HBTfxtwHMe
         O0mcv0dY/S7sSqWMCmKbZOqBgUfRFv4UWPvHK2aeYqVTwc7Epg6MYeJGfYNu12/tFnkS
         EPTkijT9fTKHJ7F2AYBjprwZRSdSAcy0A4nW84a78YVb7SlQYPIkroxV8Ahvyzb7ovuD
         Z9V8QHZuev1ehkmjLzs3aZwE3/ISya86Oh/4GBy7ze7+Fbkt3YNFpOdJtFgvX5AVCd8W
         5JK9rTtZ8ec03X5tmDtl8it02EnqWeYOnP/MuY820vf9tMlFXymhwNO1j1MHHNCsqhmB
         Z6Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=xnc9kC5T1Z9px5v861w1II3/xpAACSlgB5w7w7ODSac=;
        b=BIW8u8E7T2DxvZ0SVP8fal9V4RAAs8uKbi8ETw73qx9beh5Lz0P5LqDACsK+Ws41Vy
         L0Tc0L7gr+63hmrti03DRwrEbCNNjGdqbiublvKp8jXb4fu7j02I0cYiy0vH+raeSKU1
         G71Qde3K8OyhNB1eyaP7LBdvrgkjiucRwKitOyzYe9ZPKlP0f4RtWZnL9wGyX8OhTMWX
         m0bHXSMujr7D8Zh6I58bnN/0usX63M2Jue/DcH75MxBLuubfsZbPAjB8CWD79rF1FT93
         Y8taXAbFcBopbZ7lxkW0cIJQXn74Q1dPNxq+gZQVjgMpbBYI2fEfNTvpeHA+gugYZY08
         0Ayg==
X-Gm-Message-State: AOAM530SX087l3Rcas5Ea9oFwSZPIVoSJ03M/wMwZ4MGUnabJGfZYtry
        jPoqB2sTyrvEZeeaOyyUe+jSwg==
X-Google-Smtp-Source: ABdhPJx8855NxpUrGq6jdKOOJdXP4QEHmhCJknfHxBysgJY4AqXO9OzT6Lvk7Q9Jt5zkOBros8dWkw==
X-Received: by 2002:a63:2003:: with SMTP id g3mr3907289pgg.355.1615403035167;
        Wed, 10 Mar 2021 11:03:55 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id h186sm273465pgc.38.2021.03.10.11.03.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 11:03:54 -0800 (PST)
Message-ID: <6049181a.1c69fb81.5f540.0f9f@mx.google.com>
Date:   Wed, 10 Mar 2021 11:03:54 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.12-rc2-28-g8608bdeb4cdb
X-Kernelci-Report-Type: build
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
Subject: pm/testing build: 7 builds: 0 failed,
 7 passed (v5.12-rc2-28-g8608bdeb4cdb)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 7 builds: 0 failed, 7 passed (v5.12-rc2-28-g8608bdeb4cdb)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
12-rc2-28-g8608bdeb4cdb/

Tree: pm
Branch: testing
Git Describe: v5.12-rc2-28-g8608bdeb4cdb
Git Commit: 8608bdeb4cdb5608b4073077e6e5d7bdedefd169
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
