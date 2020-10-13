Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3215A28C74B
	for <lists+linux-pm@lfdr.de>; Tue, 13 Oct 2020 04:49:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727836AbgJMCtX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 12 Oct 2020 22:49:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727075AbgJMCtX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 12 Oct 2020 22:49:23 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BEA7C0613D0
        for <linux-pm@vger.kernel.org>; Mon, 12 Oct 2020 19:49:23 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id x13so13081674pfa.9
        for <linux-pm@vger.kernel.org>; Mon, 12 Oct 2020 19:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=JvaNb/vyWILgjwlb+McV9I2mLfEUovf/jDeO9CieO2c=;
        b=VXONV3BeLlrXazla9wbw9BwJprwL4En7aF1ATtZISWbFH7Tno2l3wCsxZHLGihVb8u
         HNISauK6r3OEP9YHudA6UlfJ50V8tq+G1ljU6qYQAsM4piBrc6tyzfuYo2O/t1rb/Sn4
         MjV5wXP4vWJcVBJ9F/OND1o0keD5WNiQuwrvBPLV8JR+JSODEiDFQVGFyq/pAaiNwNe6
         ZVLKDp6z+CT4XatfMpXlhgi0CozT6YMpH53kSPos1SKfsvwztGGZFr1tS8ifHzSb42ou
         8PBwt4M5iZCOeHHzpwyjr29Aju+vsA8TsX6oc6GMF1isu4/F8/WLbDv91XHMlEdxBbYm
         KE4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=JvaNb/vyWILgjwlb+McV9I2mLfEUovf/jDeO9CieO2c=;
        b=jU80RiWLUsfQJIV3W2yv/KpTsB47T8z/wiUzgh3cQT5m2ayoya2kex+p8ZOUUSDSdZ
         b0MIYJtq8n1DRvkFs6OGUemSizfactRmjEDbqzwdU526sRk+k544PFGzVjN3xl6zIOQh
         uIA/zzxk2sskHS73aKIuM4/PDHG7B42fzWGFGEtrlpbIJv0FVJdGON8aUULRWzZTQ2s0
         Mv2TjUT59MO0/0uOKvvudxas4MM+YOFdOoOTTaYAWqdOiMN0NvMtZMigOpVqtp6R7hyk
         6jAprlJLJQ+Dasez/OUP/Nc2FgBUR+MVmQbXvTFEmKzzibIIcVXTjNmmWstscIaK77W6
         YNtQ==
X-Gm-Message-State: AOAM532n/JLU008jdbQNYNCb179EHArmP0MkZ8bT5MBrjdN9YnJHuJ8F
        b8eqIc04O1qb3n36HD+ChtvXeQ==
X-Google-Smtp-Source: ABdhPJwqYdVUoY3ts0w6iDaOOS4VM26S+QWhRGoBf0/AjFtCn/2483tBnohqzPTBcdHpOMkUmaxKkg==
X-Received: by 2002:a17:90b:1490:: with SMTP id js16mr10625903pjb.184.1602557362601;
        Mon, 12 Oct 2020 19:49:22 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id 14sm2981923pfy.192.2020.10.12.19.49.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2020 19:49:21 -0700 (PDT)
Message-ID: <5f8515b1.1c69fb81.946b8.666c@mx.google.com>
Date:   Mon, 12 Oct 2020 19:49:21 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.9-rc8-160-g91e0225c546b
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
Subject: pm/testing baseline: 98 runs,
 1 regressions (v5.9-rc8-160-g91e0225c546b)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 98 runs, 1 regressions (v5.9-rc8-160-g91e0225c546b)

Regressions Summary
-------------------

platform | arch | lab           | compiler | defconfig          | results
---------+------+---------------+----------+--------------------+--------
panda    | arm  | lab-collabora | gcc-8    | multi_v7_defconfig | 4/5    =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.9-rc8=
-160-g91e0225c546b/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v5.9-rc8-160-g91e0225c546b
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      91e0225c546b542d828011feef9fb155e18b7941 =



Test Regressions
---------------- =



platform | arch | lab           | compiler | defconfig          | results
---------+------+---------------+----------+--------------------+--------
panda    | arm  | lab-collabora | gcc-8    | multi_v7_defconfig | 4/5    =


  Details:     https://kernelci.org/test/plan/id/5f8505e8d15bc004284ff3f5

  Results:     4 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.9-rc8-160-g91e02=
25c546b/arm/multi_v7_defconfig/gcc-8/lab-collabora/baseline-panda.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.9-rc8-160-g91e02=
25c546b/arm/multi_v7_defconfig/gcc-8/lab-collabora/baseline-panda.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-3-g27eeeac7da2d/armel/baseline/rootfs.cpio.gz =


  * baseline.dmesg.alert: https://kernelci.org/test/case/id/5f8505e8d15bc00=
4284ff3fb
      failing since 54 days (last pass: v5.8-107-gb72b3ea38c81, first fail:=
 v5.9-rc1-4-g1f08d51cd57f)
      60 lines

    2020-10-13 01:41:53.499000  kern  :alert : BUG: Bad page state in proce=
ss swapper/0  pfn:9c802
    2020-10-13 01:41:53.505000  kern  :alert : BUG: Bad page state in proce=
ss swapper/0  pfn:9c803
    2020-10-13 01:41:53.511000  kern  :alert : BUG: Bad page state in proce=
ss swapper/0  pfn:9c804
    2020-10-13 01:41:53.517000  kern  :alert : BUG: Bad page state in proce=
ss swapper/0  pfn:9c805
    2020-10-13 01:41:53.523000  kern  :alert : BUG: Bad page state in proce=
ss swapper/0  pfn:9c806
    2020-10-13 01:41:53.529000  kern  :alert : BUG: Bad page state in proce=
ss swapper/0  pfn:9c807
    2020-10-13 01:41:53.535000  kern  :alert : BUG: Bad page state in proce=
ss swapper/0  pfn:9c808
    2020-10-13 01:41:53.541000  kern  :alert : BUG: Bad page state in proce=
ss swapper/0  pfn:9c809
    2020-10-13 01:41:53.547000  kern  :alert : BUG: Bad page state in proce=
ss swapper/0  pfn:9c80a
    2020-10-13 01:41:53.553000  kern  :alert : BUG: Bad page state in proce=
ss swapper/0  pfn:9c80b
    ... (49 line(s) more)
      =20
