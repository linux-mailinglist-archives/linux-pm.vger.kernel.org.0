Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69C1D379959
	for <lists+linux-pm@lfdr.de>; Mon, 10 May 2021 23:40:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232983AbhEJVlS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 10 May 2021 17:41:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232976AbhEJVlS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 10 May 2021 17:41:18 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1ED9C061574
        for <linux-pm@vger.kernel.org>; Mon, 10 May 2021 14:40:12 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id gx21-20020a17090b1255b02901589d39576eso169465pjb.0
        for <linux-pm@vger.kernel.org>; Mon, 10 May 2021 14:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=AFH6rkAbV6Zg7Fla0hPgM0WvnU0I7elQCuNtXSYXVN4=;
        b=AsRc/HC1Yu7cwu7USVgqg9nDhYR2dumvpz3/OgS9bd1JBFseJboz7uwA2FRMXR8w2j
         iTCOu9Bt73q7SZYjRykjspBIAMM1lS402Sb22pJ5QrTVRFTW6wQARiG9nDr6nR4D16hn
         Db4cb+mty8sDEwWk8abMAFTR3tZ3gAVP5L8Y6xeKiY4/oXLypJ3wlaHoKGWUQjj5WX73
         ZzxblBOacn/1fYqz1MjTWoe6OgGjj5VLpmcaWwHc+SBFA3/0ZLJYKzn5Ng7GoY3btPNM
         hBC3XTznRdojE+i7ZefnTynGD+jtKneKnc1B/F1ZksrSqHMhNIk6sG91cn6XHuL/bQjY
         UhZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=AFH6rkAbV6Zg7Fla0hPgM0WvnU0I7elQCuNtXSYXVN4=;
        b=sCE+wfIgmBRuKKi6HF+NE0X6rv7KeFhuldKqTtPjNlIw5RD2LIlB0miHgYFsm6gAoS
         tG7U29XhAf6/SrZsdiROoQA08qTggDl0EvLQ3Yhu1ESboEPPWVZR8SINoPLnzx8UIV1D
         4bb4sgKKVzh2CF6MdQ901xgN4UiII3J3Og8Y6dziAQYWu4Dq4ZWHhLCKsSD55Qm3CfQ7
         7LwFxHIKXAlgTYrUoM0esJPKwayYZ8TwnTWUkD3XahaWQda5azIsGiGJGjcewvDuBLbc
         nCm+KgU1ugYao4CmydO0r/yw2Ro35eeCFknCcTSjNyLizexM1IUw6cvAo+WTDUsVVCmd
         0kNQ==
X-Gm-Message-State: AOAM530fzIvgkkUWSIcdbbJss5s/2K7HxfWBDQ+bQJb/W4nvNEM+Mzj7
        lT7zIXGJwfaaaTd/JFqz4aE7ngbpsPr/uSxD
X-Google-Smtp-Source: ABdhPJxHKegKwhytbfVyYYa+PhpbRI3whM+zmerDWrPLSKUMgrNeMbguciXaxEO8HLAoSS/xyEkP7g==
X-Received: by 2002:a17:90b:1e46:: with SMTP id pi6mr1316552pjb.212.1620682812322;
        Mon, 10 May 2021 14:40:12 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id a16sm11907322pfa.95.2021.05.10.14.40.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 14:40:12 -0700 (PDT)
Message-ID: <6099a83c.1c69fb81.6678d.4730@mx.google.com>
Date:   Mon, 10 May 2021 14:40:12 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v5.13-rc1-4-gdc9d574fa82fc
X-Kernelci-Branch: testing
Subject: pm/testing sleep: 3 runs, 1 regressions (v5.13-rc1-4-gdc9d574fa82fc)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing sleep: 3 runs, 1 regressions (v5.13-rc1-4-gdc9d574fa82fc)

Regressions Summary
-------------------

platform        | arch  | lab           | compiler | defconfig | regressions
----------------+-------+---------------+----------+-----------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-8    | defconfig | 1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.13-rc=
1-4-gdc9d574fa82fc/plan/sleep/

  Test:     sleep
  Tree:     pm
  Branch:   testing
  Describe: v5.13-rc1-4-gdc9d574fa82fc
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      dc9d574fa82fc39db81cb09a99c09c865d03f98b =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig | regressions
----------------+-------+---------------+----------+-----------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-8    | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/60999b44a61dd568576f5472

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.13-rc1-4-gdc9d57=
4fa82fc/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.13-rc1-4-gdc9d57=
4fa82fc/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2021=
0503.0/arm64/rootfs.cpio.gz =



  * sleep.login: https://kernelci.org/test/case/id/60999b44a61dd568576f5473
        failing since 264 days (last pass: v5.8-107-gb72b3ea38c81, first fa=
il: v5.9-rc1-4-g1f08d51cd57f) =

 =20
