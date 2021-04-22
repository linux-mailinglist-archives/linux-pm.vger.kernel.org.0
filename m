Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22A11367FE8
	for <lists+linux-pm@lfdr.de>; Thu, 22 Apr 2021 13:59:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235977AbhDVMAE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 22 Apr 2021 08:00:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235957AbhDVMAD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 22 Apr 2021 08:00:03 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 173DDC06174A
        for <linux-pm@vger.kernel.org>; Thu, 22 Apr 2021 04:59:29 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id y32so32647240pga.11
        for <linux-pm@vger.kernel.org>; Thu, 22 Apr 2021 04:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=jz4ZjkOXmMhdK6XISQF0NeUyq4SESS0tGnC6BOOTkik=;
        b=yLQ9qegmxrYRg7Mn33R7w7m3SkA56KB3xvFlclhgSIBTgRUQbX/hBHam4yy+BYkkZz
         BSLO4yC7W4rfI/VVRdL9gOVVjHIISDMtrZaAjkr6stCvLY2gYa4e8W73TVF0uDR32s33
         mKzI9BE8xA6sICOiWTJibc1oGdDAILztVVjbBoomJOaZdVAlysKmpXK/z/Z3lUVmoAab
         fjml0WwiJ8JJL+AW78QJPxGWZ4WD14j60R2NT/tBDt4NHG9Ul+SaQv4bDhzf1WBouTIn
         j9D9xAxcgsmHI8UJQSmTBR3jl6sOde65e4knj06/Hk4Yu/RIVv1IqjTsLLsyEupOe1F8
         LJKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=jz4ZjkOXmMhdK6XISQF0NeUyq4SESS0tGnC6BOOTkik=;
        b=uIUBylaXX797MH4Xf/ncf7jxHQV9O2N+dgSlfy4b7iryPGxL1UWfq5Fs1IuWoWAjqd
         6RfBwQmjqenk/9TQCb5+AQYAQP/+w3k95ZXd/SfPaHUygfHQRH8V9dHmV1v7aQ4IvL0w
         UIf92FU2n9UvO0vTcD34xEKCLr4K6qV6wmQq5yhQ0zbDqYtwhwLSNW6yiDG/gpWio30t
         G9Wy5hblOj1IfAmHNqgEjQPL1apvzqXbTMJivPUZGCa50vAxE/CeoA1KSCFKiocCkLSw
         0pyndSa23tgyFKoDZMCd4rPpslF1lFrfual9rvue/s82MLHt00hfJHvwKPi8Kdm8HMRF
         QAdw==
X-Gm-Message-State: AOAM531hX/AdUq5ye9LbKIwhfWW8cnhgvuXlHbeJ4TfN4wO261gp+K/e
        uJGJr+nk72+l2LmZKKl1dGiyDw==
X-Google-Smtp-Source: ABdhPJwj4pzlIe+yeellqRSbGctwvQ/0dy3nzaVZWisCJxQrACS+eCgZil5mD556IdD6jESCWQ+p7Q==
X-Received: by 2002:a63:1556:: with SMTP id 22mr3272015pgv.142.1619092768614;
        Thu, 22 Apr 2021 04:59:28 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id a16sm2221875pgl.12.2021.04.22.04.59.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Apr 2021 04:59:28 -0700 (PDT)
Message-ID: <60816520.1c69fb81.16dee.66e0@mx.google.com>
Date:   Thu, 22 Apr 2021 04:59:28 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.12-rc8-166-ge5e331f4da127
X-Kernelci-Report-Type: test
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
Subject: pm/testing sleep: 5 runs, 1 regressions (v5.12-rc8-166-ge5e331f4da127)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing sleep: 5 runs, 1 regressions (v5.12-rc8-166-ge5e331f4da127)

Regressions Summary
-------------------

platform        | arch  | lab           | compiler | defconfig | regressions
----------------+-------+---------------+----------+-----------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-8    | defconfig | 1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.12-rc=
8-166-ge5e331f4da127/plan/sleep/

  Test:     sleep
  Tree:     pm
  Branch:   testing
  Describe: v5.12-rc8-166-ge5e331f4da127
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      e5e331f4da1273e7bdbc1afaf2a4fb5f7d98acf9 =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig | regressions
----------------+-------+---------------+----------+-----------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-8    | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/608157aef1c16e0f809b77c2

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.12-rc8-166-ge5e3=
31f4da127/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.12-rc8-166-ge5e3=
31f4da127/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2021=
0419.0/arm64/rootfs.cpio.gz =



  * sleep.login: https://kernelci.org/test/case/id/608157aef1c16e0f809b77c3
        failing since 245 days (last pass: v5.8-107-gb72b3ea38c81, first fa=
il: v5.9-rc1-4-g1f08d51cd57f) =

 =20
