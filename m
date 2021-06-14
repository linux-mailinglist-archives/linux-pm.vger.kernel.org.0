Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92AEE3A71E5
	for <lists+linux-pm@lfdr.de>; Tue, 15 Jun 2021 00:25:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229979AbhFNW1r (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 14 Jun 2021 18:27:47 -0400
Received: from mail-pl1-f178.google.com ([209.85.214.178]:38869 "EHLO
        mail-pl1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231365AbhFNW1p (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 14 Jun 2021 18:27:45 -0400
Received: by mail-pl1-f178.google.com with SMTP id 69so7397602plc.5
        for <linux-pm@vger.kernel.org>; Mon, 14 Jun 2021 15:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=77kFASg6iJ7SnQsYnF1VHWBUbsK2CouXzB16oEE7Kys=;
        b=yLPpDQJlU4Da8Cj6lTjnNZ/+AiPGcG9Cvv5RSORfOzAS1ryJ9g2ZA27w7lWUTlxkDP
         Hb748ouDq2ChyhRGmYd/TLeZAlcR/uX+pxnKHVd3p6buMH2dY4WmKiGoHer7ClZEAGPt
         EEUMYIVWpZrRbNiq9S2DL6iTCuLdSzUB82sq8OccIx9JTcQYb2UWguI4oWG/K1D6/LcQ
         vANoF8tuYosgPrHj/mLvYolIpptsIBHz21em4oQBOdOfq343kYZ9JFQxO2/PfIOq9O/u
         1wYxHi5o0wYidosxg021B8wQ5ZukCawEeBFRYKesND6HMF4ZYt7/Wtm/FMRAJTGXv0EG
         TnMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=77kFASg6iJ7SnQsYnF1VHWBUbsK2CouXzB16oEE7Kys=;
        b=eMpN5NQs0YeHJFiy8tYYqwjp/K50ChUwcAv/cSO0f0RzyCEGIhYTaR8vh1ia0+vGGj
         169YGBgHbNn3kIRZI1w19UK4HvzIU3ekTGX/eO7dFp7DM9j/UvduqXIhZqZ9TdBgsRwI
         56EZP60tblXSATNxREgO/6RIg4n1OBXVeg04Lrqx8hSasoTjsxvFgHQHpbqXzXJKeuI9
         M5O96P8IL57s5KNPIqX+jTHrNNdE/kRV7BJJUmgnC9y0q8TOR3zeXD+WqwIsp96ZeZlN
         NsdXOJEpIdVYr6qyUo5bMnm+aXTq26kC1hd5lNpGAeu0j/NwbaxeTS75HhA/KaRTCYvx
         bNfw==
X-Gm-Message-State: AOAM532h7rzeK82IPtTdZ938jLUzubwWZ46EXJ93WGbsTlBYpa4fYYLd
        KxcIqSSNGaN1tWx9yMBP/s/vBg==
X-Google-Smtp-Source: ABdhPJz2tGtmC2gD2QSv5+lOmqpEyybm3aou0K06evwUXoQ5q5MF2EoCvKAjwvF7uNbdo+ef0iohpg==
X-Received: by 2002:a17:90a:4812:: with SMTP id a18mr1436406pjh.40.1623709482238;
        Mon, 14 Jun 2021 15:24:42 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id z7sm13848978pgr.28.2021.06.14.15.24.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 15:24:41 -0700 (PDT)
Message-ID: <60c7d729.1c69fb81.40242.9474@mx.google.com>
Date:   Mon, 14 Jun 2021 15:24:41 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v5.13-rc6-116-ga206065a8406
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
Subject: pm/testing build: 7 builds: 0 failed,
 7 passed (v5.13-rc6-116-ga206065a8406)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 7 builds: 0 failed, 7 passed (v5.13-rc6-116-ga206065a8406)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
13-rc6-116-ga206065a8406/

Tree: pm
Branch: testing
Git Describe: v5.13-rc6-116-ga206065a8406
Git Commit: a206065a840616e966a96a148a690b169746b642
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
