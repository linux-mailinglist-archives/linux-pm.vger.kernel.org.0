Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70186316980
	for <lists+linux-pm@lfdr.de>; Wed, 10 Feb 2021 15:55:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbhBJOzH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 10 Feb 2021 09:55:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbhBJOzD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 10 Feb 2021 09:55:03 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 200E0C061574
        for <linux-pm@vger.kernel.org>; Wed, 10 Feb 2021 06:54:22 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id cv23so1233469pjb.5
        for <linux-pm@vger.kernel.org>; Wed, 10 Feb 2021 06:54:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=X9bRut3Lz+E69qkd4tDZdovz+jrcgE/rT7Uks3wEiuI=;
        b=xHYOwWJYiAn9tyAGM/dycNAWVBJWZGWjmzcayiizJvbk8DkBFhom8HwCFrpPOWCDbs
         nr2LyNt+ETD25aCykZI1CUWdgHg8gMZCH1TqApeKC0nm8XQ9Y4qQ5oIfQNtEzZ4jNReW
         NiPWTY92wyI8IZ53RlZGH1tHSKCcrdIXigVusbYM9W6512t8Snww8hUwaXbxbcqHSqgl
         H3/DjZ8kaRGtFUxz4M+DVwDAiMzg2v7T7kaklidt5zlNRWeIpYRKVt0yvHEhICI6j2uI
         NaoqoKUUYbnOxRx1gr5a/KOakU9WVru4Khw2cQ58Ixvdiv/Nnth4qStvNftNVWklQxs1
         dkZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=X9bRut3Lz+E69qkd4tDZdovz+jrcgE/rT7Uks3wEiuI=;
        b=ss4JVJaADoaTUwy8/VV/eVE/woyj/dYjtAC6rixxeg6YwGaAafokcKRBEes5gLfU1g
         hvTJlMphLFGQE63BP2e/r4P5ZQ7ecmSBQM81IPpjBxSqZc6IqI4h8CJCMb97n8gxvkA6
         ZdW/22cKtPYEdT8cKvQrviKgA+CguFLA3DMI87vZl5VVz9lWZk4B6aQqP51Fcp3de5s+
         iDvueY/MFKjAqQVDC0xjnMPfLu2t12eiWqTNzGuEoB3flPwkF4Bv3RETGyAGz4eQm0hE
         e7vgbaC6J5CkqGz6U8h/hyiEsEd6UcApQIcY/aDMHE/kUvE27tGOeejGKyU7yoMo+F3o
         /FZw==
X-Gm-Message-State: AOAM531HL66tXZinMUUe87lHkohn8DvydZOAMQtsn6FzVKmviYuSRSpY
        Xgb67taDnmLKVYunDlkz+UsKkw==
X-Google-Smtp-Source: ABdhPJwP8FyoRUNe1k5KcQvffp+zh90udHGutKDZ995sKL+TAzzadEWBZwQauLlmWeqGl8RPj2rESA==
X-Received: by 2002:a17:902:e8cb:b029:e2:9906:45a6 with SMTP id v11-20020a170902e8cbb02900e2990645a6mr3331975plg.41.1612968861684;
        Wed, 10 Feb 2021 06:54:21 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id b15sm2612210pfi.38.2021.02.10.06.54.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 06:54:21 -0800 (PST)
Message-ID: <6023f39d.1c69fb81.a45e3.5686@mx.google.com>
Date:   Wed, 10 Feb 2021 06:54:21 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.11-rc7-105-g32890f947002
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
Subject: pm/testing sleep: 4 runs, 1 regressions (v5.11-rc7-105-g32890f947002)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing sleep: 4 runs, 1 regressions (v5.11-rc7-105-g32890f947002)

Regressions Summary
-------------------

platform        | arch  | lab           | compiler | defconfig | regressions
----------------+-------+---------------+----------+-----------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-8    | defconfig | 1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.11-rc=
7-105-g32890f947002/plan/sleep/

  Test:     sleep
  Tree:     pm
  Branch:   testing
  Describe: v5.11-rc7-105-g32890f947002
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      32890f947002ed83bfa76ad73fae15393292a21a =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig | regressions
----------------+-------+---------------+----------+-----------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-8    | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/6023e6fa029a11f3283abf1c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.11-rc7-105-g3289=
0f947002/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.11-rc7-105-g3289=
0f947002/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2021=
0208.0/arm64/rootfs.cpio.gz =



  * sleep.login: https://kernelci.org/test/case/id/6023e6fa029a11f3283abf1d
        failing since 174 days (last pass: v5.8-107-gb72b3ea38c81, first fa=
il: v5.9-rc1-4-g1f08d51cd57f) =

 =20
