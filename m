Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 948DA21F692
	for <lists+linux-pm@lfdr.de>; Tue, 14 Jul 2020 17:58:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbgGNP6N (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 14 Jul 2020 11:58:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbgGNP6N (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 Jul 2020 11:58:13 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2942CC061755
        for <linux-pm@vger.kernel.org>; Tue, 14 Jul 2020 08:58:13 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d1so1949571plr.8
        for <linux-pm@vger.kernel.org>; Tue, 14 Jul 2020 08:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=kxexHih2bwVN8fZsmsF/MqEelBet2IqedPkfawQ8XiI=;
        b=0+DEzBKhIzaOFKXUEBJhhcYOIkb2tGy+HoDO1yctB9zebIJSnfW3TuuZ0kT6F9MueU
         ONKSt1RvtzLmGhJSC8GNbG61HmASJ1V2A/mGZ53xqHuJblyFLkPdlBdU0x99DLlb3VuG
         ukCuRd8oFc8bIzlQcMU9VA5vUOztKqfDWtcglPfalKq7gCUCAx4kO+CzLdSpU/hrUcOn
         SrIinpHYv5gxcElZ+Lre/Kl68j0x+WHeLxlvhDLlQzW6nUdLgNw83JN3SN3d9Di/ECCd
         609TV5c/W/AQYYExuzESxSq+8YgL8cyOFV/hUIgXLWbrHTj6p+XnybIy9H14YbGC/ilA
         v8Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=kxexHih2bwVN8fZsmsF/MqEelBet2IqedPkfawQ8XiI=;
        b=HxjG0E9kYaa7uK+uLF2/7urfV31Yi/oyo6WqPszrodPF2cG4F/bOMbBnSHt08hCaAK
         OHMaOKpWzlwx1OlevCeZkS+x/A3bTAXTbyMZcOVxMNrq753c44b+HouWVC97Fk4lu01b
         wLWNFBNleOmIC5lKvcYKtkyy+tR/KRedHB1Bh2xaKdzoMPSpn+r8FpSpOB3NzLIiwCOg
         x5ZJE4VO17ss28QGLK2NCIafhQzT8o08NUyyVMaiJzvReoZU7ahEwq92zBQuENCfTlgk
         wwKe7rumSWfyKUHCF94Ku1G/WdkmgVF5YjZibREt6De5gkr5/VQwR68D3cFBcOm001UU
         2oxg==
X-Gm-Message-State: AOAM5329mi+WgB/KJyQaoFXPQfCxMcdMQWf2AvjDQ8hvTnWXPzWMkX0F
        hrk5UeB9Pf/IlsSpvF00CrY0efONmhM=
X-Google-Smtp-Source: ABdhPJyFg9GDtuAfrv7bTXrq5MF1BwD1+QdznWzEaecfaR98WQY02gh4ZBp7a0IedF8nYK9k3VZF+g==
X-Received: by 2002:a17:90a:cc:: with SMTP id v12mr4957099pjd.96.1594742292727;
        Tue, 14 Jul 2020 08:58:12 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id m19sm1765727pgd.13.2020.07.14.08.58.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 08:58:11 -0700 (PDT)
Message-ID: <5f0dd613.1c69fb81.24398.3554@mx.google.com>
Date:   Tue, 14 Jul 2020 08:58:11 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.8-rc5-44-g71865a3b9f0a
X-Kernelci-Report-Type: test
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
Subject: pm/testing baseline: 68 runs,
 1 regressions (v5.8-rc5-44-g71865a3b9f0a)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 68 runs, 1 regressions (v5.8-rc5-44-g71865a3b9f0a)

Regressions Summary
-------------------

platform                     | arch  | lab          | compiler | defconfig =
| results
-----------------------------+-------+--------------+----------+-----------=
+--------
meson-gxl-s805x-libretech-ac | arm64 | lab-baylibre | gcc-8    | defconfig =
| 4/5    =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.8-rc5=
-44-g71865a3b9f0a/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v5.8-rc5-44-g71865a3b9f0a
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      71865a3b9f0af787f9e80943606014cb59965cc4 =



Test Regressions
---------------- =



platform                     | arch  | lab          | compiler | defconfig =
| results
-----------------------------+-------+--------------+----------+-----------=
+--------
meson-gxl-s805x-libretech-ac | arm64 | lab-baylibre | gcc-8    | defconfig =
| 4/5    =


  Details:     https://kernelci.org/test/plan/id/5f0dcb6972cdf677de85bb18

  Results:     4 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.8-rc5-44-g71865a=
3b9f0a/arm64/defconfig/gcc-8/lab-baylibre/baseline-meson-gxl-s805x-libretec=
h-ac.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.8-rc5-44-g71865a=
3b9f0a/arm64/defconfig/gcc-8/lab-baylibre/baseline-meson-gxl-s805x-libretec=
h-ac.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05/arm64/baseline/rootfs.cpio.gz =


  * baseline.dmesg.emerg: https://kernelci.org/test/case/id/5f0dcb6972cdf67=
7de85bb1d
      new failure (last pass: v5.8-rc5-39-gf2eae871177c)
      2 lines =20
