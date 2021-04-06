Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC37B35573D
	for <lists+linux-pm@lfdr.de>; Tue,  6 Apr 2021 17:05:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345442AbhDFPFp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 6 Apr 2021 11:05:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230454AbhDFPFo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 6 Apr 2021 11:05:44 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B74F6C06174A
        for <linux-pm@vger.kernel.org>; Tue,  6 Apr 2021 08:05:36 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id g35so5808760pgg.9
        for <linux-pm@vger.kernel.org>; Tue, 06 Apr 2021 08:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=4fzCZXUeMRDIENhKyTRhXh0JqWij4mMtknNKsEAvB7I=;
        b=i3BiipNRtEkZxHRTDthWrenTe/h+X8HRteT8UgQB1lEfFz05ycbOzC77N3U7nDH5Cc
         hnpadc/AKSk5OcpooVXpvgqh+O7S7CVFHgSgATsOZBxDB7ECf9ARlFc2fKcU8eWkybRS
         +QXyKkqa9Lpf1ai90OgrwMEhYacUGqLH5buAtwCw0Dt0A41xnsL7IPr6G0fqU87ZwpgV
         9ud3Vp8yoP2IpzAyssm48RVQorxREUBuWc15vKeapYxzlZhdG0Ob+ozX2W+i0PcTX8pS
         ICGDO7ZYbaQRxBoVAJGjdAbFqsMlS6LWKuqxa19N7LNdgUGioOn2WuEgtSK0H6MosLhR
         DKRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=4fzCZXUeMRDIENhKyTRhXh0JqWij4mMtknNKsEAvB7I=;
        b=Qqv99vhSGDEraDDkoBzQH7uFa3cJpRQ7uN8Pb9bYusdsmA0JBvRCiIUOblVq9b/M7s
         lbbgLK0kc2Fqicn1utbAMnkj4sZhokYUKrh+ZWxC/zi430Q5zxgzDtsFkRvwkc5hs/7r
         YMR0fg5Jve89kY6niZyZ0bq78X+WaDSZnG5xVDgGaEA7bpjGPTuzaohuZ2I82V5kBhcJ
         DjD3b/5SFvw8A7+duj3xBQVtOLqRiw73DL+GGwqxYBJ3AE2AE7NqgnDnq5woPKSTUAMz
         X6LkX2ztVNgv06xMAFzTyUKEpmnAWludsCTNw6pYZHIUSkZPx7gWsTKDC0k1fO8oNvZW
         326Q==
X-Gm-Message-State: AOAM533oXmjsZo0XkTlCfXjVgO+ZYKQVSpGWMa65/IHBVpwSsk0HqBJc
        iaZzGcSac3tG7ZmmTXRrWuPGkg==
X-Google-Smtp-Source: ABdhPJxMWs8K8KWSx7p+B21+SDbBXvBw4uJHI1reirWUJ1UmyzegGkBDcjBJRQWUiVJYBFV9xowuUg==
X-Received: by 2002:a62:e119:0:b029:1f8:a4c1:ac9c with SMTP id q25-20020a62e1190000b02901f8a4c1ac9cmr28147230pfh.55.1617721536302;
        Tue, 06 Apr 2021 08:05:36 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id l2sm2959259pji.45.2021.04.06.08.05.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 08:05:36 -0700 (PDT)
Message-ID: <606c78c0.1c69fb81.c3380.80d5@mx.google.com>
Date:   Tue, 06 Apr 2021 08:05:36 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.12-rc6-37-gcf66fa75745a0
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
Subject: pm/testing sleep: 5 runs, 1 regressions (v5.12-rc6-37-gcf66fa75745a0)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing sleep: 5 runs, 1 regressions (v5.12-rc6-37-gcf66fa75745a0)

Regressions Summary
-------------------

platform        | arch  | lab           | compiler | defconfig | regressions
----------------+-------+---------------+----------+-----------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-8    | defconfig | 1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.12-rc=
6-37-gcf66fa75745a0/plan/sleep/

  Test:     sleep
  Tree:     pm
  Branch:   testing
  Describe: v5.12-rc6-37-gcf66fa75745a0
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      cf66fa75745a0b1237bc54340c8148170dc63edc =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig | regressions
----------------+-------+---------------+----------+-----------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-8    | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/606c6c37a363713728dac6b3

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.12-rc6-37-gcf66f=
a75745a0/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.12-rc6-37-gcf66f=
a75745a0/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2021=
0324.0/arm64/rootfs.cpio.gz =



  * sleep.login: https://kernelci.org/test/case/id/606c6c37a363713728dac6b4
        failing since 229 days (last pass: v5.8-107-gb72b3ea38c81, first fa=
il: v5.9-rc1-4-g1f08d51cd57f) =

 =20
