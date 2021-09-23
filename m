Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D6BB416720
	for <lists+linux-pm@lfdr.de>; Thu, 23 Sep 2021 23:09:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243221AbhIWVL0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 23 Sep 2021 17:11:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243174AbhIWVLZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 23 Sep 2021 17:11:25 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03D80C061574
        for <linux-pm@vger.kernel.org>; Thu, 23 Sep 2021 14:09:54 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id bb10so4855609plb.2
        for <linux-pm@vger.kernel.org>; Thu, 23 Sep 2021 14:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=fKQczvPu6k3KZ6cEFfgUHIL08SdgtINdcbrYnz37040=;
        b=7N/CxYCeETCihgx8/BQwUUZXii9UCMWf0PC2zcUpWWfUoFuM+vyO4AeGcaLZX+aY6p
         62JPJ+mLC6sG/dB+xLkPJJOk+3dWRQpMwr0s/V2I15szOpIVUlbszHyHo0Li2LnEdaJg
         DdST8sTym4ZYxOmftFdCEfLHEifl3iN+ywKGKOkJruKOurV3NyEPLVt3ttBJW3gDZhNW
         qiHJqMQGBD9qssKmJY5l15XCpzXvMI7mCorI2/GsY8TuwfM1671l7U3cGWyMCoHLnN4E
         eC+pkgtfAh3QJwuXmWbJtcGrDwww0oOV80BCp6ZdKphNfRuunTDYqQ7hGgHaIamyGz1U
         yinw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=fKQczvPu6k3KZ6cEFfgUHIL08SdgtINdcbrYnz37040=;
        b=zy/WFBuqUHnuJYDZ7dl0ei2dZF0k1I+tRGJXMu/xAxj5V127y12Mtgi+hw59YS7kVA
         38EbKXIoswLVLCwSob1IdHIHfRUhTYKlL5JhFUDWJMEqcEl2FY2y9WGftE1U8aRuXzRQ
         S9Lhb5dCFnFWNg9M1nYSgUUHeTqitlM1abtTj1hKM8wpM84S/oRQJsmaDq3pThRsRoF/
         5SGX6lQHQviDvefuZKJqa6NoNKs3sCypQAa8CMtlANd+dLh+aAzzgF1qCO0CHZ5Kn2UG
         XsZZb+nQGUkcwQUUCml5hLiWlv/iV8FyoNGH5oTTN/DK7X3u/nJpvRglm1sNxOQ0JnSn
         oLYw==
X-Gm-Message-State: AOAM530/F7DPW8vdNBbfmJD3ugqx6iSKnFl680+b0XUBFbBRNwdB7kBi
        j1MafRXGysQ/qehhc9N/9D7JIsqtVYlOIv5f
X-Google-Smtp-Source: ABdhPJwW1x0E/kP+UA4wsQmPOKnoF95pSnbKu7ccu3WXMn6ESQVlYg+2Ghv3/Cx7DPa4MIO4cNC5ZA==
X-Received: by 2002:a17:90a:ce85:: with SMTP id g5mr20204108pju.196.1632431393371;
        Thu, 23 Sep 2021 14:09:53 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id w11sm7060886pgf.5.2021.09.23.14.09.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 14:09:53 -0700 (PDT)
Message-ID: <614ced21.1c69fb81.4529d.654e@mx.google.com>
Date:   Thu, 23 Sep 2021 14:09:53 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.15-rc2-12-g9fa78c37a2e3
X-Kernelci-Report-Type: test
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
Subject: pm/testing sleep: 4 runs, 2 regressions (v5.15-rc2-12-g9fa78c37a2e3)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing sleep: 4 runs, 2 regressions (v5.15-rc2-12-g9fa78c37a2e3)

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


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.15-rc=
2-12-g9fa78c37a2e3/plan/sleep/

  Test:     sleep
  Tree:     pm
  Branch:   testing
  Describe: v5.15-rc2-12-g9fa78c37a2e3
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      9fa78c37a2e340ea8d57b78ae9379a4110a70515 =



Test Regressions
---------------- =



platform         | arch  | lab           | compiler | defconfig | regressio=
ns
-----------------+-------+---------------+----------+-----------+----------=
--
mt8173-elm-hana  | arm64 | lab-collabora | gcc-8    | defconfig | 1        =
  =


  Details:     https://kernelci.org/test/plan/id/614cde78d0b54a05da99a2fa

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.15-rc2-12-g9fa78=
c37a2e3/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.15-rc2-12-g9fa78=
c37a2e3/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2021=
0913.0/arm64/rootfs.cpio.gz =



  * sleep.login: https://kernelci.org/test/case/id/614cde78d0b54a05da99a2fb
        failing since 400 days (last pass: v5.8-107-gb72b3ea38c81, first fa=
il: v5.9-rc1-4-g1f08d51cd57f) =

 =



platform         | arch  | lab           | compiler | defconfig | regressio=
ns
-----------------+-------+---------------+----------+-----------+----------=
--
rk3399-gru-kevin | arm64 | lab-collabora | gcc-8    | defconfig | 1        =
  =


  Details:     https://kernelci.org/test/plan/id/614cdf5c98e886cea799a30b

  Results:     12 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.15-rc2-12-g9fa78=
c37a2e3/arm64/defconfig/gcc-8/lab-collabora/sleep-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.15-rc2-12-g9fa78=
c37a2e3/arm64/defconfig/gcc-8/lab-collabora/sleep-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2021=
0913.0/arm64/rootfs.cpio.gz =



  * sleep.rtcwake-mem-2: https://kernelci.org/test/case/id/614cdf5c98e886ce=
a799a315
        new failure (last pass: v5.15-rc1-5-g7f2d17677d02)

    2021-09-23T20:06:01.403617  rtcwake: assuming RTC uses UTC ...
    2021-09-23T20:06:01.413520  rtcwake: wakeup from \"mem\" using rtc0 at =
Thu Sep 23 18:36:10 2021
    2021-09-23T20:06:01.425369  <6>[   23.087237] PM: suspend entry (deep)
    2021-09-23T20:06:01.441400  <6>[   23.103579] Filesystems sync: 0.000 s=
econds
    2021-09-23T20:06:01.463325  <6>[   23.119738] Freezing user space proce=
sses ... (elapsed 0.001 seconds) done.
    2021-09-23T20:06:01.472791  <6>[   23.136338] OOM killer disabled.
    2021-09-23T20:06:01.490400  <6>[   23.145245] Freezing remaining freeza=
ble tasks ... (elapsed 0.001 seconds) done.
    2021-09-23T20:06:01.501384  <6>[   23.159708] printk: Suspending consol=
e(s) (use no_console_suspend to debug)
    2021-09-23T20:06:02.529402  <3>[   23.174633] mwifiex_pcie 0000:01:00.0=
: adapter is not valid
    2021-09-23T20:06:02.543537  <4>[   23.289664] xhci-hcd xhci-hcd.15.auto=
: WARN: xHC CMD_RUN timeout =

    ... (11 line(s) more)  =

 =20
