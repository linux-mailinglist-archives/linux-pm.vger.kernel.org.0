Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30CCF28C775
	for <lists+linux-pm@lfdr.de>; Tue, 13 Oct 2020 05:04:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728444AbgJMDEZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 12 Oct 2020 23:04:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727888AbgJMDEY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 12 Oct 2020 23:04:24 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69A4BC0613D0
        for <linux-pm@vger.kernel.org>; Mon, 12 Oct 2020 20:04:23 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id n9so16484611pgf.9
        for <linux-pm@vger.kernel.org>; Mon, 12 Oct 2020 20:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=Fmf0Dr/6TkMBH9VRjbDNvQL/ij7oqtVo3SaqQEHtPGo=;
        b=unNFefM13iDiM4iXKr0dMyy3ExEG1UN7OprOCTAg4L13f+K8Y4VyUHAZAtMC0aOCqG
         vujXuzjugTi/JsJsW2Jt//USbyAh3a2cmtc5gGURhij8qg92N1g8Tid/RCRXVJGg+OzU
         3iUgujyErdsMN8YPEbKgxWSialEvAuayPC5I5a4GCUKO6zSTyhKLJpzc74hp7bWY/4ph
         or7h74gqqFJFxG5R0kSpqVicbuizHq5mZY8RN/PdLOrkn+9BSNTHDQ88afEdQwoEjWJR
         mEKhOrMn9Y6tgEIKBXWO5g1T8Dw6dZT1SzrNgpepV1pdrtXJXukTgJk5Lk4esEm12DVR
         VK+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=Fmf0Dr/6TkMBH9VRjbDNvQL/ij7oqtVo3SaqQEHtPGo=;
        b=jZDpNz1Te1EIi+WD0MQo9P5kOH3yBwTTV3o4TcztQtwitMVhVJBNjB93TidKKbdf7V
         KzpwircxeIV6KhohKxvrULSp/rlqopVy6rL15835QIIm2dBNtN0a6tnZmKYMpDwg+cci
         4NBRKq67zaMNxWl9N73br0nXIyocqTpzhmbKRKwmOoI67KvxmRfzBHRt+zf/rHqSmQqx
         gAds4HvDeQ23qL1OBKPrxpEXZ/fPAnqP4c7dLNRfY2Mt5rvv7iDaYmtr6tjtcIkLoeKB
         Ngq3epjbjTXcIfqX5QhIfLTap1uD9n17hP/1Xz5q+/ozIHMltoyLMNFRchXrrYqcPBFC
         TiFw==
X-Gm-Message-State: AOAM531Ym43ht5VkcFAiieO7ZiaPQOYbobVgoLGEXzNYeQ/nW6PRBZqK
        P1n/uhuEViTZO9NqaMOqCRggmT2/nxBBMA==
X-Google-Smtp-Source: ABdhPJyB1WjdHapGHpKtIEviSuC8HkE5C7jRmmfxSATSEw7yWIPEms4tiZbEB21UTP1ODtgyhIH9Mg==
X-Received: by 2002:a17:90b:388b:: with SMTP id mu11mr3581186pjb.204.1602558262830;
        Mon, 12 Oct 2020 20:04:22 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id gg24sm24940447pjb.44.2020.10.12.20.04.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2020 20:04:22 -0700 (PDT)
Message-ID: <5f851936.1c69fb81.4ad34.1474@mx.google.com>
Date:   Mon, 12 Oct 2020 20:04:22 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.9-rc8-160-g91e0225c546b
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
Subject: pm/testing sleep: 6 runs, 1 regressions (v5.9-rc8-160-g91e0225c546b)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing sleep: 6 runs, 1 regressions (v5.9-rc8-160-g91e0225c546b)

Regressions Summary
-------------------

platform        | arch  | lab           | compiler | defconfig | results
----------------+-------+---------------+----------+-----------+--------
mt8173-elm-hana | arm64 | lab-collabora | gcc-8    | defconfig | 0/1    =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.9-rc8=
-160-g91e0225c546b/plan/sleep/

  Test:     sleep
  Tree:     pm
  Branch:   testing
  Describe: v5.9-rc8-160-g91e0225c546b
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      91e0225c546b542d828011feef9fb155e18b7941 =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig | results
----------------+-------+---------------+----------+-----------+--------
mt8173-elm-hana | arm64 | lab-collabora | gcc-8    | defconfig | 0/1    =


  Details:     https://kernelci.org/test/plan/id/5f84fad0f69fd991e04ff3eb

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.9-rc8-160-g91e02=
25c546b/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.9-rc8-160-g91e02=
25c546b/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2020=
1002.0/arm64/rootfs.cpio.gz =


  * sleep.login: https://kernelci.org/test/case/id/5f84fad0f69fd991e04ff3ec
      failing since 54 days (last pass: v5.8-107-gb72b3ea38c81, first fail:=
 v5.9-rc1-4-g1f08d51cd57f)  =20
