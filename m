Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B828136501E
	for <lists+linux-pm@lfdr.de>; Tue, 20 Apr 2021 04:10:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbhDTCLE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 19 Apr 2021 22:11:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbhDTCLB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 19 Apr 2021 22:11:01 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92621C06174A
        for <linux-pm@vger.kernel.org>; Mon, 19 Apr 2021 19:10:30 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id f6-20020a17090a6546b029015088cf4a1eso3771694pjs.2
        for <linux-pm@vger.kernel.org>; Mon, 19 Apr 2021 19:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=O+hwIRt0jVgwcuxK1OWos2EZq803g/aB1hSXG4pBUnM=;
        b=Mcy2cpSAlqi1uSN1ML22sSDdQ0aZYwKUrW3Tr2vWhHIAuJn5KrRnjQr60Y8+7R3Ad7
         EOznp/LzpXuv/Z4UxOnDBpLbJoJ47ESCv5sQiKAqn92FfDfwdaTveOkn0rhzfEJg+IOH
         aIqyycgX/kxwUkzJ2+QYgdt06kL4jG4HCDk1vaRZKroA6jUr8HANwJ3k6WIFYkgArB4P
         QU/XQfhxs4/4c+vXMgihHrgRXoyWwIGCowjZSuowH2MK6/rkbdbTUbtG2X1WJec+vleG
         R0kG5z4EW5mM7d9qDUZ6IM8QI1tqA8kjrb8shXZK0wyb8h84bHmlL6apvY/BcG43GPZS
         /vlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=O+hwIRt0jVgwcuxK1OWos2EZq803g/aB1hSXG4pBUnM=;
        b=iutreY3KKE5+Nn3rg1AwMOXxD/xMgwQmR7lBWqFjN33J+qrsSyyF9WWM9Ed0WF39eU
         9ic7Bk1dcSGMa4dUre7FajyUyOHGd3UWwRppHR3W6Dnni0YtuaP+R+5FDXSbaPxjfzH7
         YUd8+fxXZHa9sLGC4Vd+9ALx6HR+xWpbdCtw7qVmwy71l6Ij2W1YuGbncydKkenRj95c
         lNFdP2AecLWXzfLWoLwbcoPx8HT/VDYyiTkV9hrKxh7UBWCDNY+ptD4WRmRdqWc0S6Q4
         ssrAUjeIdq7c78C0FDAqDwtCRZU7ixhJ1007jFZa1kRdcriJeVYln749ngJ+DZVEYIuF
         oB5g==
X-Gm-Message-State: AOAM532JjI5lLr0fhj/LUaMoKHbrQhuN7AplTWXhyUyZyJ4CfpCGL0rh
        vSwAP444u/QQoZxklbAGMFf7izQ7ZsRpDZ12
X-Google-Smtp-Source: ABdhPJxhsu/NNHssLpkrprZh7qEPRI+LKaD/E/zcSuxdZPUIhbGmvv30vKOcCoZNfZwfuyCvun5rQA==
X-Received: by 2002:a17:902:7201:b029:ec:b5c2:571c with SMTP id ba1-20020a1709027201b02900ecb5c2571cmr2006157plb.55.1618884630116;
        Mon, 19 Apr 2021 19:10:30 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id q10sm667709pjf.1.2021.04.19.19.10.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 19:10:29 -0700 (PDT)
Message-ID: <607e3815.1c69fb81.c79fd.34d4@mx.google.com>
Date:   Mon, 19 Apr 2021 19:10:29 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.12-rc8-160-g304bbea920d32
X-Kernelci-Report-Type: test
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
Subject: pm/testing sleep: 2 runs, 1 regressions (v5.12-rc8-160-g304bbea920d32)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing sleep: 2 runs, 1 regressions (v5.12-rc8-160-g304bbea920d32)

Regressions Summary
-------------------

platform        | arch  | lab           | compiler | defconfig | regressions
----------------+-------+---------------+----------+-----------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-8    | defconfig | 1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.12-rc=
8-160-g304bbea920d32/plan/sleep/

  Test:     sleep
  Tree:     pm
  Branch:   testing
  Describe: v5.12-rc8-160-g304bbea920d32
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      304bbea920d32fc73cdc144d3db268dba0b585df =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig | regressions
----------------+-------+---------------+----------+-----------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-8    | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/607e2b3688afc3af799b77cf

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.12-rc8-160-g304b=
bea920d32/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.12-rc8-160-g304b=
bea920d32/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2021=
0412.0/arm64/rootfs.cpio.gz =



  * sleep.login: https://kernelci.org/test/case/id/607e2b3688afc3af799b77d0
        failing since 243 days (last pass: v5.8-107-gb72b3ea38c81, first fa=
il: v5.9-rc1-4-g1f08d51cd57f) =

 =20
