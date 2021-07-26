Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 205C33D6816
	for <lists+linux-pm@lfdr.de>; Mon, 26 Jul 2021 22:20:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232488AbhGZTj7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 26 Jul 2021 15:39:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232069AbhGZTj7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 26 Jul 2021 15:39:59 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84905C061760
        for <linux-pm@vger.kernel.org>; Mon, 26 Jul 2021 13:20:26 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id a20so13310491plm.0
        for <linux-pm@vger.kernel.org>; Mon, 26 Jul 2021 13:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=Xytr2lS1XzOZPEjgFFbOl4hYPUnBcjuxyRvgswe2Hsw=;
        b=P5u+0eQz9NA60pid4G5QsQxn/PQfWaANnwl488Kh/Pdt+49xzsrJBx0VMCw4u8yMC1
         0bRR7UokMLpUul32g2vzfoZyF3Y4qs2zL0sde1Nf+UVU537Kazlpew2Jqq9UClbyYS3+
         iPWrfgFvGi9ALyZxbfN8UbuB7+3BcyW38n4mMbm8bvDyVaiNdSMhdRY8WYz6QHznti6K
         Cl8Juev36Mr/XkO6gDg9+jzicl0zrW3AzgIiSrOVYxqRscq1TP4z5+OhBZUrOhaRqHji
         4QgiG8oQxobHyEeSqIjPclkpidk5gXQ4WDVaNnzY3cAhrToDs/aMUuXBg+91bNSNWlPo
         Uk0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=Xytr2lS1XzOZPEjgFFbOl4hYPUnBcjuxyRvgswe2Hsw=;
        b=b6/S5WQuf3eVc5/ixdJizRrMgv9kBjtXloPGCCoqsAbCE39ZIEOhG8ylDvEmORQqOY
         yyN40DYmyXUKWZZfsXT2ijaIiWsItgZ2xGRNq/qclh8H7FIRRYcHXfWiE71gp/PcolUf
         8G6PXWTyEN7X+odVIs3R/LzWT4aL+G82yGlwuXCQWP2N2yH9NWhOHbde4hceBAeUhmMc
         lMXfIhKnZQ1TwWVP4nlqA0h7eimcrov18HSpr1MPbr3QPbacz32h17pFTm8sYPQmzI+k
         5c1DHsi9Lrvrjao7xgIi+6DgzbIpi+FsNuxWDS5ToDy2GeNeS5xy6op1TFC3qBXP1ngJ
         5vRA==
X-Gm-Message-State: AOAM531CCHGFGg8Nn4hIwUNDrJPx6my0LjIfmqwk273BpixGkJojbbpN
        +nvTh7dANHXLpjRHdIG77tWqrA==
X-Google-Smtp-Source: ABdhPJzcQjPwVX86BTb9NcXQIYNUnIjl3uoLjclgkPfiHP8KpttPqcM174oFuvjadVyW9vAn7l4kPQ==
X-Received: by 2002:a65:5544:: with SMTP id t4mr19702620pgr.240.1627330826062;
        Mon, 26 Jul 2021 13:20:26 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id j21sm493288pjz.26.2021.07.26.13.20.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 13:20:25 -0700 (PDT)
Message-ID: <60ff1909.1c69fb81.fb06c.23fd@mx.google.com>
Date:   Mon, 26 Jul 2021 13:20:25 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Kernel: v5.14-rc3-16-g1dae4a65c011
X-Kernelci-Report-Type: test
X-Kernelci-Tree: pm
Subject: pm/testing sleep: 6 runs, 2 regressions (v5.14-rc3-16-g1dae4a65c011)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing sleep: 6 runs, 2 regressions (v5.14-rc3-16-g1dae4a65c011)

Regressions Summary
-------------------

platform         | arch  | lab           | compiler | defconfig | regressio=
ns
-----------------+-------+---------------+----------+-----------+----------=
--
mt8173-elm-hana  | arm64 | lab-collabora | gcc-8    | defconfig | 1        =
  =

rk3399-gru-kevin | arm64 | lab-collabora | gcc-8    | defconfig | 1        =
  =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.14-rc=
3-16-g1dae4a65c011/plan/sleep/

  Test:     sleep
  Tree:     pm
  Branch:   testing
  Describe: v5.14-rc3-16-g1dae4a65c011
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      1dae4a65c01109508ee17281b6d92b734d7bc1f3 =



Test Regressions
---------------- =



platform         | arch  | lab           | compiler | defconfig | regressio=
ns
-----------------+-------+---------------+----------+-----------+----------=
--
mt8173-elm-hana  | arm64 | lab-collabora | gcc-8    | defconfig | 1        =
  =


  Details:     https://kernelci.org/test/plan/id/60ff0cc6ef191d8f853a2f29

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.14-rc3-16-g1dae4=
a65c011/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.14-rc3-16-g1dae4=
a65c011/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2021=
0722.0/arm64/rootfs.cpio.gz =



  * sleep.login: https://kernelci.org/test/case/id/60ff0cc6ef191d8f853a2f2a
        failing since 341 days (last pass: v5.8-107-gb72b3ea38c81, first fa=
il: v5.9-rc1-4-g1f08d51cd57f) =

 =



platform         | arch  | lab           | compiler | defconfig | regressio=
ns
-----------------+-------+---------------+----------+-----------+----------=
--
rk3399-gru-kevin | arm64 | lab-collabora | gcc-8    | defconfig | 1        =
  =


  Details:     https://kernelci.org/test/plan/id/60ff15e78bd6ef34133a2f31

  Results:     12 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.14-rc3-16-g1dae4=
a65c011/arm64/defconfig/gcc-8/lab-collabora/sleep-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.14-rc3-16-g1dae4=
a65c011/arm64/defconfig/gcc-8/lab-collabora/sleep-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2021=
0722.0/arm64/rootfs.cpio.gz =



  * sleep.rtcwake-mem-7: https://kernelci.org/test/case/id/60ff15e78bd6ef34=
133a2f36
        new failure (last pass: v5.14-rc2-17-gd713e0c833987) =

 =20
