Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAA432E9D9E
	for <lists+linux-pm@lfdr.de>; Mon,  4 Jan 2021 20:00:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbhADTAH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 4 Jan 2021 14:00:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727862AbhADTAG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 4 Jan 2021 14:00:06 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5664DC061796
        for <linux-pm@vger.kernel.org>; Mon,  4 Jan 2021 10:59:26 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id lb18so158182pjb.5
        for <linux-pm@vger.kernel.org>; Mon, 04 Jan 2021 10:59:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=P/9FP9227WZfmL7pi05a3loMRD6lonG8fWlod9E85zk=;
        b=KQHBE7hW1y4uuaOGW0uQqMnGAjwx9wdm/JDoNoHC+Fh2jF+u6/yFkZJInNiTKj5gi4
         2sbjOtN3/Rl/UQ7rZRMvAZBqZ7sfjm3HFKhTN67Lg9vxHcH2ND/ISZHlYVPxi4MZ1/hK
         nqCEcgCaRwXafDtOn0JU9y+73OW3qwom2Szj9jUWx48rW93m0l3vxl0Aq+RDNsDeIQAT
         my9G01OXN1XZOh3idix1YMXyyDRoLkW7S6cTaH/3VpMKTbY/5CQfeN6Te0e58oAXwuHz
         dv7DNOy0vQglZWih2EuzETveMVUXADHA+BofvW6/4ogI52cFeQ+R1YOn0oC2mVm9dawU
         8BPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=P/9FP9227WZfmL7pi05a3loMRD6lonG8fWlod9E85zk=;
        b=Q1TR/6BkA86mEoiYOeBoPVLoDFAQYIRCZSM452drtVLEMOgnc0bAEWZ01Ge9kVSnjT
         ZTwPJPGfll5FHlGsay7wSTphAsa4CUAW+PXGtyKDeR+rBUQ5EEtZYV0Ct62jDJR4Elip
         eMvpWLfgZUThQsu00LE7o4pyoasqDDMYw0mGUmtTZmP4qVw4wBBMLRa7enZQWz1jWiE5
         dSoYpJ/5fdurfEXf+xlVv2Tjxu6e00dqDZwcjvJjxTsmX6qtphgIRcjdM/ngRYRU4bp1
         gMz4NW+b8foNuzabxW5FelnKlE9o1GLK1QW39Ug3hzc3AY1iRpiuMp3N2a/rs/TmxJM5
         OZtA==
X-Gm-Message-State: AOAM533/W4T7OumwhomhVykZL25zqfEQNMUrSJl9TLhAPQhQXYo0bMMH
        mYuS4u0lsJDp8niWz7RCjOO9yA==
X-Google-Smtp-Source: ABdhPJxrH1yhwmPd2XTw1DblnYksNCXBjGhmDFd/xhC5v6KAIp3efCYqCY0fLy53qNaW0RgUr2y8Gg==
X-Received: by 2002:a17:902:d34a:b029:da:861e:ecd8 with SMTP id l10-20020a170902d34ab02900da861eecd8mr66648056plk.45.1609786765978;
        Mon, 04 Jan 2021 10:59:25 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id ev23sm128113pjb.24.2021.01.04.10.59.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jan 2021 10:59:25 -0800 (PST)
Message-ID: <5ff3658d.1c69fb81.aa2e4.06a7@mx.google.com>
Date:   Mon, 04 Jan 2021 10:59:25 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v5.11-rc1-12-ga04307bd9ddd
X-Kernelci-Report-Type: test
Subject: pm/testing baseline: 110 runs,
 1 regressions (v5.11-rc1-12-ga04307bd9ddd)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 110 runs, 1 regressions (v5.11-rc1-12-ga04307bd9ddd)

Regressions Summary
-------------------

platform                   | arch  | lab          | compiler | defconfig | =
regressions
---------------------------+-------+--------------+----------+-----------+-=
-----------
meson-gxl-s905x-khadas-vim | arm64 | lab-baylibre | gcc-8    | defconfig | =
1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.11-rc=
1-12-ga04307bd9ddd/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v5.11-rc1-12-ga04307bd9ddd
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      a04307bd9dddb650f84d968165cdf4d3dd3c9b99 =



Test Regressions
---------------- =



platform                   | arch  | lab          | compiler | defconfig | =
regressions
---------------------------+-------+--------------+----------+-----------+-=
-----------
meson-gxl-s905x-khadas-vim | arm64 | lab-baylibre | gcc-8    | defconfig | =
1          =


  Details:     https://kernelci.org/test/plan/id/5ff35b9f0949176375c94cf8

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.11-rc1-12-ga0430=
7bd9ddd/arm64/defconfig/gcc-8/lab-baylibre/baseline-meson-gxl-s905x-khadas-=
vim.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.11-rc1-12-ga0430=
7bd9ddd/arm64/defconfig/gcc-8/lab-baylibre/baseline-meson-gxl-s905x-khadas-=
vim.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-4-g97706c5d9567/arm64/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/5ff35b9f0949176375c94=
cf9
        new failure (last pass: v5.10-rc7-148-g08e85a810cae) =

 =20
