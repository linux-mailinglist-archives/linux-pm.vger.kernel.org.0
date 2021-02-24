Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE60C3242B6
	for <lists+linux-pm@lfdr.de>; Wed, 24 Feb 2021 17:58:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235807AbhBXQ6T (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 24 Feb 2021 11:58:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235915AbhBXQ5T (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 24 Feb 2021 11:57:19 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76173C061786
        for <linux-pm@vger.kernel.org>; Wed, 24 Feb 2021 08:56:38 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id b145so1711644pfb.4
        for <linux-pm@vger.kernel.org>; Wed, 24 Feb 2021 08:56:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=jnXvQ/E13MaGbFi14tRdpcxhz+j6B/wWpuzJgS2K4KE=;
        b=OTSmYBzORhukOzM6Eq+nD98y7h7opVHcEFn7AKaFFX86GehJ4GEeFv77sQ6LUBSUyy
         7gRSUNvOX5bwoW0ftW133Y52xzaLb5znF71HcQkxvVjQocCnKyK0hjnINzxuRwh74tp1
         deOZVVwRG8AKDYLnqNlYnWzPNI9D4AOrV3OvltJnpWzlRTJeqzpcJKpYz8wOOLdjskFN
         Nu66O800oA+L2E8eg9qZh8B9Qn2LjNP1kzRqT/2Nis050HN2grAfOah7jXha2wmiWlhk
         GwWWH2Ldy2GBMsNNmt+x2SDraw9arY/jvYBel2zgAfvHtc4hsFvb7V6tkryZnXP27Soj
         2MOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=jnXvQ/E13MaGbFi14tRdpcxhz+j6B/wWpuzJgS2K4KE=;
        b=tvbPJsiPYnQIfYFj0W3B3EVrHVY9t8q+eUyhK5wEQVJENKF/Aonf/CpEHTwzrl3a0w
         aoFW8qSQKE8aXomYkwGcVA9CpW6zZQTpk8e7s49Jr0W2SevtjdzkiHFkBkwI1e3yFHIH
         vP7x3s6VLr8EJ8aN74DJ1J+VbJe2uCckTMdA+XVW6RLbWw7xEzsDlW9aV79Ox8PIayF5
         w3VhQgRFxdJ9TvdlwMh61Qeu1+97gNSlt0N+jnTSIZzMWMiaOUPMQvI09SpU8UJIBNue
         BycggBiRu44TmYVHSbN1cU9joVt20wVkmxZ/OyvkMTrLCz+u62xCHBiCDebi52LzUK2v
         cdnQ==
X-Gm-Message-State: AOAM531nCb5pS2OZk8KqphCblyY5Q0DmvGtUFgEX+vLUJlOnGuEulwfu
        5J1iDb3nObA8CZpIlINn6pP4YPngkI874g==
X-Google-Smtp-Source: ABdhPJwJCWMxRyqBSwoGuXNNmZM1d+NVdWuZLtjc3eMHuO4d5ZRxdntjHSOifDFn1HC/XEhZKnkwhw==
X-Received: by 2002:a65:4781:: with SMTP id e1mr29689725pgs.30.1614185798044;
        Wed, 24 Feb 2021 08:56:38 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id np7sm3132946pjb.10.2021.02.24.08.56.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Feb 2021 08:56:37 -0800 (PST)
Message-ID: <60368545.1c69fb81.df85d.6818@mx.google.com>
Date:   Wed, 24 Feb 2021 08:56:37 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.11-168-gd10b8fa0d6dfd
X-Kernelci-Report-Type: test
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
Subject: pm/testing sleep: 4 runs, 1 regressions (v5.11-168-gd10b8fa0d6dfd)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing sleep: 4 runs, 1 regressions (v5.11-168-gd10b8fa0d6dfd)

Regressions Summary
-------------------

platform        | arch  | lab           | compiler | defconfig | regressions
----------------+-------+---------------+----------+-----------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-8    | defconfig | 1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.11-16=
8-gd10b8fa0d6dfd/plan/sleep/

  Test:     sleep
  Tree:     pm
  Branch:   testing
  Describe: v5.11-168-gd10b8fa0d6dfd
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      d10b8fa0d6dfd06fb9afd44b0ceea8e904fc95bf =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig | regressions
----------------+-------+---------------+----------+-----------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-8    | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/603677cff4a9cac895addcd0

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.11-168-gd10b8fa0=
d6dfd/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.11-168-gd10b8fa0=
d6dfd/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2021=
0215.2/arm64/rootfs.cpio.gz =



  * sleep.login: https://kernelci.org/test/case/id/603677cff4a9cac895addcd1
        failing since 188 days (last pass: v5.8-107-gb72b3ea38c81, first fa=
il: v5.9-rc1-4-g1f08d51cd57f) =

 =20
