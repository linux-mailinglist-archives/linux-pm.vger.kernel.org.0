Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A53822B762A
	for <lists+linux-pm@lfdr.de>; Wed, 18 Nov 2020 07:12:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725772AbgKRGLv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 18 Nov 2020 01:11:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbgKRGLv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 18 Nov 2020 01:11:51 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 192A9C0613D4
        for <linux-pm@vger.kernel.org>; Tue, 17 Nov 2020 22:11:50 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id t37so386707pga.7
        for <linux-pm@vger.kernel.org>; Tue, 17 Nov 2020 22:11:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=HuMoxTU1k0KFus5Yq9ZJ9XyvPYsrLnIFSuR+IiYHpUg=;
        b=q/RihpQu39FJ2Ec1LKU+u+g217WzBilRqrvtcPPqNL5pD0Fspb1vKW6FjGGQOY2Sfl
         FomprElaXQSr7X6k3XbZrciVLYWkC+xEMDa+l19Mcvql+DBMCxXU27INP+XHmm8+VCb0
         JwIY4F+yevPVsVHRYwj6SbpY93MNLvOCUXXs/hsmtXaBlhiOP6pn50q7ydKiOc8H2bCP
         tfxTX4xeo4efFieGjR35POS13Wwm19J5L6T2aPg83EZXTTuEKnBJQxo5/MTEQ3FSCxhm
         J8EVs4bRQt/WTAgPZso/QmtAoPOV+pVKZmWet5edJk8eFgcBRtJntaaeslVTSxGKD5ZW
         xJMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=HuMoxTU1k0KFus5Yq9ZJ9XyvPYsrLnIFSuR+IiYHpUg=;
        b=DUKvG6fiHNS0cnv7kTnfvbc13zZisaJ+3MdoEDyA8a7PduMZpqFYKAPFxYHZ30XmnA
         5Vgp18vZLHF0QA9EKVFFjvA0ZWiFh10Zyo8mxZhrmpbhq8mBAQUYprpBG399NMRq/k/S
         q5GISkuvbxtYpcv0x2IrZEL9/L/eju1KSyxk2hzLHXtzTXgD5qSpVaLVxUdwLqQeXXTu
         A+zinrJhvVKsaa+pXTs22me3VkN+DfBHYUQGjkn4Dd7DnymDzziikksBxMXt3vGv+LGi
         I8w1ya9sH0HoL9ERifmuNNyybTtlPQhg7Mnm4b+xfmLuyEXkB/VSIy6FBDd5888+BuJ1
         IAig==
X-Gm-Message-State: AOAM530IZMRwOzZ1sl7xlip7jzgFc3QcfOjYQBr/qoMZY3TNMa6nMec2
        PYeJM0YgdjVIeF/c8u6tYtXMyQ==
X-Google-Smtp-Source: ABdhPJwHxby8xDDfuMadp5GHZSw2ACIUdDd8fHMkFhEY584aBw8JMmoUG27ItSqESH7CaZCtPgZhRQ==
X-Received: by 2002:a63:4511:: with SMTP id s17mr6782385pga.4.1605679909565;
        Tue, 17 Nov 2020 22:11:49 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id h11sm3407353pfn.27.2020.11.17.22.11.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2020 22:11:48 -0800 (PST)
Message-ID: <5fb4bb24.1c69fb81.bc885.77bb@mx.google.com>
Date:   Tue, 17 Nov 2020 22:11:48 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10-rc4-32-g91565ced8699
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
Subject: pm/testing sleep: 8 runs, 2 regressions (v5.10-rc4-32-g91565ced8699)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing sleep: 8 runs, 2 regressions (v5.10-rc4-32-g91565ced8699)

Regressions Summary
-------------------

platform          | arch  | lab           | compiler | defconfig          |=
 regressions
------------------+-------+---------------+----------+--------------------+=
------------
mt8173-elm-hana   | arm64 | lab-collabora | gcc-8    | defconfig          |=
 1          =

tegra124-nyan-big | arm   | lab-collabora | gcc-8    | multi_v7_defconfig |=
 1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.10-rc=
4-32-g91565ced8699/plan/sleep/

  Test:     sleep
  Tree:     pm
  Branch:   testing
  Describe: v5.10-rc4-32-g91565ced8699
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      91565ced86999f0d538b19d4d8cff8050aff8a8f =



Test Regressions
---------------- =



platform          | arch  | lab           | compiler | defconfig          |=
 regressions
------------------+-------+---------------+----------+--------------------+=
------------
mt8173-elm-hana   | arm64 | lab-collabora | gcc-8    | defconfig          |=
 1          =


  Details:     https://kernelci.org/test/plan/id/5fb4aed87130769dcfd8d924

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.10-rc4-32-g91565=
ced8699/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.10-rc4-32-g91565=
ced8699/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2020=
1113.0/arm64/rootfs.cpio.gz =



  * sleep.login: https://kernelci.org/test/case/id/5fb4aed87130769dcfd8d925
        failing since 90 days (last pass: v5.8-107-gb72b3ea38c81, first fai=
l: v5.9-rc1-4-g1f08d51cd57f) =

 =



platform          | arch  | lab           | compiler | defconfig          |=
 regressions
------------------+-------+---------------+----------+--------------------+=
------------
tegra124-nyan-big | arm   | lab-collabora | gcc-8    | multi_v7_defconfig |=
 1          =


  Details:     https://kernelci.org/test/plan/id/5fb4b8bce6478e092ed8d911

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.10-rc4-32-g91565=
ced8699/arm/multi_v7_defconfig/gcc-8/lab-collabora/sleep-tegra124-nyan-big.=
txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.10-rc4-32-g91565=
ced8699/arm/multi_v7_defconfig/gcc-8/lab-collabora/sleep-tegra124-nyan-big.=
html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2020=
1113.0/armhf/rootfs.cpio.gz =



  * sleep.login: https://kernelci.org/test/case/id/5fb4b8bce6478e092ed8d912
        new failure (last pass: pm-5.10-rc4-33-g52d108cd060d) =

 =20
