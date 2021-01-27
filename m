Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B6103063EC
	for <lists+linux-pm@lfdr.de>; Wed, 27 Jan 2021 20:17:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231210AbhA0TRk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 Jan 2021 14:17:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231135AbhA0TRg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 27 Jan 2021 14:17:36 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96C42C0613D6
        for <linux-pm@vger.kernel.org>; Wed, 27 Jan 2021 11:16:55 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id u67so1845381pfb.3
        for <linux-pm@vger.kernel.org>; Wed, 27 Jan 2021 11:16:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=lbPABvMzpD16IoGjcR18rZ9jk/Jm5H+LR+KnJ0h6P9o=;
        b=Ts+lmSymgSAcHoM5p3D9rn+5MrM1k22UHYzx5S6FOEq6ibomy4r9wluwfFD9HJtixS
         ANXzjl41BwAeulpUXD2vh7KHAxsXIC+a482+q7WWYsDpaCxiKlO7csyGL0AbdZe1hpRX
         Y5BWUnVbp4Yh03wT1NWs2bUfJQjI/4eXMqVlCEAyWcBdlyUYosF6XkBmsuii+kiJukKR
         sQ3B++pAqfsT2T49ti2Ri7Ns9AQ1RF6VnJt6X4XS1qc2DBz1IHNNhtN+LGNUMVVcaGVo
         VdmPDFHW060IdllLa85VXN2jtIzOXVyLt5fNVwOWFwYY3hjEHzAzQkBzVpdwhxf+0OK8
         d05A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=lbPABvMzpD16IoGjcR18rZ9jk/Jm5H+LR+KnJ0h6P9o=;
        b=DSv9vuCl0Dfeo99QJCuOt8vEcasmd757gEiX/Qlwrf6sO10JAq/uH6DkAIK8WYfvVt
         HWn1BxSwVyaoAcohMTmmXFp+W4llVB/z/T4zHgLZQSio4a6WGadmwtRaUtzfBPIQj4B5
         skqPrCZI2yySk2sfChxUqPPZOiA0PZ0t4U2XuTvBQIb6095uL5l+UNHqiGbP+DUsQrvM
         5uMQnx2mUg2yWjrLK5YBRTJrFp5p9xKXGt6Ce5WCnxzH0xYnaC5uIAfZai9AGiFTo0k+
         lvjV18/7Dup3F2Hm9ggMW1e2T2P2Sxc+que5+4tF4muVo8ww8UjZ+OAR+v19etv/yCbG
         SRTQ==
X-Gm-Message-State: AOAM533KVeI73Cf5FF31Nr60es2ElAjziTrkvp+3B7ZF5Sa56ntM5eM4
        W62Ap72povesjd0VXx7zn+BN1A==
X-Google-Smtp-Source: ABdhPJy+fpsQJTJlrxJnTEweCzbNGnmGrsHpVGQLNOWfRu5/TkiMft9D7QDZ1wSd0Knvmr6RFx47Cg==
X-Received: by 2002:a62:6047:0:b029:1ac:6091:cf50 with SMTP id u68-20020a6260470000b02901ac6091cf50mr12104240pfb.40.1611775015238;
        Wed, 27 Jan 2021 11:16:55 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id p2sm3068402pjj.0.2021.01.27.11.16.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jan 2021 11:16:54 -0800 (PST)
Message-ID: <6011bc26.1c69fb81.b724c.6d83@mx.google.com>
Date:   Wed, 27 Jan 2021 11:16:54 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.11-rc5-62-g93c3d4245f20
X-Kernelci-Report-Type: test
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
Subject: pm/testing sleep: 5 runs, 1 regressions (v5.11-rc5-62-g93c3d4245f20)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing sleep: 5 runs, 1 regressions (v5.11-rc5-62-g93c3d4245f20)

Regressions Summary
-------------------

platform        | arch  | lab           | compiler | defconfig | regressions
----------------+-------+---------------+----------+-----------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-8    | defconfig | 1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.11-rc=
5-62-g93c3d4245f20/plan/sleep/

  Test:     sleep
  Tree:     pm
  Branch:   testing
  Describe: v5.11-rc5-62-g93c3d4245f20
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      93c3d4245f208b925982f9e9bef346f47dff0157 =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig | regressions
----------------+-------+---------------+----------+-----------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-8    | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/6011afe7db13b2f9d3d3dfc9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.11-rc5-62-g93c3d=
4245f20/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.11-rc5-62-g93c3d=
4245f20/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2021=
0125.1/arm64/rootfs.cpio.gz =



  * sleep.login: https://kernelci.org/test/case/id/6011afe7db13b2f9d3d3dfca
        failing since 161 days (last pass: v5.8-107-gb72b3ea38c81, first fa=
il: v5.9-rc1-4-g1f08d51cd57f) =

 =20
