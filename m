Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B76AA34DCEE
	for <lists+linux-pm@lfdr.de>; Tue, 30 Mar 2021 02:20:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbhC3ATu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 29 Mar 2021 20:19:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230240AbhC3ATt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 29 Mar 2021 20:19:49 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AE6EC061762
        for <linux-pm@vger.kernel.org>; Mon, 29 Mar 2021 17:19:49 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id nh23-20020a17090b3657b02900c0d5e235a8so6777237pjb.0
        for <linux-pm@vger.kernel.org>; Mon, 29 Mar 2021 17:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=lPkuxvtcQS90ZDZT98YJBQZrrUv6oAbn1zu0whHbSo4=;
        b=I9rFyj6dbRhmVpU6YBltm7XgBx6/qaMHxlbC5gnLh+lRVXRJEGYIVf9FXvUZz8S9wM
         IwT79npSYGNwFoe15n/S8TwRLyplGeBUbBiEYrAcUQ2+rvRUBGGdY4b6joFe61K9MNeZ
         3Tm7KZwztaj+uTQlujLQCn0xG1abSQg9i5AbP8ebr4aV99NA5hqB2Ks3n3Hc4nd53TU/
         Op9fO0y4diCpkCcGnaOGnAi8v4Y90W00+wJrTrsQ7OpZmQTtqSZayRltR3RseqgTThdC
         AmQBhaUqKyLYBXdXeylNpealHy9mvF/4kb+v4K/xwuzKTfp/NKkDJZ3ytKpbL7KQoaCP
         J16g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=lPkuxvtcQS90ZDZT98YJBQZrrUv6oAbn1zu0whHbSo4=;
        b=t5avDIioR2ic7szzmRYOWjhooanFJJfCDLSuaGTZrK4odX0FRtaqX2OqQBsgMyMiY0
         a7RLeiJ9obNSDPuQL2U7TXj5jD5Fkh0mAJIyG5K+hFD1nB4yLOQ5K09lLH1Eoh6HFSKI
         whT7ct5g6N+Uk46LSMgN1gS79M24RqCT7ffr3YgVXe8B1zlClMKUZAI1ETtHHhsC3PlI
         XDcioBcY8rEfp/A6DuZfj4EoE0PEyKOHDq3DMZ8Fr/ZVli4guxeo+3QK1NJD0W1/3NiY
         j3E5myJn9v2xP5H1lHR77hI7vrnonuDn8Dt6VvMeCFQ2jSpaQjvoUE6LGXB2SrwQdVYZ
         k5nQ==
X-Gm-Message-State: AOAM533u8NPfhls/IEmzvBb068S1XpT9dtmTyVK8TOMKZuNLMRqlgfb2
        gEXUc6+nYr681F4IN1a1EnSGLQVvHe8GMQ==
X-Google-Smtp-Source: ABdhPJyqOFTeXPjkaDJp5ioRto+8MY58C6QJpTwFxzxQsPQnagAowQC9xYs2kJMl0SW1vKhdSmu0qQ==
X-Received: by 2002:a17:902:b705:b029:e6:f027:adf8 with SMTP id d5-20020a170902b705b02900e6f027adf8mr31414599pls.72.1617063589196;
        Mon, 29 Mar 2021 17:19:49 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id f2sm735304pju.46.2021.03.29.17.19.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Mar 2021 17:19:48 -0700 (PDT)
Message-ID: <60626ea4.1c69fb81.94eae.1e91@mx.google.com>
Date:   Mon, 29 Mar 2021 17:19:48 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.12-rc5-44-g1d535f1c735a0
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
Subject: pm/testing sleep: 4 runs, 1 regressions (v5.12-rc5-44-g1d535f1c735a0)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing sleep: 4 runs, 1 regressions (v5.12-rc5-44-g1d535f1c735a0)

Regressions Summary
-------------------

platform        | arch  | lab           | compiler | defconfig | regressions
----------------+-------+---------------+----------+-----------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-8    | defconfig | 1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.12-rc=
5-44-g1d535f1c735a0/plan/sleep/

  Test:     sleep
  Tree:     pm
  Branch:   testing
  Describe: v5.12-rc5-44-g1d535f1c735a0
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      1d535f1c735a0cbe50c8446d81760a1d07605610 =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig | regressions
----------------+-------+---------------+----------+-----------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-8    | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/6062614e3fd4b8739daf02b9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.12-rc5-44-g1d535=
f1c735a0/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.12-rc5-44-g1d535=
f1c735a0/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2021=
0315.0/arm64/rootfs.cpio.gz =



  * sleep.login: https://kernelci.org/test/case/id/6062614e3fd4b8739daf02ba
        failing since 222 days (last pass: v5.8-107-gb72b3ea38c81, first fa=
il: v5.9-rc1-4-g1f08d51cd57f) =

 =20
