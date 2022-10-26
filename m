Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75B5E60EA46
	for <lists+linux-pm@lfdr.de>; Wed, 26 Oct 2022 22:31:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234154AbiJZUb6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 26 Oct 2022 16:31:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234111AbiJZUb5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 26 Oct 2022 16:31:57 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E71F83D5BF
        for <linux-pm@vger.kernel.org>; Wed, 26 Oct 2022 13:31:55 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id f5-20020a17090a4a8500b002131bb59d61so4188579pjh.1
        for <linux-pm@vger.kernel.org>; Wed, 26 Oct 2022 13:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Vo0sS6aua0AA2hmKOLbbD8XcrG6QhZurL2yFWtK6O3w=;
        b=HuouoGzh5N4BpZZ9fd/DQk+KEeZQOIc6aYmCcHszFgz37l9157W6ZuOVHaRuhxjr2i
         UsxeIFTP7hJa3uQKqxN6SkH553fKe4KHwOnRJvi3cw/6Zla+y48lTeVq09WRSq5aMIGv
         uMnUxrj0yQbEHmgSMwGk8NclpZLeXabu4SsXTbSvB+Ips88uqQX1XDgbZLAcmRHArehH
         i9rAVWEI5iChItq9nCPjDcQoyuBWPrYbtrGPSlRhBnBNZ9fOIPLcAh/L2CP43kl+HsS7
         krZZTBXPZKw1fhUA5emJFcX2GjHo4gg/rFpsp6vRKkteS0iFZm6kUFuFj3WhulPP7jKB
         32xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vo0sS6aua0AA2hmKOLbbD8XcrG6QhZurL2yFWtK6O3w=;
        b=WWePulZds41j82YmnlCiEXW1UIzGNr+seRU4jNICI3swZkVR/Azxh8i1NtHMDBD7L2
         jQIYIW4P7JTLz8DIB+45xM0HL3VYLlD45KfMn3H7aB9GHA9uHmK2/2UIJqTwep/1GcGm
         x+CG5r8xZ4hETm2Bhaz/jRCiY+FeBcMkjGtEtW3TJ7cefT+eyRSmVJXrqjgK0nePTzq/
         /DPlBRC4BT9OZTIZYn+/yanPwxIbYLR9Wzg3ofRPHZ2GQ3IlBHemD8+jWEIAXiANINst
         cnsZhyEYKjHvAWtaY8Ew0NklZz5yc0+qvFgiOH7Ihg6l5J2TKU22woDs4lTN3Kh4GfMq
         K6fA==
X-Gm-Message-State: ACrzQf0SWCI0zowsKUc1RQB2bDqr29Ij+5GSZPsR63BZ3oUOpDLu7sN7
        +rsa1n0RPa/Jj6ZS8K9/lBFacAjy4NRbWIkg
X-Google-Smtp-Source: AMsMyM6e26leKti9Lnen5dO8zHAGb+l1OaUcKgRm811Nl+DiP9gBp9Vb9PKNF5ygetgXWMYnelgfQg==
X-Received: by 2002:a17:902:e74a:b0:186:a094:1d3 with SMTP id p10-20020a170902e74a00b00186a09401d3mr18826510plf.153.1666816315353;
        Wed, 26 Oct 2022 13:31:55 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id i1-20020a1709026ac100b00185402cfedesm3279939plt.246.2022.10.26.13.31.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 13:31:55 -0700 (PDT)
Message-ID: <6359993b.170a0220.f30bc.73a3@mx.google.com>
Date:   Wed, 26 Oct 2022 13:31:55 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.1-rc2-12-g77db830e1d3a3
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
Subject: pm/testing baseline: 40 runs,
 1 regressions (v6.1-rc2-12-g77db830e1d3a3)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 40 runs, 1 regressions (v6.1-rc2-12-g77db830e1d3a3)

Regressions Summary
-------------------

platform              | arch  | lab         | compiler | defconfig | regres=
sions
----------------------+-------+-------------+----------+-----------+-------=
-----
kontron-kbox-a-230-ls | arm64 | lab-kontron | gcc-10   | defconfig | 1     =
     =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v6.1-rc2=
-12-g77db830e1d3a3/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v6.1-rc2-12-g77db830e1d3a3
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      77db830e1d3a3b7ae46801b25de69104aff9ed7a =



Test Regressions
---------------- =



platform              | arch  | lab         | compiler | defconfig | regres=
sions
----------------------+-------+-------------+----------+-----------+-------=
-----
kontron-kbox-a-230-ls | arm64 | lab-kontron | gcc-10   | defconfig | 1     =
     =


  Details:     https://kernelci.org/test/plan/id/63598f4aca3d9849d3e7db98

  Results:     94 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.1-rc2-12-g77db83=
0e1d3a3/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-kbox-a-230-ls.t=
xt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.1-rc2-12-g77db83=
0e1d3a3/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-kbox-a-230-ls.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20221024.1/arm64/rootfs.cpio.gz =



  * baseline.bootrr.mscc_felix-probed: https://kernelci.org/test/case/id/63=
598f4aca3d9849d3e7dba1
        failing since 141 days (last pass: v5.18-rc7-183-g45785e0ed597, fir=
st fail: v5.19-rc1-2-g6a8964e282382)

    2022-10-26T19:49:11.265334  /lava-191754/1/../bin/lava-test-case
    2022-10-26T19:49:11.265637  <8>[   13.822545] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmscc_felix-probed RESULT=3Dfail>
    2022-10-26T19:49:11.265786  /lava-191754/1/../bin/lava-test-case
    2022-10-26T19:49:11.265924  <8>[   13.839135] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dleds-gpio-driver-present RESULT=3Dpass>
    2022-10-26T19:49:11.266062  /lava-191754/1/../bin/lava-test-case
    2022-10-26T19:49:11.266194  <8>[   13.855278] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dleds-gpio-probed RESULT=3Dpass>
    2022-10-26T19:49:11.266325  /lava-191754/1/../bin/lava-test-case   =

 =20
