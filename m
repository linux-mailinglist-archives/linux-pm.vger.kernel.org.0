Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50D88265029
	for <lists+linux-pm@lfdr.de>; Thu, 10 Sep 2020 22:06:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726301AbgIJUGT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 10 Sep 2020 16:06:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbgIJUDm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 10 Sep 2020 16:03:42 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADCF7C0613ED
        for <linux-pm@vger.kernel.org>; Thu, 10 Sep 2020 13:03:42 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id s65so3804891pgb.0
        for <linux-pm@vger.kernel.org>; Thu, 10 Sep 2020 13:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=iFDficNSci8qA9wFNJyygKnNTt9O8nMrmuFz9yCV5pU=;
        b=ThfftGYqDO/6Ienq1czqP2kID3lipFmYlCjShbBFc67WGmMHoW3c+CzljeUYsA5WxD
         K30jslTQU03cqtaQlcu5qhp3DKxEt/49q+/rbfeepllAnKkTTx5n5ZwR2Wkd6KH75JSf
         oM4qDeDKaQ4yZN5CfArbQjUh1nH8zoA1JvK2HshJj5S6kQBHEONJaVMTVUmtb1kDodvz
         t2Tu19pE5VcDe8439to8tgoxpna6TKmWYZg7W6xmwgcjtIgFhyBrwaeKTZBnQ5a7i8PV
         i2yKJ9ec2v9j+IwJ07cnWkbXSjJp0xrXpgI6SwmnueXuBGCccP6vNMJmpaOvP9IdpQLW
         K3xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=iFDficNSci8qA9wFNJyygKnNTt9O8nMrmuFz9yCV5pU=;
        b=XtFHFZ9zDrRpEfLGvv3RxxRyQKJYP1/ga38/9nXTYrl/ZA+s2UM3krslz3Sm6XOSTC
         S4UKG+yeDp25JLy5azR2kV1sk+M40M+acv466BL38ZjTIZIeMzkHX5aWMdhL+8TDS224
         EOYMjUSwW/HftgXfUotjWTWEqqUF9r3z3djh6C7EXDBzhqe+5YO82kQdhe7ByYI/RiUn
         +IkgWQxV8EKfbTqOTCoGArvGgkFPZqv9Z90R8tkP3WxeWi7DEy/W1T0u68VrRWW0YGin
         vbhpk/yVELY4n7zpm8nMKVFkJcjW6JF+x0rkzsYMF4k00/5KwPzei98Y0CIA0MKkIPCl
         rvcg==
X-Gm-Message-State: AOAM531RIHV6KJmlOLiCKqKkUzs7XOetiSSvFrYvsx5N+jtO4E8JQwYG
        SzBGIB+2La+0woM/fckozofihIJPO2Br7g==
X-Google-Smtp-Source: ABdhPJwqA/dpRqgQMWYbg5XxNFJTi7KZYE4QizEhVeS6IzYSF6yn2tuzxQIbOEErZ9tYxbshui9NsQ==
X-Received: by 2002:aa7:961b:0:b029:13e:d13d:a140 with SMTP id q27-20020aa7961b0000b029013ed13da140mr7145098pfg.40.1599768222252;
        Thu, 10 Sep 2020 13:03:42 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id j19sm7020415pfe.108.2020.09.10.13.03.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 13:03:41 -0700 (PDT)
Message-ID: <5f5a869d.1c69fb81.d5c26.2b8a@mx.google.com>
Date:   Thu, 10 Sep 2020 13:03:41 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.9-rc4-6-g23818c154bae
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
Subject: pm/testing sleep: 6 runs, 1 regressions (v5.9-rc4-6-g23818c154bae)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing sleep: 6 runs, 1 regressions (v5.9-rc4-6-g23818c154bae)

Regressions Summary
-------------------

platform        | arch  | lab           | compiler | defconfig | results
----------------+-------+---------------+----------+-----------+--------
mt8173-elm-hana | arm64 | lab-collabora | gcc-8    | defconfig | 0/1    =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.9-rc4=
-6-g23818c154bae/plan/sleep/

  Test:     sleep
  Tree:     pm
  Branch:   testing
  Describe: v5.9-rc4-6-g23818c154bae
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      23818c154baeeb4bb6a8de39cdb9b1e589b6416a =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig | results
----------------+-------+---------------+----------+-----------+--------
mt8173-elm-hana | arm64 | lab-collabora | gcc-8    | defconfig | 0/1    =


  Details:     https://kernelci.org/test/plan/id/5f5a762b37624b2991d35392

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.9-rc4-6-g23818c1=
54bae/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.9-rc4-6-g23818c1=
54bae/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2020=
0821.0/arm64/rootfs.cpio.gz =


  * sleep.login: https://kernelci.org/test/case/id/5f5a762b37624b2991d35393
      failing since 22 days (last pass: v5.8-107-gb72b3ea38c81, first fail:=
 v5.9-rc1-4-g1f08d51cd57f)  =20
