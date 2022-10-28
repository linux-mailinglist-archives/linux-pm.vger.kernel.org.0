Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A97A611807
	for <lists+linux-pm@lfdr.de>; Fri, 28 Oct 2022 18:49:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbiJ1Qtr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 28 Oct 2022 12:49:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbiJ1Qtq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 28 Oct 2022 12:49:46 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E611125E88
        for <linux-pm@vger.kernel.org>; Fri, 28 Oct 2022 09:49:45 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id f5-20020a17090a4a8500b002131bb59d61so8148369pjh.1
        for <linux-pm@vger.kernel.org>; Fri, 28 Oct 2022 09:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=mrcD5HmI51mFiSzRrJvwaW0gsy+kPJUeapV7l+XtCBo=;
        b=AhSIZqEHWEqm0xGvQEl6cR3q28hONaJbmrbp0vq3EvfUTYQORX3LnUvQ8WGmmZv7bo
         qu/n47LONgAl5jeGTFOmDbLRuCRTXRvbmAV6q/6R7ErBQ4EZW15f8JC56FBQ7ER9lLM6
         l7uAwGkuK2ks03n15QHq1C4VxsNCKuywgdJpAL6jK78JDBA5mnfxpjWDIFcSVoOQwO+6
         25nj4cem4yry+F8A5kg877ImhMN7hzV7KrIKPMB7vPXUKDWaH0/cz7D0oInnARPv+95u
         uqnDenpLvozFmSQZzcA60/PvzUfsgS2ItYXtI9tW33f/HHAlY1f5KSFes8mZBZCYXkhg
         rLbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mrcD5HmI51mFiSzRrJvwaW0gsy+kPJUeapV7l+XtCBo=;
        b=zvO0PYaBr7IHhkqKYNz9oesn2fQfuLDun+VLLBzq34BMMntbqwywJfTWKRBpL5wSht
         JrC76afqaKDOkRTJAQS7Te5TLe/WYGQzwfm9SWSLIG0P5gdBCFPoApa4usthQI02RjJ9
         iJud/Cw40mQg2AxOqnPr43l846WcN+B6PSKbwRpK1VdUhuXuknbyA0Ud2eWCjy97p2bn
         Zg1yNOAipumdd0LLldXIFdQsR5UM6a/Sczk1/W7DSk66s2F/2GRLbpwgO7R4jDkPYDq7
         Zp657mEVI9jvnqiBi1DgNd387Oq10xsGy/gLvbCT/4LYh2LGPic9J8BcBY3BAKQavQlC
         ELiA==
X-Gm-Message-State: ACrzQf1VwbhaSbhQKrFZa7UrkWgq85T7XbqfxgefAyHwQFV4HMuIOo5h
        sh50xqC3HLYQaXidhl2ZqCIkDg==
X-Google-Smtp-Source: AMsMyM4FMBSmpKR1lCbpyV7G36NI5Va/MI2Q/qNHCQsQbUtMXrM53tA9ym7mSw3BofrFjfmAqexnAw==
X-Received: by 2002:a17:90a:e593:b0:212:f0e8:46ca with SMTP id g19-20020a17090ae59300b00212f0e846camr17373436pjz.144.1666975785025;
        Fri, 28 Oct 2022 09:49:45 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id s14-20020a170902ea0e00b001837b19ebb8sm3354142plg.244.2022.10.28.09.49.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 09:49:44 -0700 (PDT)
Message-ID: <635c0828.170a0220.c3bd0.6d4f@mx.google.com>
Date:   Fri, 28 Oct 2022 09:49:44 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.1-rc2-18-g111ae903a8e62
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
Subject: pm/testing baseline: 55 runs,
 1 regressions (v6.1-rc2-18-g111ae903a8e62)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 55 runs, 1 regressions (v6.1-rc2-18-g111ae903a8e62)

Regressions Summary
-------------------

platform              | arch  | lab         | compiler | defconfig | regres=
sions
----------------------+-------+-------------+----------+-----------+-------=
-----
kontron-kbox-a-230-ls | arm64 | lab-kontron | gcc-10   | defconfig | 1     =
     =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v6.1-rc2=
-18-g111ae903a8e62/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v6.1-rc2-18-g111ae903a8e62
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      111ae903a8e6222057b042648ac9b64ffd4adb63 =



Test Regressions
---------------- =



platform              | arch  | lab         | compiler | defconfig | regres=
sions
----------------------+-------+-------------+----------+-----------+-------=
-----
kontron-kbox-a-230-ls | arm64 | lab-kontron | gcc-10   | defconfig | 1     =
     =


  Details:     https://kernelci.org/test/plan/id/635bfc3a7add839acbe7db57

  Results:     94 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.1-rc2-18-g111ae9=
03a8e62/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-kbox-a-230-ls.t=
xt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.1-rc2-18-g111ae9=
03a8e62/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-kbox-a-230-ls.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20221024.1/arm64/rootfs.cpio.gz =



  * baseline.bootrr.mscc_felix-probed: https://kernelci.org/test/case/id/63=
5bfc3a7add839acbe7db60
        failing since 143 days (last pass: v5.18-rc7-183-g45785e0ed597, fir=
st fail: v5.19-rc1-2-g6a8964e282382)

    2022-10-28T15:58:37.007681  /lava-193349/1/../bin/lava-test-case
    2022-10-28T15:58:37.008085  <8>[   17.009103] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmscc_felix-probed RESULT=3Dfail>
    2022-10-28T15:58:37.008302  /lava-193349/1/../bin/lava-test-case
    2022-10-28T15:58:37.008518  <8>[   17.025167] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dleds-gpio-driver-present RESULT=3Dpass>
    2022-10-28T15:58:37.008735  /lava-193349/1/../bin/lava-test-case
    2022-10-28T15:58:37.008945  <8>[   17.041281] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dleds-gpio-probed RESULT=3Dpass>
    2022-10-28T15:58:37.009170  /lava-193349/1/../bin/lava-test-case   =

 =20
