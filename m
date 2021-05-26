Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED79D391DA1
	for <lists+linux-pm@lfdr.de>; Wed, 26 May 2021 19:13:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234183AbhEZROr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 26 May 2021 13:14:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234127AbhEZROr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 26 May 2021 13:14:47 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35BA4C061574
        for <linux-pm@vger.kernel.org>; Wed, 26 May 2021 10:13:15 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id g18so1439042pfr.2
        for <linux-pm@vger.kernel.org>; Wed, 26 May 2021 10:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=V0tCxZ6cD0s+1hN9O7Ihznlk3RtlHvS4qHAAKZZDFao=;
        b=TPC1IbIkaCWrCqMyyxkcLWaNJqJD7ryYzaIE052o86n8gnS/+1mcWgzpsvXikWPbAm
         HNKWOVTGlFGS2xsJN1ncTVdjVEa94O1qJfh/H3t8KqjgSKkqbsFTci6+g2pkcrTDr2dA
         Ml2cQ7xl8jTNlEcu5jMxv6UKDD9oqggT/xZR1Swg98Gv+sHSvKxQKhr9PTFm5vNX+Qz3
         l/avntF/fyxuEY5j7TIWD/vRDIS+seib8EjQ47zihDrRMoIEChoxhJJbDy4b49SzuJgg
         1WdqwDbcumSWw9LAqbYp/fU2im1n/ile/FPEn2fz1EUxWA8holvPGveNuIv+sOTf4Q9c
         Emmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=V0tCxZ6cD0s+1hN9O7Ihznlk3RtlHvS4qHAAKZZDFao=;
        b=lUCBZbf4ZCupfXLKBA+H5Z78O/UhxrzWF8y6UYRplJ0lghtwI3gqNbkTrjj4EwRSzs
         1hU3936J0BgeG9pXeXMQM4zn24lL3FoOkUMwjftrim5djLykgM00waMipJW3IY8G+VO3
         dg7Sz5GdnWFw0uQrGfGFAMOBJMVLz6zk7oaGswj9uQzXzRaPeJT/7yAuJkwY0GU2FT5O
         GJIjR8BU2bjt18FdQ/FN83ADmL5MePivmLEojD0KmC8quQIuWX76uU4JdpvUc898wQdn
         nuUBDVK70yBksIoOH8RA2RqtH5eln7KXDF4m4pqyWVOJIcBThfQiFXvmByVt2Vpwk/+A
         jQRA==
X-Gm-Message-State: AOAM5336fAwagvJMT8NElt8eRefsR2HLLfdf6SxXThSFiDbI3zbfsDHM
        dLF+CzDL0zI2vGNZwtuxRAv24g==
X-Google-Smtp-Source: ABdhPJycUJShB4wMXaYZR/AGXcRZSYaQcZHJ6TuV52RnR4ly8QzKrhv/9SGX1hdicwPhCkwT6o4gxA==
X-Received: by 2002:a62:2a14:0:b029:263:20c5:6d8c with SMTP id q20-20020a622a140000b029026320c56d8cmr36615690pfq.23.1622049194509;
        Wed, 26 May 2021 10:13:14 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id w26sm17395621pgl.50.2021.05.26.10.13.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 10:13:14 -0700 (PDT)
Message-ID: <60ae81aa.1c69fb81.865db.8ac8@mx.google.com>
Date:   Wed, 26 May 2021 10:13:14 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v5.13-rc3-39-gb4a1c81b7736
X-Kernelci-Branch: testing
X-Kernelci-Report-Type: test
Subject: pm/testing sleep: 4 runs, 1 regressions (v5.13-rc3-39-gb4a1c81b7736)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing sleep: 4 runs, 1 regressions (v5.13-rc3-39-gb4a1c81b7736)

Regressions Summary
-------------------

platform        | arch  | lab           | compiler | defconfig | regressions
----------------+-------+---------------+----------+-----------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-8    | defconfig | 1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.13-rc=
3-39-gb4a1c81b7736/plan/sleep/

  Test:     sleep
  Tree:     pm
  Branch:   testing
  Describe: v5.13-rc3-39-gb4a1c81b7736
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      b4a1c81b77364a4a4a03bdd47304a74d95ca4d3b =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig | regressions
----------------+-------+---------------+----------+-----------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-8    | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/60ae74efd990dea0b8b3afa1

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.13-rc3-39-gb4a1c=
81b7736/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.13-rc3-39-gb4a1c=
81b7736/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2021=
0503.0/arm64/rootfs.cpio.gz =



  * sleep.login: https://kernelci.org/test/case/id/60ae74efd990dea0b8b3afa2
        failing since 279 days (last pass: v5.8-107-gb72b3ea38c81, first fa=
il: v5.9-rc1-4-g1f08d51cd57f) =

 =20
