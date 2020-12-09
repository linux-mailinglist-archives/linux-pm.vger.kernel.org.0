Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44C372D4C6F
	for <lists+linux-pm@lfdr.de>; Wed,  9 Dec 2020 22:05:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbgLIVEw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 9 Dec 2020 16:04:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727013AbgLIVEq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 9 Dec 2020 16:04:46 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89A42C0613CF
        for <linux-pm@vger.kernel.org>; Wed,  9 Dec 2020 13:04:06 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id t18so1628006plo.0
        for <linux-pm@vger.kernel.org>; Wed, 09 Dec 2020 13:04:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=HAF+MtGPGSckJw1f8j1/jJwu/W6o8SZyYg3S9iUWJF8=;
        b=OJYbElOL6CE5DrXE82ff7+AqiQejJ9yy/HYpvM1KFH2UWKi3V2wRWO47U5Wnxlrvbu
         exfwlV6t4EhrdqGlMLnb4YrlMcOP4hyos5LYaGwKDQj7s1mAEYJ1sFi27cbJtPh9g82k
         FwpcpTT3ms+hjNhmi+aRnY6sAWR082nE2oo1k1KuAVCH9pynxk6jI6Zp8q0LrHpy7FLZ
         hk6NgzsmFvlkhFfZQwQfYNXdQ7QDASnifOXPyTVE2EkshAtNQPlSoi7qsvaoKAYscwWx
         XxYNEkewhX+UkJl/X0caN1NRztb75H9yOhgRCOd6R4VjzoOnVuFZSVXCrXxZonPUPGG8
         3i0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=HAF+MtGPGSckJw1f8j1/jJwu/W6o8SZyYg3S9iUWJF8=;
        b=qRy4oxwS3USV2b/7I9BIVOimLShJy1v7AwFL55OPnoJn29Nrrin5MdlisafKrM0rNt
         SCsuHI0uCdhUbD3zPmVK0rjcx79LfoOyck68eHpS60TCVr5/ptXpjtc+DhgTSkh+5oaL
         /O5kaXSgUwfivYvtdD0xirLAB/KcPZA8qpnZPsFUD6JFPocN5a3uC/3GK+6WUc+y1kGV
         T56Q+IbPOeyszxFB608xlzG4s+i+HKh/wCpQ9Yb6J9pEwAycvgUehWOgZ3r9BOQBW0B/
         aAu4frGmpA19T/RkHRyJR4CAHE5gHOXjqEL7cwbTBqNsJBDzthyzkZUbtS/EoxBsLITb
         mqcw==
X-Gm-Message-State: AOAM532X8S/5F+Ge7WJN0VPDyLaqccy/47+Gu0pDuHVMBjcxOw/wlFyO
        5Cyf9HRcL0e8VjJLbAAX7YSNLA==
X-Google-Smtp-Source: ABdhPJxj0IaXdChMsTVOKCYpKVYmJPm21/4iCY0oTwsGJmU2vN+cTRra97KYou4daSkkkrFc0hTebw==
X-Received: by 2002:a17:902:e98c:b029:da:cb88:f11d with SMTP id f12-20020a170902e98cb02900dacb88f11dmr3604844plb.17.1607547846114;
        Wed, 09 Dec 2020 13:04:06 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id 6sm3542610pfj.216.2020.12.09.13.04.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 13:04:05 -0800 (PST)
Message-ID: <5fd13bc5.1c69fb81.10b86.6c15@mx.google.com>
Date:   Wed, 09 Dec 2020 13:04:05 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v5.10-rc7-96-ga834ecc967a3
X-Kernelci-Report-Type: test
Subject: pm/testing baseline: 90 runs,
 1 regressions (v5.10-rc7-96-ga834ecc967a3)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 90 runs, 1 regressions (v5.10-rc7-96-ga834ecc967a3)

Regressions Summary
-------------------

platform   | arch  | lab     | compiler | defconfig | regressions
-----------+-------+---------+----------+-----------+------------
imx8mp-evk | arm64 | lab-nxp | gcc-8    | defconfig | 1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.10-rc=
7-96-ga834ecc967a3/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v5.10-rc7-96-ga834ecc967a3
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      a834ecc967a356eabe764b7439b3877e93822dca =



Test Regressions
---------------- =



platform   | arch  | lab     | compiler | defconfig | regressions
-----------+-------+---------+----------+-----------+------------
imx8mp-evk | arm64 | lab-nxp | gcc-8    | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/5fd1332cc2df117e8fc94cb9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.10-rc7-96-ga834e=
cc967a3/arm64/defconfig/gcc-8/lab-nxp/baseline-imx8mp-evk.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.10-rc7-96-ga834e=
cc967a3/arm64/defconfig/gcc-8/lab-nxp/baseline-imx8mp-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-4-g97706c5d9567/arm64/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/5fd1332cc2df117e8fc94=
cba
        new failure (last pass: v5.10-rc7-92-g717f8fce803b) =

 =20
