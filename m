Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D462B21E1DE
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jul 2020 23:07:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbgGMVHm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 Jul 2020 17:07:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726291AbgGMVHm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 Jul 2020 17:07:42 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74E82C061755
        for <linux-pm@vger.kernel.org>; Mon, 13 Jul 2020 14:07:42 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id k4so6050377pld.12
        for <linux-pm@vger.kernel.org>; Mon, 13 Jul 2020 14:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=UWY93BEKGHJ4H/zfl37mRhIQkicIv/KkFkNAUD1jEvs=;
        b=L7cUBrNMlwQSPlyuiHhd9AHXjYpsO/7ZjKFAOjt0Qt0nLp3watVf/fhpuoqLfWp7TQ
         AgIib57qd4ni/crR+xp2iG097jVlOH79zdklb4BCqGSMCJWWu6npqqfmSeAvoot47ASr
         IwpTWtJNneYKJMoam6L1kpdNqltcFm3qBEwU2/q8E1qBwkoBoCs994g/3Ilh59Rnr7+I
         MSl/1LWmJvCYuUI59WR4W8cu8xEupctuRMIRNBQ+H1Hsntey2Nrfp4byRlOVRAVIVV+D
         dtH84Rqx32kNokVKX2jh1hnoHl2c+lEy1ZhvOSlowZz4eCbICsbSnGKLJFrUFkWaIAFc
         IwYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=UWY93BEKGHJ4H/zfl37mRhIQkicIv/KkFkNAUD1jEvs=;
        b=gSquAGsNOeJ1vUvKUfPragLpaBnG5J/dNUYsjcC7ubyjGgpe6OZUO8Vvl5c3i1KFHB
         1nsjA3XjKUQM+UtXCd8HMgfuLH7PZxsO7YQ4lnlfh2n8bLMOmesrS/GjJjoqLVWTh/CJ
         PKjSFtVI0E+TMvCbhQO6sXLMruBbLJo3V1Huvc3uKq/glVLbn6vchlGPX0ltXLFu9I4H
         eRG2rfRnNl2sXBasb/6fWTogPXj/zw81ij0Sto3aLOAHmusQR2HLcGq+v1+Vm88d4qdW
         t4G8/ja0z6LmjdNPawlM8vvIusoKdO2KxnE7LJRA/gHxMBUKPHSsdTvYuUrbbjGGlc/1
         uB/Q==
X-Gm-Message-State: AOAM532YlQeo7pkrVvSmu+l49g1XU6xafcPyhrKBWqXJJ52GkGhleTkq
        8C9opoPkYHId6lvrSZiDOiaSaQ==
X-Google-Smtp-Source: ABdhPJw7zqak0bPwHnMpkk7iyWk67eQSW4Ev8yABfJzQF4vkE+NBVuNhm4NjrOQNG7dHJIKe3gmyEg==
X-Received: by 2002:a17:90a:71c3:: with SMTP id m3mr1299044pjs.225.1594674461598;
        Mon, 13 Jul 2020 14:07:41 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id u2sm14960257pfl.21.2020.07.13.14.07.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 14:07:40 -0700 (PDT)
Message-ID: <5f0ccd1c.1c69fb81.23342.4c2b@mx.google.com>
Date:   Mon, 13 Jul 2020 14:07:40 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.8-rc5-39-gf2eae871177c
X-Kernelci-Report-Type: test
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
Subject: pm/testing sleep: 8 runs, 1 regressions (v5.8-rc5-39-gf2eae871177c)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing sleep: 8 runs, 1 regressions (v5.8-rc5-39-gf2eae871177c)

Regressions Summary
-------------------

platform          | arch | lab           | compiler | defconfig          | =
results
------------------+------+---------------+----------+--------------------+-=
-------
rk3288-veyron-jaq | arm  | lab-collabora | gcc-8    | multi_v7_defconfig | =
20/21  =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.8-rc5=
-39-gf2eae871177c/plan/sleep/

  Test:     sleep
  Tree:     pm
  Branch:   testing
  Describe: v5.8-rc5-39-gf2eae871177c
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      f2eae871177c5c62003e6a961382f098afeabfe6 =



Test Regressions
---------------- =



platform          | arch | lab           | compiler | defconfig          | =
results
------------------+------+---------------+----------+--------------------+-=
-------
rk3288-veyron-jaq | arm  | lab-collabora | gcc-8    | multi_v7_defconfig | =
20/21  =


  Details:     https://kernelci.org/test/plan/id/5f0cbf76acb93470a785bb18

  Results:     20 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.8-rc5-39-gf2eae8=
71177c/arm/multi_v7_defconfig/gcc-8/lab-collabora/sleep-rk3288-veyron-jaq.t=
xt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.8-rc5-39-gf2eae8=
71177c/arm/multi_v7_defconfig/gcc-8/lab-collabora/sleep-rk3288-veyron-jaq.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2020=
0710.0/armhf/rootfs.cpio.gz =


  * sleep.rtcwake-mem-7: https://kernelci.org/test/case/id/5f0cbf76acb93470=
a785bb20
      new failure (last pass: v5.8-rc3-22-g0169dcbef89a) =20
