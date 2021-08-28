Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AF493FA21E
	for <lists+linux-pm@lfdr.de>; Sat, 28 Aug 2021 02:19:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232631AbhH1AUf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 27 Aug 2021 20:20:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232616AbhH1AUf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 27 Aug 2021 20:20:35 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47244C0613D9
        for <linux-pm@vger.kernel.org>; Fri, 27 Aug 2021 17:19:45 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id ot2-20020a17090b3b4200b0019127f8ed87so8852216pjb.1
        for <linux-pm@vger.kernel.org>; Fri, 27 Aug 2021 17:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=b16CLFbJG+Bf47i4hXvhl6N06JEcub1msRySgqEtlk0=;
        b=YSg9bOGjLtbKqJos1Rcdbb23CekNuOsJldRd6jRfzYvNVQVrFL1M6wAA8fHWJCDG25
         gXbl2sHsv9PNdF4KGMbq8de2EVVDm9Q6SWRvlCesL9Nqb2aNK+vdqmvu+9GUp94RnGiK
         b3qw9qyUpY6nPmim9aS3ybgxPChyf4cHRgEQfUpfXaM50BHytRLOmekQkFDHq0LZt2CP
         D2PmkaYy/q8JMRiA0RLBeEnoEGPBGeLUIrtSuygWdhVBt/6nCMaPz+sv0MxxNFPeNHaK
         4uemYEfNLcVVRntnyB98FVsgM/61yxKRbgNdtJ8cf7pqMg1NEFgQw/iEDr+4ZqBvoG1D
         uLTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=b16CLFbJG+Bf47i4hXvhl6N06JEcub1msRySgqEtlk0=;
        b=HBOvVXlB4658RXME87QgUCejGXi7VFvIiNdaK2ElNzz4jK2bXV1q02jGNHE0F0ZoKL
         9kTUDFMvLyN6UoJbIgOGzXwY+Pqdx6XgLOatGhSabymT4t6yxgOzsINvmTRuJqOr/pq2
         V6G1Ogt1j3W8L8SCnjqNLVBosrPF8q/Ry6fN7kL7/T877AkB0nWUAY0zlz1/wjk8i8w2
         PjNDztXRJ9Y45BSRBEa4emB7H3V0TveBof/C5Kn7hQOgFJdKxYDS5VyK6EAN7sL9WB6e
         Flr6ygeFclwDA9ho43ICC6jQ7+PO7/Lbx8qn9XVFrb6hcgdGB5FWo1xryH4RwxNvZqwy
         pZPA==
X-Gm-Message-State: AOAM531XxF4FzNU5Tl8qo6GOdCOoOANCmzwVCyhlj9zK8iyNBitVOb6c
        BoyNMA3U0zVn1oKUVDQL+vvpHg==
X-Google-Smtp-Source: ABdhPJzFtiino5dM+2bp8meNFI0v/1EfLSfVgBLzEYt3oMpxHTrTLBenXubricLEHTWBImaD+99tVA==
X-Received: by 2002:a17:902:f703:b029:12c:982:c9ae with SMTP id h3-20020a170902f703b029012c0982c9aemr11128283plo.20.1630109984732;
        Fri, 27 Aug 2021 17:19:44 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id s20sm6851631pfe.205.2021.08.27.17.19.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Aug 2021 17:19:44 -0700 (PDT)
Message-ID: <61298120.1c69fb81.e903b.1f1b@mx.google.com>
Date:   Fri, 27 Aug 2021 17:19:44 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Kernel: acpi-5.14-rc8-64-ga93c0039d89d
X-Kernelci-Report-Type: build
X-Kernelci-Tree: pm
Subject: pm/testing build: 7 builds: 0 failed,
 7 passed (acpi-5.14-rc8-64-ga93c0039d89d)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 7 builds: 0 failed, 7 passed (acpi-5.14-rc8-64-ga93c0039d=
89d)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/acp=
i-5.14-rc8-64-ga93c0039d89d/

Tree: pm
Branch: testing
Git Describe: acpi-5.14-rc8-64-ga93c0039d89d
Git Commit: a93c0039d89d6f11b98f49db841515e65a5dd0ba
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
