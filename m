Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 850883A726F
	for <lists+linux-pm@lfdr.de>; Tue, 15 Jun 2021 01:23:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbhFNXZW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 14 Jun 2021 19:25:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbhFNXZV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 14 Jun 2021 19:25:21 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C499C061574
        for <linux-pm@vger.kernel.org>; Mon, 14 Jun 2021 16:23:02 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id v7so1177628pgl.2
        for <linux-pm@vger.kernel.org>; Mon, 14 Jun 2021 16:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=dQgm45qHmo75g30KS0QvvKtvmp+PT8sY9hRxOfTgw5Y=;
        b=DgtDfPIcbELHNU/mvOO8YWeSFJQfDGOwl5c2D9wb7fFffEgOe6KbDfDzzsR3F5KUI7
         B0OiEnvMq5dRSVzqmMVPLVvpnTCsEXyQVgSpjTn9mHtC+XBAhNws2xLtwmfQM2/XMcCi
         W5uaxwZSPL87Ygo/1B01FsXE91dF1XlfrJDBD7T5qEEtQdZOzOUDgttxIyJC6P+O01FP
         ce1XX1Eh9BdhODJApMRctfrS1rKe3kfJDtbqGZjTRAO42lqs6oSdu1rYZFmSR6nkEQ5v
         7d4H0uiC//5uW9SSLJPrwU5HG7lHkz4PauuSoa/zufiE6U356V2MB4YxUkhMSCx2oY7m
         u0qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=dQgm45qHmo75g30KS0QvvKtvmp+PT8sY9hRxOfTgw5Y=;
        b=Kv74H9NsKtRyBzcedzfr61pl2rV7jAC3s4LU78Icaed6z58HQ0u3g3cdCXMN6v2L1J
         u2f5av56Fy2aak245SAHfTSxPYEXR4OrebTVGIi5zyJSV8eYne+WEZmYa0MIxL5Wjmhp
         tNRmjxqtboqiPpUDTVYhTfuIh6nSfAZjqQRPbPAcLxYYdHbvUUij0BE5kZ4RaHDGFRvm
         faUMaiPHGwmoeJ/n7D8vqnyoWLspvBlqanQFH1nhsw0AfPOCbt2OL5D4ziC8EiD4LTji
         ZrWXgf7RemmdXvbCajL90m0+0Wl5bhoy793824qJN0DCzp6XYoza+oJbdodH46DJe/HM
         o1sw==
X-Gm-Message-State: AOAM532D70c+Q5Z7aPgUXagq4RGVetfDWBy9wSMJ+oHsYhudC6XA1N/3
        rxlTJSUPjxSluiS7qXAa3PPGGTiros5z1NTm
X-Google-Smtp-Source: ABdhPJzrayvEZpjhMGZRqiHd0bki3h5x8agryrorjnl3ZaloU0TElyywIBYllHjvqb7Ztram4Cu58Q==
X-Received: by 2002:a05:6a00:13a3:b029:2f9:30cc:6eec with SMTP id t35-20020a056a0013a3b02902f930cc6eecmr1387001pfg.44.1623712981764;
        Mon, 14 Jun 2021 16:23:01 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id m2sm13184460pjf.24.2021.06.14.16.23.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 16:23:01 -0700 (PDT)
Message-ID: <60c7e4d5.1c69fb81.a6034.6bc0@mx.google.com>
Date:   Mon, 14 Jun 2021 16:23:01 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.13-rc6-116-ga206065a8406
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
Subject: pm/testing sleep: 2 runs, 1 regressions (v5.13-rc6-116-ga206065a8406)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing sleep: 2 runs, 1 regressions (v5.13-rc6-116-ga206065a8406)

Regressions Summary
-------------------

platform        | arch  | lab           | compiler | defconfig | regressions
----------------+-------+---------------+----------+-----------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-8    | defconfig | 1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.13-rc=
6-116-ga206065a8406/plan/sleep/

  Test:     sleep
  Tree:     pm
  Branch:   testing
  Describe: v5.13-rc6-116-ga206065a8406
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      a206065a840616e966a96a148a690b169746b642 =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig | regressions
----------------+-------+---------------+----------+-----------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-8    | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/60c7d82b3e94ec3236413287

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.13-rc6-116-ga206=
065a8406/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.13-rc6-116-ga206=
065a8406/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2021=
0520.0/arm64/rootfs.cpio.gz =



  * sleep.login: https://kernelci.org/test/case/id/60c7d82b3e94ec3236413288
        failing since 299 days (last pass: v5.8-107-gb72b3ea38c81, first fa=
il: v5.9-rc1-4-g1f08d51cd57f) =

 =20
