Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 485AF41CF8F
	for <lists+linux-pm@lfdr.de>; Thu, 30 Sep 2021 00:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347324AbhI2W62 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 Sep 2021 18:58:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345988AbhI2W60 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 29 Sep 2021 18:58:26 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F253CC06161C
        for <linux-pm@vger.kernel.org>; Wed, 29 Sep 2021 15:56:44 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id on12-20020a17090b1d0c00b001997c60aa29so649443pjb.1
        for <linux-pm@vger.kernel.org>; Wed, 29 Sep 2021 15:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=5icUdSFaD3MPJdiyHY01W4BIx5GCDcZl0ERvqvSVajI=;
        b=VbywYhcx9zWmBaxHcuVHPenQEFzgas/7U/HLmxWwkRwpof25farMBWCIqF5QZjqOnZ
         vjupNIjpgXksRpDOiS3wMSntHHXVaVC55BQaVWZg1SlVNqpRuas/6nPRXmE5au80GLHc
         /VU/uXrFPQ6p9f1wl2WFdbqsbVhXHa+YK+VArm23LAkcDLH7v7VyyLGzdZpImnqth/cX
         V/U7G/wCZIH71IcVEX3RbPnlPgeRP2fqbJ645hBcUR3UcKA0pRqDB2Vg8oKRNl5dJ2yX
         B3B7HlsXOyazfJzTaRY5QwqUboPGN5Kv/YQM75Zb8mV3emlP8R0k6Zf+1HX9Z2ju5fUS
         Of0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=5icUdSFaD3MPJdiyHY01W4BIx5GCDcZl0ERvqvSVajI=;
        b=ObROX1K7XQROiw2cD1aofN+KJctS0pCkpRxLWL6xMOWGo/uDnIkkTHy8b21+wzH0ut
         g4hWR+3hsV1w4d43FvovJuEs1oAY5Wn12jR0izQ4Q4HcRAb/f+CO6e/shw+0GkKfRLkt
         2a42J6OVmM76WRw/PV7b1JFAeNxiJcTtj/I3TwsLTl5jl95k86Pf8CLQnEYzcBIkAWeh
         0o17DDQ9CvkY9fZyP3c7ZEIC1RPaXFNecA/2bZAlGb7ymj4E54oXWC8/kYHGwVrhfvqD
         IFpQynzIVrJ5LzW4iFMYjf4/Zz6zC29eqDQLabm7BfNVXwS9bgPmntxaZgemn3kyyMTF
         C0EQ==
X-Gm-Message-State: AOAM532fK5HSDgVNfHrJi13kKSLQwbXX3wJFeeJIAmIlXAIPZFQTtUIq
        Oqmpit8PfM7UTErtPLooMWQ4FQuALbB9cAbMfRE=
X-Google-Smtp-Source: ABdhPJyw8u1duRNbW8gygBx6dmzz55dwrva/vdaZY5JHasOTK82hxloMJ7Dg5EhPqdeQJuRecIcbbg==
X-Received: by 2002:a17:903:2403:b0:13d:cef7:61f1 with SMTP id e3-20020a170903240300b0013dcef761f1mr956008plo.48.1632956204564;
        Wed, 29 Sep 2021 15:56:44 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id ci18sm621019pjb.11.2021.09.29.15.56.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Sep 2021 15:56:44 -0700 (PDT)
Message-ID: <6154ef2c.1c69fb81.23ebe.296a@mx.google.com>
Date:   Wed, 29 Sep 2021 15:56:44 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.15-rc3-23-gd91db9b878c3
X-Kernelci-Report-Type: test
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
Subject: pm/testing sleep: 5 runs, 1 regressions (v5.15-rc3-23-gd91db9b878c3)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing sleep: 5 runs, 1 regressions (v5.15-rc3-23-gd91db9b878c3)

Regressions Summary
-------------------

platform        | arch  | lab           | compiler | defconfig | regressions
----------------+-------+---------------+----------+-----------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-8    | defconfig | 1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.15-rc=
3-23-gd91db9b878c3/plan/sleep/

  Test:     sleep
  Tree:     pm
  Branch:   testing
  Describe: v5.15-rc3-23-gd91db9b878c3
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      d91db9b878c32d8a746d69b30925174081c951d4 =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig | regressions
----------------+-------+---------------+----------+-----------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-8    | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/6154e2a16391c69b8099a2dc

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.15-rc3-23-gd91db=
9b878c3/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.15-rc3-23-gd91db=
9b878c3/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2021=
0913.0/arm64/rootfs.cpio.gz =



  * sleep.login: https://kernelci.org/test/case/id/6154e2a16391c69b8099a2dd
        failing since 406 days (last pass: v5.8-107-gb72b3ea38c81, first fa=
il: v5.9-rc1-4-g1f08d51cd57f) =

 =20
