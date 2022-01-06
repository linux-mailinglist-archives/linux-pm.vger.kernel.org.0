Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0320486D35
	for <lists+linux-pm@lfdr.de>; Thu,  6 Jan 2022 23:28:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245108AbiAFW2P (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 6 Jan 2022 17:28:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245098AbiAFW2O (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 6 Jan 2022 17:28:14 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C05D5C061245
        for <linux-pm@vger.kernel.org>; Thu,  6 Jan 2022 14:28:14 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id c9-20020a17090a1d0900b001b2b54bd6c5so10136682pjd.1
        for <linux-pm@vger.kernel.org>; Thu, 06 Jan 2022 14:28:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=GCk4Zyi9M6py0E8Itw96MuggA1CsSBJjPglv8XcHmRI=;
        b=AWnSTCzMcXbMksCtldTgfqpO2zzCdotcafEvkSdddEB684jrU+AvunwCGC6Euo5WNc
         c5QUcQfa/BVUlIHzfdJU4LCX71AodH4xNgkHLqcyygKv683/VJ+4eDE5Wm7sQx/5PS31
         cZlwS64QnOI/aTvbaT+bTXx3X4P+tKbJBoPpgcNtG/oVzclepV7NZdfIQIQ+ZrnYSTO7
         roqFh+C/FG9LRQoKwK6AaEFDJNh9OTwBrSHth7Ji6GuAa1oijIgGZDQkeW1QxGRUjTjd
         fICKFtPF2TADNZpRualckQJwJKmxdF9p9MkclNsOcZWSYctmLFlxmVOB5dFoyy4BylFO
         sYLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=GCk4Zyi9M6py0E8Itw96MuggA1CsSBJjPglv8XcHmRI=;
        b=AGMDlRC7hNxb8Uh34AFI30iQH4pUdB1mon5GCLY+Bz5ZQhL7GQ19wEPHAOcnIN/QFz
         RLpeYXufFO1i8aofMqJxBCGZj4/N4hfSJNk8J+s7yIV2dQcyH59F6FOXZWcLk99l1sA9
         hlg5WyvDdys4ntfsjI7hYPrDDptKSeK3u4uoYlUEHPjqYUQKvghyEJVIf2zVTtwTV/F5
         zWSUgn5iwZ7xD90VIkhoQ2C1tsBf99CTj2k1B4/6+V6Fo7hAKi5GwoZFqCDSoXFZKs6L
         /ORfpEFTadZF+2Vw2g7l42D+mreT5UQ6GSryKK4m/MgdK5QJEDpYEb+ux5+iVUzinf/a
         xAiw==
X-Gm-Message-State: AOAM5317z2nZ35JmaFYCsvVz8UCBUIbWoTaD6BXi28xK9OPx5PKh58vl
        bo6jba4e+QjiOh/1IKRzmvP9BQ==
X-Google-Smtp-Source: ABdhPJzY1adBQ5vBnTOlmtcvpAlIPECR/ygAlnz18aqW8H+zmoN2jZv1JhaGvPjhDxWA0wTwbNtFTw==
X-Received: by 2002:a17:90b:3e83:: with SMTP id rj3mr12190209pjb.132.1641508094347;
        Thu, 06 Jan 2022 14:28:14 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id f125sm3388111pfa.28.2022.01.06.14.28.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 14:28:14 -0800 (PST)
Message-ID: <61d76cfe.1c69fb81.b6eaa.8ed7@mx.google.com>
Date:   Thu, 06 Jan 2022 14:28:14 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v5.16-rc8-171-gf099fd60c342
X-Kernelci-Branch: testing
Subject: pm/testing baseline: 75 runs,
 1 regressions (v5.16-rc8-171-gf099fd60c342)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 75 runs, 1 regressions (v5.16-rc8-171-gf099fd60c342)

Regressions Summary
-------------------

platform               | arch  | lab          | compiler | defconfig | regr=
essions
-----------------------+-------+--------------+----------+-----------+-----=
-------
sun50i-a64-pine64-plus | arm64 | lab-baylibre | gcc-10   | defconfig | 1   =
       =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.16-rc=
8-171-gf099fd60c342/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v5.16-rc8-171-gf099fd60c342
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      f099fd60c342d8d8265202ce01b4375358913072 =



Test Regressions
---------------- =



platform               | arch  | lab          | compiler | defconfig | regr=
essions
-----------------------+-------+--------------+----------+-----------+-----=
-------
sun50i-a64-pine64-plus | arm64 | lab-baylibre | gcc-10   | defconfig | 1   =
       =


  Details:     https://kernelci.org/test/plan/id/61d768c18f0bfb7433ef673d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.16-rc8-171-gf099=
fd60c342/arm64/defconfig/gcc-10/lab-baylibre/baseline-sun50i-a64-pine64-plu=
s.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.16-rc8-171-gf099=
fd60c342/arm64/defconfig/gcc-10/lab-baylibre/baseline-sun50i-a64-pine64-plu=
s.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20211210.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/61d768c18f0bfb7433ef6=
73e
        new failure (last pass: v5.16-rc8-155-g7a716cec17d1) =

 =20
