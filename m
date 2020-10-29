Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6D4929F5D1
	for <lists+linux-pm@lfdr.de>; Thu, 29 Oct 2020 21:04:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726433AbgJ2UEg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 29 Oct 2020 16:04:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726419AbgJ2UEf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 29 Oct 2020 16:04:35 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 930BDC0613CF
        for <linux-pm@vger.kernel.org>; Thu, 29 Oct 2020 13:04:35 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id c20so3262031pfr.8
        for <linux-pm@vger.kernel.org>; Thu, 29 Oct 2020 13:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=HmDnBSVNC6qQnYYn5lYet8c5k1ZKx6RIi0h666cji+Y=;
        b=0YwG/QQOPZ8SfiwV53Yror7QXrbVnlBDxF/RUGg7Qn8Tv9y5vO4CbNLHaJNT4Zz4HQ
         WajTkOx/KHcHWS24i5m0jDu/sa8eOGe6tgU+nmKhy/EfJ+j9d5q32H/cIcdqUZ9TT+76
         6Q2bF/J62p/h3zYKmdsjECVYqqEb1Oz+8R2gRRG00BANP/2ny7i0Ci+SrkFyoGhJmRrG
         r6ZVT3CGkmPCtWiER0rIk7gJDby4CZM0xPr9a4z5lBfsoC9zPbds4Pq6tUhUPf+ji4i/
         l+5sgs2e7qbNnLey/CCtK3FlXTPlw4x126H32QYaUHw4NTs3gyLgHOJxEOpbxfNbkNYz
         CGRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=HmDnBSVNC6qQnYYn5lYet8c5k1ZKx6RIi0h666cji+Y=;
        b=WScpAluj9igoSE676WpGjiUu3bb1zyxwVWnBRu9UwUKABnZuRt11YuRk+fynzfjUew
         LHMt+0cNmYddDHXM+cntf2UcrcX6mDcfmvg9nrCdOS0ul1X+oD0gHgLyLZgqh4B33xDJ
         ihiNXp19ctLLfqyBZiQPHpsCZwHT8KpNNIC2j0yj7IIkrIhIXMvQ0rigXgHUs+xlKlNm
         zH+9SGT8uS28wsqLbqGvuBQjM4S4N6q3w4UvErSZhIc96IWCvhxZP6pW3Be9ULqmh184
         Qqk9YkIvL1ojCok2SgFsaO9mwf2VNMh9S2hW2gzUsx88NhDRSF73S/dVKuiu+eoQiLF5
         yAKw==
X-Gm-Message-State: AOAM532MENrC4zkc7ArEhD53rkGZOGENzlAM43ixSPkiA6B4QDLLUgeN
        19ySmPcEeGJZvcLMBp+KQq1Urw==
X-Google-Smtp-Source: ABdhPJxacoBirPPpmI2cIixoHhXgl6VkjzIuejnnXQuYXSsvDmCgzhtVKz830a8ckXKu1WuGrthxQQ==
X-Received: by 2002:a17:90a:8007:: with SMTP id b7mr876899pjn.84.1604001875257;
        Thu, 29 Oct 2020 13:04:35 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id 10sm660387pjt.50.2020.10.29.13.04.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 13:04:34 -0700 (PDT)
Message-ID: <5f9b2052.1c69fb81.22fcd.18e8@mx.google.com>
Date:   Thu, 29 Oct 2020 13:04:34 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.10-rc1-21-gc0300fd595bb
X-Kernelci-Report-Type: test
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
Subject: pm/testing sleep: 5 runs, 1 regressions (v5.10-rc1-21-gc0300fd595bb)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing sleep: 5 runs, 1 regressions (v5.10-rc1-21-gc0300fd595bb)

Regressions Summary
-------------------

platform        | arch  | lab           | compiler | defconfig | regressions
----------------+-------+---------------+----------+-----------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-8    | defconfig | 1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.10-rc=
1-21-gc0300fd595bb/plan/sleep/

  Test:     sleep
  Tree:     pm
  Branch:   testing
  Describe: v5.10-rc1-21-gc0300fd595bb
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      c0300fd595bb14b0f13400d75380859f1558bcac =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig | regressions
----------------+-------+---------------+----------+-----------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-8    | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/5f9b13bf56d0b960dc381032

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.10-rc1-21-gc0300=
fd595bb/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.10-rc1-21-gc0300=
fd595bb/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2020=
1022.0/arm64/rootfs.cpio.gz =



  * sleep.login: https://kernelci.org/test/case/id/5f9b13bf56d0b960dc381033
        failing since 71 days (last pass: v5.8-107-gb72b3ea38c81, first fai=
l: v5.9-rc1-4-g1f08d51cd57f) =

 =20
