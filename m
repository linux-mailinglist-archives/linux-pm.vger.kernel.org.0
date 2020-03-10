Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E74F17F3E9
	for <lists+linux-pm@lfdr.de>; Tue, 10 Mar 2020 10:43:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726202AbgCJJn3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Mar 2020 05:43:29 -0400
Received: from mail-pf1-f180.google.com ([209.85.210.180]:35952 "EHLO
        mail-pf1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726195AbgCJJn3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Mar 2020 05:43:29 -0400
Received: by mail-pf1-f180.google.com with SMTP id i13so6234652pfe.3
        for <linux-pm@vger.kernel.org>; Tue, 10 Mar 2020 02:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=mRDpIwYybowK/CjF7XA3PGMgbWifN8DwcaMi2xPIUVw=;
        b=IxiPvyBq5S2z3VkexggH8T1d4GJ2eLmbEKxoKCpt3S+KT/cdCjjYp6T0FGu8Uxad89
         qtXiByxlqytiGlH7D8iXIqfFtEJQ13M4fmY8iNBx32NJK5E4Z8vIslOwIis0/PrGBsp3
         gS4ZQRJf4YtFvwN3HfUV9BMGIG6BNVJjPxhov36JQcjMSdWCK3KGKVG630Pg8gj5XiwS
         +BxENhzoP93tKn8duXt/1IdibkPpLyx0JOoI71eqSxGkq4hMhKcdJa+FX4Swuanrtr5t
         ei1yvmedO79yqxNN4mMtZ70LNQRGi8xMCMxcQbCDivtLwaMjKfB/394Qs1KWREj4aNb8
         kYJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=mRDpIwYybowK/CjF7XA3PGMgbWifN8DwcaMi2xPIUVw=;
        b=BkxcaqC1F63UDJgGr9/zC1mxFAe9ppDTDGXRDbl/GfcZmGF7UOtWI9r8j54j24V+2R
         Dj0bJVPJ0qKE7MSJD4cvNcRKpVRV6ELfHLiNdxR8PjUUF0u2rsOQmi/c0QMG7+AHQPIX
         TowBwbCed6pItJoZM+D8uvnD9kY504xwYvjC0jUG41EV3omuz6mp4owcdOPIv+4DyNV7
         TDrsT0xlLQN+vX4QcztTWRcmzJ/a4H7XmJx5k0O/5IHhNh5+tabmyMDvlIe/DwubbAQI
         AVaUGqE+vaS9CPEphAx2T1nPre3L/HUzGzO/bJ8U20VGbL0HzL97bpm3br5vu4POWUTK
         cOsw==
X-Gm-Message-State: ANhLgQ0dRGzaC4Wuo/9AY1pJECPZlFHKr5gvDrIvlhl4zHyBLGQDzo4J
        M1jOtOXIfPfOCfN87MypLZBTm8oNP0w=
X-Google-Smtp-Source: ADFU+vt28eUXcy1SbrmZr8aYPGM/gH5Q4XVbeFBQNJp64H6cUAmCxAW9XFJgaKnCQY6+puZ2x78apg==
X-Received: by 2002:a63:ef03:: with SMTP id u3mr19508427pgh.77.1583833408639;
        Tue, 10 Mar 2020 02:43:28 -0700 (PDT)
Received: from [10.0.9.4] ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id c9sm1169211pjr.47.2020.03.10.02.43.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2020 02:43:27 -0700 (PDT)
Message-ID: <5e67613f.1c69fb81.b24d6.3afe@mx.google.com>
Date:   Tue, 10 Mar 2020 02:43:27 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v5.6-rc5-83-gabcd59902c64
X-Kernelci-Report-Type: build
Subject: pm/testing build: 6 builds: 0 failed,
 6 passed (v5.6-rc5-83-gabcd59902c64)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org
From:   "kernelci.org bot" <bot@kernelci.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 6 builds: 0 failed, 6 passed (v5.6-rc5-83-gabcd59902c64)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
6-rc5-83-gabcd59902c64/

Tree: pm
Branch: testing
Git Describe: v5.6-rc5-83-gabcd59902c64
Git Commit: abcd59902c6467999041971af4ab14f30a2b3780
Git URL: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
Built: 6 unique architectures

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
defconfig (arm64, gcc-8) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section mi=
smatches

---------------------------------------------------------------------------=
-----
defconfig (riscv, gcc-8) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section mi=
smatches

---------------------------------------------------------------------------=
-----
haps_hs_smp_defconfig (arc, gcc-8) =E2=80=94 PASS, 0 errors, 0 warnings, 0 =
section mismatches

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
