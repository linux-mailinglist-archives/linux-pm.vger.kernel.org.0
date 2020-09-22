Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECB0F273871
	for <lists+linux-pm@lfdr.de>; Tue, 22 Sep 2020 04:21:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729230AbgIVCVN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 21 Sep 2020 22:21:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728949AbgIVCVM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 21 Sep 2020 22:21:12 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3627C061755
        for <linux-pm@vger.kernel.org>; Mon, 21 Sep 2020 19:21:12 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id a9so752817pjg.1
        for <linux-pm@vger.kernel.org>; Mon, 21 Sep 2020 19:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=QjRARZnXe7Aecosn0GLFZ8JhWzT3T+Xlkbh+9mjPU0I=;
        b=G5cxX5BfmwJP8TSkQ77FRZ/FbcYBy+dB+Az87VGufwEowQT0HzkvG7O6TFcZHAxiNp
         I4aj0mj3hOb/ZWBgzR7n4ZbsUGAvXntjUDZM7GdGbO9O6YuDND7jCrwbPyq1FAIySfwB
         WpZRdFMhev3Q+mxRCH22eg0SvxxQ5OlLdCCu7kmvOWc9QXHqr6e/4xIy7POXIiDKNnn2
         2gHBrxyxgw6FXyUCJODnJjA+gPbE+xabmQTbSiuZgER8TUUM6zjytDAu61YYvEU0nDMt
         xzgoKWkWgex/63f/nCAEsBPfAlSv6+a3TVJSKZ7hPOvwwrB5MsFb8VplnfuRV++Imnrs
         N1Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=QjRARZnXe7Aecosn0GLFZ8JhWzT3T+Xlkbh+9mjPU0I=;
        b=GwOeNSBvG39p1QrWyunV6llSiXgx84Gd5dEPvojbhSuI2JL1X4vcoETfE5HGrUsBs6
         EOMiWxvsv+3OoB/ZbVowoq5VbVbk/ZT7ijdHzM9L0xyYFlZjH4RbjAaiSlsYORDUcD4d
         dyYK3gWgbhguuup7vp2aQaZ0F9cjSurlUel+yRh3aBFxD/Xc+kxbEsdCS02bD4lQKa65
         kRo6rTLuEXEOLTc9VoiJzLT8jKMA3H9VF3qVGPUc1Yp6zu5zFZmtHX5lZ3S+CGT9xQct
         y/LXlWfMjcNvM6bfRpY2CIf4iisX0vpo8IQjDQVQXYrijLwVpUbjgg360qH37+vWTlKy
         FoXg==
X-Gm-Message-State: AOAM5304opEGHV+qjL5Dkv5pTFSfe2y/xuDL1cfW4qMTMu6DOtlaKK0+
        yYrqtRbg49+yCEPiigw75HtTtKKo3LoyCQ==
X-Google-Smtp-Source: ABdhPJxFsYbpBDY9WfvQfFxoljg/7pbpOKXh5aoO4p0jQSCloTULZLPGLrdrTRAK4lnO9NC5KiQSCw==
X-Received: by 2002:a17:90a:62c4:: with SMTP id k4mr1859037pjs.174.1600741272111;
        Mon, 21 Sep 2020 19:21:12 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id d5sm14347658pfq.72.2020.09.21.19.21.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2020 19:21:11 -0700 (PDT)
Message-ID: <5f695f97.1c69fb81.a9d0d.34dd@mx.google.com>
Date:   Mon, 21 Sep 2020 19:21:11 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
X-Kernelci-Kernel: v5.9-rc6-23-g24a16b940f0b
Subject: pm/testing baseline: 102 runs,
 2 regressions (v5.9-rc6-23-g24a16b940f0b)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 102 runs, 2 regressions (v5.9-rc6-23-g24a16b940f0b)

Regressions Summary
-------------------

platform         | arch  | lab           | compiler | defconfig          | =
results
-----------------+-------+---------------+----------+--------------------+-=
-------
panda            | arm   | lab-collabora | gcc-8    | multi_v7_defconfig | =
4/5    =

rk3399-gru-kevin | arm64 | lab-collabora | gcc-8    | defconfig          | =
0/1    =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.9-rc6=
-23-g24a16b940f0b/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v5.9-rc6-23-g24a16b940f0b
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      24a16b940f0be5f822951a86ba0db8664f6d0677 =



Test Regressions
---------------- =



platform         | arch  | lab           | compiler | defconfig          | =
results
-----------------+-------+---------------+----------+--------------------+-=
-------
panda            | arm   | lab-collabora | gcc-8    | multi_v7_defconfig | =
4/5    =


  Details:     https://kernelci.org/test/plan/id/5f69557e580734ce2cbf9dc3

  Results:     4 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.9-rc6-23-g24a16b=
940f0b/arm/multi_v7_defconfig/gcc-8/lab-collabora/baseline-panda.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.9-rc6-23-g24a16b=
940f0b/arm/multi_v7_defconfig/gcc-8/lab-collabora/baseline-panda.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05/armel/baseline/rootfs.cpio.gz =


  * baseline.dmesg.alert: https://kernelci.org/test/case/id/5f69557e580734c=
e2cbf9dc9
      failing since 33 days (last pass: v5.8-107-gb72b3ea38c81, first fail:=
 v5.9-rc1-4-g1f08d51cd57f)
      60 lines

    2020-09-22 01:38:00.525000  kern  :alert : BUG: Bad page state in proce=
ss swapper/0  pfn:9c802
    2020-09-22 01:38:00.531000  kern  :alert : BUG: Bad page state in proce=
ss swapper/0  pfn:9c803
    2020-09-22 01:38:00.536000  kern  :alert : BUG: Bad page state in proce=
ss swapper/0  pfn:9c804
    2020-09-22 01:38:00.543000  kern  :alert : BUG: Bad page state in proce=
ss swapper/0  pfn:9c805
    2020-09-22 01:38:00.548000  kern  :alert : BUG: Bad page state in proce=
ss swapper/0  pfn:9c806
    2020-09-22 01:38:00.554000  kern  :alert : BUG: Bad page state in proce=
ss swapper/0  pfn:9c807
    2020-09-22 01:38:00.560000  kern  :alert : BUG: Bad page state in proce=
ss swapper/0  pfn:9c808
    2020-09-22 01:38:00.567000  kern  :alert : BUG: Bad page state in proce=
ss swapper/0  pfn:9c809
    2020-09-22 01:38:00.573000  kern  :alert : BUG: Bad page state in proce=
ss swapper/0  pfn:9c80a
    2020-09-22 01:38:00.579000  kern  :alert : BUG: Bad page state in proce=
ss swapper/0  pfn:9c80b
    ... (49 line(s) more)
      =



platform         | arch  | lab           | compiler | defconfig          | =
results
-----------------+-------+---------------+----------+--------------------+-=
-------
rk3399-gru-kevin | arm64 | lab-collabora | gcc-8    | defconfig          | =
0/1    =


  Details:     https://kernelci.org/test/plan/id/5f695622f1e896ecb0bf9dda

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.9-rc6-23-g24a16b=
940f0b/arm64/defconfig/gcc-8/lab-collabora/baseline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.9-rc6-23-g24a16b=
940f0b/arm64/defconfig/gcc-8/lab-collabora/baseline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05/arm64/baseline/rootfs.cpio.gz =


  * baseline.login: https://kernelci.org/test/case/id/5f695622f1e896ecb0bf9=
ddb
      new failure (last pass: v5.9-rc5)  =20
