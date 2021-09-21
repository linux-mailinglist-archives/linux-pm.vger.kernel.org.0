Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F764413A4D
	for <lists+linux-pm@lfdr.de>; Tue, 21 Sep 2021 20:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231775AbhIUSuI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 21 Sep 2021 14:50:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231720AbhIUSuH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 21 Sep 2021 14:50:07 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39786C061574
        for <linux-pm@vger.kernel.org>; Tue, 21 Sep 2021 11:48:39 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id c1so355839pfp.10
        for <linux-pm@vger.kernel.org>; Tue, 21 Sep 2021 11:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=es5kz3tj3hxVEMnQfXxZLdJf6NY2dEQHiePwiJ5xv5s=;
        b=q+kj/kVAd9yUFM6uoe4M2yUvhsHIepETb2KM+p9/frHgdTTVfaIXPzeJpdnYWDq5/a
         BR27i1xSld7YBu/gEtWna2UcDqVqXkXNgZZ5BzfJ4sIDb+Pf3wHtH/MargA3BPNltp5i
         BwuNxjzOpLrPA7Bmr64dmj+fXfbgvdm/QiTNYoanCJ05JQaY19iR4085P57B+vnEposB
         BRRXlv8FCViota3U1FPH3sz/hVxKcpAyg0mgQzWyCPBuB+TNt72QZoIijuQzQgCaJ+Ln
         u6vgT+upk9thgTPbqfA0U4pjDFGrvE+DlNjntsLcEcUv5RysygvklEotpH9BOGBcybCP
         vtfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=es5kz3tj3hxVEMnQfXxZLdJf6NY2dEQHiePwiJ5xv5s=;
        b=RYiWYoEuhUA+x5ZK0MAV4OjIq8czgREVOXH9y9xnIb4aJqqiFMlM0yHQtC7wu58act
         4QnfZJ+h/G0UTf3juHDIEMmvvK95i/KiSlJFgDOVJdmTIyEX5t5yRCcxppfgaOD3iFUL
         GT7xz+z7u9HdNi+8FTpsfzZXDU9yarreXYcDdNzEjm9eSuoXDKLdOW/uRDhj9FnRuKnx
         MHVZrRFjY6XBwCo2y+LJyId8SN9LZbt7xWikZFk1pHK/y5hoWKWOLMhUN2sbX2TKdKMj
         3w5hizpo8TjRO5jWR+lLgcVvIoGkrl6XivEgE3IIY800ULyVM9xx9gfPwgDaJIe14ObO
         Un0Q==
X-Gm-Message-State: AOAM530YJ2dHCPk36paT0OH57l3ziZb70HB4WN0+syQJ5zavMt36bf7s
        278RIwla+KLxSf30flF1bLUwLQ==
X-Google-Smtp-Source: ABdhPJzz5EH5MSpvcPNS5nrVYRXI0S3mCV66yD0ES8Hdy3Q8/00eBITlZFSI/w+De8koKuSC6JBapA==
X-Received: by 2002:aa7:9a0e:0:b0:44a:3ae2:825c with SMTP id w14-20020aa79a0e000000b0044a3ae2825cmr2332499pfj.28.1632250118761;
        Tue, 21 Sep 2021 11:48:38 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id p2sm3263420pja.51.2021.09.21.11.48.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 11:48:38 -0700 (PDT)
Message-ID: <614a2906.1c69fb81.2202b.be51@mx.google.com>
Date:   Tue, 21 Sep 2021 11:48:38 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.15-rc2-10-g163807478ffd
X-Kernelci-Report-Type: test
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
Subject: pm/testing baseline: 46 runs,
 1 regressions (v5.15-rc2-10-g163807478ffd)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 46 runs, 1 regressions (v5.15-rc2-10-g163807478ffd)

Regressions Summary
-------------------

platform  | arch | lab          | compiler | defconfig          | regressio=
ns
----------+------+--------------+----------+--------------------+----------=
--
beagle-xm | arm  | lab-baylibre | gcc-8    | multi_v7_defconfig | 1        =
  =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.15-rc=
2-10-g163807478ffd/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v5.15-rc2-10-g163807478ffd
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      163807478ffdb2ab198066e36d25d516e20544b9 =



Test Regressions
---------------- =



platform  | arch | lab          | compiler | defconfig          | regressio=
ns
----------+------+--------------+----------+--------------------+----------=
--
beagle-xm | arm  | lab-baylibre | gcc-8    | multi_v7_defconfig | 1        =
  =


  Details:     https://kernelci.org/test/plan/id/614a1a0c7ce9cf51a899a2df

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.15-rc2-10-g16380=
7478ffd/arm/multi_v7_defconfig/gcc-8/lab-baylibre/baseline-beagle-xm.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.15-rc2-10-g16380=
7478ffd/arm/multi_v7_defconfig/gcc-8/lab-baylibre/baseline-beagle-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-6-g8983f3b738df/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/614a1a0c7ce9cf51a899a=
2e0
        failing since 46 days (last pass: v5.14-rc3-20-g604483c9d252, first=
 fail: v5.14-rc4-28-g9ac32de19606) =

 =20
