Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72A0C2AC60A
	for <lists+linux-pm@lfdr.de>; Mon,  9 Nov 2020 21:37:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbgKIUhQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 9 Nov 2020 15:37:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726952AbgKIUhP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 9 Nov 2020 15:37:15 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58050C0613CF
        for <linux-pm@vger.kernel.org>; Mon,  9 Nov 2020 12:37:15 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id w11so5310382pll.8
        for <linux-pm@vger.kernel.org>; Mon, 09 Nov 2020 12:37:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=Fk2R1hoCre+FTfwXbroDAJ5SPfR0in8m55fa3KawrZc=;
        b=iig0z8+3VkE9PmXpsgDGazpYkAYRt4bFSQlAIRru+TLVLBx7Drfqw1oCqGX0cJocxA
         2s17VYBNIvfIBezVx7dRwTXgVLbT18Qp/3diQBzN6LmsqSaHTeuRIxplCwUWs0E/M14t
         9m81nw27LZJKS0E9ke1+W5uQE/IWXCPYJkG2+7Tk5WJCXvGj7ey+W/TaEDJi/0OwvAer
         JUg4M2SPHvkQSgXlgpxmijDtc109CNZYW+Nhwa1xo4JQzcCVaRsT9Vw6sMAOwKWpEOYl
         PlXeUp9SrFoAGp3Fd7dar6UO/u/3Q0L380i0s8bPKKodPiyHm+9cp7beW3vPHoYpbJSa
         ZHwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=Fk2R1hoCre+FTfwXbroDAJ5SPfR0in8m55fa3KawrZc=;
        b=Qa1tP21FzrjGzqfiaDnXgfLp5HrfBeqBKk3PlYLzvSxE9aPUC3TsTs/kyLcJKBqhOL
         lQOrG5DzGIdMPGOL11+AISCee5npVRP//BaF7Hr0Tylq7a9G4GnGIfEz88tmSSV31zJC
         SS7eICVq6SlNDwxFMq0dPo480x1NUmNWgOD67SnoM+b2XETfKLFq/HHiwoNC4wvpc2Ja
         4b2yrfXiKRaf4du1exH/QAuFfFxFf8HGAgvHcSeyD9Cg+ZFTjmJuwavIPWHEkPV0HcSe
         ndTdpOejyQV7SyT36qVdpuoL7F51Q5CRuxyOYQkNdVOVsw0Uh4rBRW7MZ/U07vFQBKfz
         qPTg==
X-Gm-Message-State: AOAM5311pQmHZofbs0U2gZPFTLsnUvMgxwu1xNuQxWj7m/KZwXktU07C
        qftih6ujjXUrbdsSHB3SIy5M93F74tEv3Q==
X-Google-Smtp-Source: ABdhPJyVH2zYEwnWy21NcuCM/KVvM2xsFU9MJQtoS1uJz5EqL7DPvy9r4rp9Ax4GxmvObLUfeluxCg==
X-Received: by 2002:a17:902:ab85:b029:d6:b5d2:b6fd with SMTP id f5-20020a170902ab85b02900d6b5d2b6fdmr13618170plr.9.1604954234628;
        Mon, 09 Nov 2020 12:37:14 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id n72sm12442909pfd.202.2020.11.09.12.37.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 12:37:13 -0800 (PST)
Message-ID: <5fa9a879.1c69fb81.c7c96.a814@mx.google.com>
Date:   Mon, 09 Nov 2020 12:37:13 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
X-Kernelci-Kernel: v5.10-rc3-14-g103ceda28388
Subject: pm/testing baseline: 118 runs,
 1 regressions (v5.10-rc3-14-g103ceda28388)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 118 runs, 1 regressions (v5.10-rc3-14-g103ceda28388)

Regressions Summary
-------------------

platform   | arch  | lab     | compiler | defconfig | regressions
-----------+-------+---------+----------+-----------+------------
imx8mp-evk | arm64 | lab-nxp | gcc-8    | defconfig | 1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.10-rc=
3-14-g103ceda28388/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v5.10-rc3-14-g103ceda28388
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      103ceda2838877c8a62f904e886f7ca11a3bb1c1 =



Test Regressions
---------------- =



platform   | arch  | lab     | compiler | defconfig | regressions
-----------+-------+---------+----------+-----------+------------
imx8mp-evk | arm64 | lab-nxp | gcc-8    | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/5fa99ff7629fa51314db8857

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.10-rc3-14-g103ce=
da28388/arm64/defconfig/gcc-8/lab-nxp/baseline-imx8mp-evk.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.10-rc3-14-g103ce=
da28388/arm64/defconfig/gcc-8/lab-nxp/baseline-imx8mp-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-4-g97706c5d9567/arm64/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/5fa99ff7629fa51314db8=
858
        new failure (last pass: v5.10-rc3-7-g7c5e6f73cac0) =

 =20
