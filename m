Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 364E342D0C9
	for <lists+linux-pm@lfdr.de>; Thu, 14 Oct 2021 05:09:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbhJNDLQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 13 Oct 2021 23:11:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbhJNDLQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 13 Oct 2021 23:11:16 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFD1EC061570
        for <linux-pm@vger.kernel.org>; Wed, 13 Oct 2021 20:09:11 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id g184so4196067pgc.6
        for <linux-pm@vger.kernel.org>; Wed, 13 Oct 2021 20:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=TiwSeVlVup4sLwTVhPHk2bzGUXHXQ2j6MkbnlHgJiBM=;
        b=f3+WgxIEHZqjI45FL1NxvIvL2VafVY9H2F5pcuJ/AbuqdpKntx9G/2lwllV1XOLjhF
         UB9b9xsQ0jG8M0ySWdA56mgrVirET4bqR38TamPKcSdLYW6r4XC4/QAoUEDqlESOUods
         aUolBKL8Gb5a6Y+iPAgMOARCFB6qfNwSCBwTEfSHRPS+yH2TEugoAIAGTfX4APh01FNz
         mMvyWnbXTY/WVUiAAu7kREczZGChdIBhOEMPinjUQ9Z2imOejPdiBrxuZBWxluW3Unwd
         6SZi0EYwT0aJV/X+oGnxfISthTZF1/i9LabnwFrchSmJjpP1NW1QAXRBwOpGke7MAVDW
         2xNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=TiwSeVlVup4sLwTVhPHk2bzGUXHXQ2j6MkbnlHgJiBM=;
        b=1HDtMf84i4w1SWZsU2hw3o3wfeleUbu9vdLi+WzeF5ahukZnyqEs/L8KMQZtIE+Pju
         adYPmVjqCeIX0H5PWSBrs4KfuJANnm6n8bqDXkpOMJoWbaEV2sunjlafkEkvdhYsmP7m
         xyUyY6jjncCj6uxY4SCU0WJExmA22ZJ4omdgXoui/NftlAzm/Zy5A+b01+jHfuE+ItKz
         GisCvHL9x1acLlB3xNTQQsjRdn2Uj8+ebAIszQVcFbkQCx5QsuA4Z0h7sndbpnbvbfaW
         plCUs7IETfN589ZPoBe7/TQ56v6xQfiv2/+0c+aqU8DGGTQhszfD27rD7TL9DtKfxdlA
         anFw==
X-Gm-Message-State: AOAM531KFN2v4f4P8m/WUZQjYyKVBkb/f278UT3znClMripGj8z7vobT
        IeK2MIp0/+vdS3CI3rB9gROlVOSXhDjeqs0Hyxc=
X-Google-Smtp-Source: ABdhPJwu+9iqmJCULB8Uv30JhyRM+qLp2EqqJCK7TVxjaTiYgzq9z/vkWIEwSY4jc5BW1SQdaYmEjw==
X-Received: by 2002:a05:6a00:731:b0:44c:7c1b:fe6a with SMTP id 17-20020a056a00073100b0044c7c1bfe6amr3087115pfm.44.1634180951383;
        Wed, 13 Oct 2021 20:09:11 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id j6sm848092pgq.0.2021.10.13.20.09.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 20:09:11 -0700 (PDT)
Message-ID: <61679f57.1c69fb81.c0144.3db3@mx.google.com>
Date:   Wed, 13 Oct 2021 20:09:11 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.15-rc5-53-g1b3dc77d7595
Subject: pm/testing baseline: 73 runs,
 1 regressions (v5.15-rc5-53-g1b3dc77d7595)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 73 runs, 1 regressions (v5.15-rc5-53-g1b3dc77d7595)

Regressions Summary
-------------------

platform  | arch | lab          | compiler | defconfig          | regressio=
ns
----------+------+--------------+----------+--------------------+----------=
--
beagle-xm | arm  | lab-baylibre | gcc-8    | multi_v7_defconfig | 1        =
  =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.15-rc=
5-53-g1b3dc77d7595/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v5.15-rc5-53-g1b3dc77d7595
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      1b3dc77d759553dba8e4842113a61a1a7de4adce =



Test Regressions
---------------- =



platform  | arch | lab          | compiler | defconfig          | regressio=
ns
----------+------+--------------+----------+--------------------+----------=
--
beagle-xm | arm  | lab-baylibre | gcc-8    | multi_v7_defconfig | 1        =
  =


  Details:     https://kernelci.org/test/plan/id/616792e46a7661a25c08facc

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.15-rc5-53-g1b3dc=
77d7595/arm/multi_v7_defconfig/gcc-8/lab-baylibre/baseline-beagle-xm.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.15-rc5-53-g1b3dc=
77d7595/arm/multi_v7_defconfig/gcc-8/lab-baylibre/baseline-beagle-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-6-g8983f3b738df/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/616792e46a7661a25c08f=
acd
        failing since 6 days (last pass: v5.15-rc4-24-g8e0efc215fb1, first =
fail: v5.15-rc4-42-g574167bf7ed8) =

 =20
