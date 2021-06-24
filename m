Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3EB83B3517
	for <lists+linux-pm@lfdr.de>; Thu, 24 Jun 2021 19:59:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229464AbhFXSB2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 24 Jun 2021 14:01:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbhFXSB2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 24 Jun 2021 14:01:28 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76C8CC061574
        for <linux-pm@vger.kernel.org>; Thu, 24 Jun 2021 10:59:07 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id u190so5370358pgd.8
        for <linux-pm@vger.kernel.org>; Thu, 24 Jun 2021 10:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=XyfC39Be8nxbZCD0IbPwUeHv7fDlOEK0ROtzWD/6SoU=;
        b=yjK4pkgtJBTX9ozYtJ3czjPkAIzicdK6XCFfa3usH2cvnm9AtntJsqkMpYgyE9Okph
         9SVV0unZcxN0PajndtvnMYkA78R/IXrF19LFnE8TSr++1109aPDeVqeGXkWzFQ0RmG0/
         PKd3VWkZwJvT8NlcZrWnAyC0ldQWbiMHGEEFscrX6+2QPrKdWsN//GL4fRZ8nLda1/l8
         JHN8gipNylD3At5hbLdH+i0QpdCQ8XRJkv0fkPHCb+whN9MFRZTqfd7ofzKMBjmW1/58
         Xr0msQ6V/El4xZSZmM2GHti6U92JiONBfJXZlUCxp8epVxwOudieWhlz3db0zrCyzowC
         vzjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=XyfC39Be8nxbZCD0IbPwUeHv7fDlOEK0ROtzWD/6SoU=;
        b=YjNLHZ2TGuomRJLmwYmpylW1WYKHCeesMVE6crp+SDAeeHIy3EvaxVK89AWgtSthOg
         5Kd+geEytr85zxpb5CBtKY/HA/Z/KBxhd8266P1//vlAAlo/HqYZFY8Q9znRnuVMDjnK
         Bt3qFmoFuV/D4xTFoOhnnXn15iuYODc93hXMkQ03HXTKskRdDeKYkr66W/vNlaVQnMUM
         GtCNi0sZ6liZctgyuiQ/KPcpwZimVvFP00g3tiMk2rTk4zEcqvYGsu7G+XcchObfQ2eP
         p/VRQc8RENN/uKQJzENxhRTyRlPs8H0p3NJDYhlwE9jlijxG+eu2+DXw3mJ2MX5qVJ6b
         JiKw==
X-Gm-Message-State: AOAM532pJLq9LH9U/OwOPtxm9pkjQ5r0U8cBzTMVTPi8VuaMqJs6MtCQ
        NC88gshEBl5lTYDqCE5XdSZccXyzIt2RO8wE
X-Google-Smtp-Source: ABdhPJwwp4/sIdnYDdOJLTovv2yYsg+w+WrWtp7waXPXZ5L2uVe/xHy6bP6VLLcv5z0MlILin52i0g==
X-Received: by 2002:a62:2bc6:0:b029:2e7:a7c2:201 with SMTP id r189-20020a622bc60000b02902e7a7c20201mr6330974pfr.64.1624557547011;
        Thu, 24 Jun 2021 10:59:07 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id y29sm3931715pff.161.2021.06.24.10.59.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 10:59:06 -0700 (PDT)
Message-ID: <60d4c7ea.1c69fb81.5914b.a613@mx.google.com>
Date:   Thu, 24 Jun 2021 10:59:06 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: pm-5.13-rc8-159-g3304616e985f
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
Subject: pm/testing sleep: 3 runs,
 1 regressions (pm-5.13-rc8-159-g3304616e985f)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing sleep: 3 runs, 1 regressions (pm-5.13-rc8-159-g3304616e985f)

Regressions Summary
-------------------

platform        | arch  | lab           | compiler | defconfig | regressions
----------------+-------+---------------+----------+-----------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-8    | defconfig | 1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/pm-5.13-=
rc8-159-g3304616e985f/plan/sleep/

  Test:     sleep
  Tree:     pm
  Branch:   testing
  Describe: pm-5.13-rc8-159-g3304616e985f
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      3304616e985fa1c05e1a111375480fc88d71a574 =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig | regressions
----------------+-------+---------------+----------+-----------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-8    | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/60d4bb265111bce13d413267

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/pm-5.13-rc8-159-g33=
04616e985f/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//pm/testing/pm-5.13-rc8-159-g33=
04616e985f/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2021=
0520.0/arm64/rootfs.cpio.gz =



  * sleep.login: https://kernelci.org/test/case/id/60d4bb265111bce13d413268
        failing since 308 days (last pass: v5.8-107-gb72b3ea38c81, first fa=
il: v5.9-rc1-4-g1f08d51cd57f) =

 =20
