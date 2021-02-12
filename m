Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6774631A3B3
	for <lists+linux-pm@lfdr.de>; Fri, 12 Feb 2021 18:36:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231301AbhBLReX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 12 Feb 2021 12:34:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230240AbhBLReK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 12 Feb 2021 12:34:10 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BE81C061574
        for <linux-pm@vger.kernel.org>; Fri, 12 Feb 2021 09:33:31 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id z6so6246311pfq.0
        for <linux-pm@vger.kernel.org>; Fri, 12 Feb 2021 09:33:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=6GhVdkMYkI/0dHYuKI4F6kZgqc+LNZAtiz8RClj5UEs=;
        b=WVZ2Y6iBv4nM539UMdm6jjtePPpTu3VfxVa/rxkn+5Gu20R8MeJVY5oUAUj9cdsbTW
         7mJvVi8/DyJ4+Sdf26htR822c+uCuXx3XKBq3p8DBLZBX1Lks28VmT+lxaqjErZBW94t
         drAO6CkAnhAfxrjwn+kp9+gz8V7wMIo1ykiXwOyfnmbxTwPx51IPYENoJIP+rRXAcUjx
         idaCgR1mmiHVT17jEG7/YZw9jgbG7Kvah+r+6dGHB/zTY236+yjWpBidN9NPLASZryOI
         X2g8lPeTOcZGw1vOKnaonyO3mkkP9oHrXtcQAu8IHy2XkOKn0Y9RbWmukCOviNfaWkF5
         Ag9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=6GhVdkMYkI/0dHYuKI4F6kZgqc+LNZAtiz8RClj5UEs=;
        b=jmGYs8NUdilPoldSstRUb7AociyVlurABqd/IpFR8ryoX95Fp253ic2e2BAILWNkX4
         +HBE5C3Aoqwjt/fFSgUxXydXnsAM/cCauYzvlq8N3YL/q+CsIyZtisq1LsO855iLDQtB
         5+nsvR0A036s12yN1WsASEk08JzP00dFj1VtPBJ4HZ/ddqZ9aexm15s5nBLGamw7nJK3
         zUikS+HnGb2W4oPM2Ez9iay8ZHhTjDb4tZmRqF7NM9Y2sHdjRDLd/TE/xVBGsJiNDuSa
         rYxc7bDBELM6cBnfbd741qM1pG2DMY6E9nQtcsIN+1L7FDz9hd41Td4iAAfsFnx+kK6H
         roiQ==
X-Gm-Message-State: AOAM5305NokNFmrdU83d+dUki+cTWuuwVQUIudv1mfJmhF02NXOQePz8
        jVlGBKJVVwi/RVntbdNuQoCQ0w==
X-Google-Smtp-Source: ABdhPJwYAQwsXipxK1Gg3lqnNXbNreCeqATTNUomHVbj5+BwL/pDeYP697LkF8mWxVLLUcpEPdMD7A==
X-Received: by 2002:a63:f95b:: with SMTP id q27mr4285621pgk.82.1613151210600;
        Fri, 12 Feb 2021 09:33:30 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id f28sm10568805pfk.182.2021.02.12.09.33.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Feb 2021 09:33:30 -0800 (PST)
Message-ID: <6026bbea.1c69fb81.6016b.7272@mx.google.com>
Date:   Fri, 12 Feb 2021 09:33:30 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: pm-5.11-rc8-133-g5352de4c92b3a
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
Subject: pm/testing sleep: 5 runs,
 1 regressions (pm-5.11-rc8-133-g5352de4c92b3a)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing sleep: 5 runs, 1 regressions (pm-5.11-rc8-133-g5352de4c92b3a)

Regressions Summary
-------------------

platform        | arch  | lab           | compiler | defconfig | regressions
----------------+-------+---------------+----------+-----------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-8    | defconfig | 1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/pm-5.11-=
rc8-133-g5352de4c92b3a/plan/sleep/

  Test:     sleep
  Tree:     pm
  Branch:   testing
  Describe: pm-5.11-rc8-133-g5352de4c92b3a
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      5352de4c92b3acb86d4756be6105203619809e07 =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig | regressions
----------------+-------+---------------+----------+-----------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-8    | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/6026ac7d49009a73cf3abe76

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/pm-5.11-rc8-133-g53=
52de4c92b3a/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//pm/testing/pm-5.11-rc8-133-g53=
52de4c92b3a/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2021=
0208.0/arm64/rootfs.cpio.gz =



  * sleep.login: https://kernelci.org/test/case/id/6026ac7d49009a73cf3abe77
        failing since 176 days (last pass: v5.8-107-gb72b3ea38c81, first fa=
il: v5.9-rc1-4-g1f08d51cd57f) =

 =20
