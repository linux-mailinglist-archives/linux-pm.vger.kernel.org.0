Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB0BD32F275
	for <lists+linux-pm@lfdr.de>; Fri,  5 Mar 2021 19:26:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbhCES0W (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 5 Mar 2021 13:26:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbhCES0C (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 5 Mar 2021 13:26:02 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2B65C061574
        for <linux-pm@vger.kernel.org>; Fri,  5 Mar 2021 10:26:01 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id t29so2605677pfg.11
        for <linux-pm@vger.kernel.org>; Fri, 05 Mar 2021 10:26:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=b+6US9S2Mo/fA8cxA8PbORoFM9bf1HT3GRemrhIH+Wk=;
        b=nS92C71VP6fKmc1z4Xia5Kszzq+MM3kIGz0hi8yicaoHQVeiysirqegk+h05Ad0Wr2
         72bvSRExMwt8lF1HWqmIB45DN/U2n+1u7oye4RGhcaWSQ6Ly+vwZHJ+Tm/7Vy/kXw4Sa
         nyy1hbX8QVKpU7rgm002WBwZWDgqnHRLXw3zx/5HZaKIpmSoBokOQ7EZuvF2mS2pTH9m
         XSIjX5u5wzrMaH+PAg8x1C+eN/+UcZP52TDMOMLw7M1q57Bfl+Vw6TNw4q7y1oLoC9Q2
         I+ClL+4nYdMl1xTP8wr8o52r8KdU9xhzRehnNq4MvwFTEBPVcRQjNdQo3utLziJXBzyz
         znjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=b+6US9S2Mo/fA8cxA8PbORoFM9bf1HT3GRemrhIH+Wk=;
        b=qs+vVZ3Qta8jveKN7JYhaHKD4TCqgU87hPVKipMUWsHCI9jtiaAyEbDAXLVoOHcYMX
         Z7GQH8EXVvYfs9sdPIkRPNlHKySLsYUtCPZ6k15YlQZ1j+673eKhEW+2TbjNTv7OevPu
         l5JH2Mc1i/r0ryka6b3MDW110goArJZoarkeEyVyogsDdkehqKy+zsMxe8I99ugNv3Wx
         ooR04eiiFcZtHNY+m7AsGb/WSyL7SvV298/5nI43WqzbUBTyQvsI9AMjpjt3YtCanQV2
         6UEPL+Pf3TWPffwLRBBemDjTXip92SZwNy3uBisCNbmaNeR/9dtD4k/hw4aejQWZtrpl
         +y9g==
X-Gm-Message-State: AOAM532kju4f02q8ZK10nII/aJkTNneWomeYw2qzOpxb/PDfltrYXEby
        0RrPkrDKndvotZlyd/8iS4qbrA==
X-Google-Smtp-Source: ABdhPJz9llIhPzUZiYF/KplyRwCVLCHhoCKvhb7Q1wliYHDG7YziuxnpItrwj3tIbZnosnHKVXmIrg==
X-Received: by 2002:a63:5a0c:: with SMTP id o12mr9776037pgb.76.1614968761500;
        Fri, 05 Mar 2021 10:26:01 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id e185sm3199612pfe.117.2021.03.05.10.26.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Mar 2021 10:26:01 -0800 (PST)
Message-ID: <604277b9.1c69fb81.fc654.8801@mx.google.com>
Date:   Fri, 05 Mar 2021 10:26:01 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: acpi-5.12-rc2-19-g5c476073a9df
X-Kernelci-Report-Type: build
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
Subject: pm/testing build: 7 builds: 0 failed,
 7 passed (acpi-5.12-rc2-19-g5c476073a9df)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 7 builds: 0 failed, 7 passed (acpi-5.12-rc2-19-g5c476073a=
9df)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/acp=
i-5.12-rc2-19-g5c476073a9df/

Tree: pm
Branch: testing
Git Describe: acpi-5.12-rc2-19-g5c476073a9df
Git Commit: 5c476073a9df062a501edf9ea7b11ccc53c27bf7
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
