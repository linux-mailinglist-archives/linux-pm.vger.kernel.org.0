Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F287C274F76
	for <lists+linux-pm@lfdr.de>; Wed, 23 Sep 2020 05:13:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbgIWDNm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 22 Sep 2020 23:13:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726732AbgIWDNm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 22 Sep 2020 23:13:42 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45D23C061755
        for <linux-pm@vger.kernel.org>; Tue, 22 Sep 2020 20:13:42 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id r19so6098850pls.1
        for <linux-pm@vger.kernel.org>; Tue, 22 Sep 2020 20:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=QKwRiOqpf/BKAiMlto8wdwaprwf3NfRqZlk8IYPcGhQ=;
        b=c+KFLfA08UaV+58op9gfj93OE1tVjKXPwTT2SemspMVlUIt8UZ+C4ExKrYypjNiogD
         FEE/L5s6ZUjC4vkbk8qE/Npay5BmZ8tnoHKUjDckKggNOrQHFW0SDh3MVeraPFMFWV6d
         p75XHoWsw28K92k3g4sSS7HG+janx5BrQh7IcQdj8lGxBZfDTp+czSenU3omCfJsxnJc
         +qamY2z9TSZLfd5p5vr1/HTNYu+dUIypX76oRsE7A6dFZ8X2PHoXAEoJ5E5dK9dLurbS
         tcHMgV0nnF1FPckPA23mNzL9wOX89mVZly48Z9+pKbXut30MktxYyP1bk1r+fruMIq4n
         z0Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=QKwRiOqpf/BKAiMlto8wdwaprwf3NfRqZlk8IYPcGhQ=;
        b=takBTsEwnUY1zMUGwPhg1j2WH1sb86pR69n25zhe6TIXZoZx5VGmNgTm5mL94YQXIJ
         tIdyLWKX12BY0IP4VQkt0pc3uYoBj1IKILsz+QPTYTpfw1c4Ewd2VSZPY4fLkuy8vcw+
         FvC3JTFZ5SJXA/C3ZH1tlmWdiAuuHsc3yNb+X2J7sWsBW4OiEN6c0X2vy55pn3kA8pML
         DqclVempYr8vOcF9w0Lk1qYKDu8eu5ByfJbmzyLm/FdUuheTUOpVd1UjNBVed12mXxOp
         Z6acNz49w0HN1yq5Qn8k/b7T/u0aEBEhokJ874YtFOHsEMoVw6k6E8ohFo/Av3/kGMU5
         nLIQ==
X-Gm-Message-State: AOAM5314o8HrsMRppcrZopf6SngoUSf7HCGPMggtdW20a5ZJ10excK4a
        PSophfaIGLjRPQ0mT/dhEs+INWxcPB6U6w==
X-Google-Smtp-Source: ABdhPJz2BumlKJE+88lNlJRF9IpMrbWFtHUlu3fN4AKMYRnORYYreujWxlPGa3xWlVF+5G1XmnnKEg==
X-Received: by 2002:a17:90b:815:: with SMTP id bk21mr6446064pjb.57.1600830821814;
        Tue, 22 Sep 2020 20:13:41 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id o19sm16359651pfp.64.2020.09.22.20.13.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2020 20:13:41 -0700 (PDT)
Message-ID: <5f6abd65.1c69fb81.28501.8eaf@mx.google.com>
Date:   Tue, 22 Sep 2020 20:13:41 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
X-Kernelci-Kernel: v5.9-rc6-28-gbc13abdb9140
Subject: pm/testing baseline: 98 runs,
 1 regressions (v5.9-rc6-28-gbc13abdb9140)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 98 runs, 1 regressions (v5.9-rc6-28-gbc13abdb9140)

Regressions Summary
-------------------

platform | arch | lab           | compiler | defconfig          | results
---------+------+---------------+----------+--------------------+--------
panda    | arm  | lab-collabora | gcc-8    | multi_v7_defconfig | 4/5    =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.9-rc6=
-28-gbc13abdb9140/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v5.9-rc6-28-gbc13abdb9140
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      bc13abdb914005e3af0362e03ab72a80e14eb797 =



Test Regressions
---------------- =



platform | arch | lab           | compiler | defconfig          | results
---------+------+---------------+----------+--------------------+--------
panda    | arm  | lab-collabora | gcc-8    | multi_v7_defconfig | 4/5    =


  Details:     https://kernelci.org/test/plan/id/5f6ab3505d7906a47fbf9dcb

  Results:     4 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.9-rc6-28-gbc13ab=
db9140/arm/multi_v7_defconfig/gcc-8/lab-collabora/baseline-panda.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.9-rc6-28-gbc13ab=
db9140/arm/multi_v7_defconfig/gcc-8/lab-collabora/baseline-panda.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05/armel/baseline/rootfs.cpio.gz =


  * baseline.dmesg.alert: https://kernelci.org/test/case/id/5f6ab3505d7906a=
47fbf9dd1
      failing since 34 days (last pass: v5.8-107-gb72b3ea38c81, first fail:=
 v5.9-rc1-4-g1f08d51cd57f)
      60 lines

    2020-09-23 02:30:34.643000  kern  :alert : BUG: Bad page state in proce=
ss swapper/0  pfn:9c802
    2020-09-23 02:30:34.649000  kern  :alert : BUG: Bad page state in proce=
ss swapper/0  pfn:9c803
    2020-09-23 02:30:34.655000  kern  :alert : BUG: Bad page state in proce=
ss swapper/0  pfn:9c804
    2020-09-23 02:30:34.661000  kern  :alert : BUG: Bad page state in proce=
ss swapper/0  pfn:9c805
    2020-09-23 02:30:34.667000  kern  :alert : BUG: Bad page state in proce=
ss swapper/0  pfn:9c806
    2020-09-23 02:30:34.673000  kern  :alert : BUG: Bad page state in proce=
ss swapper/0  pfn:9c807
    2020-09-23 02:30:34.678000  kern  :alert : BUG: Bad page state in proce=
ss swapper/0  pfn:9c808
    2020-09-23 02:30:34.684000  kern  :alert : BUG: Bad page state in proce=
ss swapper/0  pfn:9c809
    2020-09-23 02:30:34.690000  kern  :alert : BUG: Bad page state in proce=
ss swapper/0  pfn:9c80a
    2020-09-23 02:30:34.697000  kern  :alert : BUG: Bad page state in proce=
ss swapper/0  pfn:9c80b
    ... (49 line(s) more)
      =20
