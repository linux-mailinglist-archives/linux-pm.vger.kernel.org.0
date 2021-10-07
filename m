Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C58B2425FC1
	for <lists+linux-pm@lfdr.de>; Fri,  8 Oct 2021 00:18:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231825AbhJGWTz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 7 Oct 2021 18:19:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231613AbhJGWTy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 7 Oct 2021 18:19:54 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAC83C061570
        for <linux-pm@vger.kernel.org>; Thu,  7 Oct 2021 15:17:59 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id k23so6062225pji.0
        for <linux-pm@vger.kernel.org>; Thu, 07 Oct 2021 15:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=NXxGx4J34fk66THJ2ruvmOmIoG8yXsxNkV12r4Oa2D0=;
        b=HaPtZ+UkhBNfPP8fWwsUIFWDYrN6mDvNvbJ951hrse4CVeUsalIGdnRfzYBl7z+VHa
         uVmy7rcmXlD7+DQ8p9jJclZulyaooGjx37a8SNXIf0tr6yX2f6YWeCPkP95MLJP/scIx
         f9N9zqlu7M7kFbUiirdt7ksaNmucWBdgR1snT29f4S0o8+tM6MP2XSnfqqESJ9zN2Vwo
         hSucNMElJ/Jribjffpid5kAVW3hvnhEnyPmIJW+/f58otdC2qRo4SXybDvOjVlfnmupg
         WcDBl3SIoVf2VL9b97lyOB7O4M1NNHEs6JSdh9cEM2lFJYKKl0y10SN6hHmiW30+IUjB
         9AFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=NXxGx4J34fk66THJ2ruvmOmIoG8yXsxNkV12r4Oa2D0=;
        b=RLnj62O7GE4CsjoK7uyZUJyYCnPSMa6ymvk9xCEdgTN8FcK5F/8LpWdIRQw9nqvBHD
         lASOoyYyon44u6gOUaJv6MdXIueTjPc4rjYBzQd1ksrqOYG8hYQZiOVH2gpelZcm3a3J
         BbL7vUvUGaddOLH1LX/PFPtHPz8z0Pp1GD2RV6AT94+rqcroBNizPArYeyeGEaSTVmu8
         tCmVrot4kHcVRQibtWDRjeeYtU8mJzY/cquMTNoHAPJWS6zvhWQAyVReHucuP3wcDbfG
         KfnQQiHCHz1grunPr/fr4ShZfVWbdBQsMvR2puQ2Lv9mChO4//OnIuE/dTQlLYu+71VO
         B7kg==
X-Gm-Message-State: AOAM531O7+Bs3OkAQotJCU0jirEiw1KwktsFM96h36JXL6qs6P2cQv8A
        2X1C/HzW9Bdhus/vJuT8xQfocw==
X-Google-Smtp-Source: ABdhPJxaQDa9tmwEed4QdWnfiUj3enIcE0Gp6Aqme79isNpuN1feKiA6GJBEUEDDVfg7bRaUsZo8fw==
X-Received: by 2002:a17:902:930c:b0:13e:42b4:9149 with SMTP id bc12-20020a170902930c00b0013e42b49149mr6064386plb.86.1633645078997;
        Thu, 07 Oct 2021 15:17:58 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id 1sm371935pfm.163.2021.10.07.15.17.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 15:17:58 -0700 (PDT)
Message-ID: <615f7216.1c69fb81.99f98.1a88@mx.google.com>
Date:   Thu, 07 Oct 2021 15:17:58 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.15-rc4-42-g574167bf7ed8
X-Kernelci-Report-Type: test
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
Subject: pm/testing sleep: 4 runs, 1 regressions (v5.15-rc4-42-g574167bf7ed8)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing sleep: 4 runs, 1 regressions (v5.15-rc4-42-g574167bf7ed8)

Regressions Summary
-------------------

platform        | arch  | lab           | compiler | defconfig | regressions
----------------+-------+---------------+----------+-----------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-8    | defconfig | 1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.15-rc=
4-42-g574167bf7ed8/plan/sleep/

  Test:     sleep
  Tree:     pm
  Branch:   testing
  Describe: v5.15-rc4-42-g574167bf7ed8
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      574167bf7ed8e12be9710fc84442c5e23775f75d =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig | regressions
----------------+-------+---------------+----------+-----------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-8    | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/615f660d62d1ad622699a338

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.15-rc4-42-g57416=
7bf7ed8/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.15-rc4-42-g57416=
7bf7ed8/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2021=
0913.0/arm64/rootfs.cpio.gz =



  * sleep.login: https://kernelci.org/test/case/id/615f660d62d1ad622699a339
        failing since 414 days (last pass: v5.8-107-gb72b3ea38c81, first fa=
il: v5.9-rc1-4-g1f08d51cd57f) =

 =20
