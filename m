Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8A9861FD6D
	for <lists+linux-pm@lfdr.de>; Mon,  7 Nov 2022 19:23:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232038AbiKGSXw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 7 Nov 2022 13:23:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233133AbiKGSXd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 7 Nov 2022 13:23:33 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B4CA27145
        for <linux-pm@vger.kernel.org>; Mon,  7 Nov 2022 10:23:17 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id g24so11835576plq.3
        for <linux-pm@vger.kernel.org>; Mon, 07 Nov 2022 10:23:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=FH+REYnq7wMCMGNPtMGHxqk5OZxMXnuvqZGMDla2v4A=;
        b=a+fAZRZ9wCKXMglYWkj84yO5klEKmgTJqP4VK8GJaEd3pJngC6mtGatcBBEKbMUKIR
         eW0kVJP9GOt9vE95eXfFfSRM2PXPE7bT2aEStL1piwSVKqX8x13j+k9dHGpd6tm9xjmU
         1CvQv9D4FetpPZRsrVoxySZ4BH67xY9i5RrlU1kVJdXi7ZO4cLR4Q1opTucyV4Wtn5SP
         nqlwjotiws8oN3QNfEe7DqIjUL58HXasj1SE2Qmmb+yjhPjn6i25gfcCsbLXLWLeVGOo
         wLsECUa0N59sVtFLWFnNFDQwYZolh7UPJaC7HfbYylXCzigzTUnjx1nfTHm5SWS90E2Y
         BxYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FH+REYnq7wMCMGNPtMGHxqk5OZxMXnuvqZGMDla2v4A=;
        b=bk8US7fczJbNN4Tp43cSb8PN3xDb5GIlsRs4PEoDFqwEghxndFAmcwOptbmrP8JrwQ
         o19b5ArGy5jTH/e9MVD7zoLbmh07p6Dn1pLIFlM9HpOT3GiGuN37YMTJwe1IyzkCu5yb
         ZzBwN8o6PfE9lw96p6/QAoYYDvR06mR1C/Jw7OCkTAjT/hsSOCOifw71Qexb3by3mnc7
         /xIfkCZnra4oOFTEseuG7uaTVa6k6wWbbMntdf3qP65iCb2FE9mLOAEmImnPK8HUvUBx
         Pn4Kgq6dCFxtTvU/yXDYm+BCGG8s9+68SSoBGqfEyza2KmuRafPrHmfxwRmgiP1v4BPX
         Safw==
X-Gm-Message-State: ACrzQf0DGGuKiOnP/aaCpbbyBRWR9gQuniL4D2XgpTidV4L51VN9y3rn
        qm3bghgem22WjMb0RgtoFyk1+A==
X-Google-Smtp-Source: AMsMyM7cyhj7QRt3X7ZoFLSjOirAVfrluI2Zdlepp3EMn2o31ysf5NZC6iZRM+lss/5/QXgRxw9Plw==
X-Received: by 2002:a17:90a:d244:b0:213:aa62:7a91 with SMTP id o4-20020a17090ad24400b00213aa627a91mr50279142pjw.101.1667845396796;
        Mon, 07 Nov 2022 10:23:16 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id q8-20020a17090311c800b00186b5c1a715sm2654342plh.182.2022.11.07.10.23.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 10:23:16 -0800 (PST)
Message-ID: <63694d14.170a0220.7f177.41d9@mx.google.com>
Date:   Mon, 07 Nov 2022 10:23:16 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.1-rc4-46-gef614051a953
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
Subject: pm/testing baseline: 64 runs,
 2 regressions (v6.1-rc4-46-gef614051a953)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 64 runs, 2 regressions (v6.1-rc4-46-gef614051a953)

Regressions Summary
-------------------

platform           | arch | lab             | compiler | defconfig         =
 | regressions
-------------------+------+-----------------+----------+-------------------=
-+------------
imx6ul-pico-hobbit | arm  | lab-pengutronix | gcc-10   | multi_v7_defconfig=
 | 1          =

imx7ulp-evk        | arm  | lab-nxp         | gcc-10   | multi_v7_defconfig=
 | 1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v6.1-rc4=
-46-gef614051a953/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v6.1-rc4-46-gef614051a953
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      ef614051a953a2de0c3b962e6baf3637c5a9d63a =



Test Regressions
---------------- =



platform           | arch | lab             | compiler | defconfig         =
 | regressions
-------------------+------+-----------------+----------+-------------------=
-+------------
imx6ul-pico-hobbit | arm  | lab-pengutronix | gcc-10   | multi_v7_defconfig=
 | 1          =


  Details:     https://kernelci.org/test/plan/id/63694635b6281b1f03e7db62

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.1-rc4-46-gef6140=
51a953/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx6ul-pico-h=
obbit.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.1-rc4-46-gef6140=
51a953/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx6ul-pico-h=
obbit.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20221024.1/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63694635b6281b1f03e7d=
b63
        failing since 101 days (last pass: v5.19-rc8-79-gb3f10ca8bf191, fir=
st fail: v5.19-rc8-92-ge240a33f1bc48) =

 =



platform           | arch | lab             | compiler | defconfig         =
 | regressions
-------------------+------+-----------------+----------+-------------------=
-+------------
imx7ulp-evk        | arm  | lab-nxp         | gcc-10   | multi_v7_defconfig=
 | 1          =


  Details:     https://kernelci.org/test/plan/id/636945eaf646ca3fd0e7db5f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.1-rc4-46-gef6140=
51a953/arm/multi_v7_defconfig/gcc-10/lab-nxp/baseline-imx7ulp-evk.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.1-rc4-46-gef6140=
51a953/arm/multi_v7_defconfig/gcc-10/lab-nxp/baseline-imx7ulp-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20221024.1/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/636945eaf646ca3fd0e7d=
b60
        failing since 38 days (last pass: pm-6.0-rc7-143-g00674ddf1b594, fi=
rst fail: v6.0-rc7-186-gfa11712315997) =

 =20
