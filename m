Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 244C443B532
	for <lists+linux-pm@lfdr.de>; Tue, 26 Oct 2021 17:11:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235476AbhJZPOB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 26 Oct 2021 11:14:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236225AbhJZPN5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 26 Oct 2021 11:13:57 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 189CFC061767
        for <linux-pm@vger.kernel.org>; Tue, 26 Oct 2021 08:11:34 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id ls14-20020a17090b350e00b001a00e2251c8so1961579pjb.4
        for <linux-pm@vger.kernel.org>; Tue, 26 Oct 2021 08:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=BSnFByGdNbMK48EFHibqPnnNickXc+LxiIiHetJOH4w=;
        b=tpZ3gfXg90nvp+k35FXNZsRaMlwYfBrV68eHLtnp2MJNW+TriJtqUcX7SODnPi/vcK
         mSn0ynslUECQmR0haxtinmVgQf0PwEPvgq9fGvzAUthlyC4WWycW26IIMzTJj/qfdLXb
         UWVKQBhBcCWuLtUBHZxE5IW0SZh3h+kFw/2CFMF7YeFYDHeMhG9rym8och2FstwZ9MRv
         GNEwDDCpRPuUhAFGYpcleN8VeFYML0+hLYlBR0og1wfsJv4D/TEpF8BCD0f68hxskZaj
         mMxDNwpglp1qdPmom2ERqA0+vCrMO+fC+ltTQuw5SgZRBFf4zSZlFLM1Q7pUSTF9AXLP
         vGUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=BSnFByGdNbMK48EFHibqPnnNickXc+LxiIiHetJOH4w=;
        b=nfKGMak4helK42GkEatGkv76DLECbk4kihcgX2EP/k3KfxTx9qn0IcFNUPvxEeikCI
         Kn5Yj2P9kyBACoFqdNlpaqN6WmM19MeNrES40p4m3TQCXYRtJHMvcWOAVtLLuPyRk9K4
         lZ+/Q03UQVMr/UKxZbaDDqcMtkj3e/Bg6TXAn+jroYk7r3vhDjIOSHKT5kqcVjBQlsGV
         by2cmdfOLqUOsqVLpxfvXfeZAb+uJyd2pjnMJO23PEWE04bmOa5bKcUkDqAicBeYZHuL
         YgCtxWvcQrDb1RhsGWKWyeMnx5+wsRm4RwO8KutRt4v2dpDdL18HrWRdqhEJ8rQg0ARH
         nrPw==
X-Gm-Message-State: AOAM532Z1E4VE/RxHf9wXM1NOMrECUgUP4hMIZKca0UnzRhNgvkzWilM
        D4+WTRnN79k72n8MbUXgxBJRr+ZviRdJg68K
X-Google-Smtp-Source: ABdhPJxhjrkCdqtzSkoaFYeJqqC8CKQoRr5t9zoyZkkrY4bhmt872yGgl1KZSBS7A0zvreLVYCiy5Q==
X-Received: by 2002:a17:90b:4b4f:: with SMTP id mi15mr15847250pjb.150.1635261093627;
        Tue, 26 Oct 2021 08:11:33 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id z22sm8680323pfa.214.2021.10.26.08.11.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 08:11:33 -0700 (PDT)
Message-ID: <61781aa5.1c69fb81.7fea.4e08@mx.google.com>
Date:   Tue, 26 Oct 2021 08:11:33 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v5.15-rc7-95-g5ae5ac40021d
X-Kernelci-Report-Type: test
Subject: pm/testing baseline: 75 runs,
 1 regressions (v5.15-rc7-95-g5ae5ac40021d)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 75 runs, 1 regressions (v5.15-rc7-95-g5ae5ac40021d)

Regressions Summary
-------------------

platform      | arch  | lab          | compiler | defconfig | regressions
--------------+-------+--------------+----------+-----------+------------
rk3328-rock64 | arm64 | lab-baylibre | gcc-10   | defconfig | 1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.15-rc=
7-95-g5ae5ac40021d/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v5.15-rc7-95-g5ae5ac40021d
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      5ae5ac40021d00a4ebbfd42bd7f78ea42d613a1a =



Test Regressions
---------------- =



platform      | arch  | lab          | compiler | defconfig | regressions
--------------+-------+--------------+----------+-----------+------------
rk3328-rock64 | arm64 | lab-baylibre | gcc-10   | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/6178115ce7430836d43358f3

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.15-rc7-95-g5ae5a=
c40021d/arm64/defconfig/gcc-10/lab-baylibre/baseline-rk3328-rock64.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.15-rc7-95-g5ae5a=
c40021d/arm64/defconfig/gcc-10/lab-baylibre/baseline-rk3328-rock64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-6-g8983f3b738df/arm64/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6178115ce7430836d4335=
8f4
        new failure (last pass: v5.15-rc6-80-g30c7771b41dc) =

 =20
