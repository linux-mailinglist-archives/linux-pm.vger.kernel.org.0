Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 685FE34F6DE
	for <lists+linux-pm@lfdr.de>; Wed, 31 Mar 2021 04:40:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233356AbhCaCju (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 30 Mar 2021 22:39:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233293AbhCaCjo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 30 Mar 2021 22:39:44 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 712D6C061574
        for <linux-pm@vger.kernel.org>; Tue, 30 Mar 2021 19:39:44 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id a22-20020a17090aa516b02900c1215e9b33so403751pjq.5
        for <linux-pm@vger.kernel.org>; Tue, 30 Mar 2021 19:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=VUZRgF5E24pnBMmmHrAM5xXK1gFeg2Ymb2GHL6L9Fsc=;
        b=k72TsxPxJkS7ntnLVYJtKteL1cbrwkuGWLp7W0XJ+YNEZ/5qKTcFrnOwgx9MasP67v
         8cSjAz/CO31iJZ835cpdJTm172UNM5NodTjUuqNO06QaIuz1FPMl477uCTZE43naeXNA
         F3HQG9E+pZQKqzZJF+ABwef60WeBid5Em/GWsr/GKh2SEUsxVCJQE1/EJNfoT22JnL5w
         L2iegTJHodS6NiiQJHlpdNL0K7Cypw3oIlDIFxPgm9sYtaj6K/KRE4zAfWuzjk0NtNEZ
         NZloewPwTEt6X8en6lovM+J5o//o1xoTUwhW8dgv4f838Hkwck98FddO6AVMOUYSyPFL
         QbjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=VUZRgF5E24pnBMmmHrAM5xXK1gFeg2Ymb2GHL6L9Fsc=;
        b=dF4Y4wTkhmNyNjPBM+KrWGnDrarImGMo8K6Xm4dJu1vZxzc9T3nUWVytemT5QWol/a
         hqlwkmiUU604tdNV6DPepA8y73rlS+6pEIglBSH8JeED/cn74rdaJYqhNgyvpHMQE1zI
         vL0cZlQl6UaG0xrSfrEFKJo24uudPvxeru7eQedO+A/eBG/c/VMt+nHqnhfDsPY4dolZ
         BcOeJ21kH4bVlOxOT4OGLLBYRpSBCdCsvdb5z/ZUXYCmpTeHYaIMp0M28D0dOjjSmpbR
         yysbPNmWgwJFFtrooJamiGGZZJ6xFWkVXfK1tkI4CHF/hjI4UHyU4p6di/gYtBXnhmye
         EkXQ==
X-Gm-Message-State: AOAM531gS2S1WAUg8+FQppcnGaXJbKxRlqtiPge0a4XoKMH9Ntal8JxQ
        xC5rcNEBUKoOgSjPodVpqadz8w==
X-Google-Smtp-Source: ABdhPJxlW64ohdEvbi4O8lZmmmBtiG1q5ZZu+/S73LtYhvsBcwy+STTLamBcScIbGkFDlQq3+jtZ/g==
X-Received: by 2002:a17:90a:a789:: with SMTP id f9mr1325628pjq.192.1617158384057;
        Tue, 30 Mar 2021 19:39:44 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id y15sm571271pgi.31.2021.03.30.19.39.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 19:39:43 -0700 (PDT)
Message-ID: <6063e0ef.1c69fb81.f8e7c.2b80@mx.google.com>
Date:   Tue, 30 Mar 2021 19:39:43 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.12-rc5-47-g506a524e05e2
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
Subject: pm/testing sleep: 3 runs, 1 regressions (v5.12-rc5-47-g506a524e05e2)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing sleep: 3 runs, 1 regressions (v5.12-rc5-47-g506a524e05e2)

Regressions Summary
-------------------

platform        | arch  | lab           | compiler | defconfig | regressions
----------------+-------+---------------+----------+-----------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-8    | defconfig | 1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.12-rc=
5-47-g506a524e05e2/plan/sleep/

  Test:     sleep
  Tree:     pm
  Branch:   testing
  Describe: v5.12-rc5-47-g506a524e05e2
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      506a524e05e240d2878cf86a56c47e72e09d329f =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig | regressions
----------------+-------+---------------+----------+-----------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-8    | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/6063d475521cb2c29cdac6c0

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.12-rc5-47-g506a5=
24e05e2/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.12-rc5-47-g506a5=
24e05e2/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2021=
0315.0/arm64/rootfs.cpio.gz =



  * sleep.login: https://kernelci.org/test/case/id/6063d475521cb2c29cdac6c1
        failing since 223 days (last pass: v5.8-107-gb72b3ea38c81, first fa=
il: v5.9-rc1-4-g1f08d51cd57f) =

 =20
