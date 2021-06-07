Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BFF439DEBC
	for <lists+linux-pm@lfdr.de>; Mon,  7 Jun 2021 16:29:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbhFGObE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 7 Jun 2021 10:31:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbhFGObD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 7 Jun 2021 10:31:03 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC96EC061766
        for <linux-pm@vger.kernel.org>; Mon,  7 Jun 2021 07:29:12 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id l10-20020a17090a150ab0290162974722f2so106485pja.2
        for <linux-pm@vger.kernel.org>; Mon, 07 Jun 2021 07:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=igsdmXz2ggL0uhBwRJFGNwoPZd6P1fFHm6UPDCED6LE=;
        b=q62bcCSkjJV4d3XKpd4SRTP4bhX/AbBR37sW4hTSZmrnEqyk2Vsd83+d62K/0lrgo2
         Jq3cn95jyKu5ZoVOJanVGC6z9xe0i9bbdA+28Z581Rs5SOTgbE3eyBkBNKKY0x1l2MwM
         0m5mKrRPXg5chRW6gFAO30giaJMH2FXa9gCOya/JlZ5dGn/utWsmA7bVwqtVPELd5ttl
         zSjzZAzmQsC8MDcdSvQdf849Z5ZzeStdgKMhYoMHw2GK8OlCu1jusjlrhijLklHhROxu
         l7285GttMbKPWBKsumzNPUBMJihNTbR5zn6P2JEouGuvpHcoQsEY9Mb94cFyTpP4EEQS
         UppA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=igsdmXz2ggL0uhBwRJFGNwoPZd6P1fFHm6UPDCED6LE=;
        b=hlVwfNA9TDz3u0jaEEcW/H36JeRtAYye6hT2XvE46+mGycI5yYtKmBha4kmpEWI/8o
         w9ABtrSo7IEfsm0qaGRyOHdz2nW/Wa+/Kv76T3BXgio7jwSL1pC/TVLcBwDvslzAQeQI
         7eOXw6ME5WWKq3VuI/6htuFYKlbbsRvg3+tPMNmKR0LnR/W9dpGBJw+9tckD2UfusbsI
         Jqg0f+TuLdokG+Od7XTAkggZm8ls4sJLaLUXnJbDvNgYj5fIfLybK3vrTgMXt3LeCiZg
         uicW/KQ6cSiAkYLmd5vO3qHyQa7mFYZKJ94+joHMtGOGjIWFpXm9F3Kfj8TIRW7b8wJx
         viPw==
X-Gm-Message-State: AOAM532Op4n5XujWClJ9Qc0Qf3Vbt+g1VWFKWFURaDmbX5tckxKO3sYE
        L0D8xThPeC1iQvPQLnYkHZbyao0Q+mMc7ZWf
X-Google-Smtp-Source: ABdhPJyUsby+Q2BqRT6ge2jKra69sDvqom5uwW3arrmemBElppcDpC+xUI8d+Qx1u6njW6sWGq9uqw==
X-Received: by 2002:a17:90b:1b4f:: with SMTP id nv15mr33141985pjb.56.1623076152353;
        Mon, 07 Jun 2021 07:29:12 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id b8sm8046900pfo.64.2021.06.07.07.29.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 07:29:12 -0700 (PDT)
Message-ID: <60be2d38.1c69fb81.129b0.7a64@mx.google.com>
Date:   Mon, 07 Jun 2021 07:29:12 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.13-rc5-37-gfcbef3bdf3a8
X-Kernelci-Report-Type: test
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
Subject: pm/testing baseline: 105 runs,
 1 regressions (v5.13-rc5-37-gfcbef3bdf3a8)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 105 runs, 1 regressions (v5.13-rc5-37-gfcbef3bdf3a8)

Regressions Summary
-------------------

platform   | arch  | lab     | compiler | defconfig | regressions
-----------+-------+---------+----------+-----------+------------
imx8mp-evk | arm64 | lab-nxp | gcc-8    | defconfig | 1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.13-rc=
5-37-gfcbef3bdf3a8/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v5.13-rc5-37-gfcbef3bdf3a8
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      fcbef3bdf3a80dfe325261a837f0abd0b2a1b3f0 =



Test Regressions
---------------- =



platform   | arch  | lab     | compiler | defconfig | regressions
-----------+-------+---------+----------+-----------+------------
imx8mp-evk | arm64 | lab-nxp | gcc-8    | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/60be2424e0fa950fd30c0dfe

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.13-rc5-37-gfcbef=
3bdf3a8/arm64/defconfig/gcc-8/lab-nxp/baseline-imx8mp-evk.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.13-rc5-37-gfcbef=
3bdf3a8/arm64/defconfig/gcc-8/lab-nxp/baseline-imx8mp-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-5-g2f114cc7102b/arm64/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/60be2424e0fa950fd30c0=
dff
        new failure (last pass: acpi-5.13-rc5-42-ga25ea0c642c2) =

 =20
