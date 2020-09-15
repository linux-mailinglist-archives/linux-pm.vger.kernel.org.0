Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CE1826AE20
	for <lists+linux-pm@lfdr.de>; Tue, 15 Sep 2020 21:52:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbgIOTwe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 15 Sep 2020 15:52:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727825AbgIORHz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 15 Sep 2020 13:07:55 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 232A3C061351
        for <linux-pm@vger.kernel.org>; Tue, 15 Sep 2020 09:57:39 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id c3so1661745plz.5
        for <linux-pm@vger.kernel.org>; Tue, 15 Sep 2020 09:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=RMBtx+N8rfyXlpE0k0ifH8sVhqMJoEQ3x/BGMNzKRfw=;
        b=kDfmKB6bB82yeM/GMZV+8OfXIpT8eh8ukHdb1oXY7uPqiAzF9rtDAig6fWnmEvP8Zn
         q6TQtul2Ow5lfzrxJwXCGmqxGNhtKMUkZ5RUXDU+ES6m51FGmkFvx8/F+XNAaUfgbY21
         rUO69w4zE/Bxj9nPRuqSHi2J939bAKGzND9G+dj0CmpY+0ychAaDbiAjCdUxuwmmbg7M
         KD9E/N3NRhZpqB02MBj3NKb9Ph8a3KdIY1CHvHEeCoNva870tb4+P3TDNY6R3hx1DZJ5
         KvOH04Nj7yiwr2VlIk4kko8eKBRVFbtoXiufhmQkU4j/HmCnKXBx8sQWBpgc88C0V1mz
         w0hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=RMBtx+N8rfyXlpE0k0ifH8sVhqMJoEQ3x/BGMNzKRfw=;
        b=NnQOZK2WlxjkuJx09WfH0/RSbjHQaPeJJ8wwcQo7S3AIKIeH63notEehrm3EyoGHbO
         H4RYaAbO4n72fYBujylEoe5dFFMFarcgU+fiXD/MPTSihQ9NI7dHL1FTAaBlBPC9LqKd
         K+uLzdssMbiwpFDNAUxGkktPtBYjUkWbFcSSb32aGn+S5bnDKAVBgjt3gxlYsVrPQP9C
         UdgRciZ+4ruuTvE5NAf2zOhrSNJpGuQRDA7tJ7WaIJORGREQ0w1MQtYhbyqQB56+45gS
         gdruDHzM6jq1Dzxw+ldCuky+XKEegMc1Cb86YfWDJk6zK4pIdAhMK+Agox4LclbMlFxV
         YYSA==
X-Gm-Message-State: AOAM531rM/eIjR/vJGE1ivsB+19SaTRID3X1Ozr81ceZKJ1ChnAkHh5m
        gmj+5BZMrpjHBYpswqY3oWNOTWrEyUUsjg==
X-Google-Smtp-Source: ABdhPJypOKcaPpjbNRDpdqO1TbALGLtahMaTQQN1C00GYFaKimbdCt009TDxcDp4Q3yLwKIeYKDLog==
X-Received: by 2002:a17:902:b410:b029:d1:920c:c22b with SMTP id x16-20020a170902b410b02900d1920cc22bmr9318427plr.28.1600189058314;
        Tue, 15 Sep 2020 09:57:38 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id s129sm13918163pfb.39.2020.09.15.09.57.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 09:57:37 -0700 (PDT)
Message-ID: <5f60f281.1c69fb81.1663.45e0@mx.google.com>
Date:   Tue, 15 Sep 2020 09:57:37 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.9-rc5
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
Subject: pm/testing baseline: 118 runs, 2 regressions (v5.9-rc5)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 118 runs, 2 regressions (v5.9-rc5)

Regressions Summary
-------------------

platform         | arch  | lab           | compiler | defconfig          | =
results
-----------------+-------+---------------+----------+--------------------+-=
-------
panda            | arm   | lab-collabora | gcc-8    | multi_v7_defconfig | =
4/5    =

rk3399-gru-kevin | arm64 | lab-collabora | gcc-8    | defconfig          | =
82/88  =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.9-rc5=
/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v5.9-rc5
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      856deb866d16e29bd65952e0289066f6078af773 =



Test Regressions
---------------- =



platform         | arch  | lab           | compiler | defconfig          | =
results
-----------------+-------+---------------+----------+--------------------+-=
-------
panda            | arm   | lab-collabora | gcc-8    | multi_v7_defconfig | =
4/5    =


  Details:     https://kernelci.org/test/plan/id/5f60e8815f9aa187c4bed953

  Results:     4 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.9-rc5/arm/multi_=
v7_defconfig/gcc-8/lab-collabora/baseline-panda.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.9-rc5/arm/multi_=
v7_defconfig/gcc-8/lab-collabora/baseline-panda.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05/armel/baseline/rootfs.cpio.gz =


  * baseline.dmesg.alert: https://kernelci.org/test/case/id/5f60e8815f9aa18=
7c4bed957
      failing since 26 days (last pass: v5.8-107-gb72b3ea38c81, first fail:=
 v5.9-rc1-4-g1f08d51cd57f)
      60 lines

    2020-09-15 16:14:51.305000  kern  :alert : BUG: Bad page state in proce=
ss swapper/0  pfn:9c802
    2020-09-15 16:14:51.310000  kern  :alert : BUG: Bad page state in proce=
ss swapper/0  pfn:9c803
    2020-09-15 16:14:51.316000  kern  :alert : BUG: Bad page state in proce=
ss swapper/0  pfn:9c804
    2020-09-15 16:14:51.322000  kern  :alert : BUG: Bad page state in proce=
ss swapper/0  pfn:9c805
    2020-09-15 16:14:51.328000  kern  :alert : BUG: Bad page state in proce=
ss swapper/0  pfn:9c806
    2020-09-15 16:14:51.334000  kern  :alert : BUG: Bad page state in proce=
ss swapper/0  pfn:9c807
    2020-09-15 16:14:51.340000  kern  :alert : BUG: Bad page state in proce=
ss swapper/0  pfn:9c808
    2020-09-15 16:14:51.346000  kern  :alert : BUG: Bad page state in proce=
ss swapper/0  pfn:9c809
    2020-09-15 16:14:51.352000  kern  :alert : BUG: Bad page state in proce=
ss swapper/0  pfn:9c80a
    2020-09-15 16:14:51.358000  kern  :alert : BUG: Bad page state in proce=
ss swapper/0  pfn:9c80b
    ... (49 line(s) more)
      =



platform         | arch  | lab           | compiler | defconfig          | =
results
-----------------+-------+---------------+----------+--------------------+-=
-------
rk3399-gru-kevin | arm64 | lab-collabora | gcc-8    | defconfig          | =
82/88  =


  Details:     https://kernelci.org/test/plan/id/5f60e8a0f377fb46b3bed959

  Results:     82 PASS, 6 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.9-rc5/arm64/defc=
onfig/gcc-8/lab-collabora/baseline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.9-rc5/arm64/defc=
onfig/gcc-8/lab-collabora/baseline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05/arm64/baseline/rootfs.cpio.gz =


  * baseline.bootrr.rockchip-dp-probed: https://kernelci.org/test/case/id/5=
f60e8a0f377fb46b3bed98c
      new failure (last pass: v5.9-rc4-6-g23818c154bae)

    2020-09-15 16:15:23.892000  /lava-2625562/1/../bin/lava-test-case
      =20
