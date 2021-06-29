Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CFFF3B77A0
	for <lists+linux-pm@lfdr.de>; Tue, 29 Jun 2021 20:08:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234964AbhF2SK2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 29 Jun 2021 14:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234874AbhF2SK1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 29 Jun 2021 14:10:27 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D415C061760
        for <linux-pm@vger.kernel.org>; Tue, 29 Jun 2021 11:07:59 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id z4so2043725plg.8
        for <linux-pm@vger.kernel.org>; Tue, 29 Jun 2021 11:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=mZI1K1Kn7RFQkCDFGzXld/PHWmdsy5FZO5cFkWsgc4w=;
        b=Y0oX1KaK9XZKtf5hKM1yjhmaLNUiYDfIII7Rp6Drrl/jYiVdzZv/HOFaVdQLtjspoR
         tNdsrCyYpSqoeXVtEsuI3u6lTNjXX4WE/aRvjnXprdrfEE/05xpYf4cU5NOuCdJnlIpW
         vndLOCjan7Szg2Un/2vmXtJ1EPOzHTRD3w9OEGPDvOKvm82PL2+ePmAy7sm3sxe141Lx
         9wCtQzlgxqP+sakgG81+KaqyxTVCd3hKfRKXzVpq+ojI4Mqombh4Fx8zhoUXK+Ls166p
         fKW1sHPi3pnEz5eJ5haJNJDpN0RmhRu+RqLIu9T1oJBsH11VZriar0q0pDCvRZiPGKAd
         Egog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=mZI1K1Kn7RFQkCDFGzXld/PHWmdsy5FZO5cFkWsgc4w=;
        b=POAM++yPecsjcTmGl7wv5tN/UFtfotEt3CP50ldiEC+REHmlsFOlvoMs5Jt7pXIslE
         gL7Om0sVI8aCQWhQOWd/GUBzJ9kU+Db5o6LM+fVjvZpjPU6/gr+/XXUD7auAvNELJTsF
         1nfSHov6drhH0d54IutTJo6VuMr2Yv/h0/bQl9sq80mXMNazlduCP/yKwYChiW24FjgP
         eVIBnmbRyyxTLeIzuUQIhrgEKOOkYYvPZh1N9tyf6xz65DgRiNk1djBL+DP6y+A0YycX
         MNjg5OB8AZS+rROYAbQjEKMq+aWZHjQ/hismkX8BJOryQFFW+serwNLBtq67juDC73gw
         yCug==
X-Gm-Message-State: AOAM533J3HZUtpfrvgwDsHeiOwCyIdXWATasF0G1+WHA+R8JKrXakvyg
        HQK+9aIihxnJBy1UGFJwNKgF3Q==
X-Google-Smtp-Source: ABdhPJyioEb6CQ97tcA2D+R0XSc6oDBdOhFQy4eIIZ1poGvsYuGg776tUlqy2emwrdekSkcH1hA8dw==
X-Received: by 2002:a17:90b:19d4:: with SMTP id nm20mr128439pjb.134.1624990078769;
        Tue, 29 Jun 2021 11:07:58 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id u20sm18737326pfn.189.2021.06.29.11.07.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jun 2021 11:07:58 -0700 (PDT)
Message-ID: <60db617e.1c69fb81.74ced.76e1@mx.google.com>
Date:   Tue, 29 Jun 2021 11:07:58 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: devprop-5.13-rc8-173-ge132b9a1079c
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
Subject: pm/testing sleep: 3 runs,
 1 regressions (devprop-5.13-rc8-173-ge132b9a1079c)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing sleep: 3 runs, 1 regressions (devprop-5.13-rc8-173-ge132b9a1079c)

Regressions Summary
-------------------

platform        | arch  | lab           | compiler | defconfig | regressions
----------------+-------+---------------+----------+-----------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-8    | defconfig | 1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/devprop-=
5.13-rc8-173-ge132b9a1079c/plan/sleep/

  Test:     sleep
  Tree:     pm
  Branch:   testing
  Describe: devprop-5.13-rc8-173-ge132b9a1079c
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      e132b9a1079c9a25ae896d443b0eca1b272b5f5b =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig | regressions
----------------+-------+---------------+----------+-----------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-8    | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/60db54cc45dc3c113623bbee

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/devprop-5.13-rc8-17=
3-ge132b9a1079c/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.t=
xt
  HTML log:    https://storage.kernelci.org//pm/testing/devprop-5.13-rc8-17=
3-ge132b9a1079c/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2021=
0520.0/arm64/rootfs.cpio.gz =



  * sleep.login: https://kernelci.org/test/case/id/60db54cc45dc3c113623bbef
        failing since 313 days (last pass: v5.8-107-gb72b3ea38c81, first fa=
il: v5.9-rc1-4-g1f08d51cd57f) =

 =20
