Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F8CC2CAB96
	for <lists+linux-pm@lfdr.de>; Tue,  1 Dec 2020 20:16:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727432AbgLATQT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 1 Dec 2020 14:16:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727375AbgLATQS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 1 Dec 2020 14:16:18 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2909C0613D4
        for <linux-pm@vger.kernel.org>; Tue,  1 Dec 2020 11:15:38 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id q22so1482547pfk.12
        for <linux-pm@vger.kernel.org>; Tue, 01 Dec 2020 11:15:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=gs2j2J7AT5nnsyo0SZgLOxwTiwS7dTpaglVIrL+O4yI=;
        b=PC8HaoyyA3NJlubTR6Oer8hqD0IjhQ3ar9nd7ssYRZw5HCi9/R3fuki+EazGBvO7AZ
         mV9VoRgTlaSfeQcWJxz8BHx1k8uk2oKyuctwmj7tVU1JgGGV790VnG7Cfast/0AFiraY
         WPpVgliHwz1jXqYLhUqv5Jynu2ap8hbfTBPGoFUoeisIkXiBz6XZPnOEEIYRjO9WeXO1
         hG9ML2NatBfzSSIPFXRqOUKJkUv5R1gQ90kl4hxe8eb9WUbALob6H56QFok0YC0eHcUJ
         v6yq3Q9OGISa0mO6cjFidHYR95qkOEvtgkWWOwBffHvCRgNqdhjhivWdXSznWeVEgM28
         w/0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=gs2j2J7AT5nnsyo0SZgLOxwTiwS7dTpaglVIrL+O4yI=;
        b=apfhhdyPhxJu01dra43cUegJ73iKZaR9s4C7vm4Vefk+VrMKk64mDccoDM6rMuj5sa
         VWIRZEpVqUWhnmNJ/L12/CQ+uJug7IjcfkqOlZY7YQL3E5HU/xlPUPtiDWNy/gLFtpqT
         Bq8oRrbI56SUsg/Rp0mABR+FW2mpU1M5hLf7HvG5eEJ6/ijTl8SENd6CTxc7w+tSjTw/
         uI+YuFVzL1fZce9i+BdVkhuNGhxZ+xAJ9q3szEoseVh/IOEKKU9y0+39IJw7HbOlRvY5
         2g8rekEyxeW2B4cUII1GocNMD7FAcl4S5RlV43C2P2D7+fvbEtgYWB6wd+iIyijbfzgh
         ZHqw==
X-Gm-Message-State: AOAM530//qiRe9DSl9a7XcSkwsJDh13i1lndIItOHkNNv7ML6JoA6Iur
        OaMAZ3bOSL8NX5kZdB14tz7lHUxJEgMq0g==
X-Google-Smtp-Source: ABdhPJxBC7lRVoq6tWMjsqnblSf6+BB4mIA6uzUzlp66KHB4Ri4yZ0Gy9QjscHgbBgOK1QHitFxLfw==
X-Received: by 2002:a05:6a00:848:b029:197:e659:e236 with SMTP id q8-20020a056a000848b0290197e659e236mr3908107pfk.74.1606850138339;
        Tue, 01 Dec 2020 11:15:38 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id a25sm507203pfg.138.2020.12.01.11.15.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Dec 2020 11:15:37 -0800 (PST)
Message-ID: <5fc69659.1c69fb81.e3d6f.132f@mx.google.com>
Date:   Tue, 01 Dec 2020 11:15:37 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v5.10-rc6-78-gc6c91db76539e
X-Kernelci-Report-Type: test
Subject: pm/testing sleep: 5 runs, 1 regressions (v5.10-rc6-78-gc6c91db76539e)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing sleep: 5 runs, 1 regressions (v5.10-rc6-78-gc6c91db76539e)

Regressions Summary
-------------------

platform        | arch  | lab           | compiler | defconfig | regressions
----------------+-------+---------------+----------+-----------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-8    | defconfig | 1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.10-rc=
6-78-gc6c91db76539e/plan/sleep/

  Test:     sleep
  Tree:     pm
  Branch:   testing
  Describe: v5.10-rc6-78-gc6c91db76539e
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      c6c91db76539e729139e47085af40adf240800a4 =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig | regressions
----------------+-------+---------------+----------+-----------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-8    | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/5fc687ffc6c03a7c30c94cf9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.10-rc6-78-gc6c91=
db76539e/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.10-rc6-78-gc6c91=
db76539e/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2020=
1130.0/arm64/rootfs.cpio.gz =



  * sleep.login: https://kernelci.org/test/case/id/5fc687ffc6c03a7c30c94cfa
        failing since 104 days (last pass: v5.8-107-gb72b3ea38c81, first fa=
il: v5.9-rc1-4-g1f08d51cd57f) =

 =20
