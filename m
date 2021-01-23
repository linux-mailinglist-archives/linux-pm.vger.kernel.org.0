Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85766301240
	for <lists+linux-pm@lfdr.de>; Sat, 23 Jan 2021 03:29:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726470AbhAWC3S (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 22 Jan 2021 21:29:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726440AbhAWC3M (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 22 Jan 2021 21:29:12 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95273C0613D6
        for <linux-pm@vger.kernel.org>; Fri, 22 Jan 2021 18:28:32 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id n7so5089877pgg.2
        for <linux-pm@vger.kernel.org>; Fri, 22 Jan 2021 18:28:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=VGJwx2FisvTGH/De1iaB4pLDm201R59ZvSTw9ONoAeM=;
        b=XjlYJDgJcxYeJrvE9S9BMgkYBsSlywuoUht2LA6V9OA6y9Z8YY36K+7klfgs29kfTf
         X5y6EwrESrly1f1kxOJMAZWdmkKz5QLwhbwrnfs1ml5LpSC+BVOfFL7nmMwsyEv1BrfO
         Pv2aGNGdShvc3c4A1QY3anbR2p+QreWVRhFvvu44+DYl+nft3Nj+hvNXfE3qcE9Kqclr
         jIolc4IWm7j4eA6mOiwVQAMemp13QhH3ukYvxwNNe6SU3l4OPZC29C3AJ+jDykkLX84D
         XXVjqdMlRyidAl04/DEB1MOIlwprOEIQyg8bMgP/Iqt7R7aAN5WlY3lXt7v6cbfMPuva
         ocFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=VGJwx2FisvTGH/De1iaB4pLDm201R59ZvSTw9ONoAeM=;
        b=Mvr3jsP2/33SsCKGMzcuSH16xV6vniabOfmVN35258j/cfzoUbCwMrfm2tLaDnrNLn
         zsdeqnCw05FQhOwNPBFE0LY80Kvb9Tq5+qVs7Kw9qcn9UzrcVpq6j7nZv4p2KdO5BNVX
         KGOL99RZ2+JfcDfVd7f9Mypk/Jfj1TkLUmu3l2HI/BuCk2Cgh38E3HSusqvqq6y1I9ra
         iHkQAkY8r6T51Tr9zYX13wB+O9bcmxHt6QQqASgZVpoe13Q6LxgOpe8itlNh0Frzotm2
         Inql8znhvgPXHz9473b1gPpzTo7UiI0s93ZUUkIzbmw3JWjqPzRulc9d4B/TLDsS8037
         aJMQ==
X-Gm-Message-State: AOAM5319+oCnQuxzYOEEsp6fdQW5tsC9cT46DgvQBY8FxYRZaiEH0QEl
        xsESY2PqG/3a4cCmkveJ88Mfxw==
X-Google-Smtp-Source: ABdhPJwlbIRdcLM8GHIAmerYahTQ17QaNXOfoP7cESnGyHVrzz3O/N6ZiNdHGM4UFpqNpJhzkhVi4A==
X-Received: by 2002:a63:4b0b:: with SMTP id y11mr7699615pga.118.1611368912198;
        Fri, 22 Jan 2021 18:28:32 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id me3sm10046484pjb.32.2021.01.22.18.28.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jan 2021 18:28:31 -0800 (PST)
Message-ID: <600b89cf.1c69fb81.10378.79ef@mx.google.com>
Date:   Fri, 22 Jan 2021 18:28:31 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: acpi-5.11-rc5-27-gad758c58a703
X-Kernelci-Report-Type: test
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
Subject: pm/testing sleep: 3 runs,
 1 regressions (acpi-5.11-rc5-27-gad758c58a703)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing sleep: 3 runs, 1 regressions (acpi-5.11-rc5-27-gad758c58a703)

Regressions Summary
-------------------

platform        | arch  | lab           | compiler | defconfig | regressions
----------------+-------+---------------+----------+-----------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-8    | defconfig | 1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/acpi-5.1=
1-rc5-27-gad758c58a703/plan/sleep/

  Test:     sleep
  Tree:     pm
  Branch:   testing
  Describe: acpi-5.11-rc5-27-gad758c58a703
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      ad758c58a7036596aed10b408535d4e0dd16c7d6 =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig | regressions
----------------+-------+---------------+----------+-----------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-8    | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/600b7c7a168546a003d3dfdf

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/acpi-5.11-rc5-27-ga=
d758c58a703/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//pm/testing/acpi-5.11-rc5-27-ga=
d758c58a703/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2021=
0118.2/arm64/rootfs.cpio.gz =



  * sleep.login: https://kernelci.org/test/case/id/600b7c7b168546a003d3dfe0
        failing since 156 days (last pass: v5.8-107-gb72b3ea38c81, first fa=
il: v5.9-rc1-4-g1f08d51cd57f) =

 =20
