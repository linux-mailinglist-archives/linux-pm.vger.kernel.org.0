Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16C2A2042AA
	for <lists+linux-pm@lfdr.de>; Mon, 22 Jun 2020 23:28:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730528AbgFVV2b (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 22 Jun 2020 17:28:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730430AbgFVV2b (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 22 Jun 2020 17:28:31 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 553BCC061573
        for <linux-pm@vger.kernel.org>; Mon, 22 Jun 2020 14:28:31 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id p11so307146pff.11
        for <linux-pm@vger.kernel.org>; Mon, 22 Jun 2020 14:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=4EPaqEwekZ/Ix6DgFYaI22mLLXxhk/MSzqy20i9Tsg8=;
        b=NTgnZnKoXk0/BULvopvmLvQunf4+W1Sa6k0b4LL/5Enrp4MhkU60IHMDgIJwRguTRZ
         eg2+zCUBf3fI6kGnJC7WMHj4WAUd4a5e5qZ6weoatzekRXnCgF2VCdE3xf2APBGkCeLt
         yoybDBM5XzY46NUPS46meEi56WoIGGTf7zdxNGd0CSZd6z4S0tgX2dlikyzgoZpsAuQ6
         KsN3Z3GBeaEESTEHBdiddJvrOKMX99SmeOyuZ27i3Ek+yM9xEA/tVJknMvP7OIDpEiks
         amUaCt/OhUDeEpcABsIcoaPqye5kQ2UlW1oMViqA5vb4Ad/jpMYJBiwsV4jia/FCD9Wj
         6hIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=4EPaqEwekZ/Ix6DgFYaI22mLLXxhk/MSzqy20i9Tsg8=;
        b=WwxPohWnj0R+7KMuDSWFBBIVkHI3uvuAYKYcMioEumnmTGpmjYZksitn+pRcZgBOLf
         6XUVG31ISPYx+QYL3X3c47Vr9rL8swOI0+TNPjgm96R938WHPfoHyjTLqsu8mH02JK7G
         6IvUiLQEGMh6Q39RUWzOEUXTPjWGFtub8A1T6WEHFtiOKa+2bBi76YPzwX+/b6TuTaCd
         4+ZR4Johky0fUHY/HL6B1dvyOuqpMMAD0zkbvrhACPiY9bzmYqdqW36J6DYBqTB7WqTV
         RNkeuPkeZI2KtFF0Wj5T0ua2bQ9EYPoSD0N8Ddhoa+HE+/YWSlkOn/TkbnXMt2uOe1F3
         214Q==
X-Gm-Message-State: AOAM533ocfpzNEzWbF8apqEDIhgks06X6VAUH3vjrMHGVVuMEAKZOBUf
        YJqw2qozcSl8Tbol8rftixURx7dW+l4=
X-Google-Smtp-Source: ABdhPJzyMOq/em+uAy1SYc7KGSKsZk3OHOqMp2oCEu+Qa4wS+RTnZvaRiGF0fY/4dyPmk84pEg1I3w==
X-Received: by 2002:a63:7f17:: with SMTP id a23mr8472899pgd.3.1592861310823;
        Mon, 22 Jun 2020 14:28:30 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id fy21sm379042pjb.38.2020.06.22.14.28.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 14:28:30 -0700 (PDT)
Message-ID: <5ef1227e.1c69fb81.7eb98.1476@mx.google.com>
Date:   Mon, 22 Jun 2020 14:28:30 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v5.8-rc2
Subject: pm/testing baseline: 62 runs, 1 regressions (v5.8-rc2)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 62 runs, 1 regressions (v5.8-rc2)

Regressions Summary
-------------------

platform        | arch  | lab          | compiler | defconfig | results
----------------+-------+--------------+----------+-----------+--------
bcm2837-rpi-3-b | arm64 | lab-baylibre | gcc-8    | defconfig | 4/5    =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.8-rc2=
/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v5.8-rc2
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      48778464bb7d346b47157d21ffde2af6b2d39110 =



Test Regressions
---------------- =



platform        | arch  | lab          | compiler | defconfig | results
----------------+-------+--------------+----------+-----------+--------
bcm2837-rpi-3-b | arm64 | lab-baylibre | gcc-8    | defconfig | 4/5    =


  Details:     https://kernelci.org/test/plan/id/5ef1163007fcd4dc1d97bf52

  Results:     4 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.8-rc2/arm64/defc=
onfig/gcc-8/lab-baylibre/baseline-bcm2837-rpi-3-b.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.8-rc2/arm64/defc=
onfig/gcc-8/lab-baylibre/baseline-bcm2837-rpi-3-b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2019=
.02-11-g17e793fa4728/arm64/baseline/rootfs.cpio.gz =


  * baseline.dmesg.crit: https://kernelci.org/test/case/id/5ef1163007fcd4dc=
1d97bf55
      failing since 23 days (last pass: v5.7-rc7-92-g065693d08662, first fa=
il: v5.7-rc7-109-g1a09809dda81)
      1 lines =20
