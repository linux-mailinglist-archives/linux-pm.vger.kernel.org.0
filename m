Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CF9C38F3C5
	for <lists+linux-pm@lfdr.de>; Mon, 24 May 2021 21:35:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233070AbhEXTgt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 24 May 2021 15:36:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232911AbhEXTgt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 24 May 2021 15:36:49 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC7B6C061574
        for <linux-pm@vger.kernel.org>; Mon, 24 May 2021 12:35:20 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id g24so15452704pji.4
        for <linux-pm@vger.kernel.org>; Mon, 24 May 2021 12:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=SjKlnQ+iOPXXY9y0RPDvqc9B4tNuCtplOXH4EzAHqR8=;
        b=pZLZtB1AZeXvm2rHLj4dG5pkPWzX5aQ2XLYFO8lpYljDvCZt54PaUj+BupQwLtFIeb
         +6Wy75+GXmK195ESj+1zzp2CWxgViihmeOO32f8zmIjeMN5xyQz3zPWR7RUl1CveB69M
         me4O8uZTxO9ZyOydvKIlQqb8F9of8z1CRd8UsiYQFRnS5fTL32D4XRi49rnSbFiUr+bc
         mlIjXIYpNlN11JJ8R0NQr6Y+FzHSqwqvTpaULOEzF/RlJCdvtFP516fPFfbcb+D9jqdD
         PH2VNe+bixZTNue2ATvIdJQK4EwM5O7h6u3US/S0t6/Lg2DKTqCgrT8/E6Qog8IBhpuF
         F5nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=SjKlnQ+iOPXXY9y0RPDvqc9B4tNuCtplOXH4EzAHqR8=;
        b=KbgH+4GeMQ9HHIPp0VaYtCJaKulCfSRG9jPfANP9RpqM29qBlrQKRoyAGlE2hdZAVN
         7bdCx45AYVlt/b3BPoh1YgqLx/YWzVmh7DHcnnkWds8PpAn0Nbbq7GuyMpqOSfqpmHMi
         1EdbBSETHoAJwMmu2PcOhmOZVtDjEAgHLEXO+phJ6TXGaK1xijYQREXIwyoZm5UlDuKV
         ukJ9RXOGQkUBrSmNnlpVuEivLcLOqwI7FwcBA5o6SuTrWJmUPzfNQ9slKqdCAi3NqMZs
         eBTR7Ywe5xxYm4UX1uvB0u4Lkp4tia6Z3we/YX0uP9RFBoYA/zYq6MxwDsqAJBILpvH4
         khtw==
X-Gm-Message-State: AOAM531OCBz6UkTcMZzuKuiHynnP9aGRmVCVwjasxlyFEv85goLmXuT1
        VH9GRDACkTfWw1UkTi61KIrjrw==
X-Google-Smtp-Source: ABdhPJy1L0P9w31C3L4xu9KNIqQZYbWNPp1TJVe56Xpvhu1rVPZjsED/bZZfsH2HWLlM3Gh7nf0Pkg==
X-Received: by 2002:a17:90a:d14f:: with SMTP id t15mr785218pjw.160.1621884920589;
        Mon, 24 May 2021 12:35:20 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id i5sm7855042pgr.54.2021.05.24.12.35.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 May 2021 12:35:20 -0700 (PDT)
Message-ID: <60abfff8.1c69fb81.d6484.98f3@mx.google.com>
Date:   Mon, 24 May 2021 12:35:20 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v5.13-rc3-26-gc17108d7145e
X-Kernelci-Branch: testing
X-Kernelci-Report-Type: build
Subject: pm/testing build: 7 builds: 0 failed,
 7 passed (v5.13-rc3-26-gc17108d7145e)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 7 builds: 0 failed, 7 passed (v5.13-rc3-26-gc17108d7145e)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
13-rc3-26-gc17108d7145e/

Tree: pm
Branch: testing
Git Describe: v5.13-rc3-26-gc17108d7145e
Git Commit: c17108d7145e8c8b80386c02453df5d4b03dbcb1
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
