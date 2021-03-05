Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4BF532F3C5
	for <lists+linux-pm@lfdr.de>; Fri,  5 Mar 2021 20:25:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbhCETZI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 5 Mar 2021 14:25:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbhCETYp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 5 Mar 2021 14:24:45 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42BB5C061574
        for <linux-pm@vger.kernel.org>; Fri,  5 Mar 2021 11:24:45 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id ba1so1928138plb.1
        for <linux-pm@vger.kernel.org>; Fri, 05 Mar 2021 11:24:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=DGZpICknQS6IyBsdZzXHI+7keNplh/AFd0sisBvQqs8=;
        b=uxLRhyfR3XA1QL69NhnozgbOCrQDhFjhcIgXb+8REvbpb9gL2XL6Nr2ZsHTp2zg116
         7BYpQgOqVLxUP7t81t8o2swRxPmsW5nTfdWZFqMWWdNyguLyAh1fRzYA2c3NIEa2AaO2
         NuI4exdEJAqdlx5Jl8r5Fmn5wiy1ZQ4diz+aRnuHgKXvFod4aO+Weet1ab6Hpb0jcNZT
         QDDjrRjmo5fmRXKSG3h3c10gdTvBJZQh55myJPDnLVcHN5N+QqNwkcyQzIZJPu1b2Sx9
         lVlX+ROqdrTDbyHi0L1hzJX0nzq/n0yNdKNJWDPijODS02IXIAY1qS9PiC1m7oeqRKgg
         mDbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=DGZpICknQS6IyBsdZzXHI+7keNplh/AFd0sisBvQqs8=;
        b=ekvVXgHRt+qMyVgpRopyYqTmVgeV+u4vww4KntOxF6H5ZmOxIVf5c/HnbdkhjQ7oHO
         BRMh7CR5VkDn9PJiZ78YVBcKqf/Un4BTsEhTQmrDDtJXK/6EoZ3Eg2U4RRCIzDduHJPl
         XY1b8lhZuyyUYQrwquEtkKThdyi9XznRW9qit4UgWP4wNiQbGyAn+uF4F3dPvhgUhWNe
         psK5/FDEwA70LOjGjwnIVs+I8dmMz8XQx/FAYz5LcJHNwLuRuXiOoej30Z2VtiuE2bWh
         iGx4/P54J7XqrZPfaRwtZhVWM9wuyB6IW/sxM3DfcDUtfGomLaw8vSMhhxWNSD86qko4
         tu7Q==
X-Gm-Message-State: AOAM532yVsVO1lY7uRo7cGNmOf/Oq2HDDmL0e2mh5bquztFWtY5L8/J6
        FWlcCpQQbJy1ExF+hfPAAxzTJA==
X-Google-Smtp-Source: ABdhPJzXWbmAFoJFO21D7UUYom9J2IV9Eq3Z1V6hYz39PyN65RgQpm6UHtXu5+cvIejaJiUlP+u6xw==
X-Received: by 2002:a17:902:7002:b029:e5:e1fc:7e88 with SMTP id y2-20020a1709027002b02900e5e1fc7e88mr7148092plk.30.1614972284826;
        Fri, 05 Mar 2021 11:24:44 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id j125sm3563025pfd.27.2021.03.05.11.24.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Mar 2021 11:24:44 -0800 (PST)
Message-ID: <6042857c.1c69fb81.d8d0.959d@mx.google.com>
Date:   Fri, 05 Mar 2021 11:24:44 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: acpi-5.12-rc2-19-g5c476073a9df
X-Kernelci-Report-Type: test
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
Subject: pm/testing sleep: 4 runs,
 1 regressions (acpi-5.12-rc2-19-g5c476073a9df)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing sleep: 4 runs, 1 regressions (acpi-5.12-rc2-19-g5c476073a9df)

Regressions Summary
-------------------

platform        | arch  | lab           | compiler | defconfig | regressions
----------------+-------+---------------+----------+-----------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-8    | defconfig | 1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/acpi-5.1=
2-rc2-19-g5c476073a9df/plan/sleep/

  Test:     sleep
  Tree:     pm
  Branch:   testing
  Describe: acpi-5.12-rc2-19-g5c476073a9df
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      5c476073a9df062a501edf9ea7b11ccc53c27bf7 =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig | regressions
----------------+-------+---------------+----------+-----------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-8    | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/6042792b07674cdceaaddcc7

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/acpi-5.12-rc2-19-g5=
c476073a9df/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//pm/testing/acpi-5.12-rc2-19-g5=
c476073a9df/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2021=
0301.0/arm64/rootfs.cpio.gz =



  * sleep.login: https://kernelci.org/test/case/id/6042792b07674cdceaaddcc8
        failing since 198 days (last pass: v5.8-107-gb72b3ea38c81, first fa=
il: v5.9-rc1-4-g1f08d51cd57f) =

 =20
