Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD04529F732
	for <lists+linux-pm@lfdr.de>; Thu, 29 Oct 2020 22:53:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725747AbgJ2Vxu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 29 Oct 2020 17:53:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbgJ2Vxt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 29 Oct 2020 17:53:49 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C88FC0613CF
        for <linux-pm@vger.kernel.org>; Thu, 29 Oct 2020 14:53:48 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id x23so1959177plr.6
        for <linux-pm@vger.kernel.org>; Thu, 29 Oct 2020 14:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=Eu418Sk3GF2+EEHmdSqcqxo0CrhCdsoqi3Jj66IAvjE=;
        b=NcxwHTtLQiBYbhwLrzI2E2zpCEFanRcTyeAJxOU8hCccjxOK9rkdwvxxmCLQ4zvknA
         mQVNkkg6baUyGWzfBt6o7UIfeSmZpklbIi0/nG9nifhIh+OGO3by5OKDNgUPsTrrgvte
         3rSotrC7oe/uI917z85pnEw/4RIm60xChdkaFwv0jP2n6LPnnx1Gxy18ehiIXrSYOXFh
         n/s++fchWAUviclR+AmekCVU9UftBzFh9X3NENSs65ax+bZvslmTDIPhi2iQh4+woq6J
         5V7kSqj8zi72z6NANABO1MMTT1v5i0keql0qH3Zez0TzvYkz5IoFrE9svBZ9ZoXHajfG
         cczA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=Eu418Sk3GF2+EEHmdSqcqxo0CrhCdsoqi3Jj66IAvjE=;
        b=J/7WWeSvA27h4IvrHZ3Q0bYAm4GejA2wA04uIx/uS4B1nqKnTIMGmx99nU0JI41AD1
         TXrcnJJhCEVhKEf/NR1Ootv+961zS21W3MC9hozl6g4b1NWTT0BxOnJ4Lz2gAQPtjMlR
         YhBe2T9ZB7y4t7gzVwFyxMb5v9QPS4pTh96AF50DwubqCZFhs65zpmABIt5yEgD1W3sJ
         hX8l2pKt15UHvvujM76Qx11/5CTw6KXgZNuacRCwTdEgZTIxOLXe/1FLUO8gV9LBgjH8
         GMh2idNGJ4DNUfaFVcpQDi7uLgKSzVF//roL1g/1D9OdDZUKQ3PF0HT0xH7/DRxcJJv6
         8kAw==
X-Gm-Message-State: AOAM532Qqnaar9ezNH913GAC7WDdVlvBLNIMY2Fe0Sp3LyYCZUXJzjKO
        ZQfs09xe/ONCL4L842ZFROqokBZuqEsoRQ==
X-Google-Smtp-Source: ABdhPJz1G7NY5+ETwG7sm2KXLIJC/doafw4pXTWqJFoi2RSSg45owqzMRcO5V0fVuIMnb11SaMIkRw==
X-Received: by 2002:a17:902:bc82:b029:d6:4ee5:87d0 with SMTP id bb2-20020a170902bc82b02900d64ee587d0mr5852337plb.40.1604008428014;
        Thu, 29 Oct 2020 14:53:48 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id i14sm3769682pfd.38.2020.10.29.14.53.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 14:53:47 -0700 (PDT)
Message-ID: <5f9b39eb.1c69fb81.944de.9143@mx.google.com>
Date:   Thu, 29 Oct 2020 14:53:47 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.10-rc1-24-g5e00eb5f6209
X-Kernelci-Report-Type: test
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
Subject: pm/testing baseline: 120 runs,
 1 regressions (v5.10-rc1-24-g5e00eb5f6209)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 120 runs, 1 regressions (v5.10-rc1-24-g5e00eb5f6209)

Regressions Summary
-------------------

platform | arch | lab           | compiler | defconfig          | regressio=
ns
---------+------+---------------+----------+--------------------+----------=
--
panda    | arm  | lab-collabora | gcc-8    | multi_v7_defconfig | 1        =
  =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.10-rc=
1-24-g5e00eb5f6209/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v5.10-rc1-24-g5e00eb5f6209
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      5e00eb5f62091ac1f78776b876efe2a09a9263a2 =



Test Regressions
---------------- =



platform | arch | lab           | compiler | defconfig          | regressio=
ns
---------+------+---------------+----------+--------------------+----------=
--
panda    | arm  | lab-collabora | gcc-8    | multi_v7_defconfig | 1        =
  =


  Details:     https://kernelci.org/test/plan/id/5f9b2fc3978596f65a381044

  Results:     4 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.10-rc1-24-g5e00e=
b5f6209/arm/multi_v7_defconfig/gcc-8/lab-collabora/baseline-panda.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.10-rc1-24-g5e00e=
b5f6209/arm/multi_v7_defconfig/gcc-8/lab-collabora/baseline-panda.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-4-g97706c5d9567/armel/baseline/rootfs.cpio.gz =



  * baseline.dmesg.alert: https://kernelci.org/test/case/id/5f9b2fc3978596f=
65a38104a
        failing since 71 days (last pass: v5.8-107-gb72b3ea38c81, first fai=
l: v5.9-rc1-4-g1f08d51cd57f)
        60 lines

    2020-10-29 21:10:19.657000+00:00  kern  :alert : BUG: Bad page state in=
 process swapper/0  pfn:9c802
    2020-10-29 21:10:19.663000+00:00  kern  :alert : BUG: Bad page state in=
 process swapper/0  pfn:9c803
    2020-10-29 21:10:19.669000+00:00  kern  :alert : BUG: Bad page state in=
 process swapper/0  pfn:9c804
    2020-10-29 21:10:19.675000+00:00  kern  :alert : BUG: Bad page state in=
 process swapper/0  pfn:9c805
    2020-10-29 21:10:19.681000+00:00  kern  :alert : BUG: Bad page state in=
 process swapper/0  pfn:9c806
    2020-10-29 21:10:19.687000+00:00  kern  :alert : BUG: Bad page state in=
 process swapper/0  pfn:9c807
    2020-10-29 21:10:19.693000+00:00  kern  :alert : BUG: Bad page state in=
 process swapper/0  pfn:9c808
    2020-10-29 21:10:19.698000+00:00  kern  :alert : BUG: Bad page state in=
 process swapper/0  pfn:9c809
    2020-10-29 21:10:19.705000+00:00  kern  :alert : BUG: Bad page state in=
 process swapper/0  pfn:9c80a
    2020-10-29 21:10:19.711000+00:00  kern  :alert : BUG: Bad page state in=
 process swapper/0  pfn:9c80b =

    ... (49 line(s) more)  =

 =20
