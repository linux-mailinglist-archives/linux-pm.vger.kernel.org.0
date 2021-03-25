Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1C2E3485D3
	for <lists+linux-pm@lfdr.de>; Thu, 25 Mar 2021 01:21:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239210AbhCYAU7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 24 Mar 2021 20:20:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239217AbhCYAU3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 24 Mar 2021 20:20:29 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD87BC06174A
        for <linux-pm@vger.kernel.org>; Wed, 24 Mar 2021 17:20:28 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id u19so42622pgh.10
        for <linux-pm@vger.kernel.org>; Wed, 24 Mar 2021 17:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=Sx6h6uPIBwGBcckHe+LEsLjwH8Rq4fCHRoLvivImXYM=;
        b=DWZBJtW8niUw1C5hCRZzkqsJlLlc2ZIcgtJPqLJRKF7cLZ4WmaLI3sHNqTqTnDcLnG
         lmjSM7ikmT9NRFbElWXDciJ8IM4VQJksPnhqDqHV6f/+dP3E7a40Vq/nscp/75U/yhW7
         +UYO7mzHyaTaNMh6qhjCNPhBJTokEBsteh4m81ojl4q2X3tyfX2uErDi3xRSo3unKBgF
         32JLO6VFE0FM2Sg9Ar0/pKHCcnWp6G+OFE4hJuH1Cns3xqoQCG3EEredM9p5ubI8/MJf
         2Zs2uurR0sfqTZZ+44Au070rp3QAZWaEfMfZ5QQBdmUnPdkWgJoOkiu0O1nwIGcUnZPw
         IVFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=Sx6h6uPIBwGBcckHe+LEsLjwH8Rq4fCHRoLvivImXYM=;
        b=gTFBofdAv5HF93mJ39ZYp0CIyhv6HmXdwEmtpxN43klIzrHd3k9zoi+dXaZkUhkJo5
         Fo6x8NT3iVESrdYHVqNmMD5VcJSqiFVU768MCX+S7cSG4q450WoJ8m8S2EDngTfVogyh
         359IYVLoP4ShPVYX/i3Ap1viP6jpzpCALuwmw94fkuBld7VTGqlsAPcbbhUTnMXUBgdG
         7yl48glYXFt/blwems3LGxGFWvSPzj12Ou/XePU+kI+SXqz9/zPK/pHveMG9zp3KsxJx
         xDVOl1zs0kIO0/odNgb7gYAxKjw9jJ9RJNbYLLwKkh1+RIdnmoL3D1Xg/FMlITWyOlVG
         yWFw==
X-Gm-Message-State: AOAM531z0CYPkBimPQoalGtzFhtZaDW1CpPw/A3FJpQsUzsvqJKDmv7i
        6REzYS2GlkNtftjybWAhPACqQg==
X-Google-Smtp-Source: ABdhPJwCqT6wVKjr4ybHp4zm8wx1+XjgQW94X6PcfOpVZEf3qfCdvEDXu4CGwi74+yrhMWmejYpvWg==
X-Received: by 2002:a17:902:8687:b029:e6:5eda:c3a8 with SMTP id g7-20020a1709028687b02900e65edac3a8mr6217840plo.59.1616631628227;
        Wed, 24 Mar 2021 17:20:28 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id g26sm3371047pge.67.2021.03.24.17.20.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 17:20:27 -0700 (PDT)
Message-ID: <605bd74b.1c69fb81.a8da1.9823@mx.google.com>
Date:   Wed, 24 Mar 2021 17:20:27 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.12-rc4-45-g972d86381b186
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
Subject: pm/testing sleep: 3 runs, 1 regressions (v5.12-rc4-45-g972d86381b186)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing sleep: 3 runs, 1 regressions (v5.12-rc4-45-g972d86381b186)

Regressions Summary
-------------------

platform        | arch  | lab           | compiler | defconfig | regressions
----------------+-------+---------------+----------+-----------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-8    | defconfig | 1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.12-rc=
4-45-g972d86381b186/plan/sleep/

  Test:     sleep
  Tree:     pm
  Branch:   testing
  Describe: v5.12-rc4-45-g972d86381b186
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      972d86381b186fde03c69fb4cc0ca70f5255baa7 =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig | regressions
----------------+-------+---------------+----------+-----------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-8    | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/605bcaa0309c8f50f7af0324

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.12-rc4-45-g972d8=
6381b186/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.12-rc4-45-g972d8=
6381b186/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2021=
0315.0/arm64/rootfs.cpio.gz =



  * sleep.login: https://kernelci.org/test/case/id/605bcaa0309c8f50f7af0325
        failing since 217 days (last pass: v5.8-107-gb72b3ea38c81, first fa=
il: v5.9-rc1-4-g1f08d51cd57f) =

 =20
