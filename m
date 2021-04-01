Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46BDF351876
	for <lists+linux-pm@lfdr.de>; Thu,  1 Apr 2021 19:48:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234835AbhDARpw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 1 Apr 2021 13:45:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234649AbhDARi5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 1 Apr 2021 13:38:57 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95F59C0045E2
        for <linux-pm@vger.kernel.org>; Thu,  1 Apr 2021 07:39:28 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id h20so1127311plr.4
        for <linux-pm@vger.kernel.org>; Thu, 01 Apr 2021 07:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=PsHpO6v9mWQ0G1AVpDyF0OqSKx7z69BcdM2ALZ385es=;
        b=P5ZXIlPSLPYd5bVxU0yae8si8YKo80aHIgHKeb1YyEJWBtdLrZTbIYq2PORq8nlO7Q
         PmEBO1bfKnDwfjUxNAOxQMZvunTUW5QbRMug+ujGhXqMk+BZOh6Q9JmdOiytK21sAdFG
         Q2UccCmN6mKnUGld1Xv1lX1bqNeni6fkKrwMnLEwjSOPTNa6mB82HKJjFPX+/ZSxiJIJ
         bIXjEYfwiStSBHy3LPzQcKkchr02WzxUh2SoLOgyGFF5mmQ0h09FYM5jWu5uzysPebpX
         8cEFm0GildTAXgiwNVvg7HfKkKeox6XkQt+/TOPho12n7jcWXPRULaCMc2OI7nGMQ1/t
         EfkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=PsHpO6v9mWQ0G1AVpDyF0OqSKx7z69BcdM2ALZ385es=;
        b=MeoVbS2vZKWQSiFc542+xHRhUy57UezTssPN6hhIu1XoGqjLmmM7UqGyfbNpwEzGck
         PG5lzX5U61hcwAAhrEUjTHro1ce55t2dhqFqoEh43PpC0p50Y5kxuVXqA3NSTKhaPY/D
         /SFpM2ZuV4X5gTItfUqdnl/7nfEp+/wTJOw4055xRrhcLhID6zZEeqrQCVIDiYhlu95w
         QVll3oIQkv7rWrVbFj2hyPLxzXPOHjHzQgg73La0N/tLtOtrSl9X5MOhXkC6mi/3bW7G
         l0U/qkuAIP/Nr/Zx2ciXrO0dZwMDkPy7FVbunzm7T6rqJbugZkeZbciU5E81d4UBLiei
         i2zA==
X-Gm-Message-State: AOAM532+1S7s1zJrhpttqiu+/tgcBBsVx8cNEJ+P9FKF9tUW75tD/A2K
        3vb0qNaReHGoD5NY5r5954CHog==
X-Google-Smtp-Source: ABdhPJxaJgN1NVFtKo0GqIaM1hhrpVRqkMXBYv5D77QEHD6kNl7pui/bOxtNRB7A6wLubTUosZUgYA==
X-Received: by 2002:a17:90a:6be4:: with SMTP id w91mr9675245pjj.68.1617287968190;
        Thu, 01 Apr 2021 07:39:28 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id gz12sm5964185pjb.33.2021.04.01.07.39.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 07:39:27 -0700 (PDT)
Message-ID: <6065db1f.1c69fb81.215b2.efe2@mx.google.com>
Date:   Thu, 01 Apr 2021 07:39:27 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.12-rc5-47-g85f34ae663986
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
Subject: pm/testing sleep: 4 runs, 1 regressions (v5.12-rc5-47-g85f34ae663986)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing sleep: 4 runs, 1 regressions (v5.12-rc5-47-g85f34ae663986)

Regressions Summary
-------------------

platform        | arch  | lab           | compiler | defconfig | regressions
----------------+-------+---------------+----------+-----------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-8    | defconfig | 1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.12-rc=
5-47-g85f34ae663986/plan/sleep/

  Test:     sleep
  Tree:     pm
  Branch:   testing
  Describe: v5.12-rc5-47-g85f34ae663986
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      85f34ae663986081df77a1df26e08fd1978573a3 =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig | regressions
----------------+-------+---------------+----------+-----------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-8    | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/6065ce7965669025e3dac6b7

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.12-rc5-47-g85f34=
ae663986/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.12-rc5-47-g85f34=
ae663986/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2021=
0315.0/arm64/rootfs.cpio.gz =



  * sleep.login: https://kernelci.org/test/case/id/6065ce7965669025e3dac6b8
        failing since 224 days (last pass: v5.8-107-gb72b3ea38c81, first fa=
il: v5.9-rc1-4-g1f08d51cd57f) =

 =20
