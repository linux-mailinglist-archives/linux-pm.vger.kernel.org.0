Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6E3F38F46F
	for <lists+linux-pm@lfdr.de>; Mon, 24 May 2021 22:33:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233049AbhEXUfR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 24 May 2021 16:35:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232929AbhEXUfQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 24 May 2021 16:35:16 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6955CC061574
        for <linux-pm@vger.kernel.org>; Mon, 24 May 2021 13:33:47 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id x188so21799050pfd.7
        for <linux-pm@vger.kernel.org>; Mon, 24 May 2021 13:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=bPgiLPk+SEeT+YQGI7BSzIctuKtghuS+/jEiGhkWMAk=;
        b=QbBpKzSgfmxmxlYLwgcjsOxc4qFIYHRrXCEtDccRqhhdw/VIQwraRx2MUbPjvy1F9n
         cz6lcT//4Bzmhzn0nHuyIa9VNa1arCwinA40CiR8MQydOjrxvj+XKE/Kuafq4Nziiv5v
         VWOpEgvU06XB0Cs692YbovngEXGobL38/CU4rtvfz7yGCWbs5aE9gCxEDZAh0vwT0KWJ
         NlxuaTAQMpxJt4dSKA0ELWdKJvFVbZDdRNtxoC5jcXdW1a0wFO13FWm0UmETsVslnzaY
         mwnUArF95V2PmeUBB5dXyr6OlxcTdXDiuIQAfJXOebYmQqrMt7uvYmX8nQW4MieiRAvE
         h7Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=bPgiLPk+SEeT+YQGI7BSzIctuKtghuS+/jEiGhkWMAk=;
        b=kogutBxUpswoZxRzd6fOOKYdwqpnNfP/47Fuz7OiXLvjoXljBz++CDXaMzexjexJwM
         KgNibhDDcF+f/14IWjcnUBV4x7AY2lJjefcE+ogpC1WtfLbFgWRBv6hXXM2hhpzOTcvn
         d11HlLHg6P724DW83FzvTLsnxBNvx+YlEIVyfFPNzRZ+yEi3lKb+N2NWj9v7qhZ9Awsz
         OVjVtgZaHVEzYTUE8iLfGqLZR03lfWx2AOHW93LRwL0UM2eYSQODihUwS8s3K7GG65cw
         iKMOQCS983wcOTKAnriRpQ8YKLGZWOFUTQxGRgmLvJNYREcL+jPVysAcKo42BloMWNFL
         4Mng==
X-Gm-Message-State: AOAM532OJIsNyoXJAarlLBhSv5P9mRKabJ7nabyJ5mdZcmTzD/4+l0n5
        0IyEhXXd+Rpdc0FtN0SXpnKvrQ==
X-Google-Smtp-Source: ABdhPJxqpV10nzpczwWAMC5FY4wFzDqEeZ3IwTQovBKsb8J2P3MdoZwDVWkDPcKDEKuA0MDp6Quuug==
X-Received: by 2002:a65:41c8:: with SMTP id b8mr15052277pgq.196.1621888426883;
        Mon, 24 May 2021 13:33:46 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id t188sm11825155pfc.178.2021.05.24.13.33.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 May 2021 13:33:46 -0700 (PDT)
Message-ID: <60ac0daa.1c69fb81.3300c.7891@mx.google.com>
Date:   Mon, 24 May 2021 13:33:46 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v5.13-rc3-26-gc17108d7145e
X-Kernelci-Branch: testing
X-Kernelci-Report-Type: test
Subject: pm/testing sleep: 3 runs, 1 regressions (v5.13-rc3-26-gc17108d7145e)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing sleep: 3 runs, 1 regressions (v5.13-rc3-26-gc17108d7145e)

Regressions Summary
-------------------

platform        | arch  | lab           | compiler | defconfig | regressions
----------------+-------+---------------+----------+-----------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-8    | defconfig | 1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.13-rc=
3-26-gc17108d7145e/plan/sleep/

  Test:     sleep
  Tree:     pm
  Branch:   testing
  Describe: v5.13-rc3-26-gc17108d7145e
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      c17108d7145e8c8b80386c02453df5d4b03dbcb1 =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig | regressions
----------------+-------+---------------+----------+-----------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-8    | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/60ac011f24855c747db3afd0

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.13-rc3-26-gc1710=
8d7145e/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.13-rc3-26-gc1710=
8d7145e/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2021=
0503.0/arm64/rootfs.cpio.gz =



  * sleep.login: https://kernelci.org/test/case/id/60ac011f24855c747db3afd1
        failing since 278 days (last pass: v5.8-107-gb72b3ea38c81, first fa=
il: v5.9-rc1-4-g1f08d51cd57f) =

 =20
