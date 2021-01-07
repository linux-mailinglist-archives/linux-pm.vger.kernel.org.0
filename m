Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5795E2EE9DD
	for <lists+linux-pm@lfdr.de>; Fri,  8 Jan 2021 00:38:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728954AbhAGXiW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 7 Jan 2021 18:38:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728605AbhAGXiW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 7 Jan 2021 18:38:22 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8D85C0612F4
        for <linux-pm@vger.kernel.org>; Thu,  7 Jan 2021 15:37:41 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id be12so4698823plb.4
        for <linux-pm@vger.kernel.org>; Thu, 07 Jan 2021 15:37:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=326vCKfR625xSV8hLH4OIVEH6T58xnIeKzTFe7g0MS0=;
        b=pPRJg/CMnBD8qUnoxvmP0DN8IkAXoalqOwfhHF//y/2i9c7jj2cLlufsEyXR4XAijQ
         XolrUjl4WAxqf5lpG50RmCyUlQopDFyfz5iTWTIicORlQVAlEumsInSEIZmqputJE+/x
         fQrl0G9NvVwz/qFrQFfqgFYP5wPfyAqIMNp27j0mxKZpTJZbNhsdFuj5iTm05vL4rxSa
         AllzKWcReZMpJodhpEUmI0N4BfwA4LxZ2lIjY3eRTFJQ8Lr5CFxslx5E/gFGpfEz0JF7
         kn0cS/8/meNIFgj+dCIqb/FXDjEtQlNr+5XK2/l3++XvIPxhgv7jMcPa7GbAXF8GmJqQ
         N2zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=326vCKfR625xSV8hLH4OIVEH6T58xnIeKzTFe7g0MS0=;
        b=bgTGAYT8DYjk4KRZ/mFodXR/Bk5HUFMp+ZM1xQMXTqrDU/Hc4Nb9+IHX5PeVZVn1mo
         H51p40ZGjJWTgtlW72LrnJhLxa3WE3Y57ZM0JPpIxBW9ANTL3AH3IhE/Q/O46b59psQw
         bTthhc4qFcRNgLQYFI0ihoolrxGPZsMclR5lzgzPpHMmo3NMKNZQa+MIAY6soXJwfp8O
         dYexc8RhtyYZwjcx1w3RMTwL3gKRwyAhCwMfWyd6IQrcRivffA3DBhW1s5RcRROSAMzq
         ol38usgQlK+CU7aV+BkWJUVXT7nbkYUP4NhrInnI/PJhW1CtEuqXR0mYqOvbkpakonhE
         ic8Q==
X-Gm-Message-State: AOAM531UDWicNhSTltusQK+HpFU/nP6gQKOQCwSVGzztsAMsg+sy8VrM
        JQ7LnoFDpHwcrncgqwNfud+6JMxm+ant0w==
X-Google-Smtp-Source: ABdhPJx1/8VvDG4A+1eJeSPxPnQ+yXG2PQvR+aK//IuytHbkT9Pz9unSVB29j+4qnpO++GOGlHZwQQ==
X-Received: by 2002:a17:90a:5298:: with SMTP id w24mr823266pjh.182.1610062661597;
        Thu, 07 Jan 2021 15:37:41 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id z12sm6535746pfn.186.2021.01.07.15.37.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 15:37:40 -0800 (PST)
Message-ID: <5ff79b44.1c69fb81.7aab5.0308@mx.google.com>
Date:   Thu, 07 Jan 2021 15:37:40 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v5.11-rc2-21-g75a052c6b1ba
X-Kernelci-Report-Type: test
Subject: pm/testing sleep: 8 runs, 1 regressions (v5.11-rc2-21-g75a052c6b1ba)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing sleep: 8 runs, 1 regressions (v5.11-rc2-21-g75a052c6b1ba)

Regressions Summary
-------------------

platform        | arch  | lab           | compiler | defconfig | regressions
----------------+-------+---------------+----------+-----------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-8    | defconfig | 1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.11-rc=
2-21-g75a052c6b1ba/plan/sleep/

  Test:     sleep
  Tree:     pm
  Branch:   testing
  Describe: v5.11-rc2-21-g75a052c6b1ba
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      75a052c6b1ba2bb2cb1a09af90576af93d4f95a7 =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig | regressions
----------------+-------+---------------+----------+-----------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-8    | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/5ff78eceb9ac23045ac94cb9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.11-rc2-21-g75a05=
2c6b1ba/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.11-rc2-21-g75a05=
2c6b1ba/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2020=
1221.0/arm64/rootfs.cpio.gz =



  * sleep.login: https://kernelci.org/test/case/id/5ff78eceb9ac23045ac94cba
        failing since 141 days (last pass: v5.8-107-gb72b3ea38c81, first fa=
il: v5.9-rc1-4-g1f08d51cd57f) =

 =20
