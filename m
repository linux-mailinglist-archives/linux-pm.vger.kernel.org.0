Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E60536BCB6
	for <lists+linux-pm@lfdr.de>; Tue, 27 Apr 2021 02:46:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232295AbhD0Arc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 26 Apr 2021 20:47:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232022AbhD0Arb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 26 Apr 2021 20:47:31 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 988CEC061574
        for <linux-pm@vger.kernel.org>; Mon, 26 Apr 2021 17:46:49 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id s20so14054602plr.13
        for <linux-pm@vger.kernel.org>; Mon, 26 Apr 2021 17:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=bB8kvLNdI+MsDbYpt4liKVXQylu4eFriIHUl0HNoZfI=;
        b=rylARCN7Wogc7pM2twjde44C80d46xgocstzBkVrVlkwro5TjlbvJsopNst4jcKHxw
         6gvTTmmotsl50KeaueG1m5Hz+fctXfW+WPJ/OHZEfdWxBb+6lQBfJDI/5JeWXs4z9jff
         sqiSdGu2MMN8ytjyR579jSZSL3z2gzbEiOWnYTm91JWlmEiVv5Vl21PA+l5XDXLdBIRu
         pF4RG7N61Pt/f+MUx4nQ0wbXFoq9xpK/Bpg/cK82Up62O5gO1pNm4eXTPr9FMF3xegGC
         UJsX6HCj39f0JVveCdBy5g9bgXKA39OR9wfpqQmV2itVV4gM2Sw0RFouvr7rldkOR54e
         ZqHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=bB8kvLNdI+MsDbYpt4liKVXQylu4eFriIHUl0HNoZfI=;
        b=XBCVLByoa/dcAomShkqRA6boUj1A+fiE6PuEzeH4KpjxPC5jSzro3hbydIX2vVLAz9
         Y0q4+j2mP0RGaa9QUat3JqfELaArwV793fp3c/UH68xKVBbl5LoUPwEdSbdH+zK8jth6
         u3ZtqqE4dDxlak3wtxhKOFockTrXYb/2xrpZuK0Ol7DRz2BTk/jsbA9W6ObpH7+UCpAT
         ChSk5rJvWWOVb1xJC0P6c6EacN0fyz2ZJ84L9LHxfs4kKZmcuCwBJLXX/mCZMiiCQSYt
         q5cjmjRJUhgzK1go+0Qn3RaHPU8TumI0FeCMyWUrfEIA+dKxq8+wsDXrVDcGQIMVwgm1
         2CJQ==
X-Gm-Message-State: AOAM530chiBnyY1Zp3Y4RRpN64V8Pmr4iGt5GeVbn8IM1Y/G1TDCIoUp
        F6IEuKV8zY0KfKnxGI+9IXOS0A==
X-Google-Smtp-Source: ABdhPJx2Nl6hKKLLwVgNytRoHZt2L28N+EGmq7ZTE83C6w/JiYo9Sw5RcxbaZzMlExnxTqO0ysCFRA==
X-Received: by 2002:a17:90b:30c3:: with SMTP id hi3mr10788394pjb.235.1619484409256;
        Mon, 26 Apr 2021 17:46:49 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id o189sm697119pfb.215.2021.04.26.17.46.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Apr 2021 17:46:48 -0700 (PDT)
Message-ID: <60875ef8.1c69fb81.2d05a.3450@mx.google.com>
Date:   Mon, 26 Apr 2021 17:46:48 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.12-rc8-168-g3c44d15e5ffdb
X-Kernelci-Report-Type: test
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
Subject: pm/testing baseline: 113 runs,
 1 regressions (v5.12-rc8-168-g3c44d15e5ffdb)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 113 runs, 1 regressions (v5.12-rc8-168-g3c44d15e5ffdb)

Regressions Summary
-------------------

platform   | arch  | lab     | compiler | defconfig | regressions
-----------+-------+---------+----------+-----------+------------
imx8mp-evk | arm64 | lab-nxp | gcc-8    | defconfig | 1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.12-rc=
8-168-g3c44d15e5ffdb/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v5.12-rc8-168-g3c44d15e5ffdb
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      3c44d15e5ffdbc1b9d31d098b65c5cb50211d802 =



Test Regressions
---------------- =



platform   | arch  | lab     | compiler | defconfig | regressions
-----------+-------+---------+----------+-----------+------------
imx8mp-evk | arm64 | lab-nxp | gcc-8    | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/608756df3afa6a56759b779a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.12-rc8-168-g3c44=
d15e5ffdb/arm64/defconfig/gcc-8/lab-nxp/baseline-imx8mp-evk.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.12-rc8-168-g3c44=
d15e5ffdb/arm64/defconfig/gcc-8/lab-nxp/baseline-imx8mp-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-5-g2f114cc7102b/arm64/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/608756df3afa6a56759b7=
79b
        failing since 25 days (last pass: v5.12-rc5-47-g506a524e05e2, first=
 fail: v5.12-rc5-47-g85f34ae663986) =

 =20
