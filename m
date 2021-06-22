Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A18AF3B0D56
	for <lists+linux-pm@lfdr.de>; Tue, 22 Jun 2021 21:00:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232418AbhFVTCh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 22 Jun 2021 15:02:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232021AbhFVTCg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 22 Jun 2021 15:02:36 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95214C061574
        for <linux-pm@vger.kernel.org>; Tue, 22 Jun 2021 12:00:20 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id c5so295733pfv.8
        for <linux-pm@vger.kernel.org>; Tue, 22 Jun 2021 12:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=N202F85Y/6pfD8x/zSUupobNKoSN2BMgsxhl4ELGlsk=;
        b=fJGkg2vNtZx2q5srhjaCzd2fKoofyLVF0p25fP1dgypsfrd2FLzfelqfbD6N7WLWQf
         549DWBGopPV0lyuaT3w9uHL3gJ9zVBwU2PhSVWWdiam7JDwbsbuf36dkrQi35F0ucPpS
         2jC/xuVfPeUhnl/TRakqkq0I1kVHavuGGJ4atZPMyQwRgB7xjIcODYha4TCVXkyGGeBw
         wKmLeUhGyPjEr5SOS7Z6fAkNCccDjE0bIu7uwgQxCaZoxEKwsNaJqUa0bjZdrngKfLYM
         jbTngt4sn8N7RXx72HqXe7fyQhc2UgdYSo2UObSHPhKuiZbLV6owkhB+90Kt8OVKZbG3
         ls2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=N202F85Y/6pfD8x/zSUupobNKoSN2BMgsxhl4ELGlsk=;
        b=iRp4XXcN9331UZM89TOKgUV1nsw4PpGt2faVySzvg3v+g+CocmC5okIMBw4Q/0VC8I
         zRC/KJF0pMhP1YfQzulfMiPb9cewc1+6P2R2Z5ts87kwkqpbjFWNE4WU57k3ZBbsk7kl
         QqPoFn/u1A0fO6xDyFiQwIMoOgiZ82+Og2PslOQgGV7nS2BmmV6K97BRmdWe9P+/zsFf
         QoxGE+Z6racd2meJD+EhKMKJXcOqHPKGni48wu358G/O5or8HYSls3DusoEuvzy0Z1uy
         HK0AtlPDJ2eAl6eh25Q3BTNpJQ1E4Ru4qowmJjatE5CIoCIq+5vmJFQ87zsflGI3Xi2P
         cxpg==
X-Gm-Message-State: AOAM533qsmAZUA5kbGASEegMpJR9x1p578r5ctdZtRVwG/UNxgENJu6V
        afkEPdWsOi7NR7wh5rOW8k4wrA==
X-Google-Smtp-Source: ABdhPJwJBc9dAklPjOMtd/Lbb1YBa36da5gmMn3AjFuqfdWtIIURbkn/kmj/UY9wezMJDQ/shucI0Q==
X-Received: by 2002:a65:48c5:: with SMTP id o5mr107323pgs.397.1624388417462;
        Tue, 22 Jun 2021 12:00:17 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id h22sm97631pfc.21.2021.06.22.12.00.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jun 2021 12:00:17 -0700 (PDT)
Message-ID: <60d23341.1c69fb81.bd70e.0654@mx.google.com>
Date:   Tue, 22 Jun 2021 12:00:17 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.13-rc7-150-ga51c80057a88
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
Subject: pm/testing sleep: 3 runs, 1 regressions (v5.13-rc7-150-ga51c80057a88)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing sleep: 3 runs, 1 regressions (v5.13-rc7-150-ga51c80057a88)

Regressions Summary
-------------------

platform        | arch  | lab           | compiler | defconfig | regressions
----------------+-------+---------------+----------+-----------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-8    | defconfig | 1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.13-rc=
7-150-ga51c80057a88/plan/sleep/

  Test:     sleep
  Tree:     pm
  Branch:   testing
  Describe: v5.13-rc7-150-ga51c80057a88
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      a51c80057a887e0f24bd8303b0791a130ff04121 =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig | regressions
----------------+-------+---------------+----------+-----------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-8    | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/60d22003e490b29a6e41327b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.13-rc7-150-ga51c=
80057a88/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.13-rc7-150-ga51c=
80057a88/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2021=
0520.0/arm64/rootfs.cpio.gz =



  * sleep.login: https://kernelci.org/test/case/id/60d22003e490b29a6e41327c
        failing since 306 days (last pass: v5.8-107-gb72b3ea38c81, first fa=
il: v5.9-rc1-4-g1f08d51cd57f) =

 =20
