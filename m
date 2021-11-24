Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BC5545CD88
	for <lists+linux-pm@lfdr.de>; Wed, 24 Nov 2021 20:52:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235528AbhKXT4E (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 24 Nov 2021 14:56:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235076AbhKXT4D (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 24 Nov 2021 14:56:03 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69363C061574
        for <linux-pm@vger.kernel.org>; Wed, 24 Nov 2021 11:52:53 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id l190so3099011pge.7
        for <linux-pm@vger.kernel.org>; Wed, 24 Nov 2021 11:52:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=0cWzTmjlHWvd+yWpHsVoThzSR+P+J7m/Nn0KgKishZ0=;
        b=MgGXZsfNLiJW/pVewOvlirc88nzHpFTvz7+GAZqsNaQTB2wGJ3IgyBT3wCiN+x1rxj
         /wXVxtgJ2OGb5LqJyyuqZ0WxkvtT7P9EC65aKcsuxafP6v3TrXfLFlYIZjvn7+cBh5vO
         9osCyAgeER1WOh0k2scXo1nyI7H/lxl5W7CkCF7EkoLYDjga0se5GEZjWT4km/Oe/0BR
         FswFYl45gip+18uE7dFcxTfF9IarGJOF1BfA23AsHy7A/0+mMCUHT/7GPNPyfWWQMTfY
         Dm4BTio/8715XkBrzElKc2lBbBM4WLAXc9JMmd6YPF82/6Ze3d4r6fmMGpCjteq+c6nj
         ctAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=0cWzTmjlHWvd+yWpHsVoThzSR+P+J7m/Nn0KgKishZ0=;
        b=zmEc0tB6UJyt30U13Nb5gJERWM6tDtfwRajOMW7cVJQTUwdK7gZAHREJTxED4PeYK7
         VdUd/5JvxMFvzO1hqd79rQlKwS9GS2lkH4ecgw8SbtzBHfTCB3vgRv+MleP01YQzR6SN
         vYiBeu0bFwKCD7s7YSPe2JdRkKFnaqadz3DHp96VxkAhr30yjzsJnzQlje3qnYkY7jL0
         s6x+P9G1wbWBuFTqJGrz8700WjQttpS7GsfcaHhzZ7Ure4Qvj7mIb77B3f43s7RvqBmi
         DF3YvHat04dUBkQfEPMKKLnmijHAK1KsgHcsRzeA22FaUoC2BdpbBu1kp+SRkqtFfSaB
         SK1Q==
X-Gm-Message-State: AOAM533jvn/ENLKCNbZ5aKsV8EjzRaWs+aGOd2Eu6VD+jR6CAZXk0OSx
        r4R7mOKgqnth8ctxpLH/zw2WEsuHtZaghWIzrq4=
X-Google-Smtp-Source: ABdhPJylpI61oPz48yzy7Vc0bcoSnM3FxSiRur6TZBlMHJT8RkO2n4pq0hBh1TV/Thx6pGU+7VeP5Q==
X-Received: by 2002:a63:d110:: with SMTP id k16mr11947613pgg.90.1637783572814;
        Wed, 24 Nov 2021 11:52:52 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id p15sm440906pjh.1.2021.11.24.11.52.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Nov 2021 11:52:52 -0800 (PST)
Message-ID: <619e9814.1c69fb81.2d75.1939@mx.google.com>
Date:   Wed, 24 Nov 2021 11:52:52 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.16-rc2-16-ga3f78507f993
X-Kernelci-Report-Type: test
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
Subject: pm/testing sleep: 2 runs, 1 regressions (v5.16-rc2-16-ga3f78507f993)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing sleep: 2 runs, 1 regressions (v5.16-rc2-16-ga3f78507f993)

Regressions Summary
-------------------

platform         | arch  | lab           | compiler | defconfig | regressio=
ns
-----------------+-------+---------------+----------+-----------+----------=
--
rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig | 1        =
  =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.16-rc=
2-16-ga3f78507f993/plan/sleep/

  Test:     sleep
  Tree:     pm
  Branch:   testing
  Describe: v5.16-rc2-16-ga3f78507f993
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      a3f78507f9931f5abe2f8273896e002b59eaeb90 =



Test Regressions
---------------- =



platform         | arch  | lab           | compiler | defconfig | regressio=
ns
-----------------+-------+---------------+----------+-----------+----------=
--
rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig | 1        =
  =


  Details:     https://kernelci.org/test/plan/id/619e94ced6012bebaaf2efb4

  Results:     12 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.16-rc2-16-ga3f78=
507f993/arm64/defconfig/gcc-10/lab-collabora/sleep-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.16-rc2-16-ga3f78=
507f993/arm64/defconfig/gcc-10/lab-collabora/sleep-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2021=
1118.0/arm64/rootfs.cpio.gz =



  * sleep.rtcwake-mem-8: https://kernelci.org/test/case/id/619e94ced6012beb=
aaf2efb8
        new failure (last pass: v5.16-rc2-12-gf9efc61a2f28) =

 =20
