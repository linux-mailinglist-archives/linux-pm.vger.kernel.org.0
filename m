Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 796FD221360
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jul 2020 19:12:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725993AbgGORMT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 Jul 2020 13:12:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725838AbgGORMS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Jul 2020 13:12:18 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A69EFC061755
        for <linux-pm@vger.kernel.org>; Wed, 15 Jul 2020 10:12:18 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id mn17so3381030pjb.4
        for <linux-pm@vger.kernel.org>; Wed, 15 Jul 2020 10:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=fLZvnp+VlCFl1Z6yoxmKXgilfM403CskUy8duZ3791s=;
        b=tSV0jg+u5y502Ii87glkUUbEVsf6hqHaFZzLfrVFT4kouNsspIrO0h6iwJTh+RXB0u
         ZLoKeojRMhtUG4S2q2j3eMdTrtc1AZxZxgM4D/W7UZvAb8GiH7BuwGPMfYwU+JgUmAui
         n++mNP9NHwovleTKgoOpJshzVAb5irL9fkX7qvdqBEZP2Fyp4gaSD3VPJp9GCXxM3Fq3
         hlvLgLQjP/VjKlK/wsMWIQ/Tm9Ye9PGkABWbneyCaXzIkUfKW/K1BLLwio94mSX0sKHj
         gM5pKxgCf1OjjoMgI1LPyUsCEsVgrv5vGCU/dOjFxdAl+WSbVUQO2d3WLzl4dYQl+H6F
         UVCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=fLZvnp+VlCFl1Z6yoxmKXgilfM403CskUy8duZ3791s=;
        b=ggRGbl7waadYwJ3zACoqT3yvXcQ6ebtfqjFsN+Db8/xYaia25HOTqMxTTjlf8sF1FU
         Bl8Nx3GJ1YntxKrVbxtkevSxiQ0vNNlEHVaA7yDbOV+UKiF8abBK8D1HFyr/Hdid4mx/
         Vxr39aKkbdm3tweDJgVJbfH6qv417vsYZfEnOCtOeMwwlCDDYeG975HIuMR8mq/6Ty4o
         L3y5MLu3G7F07tZWUKMdHviSKMRKHRWFVSHox2btBYiiLC5OiIHkfaxfPVM1ntXZfOLD
         HFftneQgZQ6vPw0ui1bPnx/p0ZrBscV+B8oBZFPFrCc9uKPO8pYFwRKyxXBS939NeP+H
         5pTw==
X-Gm-Message-State: AOAM530vajklvCxQ24B5Xjlbcbyy2QUboS35k0lAV4gwYCxdhLOl+XIT
        HIfvy97JNwTS53tOuQv9Afodfg==
X-Google-Smtp-Source: ABdhPJx9jgLb2GI6fvOx4pzvpsBeYhdACT0el4RIjzMmdqygHQF+WRThCl2pAZGjUe+/dO2iPIdABA==
X-Received: by 2002:a17:90a:f695:: with SMTP id cl21mr685963pjb.86.1594833138105;
        Wed, 15 Jul 2020 10:12:18 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id b205sm2453010pfb.204.2020.07.15.10.12.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 10:12:17 -0700 (PDT)
Message-ID: <5f0f38f1.1c69fb81.fd895.66bc@mx.google.com>
Date:   Wed, 15 Jul 2020 10:12:17 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.8-rc5-46-g8d0151344351
X-Kernelci-Report-Type: test
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
Subject: pm/testing baseline: 65 runs,
 1 regressions (v5.8-rc5-46-g8d0151344351)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 65 runs, 1 regressions (v5.8-rc5-46-g8d0151344351)

Regressions Summary
-------------------

platform        | arch  | lab          | compiler | defconfig | results
----------------+-------+--------------+----------+-----------+--------
bcm2837-rpi-3-b | arm64 | lab-baylibre | gcc-8    | defconfig | 4/5    =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.8-rc5=
-46-g8d0151344351/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v5.8-rc5-46-g8d0151344351
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      8d01513443514b97657e43e2c02ca3aff58ae0a3 =



Test Regressions
---------------- =



platform        | arch  | lab          | compiler | defconfig | results
----------------+-------+--------------+----------+-----------+--------
bcm2837-rpi-3-b | arm64 | lab-baylibre | gcc-8    | defconfig | 4/5    =


  Details:     https://kernelci.org/test/plan/id/5f0f2f183b6b175b1f85bb28

  Results:     4 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.8-rc5-46-g8d0151=
344351/arm64/defconfig/gcc-8/lab-baylibre/baseline-bcm2837-rpi-3-b.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.8-rc5-46-g8d0151=
344351/arm64/defconfig/gcc-8/lab-baylibre/baseline-bcm2837-rpi-3-b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05/arm64/baseline/rootfs.cpio.gz =


  * baseline.dmesg.crit: https://kernelci.org/test/case/id/5f0f2f183b6b175b=
1f85bb2b
      new failure (last pass: v5.8-rc5-44-g71865a3b9f0a)
      2 lines =20
