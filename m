Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D29CE275CA0
	for <lists+linux-pm@lfdr.de>; Wed, 23 Sep 2020 17:58:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbgIWP6x (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 23 Sep 2020 11:58:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgIWP6x (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 23 Sep 2020 11:58:53 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8C76C0613CE
        for <linux-pm@vger.kernel.org>; Wed, 23 Sep 2020 08:58:52 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id f2so14658299pgd.3
        for <linux-pm@vger.kernel.org>; Wed, 23 Sep 2020 08:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=W1aTWsbxhQ+aTQonuMGx6xR0hjG1bOpvURxp1bhuSck=;
        b=l0WfkSPS4efd2Vrlr/hgVSHNOXMnWewlI6nt+NjbRZjTdxWC3HhV27fOKIYHDPQPbu
         E10TlcgkbmOUvwsBxnPxM2whcWMdkXfPqKfe3sGWIaQ6z5gN+FZAEEAbdQRvro9bEoxB
         B2lMFDxzQLxIF8xkNMRw6XkgRDkzx9pdkXCx0bPp0Qme11VfLNJLblFGs2dv6fdBxlJ8
         HIxo0q/mh70DdEQB5FWNIdJGTiBAkVr4U2bfcbIrx/3xTX/KVAtpFfIrgC87Erwtyoj1
         Z16clxZIiZfHdeGl7ADnYTx//rn/dsvWWZVgT7ZgOGbS0IStaU1sVIsa6P3AgSnSvJQ6
         YzJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=W1aTWsbxhQ+aTQonuMGx6xR0hjG1bOpvURxp1bhuSck=;
        b=mnB7AKf2O6z5gGOaLJguWkRX0KQsh9uMZOs/k6WatV4Tw0rkLpL70FLkw9WP1qhZJV
         IJSfctFDJVe56m1iHbQCCsVFeJZK1M8fWNhNRjnpaIO5rzeCoxI0oKuFxdlDgN6Ocln1
         exCGZb4FH0OtwWb7c3Q2Mk2oj7bCQjCsxcALzwJJfMF8JUUzM7deWZ1zYLfpdvOgEdhu
         PcK5e+/YHTDDyyWyG7uyz9whUlP9AfitQcMo6zmENNHC9pYp51JBVWDLfnipHBY1a6Gl
         Uks4QZfkBZWF7fkZQ60Fq4T/FtDj/kQJnb0rZd74ciFqBbzcysI/r8FtYXhImYUty29M
         cPFw==
X-Gm-Message-State: AOAM532+6nLnyZlfhGqwfMkyEuPiu3vlb1xT+Z7oqEIZu4caCWs4pYG5
        qF4cwuk1h7UQF4AWz4oEz3gXGg==
X-Google-Smtp-Source: ABdhPJwxQStw2UcHi18nk7bRc0C4EVZQNANbafCt9RaRVDmeO7rYcGilLvX6SW4IN4skrQQMRfkU2w==
X-Received: by 2002:a63:cc42:: with SMTP id q2mr391086pgi.216.1600876731990;
        Wed, 23 Sep 2020 08:58:51 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id r2sm264823pga.94.2020.09.23.08.58.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2020 08:58:51 -0700 (PDT)
Message-ID: <5f6b70bb.1c69fb81.d2631.0a6d@mx.google.com>
Date:   Wed, 23 Sep 2020 08:58:51 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
X-Kernelci-Kernel: v5.9-rc6-35-g5dee22f9d504
Subject: pm/testing sleep: 6 runs, 2 regressions (v5.9-rc6-35-g5dee22f9d504)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing sleep: 6 runs, 2 regressions (v5.9-rc6-35-g5dee22f9d504)

Regressions Summary
-------------------

platform         | arch  | lab           | compiler | defconfig | results
-----------------+-------+---------------+----------+-----------+--------
mt8173-elm-hana  | arm64 | lab-collabora | gcc-8    | defconfig | 0/1    =

rk3399-gru-kevin | arm64 | lab-collabora | gcc-8    | defconfig | 0/1    =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.9-rc6=
-35-g5dee22f9d504/plan/sleep/

  Test:     sleep
  Tree:     pm
  Branch:   testing
  Describe: v5.9-rc6-35-g5dee22f9d504
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      5dee22f9d504e6f0a1ab8559900638a87376475c =



Test Regressions
---------------- =



platform         | arch  | lab           | compiler | defconfig | results
-----------------+-------+---------------+----------+-----------+--------
mt8173-elm-hana  | arm64 | lab-collabora | gcc-8    | defconfig | 0/1    =


  Details:     https://kernelci.org/test/plan/id/5f6b62de57e7fad2b6bf9dcf

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.9-rc6-35-g5dee22=
f9d504/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.9-rc6-35-g5dee22=
f9d504/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2020=
0911.0/arm64/rootfs.cpio.gz =


  * sleep.login: https://kernelci.org/test/case/id/5f6b62de57e7fad2b6bf9dd0
      failing since 34 days (last pass: v5.8-107-gb72b3ea38c81, first fail:=
 v5.9-rc1-4-g1f08d51cd57f)  =



platform         | arch  | lab           | compiler | defconfig | results
-----------------+-------+---------------+----------+-----------+--------
rk3399-gru-kevin | arm64 | lab-collabora | gcc-8    | defconfig | 0/1    =


  Details:     https://kernelci.org/test/plan/id/5f6b631b7430cbe6d7bf9dd8

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.9-rc6-35-g5dee22=
f9d504/arm64/defconfig/gcc-8/lab-collabora/sleep-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.9-rc6-35-g5dee22=
f9d504/arm64/defconfig/gcc-8/lab-collabora/sleep-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2020=
0911.0/arm64/rootfs.cpio.gz =


  * sleep.login: https://kernelci.org/test/case/id/5f6b631b7430cbe6d7bf9dd9
      new failure (last pass: v5.9-rc6-28-gbc13abdb9140)  =20
