Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41A33422F9D
	for <lists+linux-pm@lfdr.de>; Tue,  5 Oct 2021 20:05:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232861AbhJESHk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 5 Oct 2021 14:07:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbhJESHk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 5 Oct 2021 14:07:40 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ED58C061749
        for <linux-pm@vger.kernel.org>; Tue,  5 Oct 2021 11:05:49 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id 187so201004pfc.10
        for <linux-pm@vger.kernel.org>; Tue, 05 Oct 2021 11:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=jaQ9FboIDtxXBghWjGnkTtPHcEHeWQSEYBtsCG3gkOY=;
        b=f6FgrjnQjPlKfvniZjcpG9zfSX/58v3jcaCM54+noX81fOm25KFfYxb2/jmW5bom3U
         TdtM+fIW6BQqc0Sq9+Uq8HmGq0d1Ye/8qz7MKPJ4tFEAH+ICPpLwAErBhkUPtPI/yGhd
         CKkFGgu/X7IUuThXuHUpCxVcAzf6XfApea+GKPkq5VUh+FwC1qJB/uRHIWtVW1WYa3rp
         l0gC0w9TcYus0pAOEw+dGZrXBQYDDU7CXMP5cJEVvSaR3mTdqhHdkrwT7+J2gyl6eVi/
         euLtzpeUfJfB1KBayc9AY4ruDdbBO5GTNinCl6x9qwupg1KkC19XzxqLKgiQI+eKqt3w
         yFTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=jaQ9FboIDtxXBghWjGnkTtPHcEHeWQSEYBtsCG3gkOY=;
        b=G3Lx/8EMKeGufRO6TnnHBD8F2oIHGQ9PX7oC9A/CIiHEOxExkoeFTHDuxh0eAONMkn
         2UaeUxTZOVUIOPnMR2ktUGPcRyJxxtv7Jc61S/WV1BrR7aQUF4JLx5A51npyFQZeyM9h
         0szV3+c0iFmKT/nT10CotA3WFglDrAyqqdRWirCygq5rtw/h6nOXrSDwTfswHXQxeS4B
         L7CKXWMMXbMwqRIgVYPoEnR7Vgfnhd2teJzytiTvJ7HdI5MeP61LFf9aaycpbCa9K41G
         +hIX6woq1VkFAskYduKxKdBow3zOJ9Xnd4fe6uaI0aekyvb5OVlJp89Q13bCQ2oGt+NS
         yDVA==
X-Gm-Message-State: AOAM530eCxXYIjOMry6g81TGZgoOu0/9b6j6E5BTTxO6FRdtVv8aVAHL
        JxGLNjowrK+aGpBbjFd9woq8mg==
X-Google-Smtp-Source: ABdhPJy66oXJK6ksStRVEe5FIaiJ4x9yCOgWKHXVY1dovBq1GenlIfnj1BaM+T3lBBJ23IPP1tBo0Q==
X-Received: by 2002:a05:6a00:188b:b0:44c:70a8:cf4 with SMTP id x11-20020a056a00188b00b0044c70a80cf4mr8499387pfh.85.1633457148952;
        Tue, 05 Oct 2021 11:05:48 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id v22sm18507692pff.93.2021.10.05.11.05.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 11:05:48 -0700 (PDT)
Message-ID: <615c93fc.1c69fb81.1a07e.8e9e@mx.google.com>
Date:   Tue, 05 Oct 2021 11:05:48 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.15-rc4-24-g8e0efc215fb1
X-Kernelci-Report-Type: test
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
Subject: pm/testing sleep: 4 runs, 1 regressions (v5.15-rc4-24-g8e0efc215fb1)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing sleep: 4 runs, 1 regressions (v5.15-rc4-24-g8e0efc215fb1)

Regressions Summary
-------------------

platform        | arch  | lab           | compiler | defconfig | regressions
----------------+-------+---------------+----------+-----------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-8    | defconfig | 1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.15-rc=
4-24-g8e0efc215fb1/plan/sleep/

  Test:     sleep
  Tree:     pm
  Branch:   testing
  Describe: v5.15-rc4-24-g8e0efc215fb1
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      8e0efc215fb15481ac2c12c7e11ce2d7d2803691 =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig | regressions
----------------+-------+---------------+----------+-----------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-8    | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/615c86ffb819bb819899a2da

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.15-rc4-24-g8e0ef=
c215fb1/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.15-rc4-24-g8e0ef=
c215fb1/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2021=
0913.0/arm64/rootfs.cpio.gz =



  * sleep.login: https://kernelci.org/test/case/id/615c86ffb819bb819899a2db
        failing since 411 days (last pass: v5.8-107-gb72b3ea38c81, first fa=
il: v5.9-rc1-4-g1f08d51cd57f) =

 =20
