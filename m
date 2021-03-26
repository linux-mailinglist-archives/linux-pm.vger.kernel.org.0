Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1110734AF28
	for <lists+linux-pm@lfdr.de>; Fri, 26 Mar 2021 20:16:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbhCZTQI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 26 Mar 2021 15:16:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbhCZTPi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 26 Mar 2021 15:15:38 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9B3CC0613AA
        for <linux-pm@vger.kernel.org>; Fri, 26 Mar 2021 12:15:37 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id y137so229139pfg.1
        for <linux-pm@vger.kernel.org>; Fri, 26 Mar 2021 12:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=2c6Z47VJBBCPN/O821OjjidemNKX0FxKtMrdcXDZjNo=;
        b=ttmaDGdr/6lzeo3R9M1MmN0GSr2E27jj9hixRQ9myhzjR0xK7MLNeJCmOCVfXRw+KA
         lcxjLiPXV4tKFnNnFJ/s0t8rIp2v7NvNfLoeN+ao+i35OWCr7pQFzmZNU31iqC5Fzt1P
         gnbx7Q+5+vUJ6zkXMHv10wnQznpMI/leJHssDbkN17r/BqC/lBglsbwf2b8OAVMomhHS
         kPXDIhYPC7xcpBljwYovFXZTvg6FoUep4uKz7Rh0siG9t5fKnKzNdQEK8sVHQdihWX6k
         hdQFM7CbCN9b3jxbFt88MSFh3RkgmYkbjcxInwpj/PFdrb8jfc/XW3KQFCjK9Bpmv+Pb
         U/sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=2c6Z47VJBBCPN/O821OjjidemNKX0FxKtMrdcXDZjNo=;
        b=lpcxGnOIUoR/F5LNB3vgJ0zF4xoGNEaWeyX/z9nbRWVrOKxxlEWXWfpzjTELID0nuU
         iMaobuGMijiDBoICaV5QBcfMhB9XYCDZG2jMEFlgHsEXLfwLWzm3WV2gqr8+CBjDyH01
         G6kJ24aDPQfLd+mgk9O5CVspIzqVtG6tdtj8YG1U7JVj623+iEjsjR/iXDusFIKfKLrc
         UX2PBaRRXgZPuO/033bwEil+NoXHsVgEQdjyPQt1+owtaO0xQj6QDyK4qFVvQkN9MqHr
         2sxLEN1Dq/ah00dJ0YMUZAlir7pwikUcAxPMQ8m3UUAkj35uZ2dWSjCyGkg+5zCjTgnx
         6PAQ==
X-Gm-Message-State: AOAM532GhzIpXActJyF4FzJm7Se4zUa+udLTEcMOZM1pr1bewQJ3rRpf
        fuPGvUCDpjjAbQkkVN7szYJMmg==
X-Google-Smtp-Source: ABdhPJwA9lXIZcUZ9zbQd7E/XYspq13MUg172Vy/IfynDdSfR+VyInU5ngTnyQs/h8jzUKu05ruyJA==
X-Received: by 2002:a62:1c8f:0:b029:209:7eb2:748f with SMTP id c137-20020a621c8f0000b02902097eb2748fmr14335082pfc.79.1616786137379;
        Fri, 26 Mar 2021 12:15:37 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id gm10sm9403791pjb.4.2021.03.26.12.15.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 12:15:37 -0700 (PDT)
Message-ID: <605e32d9.1c69fb81.ef229.6ffe@mx.google.com>
Date:   Fri, 26 Mar 2021 12:15:37 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.12-rc4-49-ga78dc08f39195
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
Subject: pm/testing sleep: 4 runs, 1 regressions (v5.12-rc4-49-ga78dc08f39195)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing sleep: 4 runs, 1 regressions (v5.12-rc4-49-ga78dc08f39195)

Regressions Summary
-------------------

platform        | arch  | lab           | compiler | defconfig | regressions
----------------+-------+---------------+----------+-----------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-8    | defconfig | 1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.12-rc=
4-49-ga78dc08f39195/plan/sleep/

  Test:     sleep
  Tree:     pm
  Branch:   testing
  Describe: v5.12-rc4-49-ga78dc08f39195
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      a78dc08f391956cc281a98bc08f41b904ff6c831 =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig | regressions
----------------+-------+---------------+----------+-----------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-8    | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/605e264178f5a8438aaf02c1

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.12-rc4-49-ga78dc=
08f39195/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.12-rc4-49-ga78dc=
08f39195/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2021=
0315.0/arm64/rootfs.cpio.gz =



  * sleep.login: https://kernelci.org/test/case/id/605e264178f5a8438aaf02c2
        failing since 219 days (last pass: v5.8-107-gb72b3ea38c81, first fa=
il: v5.9-rc1-4-g1f08d51cd57f) =

 =20
