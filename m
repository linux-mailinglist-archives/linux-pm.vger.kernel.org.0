Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82832259F8A
	for <lists+linux-pm@lfdr.de>; Tue,  1 Sep 2020 21:57:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729348AbgIAT5Q (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 1 Sep 2020 15:57:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728508AbgIAT5Q (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 1 Sep 2020 15:57:16 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A9E8C061244
        for <linux-pm@vger.kernel.org>; Tue,  1 Sep 2020 12:57:15 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id ls14so1140558pjb.3
        for <linux-pm@vger.kernel.org>; Tue, 01 Sep 2020 12:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=voQdtlvxCveUhRIs9vi4jCxERJw4Mrc0RWoxXe/HugY=;
        b=0A6bQhR7VvEgVX5UsJHR6hCdkNpR6VC1Cq44j5HEGdAOmO97our//zqsS37RVi2Ytg
         wLHN2JAjQFO0oURs4kko+5Lhl6fVUyR9A8kuRr+C/TxoTEbG03UHM+Tqei6hQWw1gdjn
         1SoWrwTR+LqS1FeAA5zlZ0XMes9kTbBnZNNDAifC9EdgHbuEuE1S8LhJhInon2NnmW23
         BPXq0rr37uXd1bSN5NvRE38V+fOiYCTvQThZG2Lm5ea7xlwRZC2We3omjrbvjh1skm7B
         +5fxIum+B4ff7f5HKRW8VteuucHxrO1GFA9yLnUdxziNY36owGmRGr8sTXmaKh9iKEI1
         LDlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=voQdtlvxCveUhRIs9vi4jCxERJw4Mrc0RWoxXe/HugY=;
        b=Iv2/OKd+7Ouqi3WU0SaXfjDCJcpipuHFAdqFRES/MBK4RRfOMChoxVoxdxzWD3v14w
         KXa9kaA1NsEsRBdZmpfZcU/P8LpnGkTvdU8jgmSnC0Qs3vOA/YbEXvEOfkYi2mB2MsOv
         v4Vlu33I5RmlIBNkUtAls3uRh4VZovdBKD1ls7fUYrmW9a/DniOayJJlL4m0HfrmfseG
         DEWxNyE4ZdMqnSbBqbKgc6tBtIZ4jD1XT7qEJ/hpoWtB3pVxXahCM90RxF2EG88QFOG9
         yv/lJNVvdugbZj9yh0dJAMz6fmKhk27yfp2+nU2Mv8dobGZey2vCyR95BfCHiQ0N031j
         uLNQ==
X-Gm-Message-State: AOAM533EceeykP2bUgnG3/HEj+XXJsSjYfEw1k8pwhujOshMYIDiREaH
        Ahtk42m/Qe9Z5/5fTDzke5yWQCmZcH86Rg==
X-Google-Smtp-Source: ABdhPJw5R8C1SiiQ2GqEzoEkf6fEegflZuQE1uUKtZdDBMn/HsubK3wzgaWhM4r9FLUbdI6Sq/zoww==
X-Received: by 2002:a17:90a:fa94:: with SMTP id cu20mr3087292pjb.147.1598990234209;
        Tue, 01 Sep 2020 12:57:14 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id i9sm2977541pgb.37.2020.09.01.12.57.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 12:57:13 -0700 (PDT)
Message-ID: <5f4ea799.1c69fb81.45814.6db7@mx.google.com>
Date:   Tue, 01 Sep 2020 12:57:13 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v5.9-rc3-8-gd21006a798ed
Subject: pm/testing sleep: 6 runs, 1 regressions (v5.9-rc3-8-gd21006a798ed)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing sleep: 6 runs, 1 regressions (v5.9-rc3-8-gd21006a798ed)

Regressions Summary
-------------------

platform        | arch  | lab           | compiler | defconfig | results
----------------+-------+---------------+----------+-----------+--------
mt8173-elm-hana | arm64 | lab-collabora | gcc-8    | defconfig | 0/1    =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.9-rc3=
-8-gd21006a798ed/plan/sleep/

  Test:     sleep
  Tree:     pm
  Branch:   testing
  Describe: v5.9-rc3-8-gd21006a798ed
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      d21006a798ed464eacdcdb475b0be4655c816053 =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig | results
----------------+-------+---------------+----------+-----------+--------
mt8173-elm-hana | arm64 | lab-collabora | gcc-8    | defconfig | 0/1    =


  Details:     https://kernelci.org/test/plan/id/5f4e98ed3a50c2f0f808114c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.9-rc3-8-gd21006a=
798ed/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.9-rc3-8-gd21006a=
798ed/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2020=
0821.0/arm64/rootfs.cpio.gz =


  * sleep.login: https://kernelci.org/test/case/id/5f4e98ed3a50c2f0f808114d
      failing since 13 days (last pass: v5.8-107-gb72b3ea38c81, first fail:=
 v5.9-rc1-4-g1f08d51cd57f)  =20
