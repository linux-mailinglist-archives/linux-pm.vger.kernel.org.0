Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C1C82D6A3F
	for <lists+linux-pm@lfdr.de>; Thu, 10 Dec 2020 22:43:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394015AbgLJVmS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 10 Dec 2020 16:42:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404806AbgLJVmQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 10 Dec 2020 16:42:16 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AA13C0613CF
        for <linux-pm@vger.kernel.org>; Thu, 10 Dec 2020 13:41:35 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id t3so5464675pgi.11
        for <linux-pm@vger.kernel.org>; Thu, 10 Dec 2020 13:41:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=Z2wdL9jqI2r1uDOPgQ92ltr8RTr1l8pwzTxhZnzDFcQ=;
        b=b4RFm7vhnqE2br7L/3DJC+kYG8yeGzcVhfa9OLeS984yCJyO/TD7IhJfqzxI5T3wzj
         VbHWC82fwhW1NZ8DdKz0aNG+BOJ2DXbI5Ug2FBjDSSYQDe5U7TwsLqZOrIJDOFFkPKIy
         Dk7ArBOswrC48rsuKvJQN2PyIG/SUXA9jEaEMBeT+EBovEu2u9xi6O2r26GDgXUP5JQt
         ZkzWPjAcgxxv8HoSiVsasNxBwmQTRPq/Q/1CxFrVp/A7jOVltXGfhCD8A85qSOrsfPyY
         Ul42kknjt+6hIEYcT/fkTdpTbR3Dv4gdgdRsBck1B3vNpztXQ0vO5k2zIEE+DI7xhRbq
         JohA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=Z2wdL9jqI2r1uDOPgQ92ltr8RTr1l8pwzTxhZnzDFcQ=;
        b=lFGy+w54R2P1P7LUaRGemS7T4EBKe+HLwnx3lH1PfXZ9A7DfCn55vSi8Dtfqj9xhXn
         3Qa/IYdBl+Ds48fpn5fNQqtBqQU1tZrFSXgwuqf7XcQPYYBC+B9Tf8fHkZKhIftz3RSO
         7YUsbo7qSneJ9ysMHwS+bSsBUQB1JYFGiU+Jj9HK3NEQSzl5m+oMsL3qiZO8SyrsRK6l
         8nhkZsX4KUdLHTAZmKckrwfQsPwn49A+Iuc1BZ0jr6PpzbL2RAF+OkoicKxjP5xq9PCR
         2JIO7bP2xV4ejMURzKYfTUYvHH8h/C8wsYicYNafgym58j4DPx/ZwZqBuA+vunnz4hTm
         RGrg==
X-Gm-Message-State: AOAM530t0QTZOSTtNP9nxvuxee5p9Wb2EJvc/9bVr4UaTPvz427re2jD
        nkpVtfXtbAQbyILTs13GyNroNmgCogYC4Q==
X-Google-Smtp-Source: ABdhPJw3xCtkTf5KdzjLxbi0rkqXIrmfp2yKJ/PYZwmJsYVny7VnRWIkoRfXC/Ht4lOBy1B/fUBe5A==
X-Received: by 2002:a65:52c1:: with SMTP id z1mr8516622pgp.46.1607636495213;
        Thu, 10 Dec 2020 13:41:35 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id g202sm7208707pfb.196.2020.12.10.13.41.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Dec 2020 13:41:34 -0800 (PST)
Message-ID: <5fd2960e.1c69fb81.e480.d960@mx.google.com>
Date:   Thu, 10 Dec 2020 13:41:34 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v5.10-rc7-88-g58dfa0fa290bb
X-Kernelci-Report-Type: test
Subject: pm/testing sleep: 5 runs, 1 regressions (v5.10-rc7-88-g58dfa0fa290bb)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing sleep: 5 runs, 1 regressions (v5.10-rc7-88-g58dfa0fa290bb)

Regressions Summary
-------------------

platform        | arch  | lab           | compiler | defconfig | regressions
----------------+-------+---------------+----------+-----------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-8    | defconfig | 1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.10-rc=
7-88-g58dfa0fa290bb/plan/sleep/

  Test:     sleep
  Tree:     pm
  Branch:   testing
  Describe: v5.10-rc7-88-g58dfa0fa290bb
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      58dfa0fa290bb4c04c0dc3838b5cbce2caec7775 =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig | regressions
----------------+-------+---------------+----------+-----------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-8    | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/5fd289dd87528dbcbcc94cc7

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.10-rc7-88-g58dfa=
0fa290bb/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.10-rc7-88-g58dfa=
0fa290bb/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2020=
1130.0/arm64/rootfs.cpio.gz =



  * sleep.login: https://kernelci.org/test/case/id/5fd289dd87528dbcbcc94cc8
        failing since 113 days (last pass: v5.8-107-gb72b3ea38c81, first fa=
il: v5.9-rc1-4-g1f08d51cd57f) =

 =20
