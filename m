Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F1903B6B3E
	for <lists+linux-pm@lfdr.de>; Tue, 29 Jun 2021 01:16:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235349AbhF1XS4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 28 Jun 2021 19:18:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235240AbhF1XSz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 28 Jun 2021 19:18:55 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 750C3C061574
        for <linux-pm@vger.kernel.org>; Mon, 28 Jun 2021 16:16:23 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id a2so16800235pgi.6
        for <linux-pm@vger.kernel.org>; Mon, 28 Jun 2021 16:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=LoscrbM5Dr4/4lHLlyqMy10eRgwls9d85liekzWOxpM=;
        b=aoq5DI8+OkXRFF/6MPTc/0Sa6cYfQWDJ5SyO++vXIwBMc3ZRQrHYT1jejJH+bPkr23
         6RL0XIiB+/PHo6JoDw+HcWW0zHT3G7Qn8Lrk0hBwKNCJVIbkSJfS/CK7qHytcse4Dnor
         YfjwP/6mwk65SYrQGcbdE5p9NCMGNfbkipyq+nJ1kvPKyVEYuRrcE0E39+fNftuJuYl3
         vymcIPQP0wCXwIo1ek4JYdbEQhAvJCLiyHZP8BCq/kOHYZSTeBroL5hqtOyHqqYokFG6
         UQBaDVgFYzMGyMUw80CR6QaV7WbBvQOrgGhWefedKgAAOM8ZVaGMtW7YTFpStqPqIARo
         J9Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=LoscrbM5Dr4/4lHLlyqMy10eRgwls9d85liekzWOxpM=;
        b=mbE+StRw7jkQNDK+ESQ6QnVUHXWAAJA/UZgw7XTr1+JEnS8VW0z+28kJT14wbfBum8
         TaXbHarAc4aURSAaQMPkCDxo222IBxLd7DF9nCl64KKlI4gayeMGtB6Hgh/skpR/qBFQ
         pgExZqWJIDC+ZiPBqE52/7afipgXzc1ygbxB1HWV5ELLZfu4z91cawjlqemLYDxUlSQj
         Rs55ja0c3v1O1cSLUK1Lx4+NkrckZkJkF4YSJNfRCQGPsPfvdpLuwGRKYsf0sJt2SAVc
         0FZWDZD8eficAq+/kKCXNgC9wlJanLPCIS/WpbbBesUSx4pA/Ajhjvodu1Ol0vI9cRAx
         Dkgw==
X-Gm-Message-State: AOAM53117U1vEYp/M9VtdhXJXKtRFbBx40U9Z79NTqu2Ej9h6B0tvOjx
        tUOuoNBnIfATOzYaNzQyfGyBtw==
X-Google-Smtp-Source: ABdhPJxxieTvycrNpGml2/Kp4fs5bifVQa6p8fgFPXb64iRvGu9JLLikOAhHmDVAWFeKfTtTAMymTQ==
X-Received: by 2002:a63:471f:: with SMTP id u31mr25518580pga.85.1624922183014;
        Mon, 28 Jun 2021 16:16:23 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id a23sm15098082pff.43.2021.06.28.16.16.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jun 2021 16:16:22 -0700 (PDT)
Message-ID: <60da5846.1c69fb81.566e9.cee7@mx.google.com>
Date:   Mon, 28 Jun 2021 16:16:22 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: devprop-5.13-rc8-169-g33842e66a789
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
Subject: pm/testing build: 7 builds: 0 failed,
 7 passed (devprop-5.13-rc8-169-g33842e66a789)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 7 builds: 0 failed, 7 passed (devprop-5.13-rc8-169-g33842=
e66a789)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/dev=
prop-5.13-rc8-169-g33842e66a789/

Tree: pm
Branch: testing
Git Describe: devprop-5.13-rc8-169-g33842e66a789
Git Commit: 33842e66a789d1e4aa9d0379c1f5f43fd4cc4ae7
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
