Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 804152C4711
	for <lists+linux-pm@lfdr.de>; Wed, 25 Nov 2020 18:55:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730420AbgKYRyl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 25 Nov 2020 12:54:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730347AbgKYRyl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 25 Nov 2020 12:54:41 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CF49C0613D4
        for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2020 09:54:41 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id 18so1458449pli.13
        for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2020 09:54:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=d/NHEesGHIBjXgZI45nGP0LS3xiBMjrKXr5ujFuuCD0=;
        b=ozenYQSlQLQkGfWBdt2LEcHU7/Jy3RIBR6CWjAM5Qc/kZLGDOsQ471QjgYUZrQosdn
         P9g9YVZs/et3v1Au1O5ASwTHNdvM6UY6PxbMX3Sh/yHRiek/NyDlzwAmcmM1WYpgq+JF
         XRcZfO6zrnuM1U2e0AY6JEbCAjv9hTW5wTPueFCBRUuQjLKxCqgQg/ku5/S8/hXqqUs/
         h0+7O2OO92iemAFbWxDsBBDJzmrBrulLzkiPLKv5oWvFJgvb5tad1o5TyFgZWc8N0c9x
         z9DZjK0BcE7AC6FJ+C4DG5rxt/gFRP6dHaE5gHekl7qSM3Kib1CnuyR6lphoEmUJfRqk
         MvWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=d/NHEesGHIBjXgZI45nGP0LS3xiBMjrKXr5ujFuuCD0=;
        b=gxRSdTcpBj4/+bUoAdjoULb9w7p7d3n/tzUYNDw6IrYcxdZG5ZPSpA9wbRenwkyB1S
         hw8zNHGce/KqYrTu8qpeIiZ6OlZdHj8EHVX/T7UiF8MZElRe+LgEGgzGIzfyFsnP0cN3
         kIk20SmWkbMhFVl9Egl8IGC1PSBALTfkU8OmMgp7sl/cO7rDo044+Agq428zzKG2ucRA
         x0qVYCoooztbUXqoJouIjowPGxxUWfCOoPQ/r2i8E+TwHsY82Pu+dX0qBcTZ61RuYIc8
         pJTuU0nFooAOe+VwOL/N46g02lIiu/xfONf800QNT4XkjIb1ZYEabBzekA9IU6PY42BI
         aUeg==
X-Gm-Message-State: AOAM531o4xtqH/NHbVAnmV2A7Cq2Af9/jktlDR+4LnkP6hxxXXh7w2Qx
        efAvHxRIOMF1Vxdyky3tLPzCOQ==
X-Google-Smtp-Source: ABdhPJwodXdBjt/9O6ZXSfAEPdcsNee99C2JntJ0sloQGQc42uaQ+MoAX7yRDlnoJuaKoOFCd6jqtQ==
X-Received: by 2002:a17:902:8e87:b029:d8:e26a:77ea with SMTP id bg7-20020a1709028e87b02900d8e26a77eamr3297962plb.18.1606326879886;
        Wed, 25 Nov 2020 09:54:39 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id gx24sm3498459pjb.38.2020.11.25.09.54.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2020 09:54:39 -0800 (PST)
Message-ID: <5fbe9a5f.1c69fb81.3bb9a.85c8@mx.google.com>
Date:   Wed, 25 Nov 2020 09:54:39 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v5.10-rc5-65-g0a1829d7eb6a
X-Kernelci-Report-Type: test
Subject: pm/testing sleep: 5 runs, 1 regressions (v5.10-rc5-65-g0a1829d7eb6a)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing sleep: 5 runs, 1 regressions (v5.10-rc5-65-g0a1829d7eb6a)

Regressions Summary
-------------------

platform        | arch  | lab           | compiler | defconfig | regressions
----------------+-------+---------------+----------+-----------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-8    | defconfig | 1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.10-rc=
5-65-g0a1829d7eb6a/plan/sleep/

  Test:     sleep
  Tree:     pm
  Branch:   testing
  Describe: v5.10-rc5-65-g0a1829d7eb6a
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      0a1829d7eb6a677eea1b7173d6dd77ca5315a7b2 =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig | regressions
----------------+-------+---------------+----------+-----------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-8    | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/5fbe8bfbdf39ea8202c94e44

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.10-rc5-65-g0a182=
9d7eb6a/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.10-rc5-65-g0a182=
9d7eb6a/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2020=
1123.0/arm64/rootfs.cpio.gz =



  * sleep.login: https://kernelci.org/test/case/id/5fbe8bfbdf39ea8202c94e45
        failing since 97 days (last pass: v5.8-107-gb72b3ea38c81, first fai=
l: v5.9-rc1-4-g1f08d51cd57f) =

 =20
