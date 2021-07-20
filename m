Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6F283CF4B8
	for <lists+linux-pm@lfdr.de>; Tue, 20 Jul 2021 08:46:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243015AbhGTGFo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 20 Jul 2021 02:05:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242889AbhGTGFP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 20 Jul 2021 02:05:15 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B257AC061574
        for <linux-pm@vger.kernel.org>; Mon, 19 Jul 2021 23:45:52 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id g22-20020a17090a5796b02901763aca3df6so93966pji.5
        for <linux-pm@vger.kernel.org>; Mon, 19 Jul 2021 23:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=CqNPxUnpOino21Lagxi1gBNyV9wWr4WwQuDmO+QChcE=;
        b=DW35CW5OcLvPhZp49WOZaCNlq7XLMoq64hNAKu2V89KEga2lcH7MzP99s4Yn2erlSw
         2LGqKcrwfSsq5c4lgx8gwCCk32wvQcE2StJR92Qg9c3pDzDrikAeDEV0i/bOdInEgS3A
         NSfaEPBH5JChRsgqG3v2FX6HS9Av6H2nTG8A01jVDuEeUSkigBg0FQUiHJf5sPYSx2RS
         GMOwJ17kkBbLN2doIUu5ZRGCBBAoGvpZIKZQ9h0Kff000sAIsw/Q6mUIUdpbarYD5bLY
         834P7pqzDRxjAWJP/OIUNQt3tMFtoMvDmo4i+y61etepLyypkP1AE/9F5HreXbFr+/dm
         O0ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=CqNPxUnpOino21Lagxi1gBNyV9wWr4WwQuDmO+QChcE=;
        b=UNl6H0u3vSXr8++5okis/IH5D/j4Or8w+1t0gHEtM3ettzY1EbZTuMmLpGbPB27yfr
         YGIC5+qiNChsoCN8jYxzne4dP0wTjMu77hNziFQ4tok7+BXuJFZBsEhn2CsKdeiV5cwV
         UsUUkvFRzfLy48SDhMMyLK25/FgqTgUnC/GyFa6kMu524O07bPC92ITyp36snhC1l9bf
         EsdsSrkANh5k0p2JGoaR3CC+qCgschtcefmuuP6h5wtNUAeS6c7Xp6LUBO818tc6rUql
         B9vK0yB3rPIsBwmhf/VSuv8I6sv5UODkem0T70pUeZRbCsWv1TmxUPvgm6aG9quxAtcd
         3NGA==
X-Gm-Message-State: AOAM530kkIBqE8LVo9aCQRdoiZpN1qwTdmGlwqcU7HosQfeIKIiBkclU
        FPHCy3ZnzhgD39dvEsQU8Nhgg2xzuOFelg==
X-Google-Smtp-Source: ABdhPJwRQT4P2NNlCTpOM1kAjpMAJajY7vJSUPi+n+sCJykH8EcgVYpLMFVzqVtgkUa5+EmXHtQ1cQ==
X-Received: by 2002:a17:90a:8404:: with SMTP id j4mr33993077pjn.66.1626763552278;
        Mon, 19 Jul 2021 23:45:52 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id c7sm23855075pgq.22.2021.07.19.23.45.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jul 2021 23:45:51 -0700 (PDT)
Message-ID: <60f6711f.1c69fb81.cb685.8d11@mx.google.com>
Date:   Mon, 19 Jul 2021 23:45:51 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.14-rc2-17-gd713e0c833987
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
Subject: pm/testing sleep: 2 runs, 1 regressions (v5.14-rc2-17-gd713e0c833987)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing sleep: 2 runs, 1 regressions (v5.14-rc2-17-gd713e0c833987)

Regressions Summary
-------------------

platform        | arch  | lab           | compiler | defconfig | regressions
----------------+-------+---------------+----------+-----------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-8    | defconfig | 1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.14-rc=
2-17-gd713e0c833987/plan/sleep/

  Test:     sleep
  Tree:     pm
  Branch:   testing
  Describe: v5.14-rc2-17-gd713e0c833987
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      d713e0c8339876fb5070b53cb1bec248c37fbf38 =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig | regressions
----------------+-------+---------------+----------+-----------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-8    | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/60f66402cd27fd686f1160cd

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.14-rc2-17-gd713e=
0c833987/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.14-rc2-17-gd713e=
0c833987/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2021=
0709.0/arm64/rootfs.cpio.gz =



  * sleep.login: https://kernelci.org/test/case/id/60f66402cd27fd686f1160ce
        failing since 334 days (last pass: v5.8-107-gb72b3ea38c81, first fa=
il: v5.9-rc1-4-g1f08d51cd57f) =

 =20
