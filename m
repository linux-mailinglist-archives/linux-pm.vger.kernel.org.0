Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00CC22772D5
	for <lists+linux-pm@lfdr.de>; Thu, 24 Sep 2020 15:43:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727898AbgIXNn0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 24 Sep 2020 09:43:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728016AbgIXNnZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 24 Sep 2020 09:43:25 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B02BC0613CE
        for <linux-pm@vger.kernel.org>; Thu, 24 Sep 2020 06:43:25 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id u4so1709619plr.4
        for <linux-pm@vger.kernel.org>; Thu, 24 Sep 2020 06:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=9/yJUHSmC7m+rrTkD1YOrRZQnopvjTx45JcuJNXM6/U=;
        b=C947PHhgR6ZVoKM4707kmw5mhHtEPicEL1GvTJ8R33Nwm/gDZcXma2ZQRGeUw5kJos
         lw8KsT76UbQERL2ZUy8e6tBvkD3CsrZDaMGezgjwkWk5/Q3RoUlksZd3ZvhV1/Ds/jYE
         lWTtW2HB94Crcf6fpDZ483Eu3lvxXOn4VsxWQVRkFBNXL69vgjy/uTHT/xVXwhEeY0uU
         SLfGuQoehrdZdC3FyjPYZSQNqSRL6Pb21nl/ma3jvw6Ig+0+tE7FgzmU2b2r2wXeI0b0
         I16L2CfmXmCJWyFT40Sr7fB+HHz3nFWY7gfX4FhsGXsE8tWQMUAGuYDFyMTt57MrKSZT
         qTnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=9/yJUHSmC7m+rrTkD1YOrRZQnopvjTx45JcuJNXM6/U=;
        b=W/XfI5TKd3Z6HGLpfxcKV40sctPlY/AjbnTV3uwh13XVqhZzyGCrri0UD9u96u/Npp
         aHv9ucApisTTlYHAjoFqry9WB4NiFM6IURFHRgXtzz2Y+Kz8DlWS9pdNTQJw0drnvhLZ
         Q+haIRRdT3ZGfIVEw49oz+irxJWiknHQElm3NJz4RiwqOLrK+Tuaa0JMFAc8A8bBm9NN
         qdHv1+38FwTMyIzqUhl/jvzfrW/R3JEnZB4UQCgBhD572RkFUePPIlq9y2DK/1EDRD9E
         dofrpEoNEDdEvFQInr9gJdEt0UEcRHJLvs8wFibBz1N4LydtznpqZb5WePqh6jIylPdC
         qNjw==
X-Gm-Message-State: AOAM530DoHuKHIO4cF9gBwFc+Fp71xGSCqNKdfQT2aO4YCBkVJsqvoB1
        rAHZ1YsCLkOz4t8DhMhoOAZU6i8uWKGWyA==
X-Google-Smtp-Source: ABdhPJzlsHQJOWw6Ez3KIy7fKvsH5suc+w3q+h2YBYyPOhqOZdF01KzjJlL5U0Mu0Y7ve94RCFUWXg==
X-Received: by 2002:a17:90a:e016:: with SMTP id u22mr4290910pjy.178.1600955004972;
        Thu, 24 Sep 2020 06:43:24 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id y4sm3073303pfr.46.2020.09.24.06.43.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2020 06:43:24 -0700 (PDT)
Message-ID: <5f6ca27c.1c69fb81.7846.8088@mx.google.com>
Date:   Thu, 24 Sep 2020 06:43:24 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
X-Kernelci-Kernel: v5.9-rc6-37-ga31d518ec481
Subject: pm/testing sleep: 8 runs, 1 regressions (v5.9-rc6-37-ga31d518ec481)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing sleep: 8 runs, 1 regressions (v5.9-rc6-37-ga31d518ec481)

Regressions Summary
-------------------

platform        | arch  | lab           | compiler | defconfig | results
----------------+-------+---------------+----------+-----------+--------
mt8173-elm-hana | arm64 | lab-collabora | gcc-8    | defconfig | 0/1    =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.9-rc6=
-37-ga31d518ec481/plan/sleep/

  Test:     sleep
  Tree:     pm
  Branch:   testing
  Describe: v5.9-rc6-37-ga31d518ec481
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      a31d518ec48107762495760932218e57b2038289 =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig | results
----------------+-------+---------------+----------+-----------+--------
mt8173-elm-hana | arm64 | lab-collabora | gcc-8    | defconfig | 0/1    =


  Details:     https://kernelci.org/test/plan/id/5f6c95651df64c4f2ebf9db3

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.9-rc6-37-ga31d51=
8ec481/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.9-rc6-37-ga31d51=
8ec481/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2020=
0911.0/arm64/rootfs.cpio.gz =


  * sleep.login: https://kernelci.org/test/case/id/5f6c95651df64c4f2ebf9db4
      failing since 35 days (last pass: v5.8-107-gb72b3ea38c81, first fail:=
 v5.9-rc1-4-g1f08d51cd57f)  =20
