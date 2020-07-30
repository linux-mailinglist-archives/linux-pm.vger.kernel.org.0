Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 363362339D2
	for <lists+linux-pm@lfdr.de>; Thu, 30 Jul 2020 22:38:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730534AbgG3Uhy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 30 Jul 2020 16:37:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728745AbgG3Uhy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 30 Jul 2020 16:37:54 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26800C061574
        for <linux-pm@vger.kernel.org>; Thu, 30 Jul 2020 13:37:54 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id p1so15243633pls.4
        for <linux-pm@vger.kernel.org>; Thu, 30 Jul 2020 13:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=8aJJdI3bM5qE74zzgjWqYSYp/MK5j4Ur1pN1mdg1x8E=;
        b=qMP/es91P4TEccd5QEDVrWdIZ5bkXJa5nAcWuJ9eQ4GuhxEoLzMFPLPiTDsd46Aage
         K9Ie9jykgia9xHD1rx8n703IxZ4C50Gb+Es95tjZj1LuU+uc6qxhZ3ouh3qkupQKz1Ny
         Twvh0JWBkgX6niurjxx0jwxZrZ+acn3/tTqLcC2giRY+tYQsc0I579QD7nG6yH2BTRb+
         QzUqIZCbjZ1k64Gn8LD9OziOBhm2CmxfXjUL3GiHxlGl5wN9ERHEnm4J8Kg3O4gYVOKm
         BDcEWx1mnDmzdNnZD+dOJ0H1eW6nRrLmR9iUjjxG0y5yTMTL1jUv3WeuFRnn+kqx9s41
         qNWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=8aJJdI3bM5qE74zzgjWqYSYp/MK5j4Ur1pN1mdg1x8E=;
        b=c4V5JexmLrWH1meKOrfUuNFKajfCHBQjIXFU7h3wYc1wfGmd/wlilQkE8m57SCjkhx
         cOVHIUy+AuWxEBHe6+EdoQ8+dlauou86XG38KQse0ziC03mvsbch8fdId1y9rto3uDgl
         HHJb80U+Noi6oUhLfaNnXCQ/ug8l3W/gNwqgDyIEmNcijYnyMDNmC5mMAv+Z49cwTaL5
         3Q/WYdSdzJVmPR7rpPKAGTj683n7ThBlHfqTrS1BRwGjG6/mJcnUz2JQSeDpnF9nh6Q9
         s9XQpdgn37KlY8S4tRsFlM1dXBzRmS7gTmb2gqM67Ao9lyinayuPj8/9r4O24xd/U/HJ
         xQOw==
X-Gm-Message-State: AOAM530Cpm3lR0wqTFRmnuFpLgPPP3RkSNnrR5W03QET04euzRXa80Pa
        FXNSWQUX9N7X/kl5Wk1ZLen/hw==
X-Google-Smtp-Source: ABdhPJwZG7z4ssE3V/RGp3LnUULtUdHKXZ3nNjfTf4udavQCTG4GK8KzaVO9sCovz/Kv67aKmJKpMA==
X-Received: by 2002:aa7:9292:: with SMTP id j18mr675351pfa.128.1596141473520;
        Thu, 30 Jul 2020 13:37:53 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id f93sm6607414pjk.56.2020.07.30.13.37.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2020 13:37:52 -0700 (PDT)
Message-ID: <5f232fa0.1c69fb81.f632a.10c2@mx.google.com>
Date:   Thu, 30 Jul 2020 13:37:52 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.8-rc7-107-g97987ea7f86a
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
Subject: pm/testing baseline: 119 runs,
 1 regressions (v5.8-rc7-107-g97987ea7f86a)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 119 runs, 1 regressions (v5.8-rc7-107-g97987ea7f86a)

Regressions Summary
-------------------

platform             | arch  | lab          | compiler | defconfig | results
---------------------+-------+--------------+----------+-----------+--------
meson-gxl-s905d-p230 | arm64 | lab-baylibre | gcc-8    | defconfig | 0/1    =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.8-rc7=
-107-g97987ea7f86a/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v5.8-rc7-107-g97987ea7f86a
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      97987ea7f86a35284fd54efc7412db246f178666 =



Test Regressions
---------------- =



platform             | arch  | lab          | compiler | defconfig | results
---------------------+-------+--------------+----------+-----------+--------
meson-gxl-s905d-p230 | arm64 | lab-baylibre | gcc-8    | defconfig | 0/1    =


  Details:     https://kernelci.org/test/plan/id/5f2325e8101914532152c1d7

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.8-rc7-107-g97987=
ea7f86a/arm64/defconfig/gcc-8/lab-baylibre/baseline-meson-gxl-s905d-p230.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.8-rc7-107-g97987=
ea7f86a/arm64/defconfig/gcc-8/lab-baylibre/baseline-meson-gxl-s905d-p230.ht=
ml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05/arm64/baseline/rootfs.cpio.gz =


  * baseline.login: https://kernelci.org/test/case/id/5f2325e8101914532152c=
1d8
      new failure (last pass: v5.8-rc7-94-g89beac5dc8d0) =20
