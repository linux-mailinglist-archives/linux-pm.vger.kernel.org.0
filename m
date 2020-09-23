Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8A9F274F8D
	for <lists+linux-pm@lfdr.de>; Wed, 23 Sep 2020 05:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbgIWD2n (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 22 Sep 2020 23:28:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbgIWD2m (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 22 Sep 2020 23:28:42 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6F1AC061755
        for <linux-pm@vger.kernel.org>; Tue, 22 Sep 2020 20:28:42 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id x22so9375567pfo.12
        for <linux-pm@vger.kernel.org>; Tue, 22 Sep 2020 20:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=Cyv0NbN0yWPS+PsT7IMJD+tb3MCt73IHlNI22dI4avY=;
        b=jnHtu8GEt0GqpKYIvrCK8wUR0AjN5vWE834OR2PkQJHipX9aSkYCRqsiLD+DICGD87
         3XlIb95uL/v25ehWameSZmknzctiELQeIWHbJQBvh6x/mNjfttGl5Fd4S95fdq+VC/5O
         JFm/TOeu9SY8f+35BpxUpnX2y/98Ncf55GUWWigi66iCooNtB1iNiUk+7CBtSLmAyApM
         1iVJ+DQ1otTK8RHzteqbsv6s3WhpCxrEIR1ZEpbtv75be8G+8uoJGo/jns3e8S0swmB0
         Jyi3ow60BnNIHOsA7J/6uyFggIUIqe0N7l64qFt1PepV0q1WArSfB9h9VnPB/pFekp+9
         yhSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=Cyv0NbN0yWPS+PsT7IMJD+tb3MCt73IHlNI22dI4avY=;
        b=kR8rwQ3jD3YvkOr3+3lAVogyt/j7dSUKzKeV3TD0UIYmvsTcsMWCJrWBJ5vcOwtv+X
         WitgqfNAUj0QXKz9Ee6LQ68whx+AMLG+x89TYP0kD1UFxdorpvnmsZR+74V4+60uVBVt
         FsPHAkXiiYtz7Tc3dnB0iE2BIKcWZWis3rsakQYvlcoMOJ2L4KXPjber1UkxRQORqpm7
         uwhFuvT6ZzFI/90P5ZMd4wZM1BufDEu6woVLDrvHV74yWqPAbahpzey9E7g2txI+6GBG
         vhTs2Q3M1kaIcAHG8iw9DKWx/6cE7UDG8oeiBhpXvQjGFtTiMJGiTeURvhPWmtOJnkIV
         AI6g==
X-Gm-Message-State: AOAM531Bp7koaSymNm5ceRWZuDhgUSrUUrEY5lct7inD75QqsU4RtvLz
        UlNNgJ1DGre9Qw05pgn0qUj/uDqtE0UbKw==
X-Google-Smtp-Source: ABdhPJzNEZ6WltZ55+evFCa4bbCqWv1Ks88DBV4lFOkk8FpMgDUkqkzUiACyaIMrIi32w286Q+AbpA==
X-Received: by 2002:a63:1e03:: with SMTP id e3mr6071294pge.69.1600831722030;
        Tue, 22 Sep 2020 20:28:42 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id l141sm16613695pfd.47.2020.09.22.20.28.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2020 20:28:41 -0700 (PDT)
Message-ID: <5f6ac0e9.1c69fb81.d6589.910e@mx.google.com>
Date:   Tue, 22 Sep 2020 20:28:41 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
X-Kernelci-Kernel: v5.9-rc6-28-gbc13abdb9140
Subject: pm/testing sleep: 4 runs, 1 regressions (v5.9-rc6-28-gbc13abdb9140)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing sleep: 4 runs, 1 regressions (v5.9-rc6-28-gbc13abdb9140)

Regressions Summary
-------------------

platform        | arch  | lab           | compiler | defconfig | results
----------------+-------+---------------+----------+-----------+--------
mt8173-elm-hana | arm64 | lab-collabora | gcc-8    | defconfig | 0/1    =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.9-rc6=
-28-gbc13abdb9140/plan/sleep/

  Test:     sleep
  Tree:     pm
  Branch:   testing
  Describe: v5.9-rc6-28-gbc13abdb9140
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      bc13abdb914005e3af0362e03ab72a80e14eb797 =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig | results
----------------+-------+---------------+----------+-----------+--------
mt8173-elm-hana | arm64 | lab-collabora | gcc-8    | defconfig | 0/1    =


  Details:     https://kernelci.org/test/plan/id/5f6ab4560a43f5c57ebf9dc3

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.9-rc6-28-gbc13ab=
db9140/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.9-rc6-28-gbc13ab=
db9140/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2020=
0911.0/arm64/rootfs.cpio.gz =


  * sleep.login: https://kernelci.org/test/case/id/5f6ab4560a43f5c57ebf9dc4
      failing since 34 days (last pass: v5.8-107-gb72b3ea38c81, first fail:=
 v5.9-rc1-4-g1f08d51cd57f)  =20
