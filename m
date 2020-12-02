Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7258F2CC6B0
	for <lists+linux-pm@lfdr.de>; Wed,  2 Dec 2020 20:32:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728650AbgLBTbu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 2 Dec 2020 14:31:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726996AbgLBTbu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 2 Dec 2020 14:31:50 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4525C0613CF
        for <linux-pm@vger.kernel.org>; Wed,  2 Dec 2020 11:31:09 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id p21so952048pjv.0
        for <linux-pm@vger.kernel.org>; Wed, 02 Dec 2020 11:31:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=i+4r4Zn7+uOUM3YicFpbFkAO1SNFawOXEKfVZC9eUgo=;
        b=K+S3fPF1+HezcNZHBhsJYSNN0gV1hJD11jJoApE1d2whnxVEd4YdLO4Go/o/P5RGqO
         e9Lpv2vso6wisG4s4WpeIwPUS63mnwZVhVBp+bq6aHmOMq4fAFRHULjm8cY6K9PrzPK0
         u4nr78mACm0oxqBsx/10oPP4ZDvNi3HouiH0nrKb0mzWbFotZIj5yxUh6FdjDvn8Drw5
         12/ao8j42HoxSi38bmncsw7fYZrjtzzjrrU0Zf6MqYYLZRoAAOWorTGjLYoGlpj/g0Vu
         qZsseXR+3arpp31mVBIyLe4BFA2z2ulRpWArw1wCDEgb9XCjVoxeJ54kcpeEawbhsc+F
         lK7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=i+4r4Zn7+uOUM3YicFpbFkAO1SNFawOXEKfVZC9eUgo=;
        b=R6oyCYPv11wXCjyCufVnQWyzKBG7UUFGFfU1eeU+6bTVcK9cLsS19HU0MF0mawAI5T
         bfTb3gdP0wqAiy2GInTzn/GGkTeITCUuNOQa9j4tANTXy8me8VMtdEoouICi3efhiVPc
         a2x2NMWRHr639wxpsLIJZ8lXjE0zhYX21iSvLoeq6PopfCvsjf+WBx84gxVH3jvEcAuT
         P1hM+7yCfKQjleU0O+ovOm3FZU+fzJ/OFqLD2yFhCi7C9rlsicT2PMoQ+fE7QZDOPsLT
         Yyhmj9dM3+zK5JGoN2yHR3NqerMu5Ffv8Uc8bFXkeXn1HagmmwXDr2qXXE7G2DIjh6MS
         KVcQ==
X-Gm-Message-State: AOAM531nZSdxc3ddt/t5L3Y5pKjt7ok7uHOVa1uQG+9dro2E6mrxekIk
        lBfAP4gHovpjmaK5pqd8hwiJ1Q==
X-Google-Smtp-Source: ABdhPJy5G/XB2tUiDAFff51QMl5qpZRBrhzPu/XqhQ36vDQgoZycvfeRMsywk8a/pUELgeBNSamMVg==
X-Received: by 2002:a17:90a:aa87:: with SMTP id l7mr1264902pjq.167.1606937469424;
        Wed, 02 Dec 2020 11:31:09 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id o29sm565348pfp.66.2020.12.02.11.31.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 11:31:08 -0800 (PST)
Message-ID: <5fc7eb7c.1c69fb81.4193b.1a33@mx.google.com>
Date:   Wed, 02 Dec 2020 11:31:08 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v5.10-rc6-87-g53bf34061bc2
X-Kernelci-Report-Type: test
Subject: pm/testing sleep: 7 runs, 1 regressions (v5.10-rc6-87-g53bf34061bc2)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing sleep: 7 runs, 1 regressions (v5.10-rc6-87-g53bf34061bc2)

Regressions Summary
-------------------

platform        | arch  | lab           | compiler | defconfig | regressions
----------------+-------+---------------+----------+-----------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-8    | defconfig | 1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.10-rc=
6-87-g53bf34061bc2/plan/sleep/

  Test:     sleep
  Tree:     pm
  Branch:   testing
  Describe: v5.10-rc6-87-g53bf34061bc2
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      53bf34061bc25d8191db8c0d66104c9e7ed7f9b3 =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig | regressions
----------------+-------+---------------+----------+-----------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-8    | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/5fc7df06f3ca025bdbc94ce3

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.10-rc6-87-g53bf3=
4061bc2/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.10-rc6-87-g53bf3=
4061bc2/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2020=
1130.0/arm64/rootfs.cpio.gz =



  * sleep.login: https://kernelci.org/test/case/id/5fc7df06f3ca025bdbc94ce4
        failing since 105 days (last pass: v5.8-107-gb72b3ea38c81, first fa=
il: v5.9-rc1-4-g1f08d51cd57f) =

 =20
