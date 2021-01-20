Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 225162FDCE6
	for <lists+linux-pm@lfdr.de>; Thu, 21 Jan 2021 00:39:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730699AbhATVZT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 20 Jan 2021 16:25:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388556AbhATVRG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 20 Jan 2021 16:17:06 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86252C0613D6
        for <linux-pm@vger.kernel.org>; Wed, 20 Jan 2021 13:16:20 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id b8so13239939plx.0
        for <linux-pm@vger.kernel.org>; Wed, 20 Jan 2021 13:16:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=ca+8NzTfETzVE4+uw+qveOGQYKjaycmberW1KwYsv+g=;
        b=sp/+zyym2ObOAZ5VSgKGDvFyd7fzMiEelycw2XiJgLanPAV191du/v4seZcP2n1ckS
         14O504wPDap2gIAXzcaB/PQnNGWe0xB5neErN1fyt3P41nv3RkeBk/ilNj6zXtdahhHo
         I8K+OTjgm5aURXGPoa+cSxvje004UqQMR7ejb0dF0m6CU+YR185Pskgmy7TQazkfD8E5
         gNfEpWMUecYuiBrLN/ad5GzWAPFClDd2KIdrBqCNKXMtkeEwBEHahx2/gbNVbE/xk2/V
         V93OlgwEvSV2JRtRHvnFizXWIP83SwZQf/MlPOfVQiVJD8WYXW//tjWbv9MDssegIoLd
         ZCUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=ca+8NzTfETzVE4+uw+qveOGQYKjaycmberW1KwYsv+g=;
        b=YuBPImg9WNnOvrY1hrsC4dlJBsZGUNOxMNjtPzJis1gqbYdzJmvXfRLH7tHeCIPEtl
         jw/B5Nzf1IKhDgnI8Ks1kTEZlTXiBhjRfh0lDuLKuFlgJHvfJnb7DwhDPrULoYh27k+l
         mgMkqfRFUNipNXvYwowF2xmTTK4//jQX2AcU2dMXQwn2CL0PRj5wO6/LMKNxUb3S7AH1
         Gz3ez+/3MLgK/cb2XGT79wM5qN4SITKhhzlz8jLG7W4jGTX+jqjTqHKAX6bm3+9damx+
         6W2tcHb+TIbTT3iJ69InuFrre+84A56s9YAxIg9vdGvlkWUyfnch8b63VGtAjJGznL2R
         62lA==
X-Gm-Message-State: AOAM53368rnHR4UxMv49YhgwNc4zxOMYBFiS0dsdhVTQoKPMWaZKFtKX
        WITLdXO19N0+nsVE1u8bxz68tg==
X-Google-Smtp-Source: ABdhPJw4pOCKvDfQNI0uJJUeDzQYXxP9mahfTb+hb/0MVvzM3/BurD6mZpkApPxQpERLeXet9cWjkw==
X-Received: by 2002:a17:90a:4cc5:: with SMTP id k63mr7552829pjh.202.1611177380010;
        Wed, 20 Jan 2021 13:16:20 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id n128sm3487876pga.55.2021.01.20.13.16.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 13:16:19 -0800 (PST)
Message-ID: <60089da3.1c69fb81.bbd1d.859a@mx.google.com>
Date:   Wed, 20 Jan 2021 13:16:19 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.11-rc4-28-ga31400ec480e
Subject: pm/testing sleep: 4 runs, 1 regressions (v5.11-rc4-28-ga31400ec480e)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing sleep: 4 runs, 1 regressions (v5.11-rc4-28-ga31400ec480e)

Regressions Summary
-------------------

platform        | arch  | lab           | compiler | defconfig | regressions
----------------+-------+---------------+----------+-----------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-8    | defconfig | 1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.11-rc=
4-28-ga31400ec480e/plan/sleep/

  Test:     sleep
  Tree:     pm
  Branch:   testing
  Describe: v5.11-rc4-28-ga31400ec480e
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      a31400ec480e8a579467fbe36d7ea49c952109dc =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig | regressions
----------------+-------+---------------+----------+-----------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-8    | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/60088d0d11d9b575b6bb5d49

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.11-rc4-28-ga3140=
0ec480e/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.11-rc4-28-ga3140=
0ec480e/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2021=
0118.2/arm64/rootfs.cpio.gz =



  * sleep.login: https://kernelci.org/test/case/id/60088d0d11d9b575b6bb5d4a
        failing since 154 days (last pass: v5.8-107-gb72b3ea38c81, first fa=
il: v5.9-rc1-4-g1f08d51cd57f) =

 =20
