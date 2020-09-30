Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21C4E27F205
	for <lists+linux-pm@lfdr.de>; Wed, 30 Sep 2020 20:58:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730785AbgI3S6J (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 30 Sep 2020 14:58:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729994AbgI3S6H (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 30 Sep 2020 14:58:07 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BC16C061755
        for <linux-pm@vger.kernel.org>; Wed, 30 Sep 2020 11:58:07 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id y20so1572517pll.12
        for <linux-pm@vger.kernel.org>; Wed, 30 Sep 2020 11:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=wjuL/PEqO7yw5CovYsbI1KeCI7HNM/7I0ENKxb7MBjs=;
        b=FCOsQgU+6Jp4u1M3yV5xvFwJbq7arw6jaWGPJOkByzMDgV9H9Y7GEVWrfppxy0b6PW
         +Xw7flEbgPjCM+iLVioJVyl+ZyMp+pwTFMSQjL5k0u8nEpOuKc93U3rL/zVRGg3/oUvP
         oM0RdD0mPO30ZN+TZFG74RgmzmPEB9+Apnsb1uHdqj3d1rtUSQYP/e+4rTElesNSpX+G
         08cQT8TSr59bgdgzorIhLIJC81Ns/6SKF4tLZPjOHlxgY5VEN69nyrhc2YUvVMfDV+MQ
         fNAI/uCAzL++nQzOKiU8LcLAizgAW6Aujb/AF9C9mo0ojBlvQQGgPHHfDIpUr3bLNPBB
         dJmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=wjuL/PEqO7yw5CovYsbI1KeCI7HNM/7I0ENKxb7MBjs=;
        b=mE0/OekKlZ+8lWTCvO7R4dJ7siZDn8fur5h4jtKt1nN6R4fI6bdffregoYJS0f35/L
         p4AI6MRzDlOvxJf+WUq78M3lu7AYwtj0ZsE9ngm2BFvzfY0pyUBYTnMdmG6tXNpxDlZV
         aiMj61JPRs5vxvxjVJZdKr2ZDMJvaeAtw4MVc2Fib/C11QGqwwOEE5tn0vJFr6lr65NK
         ik4wTg3aFcJqQ7mcFPoEnJg9QmT1NXOizr2WEoXdtBRvekjUG+UvOJ15NdkyGGGnq3Vp
         k/9sc+gEGnVH0DgFtqDUhFj6MwcK8t652UHIesf+Iks/u/bij5FfI5cvG9wKhg79sbLK
         Y/GA==
X-Gm-Message-State: AOAM532UMzAaXXbk7P9UhMP857cbU/iIB1pJxSg7PmhhD394JSRKDhi6
        +DDdZgFjaJopF1FYeB47UPZ795JqHCEDXg==
X-Google-Smtp-Source: ABdhPJwh309LfoBS39b0StbIdiGXxVVTTfDN7e/5uzzezvwbqPA73/K/UMzgAcUKVqNLPvzvdDCkig==
X-Received: by 2002:a17:902:c281:b029:d2:2988:4906 with SMTP id i1-20020a170902c281b02900d229884906mr3610323pld.82.1601492286987;
        Wed, 30 Sep 2020 11:58:06 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id q193sm3353193pfq.127.2020.09.30.11.58.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2020 11:58:06 -0700 (PDT)
Message-ID: <5f74d53e.1c69fb81.4ab45.698e@mx.google.com>
Date:   Wed, 30 Sep 2020 11:58:06 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.9-rc7-75-g027a0d093137
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
Subject: pm/testing baseline: 102 runs,
 1 regressions (v5.9-rc7-75-g027a0d093137)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 102 runs, 1 regressions (v5.9-rc7-75-g027a0d093137)

Regressions Summary
-------------------

platform | arch | lab           | compiler | defconfig          | results
---------+------+---------------+----------+--------------------+--------
panda    | arm  | lab-collabora | gcc-8    | multi_v7_defconfig | 4/5    =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.9-rc7=
-75-g027a0d093137/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v5.9-rc7-75-g027a0d093137
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      027a0d093137cac9655d241a1ace1b36ed1f455d =



Test Regressions
---------------- =



platform | arch | lab           | compiler | defconfig          | results
---------+------+---------------+----------+--------------------+--------
panda    | arm  | lab-collabora | gcc-8    | multi_v7_defconfig | 4/5    =


  Details:     https://kernelci.org/test/plan/id/5f74cb429ea0b93b6087718c

  Results:     4 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.9-rc7-75-g027a0d=
093137/arm/multi_v7_defconfig/gcc-8/lab-collabora/baseline-panda.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.9-rc7-75-g027a0d=
093137/arm/multi_v7_defconfig/gcc-8/lab-collabora/baseline-panda.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-2-g61393d279614/armel/baseline/rootfs.cpio.gz =


  * baseline.dmesg.alert: https://kernelci.org/test/case/id/5f74cb429ea0b93=
b60877192
      failing since 41 days (last pass: v5.8-107-gb72b3ea38c81, first fail:=
 v5.9-rc1-4-g1f08d51cd57f)
      60 lines

    2020-09-30 18:15:24.244000  kern  :alert : BUG: Bad page state in proce=
ss swapper/0  pfn:9c802
    2020-09-30 18:15:24.248000  kern  :alert : BUG: Bad page state in proce=
ss swapper/0  pfn:9c803
    2020-09-30 18:15:24.254000  kern  :alert : BUG: Bad page state in proce=
ss swapper/0  pfn:9c804
    2020-09-30 18:15:24.260000  kern  :alert : BUG: Bad page state in proce=
ss swapper/0  pfn:9c805
    2020-09-30 18:15:24.266000  kern  :alert : BUG: Bad page state in proce=
ss swapper/0  pfn:9c806
    2020-09-30 18:15:24.272000  kern  :alert : BUG: Bad page state in proce=
ss swapper/0  pfn:9c807
    2020-09-30 18:15:24.278000  kern  :alert : BUG: Bad page state in proce=
ss swapper/0  pfn:9c808
    2020-09-30 18:15:24.283000  kern  :alert : BUG: Bad page state in proce=
ss swapper/0  pfn:9c809
    2020-09-30 18:15:24.290000  kern  :alert : BUG: Bad page state in proce=
ss swapper/0  pfn:9c80a
    2020-09-30 18:15:24.296000  kern  :alert : BUG: Bad page state in proce=
ss swapper/0  pfn:9c80b
    ... (49 line(s) more)
      =20
