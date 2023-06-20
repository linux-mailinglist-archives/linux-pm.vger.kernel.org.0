Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D4BF736DA2
	for <lists+linux-pm@lfdr.de>; Tue, 20 Jun 2023 15:44:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231974AbjFTNo1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 20 Jun 2023 09:44:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231144AbjFTNo0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 20 Jun 2023 09:44:26 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF8C610FB
        for <linux-pm@vger.kernel.org>; Tue, 20 Jun 2023 06:44:18 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1b51488ad67so23724595ad.3
        for <linux-pm@vger.kernel.org>; Tue, 20 Jun 2023 06:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1687268658; x=1689860658;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Yawf9rhWpGWFHUpeLg3d0q8Y8aEtEeejc/eHHdVGoag=;
        b=lgYDNi2uzi95/vqEPpezN0WZSE2/kWT1GoIj9qsUJSkZwYRvL0BXbmXp+POsMQ2U6f
         geZEBNHtsosALeLPqnG252vctdgHLls4t8MMA40Q3dpwii1Q2SN/ta5fsjqKqW7jW0Cd
         Zx/JMMIU2/ZC38CxP0bgrQV9CPRObQkg3A71Yubhnazj8MenrkmUU4u6Yn4GDSSjBVlO
         zO7Q2m1AKzWb9lWaxaZ6IW/rj8ocCRMoFygaz0Z763wnW8cfIMWRfbASO0RFY9h+63Qe
         5QSRzFX9h21UgR6/Hx8LnOjv1hYOdfmWOxUew99wddBrFLjeGUFOa3+JFf4TxYsvsgt8
         QrfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687268658; x=1689860658;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yawf9rhWpGWFHUpeLg3d0q8Y8aEtEeejc/eHHdVGoag=;
        b=RX0gVcLsgvp1uCU9LjFgA+Pz15luPRCku2GG+FsqaiimoRrKyWbBYNoyW9dCWyqNJB
         XL+rXJhOof2333yYRyQIC7j1WYAMb0Z2U0txpePOoLy3LebdcdBK6V5jciUo8c/SseEG
         QV05yvILhxbLntUSdLqbOEzMqpi/F8H+5eA9y35VXdfeNAsgGb5uvfMdRZGFp5ArhlOA
         EuHoVl/RZtaHOYEiq23GVSR3Yj0f9dCLdm7A9bt85Qi3LL4iy0l5u4Coya16LyPpeWZ4
         Loqqp5hfXaoDmabSzrZvUC30Bo+OOfYmNwKTw/9ayGPGG18IKcrcuxv6xzUhKz0apfZI
         RPiA==
X-Gm-Message-State: AC+VfDx1h96co0UHk1efHA1RjObEL8b5GnkzGghrcnLp3r2Sa8DBcQSn
        nyxjccPKwrRwTRa9tXORguVZ7g==
X-Google-Smtp-Source: ACHHUZ7PnI0HxY8hdEct+6JRpN68G+CZpIvBAsHEgiosOFQWJbkcDDl6zJYrzFJQI616D5U/Fg0kFQ==
X-Received: by 2002:a17:902:778d:b0:1b0:26f0:4c8e with SMTP id o13-20020a170902778d00b001b026f04c8emr7987600pll.69.1687268658337;
        Tue, 20 Jun 2023 06:44:18 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id w1-20020a170902e88100b001b55aab3301sm1657848plg.130.2023.06.20.06.44.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 06:44:17 -0700 (PDT)
Message-ID: <6491ad31.170a0220.e1945.3a36@mx.google.com>
Date:   Tue, 20 Jun 2023 06:44:17 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.4-rc7-79-gb1f20777e6682
Subject: pm/testing baseline: 50 runs,
 2 regressions (v6.4-rc7-79-gb1f20777e6682)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 50 runs, 2 regressions (v6.4-rc7-79-gb1f20777e6682)

Regressions Summary
-------------------

platform                     | arch  | lab             | compiler | defconf=
ig          | regressions
-----------------------------+-------+-----------------+----------+--------=
------------+------------
imx53-qsrb                   | arm   | lab-pengutronix | gcc-10   | multi_v=
7_defconfig | 1          =

sun50i-h5-lib...ch-all-h3-cc | arm64 | lab-broonie     | gcc-10   | defconf=
ig          | 1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v6.4-rc7=
-79-gb1f20777e6682/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v6.4-rc7-79-gb1f20777e6682
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      b1f20777e66825da68bec14044392a6d1761e7d8 =



Test Regressions
---------------- =



platform                     | arch  | lab             | compiler | defconf=
ig          | regressions
-----------------------------+-------+-----------------+----------+--------=
------------+------------
imx53-qsrb                   | arm   | lab-pengutronix | gcc-10   | multi_v=
7_defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/6491a09d43221b8d75306140

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.4-rc7-79-gb1f207=
77e6682/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx53-qsrb.t=
xt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.4-rc7-79-gb1f207=
77e6682/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx53-qsrb.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6491a09d43221b8d75306145
        failing since 143 days (last pass: v6.1-rc8-156-g0a9e32afe717, firs=
t fail: acpi-6.2-rc6-146-g628c61874ffd)

    2023-06-20T12:50:20.944188  + set +x
    2023-06-20T12:50:20.944467  [   13.081773] <LAVA_SIGNAL_ENDRUN 0_dmesg =
982655_1.5.2.3.1>
    2023-06-20T12:50:21.052198  / # #
    2023-06-20T12:50:21.154091  export SHELL=3D/bin/sh
    2023-06-20T12:50:21.154629  #
    2023-06-20T12:50:21.256064  / # export SHELL=3D/bin/sh. /lava-982655/en=
vironment
    2023-06-20T12:50:21.256516  =

    2023-06-20T12:50:21.357885  / # . /lava-982655/environment/lava-982655/=
bin/lava-test-runner /lava-982655/1
    2023-06-20T12:50:21.358591  =

    2023-06-20T12:50:21.362068  / # /lava-982655/bin/lava-test-runner /lava=
-982655/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch  | lab             | compiler | defconf=
ig          | regressions
-----------------------------+-------+-----------------+----------+--------=
------------+------------
sun50i-h5-lib...ch-all-h3-cc | arm64 | lab-broonie     | gcc-10   | defconf=
ig          | 1          =


  Details:     https://kernelci.org/test/plan/id/6491a6cafd6e3fbbd1306130

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.4-rc7-79-gb1f207=
77e6682/arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-h5-libretech-all=
-h3-cc.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.4-rc7-79-gb1f207=
77e6682/arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-h5-libretech-all=
-h3-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6491a6cafd6e3fbbd1306=
131
        failing since 63 days (last pass: v6.3-rc6-135-g5235219c59f8, first=
 fail: v6.3-rc7-153-gbc538c8be4bd) =

 =20
