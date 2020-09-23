Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 409F7275C40
	for <lists+linux-pm@lfdr.de>; Wed, 23 Sep 2020 17:43:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726184AbgIWPnx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 23 Sep 2020 11:43:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726156AbgIWPnx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 23 Sep 2020 11:43:53 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4237C0613CE
        for <linux-pm@vger.kernel.org>; Wed, 23 Sep 2020 08:43:52 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id d13so14631540pgl.6
        for <linux-pm@vger.kernel.org>; Wed, 23 Sep 2020 08:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=AHNCPLFsvZKtqUErP+fp58w5xWymP7RAn7BuGuARPsI=;
        b=E89yE3DJiqYVP1hn2qvTapRFtPYXEqLIl8Mq9sx3ut0xple3WjsVYCr1+NPbn7mM/N
         x1mKCF2wf47Uv/ewAagiIu1ifFve8eqgQWHM11QLa3rSfNM+QzUD2tIzBhTPMakrbj5L
         M86/40Hyp/J2Hf1vqWSWXSTOSTvsk28XOZZJCXL52pm4B+P0M/+Trai7fyan8eeXg0c+
         JSh2bQR9KNhbYJ+rULTlFFicjcIN7QqRx+Ic39n8nsMrTekjuysxeiWFVdHy/p3WoXA9
         4N4sl0LWFfZnyf+jbpm93ds1KmOrhu5p1C/e/QVi28GOrUvuih5CVTpieDDLxsiyj9TC
         hGhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=AHNCPLFsvZKtqUErP+fp58w5xWymP7RAn7BuGuARPsI=;
        b=RjPeCE+2jKYUtb9ulqzTOtrFyK8nG2aHtfQPAT0jheMRPMWEGliomqwkFdkqVFbp8E
         KSwzfi1xiz6DZnfFd/KdZCgdqbVRj7EREAPZ7OBLPZwoT5OqpMkSZHkKmKsRaGpJlkVv
         XN00BS/YcHk4Uj3T7uOAm9TSufe0pKmmEuD1YDVpdmg7mKAAhPwrJRo/3613VWvobVF5
         Ugteen5gNJbHbRiSYqlNdFY2PCOx/QqpXbIVqvboX9dep405yI7GNDJt5J/nSItfLsrC
         BgJzKWlYO+rupTzq5ny5ordEudLUsbn8rqlYFCEd0IsW5V25u4BNDUtU1llZ00mJOfC9
         etJQ==
X-Gm-Message-State: AOAM533GmbKcNJeBVDZRynifDF9NsACeymW3nusOe9wE1n5QlkvHNvyi
        ZRdtGC/VJwhf75v5GIiUAUWGLUFmaX/1VA==
X-Google-Smtp-Source: ABdhPJyBT+p8mTg8hwjNWjzwFPcw2TpTYfEb87VntYDtk2GDWWqNBFFPH/gF1jsvr9LNElDtJBD6ZQ==
X-Received: by 2002:a62:2c8:0:b029:13e:9ee9:5b25 with SMTP id 191-20020a6202c80000b029013e9ee95b25mr502916pfc.1.1600875832301;
        Wed, 23 Sep 2020 08:43:52 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id z28sm149206pfq.81.2020.09.23.08.43.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2020 08:43:51 -0700 (PDT)
Message-ID: <5f6b6d37.1c69fb81.14cf3.05a9@mx.google.com>
Date:   Wed, 23 Sep 2020 08:43:51 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
X-Kernelci-Kernel: v5.9-rc6-35-g5dee22f9d504
Subject: pm/testing baseline: 102 runs,
 1 regressions (v5.9-rc6-35-g5dee22f9d504)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 102 runs, 1 regressions (v5.9-rc6-35-g5dee22f9d504)

Regressions Summary
-------------------

platform | arch | lab           | compiler | defconfig          | results
---------+------+---------------+----------+--------------------+--------
panda    | arm  | lab-collabora | gcc-8    | multi_v7_defconfig | 4/5    =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.9-rc6=
-35-g5dee22f9d504/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v5.9-rc6-35-g5dee22f9d504
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      5dee22f9d504e6f0a1ab8559900638a87376475c =



Test Regressions
---------------- =



platform | arch | lab           | compiler | defconfig          | results
---------+------+---------------+----------+--------------------+--------
panda    | arm  | lab-collabora | gcc-8    | multi_v7_defconfig | 4/5    =


  Details:     https://kernelci.org/test/plan/id/5f6b63240e32fbd3f0bf9dce

  Results:     4 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.9-rc6-35-g5dee22=
f9d504/arm/multi_v7_defconfig/gcc-8/lab-collabora/baseline-panda.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.9-rc6-35-g5dee22=
f9d504/arm/multi_v7_defconfig/gcc-8/lab-collabora/baseline-panda.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05/armel/baseline/rootfs.cpio.gz =


  * baseline.dmesg.alert: https://kernelci.org/test/case/id/5f6b63240e32fbd=
3f0bf9dd4
      failing since 34 days (last pass: v5.8-107-gb72b3ea38c81, first fail:=
 v5.9-rc1-4-g1f08d51cd57f)
      60 lines

    2020-09-23 15:00:47.092000  kern  :alert : BUG: Bad page state in proce=
ss swapper/0  pfn:9c802
    2020-09-23 15:00:47.100000  kern  :alert : BUG: Bad page state in proce=
ss swapper/0  pfn:9c803
    2020-09-23 15:00:47.104000  kern  :alert : BUG: Bad page state in proce=
ss swapper/0  pfn:9c804
    2020-09-23 15:00:47.110000  kern  :alert : BUG: Bad page state in proce=
ss swapper/0  pfn:9c805
    2020-09-23 15:00:47.116000  kern  :alert : BUG: Bad page state in proce=
ss swapper/0  pfn:9c806
    2020-09-23 15:00:47.122000  kern  :alert : BUG: Bad page state in proce=
ss swapper/0  pfn:9c807
    2020-09-23 15:00:47.128000  kern  :alert : BUG: Bad page state in proce=
ss swapper/0  pfn:9c808
    2020-09-23 15:00:47.134000  kern  :alert : BUG: Bad page state in proce=
ss swapper/0  pfn:9c809
    2020-09-23 15:00:47.140000  kern  :alert : BUG: Bad page state in proce=
ss swapper/0  pfn:9c80a
    2020-09-23 15:00:47.146000  kern  :alert : BUG: Bad page state in proce=
ss swapper/0  pfn:9c80b
    ... (49 line(s) more)
      =20
