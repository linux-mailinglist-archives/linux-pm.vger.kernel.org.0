Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE31E3C65CE
	for <lists+linux-pm@lfdr.de>; Mon, 12 Jul 2021 23:59:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbhGLWCC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 12 Jul 2021 18:02:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbhGLWB6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 12 Jul 2021 18:01:58 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C92A0C0613DD
        for <linux-pm@vger.kernel.org>; Mon, 12 Jul 2021 14:59:08 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id p9so10929424pjl.3
        for <linux-pm@vger.kernel.org>; Mon, 12 Jul 2021 14:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=493VIaQA9QoRvapNApuQhu01DIjkpjSb27+0kvqT26w=;
        b=Ya0sHFhv8xRgcTQvYAUWb7NxjT8q4xPLIENJnRtirpyXqFHB2X5agI54eQSka5Ubb8
         7U2JRDOPRAJQ9qe0ZqvuCHeFm2n+vAG+O1wm5mfprp9Cx33ZK1X/gxz4HT5GQeuGhh8M
         5DtmWTQVSX/K3V9bafN6FgPZdHM3MYjFwDumgf1Of6b1qjFucmPSDOP4VXwP07SmdF6N
         8K11Cgnv3lzr0qZoPKx5qmO3080seX4G/nbirj6BP8gPwGhMO8oMGrh7O3gy+9z4hrcA
         g3zizHO6yM0Ig7Fi+R+0bvEyA/5Wrh6PWX5LWn3uUz31jmFuZP8N0jsnFJJWeXRg6pE0
         FKOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=493VIaQA9QoRvapNApuQhu01DIjkpjSb27+0kvqT26w=;
        b=kPK+SQj+L5vho7gkEcMyxP9QZgNVuZFX5ZFJKpUFrFNeZK71386Sz0QsZd/b3hdeBM
         jXw1tW8pxdIhL5X6bFP95qoKj/X3pVcfJfLtEBgW8rCMuXg7DxjMcKtmv+wgu/ZpxUsV
         xkyc0pC2GsGD0sA12KUBx7lDa6WkkqgrYyIJUTVaagEWKNdAXJY9QBD2V+l7J4XVHvHF
         GsMPX+JzgmJtncgTfCt4LgPfGmT71CBId3A3HTmRhIAI/JqiTEObWqY6HTUtMpiTo49c
         Iv5TMZj1nkWdYo2gKHQadHLHc8VcS7wotvqLpv/dEili4NAOu+yJiDI16B1tL2XEjT0m
         kRug==
X-Gm-Message-State: AOAM532dF8vqxdLqtb9sGOh2GQseWzHTKEen5qSmYZj82vowjmm4daBC
        vUTHtrhIsJoJ8aIxpxvPakcD4A==
X-Google-Smtp-Source: ABdhPJzPHKBNeHCwSPP4t8eV2Emfy+YxqNUkd0m3te0LC8a4/TJXgHMVfulmmHQSzKjtRqdc4DkMfA==
X-Received: by 2002:a17:902:6b42:b029:11d:a147:bb7b with SMTP id g2-20020a1709026b42b029011da147bb7bmr963527plt.9.1626127148319;
        Mon, 12 Jul 2021 14:59:08 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id b21sm6773128pfo.64.2021.07.12.14.59.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jul 2021 14:59:07 -0700 (PDT)
Message-ID: <60ecbb2b.1c69fb81.70d2f.3f3c@mx.google.com>
Date:   Mon, 12 Jul 2021 14:59:07 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.14-rc1
X-Kernelci-Report-Type: test
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
Subject: pm/testing sleep: 2 runs, 1 regressions (v5.14-rc1)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing sleep: 2 runs, 1 regressions (v5.14-rc1)

Regressions Summary
-------------------

platform        | arch  | lab           | compiler | defconfig | regressions
----------------+-------+---------------+----------+-----------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-8    | defconfig | 1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.14-rc=
1/plan/sleep/

  Test:     sleep
  Tree:     pm
  Branch:   testing
  Describe: v5.14-rc1
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      e73f0f0ee7541171d89f2e2491130c7771ba58d3 =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig | regressions
----------------+-------+---------------+----------+-----------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-8    | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/60ecad42b7cd415d701179a9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.14-rc1/arm64/def=
config/gcc-8/lab-collabora/sleep-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.14-rc1/arm64/def=
config/gcc-8/lab-collabora/sleep-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2021=
0709.0/arm64/rootfs.cpio.gz =



  * sleep.login: https://kernelci.org/test/case/id/60ecad42b7cd415d701179aa
        failing since 327 days (last pass: v5.8-107-gb72b3ea38c81, first fa=
il: v5.9-rc1-4-g1f08d51cd57f) =

 =20
