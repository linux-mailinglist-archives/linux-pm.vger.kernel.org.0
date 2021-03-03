Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D111732C2CB
	for <lists+linux-pm@lfdr.de>; Thu,  4 Mar 2021 01:06:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231282AbhCDAAP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 3 Mar 2021 19:00:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386827AbhCCSqt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 3 Mar 2021 13:46:49 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C16E7C061756
        for <linux-pm@vger.kernel.org>; Wed,  3 Mar 2021 10:46:09 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id a24so14523410plm.11
        for <linux-pm@vger.kernel.org>; Wed, 03 Mar 2021 10:46:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=3Ts1DlkKkIPjxARQzKQq3ZIsAsrWGQiHbxIH4vOCboo=;
        b=FRYzN+Wt2t0RzOJd3OGcBHNWSVWG9hHAC+EvG8C7b9+UfsO2F9x2xdOLTmIUbmISKs
         SwQaZGaNgqtjhqOdg/MIz37xHtmg/si6XOJ+AYg1GhAnkuT0N44P8Csd6G3jxzkmEdnj
         XzxYLcl4JEsBSSPLl2R14BjFmAMNMmvxyun6N9b2+rQyEm0RWPaC/6RPanjSUXYLVbWY
         fCye7fbZ2k1stJrFU08mLpL98CFW4BnZrLNf49tspyrv/KeUHHXwqmXi9RhIsHCLvT1h
         t4Jgnw+xPis/+rp7IHomrmnuylrgXPgSNDKTls/0cRnYHYE5Vd9Xs2dkZIwMH2gdDkVi
         wIXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=3Ts1DlkKkIPjxARQzKQq3ZIsAsrWGQiHbxIH4vOCboo=;
        b=A8YbZw3+AW6QJ6zG4GNoL9um+nLUzdFEP7EKkjCb4Yj+hkNK9kwDQ0d2DU91SXr2gg
         F+3xSzWYmAyY6tZPFgtORNBfZlf+weHM3ETY7lvbi2GkxeHSwujWjlYgnf8uvr2Nt6yW
         NaPD0k5Ls4qTYcVK+r/cQef/RBubtv5YhZCXQ2lkvC7q+1LkmAtMhCVGaSxm8txiy+Ov
         Ldzuft/xFUBBcUtUQ2E3Xyqtu7EE8xHNC2zWpHD9DGP+dCzA4Ycea64K4QdmkR2mOTxf
         66nFjAiqpnH0xkCGTM6AVIeLEXc+we/BkOCdJ0HKng7Jt3BnMfMdUE9zbx3MQBoYz39I
         /VOA==
X-Gm-Message-State: AOAM531WYKz6R8z+oH9DeOX4D/IYEYcHSemEXOLeLC4604CsRf7KZD7q
        V2hqR8DfD8Os5if+sII7B73yYQ==
X-Google-Smtp-Source: ABdhPJyfWwEnkuLSt1nKR8Od/IcMnjDhys6Wmaz+3a2KhI1zaHSqBIHNO0JZz/3banm7YifCWP31NQ==
X-Received: by 2002:a17:90a:2a41:: with SMTP id d1mr482511pjg.164.1614797169366;
        Wed, 03 Mar 2021 10:46:09 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id 192sm22871756pfx.193.2021.03.03.10.46.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 10:46:09 -0800 (PST)
Message-ID: <603fd971.1c69fb81.8709c.4c03@mx.google.com>
Date:   Wed, 03 Mar 2021 10:46:09 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.12-rc1-5-g51165d52eceb9
X-Kernelci-Report-Type: test
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
Subject: pm/testing sleep: 4 runs, 1 regressions (v5.12-rc1-5-g51165d52eceb9)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing sleep: 4 runs, 1 regressions (v5.12-rc1-5-g51165d52eceb9)

Regressions Summary
-------------------

platform        | arch  | lab           | compiler | defconfig | regressions
----------------+-------+---------------+----------+-----------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-8    | defconfig | 1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.12-rc=
1-5-g51165d52eceb9/plan/sleep/

  Test:     sleep
  Tree:     pm
  Branch:   testing
  Describe: v5.12-rc1-5-g51165d52eceb9
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      51165d52eceb9a6a227e39c9b369b4f437e4e620 =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig | regressions
----------------+-------+---------------+----------+-----------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-8    | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/603fcc60152083ee5caddccf

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.12-rc1-5-g51165d=
52eceb9/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.12-rc1-5-g51165d=
52eceb9/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2021=
0301.0/arm64/rootfs.cpio.gz =



  * sleep.login: https://kernelci.org/test/case/id/603fcc60152083ee5caddcd0
        failing since 195 days (last pass: v5.8-107-gb72b3ea38c81, first fa=
il: v5.9-rc1-4-g1f08d51cd57f) =

 =20
