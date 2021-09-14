Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2851640A253
	for <lists+linux-pm@lfdr.de>; Tue, 14 Sep 2021 03:07:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236871AbhINBId (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 Sep 2021 21:08:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230404AbhINBIc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 Sep 2021 21:08:32 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7783EC061574
        for <linux-pm@vger.kernel.org>; Mon, 13 Sep 2021 18:07:16 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id me5-20020a17090b17c500b0019af76b7bb4so160576pjb.2
        for <linux-pm@vger.kernel.org>; Mon, 13 Sep 2021 18:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=v8IVQfdyAm//bzKqL9x2OOCLhgnEtncXq8O+BtxktiI=;
        b=Do6Ky/EwldlHmhuAr9dB39fwiudDagGPH6ho2oyrhfRUUAZ1lbnrYy9WT1Tt7rqv0S
         T4QTaNXRmOC/JVUlpRX1jzy/MbWK4RqXxKLqr9uyuqhPwJ8m1QMF17WWvCsDsOCLeXCO
         2io+f4N/PvCj3bjDC47oZReTv6m2yERkHxi1A0b6DtICqDpM1/M5UuGh57eYqP42UJnT
         9lerWG9AYb/L821I/KLCfWueLNRQWLlGqulKgFSMcGlTBXGQVmTQHnZqGNoMsZR9+xRM
         lGj8obc1YwGEeQKcczLLQMQ8a3DwUsrJNfRjq7Z3J9UzRdk+wqsKqhYMiOfSX7/S0P6f
         FJ8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=v8IVQfdyAm//bzKqL9x2OOCLhgnEtncXq8O+BtxktiI=;
        b=4Qv+qQCKIR2+EDzEY26xRhJQbJ8C5fbogC+0BeVmrmY+YrUmdEhsV6gfa0odAiSBO8
         qlDr3i4ByL9wFvwQg/y/tx/LqqJHKO5k/ncHX/VEIXwNXHR7ldaAbNdBDl2c3YDLapBO
         yZwrOYSloaIZowgJ+CAVaS9pKBGyKlFcUE/mwuXVZ8ezmy/1sYGybHkED+rlgi6QX0Cx
         q6/4GHgo38hILeww3mQBg22BPtw+ba6+0+xd9Roi2q1fLdgKcqxBWZzUXd55M7mgZGiR
         PFQnf/bRdSgnwEGtLcl8jkY3rTsTCKL17VGX/cLNKh29baxMu+YFv71NVmYBx9gH0ipM
         vwqA==
X-Gm-Message-State: AOAM533piZwYNZBofYFYuBTwUCjt7LjA8YNRCT6EIUS1h0PyuLlz3/ZA
        QFYClerK7jLDFcm3q0yrsV0iwQ==
X-Google-Smtp-Source: ABdhPJxGJmvhiLvfOqJDZ7sqkKxBq2rbe0n2xE1gKAbTApowccrM+iW/tW2Cic9tdjc2+OmVCkeiOQ==
X-Received: by 2002:a17:902:e144:b0:13b:96ee:ad48 with SMTP id d4-20020a170902e14400b0013b96eead48mr6364294pla.26.1631581636013;
        Mon, 13 Sep 2021 18:07:16 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id e2sm8349245pfn.141.2021.09.13.18.07.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 18:07:15 -0700 (PDT)
Message-ID: <613ff5c3.1c69fb81.295e1.865f@mx.google.com>
Date:   Mon, 13 Sep 2021 18:07:15 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.15-rc1
X-Kernelci-Report-Type: test
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
Subject: pm/testing sleep: 4 runs, 1 regressions (v5.15-rc1)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing sleep: 4 runs, 1 regressions (v5.15-rc1)

Regressions Summary
-------------------

platform        | arch  | lab           | compiler | defconfig | regressions
----------------+-------+---------------+----------+-----------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-8    | defconfig | 1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.15-rc=
1/plan/sleep/

  Test:     sleep
  Tree:     pm
  Branch:   testing
  Describe: v5.15-rc1
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      6880fa6c56601bb8ed59df6c30fd390cc5f6dd8f =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig | regressions
----------------+-------+---------------+----------+-----------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-8    | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/613fe880a5d386ec0499a2db

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.15-rc1/arm64/def=
config/gcc-8/lab-collabora/sleep-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.15-rc1/arm64/def=
config/gcc-8/lab-collabora/sleep-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2021=
0827.0/arm64/rootfs.cpio.gz =



  * sleep.login: https://kernelci.org/test/case/id/613fe880a5d386ec0499a2dc
        failing since 390 days (last pass: v5.8-107-gb72b3ea38c81, first fa=
il: v5.9-rc1-4-g1f08d51cd57f) =

 =20
