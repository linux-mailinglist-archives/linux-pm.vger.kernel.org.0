Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 369712A6D3E
	for <lists+linux-pm@lfdr.de>; Wed,  4 Nov 2020 19:56:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731787AbgKDS4O (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 Nov 2020 13:56:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728675AbgKDS4O (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 Nov 2020 13:56:14 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73B14C0613D3
        for <linux-pm@vger.kernel.org>; Wed,  4 Nov 2020 10:56:12 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id 62so10057890pgg.12
        for <linux-pm@vger.kernel.org>; Wed, 04 Nov 2020 10:56:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=5frHk8W4TX0vBPgk9ieAak19zZ8nMFl+vS8CXX8qUAc=;
        b=Tyxa3OZ8oFuSDYomHUR8HLwuxB3ZB0ygJQZfqKXtNJsQKj/ijlDYVelzqenUz9gf1q
         MUQi2rvt+lzL2oP5enfqluiyPXT+T72hS72DACeUBGolosebnNR3k1Fexd5HFKwHaYHs
         kZPgYwipMxL0lF3sC8OndayvmqMAGA6volP9m6sSqj0Intf8xw8OEpX53uQ1iiuj4WfJ
         8wfei5dyd6VayPC1oZw7R2iYi/gxkT2TkYuqX0X14hcne57L9RpIJ92HVq6NsuQpNHO7
         SynSAvnZHQ8dcaoza8JmrxYEKLtCFpKX0Yqp2Hy1SCErnizOl27147ER8vGIpQ/h/KZQ
         5Tdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=5frHk8W4TX0vBPgk9ieAak19zZ8nMFl+vS8CXX8qUAc=;
        b=X4HnQ97A+r2K0m7EX041WsgJvQHxoTobXJvx8CBpg35eftMtVNP787u992tdn7imCB
         0azDYzWGr4aGT7CVtvlS1tBE4fVmvlHjUdG8EzhD9FdHP/CU1nkm04JpYJJJl6h6vMI5
         IfMor00x3Xd72G4ULij0SgOZE2DKEC22AmoKdeokjmBJ8jBRqEgNk9rJMQBsXIGZ9RDQ
         8oaq965rotdyy+cbYIKxlDX1JPADPYTDGw7aZnXLSO4qj1FRMlnuR3fiLnO/7WEL7+fL
         GFjH4QFM49TztfrO06t7Yz/HlcfBlSC96h1n7xX/nJK5KSiSrDsBCarFv45pP+nMYZXy
         tMtg==
X-Gm-Message-State: AOAM530Qk3GZ+lS6mYBgr59Wadvz6NTVevtiiSQ2gHcMb7lOFH4PNbaf
        xnBT81A/MQrTSQH0eiuBh1pE1Q==
X-Google-Smtp-Source: ABdhPJy+aZYSnstGd9tg+8Iip8vH+7+0GdEhD/4XarX0J7YWAYtkVT+0bBD0ZbIzB4EeJLiaS+E6ow==
X-Received: by 2002:a65:4b81:: with SMTP id t1mr6581395pgq.263.1604516171108;
        Wed, 04 Nov 2020 10:56:11 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id z206sm2745980pfc.3.2020.11.04.10.56.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 10:56:10 -0800 (PST)
Message-ID: <5fa2f94a.1c69fb81.ce782.53e8@mx.google.com>
Date:   Wed, 04 Nov 2020 10:56:10 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.10-rc2-15-gdddc237beebb
X-Kernelci-Tree: pm
X-Kernelci-Report-Type: test
X-Kernelci-Branch: testing
Subject: pm/testing sleep: 3 runs, 1 regressions (v5.10-rc2-15-gdddc237beebb)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing sleep: 3 runs, 1 regressions (v5.10-rc2-15-gdddc237beebb)

Regressions Summary
-------------------

platform        | arch  | lab           | compiler | defconfig | regressions
----------------+-------+---------------+----------+-----------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-8    | defconfig | 1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.10-rc=
2-15-gdddc237beebb/plan/sleep/

  Test:     sleep
  Tree:     pm
  Branch:   testing
  Describe: v5.10-rc2-15-gdddc237beebb
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      dddc237beebb79a67a6e2cc18b6a0a29a3a7a89c =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig | regressions
----------------+-------+---------------+----------+-----------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-8    | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/5fa2ecee2f325a49d2fb5309

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.10-rc2-15-gdddc2=
37beebb/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.10-rc2-15-gdddc2=
37beebb/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2020=
1022.0/arm64/rootfs.cpio.gz =



  * sleep.login: https://kernelci.org/test/case/id/5fa2ecee2f325a49d2fb530a
        failing since 76 days (last pass: v5.8-107-gb72b3ea38c81, first fai=
l: v5.9-rc1-4-g1f08d51cd57f) =

 =20
