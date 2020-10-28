Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2562229D39D
	for <lists+linux-pm@lfdr.de>; Wed, 28 Oct 2020 22:45:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725775AbgJ1Vpb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 28 Oct 2020 17:45:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726094AbgJ1Vpb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 28 Oct 2020 17:45:31 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75108C0613CF
        for <linux-pm@vger.kernel.org>; Wed, 28 Oct 2020 14:45:31 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id t14so620049pgg.1
        for <linux-pm@vger.kernel.org>; Wed, 28 Oct 2020 14:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=pRYapwuGN3kuSQSgQ4oeMKqhU8RdZfK+7gD9GRUOh0Y=;
        b=Tliopu3b6UCiI3Y1+Ztw6lG4mXHWR4jeDl5in7Ck4+7JNRfZ7GP+xXtlisAWm2aI5T
         tlkOUL1le0eqFVeS0FjsK3L5n7ODNOhrckBaayjI9PuJfQbkPBeuD36MX4ZTl55ixUUU
         LeFwXhnYnjeuH20ShPmq7emnSMG+bIFnnSCXrX9QeW5JozyIKOODs9xA6ON7nouQYB1p
         vDi2Q3s+Sc6GOOaUuBxBDQuRmjFPpo/kc4yYnXYPyR7QYYe4fLk4zO3OMUZgX83pvT0k
         owR13xIkoEJRANFUV5iV45zr5WF206eE80r3qJs3bX5fzRvH82H4reeJWhVbQhLg6Gwd
         Kbdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=pRYapwuGN3kuSQSgQ4oeMKqhU8RdZfK+7gD9GRUOh0Y=;
        b=BjLYa5v3kwhg2oHZl3/QEQ/nCFUQqPGv/X537rgCvlRhFdDWVnbJ0GEq5EwGH9wzMN
         55Q0WL7i29gaA63svibLWXoiprw9mR00YYsXnAZqJIqItUGf0Giia5/iqguXGbnuTQ8e
         g4N2ko6sS5padEabIPweh4cB4ODSF/U17BUC2eA+ahnkKplXYefXYW0QQPHgd/Rnm+fy
         kdMkdODdmC60BqCuJ6ngruanE2VF6iYEZdX57qYup+E7G11tXoatpKkNpTKcynoC8tQh
         B/qxx7O4X2NpQWuF8q1svrguCEHWmPT3ktMZkB4ELCmiwsp+u397Tih2bUX0SRx3eoiJ
         E63Q==
X-Gm-Message-State: AOAM531cBQpC7iKCVQUpMZC7j32FU499U7/4d9NYfpC53DSjCsKcH9FZ
        QT4oDnI/97a0aciXclGjcBUXmNsPMGXaiw==
X-Google-Smtp-Source: ABdhPJxf58AY/cSIz1hBvCKazqgSetoeOhyuSpy4HIodcvVNbuAg950KKwEgb1WWzkX6Fx2RKPA1Bw==
X-Received: by 2002:a63:2d02:: with SMTP id t2mr757483pgt.306.1603912281919;
        Wed, 28 Oct 2020 12:11:21 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id 32sm140954pgz.11.2020.10.28.12.11.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2020 12:11:21 -0700 (PDT)
Message-ID: <5f99c259.1c69fb81.f238f.05b4@mx.google.com>
Date:   Wed, 28 Oct 2020 12:11:21 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.10-rc1-19-gd1cd1a35b7d5
X-Kernelci-Report-Type: test
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
Subject: pm/testing sleep: 5 runs, 1 regressions (v5.10-rc1-19-gd1cd1a35b7d5)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing sleep: 5 runs, 1 regressions (v5.10-rc1-19-gd1cd1a35b7d5)

Regressions Summary
-------------------

platform        | arch  | lab           | compiler | defconfig | regressions
----------------+-------+---------------+----------+-----------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-8    | defconfig | 1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.10-rc=
1-19-gd1cd1a35b7d5/plan/sleep/

  Test:     sleep
  Tree:     pm
  Branch:   testing
  Describe: v5.10-rc1-19-gd1cd1a35b7d5
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      d1cd1a35b7d5e318b69f75237ca91f6b0eebfa27 =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig | regressions
----------------+-------+---------------+----------+-----------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-8    | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/5f99b0f995661aa4d138101a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.10-rc1-19-gd1cd1=
a35b7d5/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.10-rc1-19-gd1cd1=
a35b7d5/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2020=
1022.0/arm64/rootfs.cpio.gz =



  * sleep.login: https://kernelci.org/test/case/id/5f99b0f995661aa4d138101b
        failing since 69 days (last pass: v5.8-107-gb72b3ea38c81, first fai=
l: v5.9-rc1-4-g1f08d51cd57f) =

 =20
