Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64A132582F8
	for <lists+linux-pm@lfdr.de>; Mon, 31 Aug 2020 22:46:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726102AbgHaUqx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 31 Aug 2020 16:46:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725993AbgHaUqx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 31 Aug 2020 16:46:53 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF071C061573
        for <linux-pm@vger.kernel.org>; Mon, 31 Aug 2020 13:46:52 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id u128so1329477pfb.6
        for <linux-pm@vger.kernel.org>; Mon, 31 Aug 2020 13:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=manNEt+UQQD7kjg19l8QJSwddufPASSJLlBIzLjxPXQ=;
        b=jylcYB8fxOqaHeWR+3Y0QTqHrSekCJzYY6LTy8YluRoIQw/pXI5oO29PzkT39DAO3T
         7Umyojy1ffDObx9pGBUkInAkLO95aRkkMwot762l7uTYHO58hHHVEoB6ftCmRhyasmqj
         C0TRd6/u263FIW2xb1iALlSMIyBAymQ6fbvTPUAmCjLdgSWnSU1ZU7nBnVUxp5pRHbKp
         saczUsOx/ZjhxUGXeBkUhzOmwzrCOZPodAbRAJ2evpzQtkKo6RSCs5hTr4LF7IIJE2dc
         KWU8XG3HALkNZttd/h+jZI4jZShQoilU62LC4u+KC5Ic9s2vCjFx67MNd1PtvYYZlTSR
         i56A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=manNEt+UQQD7kjg19l8QJSwddufPASSJLlBIzLjxPXQ=;
        b=k8SaAvJ5bpjLU9qU8jkcQ0gJpv5hmSdgv2QIw9JCuH/KNWnWt9rK7LgibyJdOvh+fO
         FKt5aL5QLFpC2HcaCrLtzeZE2t1RhLkGycpIAffXKNex7362kYXxe2ldwl5yjbmDxl1f
         /QFB4Bsn0eONNWLPpHzMuTKmkl61HJ3423FruPxXLyX6AYtv6OrVYiDb2vBdfIZJ8rDD
         Uws6sRyCNHgXO5kQnsMJ8jKORbdD/g0HKipoEWzAOFo8Rl0zSu2sk3dR+6NOis5rR4uR
         3C/YDX2r+Qd1o5SrZ2Ho7P2olynV7x9Dkli9+tMPbLFL52MQxupbPFQZTVxUDIENbz+T
         87Jg==
X-Gm-Message-State: AOAM53200zWoPb8E6K7QeYdsfmDij+m5E1TVqhgpATTXjv3hQZvYqADP
        NLh0zFGBTcQDLj16V0DiLz0dfw==
X-Google-Smtp-Source: ABdhPJxblZe2yW6OOtlJVd54Y3T5BUXiD1l8mK8CEudvAa3erxxLItyRTzSkd02kXq6rO1L29VplPw==
X-Received: by 2002:a65:4588:: with SMTP id o8mr2556661pgq.229.1598906812027;
        Mon, 31 Aug 2020 13:46:52 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id l12sm453405pjq.31.2020.08.31.13.46.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2020 13:46:51 -0700 (PDT)
Message-ID: <5f4d61bb.1c69fb81.3b735.135e@mx.google.com>
Date:   Mon, 31 Aug 2020 13:46:51 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v5.9-rc3-3-g7c174c127f32
Subject: pm/testing sleep: 7 runs, 1 regressions (v5.9-rc3-3-g7c174c127f32)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing sleep: 7 runs, 1 regressions (v5.9-rc3-3-g7c174c127f32)

Regressions Summary
-------------------

platform        | arch  | lab           | compiler | defconfig | results
----------------+-------+---------------+----------+-----------+--------
mt8173-elm-hana | arm64 | lab-collabora | gcc-8    | defconfig | 0/1    =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.9-rc3=
-3-g7c174c127f32/plan/sleep/

  Test:     sleep
  Tree:     pm
  Branch:   testing
  Describe: v5.9-rc3-3-g7c174c127f32
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      7c174c127f32dcf647020ca02663846973075298 =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig | results
----------------+-------+---------------+----------+-----------+--------
mt8173-elm-hana | arm64 | lab-collabora | gcc-8    | defconfig | 0/1    =


  Details:     https://kernelci.org/test/plan/id/5f4d4eeecddf1231c8081123

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.9-rc3-3-g7c174c1=
27f32/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.9-rc3-3-g7c174c1=
27f32/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2020=
0821.0/arm64/rootfs.cpio.gz =


  * sleep.login: https://kernelci.org/test/case/id/5f4d4eeecddf1231c8081124
      failing since 12 days (last pass: v5.8-107-gb72b3ea38c81, first fail:=
 v5.9-rc1-4-g1f08d51cd57f)  =20
