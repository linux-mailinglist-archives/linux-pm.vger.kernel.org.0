Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E2E830CF2E
	for <lists+linux-pm@lfdr.de>; Tue,  2 Feb 2021 23:42:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235584AbhBBWiv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 2 Feb 2021 17:38:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231209AbhBBWit (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 2 Feb 2021 17:38:49 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99651C061573
        for <linux-pm@vger.kernel.org>; Tue,  2 Feb 2021 14:38:09 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id s24so3201078pjp.5
        for <linux-pm@vger.kernel.org>; Tue, 02 Feb 2021 14:38:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=/GfmbMQZhufpfF9eAUeZeMSq9TSJtS1FIijRurnCMOs=;
        b=0Q4K2p0oYXhFuPdpbF7+M20wYKU+o3bjPO78EVtVZ0fFEqn8Nwk71QgSFVWrbB2vJ0
         EGLXWFuP9NUjjyD8KKjCk6tH4xoWRHXn5yAnGTIcJzgrkdNJ+e/aZG3B2okuhjc2ef7u
         l/rMBI87QGQ3YNtysjDoQtYhzZC8TEYMTmhMJ5ofDEVh3WNNSxDp0CucA1j8C7wEjALo
         8EtYocL97uo8qL3htY4xI+ttvhKYz6IN5WZbs+xQI+G0xTyfArJ9vnqTuVwIX+AERVkn
         ZuYVE6G6K3gqWkH3lsaqqpD6EUZC4dAOhB091a9R8w0a7cUvavDFOyg2SN7FPNmXZD84
         tuqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=/GfmbMQZhufpfF9eAUeZeMSq9TSJtS1FIijRurnCMOs=;
        b=bS4n9Yh+ESuoKcr0AWnrvyVSYTLNv7RNwxzQwSasMpj6Nv5v7dfrFfA7uoITOgWyaL
         Y4f+HWqLMO04YCQ3E/2i64KESHF9KOIdlwIY9bXJL8oTkLDc4AkiIfUE19pT1vfRKKqg
         gECSrxlZzTS3+PchyA0YWmKQZqEnl8ik8M/igiOyVsoV62aW9pMPQTXQuWiVOg67CH7E
         XmqvBSim0eM4Hq4K9BPU4EipJ74dXdqONIzgweaBiwq2IObP2AsKlZkZCP6TyAVi6Mgu
         QIESijZX11mS4J+d/kHv7Ev5l7I1F7i5CFfUn6H1HJSxFnFN2r4hIbYn0PwxkpJU7RPP
         zpGA==
X-Gm-Message-State: AOAM532g9XGnGTKU2ItmH1SDee0cma3u1yrhPaRwA4b2MUqU9Mj2nwH3
        a/K92t/5suLL1wqI9TreUPboVxS6fNxWCA==
X-Google-Smtp-Source: ABdhPJwZrOUpoR7zbf0v4fRCHdaxaerxMtTKWMgG9eKs721WML9yirWLZIlerKMiAW2wRzOTF2d5bQ==
X-Received: by 2002:a17:902:a412:b029:db:cf5a:8427 with SMTP id p18-20020a170902a412b02900dbcf5a8427mr134954plq.48.1612305489175;
        Tue, 02 Feb 2021 14:38:09 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id 78sm33665pfx.127.2021.02.02.14.38.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 14:38:08 -0800 (PST)
Message-ID: <6019d450.1c69fb81.6ca15.0256@mx.google.com>
Date:   Tue, 02 Feb 2021 14:38:08 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.11-rc6-72-gc42187278fc1
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
Subject: pm/testing baseline: 108 runs,
 1 regressions (v5.11-rc6-72-gc42187278fc1)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 108 runs, 1 regressions (v5.11-rc6-72-gc42187278fc1)

Regressions Summary
-------------------

platform             | arch  | lab          | compiler | defconfig | regres=
sions
---------------------+-------+--------------+----------+-----------+-------=
-----
meson-gxl-s905d-p230 | arm64 | lab-baylibre | gcc-8    | defconfig | 1     =
     =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.11-rc=
6-72-gc42187278fc1/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v5.11-rc6-72-gc42187278fc1
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      c42187278fc107ad17fdaa2def70c451bcfdb6be =



Test Regressions
---------------- =



platform             | arch  | lab          | compiler | defconfig | regres=
sions
---------------------+-------+--------------+----------+-----------+-------=
-----
meson-gxl-s905d-p230 | arm64 | lab-baylibre | gcc-8    | defconfig | 1     =
     =


  Details:     https://kernelci.org/test/plan/id/6019cd03a1cbbb1c483abe75

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.11-rc6-72-gc4218=
7278fc1/arm64/defconfig/gcc-8/lab-baylibre/baseline-meson-gxl-s905d-p230.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.11-rc6-72-gc4218=
7278fc1/arm64/defconfig/gcc-8/lab-baylibre/baseline-meson-gxl-s905d-p230.ht=
ml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-4-g97706c5d9567/arm64/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6019cd03a1cbbb1c483ab=
e76
        new failure (last pass: v5.11-rc6-68-gd613f8c46696) =

 =20
