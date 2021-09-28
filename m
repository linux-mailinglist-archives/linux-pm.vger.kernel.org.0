Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23C0E41B2C1
	for <lists+linux-pm@lfdr.de>; Tue, 28 Sep 2021 17:15:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241384AbhI1PRI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 28 Sep 2021 11:17:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241442AbhI1PRG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 28 Sep 2021 11:17:06 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B7DDC06161C
        for <linux-pm@vger.kernel.org>; Tue, 28 Sep 2021 08:15:26 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id bb10so14424629plb.2
        for <linux-pm@vger.kernel.org>; Tue, 28 Sep 2021 08:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=OFV7sztx+HQEr69xPWJJ13swjYlsTSE1bWXN3U0TFQM=;
        b=5NtpTQr1HPwaLL7oVRagxRdkagqEjIwt4yLVyNg4gI2VxXjxIP2v+aNLYH70RGubNt
         9yNbvZtnA1NbxipzJAiByNDV158+TP7MgCviBuTBHYrMwoGhYdcJ0xZBuuzAh/IbvHvQ
         oeJCmQB1MfCayLpLtUO2ot525OZdfZF9MNFlrS05i6pxSd0g315N3LqXhfCvUUijlgYp
         IpW6uj78e5YNzXshHPm45n0ihyS+B2Y8u9aGSywTpTUh2YHuBfOJeRu9qMOJlno95dx5
         vLZfY42cfHd1sSrT9FagC6phnwrOx4wsXPKYIGli1ezSoHTnDrahpdZ/upqGUiynmnL4
         sSnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=OFV7sztx+HQEr69xPWJJ13swjYlsTSE1bWXN3U0TFQM=;
        b=3dXpPcZq0rpt9WYnw2mLa9ZGsdsZ/vf+Y3Dvnb/MBRwPbXZH6S9ioD4rexjmXHS3+T
         UoTenVzDffUvyw1uN0EJ9EcARNYZDvB8rqblqGJKtwiCBeiaWN030H3Qf0JU2aDmVJYm
         G0xCxqyMB42EG5tPKo73IVQaQ/2i0ttjl25rJMELxrnAF3jPShIONCUMH21YxcXXRCMY
         1mwonNDoD/y2RscY224bPW3GO/GqwZ9/iXjNQwQx3Uwyh02rQ4bPEKPmf2GDll/wqick
         QgX8qxWsdw2WBrleI6YpS7v9D9TLawDvzOPKY7ggvxhffft5IsmIAq+uiveFzcKjbBWi
         XJkA==
X-Gm-Message-State: AOAM53141Wq0m0yAuUe5bY8N2Ohdc6IsK4mBMNKfflrtCYwKoLiNqI2F
        ooye+IYTXGriAMLZicQ99jb+YjeSC+QY6Yqp
X-Google-Smtp-Source: ABdhPJw90oMbG1/61eFFmepEjT3Demqr0KTYz3DcLpfH21a83fLrTDEY8gIMdu4rURAWTJVtJL7/zg==
X-Received: by 2002:a17:90a:514b:: with SMTP id k11mr541998pjm.152.1632842125779;
        Tue, 28 Sep 2021 08:15:25 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id ci18sm2889133pjb.11.2021.09.28.08.15.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 08:15:25 -0700 (PDT)
Message-ID: <6153318d.1c69fb81.9824.9127@mx.google.com>
Date:   Tue, 28 Sep 2021 08:15:25 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.15-rc3-18-g7c86bb8dfc1b
X-Kernelci-Report-Type: test
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
Subject: pm/testing sleep: 4 runs, 1 regressions (v5.15-rc3-18-g7c86bb8dfc1b)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing sleep: 4 runs, 1 regressions (v5.15-rc3-18-g7c86bb8dfc1b)

Regressions Summary
-------------------

platform        | arch  | lab           | compiler | defconfig | regressions
----------------+-------+---------------+----------+-----------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-8    | defconfig | 1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.15-rc=
3-18-g7c86bb8dfc1b/plan/sleep/

  Test:     sleep
  Tree:     pm
  Branch:   testing
  Describe: v5.15-rc3-18-g7c86bb8dfc1b
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      7c86bb8dfc1ba1e8f6fef352555cf21a37ea2bc3 =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig | regressions
----------------+-------+---------------+----------+-----------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-8    | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/6153252d96bc95397d99a2f2

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.15-rc3-18-g7c86b=
b8dfc1b/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.15-rc3-18-g7c86b=
b8dfc1b/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2021=
0913.0/arm64/rootfs.cpio.gz =



  * sleep.login: https://kernelci.org/test/case/id/6153252d96bc95397d99a2f3
        failing since 404 days (last pass: v5.8-107-gb72b3ea38c81, first fa=
il: v5.9-rc1-4-g1f08d51cd57f) =

 =20
