Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CA7333D884
	for <lists+linux-pm@lfdr.de>; Tue, 16 Mar 2021 17:03:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238341AbhCPQCa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 16 Mar 2021 12:02:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238285AbhCPQBe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 16 Mar 2021 12:01:34 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70BC0C061786
        for <linux-pm@vger.kernel.org>; Tue, 16 Mar 2021 09:00:46 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id lr10-20020a17090b4b8ab02900dd61b95c5eso1583630pjb.4
        for <linux-pm@vger.kernel.org>; Tue, 16 Mar 2021 09:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=Viguq9jrOmtQ50Lb4vbbHXGkQ7HnBO9QTNqnSKFu288=;
        b=hoWPILHallZp8ku7SkzrX/woilFzYK6c1jq8bto2liaan8dF7oHIP0KEI7AtBSAyoB
         7Kcv7+deWm87e6bQIPn845Qwik6Y5zDeue8IgJyMNDxx4uJwAlczONBQ5wBVLsnPYCg3
         0ZXaocM0ofk0u+lqhEVOpnRvPFugG5V5SniTGVv1kzZvi8hCNUwb+hjHm5sofU0YplQy
         i932MZs5XJib4Bx8Zu9SvYSKEYZbhF5iAqwCTNA+ER+K4ehQ1t/ZuTxnlEHIpizKwMDd
         bvN7DEVQn7dnj/x79QOXEmMkdHxXgUlLmTyEwlggslEAyndNKBiYPqHz8WXyo63pESKo
         7fTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=Viguq9jrOmtQ50Lb4vbbHXGkQ7HnBO9QTNqnSKFu288=;
        b=qHP4w5xCVkbRcJ7Yl2YqeH/chTphjX2rZMBkFxKBslqs7NJvpx9QaD+dMfAKsinxcj
         FrABlcdO9LqU6VKa0EkGOxQvQ5DsBEvwP7jdLVstCmnaWAoS1ppaH+na1rSIeRgxkyuZ
         HV90VbbL6LppX4xBtHzMZYaF8Bp0DgPEBZn8Du01u7D0u4uof7d2B0kjoXjtf54FkkKA
         I9gKOF3NAYp/IJpShYq085yL7EXnYHGdqhKhMGCC/l+gkuZj+gT1cQqQhWQQD6XATS+l
         apKvqbr93jqu4D+70DrpYeeHZIfBUbWxsqSUphWszWqH9octD036mIqOifVhwtwiXP24
         eD/A==
X-Gm-Message-State: AOAM530shLctsYTe+7rQmorbx8qFLJZApVMGh/P03HxenQlrIXgtKhxy
        5euS5DT7SBdBIH+bglzP9OJOfgTpH5uKbA==
X-Google-Smtp-Source: ABdhPJw037dFkXFgEq5oYeOZl9mQ1Xy6+9DOraNIvaq6v9RfVBS4J9jgZ1tM3GSyaXYURBPleBmaaA==
X-Received: by 2002:a17:902:7246:b029:e6:78c4:48d8 with SMTP id c6-20020a1709027246b02900e678c448d8mr262397pll.18.1615910446046;
        Tue, 16 Mar 2021 09:00:46 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id 11sm7681265pfn.146.2021.03.16.09.00.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 09:00:45 -0700 (PDT)
Message-ID: <6050d62d.1c69fb81.89b86.1443@mx.google.com>
Date:   Tue, 16 Mar 2021 09:00:45 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.12-rc3-19-g1a7a93e88ae21
X-Kernelci-Report-Type: test
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
Subject: pm/testing sleep: 6 runs, 1 regressions (v5.12-rc3-19-g1a7a93e88ae21)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing sleep: 6 runs, 1 regressions (v5.12-rc3-19-g1a7a93e88ae21)

Regressions Summary
-------------------

platform        | arch  | lab           | compiler | defconfig | regressions
----------------+-------+---------------+----------+-----------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-8    | defconfig | 1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.12-rc=
3-19-g1a7a93e88ae21/plan/sleep/

  Test:     sleep
  Tree:     pm
  Branch:   testing
  Describe: v5.12-rc3-19-g1a7a93e88ae21
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      1a7a93e88ae21b39d09117d5a0dde26db783ff92 =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig | regressions
----------------+-------+---------------+----------+-----------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-8    | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/6050c98b4bf1954e55addd10

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.12-rc3-19-g1a7a9=
3e88ae21/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.12-rc3-19-g1a7a9=
3e88ae21/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2021=
0315.0/arm64/rootfs.cpio.gz =



  * sleep.login: https://kernelci.org/test/case/id/6050c98b4bf1954e55addd11
        failing since 208 days (last pass: v5.8-107-gb72b3ea38c81, first fa=
il: v5.9-rc1-4-g1f08d51cd57f) =

 =20
