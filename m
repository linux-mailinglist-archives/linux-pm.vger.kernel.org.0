Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C19A5345579
	for <lists+linux-pm@lfdr.de>; Tue, 23 Mar 2021 03:27:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229467AbhCWC1P (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 22 Mar 2021 22:27:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbhCWC05 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 22 Mar 2021 22:26:57 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 842FBC061574
        for <linux-pm@vger.kernel.org>; Mon, 22 Mar 2021 19:26:54 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id b184so12704425pfa.11
        for <linux-pm@vger.kernel.org>; Mon, 22 Mar 2021 19:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=BVdYGhMNYQhPX0Et1fRuupFpi7Xk7XcRTz3YDjsITg4=;
        b=dmu76ZKTzmYlGv4Ev0KO/hpdU4FTr0Faq1+6Q1fSqx3CunXt/j2R/36cIxoeVBiAzC
         xLb9+/UnJCMHI6RXh3Bf1FrIcnLXOpVjOrofuh6SvzTaS5IxB1HViUcpsj63EvgcG0ZY
         ut+oTPuOt6HCuzjZxxOSHgIvJ5qCCHPjVPYwUbctL3qazy86NDZx6SJV70+WMpLkOM/z
         hf2ALTsAf/lHt+biW6Tg6iYs6oBketnKUWO0F+2mHAHofwWe30ptvwaJMdIoQHo1ALN9
         QQLeblgHhu4wnu/RArwIC7rLjI4OhSW7QUm4eL6zQTHwkCUDEc51AeW7Z2fvoedtF5er
         tIrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=BVdYGhMNYQhPX0Et1fRuupFpi7Xk7XcRTz3YDjsITg4=;
        b=Oiovf3WYI9PlMLz29iNjkhkChxjxPeNkFe1shGi2I0b+G28CTbQSKRt2pvLOHssv8a
         ZVvwyZUyQR716zuWnZ9dst2H1WumGkON0WAiby2Vo7upf5qxUKwGSKbMYY3ZutGv2vCH
         O2aeWPHL+Wl8oNISKpiBouUJfLkBlZMsjA4TeWaHmbcwFuC051qBsiIl/Br4osIhV5Hi
         UiHmna9Z0/BMhAAeZgvuVXeULuk0E6jAFXsESc4yJ/uLucmWWl1L2urtQ9EOGr/PSepz
         gXiETeUF0PzqR+KNR7kOdbJ6GYEOjJspsm71SXn2FC37UxLAivYHI7pATrMnc+7upF4W
         xa+w==
X-Gm-Message-State: AOAM53016+l0Xy21GwtXNC34Y+hrG3DZwTAjWZ/7nn/RRwYpvWAYWyzq
        XX4oCuVaBhrTeDkcJigtQG3zLA==
X-Google-Smtp-Source: ABdhPJx+0urZqImF7CJGmxiO3P4cSR3vMWL/Hl/4xAVPvXfS8gpumexg3SS1z+80y0P6nk94pCidqA==
X-Received: by 2002:a17:902:bd96:b029:e6:3d73:f90e with SMTP id q22-20020a170902bd96b02900e63d73f90emr2575869pls.63.1616466414067;
        Mon, 22 Mar 2021 19:26:54 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id c16sm14403203pfc.112.2021.03.22.19.26.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 19:26:53 -0700 (PDT)
Message-ID: <605951ed.1c69fb81.7bb1f.4518@mx.google.com>
Date:   Mon, 22 Mar 2021 19:26:53 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.12-rc4-38-g0fc4b6feae23
X-Kernelci-Report-Type: test
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
Subject: pm/testing sleep: 2 runs, 1 regressions (v5.12-rc4-38-g0fc4b6feae23)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing sleep: 2 runs, 1 regressions (v5.12-rc4-38-g0fc4b6feae23)

Regressions Summary
-------------------

platform        | arch  | lab           | compiler | defconfig | regressions
----------------+-------+---------------+----------+-----------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-8    | defconfig | 1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.12-rc=
4-38-g0fc4b6feae23/plan/sleep/

  Test:     sleep
  Tree:     pm
  Branch:   testing
  Describe: v5.12-rc4-38-g0fc4b6feae23
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      0fc4b6feae239ecf9e355838c15521f9896dda22 =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig | regressions
----------------+-------+---------------+----------+-----------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-8    | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/60593fc091c73566b9addcb6

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.12-rc4-38-g0fc4b=
6feae23/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.12-rc4-38-g0fc4b=
6feae23/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2021=
0315.0/arm64/rootfs.cpio.gz =



  * sleep.login: https://kernelci.org/test/case/id/60593fc091c73566b9addcb7
        failing since 215 days (last pass: v5.8-107-gb72b3ea38c81, first fa=
il: v5.9-rc1-4-g1f08d51cd57f) =

 =20
