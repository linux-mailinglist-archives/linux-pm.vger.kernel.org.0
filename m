Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 077CE166DC2
	for <lists+linux-pm@lfdr.de>; Fri, 21 Feb 2020 04:32:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729280AbgBUDbM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 20 Feb 2020 22:31:12 -0500
Received: from mail-pj1-f44.google.com ([209.85.216.44]:53183 "EHLO
        mail-pj1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727944AbgBUDbM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 20 Feb 2020 22:31:12 -0500
Received: by mail-pj1-f44.google.com with SMTP id ep11so121306pjb.2
        for <linux-pm@vger.kernel.org>; Thu, 20 Feb 2020 19:31:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=2Z12RFyUyecLtxNLPDumm9FGUARthJ18i1Z7306O22U=;
        b=y1Zgg00qNyacAvRQtclBaD8InwwHHfFd1DmaC/0mr+jYUQ5n05lOvOIsHsMKWx2xpT
         3mFAHy310u9eUuD0ra4/hdtbLpvUp+LcaA38JKA5Fct/9+isUvrWhlhBHaSGkUFoXaWB
         aPI6YxU09MSIp8jq2KGo92z7w3ZOVXlU3UTckODsT5LLDRw4FeBxXehfoh1agblVUMS2
         NzmL/gs/4iM+oLBsJqAKpaKTLIZM86gzAiWNzvDNApmMcjyORyyI0A3m5UXayZJq25lW
         x84EE07y81YJpA+asLB4NRavY8m636h2q0oOjFP8GD4v+pG0AsFcb1oUhr1B2Jp4KVS2
         rJbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=2Z12RFyUyecLtxNLPDumm9FGUARthJ18i1Z7306O22U=;
        b=Zmp7sRE6fG10lo94XJXVC8kuY/EQtlGiMwLkoj1ZweKupuerlw0nYEZnMN39KRwDLe
         cFd2P4GW77pLsDrzJkGnpYAX3iGC0v/YAaK7v0MPTE8POgivoOxbjFn9oPr9J0d4pqI7
         fj27onVnFZnFgeb6SOwev7nUKNQxVP1kIarKasrsMQfQYnfCu/0UYf79tqhFwkDuT4IA
         Xo/jFamOj4UpqRmvEu8tVAon8QY/YjhOCuwcT5tS31Qytn1v1dIp1cHJ3iCh600u8TJ6
         ViVX+YRfkIuHiDY/OQXeB/RFivbi7CAHxEvoA/49LFF989F7XWNNLK57ktGYmOWQof0e
         pZbQ==
X-Gm-Message-State: APjAAAUD1fmw837otwH42YR/RLiLo7aRi9BsC+xzhPM0NAV7NqtJplk7
        4rLDAQCOfYQNvGHaC+f0THqilg==
X-Google-Smtp-Source: APXvYqwI02044yhgPYyDJAaEngtAT9T0f598bH5nKI7Xf0ML4fjjafYpZoRiYEb6cmxX2jV33Ayz3Q==
X-Received: by 2002:a17:902:8b89:: with SMTP id ay9mr33579464plb.309.1582255870426;
        Thu, 20 Feb 2020 19:31:10 -0800 (PST)
Received: from [10.0.9.4] ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id f13sm699637pgk.12.2020.02.20.19.31.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2020 19:31:09 -0800 (PST)
Message-ID: <5e4f4efd.1c69fb81.b72ee.34e6@mx.google.com>
Date:   Thu, 20 Feb 2020 19:31:09 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.6-rc2-54-gc6cef55cdff7
X-Kernelci-Report-Type: build
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
Subject: pm/testing build: 6 builds: 0 failed,
 6 passed (v5.6-rc2-54-gc6cef55cdff7)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org
From:   "kernelci.org bot" <bot@kernelci.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 6 builds: 0 failed, 6 passed (v5.6-rc2-54-gc6cef55cdff7)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
6-rc2-54-gc6cef55cdff7/

Tree: pm
Branch: testing
Git Describe: v5.6-rc2-54-gc6cef55cdff7
Git Commit: c6cef55cdff715472903e65bda7182f1f254ef6e
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
multi_v7_defconfig (arm, gcc-8) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sec=
tion mismatches

---------------------------------------------------------------------------=
-----
x86_64_defconfig (x86_64, gcc-8) =E2=80=94 PASS, 0 errors, 0 warnings, 0 se=
ction mismatches

---
For more info write to <info@kernelci.org>
