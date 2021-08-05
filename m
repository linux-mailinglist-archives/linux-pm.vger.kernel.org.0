Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A63E33E1E08
	for <lists+linux-pm@lfdr.de>; Thu,  5 Aug 2021 23:32:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbhHEVck (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 5 Aug 2021 17:32:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbhHEVcj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 5 Aug 2021 17:32:39 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76AA0C0613D5
        for <linux-pm@vger.kernel.org>; Thu,  5 Aug 2021 14:32:23 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id u5-20020a17090ae005b029017842fe8f82so3572000pjy.0
        for <linux-pm@vger.kernel.org>; Thu, 05 Aug 2021 14:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=rz7t9I0pR0e0TQES0g1I+4PAbb1jqqpefrG/d6tNEaA=;
        b=cmRqmKpIq6gEWFs8Vu7JCldADFu2/rtGegcKjSoDzKluvEVb5IE3p1mrJkQRrDtAky
         qOVq8jYw2hkKEpiBHophDxK7iQFhhUBRo+mIIMcQxGZunl+Uc6+Vh+UMMgsynfWLu8Iy
         12y0isUNcEP5S/swuCVFyXHd6iWgX2XFrl6rtPft7YRcAWxEX82JhSQvokx2rNKTMbWl
         tIrvhW1QMjWozqDJrUxt2grE7ngeHnD5rcn+M8PdByMdpZYpRN7QWM90Yl7ON/uKAA/j
         5cVACNsBL/itBVJuC+wbDYD3hxM7JYjM/Aq9kU8R6ybCTr9oIM3kzAqCMUsjMkxMu1L9
         Fxig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=rz7t9I0pR0e0TQES0g1I+4PAbb1jqqpefrG/d6tNEaA=;
        b=I8c/2PDHZatnNxblrscRKxAaEgIuLKat749q/ThL8nNIfPQU+q4OZw73kbUk4s9Pav
         440eEQNTg/KcjGj0LZ0kOxfockAlzAowaVpD9m4pnhVN7w2rCFNH41ef23i9BUgPQCTM
         6/tZ8NJdlCEMKdiUh0u6hfDCHUMbOZpQJVI/vmtkC95E3/mwcQ81J6GmiKV5FRtJnmXB
         mkZVXl+OoagOAtcvajOZhtQoYpsdlbqbj/JRNj30XfXdSzVYpSt4jQjOmO1+ITGdBcDV
         g8t/28UPVoyGs+asvEbvb+LdlXhxXd/aPdQW8FGzHBDMQjFFKr67N/jg8t+M24PZbmuG
         oKLw==
X-Gm-Message-State: AOAM531jauIXZ+KKlqnOVqNfZAng3t0PNhH7pm9JqqFMIjzbA8sB2HjD
        lGgc6Bh5FS1isanDbMFGzcXJmw==
X-Google-Smtp-Source: ABdhPJzh9xRoUTrZ93bD4MqsvDoC+wQi51Z+Pr2zG+qy0snG9DONiSRg6K5/Pl5/EGdbu+1DhIeCKA==
X-Received: by 2002:a17:90b:1254:: with SMTP id gx20mr6476434pjb.24.1628199142865;
        Thu, 05 Aug 2021 14:32:22 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id q19sm7174732pfk.49.2021.08.05.14.32.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Aug 2021 14:32:22 -0700 (PDT)
Message-ID: <610c58e6.1c69fb81.1499d.6887@mx.google.com>
Date:   Thu, 05 Aug 2021 14:32:22 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v5.14-rc4-28-g9ac32de19606
X-Kernelci-Report-Type: test
Subject: pm/testing baseline: 26 runs,
 2 regressions (v5.14-rc4-28-g9ac32de19606)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 26 runs, 2 regressions (v5.14-rc4-28-g9ac32de19606)

Regressions Summary
-------------------

platform       | arch | lab          | compiler | defconfig          | regr=
essions
---------------+------+--------------+----------+--------------------+-----=
-------
beagle-xm      | arm  | lab-baylibre | gcc-8    | multi_v7_defconfig | 1   =
       =

imx6qp-sabresd | arm  | lab-nxp      | gcc-8    | multi_v7_defconfig | 1   =
       =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.14-rc=
4-28-g9ac32de19606/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v5.14-rc4-28-g9ac32de19606
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      9ac32de19606940ad29710d22841a906d6dd4799 =



Test Regressions
---------------- =



platform       | arch | lab          | compiler | defconfig          | regr=
essions
---------------+------+--------------+----------+--------------------+-----=
-------
beagle-xm      | arm  | lab-baylibre | gcc-8    | multi_v7_defconfig | 1   =
       =


  Details:     https://kernelci.org/test/plan/id/610c4872b9a801200cb13692

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.14-rc4-28-g9ac32=
de19606/arm/multi_v7_defconfig/gcc-8/lab-baylibre/baseline-beagle-xm.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.14-rc4-28-g9ac32=
de19606/arm/multi_v7_defconfig/gcc-8/lab-baylibre/baseline-beagle-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-6-g8983f3b738df/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/610c4872b9a801200cb13=
693
        new failure (last pass: v5.14-rc3-20-g604483c9d252) =

 =



platform       | arch | lab          | compiler | defconfig          | regr=
essions
---------------+------+--------------+----------+--------------------+-----=
-------
imx6qp-sabresd | arm  | lab-nxp      | gcc-8    | multi_v7_defconfig | 1   =
       =


  Details:     https://kernelci.org/test/plan/id/610c4b29ddf9d0925eb13684

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.14-rc4-28-g9ac32=
de19606/arm/multi_v7_defconfig/gcc-8/lab-nxp/baseline-imx6qp-sabresd.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.14-rc4-28-g9ac32=
de19606/arm/multi_v7_defconfig/gcc-8/lab-nxp/baseline-imx6qp-sabresd.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-6-g8983f3b738df/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/610c4b29ddf9d0925eb13=
685
        new failure (last pass: v5.14-rc4-18-g197da54f3a8e) =

 =20
