Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4123E2AC64F
	for <lists+linux-pm@lfdr.de>; Mon,  9 Nov 2020 21:52:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729499AbgKIUwF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 9 Nov 2020 15:52:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbgKIUwF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 9 Nov 2020 15:52:05 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02EBEC0613CF
        for <linux-pm@vger.kernel.org>; Mon,  9 Nov 2020 12:52:04 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id cp9so1884949plb.1
        for <linux-pm@vger.kernel.org>; Mon, 09 Nov 2020 12:52:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=HCEygShikjcn0mo9rIjurrhdSWLZkxQTDAX5H2JQzBg=;
        b=uqc3R/ybpsAfJWbbhmO7WXc/8gbSmxK2CUUYpwmnEXFmpBWxAmyZU6lQFpxeEKfujj
         Scdo4la2+Q165h+rN6e1LwW22vYlvxYTetXmME2OIFwm+Q23lwpAPeWlXA6SRIAKY3xB
         +R4aAklHnyCRSWNI22PmJpyFdddqA3X1TVb/itOZQCegHeF/oW6Hrlisyr8XFJ9InPy1
         Vspz49LgFLNMGId0BmbjOzI6yXP3B9GApalNAuqOSD8evmrrRSybgU9Sf3KdnPSqAcg8
         KlPaI/5f+IsefdRG0UZYltka5Gm8sXKLKODaCqJwnkDfQVJC8yvNbfg/bsuI3aFB+NPQ
         qeCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=HCEygShikjcn0mo9rIjurrhdSWLZkxQTDAX5H2JQzBg=;
        b=AYkXivwKmYTSI7URSlFJFjFgnnDbXylWdr3cdnZ8PHFCzYM5g2FRF9N5M9Hvd1Fsur
         HKcFZGp5TzONzYk8CESAfphZjaZUyYeFFvLlHTadH+NII6oAyHw6qUJ2kJMiht2mKueY
         KnN6gRokZel0AaOE/tjq1/lDWleaapz3+W14RXLRPLHwTxwOXAZPtIaFcRlbok5Zs6fk
         ul65MsB6NldkLdUWt/zsk3xa5mipcQ2M5/fA16RPSDdMHe9pa+MCGMc5K8b+ehzIu5wG
         d61MoZCFLz8orWvIASqizQgUw0QJVkZRDQlGxr03ssjyxMSVIYT3U1TKmJg7zxi9g6so
         IArg==
X-Gm-Message-State: AOAM531nEdiMNDScii+hqzgH+g6VxD8cFSLgHvvfm6R/WZ7EECtGEcIX
        Uj9WfZ9g0BMesC4SatN/E9o7GvUrlKcePA==
X-Google-Smtp-Source: ABdhPJxkYiVnJomrlS2hVTuuJKTq8Z23x1D9FXI4E70WNpOfgrG4s7ddUYlAAWYjh3a57iRw66HbrA==
X-Received: by 2002:a17:902:7049:b029:d7:e413:8aba with SMTP id h9-20020a1709027049b02900d7e4138abamr4963387plt.30.1604955124565;
        Mon, 09 Nov 2020 12:52:04 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id e81sm12085920pfh.104.2020.11.09.12.52.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 12:52:03 -0800 (PST)
Message-ID: <5fa9abf3.1c69fb81.d1be3.a010@mx.google.com>
Date:   Mon, 09 Nov 2020 12:52:03 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
X-Kernelci-Kernel: v5.10-rc3-14-g103ceda28388
Subject: pm/testing sleep: 4 runs, 1 regressions (v5.10-rc3-14-g103ceda28388)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing sleep: 4 runs, 1 regressions (v5.10-rc3-14-g103ceda28388)

Regressions Summary
-------------------

platform        | arch  | lab           | compiler | defconfig | regressions
----------------+-------+---------------+----------+-----------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-8    | defconfig | 1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.10-rc=
3-14-g103ceda28388/plan/sleep/

  Test:     sleep
  Tree:     pm
  Branch:   testing
  Describe: v5.10-rc3-14-g103ceda28388
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      103ceda2838877c8a62f904e886f7ca11a3bb1c1 =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig | regressions
----------------+-------+---------------+----------+-----------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-8    | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/5fa99f9c3cf514c195db8854

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.10-rc3-14-g103ce=
da28388/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.10-rc3-14-g103ce=
da28388/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2020=
1105.0/arm64/rootfs.cpio.gz =



  * sleep.login: https://kernelci.org/test/case/id/5fa99f9c3cf514c195db8855
        failing since 82 days (last pass: v5.8-107-gb72b3ea38c81, first fai=
l: v5.9-rc1-4-g1f08d51cd57f) =

 =20
