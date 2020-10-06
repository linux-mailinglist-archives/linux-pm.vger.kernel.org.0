Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D856284BB7
	for <lists+linux-pm@lfdr.de>; Tue,  6 Oct 2020 14:34:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726391AbgJFMev (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 6 Oct 2020 08:34:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbgJFMev (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 6 Oct 2020 08:34:51 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2667C061755
        for <linux-pm@vger.kernel.org>; Tue,  6 Oct 2020 05:34:49 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id c6so1150954plr.9
        for <linux-pm@vger.kernel.org>; Tue, 06 Oct 2020 05:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=RTGVtJXS8EAFol1l4+BXrsdeDgf/EIHoxGj6qK9S1mQ=;
        b=R1/S02o4eyvQMDuLWksC5HUJQisknzyHf/kSe965W6Fv2oGlQv+9W5+Boo6DwhZUsI
         1+Yq643s9fTjDFYU4ley2HHTGRmN9oAYbUv5yhymXavfLkd9rcLA7Y6sOgOYn8mFv+LN
         OmMJk7I3vUsemgnFaVXi1tU2AogWaDptqEYWCI4G6+e180HInRIWf9kDpNS0x47/7aYk
         Vnha/e8uJd8PUw71SS/WQYIS1K6NNW43FV4GMhgmu6VGMV7k+/f5pbQDav9DH7s0gx9u
         czvfBr9tKaFAnX4s2ulhhGRqoP8KY8UiPbILNyNkht0r/4ScXlkCWwgBvHsRwddPYO57
         npMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=RTGVtJXS8EAFol1l4+BXrsdeDgf/EIHoxGj6qK9S1mQ=;
        b=mjn3OC/In2alUSQhCA3SwRGFbmx/o2K6G9hV6qX/iHacDKeloO2ErbwT9Ljsqhp4uV
         I7LK3lm7XDZlRLN2aTvY1zKe2JMo14OPpQ/ulmaJX6k/wAtahYiRaDDkxDPVRp+wcgX5
         mJuwTSQGJF63O4AnbbJBFNonfxCCKlgBtg2t290p3ig1MGIbFuxKzv9widHW1xEJTbHp
         c/cbQr5TfDR7UNTWzNWbDQKoGF5OJ0q8ohsM/2Cn8/byUs8VMVnGWjwArL88ja31ZmbN
         unwS0iInl4J13mBYfapEiSVLcZFtIKDk7u+/N2p1Yb1UDo3N54aWOayBMwAxtfNvbx+j
         43ew==
X-Gm-Message-State: AOAM533cSqtwCYZQquWypiPawZydoycccgYnfVy0rE9uzGwGl1KYaNjV
        3tyBqvGCv6Kl0mZcIbrYoCuLBg==
X-Google-Smtp-Source: ABdhPJzCKWsIkyY5NUQqCMloY7LWkGIZnA4mD4yC1dnB7NnUdpcGNyvzjyZqZNdSEpquw6jCIixnYg==
X-Received: by 2002:a17:90a:c905:: with SMTP id v5mr3975080pjt.193.1601987689391;
        Tue, 06 Oct 2020 05:34:49 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id fu19sm2655760pjb.43.2020.10.06.05.34.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2020 05:34:48 -0700 (PDT)
Message-ID: <5f7c6468.1c69fb81.584ff.59b7@mx.google.com>
Date:   Tue, 06 Oct 2020 05:34:48 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.9-rc8-137-gc3cdb7873495
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
Subject: pm/testing baseline: 77 runs,
 1 regressions (v5.9-rc8-137-gc3cdb7873495)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 77 runs, 1 regressions (v5.9-rc8-137-gc3cdb7873495)

Regressions Summary
-------------------

platform | arch | lab           | compiler | defconfig          | results
---------+------+---------------+----------+--------------------+--------
panda    | arm  | lab-collabora | gcc-8    | multi_v7_defconfig | 4/5    =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.9-rc8=
-137-gc3cdb7873495/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v5.9-rc8-137-gc3cdb7873495
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      c3cdb7873495e5bbe7e3168efa9a2e7c988669a2 =



Test Regressions
---------------- =



platform | arch | lab           | compiler | defconfig          | results
---------+------+---------------+----------+--------------------+--------
panda    | arm  | lab-collabora | gcc-8    | multi_v7_defconfig | 4/5    =


  Details:     https://kernelci.org/test/plan/id/5f7c59a562656515db4ff3ef

  Results:     4 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.9-rc8-137-gc3cdb=
7873495/arm/multi_v7_defconfig/gcc-8/lab-collabora/baseline-panda.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.9-rc8-137-gc3cdb=
7873495/arm/multi_v7_defconfig/gcc-8/lab-collabora/baseline-panda.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-3-g27eeeac7da2d/armel/baseline/rootfs.cpio.gz =


  * baseline.dmesg.alert: https://kernelci.org/test/case/id/5f7c59a56265651=
5db4ff3f5
      failing since 47 days (last pass: v5.8-107-gb72b3ea38c81, first fail:=
 v5.9-rc1-4-g1f08d51cd57f)
      60 lines

    2020-10-06 11:48:47.788000  kern  :alert : BUG: Bad page state in proce=
ss swapper/0  pfn:9c802
    2020-10-06 11:48:47.793000  kern  :alert : BUG: Bad page state in proce=
ss swapper/0  pfn:9c803
    2020-10-06 11:48:47.799000  kern  :alert : BUG: Bad page state in proce=
ss swapper/0  pfn:9c804
    2020-10-06 11:48:47.805000  kern  :alert : BUG: Bad page state in proce=
ss swapper/0  pfn:9c805
    2020-10-06 11:48:47.811000  kern  :alert : BUG: Bad page state in proce=
ss swapper/0  pfn:9c806
    2020-10-06 11:48:47.817000  kern  :alert : BUG: Bad page state in proce=
ss swapper/0  pfn:9c807
    2020-10-06 11:48:47.823000  kern  :alert : BUG: Bad page state in proce=
ss swapper/0  pfn:9c808
    2020-10-06 11:48:47.829000  kern  :alert : BUG: Bad page state in proce=
ss swapper/0  pfn:9c809
    2020-10-06 11:48:47.835000  kern  :alert : BUG: Bad page state in proce=
ss swapper/0  pfn:9c80a
    2020-10-06 11:48:47.841000  kern  :alert : BUG: Bad page state in proce=
ss swapper/0  pfn:9c80b
    ... (49 line(s) more)
      =20
