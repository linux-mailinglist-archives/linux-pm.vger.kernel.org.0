Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D11FB3A725A
	for <lists+linux-pm@lfdr.de>; Tue, 15 Jun 2021 01:09:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbhFNXLT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 14 Jun 2021 19:11:19 -0400
Received: from mail-pj1-f44.google.com ([209.85.216.44]:44728 "EHLO
        mail-pj1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbhFNXLS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 14 Jun 2021 19:11:18 -0400
Received: by mail-pj1-f44.google.com with SMTP id h12-20020a17090aa88cb029016400fd8ad8so1025428pjq.3
        for <linux-pm@vger.kernel.org>; Mon, 14 Jun 2021 16:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=/5uhm1ti1UZaYbneQvvMBHrgIUWTapT57hl/ZWXoMI8=;
        b=NKp9RexXG7PsdM60WUFu54nsWk8Ayw87j0KWPZWH/dh79FsLBF5yLnqm6QTfh6V4ez
         sERlCvBG+7f960vp3ZTP1VepGCN1OwMD4Bn0dP41j6RK523So856oV5rrN7cYOc5rHBN
         zzxU4ZmYnIt1tvahMj/bqrrMLP6SSById6YiF7tCkKEaONLaQ5T4BtRuFPgqx4RCPFt1
         Y8G2t0lM93rnDi/ywFNXNKXH/7p5IRfXs0+J4CA58+zUg096U/hlmOwshpd1IvCIiIW4
         Q00Gcqu5Lp100AV9YxfI7IYUrOZknyTdPs1uJTPIdPuKpY5kPVOIxVGTHmjMehRMpZUE
         BO/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=/5uhm1ti1UZaYbneQvvMBHrgIUWTapT57hl/ZWXoMI8=;
        b=nwWm10xD4GIXQlBoLqBywVHGtbBzXQ83ZXVh6e3fWDsmxPpJ393nj5FMManlHS+LHz
         OR1+fCfPVrZxCKtl+53yQ8DVP1QeEC4Z0UW66yqobMCOb1aLGhe3Ol2SL5ysCe9w/hpY
         J9PuaaIINwqA/SA1DZFpwXDCumED4J26VIutv8JjHVieLz93uRxstlKpX9bnReIHVo0E
         6JE2mvRAVlwClaGgOI7OjQKzXKiAXfanlXhtCMRrMKKlyU46clnd2KM9eLF96njcPrC/
         WkKQw875lxYVVXdOXIuohKT5HjsPDa3eH1hSf8fzoqSu2irt+cf9dhfph8ZMrbWuNk6V
         JHFg==
X-Gm-Message-State: AOAM532Msvm1qTQ2iZcLcV0soecRWFEFa4lDWzYbOpMeQ1uoU+7P/qQy
        GFT/mem13GVSDPmHI3Ji6d2yiPi2Z5AyP9lt
X-Google-Smtp-Source: ABdhPJy+QO5oRp1EyKCUiF735n+QpsJTfZPpOCZsQTaflJKMas2FWW1suE456SsmODMaQlF5sMjVmg==
X-Received: by 2002:a17:902:dace:b029:11c:8c9d:c15a with SMTP id q14-20020a170902daceb029011c8c9dc15amr1451895plx.40.1623712081938;
        Mon, 14 Jun 2021 16:08:01 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id p7sm14036987pfb.45.2021.06.14.16.08.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 16:08:01 -0700 (PDT)
Message-ID: <60c7e151.1c69fb81.b21e6.9bd0@mx.google.com>
Date:   Mon, 14 Jun 2021 16:08:01 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.13-rc6-116-ga206065a8406
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
Subject: pm/testing baseline: 81 runs,
 2 regressions (v5.13-rc6-116-ga206065a8406)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 81 runs, 2 regressions (v5.13-rc6-116-ga206065a8406)

Regressions Summary
-------------------

platform        | arch  | lab          | compiler | defconfig | regressions
----------------+-------+--------------+----------+-----------+------------
imx8mp-evk      | arm64 | lab-nxp      | gcc-8    | defconfig | 1          =

meson-gxbb-p200 | arm64 | lab-baylibre | gcc-8    | defconfig | 1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.13-rc=
6-116-ga206065a8406/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v5.13-rc6-116-ga206065a8406
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      a206065a840616e966a96a148a690b169746b642 =



Test Regressions
---------------- =



platform        | arch  | lab          | compiler | defconfig | regressions
----------------+-------+--------------+----------+-----------+------------
imx8mp-evk      | arm64 | lab-nxp      | gcc-8    | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/60c7d9292765de2c49413280

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.13-rc6-116-ga206=
065a8406/arm64/defconfig/gcc-8/lab-nxp/baseline-imx8mp-evk.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.13-rc6-116-ga206=
065a8406/arm64/defconfig/gcc-8/lab-nxp/baseline-imx8mp-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-5-g2f114cc7102b/arm64/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/60c7d9292765de2c49413=
281
        failing since 7 days (last pass: acpi-5.13-rc5-42-ga25ea0c642c2, fi=
rst fail: v5.13-rc5-37-gfcbef3bdf3a8) =

 =



platform        | arch  | lab          | compiler | defconfig | regressions
----------------+-------+--------------+----------+-----------+------------
meson-gxbb-p200 | arm64 | lab-baylibre | gcc-8    | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/60c7d8907b496d63f3413271

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.13-rc6-116-ga206=
065a8406/arm64/defconfig/gcc-8/lab-baylibre/baseline-meson-gxbb-p200.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.13-rc6-116-ga206=
065a8406/arm64/defconfig/gcc-8/lab-baylibre/baseline-meson-gxbb-p200.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-5-g2f114cc7102b/arm64/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/60c7d8907b496d63f3413=
272
        new failure (last pass: v5.13-rc5-112-gfce7d470d0dd) =

 =20
