Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 981F3334848
	for <lists+linux-pm@lfdr.de>; Wed, 10 Mar 2021 20:48:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233386AbhCJTrv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 10 Mar 2021 14:47:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233585AbhCJTrj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 10 Mar 2021 14:47:39 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F0C7C061760
        for <linux-pm@vger.kernel.org>; Wed, 10 Mar 2021 11:47:39 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id ba1so9021066plb.1
        for <linux-pm@vger.kernel.org>; Wed, 10 Mar 2021 11:47:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=tuqAvM/W+SWW8efRf3VoLyCzXUTJlGvbrhUBH+16mGE=;
        b=WelLdbX9omvfWE6Td2NPbE+CEMRH6tp5K8p2R49PNJyopmd9cj5dkZ4s+PtKnj5Z1J
         ko9grKLaRP5Mtl5L1IyTL5YtgGxTLdtqjZXt9SRG4ovAQobq47qBbbVN204AOXvplrsq
         KHh/cNfaMIpsObGfIsCJlk3qqcLGC0RzhMgn2NiHXPr/DP1oolTVt8sQ7S55C1jp4d1V
         rA0w/wolxi97n4Ahkx9UP+B7NVrObwjTx1mlsV81ETVABc4QDjjogzMEH7pkYW6HqwlA
         qroyvjZ8/fE7F9s2dXJmHbxFDIrssxfIeolRzQ4tZ6UKebSkyem9K4R3T1gD/lFTPfuM
         s+vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=tuqAvM/W+SWW8efRf3VoLyCzXUTJlGvbrhUBH+16mGE=;
        b=umiRu3oHJdbnk4iUMZH3GmIEkJeTQIQR2W0TK3S0pV7XMc11Mcr2TFUSaLXytDC4A/
         DXpwRk07X4ebGAsAFDL2UvCF10EBvSk90XjyiPQ+wenZt8kBcTJNloXM9u7A4f4+eAAu
         zM24c33X44K3bKTSFCNi+eRE09qla1QmmdDdwwM3HOFBBr5wcEIozQKUtReGGPLUmiAx
         /TywoWkSft9n5GSuy4vGJ/IvE9qPl8hiD4DuQJVcnt+66yPpXxRvX7izGzp50U1sk/31
         6CXXynCsmnOHWxiZDm0WlDYhjw0i6RBcNA+DpMXW9SXwGx8NOWA4x+frw+1O7aXIoK9q
         iLTg==
X-Gm-Message-State: AOAM532BQKFCVIaN548BR6qdqoqr0Q3uwgE25vRI3+/6nQg2t/VHfzCb
        CAHOjz1qC4lto8FE7exG44NV1CHRyll7+N4c
X-Google-Smtp-Source: ABdhPJzkQE+LQAVOwR/3jZ1psjA+kChNHbDz9BROWgL5eAjZsAEQoKn+CBnVKFYWvm2qoOoxlWhUuA==
X-Received: by 2002:a17:90a:3cc6:: with SMTP id k6mr5150305pjd.212.1615405659144;
        Wed, 10 Mar 2021 11:47:39 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id s1sm280420pfe.151.2021.03.10.11.47.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 11:47:38 -0800 (PST)
Message-ID: <6049225a.1c69fb81.ac0c2.113a@mx.google.com>
Date:   Wed, 10 Mar 2021 11:47:38 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.12-rc2-28-g8608bdeb4cdb
X-Kernelci-Report-Type: test
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
Subject: pm/testing baseline: 102 runs,
 1 regressions (v5.12-rc2-28-g8608bdeb4cdb)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 102 runs, 1 regressions (v5.12-rc2-28-g8608bdeb4cdb)

Regressions Summary
-------------------

platform   | arch  | lab     | compiler | defconfig | regressions
-----------+-------+---------+----------+-----------+------------
imx8mp-evk | arm64 | lab-nxp | gcc-8    | defconfig | 1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.12-rc=
2-28-g8608bdeb4cdb/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v5.12-rc2-28-g8608bdeb4cdb
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      8608bdeb4cdb5608b4073077e6e5d7bdedefd169 =



Test Regressions
---------------- =



platform   | arch  | lab     | compiler | defconfig | regressions
-----------+-------+---------+----------+-----------+------------
imx8mp-evk | arm64 | lab-nxp | gcc-8    | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/60491a00c6a7c09d43addd17

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.12-rc2-28-g8608b=
deb4cdb/arm64/defconfig/gcc-8/lab-nxp/baseline-imx8mp-evk.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.12-rc2-28-g8608b=
deb4cdb/arm64/defconfig/gcc-8/lab-nxp/baseline-imx8mp-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-4-g97706c5d9567/arm64/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/60491a00c6a7c09d43add=
d18
        failing since 19 days (last pass: pm-5.11-rc8-201-g8b72d3aa065c, fi=
rst fail: pm-5.11-rc8-205-g4475f0291af9) =

 =20
