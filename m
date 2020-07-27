Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF9A222F571
	for <lists+linux-pm@lfdr.de>; Mon, 27 Jul 2020 18:34:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729209AbgG0QeF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 27 Jul 2020 12:34:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729315AbgG0QeB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 27 Jul 2020 12:34:01 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C06B0C061794
        for <linux-pm@vger.kernel.org>; Mon, 27 Jul 2020 09:34:01 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id n5so9987041pgf.7
        for <linux-pm@vger.kernel.org>; Mon, 27 Jul 2020 09:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=ogoYk2IPRfUeL/NywOJ4u3GcFC/rM/qbbMUMfHHZskU=;
        b=tGiIlRP/geWYDXm0RCSFs+/hL4i3uP+JXzRhTG7y1QKJqbyZlP9c69gJtKj5OkyEI1
         D1FSYuairKsHwQLo5zrcSjVLbDHXmze509VHFnepyCksGBJk70obn0kFyxUm8OqrCOA4
         oDnH2NottGXyphdeF0Zrg5XJ3eYjcDI8DexhFVwN4tT1t0cW3a5Sf4yUwHpqlk0Y/7RS
         7L4NxNU+EC/W3tdO6HGXTwa/UsE8Ra5QPTNtEtCWkGBdp7qLFt0IOArf3HynTlfuhrtw
         DipIovtn9IhVx5HSLjLNM2treSpY7xYv/QSrA3twwr9pZXH7cPwJ9/2VRd2kTX8xJqpj
         6hHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=ogoYk2IPRfUeL/NywOJ4u3GcFC/rM/qbbMUMfHHZskU=;
        b=ms/L8Jtubl9KnIs+VqgvVPQvDKLq6HHp6vTrr8fnzwHK5Okej4K/Ye4M4Vwp/WTFnJ
         HoV5ivGJHRutjU4yf8IqcrYM91NCleB4R2ZzRVvR8mmDv7chp2/Dl+OSjAL6AXTB8GMy
         ed+Pc68ta8H7v4nSvrLOBcKu/XccOA9fq/uWAPZP/1BngkL/FUna1oUq3vLhIP+67anZ
         IdRiGg8/9F1Pxf67K5ThdRoxdxGkI6E0oDaIZKh280kQ8IsDffFCZDGfU1KRXDiz9U3J
         CfJPyL4ythHd2FVTBr6T/IyXlOLuwO6ENvdo7YGGdHtplPRV6nqHjuFsXgN4zKmjF30o
         7Q3Q==
X-Gm-Message-State: AOAM533FjZjG9kDNbc/83rrcdh7skE0Jv3mt9auLz9K5EJp0sRRFKD0v
        4QMKHPTTxyftXUXpHyShLk+DNQ==
X-Google-Smtp-Source: ABdhPJzCb92Hbr4N0z3uY1WA5PkyKV8Qly/ODpGeDDLk+fPKMIKOLdgfOr5Q4w6heVM0UuNdukCDCQ==
X-Received: by 2002:a65:5682:: with SMTP id v2mr20301912pgs.231.1595867641290;
        Mon, 27 Jul 2020 09:34:01 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id lb13sm131417pjb.9.2020.07.27.09.33.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 09:34:00 -0700 (PDT)
Message-ID: <5f1f01f8.1c69fb81.d6dfe.0e01@mx.google.com>
Date:   Mon, 27 Jul 2020 09:34:00 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.8-rc7-60-g7f7b2e358b1b
X-Kernelci-Report-Type: test
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
Subject: pm/testing baseline: 124 runs,
 1 regressions (v5.8-rc7-60-g7f7b2e358b1b)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 124 runs, 1 regressions (v5.8-rc7-60-g7f7b2e358b1b)

Regressions Summary
-------------------

platform    | arch   | lab          | compiler | defconfig        | results
------------+--------+--------------+----------+------------------+--------
qemu_x86_64 | x86_64 | lab-baylibre | gcc-8    | x86_64_defconfig | 0/1    =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.8-rc7=
-60-g7f7b2e358b1b/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v5.8-rc7-60-g7f7b2e358b1b
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      7f7b2e358b1baa106afe6dec6dacb539d520dc6b =



Test Regressions
---------------- =



platform    | arch   | lab          | compiler | defconfig        | results
------------+--------+--------------+----------+------------------+--------
qemu_x86_64 | x86_64 | lab-baylibre | gcc-8    | x86_64_defconfig | 0/1    =


  Details:     https://kernelci.org/test/plan/id/5f1ef548c1ea02807585bb25

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig
  Compiler:    gcc-8 (gcc (Debian 8.3.0-6) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.8-rc7-60-g7f7b2e=
358b1b/x86_64/x86_64_defconfig/gcc-8/lab-baylibre/baseline-qemu_x86_64.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.8-rc7-60-g7f7b2e=
358b1b/x86_64/x86_64_defconfig/gcc-8/lab-baylibre/baseline-qemu_x86_64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05/x86/baseline/rootfs.cpio.gz =


  * baseline.login: https://kernelci.org/test/case/id/5f1ef548c1ea02807585b=
b26
      failing since 10 days (last pass: v5.8-rc5-44-g71865a3b9f0a, first fa=
il: v5.8-rc5-62-ge1f8d84fc3fe) =20
