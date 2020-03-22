Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF2AF18E80A
	for <lists+linux-pm@lfdr.de>; Sun, 22 Mar 2020 11:29:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbgCVK3K (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 22 Mar 2020 06:29:10 -0400
Received: from mail-pj1-f48.google.com ([209.85.216.48]:33842 "EHLO
        mail-pj1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726866AbgCVK3K (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 22 Mar 2020 06:29:10 -0400
Received: by mail-pj1-f48.google.com with SMTP id q16so4790845pje.1
        for <linux-pm@vger.kernel.org>; Sun, 22 Mar 2020 03:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=ojkmA8Xi1Usomk8+YarWXa+uawjtHkQkeeUoLTdLzrw=;
        b=BDmJK+t7qJZH+5+lQt8zwZ6BFFqBhoi7tgzHBtwmJM5rfK4rpUxJWo0nAKsOVy8/XT
         stWOYqHJB6CSCoDEkjuOOqjUEcsPMEsrotO8z8V+VfoZjftdSUBZLxSTrtShPuqkH0Z+
         ACueLXesN+g7YFnwaxMYcYjtK6fa0QhEv50IAECw489sVFmE6puNB0QqDMdzBYRdqw3k
         6xwKz1tBS+r7Mou8NDHug/Po9cqPizGIkeoZcqACosqwSHpVDf8ugMY3j70kfoMc8ePO
         Kgq0lDAxGiC79DRsQvimxOsxo4polTqD3jv5poZIgSnlM5IRexnatIFtjcnrZLxoeXtR
         IHvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=ojkmA8Xi1Usomk8+YarWXa+uawjtHkQkeeUoLTdLzrw=;
        b=Ll5ojgg7sQ+RsFs73InPI1PzaafZgTaPEdIcCgKdAbpU6x0hICPPkp8MzpDSOcZ9J3
         25AW09WDhp4CV5KoJ89I/VItYT9yneZc2P6jyWMu0e5pc4ps7foF2Z2rFGWxaJgsOXGy
         WvSL3f0gj4zTGEUp/4ziEFA7nDhOJNspttz3C5T05RnLtoFogn2QYQHI0YqxSu/aRrc6
         7kIGnehoVcEiDzUER+vF5M1VNhRU6Tvmtf5WQ+XAICrB1HtVu4uWq3a/coNyYii2MF+T
         N2ceYDINeZP3zJcBZ6ALbRYKw2TH5AhtQTDvyOU6sB6EFAQhA8rjcpl4t5zooZEcDXvc
         PCQQ==
X-Gm-Message-State: ANhLgQ3Zbld1BtRo+SpY7nV56ZnFNOBembYe6H8YPxcjeBK9D6gxBylV
        n3ysxYSqOJY6yj9IdwnqlX+cMw==
X-Google-Smtp-Source: ADFU+vtgZr6WvWOEbnabJR/noXk3g7SwSam6/iDVrrq8FBX4DSOtc4fMrAf7Yw3BCMvOhZcbgi3tnQ==
X-Received: by 2002:a17:90b:370c:: with SMTP id mg12mr17830435pjb.96.1584872949468;
        Sun, 22 Mar 2020 03:29:09 -0700 (PDT)
Received: from [10.0.9.4] ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id 71sm10702947pfv.8.2020.03.22.03.29.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2020 03:29:08 -0700 (PDT)
Message-ID: <5e773df4.1c69fb81.1d6cf.6e62@mx.google.com>
Date:   Sun, 22 Mar 2020 03:29:08 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v5.6-rc6-104-g5e3ada361a7a
X-Kernelci-Report-Type: build
Subject: pm/testing build: 6 builds: 0 failed,
 6 passed (v5.6-rc6-104-g5e3ada361a7a)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org
From:   "kernelci.org bot" <bot@kernelci.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 6 builds: 0 failed, 6 passed (v5.6-rc6-104-g5e3ada361a7a)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
6-rc6-104-g5e3ada361a7a/

Tree: pm
Branch: testing
Git Describe: v5.6-rc6-104-g5e3ada361a7a
Git Commit: 5e3ada361a7aef36e173fc7004a8e9f0066f9010
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
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
