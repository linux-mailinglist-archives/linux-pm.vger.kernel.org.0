Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D7E62AE6BA
	for <lists+linux-pm@lfdr.de>; Wed, 11 Nov 2020 04:01:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725900AbgKKDBc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Nov 2020 22:01:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725839AbgKKDBc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Nov 2020 22:01:32 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28244C0613D1
        for <linux-pm@vger.kernel.org>; Tue, 10 Nov 2020 19:01:31 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id z24so515876pgk.3
        for <linux-pm@vger.kernel.org>; Tue, 10 Nov 2020 19:01:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=oJH/sevW+2dGwDLXNQp1WkALkE8Odl6i+qIiTAJ26Nk=;
        b=eSgJVqe71sb77VJcW6sY5Rb4tjgagGSJzZCDTDeZarslX3I2cP5s57ZmMyqK1LFuQV
         soqi5eM2LkVVhTiXqiHGo2rLu0/1FwGkeXkgZNjHvzWHibN+Stcn2Gcfi0mZTuwPYEAc
         Q/JoGc1liIvkRRhXePs0aPjfW8I32T3NMNHZoaJF5TwVEvW5HgDOEAY60u57LgyDgFiz
         LGDwfIfnyPNvHxPI9o497qIphHC6QUr1xe7G3ejlSXoi1l3q0U0Ku6g0s6J3mf7TJOpE
         ONtSJk9M5qB8XZqjLm9RTH3J5H0iyX98YO7S+ELyla9+ZdwAjD4liDO3nAg/0vCgOxZQ
         rWOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=oJH/sevW+2dGwDLXNQp1WkALkE8Odl6i+qIiTAJ26Nk=;
        b=f7g8wspe8nIPRuuIPZusd+7CVGydEmFqwdwPZOAYayCA1IVuFbBEs54v27p+ymdTqy
         PIYkdRWzPi93w92cL10JOvEioBUF5uFuu/CH7nJT5t/pZoqGUNpdE07dsaDF0EkjQfOz
         DGdrNLjZdf0UD20H8NcshUJbusVh2CpsTBrMj0EK6je3NhWLuc7IuYn50S09m9mE5KLW
         9KGJsHbuFAKzzVVlGSVNTDpOPC6xgxPhRFXbbpLhgzgLzofn1s1xzHwFEnLmxVHHg5at
         +szHRqJf86clgt+ajj1g0mdHeuSpRh/a5Ui1nVu7eBEJ6cHC/OgC+GXj1E/4iPva7GTX
         6dyg==
X-Gm-Message-State: AOAM5309H7RxbBbmtIRjzkuA3XTNU+0k8VCM2ql6Rd0uc25fUqbr8jBV
        tw7aYVK2jrNFqrCZ+/GI1rrjlA==
X-Google-Smtp-Source: ABdhPJx0Spy1oPYSfezw8LaT7DvUG5fj3RytFu4NLazmyqxj4kLWy90zlaRuHQ4/G1kqhKBjUrLFxg==
X-Received: by 2002:a17:90a:7522:: with SMTP id q31mr1599527pjk.158.1605063690721;
        Tue, 10 Nov 2020 19:01:30 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id t19sm360156pgv.37.2020.11.10.19.01.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 19:01:30 -0800 (PST)
Message-ID: <5fab540a.1c69fb81.73c59.1861@mx.google.com>
Date:   Tue, 10 Nov 2020 19:01:30 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
X-Kernelci-Kernel: v5.10-rc3-25-gfc4b18739b23
Subject: pm/testing sleep: 3 runs, 1 regressions (v5.10-rc3-25-gfc4b18739b23)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing sleep: 3 runs, 1 regressions (v5.10-rc3-25-gfc4b18739b23)

Regressions Summary
-------------------

platform        | arch  | lab           | compiler | defconfig | regressions
----------------+-------+---------------+----------+-----------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-8    | defconfig | 1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.10-rc=
3-25-gfc4b18739b23/plan/sleep/

  Test:     sleep
  Tree:     pm
  Branch:   testing
  Describe: v5.10-rc3-25-gfc4b18739b23
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      fc4b18739b234869e8ee6c499ed8b69e3281a262 =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig | regressions
----------------+-------+---------------+----------+-----------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-8    | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/5fab47ac80fd86375edb8872

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.10-rc3-25-gfc4b1=
8739b23/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.10-rc3-25-gfc4b1=
8739b23/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2020=
1105.0/arm64/rootfs.cpio.gz =



  * sleep.login: https://kernelci.org/test/case/id/5fab47ac80fd86375edb8873
        failing since 83 days (last pass: v5.8-107-gb72b3ea38c81, first fai=
l: v5.9-rc1-4-g1f08d51cd57f) =

 =20
