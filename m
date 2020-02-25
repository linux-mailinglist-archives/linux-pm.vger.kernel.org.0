Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA8F916EF37
	for <lists+linux-pm@lfdr.de>; Tue, 25 Feb 2020 20:43:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728443AbgBYTni (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 Feb 2020 14:43:38 -0500
Received: from mail-pf1-f175.google.com ([209.85.210.175]:45619 "EHLO
        mail-pf1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728051AbgBYTni (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 Feb 2020 14:43:38 -0500
Received: by mail-pf1-f175.google.com with SMTP id 2so70804pfg.12
        for <linux-pm@vger.kernel.org>; Tue, 25 Feb 2020 11:43:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=DlMbJINW1coIAAvnFeJw6cu/Z6RQaMDRPekUVYoNZvA=;
        b=D37JvfInrUEp6WQ3KMZKthxW8gfZe9jbjWljZkzpH/6FX4ortJjCnOFlxjSDokDcL/
         nfLN8nvTWK9QYDPfjS4oa6qRPmsCA5DYK830aTIfvOqHYzsX2clwHrK5OKkIuw5Okypz
         QONiORg1gvcA2e+vWJT+uuSYtSf9HXBLvb1JewLT0bOnO7kWUj0pNDjWorlnL42bewS9
         zHfdbcEThwTaMVVj7rthZBRltzT10DOpFJqKnL21NLVrgBl2ObWchmRzodIVzJL/4c1g
         zT64L7FtlGh/ftFCrECOKPOO3GafFtCMxCoL/YAwh3isPUIAkmxzUyUsGHlZkr+hwmzT
         XeCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=DlMbJINW1coIAAvnFeJw6cu/Z6RQaMDRPekUVYoNZvA=;
        b=qqC77nCzHRLronD9rBQ/GKmby2jvsiRUMAm2RwtRhXJ5VEIKLCAlsJHhsRzywZjxZX
         ah2GYqxG3bmITTfGpbwDQDT9cefxeY9PfaGviLRpxjIywfb1dt2K2ttpSD+jCJRDPdbn
         72AtOWVdj0qv9vaAQhkgLUsYFu8b29r8vV1dii6jg86KkLd6+EK/I1y5zPYiyGO6DXVl
         HujMYIw5bXS5caVxiMe64NI6yMQT3cFhUW06S7PU0/Z/UQ6z/GJ4BoPkvmKQ2gu1bitK
         B9FLFDAE//hAiwrHpPaLy/td4CDH+/FgdM8WSpG9RC1gH4cNd3sjCVlb3b5oC69VEpTV
         vifA==
X-Gm-Message-State: APjAAAUi328gfYdafOgLA1hthDCyC54oW6gRXiJkqcysoaTYA1frNsc0
        ZceTfGmNzwjPKnU3hgkaF9R9U2LIue0=
X-Google-Smtp-Source: APXvYqyLwJ75BPws4rBqCoFxryu+q7n16m0vI9m0bbNP8wt3Gyi/OKQA6Se7JEp+JDHqLtmn+Oby/A==
X-Received: by 2002:a63:770d:: with SMTP id s13mr129536pgc.7.1582659817359;
        Tue, 25 Feb 2020 11:43:37 -0800 (PST)
Received: from [10.0.9.4] ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id l37sm4058568pjb.15.2020.02.25.11.43.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2020 11:43:36 -0800 (PST)
Message-ID: <5e5578e8.1c69fb81.873ca.a1e3@mx.google.com>
Date:   Tue, 25 Feb 2020 11:43:36 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.6-rc3-52-g49d2c63e171c
X-Kernelci-Report-Type: build
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
Subject: pm/testing build: 6 builds: 0 failed,
 6 passed (v5.6-rc3-52-g49d2c63e171c)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org
From:   "kernelci.org bot" <bot@kernelci.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 6 builds: 0 failed, 6 passed (v5.6-rc3-52-g49d2c63e171c)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
6-rc3-52-g49d2c63e171c/

Tree: pm
Branch: testing
Git Describe: v5.6-rc3-52-g49d2c63e171c
Git Commit: 49d2c63e171c150bb9683c6660121e596e9e1a39
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
