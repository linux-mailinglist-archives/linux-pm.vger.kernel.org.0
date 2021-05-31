Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C30D139698A
	for <lists+linux-pm@lfdr.de>; Tue,  1 Jun 2021 00:07:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231585AbhEaWJF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 31 May 2021 18:09:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231305AbhEaWJF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 31 May 2021 18:09:05 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31A37C061574
        for <linux-pm@vger.kernel.org>; Mon, 31 May 2021 15:07:23 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id e1so1551915pld.13
        for <linux-pm@vger.kernel.org>; Mon, 31 May 2021 15:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=brGsxCU8Dbm+jbWoMidE8Pfl9lZFsNx+8JXzmCsAiEo=;
        b=ZEfUZp+aWZWGvKzTwnOxazljkM0wDE33BkmIVMGWAe9UivSPLqxUL2Nk5M3+XG+pHi
         L/eXKEboLCbYMW7wCC1wSzAUHG4T6pXeTglPNW407gkqUrZJ8XGUmeyjjOzmf/L4csCp
         90U8lmAZyZer/J1VMK57AMbhBIZlU3acKDtPN3KdLz6HZ/iPHZqohwMrlBSZi+92KSI9
         wNemZhWqK9l9mFZLFL5s978yqPHKRhK8kgFANACpwLiQG3ayJGulKA9MkZO6RlHosIWl
         qOoOwh9LB1N8QZSSInrbAtOk8oXXhSwXtoK0yRY4ecS8jzI3FUGT5nlqVVvpBuOH0iaL
         vXYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=brGsxCU8Dbm+jbWoMidE8Pfl9lZFsNx+8JXzmCsAiEo=;
        b=oGcJ0F0IePEPQCUMYkXmY8Wb1Kr4e6xH6tKsUrllvnppUvCTB4BpA+9oN9j/+oEJY+
         LLkWbmKVnsr8eTdusCQFCtYHGx6NWSRdwVLo6BNC18epFt5195CA4ArFd/qovr7ckhLY
         p8Q4IzH5Bn3ipy8Sh3WSHlC6w4y+EoBrHhFJ+4ZEpldCrmt/DalpcHzT1zfpincd1l0p
         Hf+nimf/O0jEbrjCBbT9Eg6b7s8UV0LOy4FMa7g+ELoR0MlJ/jecGq7v2rj7UBEmdm9Y
         Q/cxUsRkZNfm0xA2XFUAQ+vpZIJSIX3QsgEFOhrX/No/qOjtz0HT03ydd04NmAWWBwDn
         Yovw==
X-Gm-Message-State: AOAM531y5QOAgkhTLGTij9QLUpj3tEKM5U1o1P29fQ64Gbk8XyM3salV
        vCUBCocsG7kWnkBL3AVn6A3xzw==
X-Google-Smtp-Source: ABdhPJx6RujKpKjhNkpQ4XDaBLex8C6bWKDAq1n6yqW+Cm59jwr20lFdj8mjcW4n3X1obdRlAjQi4g==
X-Received: by 2002:a17:90a:ba01:: with SMTP id s1mr1212429pjr.74.1622498842675;
        Mon, 31 May 2021 15:07:22 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id t12sm4898037pfc.133.2021.05.31.15.07.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 May 2021 15:07:22 -0700 (PDT)
Message-ID: <60b55e1a.1c69fb81.2e756.ec9c@mx.google.com>
Date:   Mon, 31 May 2021 15:07:22 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v5.13-rc4-36-g3931fd6facb6
X-Kernelci-Branch: testing
X-Kernelci-Report-Type: test
Subject: pm/testing baseline: 92 runs,
 1 regressions (v5.13-rc4-36-g3931fd6facb6)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 92 runs, 1 regressions (v5.13-rc4-36-g3931fd6facb6)

Regressions Summary
-------------------

platform   | arch  | lab     | compiler | defconfig | regressions
-----------+-------+---------+----------+-----------+------------
imx8mp-evk | arm64 | lab-nxp | gcc-8    | defconfig | 1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.13-rc=
4-36-g3931fd6facb6/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v5.13-rc4-36-g3931fd6facb6
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      3931fd6facb67570e97b861b6beb5a673c492fda =



Test Regressions
---------------- =



platform   | arch  | lab     | compiler | defconfig | regressions
-----------+-------+---------+----------+-----------+------------
imx8mp-evk | arm64 | lab-nxp | gcc-8    | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/60b55601699b5e3030b3afc2

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.13-rc4-36-g3931f=
d6facb6/arm64/defconfig/gcc-8/lab-nxp/baseline-imx8mp-evk.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.13-rc4-36-g3931f=
d6facb6/arm64/defconfig/gcc-8/lab-nxp/baseline-imx8mp-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-5-g2f114cc7102b/arm64/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/60b55601699b5e3030b3a=
fc3
        new failure (last pass: v5.13-rc3-39-gb2864f8ca01d) =

 =20
