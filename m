Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AEE43AD448
	for <lists+linux-pm@lfdr.de>; Fri, 18 Jun 2021 23:17:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234498AbhFRVT2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 18 Jun 2021 17:19:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233969AbhFRVTZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 18 Jun 2021 17:19:25 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2E7FC061574
        for <linux-pm@vger.kernel.org>; Fri, 18 Jun 2021 14:17:15 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id h12so5345340plf.4
        for <linux-pm@vger.kernel.org>; Fri, 18 Jun 2021 14:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=gSMAQooaebMaN+lXt+U3/OD1lvZcReSevYzm6fm2oqE=;
        b=tgbPf0j/UN9DIzAdSFpVMBbjg8OtMrc26lKNSZjs6BPBgXvT46E57oexbVXPzydnLC
         piAFa/mG0jppaUiernrsaB2zHqM2pl+cYrKfYfO+UeKCUDDjh5GBIPcVdMwdiS6XlAQJ
         vOhalaEuV04l9Bwst8OEIMnAp3OQZgJEVaxWgfqHMyKCxdFfsbrFESdRZPJ8f93fgp/t
         q17P3/m+1S9j/6pyxTznaEsCSKoW8sdTutEK0rBEf/xSyl8RaYdlcrY2EvAZVfFO/9BA
         OeOYJJUiNGuOl5qXCT6VxGA9WmaaQR1M/azBsomSIhlOa6U1nQf0/J9V+Agbv2u4ku6V
         4W2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=gSMAQooaebMaN+lXt+U3/OD1lvZcReSevYzm6fm2oqE=;
        b=JLiWNivANyOikVSCbfnwkyIqoYIqK78ra1Eteu5EuU/vZfzk7aRN6FmhscVqPeAy8I
         Kw6iLO8GvllDKQuiqjVmiio5VbVN7uNZ9MdHJW5xYcI3dBpDxqLQO6RPw9IGRrPxjiST
         YOsLY/egepU+eVzWx/Cyf/aDhATTtR4FjSMOgNHm6+HfkCOyXUCtwaFRpmKE/Eow11xr
         OeWjd/9EvLMEAgluCoBwh8gDThjwoxmpcQZLxn9F5KY8R63ju7rPyR5divy2uvJb0lrc
         o+VaV/Cy6+UxZgkNmolCxQqRvUkG6ImfWenidBpn31363IZ4s41lG0oUPm1Dz+XYMFF3
         yX9Q==
X-Gm-Message-State: AOAM532PV1qHsEStUpm0gDaQWUq6NKzbVAkevnRFF8MoX15OvjM7O0E5
        OEzZbWIJeMfTKy7x/M7P8v5gLA==
X-Google-Smtp-Source: ABdhPJxK4MhSE6odl4BGhk0z9I04ErKcXuhFnlWD+eRO7YVDRiGNpS+ehhgbQ1IbOhpMwK43AKcrdA==
X-Received: by 2002:a17:902:bd8e:b029:11d:b246:c59a with SMTP id q14-20020a170902bd8eb029011db246c59amr6596453pls.58.1624051035272;
        Fri, 18 Jun 2021 14:17:15 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id w8sm10155570pgf.81.2021.06.18.14.17.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 14:17:14 -0700 (PDT)
Message-ID: <60cd0d5a.1c69fb81.19247.c30c@mx.google.com>
Date:   Fri, 18 Jun 2021 14:17:14 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: pm-5.13-rc7-139-g5469c0cf8416
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
Subject: pm/testing sleep: 3 runs,
 1 regressions (pm-5.13-rc7-139-g5469c0cf8416)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing sleep: 3 runs, 1 regressions (pm-5.13-rc7-139-g5469c0cf8416)

Regressions Summary
-------------------

platform        | arch  | lab           | compiler | defconfig | regressions
----------------+-------+---------------+----------+-----------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-8    | defconfig | 1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/pm-5.13-=
rc7-139-g5469c0cf8416/plan/sleep/

  Test:     sleep
  Tree:     pm
  Branch:   testing
  Describe: pm-5.13-rc7-139-g5469c0cf8416
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      5469c0cf84167fc90f5a6899df50cffa9ad1ccf9 =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig | regressions
----------------+-------+---------------+----------+-----------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-8    | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/60cd00c5ff62e8169141327d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/pm-5.13-rc7-139-g54=
69c0cf8416/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//pm/testing/pm-5.13-rc7-139-g54=
69c0cf8416/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2021=
0520.0/arm64/rootfs.cpio.gz =



  * sleep.login: https://kernelci.org/test/case/id/60cd00c5ff62e8169141327e
        failing since 303 days (last pass: v5.8-107-gb72b3ea38c81, first fa=
il: v5.9-rc1-4-g1f08d51cd57f) =

 =20
