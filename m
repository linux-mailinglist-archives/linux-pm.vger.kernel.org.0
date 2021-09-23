Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27BF04166F3
	for <lists+linux-pm@lfdr.de>; Thu, 23 Sep 2021 22:54:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235840AbhIWU41 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 23 Sep 2021 16:56:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbhIWU40 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 23 Sep 2021 16:56:26 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D5CDC061574
        for <linux-pm@vger.kernel.org>; Thu, 23 Sep 2021 13:54:54 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id me1so5265608pjb.4
        for <linux-pm@vger.kernel.org>; Thu, 23 Sep 2021 13:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=2sl6cDl70lCiOkWaoPq6Jy9FcastJB9SyeT8odrB+pk=;
        b=0i4UK/HJQqCqSeULofhgK3SgBwvnz4SS5rhoAwd9QnGDgt8QU9kFe+6kumw8T7cAsF
         a0mkV4q8Dd0BZlF2do0NRJOpuWejc+AoirbQQNjjVLROL73GWeAa4CSHXZBdBfMzJyHh
         L1td5DknMnWHfFHqU4R6U4UWLf6ZsIyN8cfBtLXIpnkVrwMbI3XSC1/+SoGJ89fGkhf9
         97w7ymMcHH3lwQ9eZGvTFLddeCkEnbB2K03ItWFrlTOisKx7CcG+MjJfRpN+KMRdnj3i
         zJZi+k4v37Xt0flJYmmmj+tEI6kxlAoNQGiT2B5omGkznf4Ra5QQ6+mRNL8sH6HE2WeJ
         4pwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=2sl6cDl70lCiOkWaoPq6Jy9FcastJB9SyeT8odrB+pk=;
        b=74mthxeYsDnMu3C8Q/1FmP0udebWdiOMJjsusLlT1kIfpkDNfZs6x09WXvotub6zWP
         uNavQnddfvYltm4hJHWtQ92NL4ix/P8oQLZeFWySY4qC8Xyys0FFmVJ6384k2ha/7j7y
         zhjeHC1ES6zUhGEajC1fwZO+7rsvsm7cerY+xYrtvodAHXvpHuWJiNHsqG0eQ+tl1GrE
         zwpVLm3CXIZQ7zIyy8jZ8eZN6ODYplqet7CPMtf0bkMSw1Y0fQcJjcU7gI+WPWaRwwj0
         cfDkVll94JxLKFw8nhfooSXBceFRLtaJXwy26KkC9IUn8HRsjX1ryufJxHLnp6P7g6mH
         p46A==
X-Gm-Message-State: AOAM530k2cu7zHaYBmA3BI9yuZudagw2FG2aB3VKXNgFWVyu/PZm3qGW
        FHo/VzMWA3T+uFuJrRuB4pop74SS1pxA9fE6
X-Google-Smtp-Source: ABdhPJxvwo9r0anENPnP8JEfRQSHj6y1vRbrg/B+sY+YGg4GAhP6zst+857tmJfApoWp/zffPVUDEA==
X-Received: by 2002:a17:90a:ee82:: with SMTP id i2mr7542107pjz.166.1632430493917;
        Thu, 23 Sep 2021 13:54:53 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id o15sm6933676pfg.14.2021.09.23.13.54.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 13:54:53 -0700 (PDT)
Message-ID: <614ce99d.1c69fb81.ffb4e.4272@mx.google.com>
Date:   Thu, 23 Sep 2021 13:54:53 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.15-rc2-12-g9fa78c37a2e3
X-Kernelci-Report-Type: test
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
Subject: pm/testing baseline: 62 runs,
 4 regressions (v5.15-rc2-12-g9fa78c37a2e3)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 62 runs, 4 regressions (v5.15-rc2-12-g9fa78c37a2e3)

Regressions Summary
-------------------

platform         | arch  | lab           | compiler | defconfig          | =
regressions
-----------------+-------+---------------+----------+--------------------+-=
-----------
beagle-xm        | arm   | lab-baylibre  | gcc-8    | multi_v7_defconfig | =
1          =

hip07-d05        | arm64 | lab-collabora | gcc-8    | defconfig          | =
1          =

rk3399-gru-kevin | arm64 | lab-collabora | gcc-8    | defconfig          | =
2          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.15-rc=
2-12-g9fa78c37a2e3/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v5.15-rc2-12-g9fa78c37a2e3
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      9fa78c37a2e340ea8d57b78ae9379a4110a70515 =



Test Regressions
---------------- =



platform         | arch  | lab           | compiler | defconfig          | =
regressions
-----------------+-------+---------------+----------+--------------------+-=
-----------
beagle-xm        | arm   | lab-baylibre  | gcc-8    | multi_v7_defconfig | =
1          =


  Details:     https://kernelci.org/test/plan/id/614ce170c5b0e430f099a324

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.15-rc2-12-g9fa78=
c37a2e3/arm/multi_v7_defconfig/gcc-8/lab-baylibre/baseline-beagle-xm.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.15-rc2-12-g9fa78=
c37a2e3/arm/multi_v7_defconfig/gcc-8/lab-baylibre/baseline-beagle-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-6-g8983f3b738df/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/614ce170c5b0e430f099a=
325
        failing since 48 days (last pass: v5.14-rc3-20-g604483c9d252, first=
 fail: v5.14-rc4-28-g9ac32de19606) =

 =



platform         | arch  | lab           | compiler | defconfig          | =
regressions
-----------------+-------+---------------+----------+--------------------+-=
-----------
hip07-d05        | arm64 | lab-collabora | gcc-8    | defconfig          | =
1          =


  Details:     https://kernelci.org/test/plan/id/614cde3a4bdfefa40999a34f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.15-rc2-12-g9fa78=
c37a2e3/arm64/defconfig/gcc-8/lab-collabora/baseline-hip07-d05.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.15-rc2-12-g9fa78=
c37a2e3/arm64/defconfig/gcc-8/lab-collabora/baseline-hip07-d05.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-6-g8983f3b738df/arm64/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/614cde3a4bdfefa40999a=
350
        failing since 85 days (last pass: pm-5.13-rc8-159-g3304616e985f, fi=
rst fail: devprop-5.13-rc8-173-ge132b9a1079c) =

 =



platform         | arch  | lab           | compiler | defconfig          | =
regressions
-----------------+-------+---------------+----------+--------------------+-=
-----------
rk3399-gru-kevin | arm64 | lab-collabora | gcc-8    | defconfig          | =
2          =


  Details:     https://kernelci.org/test/plan/id/614cdf12f707facd1499a2ec

  Results:     89 PASS, 2 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.15-rc2-12-g9fa78=
c37a2e3/arm64/defconfig/gcc-8/lab-collabora/baseline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.15-rc2-12-g9fa78=
c37a2e3/arm64/defconfig/gcc-8/lab-collabora/baseline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-6-g8983f3b738df/arm64/baseline/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/614cdf12f707facd1499a2f2
        failing since 72 days (last pass: devprop-5.13-rc8-173-ge132b9a1079=
c, first fail: v5.14-rc1)

    2021-09-23T20:09:31.565714  /lava-4574279/1/../bin/lava-test-case
    2021-09-23T20:09:31.577322  <8>[   52.528634] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy1-probed RESULT=3Dfail>   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/614cdf12f707facd1499a2f3
        failing since 72 days (last pass: devprop-5.13-rc8-173-ge132b9a1079=
c, first fail: v5.14-rc1)

    2021-09-23T20:09:30.531486  /lava-4574279/1/../bin/lava-test-case
    2021-09-23T20:09:30.542900  <8>[   51.493501] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>   =

 =20
