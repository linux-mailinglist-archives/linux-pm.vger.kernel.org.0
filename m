Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC44A6CF16A
	for <lists+linux-pm@lfdr.de>; Wed, 29 Mar 2023 19:49:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229486AbjC2Rtj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 Mar 2023 13:49:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjC2Rtj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 29 Mar 2023 13:49:39 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0DCA191
        for <linux-pm@vger.kernel.org>; Wed, 29 Mar 2023 10:49:37 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id jy12so675739plb.8
        for <linux-pm@vger.kernel.org>; Wed, 29 Mar 2023 10:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112; t=1680112177;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=gL2IQG+0n7YcrKqCSc1jqrNHvX04VOBC23XWuvNSkvk=;
        b=26+d9MmPM8NV1JzMyjBsaFm81fjugbO+uToDR0VE7jPIIFXhLGfHB+dB67N0eJpMWM
         9tMwuPc6uoi1KgY0dCZaWkwdLpGVxTDYTvw7FLs2X3Tx2d58hYWquJj9u8uSK13f3wWj
         Meu+uIDvyny8aTzDwvPm98DbKJCB3pSxgZIQZ8mAy6fZcUPQoFs1pJj+41XDqbxRITiI
         r/iCIOV7OGuL+kCzvHI489HUHwIaI4KuXNAo+LUGcs4hkNlId+eZZjD1CqXOrVFn2TdB
         yMFowqeIaiGZmOHlt37tGEsW74R9lGEfVLRyjqKaOurkC/npvqk9coXwcrnV/EW7n2Zf
         hslg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680112177;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gL2IQG+0n7YcrKqCSc1jqrNHvX04VOBC23XWuvNSkvk=;
        b=hDhpJ01SgpplfYRV7jWdFQgDcPJSlhXAzFjgxNjrTnBhc4y5DbhTXMqvp9Hc2moIM8
         YNI+YYQqUFeVFEWeLJkvZQpLff5M1cIjZV93jrVVDdOilpSQSVHuCJjQrWfwzwFj9Y8O
         YsTMOaTaK/rqw+Doi+U8s8sWXK00uQfVGAj1KaI9H1KnAYH8nTu97GB0sBZ9+XONv9T/
         ZeMmFx3nCVrb3eqH53HJ+xIZ6oFchukgA8lNRjdZG2isf1wUnd0rRSRtKQ0Dr/B8UB7M
         FG/WXzpdcjOPb4BDW5H2y1zoVSo01FSkwfnXetCVUA4CzHcfuuzFOjANIrePwUnHuxjn
         3twA==
X-Gm-Message-State: AAQBX9dDq9jb5xCYAD5y83RqonB2RIuHK+XoMAw/kARkswQagVVUKnPD
        9aQ2ek7Mg5H96mjLCf77gzvwEg==
X-Google-Smtp-Source: AKy350ZYXEzrOXfoQNU182Zr3ybUNvFL5iVgNx0Oy9+lvkoMhajxNNZUAL3hOX1Bq7Fh07n7aF2yHA==
X-Received: by 2002:a17:902:e0c5:b0:1a2:1a5b:cc69 with SMTP id e5-20020a170902e0c500b001a21a5bcc69mr14827414pla.32.1680112177458;
        Wed, 29 Mar 2023 10:49:37 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id h21-20020a170902f7d500b001a21b871824sm10259027plw.119.2023.03.29.10.49.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 10:49:37 -0700 (PDT)
Message-ID: <64247a31.170a0220.7de7c.2991@mx.google.com>
Date:   Wed, 29 Mar 2023 10:49:37 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.3-rc4-59-gb6c50a785821
Subject: pm/testing baseline: 57 runs,
 1 regressions (v6.3-rc4-59-gb6c50a785821)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 57 runs, 1 regressions (v6.3-rc4-59-gb6c50a785821)

Regressions Summary
-------------------

platform        | arch  | lab     | compiler | defconfig | regressions
----------------+-------+---------+----------+-----------+------------
fsl-lx2160a-rdb | arm64 | lab-nxp | gcc-10   | defconfig | 1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v6.3-rc4=
-59-gb6c50a785821/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v6.3-rc4-59-gb6c50a785821
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      b6c50a7858215b7aea9958979c0c15f2f98de0fb =



Test Regressions
---------------- =



platform        | arch  | lab     | compiler | defconfig | regressions
----------------+-------+---------+----------+-----------+------------
fsl-lx2160a-rdb | arm64 | lab-nxp | gcc-10   | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/64246e1e01a3b9bf4062f7a1

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.3-rc4-59-gb6c50a=
785821/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-lx2160a-rdb.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.3-rc4-59-gb6c50a=
785821/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-lx2160a-rdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230324.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64246e1e01a3b9bf4062f7a4
        failing since 13 days (last pass: v6.1-rc5-55-g60453df62d30, first =
fail: v6.3-rc2-33-g1240ce78c05e)

    2023-03-29T16:57:47.138232  [   13.214727] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1189348_1.5.2.4.1>
    2023-03-29T16:57:47.242618  / # #
    2023-03-29T16:57:47.343898  export SHELL=3D/bin/sh
    2023-03-29T16:57:47.344303  #
    2023-03-29T16:57:47.445488  / # export SHELL=3D/bin/sh. /lava-1189348/e=
nvironment
    2023-03-29T16:57:47.445896  =

    2023-03-29T16:57:47.546953  / # . /lava-1189348/environment/lava-118934=
8/bin/lava-test-runner /lava-1189348/1
    2023-03-29T16:57:47.547462  =

    2023-03-29T16:57:47.549106  / # /lava-1189348/bin/lava-test-runner /lav=
a-1189348/1
    2023-03-29T16:57:47.573652  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =20
