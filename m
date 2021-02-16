Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85F7F31CCE6
	for <lists+linux-pm@lfdr.de>; Tue, 16 Feb 2021 16:25:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbhBPPYy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 16 Feb 2021 10:24:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbhBPPYi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 16 Feb 2021 10:24:38 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9589C06174A
        for <linux-pm@vger.kernel.org>; Tue, 16 Feb 2021 07:23:58 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id y25so3041721pfp.5
        for <linux-pm@vger.kernel.org>; Tue, 16 Feb 2021 07:23:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=GhydlJ/tJwKMgGW1V7Izu5UctyJFnsZHBFTpm5M7xkU=;
        b=a4Q3DuBD6n+KI3UZEQXKip54fEy3efoknvZmMlJjpHn4wikIxHMYGmPbgN2LP1OY4+
         ZdHyKxpCZyf7Y+4drOj/IWdT3C4rv5IQTjqgi+vyiZe5j9vFYxA6wNTWbISACMsjZL19
         fLMtaqbXs7OPwtpA19BK2l4yNuH0aPLN4quLPuFlCBu1qvaSJ2qoUo18z9AnWBASy9Ha
         GJcsO+9WoKYjE/wxgVAakV5GF3RqOBX9qU9YcGOE/AHMxgprG54uIK/YbfCD9T1DTOkQ
         qfX9USPRy4C315n4FmauuTq+JEUSjOzdWhgYoZsp583pgDwURTbegg2uiU9tAavEX2fz
         5hgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=GhydlJ/tJwKMgGW1V7Izu5UctyJFnsZHBFTpm5M7xkU=;
        b=YToo+HBY161TRSDSTewGIWk2LAVr9/3fZRWf5QA6mhB7efvE/bMzeImQ/KmvVpP0O5
         MtuDgLOIN1EFOlVmRESeS9niUFb4XhNvny7ZJnAckTPI2kUFPV4R9P+GEKY2bcZposSm
         LYwvD8LKqaM2XixnRQHQH8sjp/0/8Hqx3XBUSEs+giX0/hqJUxf5vwQzVXBcnnlzd4D/
         NGilNrnobTpwRRK4YQrsEM4EyzhXzlXk2XxjUTZFJSM7VPSJcqsC9ZSlx9pPnbrSn3XX
         ZcQnTl4dRfJxt7mhjvtBm+Jc0IH4UG8d+Pew7aHzMhrnQCEacw4Go8wJdKjf8JhxCsCg
         ZKOw==
X-Gm-Message-State: AOAM530GZHlVPYiUqDMkE4qFQbYdF5krAc59J+byfx+R+Hay4BTtDkpi
        zK//wV5Qex6mtCwkgItlbxg87w==
X-Google-Smtp-Source: ABdhPJzd/m19MMjk05eOK0bfsXPXxS+PZhzsFgbvrpusptae8Z8VkMEUoC6Jv4B75mzGkthPK0q5Kw==
X-Received: by 2002:a63:c501:: with SMTP id f1mr19508674pgd.1.1613489038267;
        Tue, 16 Feb 2021 07:23:58 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id m23sm20463037pgv.14.2021.02.16.07.23.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Feb 2021 07:23:57 -0800 (PST)
Message-ID: <602be38d.1c69fb81.22baa.b5c3@mx.google.com>
Date:   Tue, 16 Feb 2021 07:23:57 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: pm-5.11-rc8-155-g606a19484587
X-Kernelci-Report-Type: build
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
Subject: pm/testing build: 7 builds: 0 failed,
 7 passed (pm-5.11-rc8-155-g606a19484587)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 7 builds: 0 failed, 7 passed (pm-5.11-rc8-155-g606a194845=
87)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/pm-=
5.11-rc8-155-g606a19484587/

Tree: pm
Branch: testing
Git Describe: pm-5.11-rc8-155-g606a19484587
Git Commit: 606a1948458764ff9a1ffa47a3d68749b9b93041
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
