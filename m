Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C754342A54
	for <lists+linux-pm@lfdr.de>; Sat, 20 Mar 2021 05:14:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbhCTEOH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 20 Mar 2021 00:14:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbhCTEOH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 20 Mar 2021 00:14:07 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 358ABC061761
        for <linux-pm@vger.kernel.org>; Fri, 19 Mar 2021 21:14:07 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id v3so5018249pgq.2
        for <linux-pm@vger.kernel.org>; Fri, 19 Mar 2021 21:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=ESwVNWGWJZpYyA0yOA62NNL/Gu8IO/YY7Yj/CY8mFbQ=;
        b=IUYBGMZqLzhDytCTvcuLn898V0N3Jtx3CI6VrWRrbp9Aeu24TMIocqb+JZtGwXUoXq
         0Wc+86uHa448HANClZhd0SDSRs8sS/5soITAUxrmcXv+Ph0qcBJTYb2thb4FzPuGjGk3
         rlI6BvtyOgNdDIHXG5OzV02/iUG1EBX/J6D6DFDnYGyTVbgj5i+ib/YvYbknloaq8vOJ
         KVl6u7i4poBsU9dwCYdJHqiRr2E6lnpmPC1z7cN6OeOUhxuqhrL/I8Ed8HUSFClLg2qe
         +N0iSqIGY4ios+MG2JOShFtTjpXGjTzoFZ8mlmjurUoFPZOlB0j2IM58DaJMpBFoy8lC
         6FxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=ESwVNWGWJZpYyA0yOA62NNL/Gu8IO/YY7Yj/CY8mFbQ=;
        b=jZmIT57gkAie2ZWYCGqZNvSofNxckqOTboBujYlX0gcZ21C7nFXaTAPnb58oq0mRO7
         Sw1BR8qsw0RfPMoJPVGy1KwOfj3bCj6P5YQvrRKieNneCtuSmR97zrjSYtKFOto7w7m+
         sfdewmFb6lyOX2JUvVQbfpKSppNGegelPWLAjvFm7GevTU6uVscyLXNaGNoMWRa78cnY
         uDSl2V3oh54TpcD2W5O//qLkzbq7PKCWdiJnZYNtbfRyZTW3wphaN7U6DlxP4o4Vq8xP
         SNRPl8ll2LluzPXsdi6Y7Tj64pOT3NpmTRexae+tAtc3pU3OXVwbe91kIf7N6mkRYKlB
         2OoA==
X-Gm-Message-State: AOAM5326sAHXKw5UWHTztDJj+B0a87i1nQrvTOy6v0KSMxJyUWeTQGKI
        CSoV4SCwtmKLsl6rQIPAUP0dybs33HLnUw==
X-Google-Smtp-Source: ABdhPJzI1Y193VWkreQdsHt9D2shQZ/lyYVRktov7KxyDyuRGFwfjXih4XgDeqYKZOvOcjWGoucw5w==
X-Received: by 2002:aa7:808b:0:b029:1ce:8a32:f5e8 with SMTP id v11-20020aa7808b0000b02901ce8a32f5e8mr11941523pff.34.1616213646631;
        Fri, 19 Mar 2021 21:14:06 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id z2sm7250907pfq.198.2021.03.19.21.14.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 21:14:06 -0700 (PDT)
Message-ID: <6055768e.1c69fb81.e7d0f.255a@mx.google.com>
Date:   Fri, 19 Mar 2021 21:14:06 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.12-rc3-29-g4bcad1ff6cfa
X-Kernelci-Report-Type: test
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
Subject: pm/testing sleep: 4 runs, 1 regressions (v5.12-rc3-29-g4bcad1ff6cfa)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing sleep: 4 runs, 1 regressions (v5.12-rc3-29-g4bcad1ff6cfa)

Regressions Summary
-------------------

platform        | arch  | lab           | compiler | defconfig | regressions
----------------+-------+---------------+----------+-----------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-8    | defconfig | 1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.12-rc=
3-29-g4bcad1ff6cfa/plan/sleep/

  Test:     sleep
  Tree:     pm
  Branch:   testing
  Describe: v5.12-rc3-29-g4bcad1ff6cfa
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      4bcad1ff6cfaa94d624c70322135621042c25124 =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig | regressions
----------------+-------+---------------+----------+-----------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-8    | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/60556a48f531ba1f07addcd0

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.12-rc3-29-g4bcad=
1ff6cfa/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.12-rc3-29-g4bcad=
1ff6cfa/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2021=
0315.0/arm64/rootfs.cpio.gz =



  * sleep.login: https://kernelci.org/test/case/id/60556a48f531ba1f07addcd1
        failing since 212 days (last pass: v5.8-107-gb72b3ea38c81, first fa=
il: v5.9-rc1-4-g1f08d51cd57f) =

 =20
