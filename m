Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 656737BF1DD
	for <lists+linux-pm@lfdr.de>; Tue, 10 Oct 2023 06:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbjJJENK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Oct 2023 00:13:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbjJJENJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Oct 2023 00:13:09 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B95D39D
        for <linux-pm@vger.kernel.org>; Mon,  9 Oct 2023 21:13:07 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-578d0dcd4e1so3276249a12.2
        for <linux-pm@vger.kernel.org>; Mon, 09 Oct 2023 21:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1696911187; x=1697515987; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=GstSII8b9kNQ1le6BxREd4epTzUTwMlZlXRqJ17Vydg=;
        b=K1fa8s8r9pHcPWpCG/+LmmeBRRXT6+LNtfLaCzkG/L7p7Ig4dHjCkl9Mu6xRTeDB+z
         ypke6gmcXu0T1q07HDZD76DK77hkW04fRe8bjkH3JkRMl8PE+RuVrrywmC/1BzclkimW
         jK4fiavW/Mx4WX0afVh79K9iIP3K6ou3PJncu/nP4IwDo/2ECpZ+7xE7SY8NNFyHmheE
         0OBrspwaj+lcVEtVXp0ME/yWPLVpy/sNHm78p0IqYAAMsyKPiO7gAdwSsElHA+rHzx5P
         yFRDGZueiFvU/1/4kXSY2seccx0JW3s21u1Oz5vxVEjzd3NLSvdj1J9YT/eR9GY4jzps
         DVIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696911187; x=1697515987;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GstSII8b9kNQ1le6BxREd4epTzUTwMlZlXRqJ17Vydg=;
        b=hXFIrigy4kCOtYI6PJKiV8pItPNp0hTw17tvg3wo+x7CdnbkMCrv2KSKP4tKB0mqDC
         sKJYgDav2if6Ptv8f/fqr8cfnD9F9ZqSAbPhFnDED6PGqImh3Q2+lD0wUzQUvyHHG8U5
         zKV6cejGT+aU8dxPfCC/VTKHVZ3rFlzTremVon47fwHc2zKDfIp3bhidRmqnqnBLxtdJ
         q4n5MNzZntxI4U01D7krbbxrbTme+Hb0fZ/vbDRN8lOqfOAhSPrWHwBhDXi4C0IokdW4
         Va+HSa80e54utHy6ZaOMzbUVloKaPBY5Y/vvpVhXjqs/DQtLdvg9xiDlsGQuWWFD9fr4
         GzRQ==
X-Gm-Message-State: AOJu0YzPwXBS98Fu5tc8a7ajZkyRVDBkzKZ0bGila2M+CDAvC+DGL45T
        +Jlhj+/XujqM7kDVsMApsCmI99rHzRG5J5zD22peQw==
X-Google-Smtp-Source: AGHT+IHuhFsPyTPjxj0if+DrYiG/fkV0g+omBLmOn4fNskZuoqfCGM6hhzttZ1F7HD2G8rDz+0P2Zg==
X-Received: by 2002:a05:6a21:198:b0:157:e4c6:766a with SMTP id le24-20020a056a21019800b00157e4c6766amr18396014pzb.41.1696911187213;
        Mon, 09 Oct 2023 21:13:07 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id h13-20020a170902eecd00b001c446f12973sm10502406plb.203.2023.10.09.21.13.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 21:13:06 -0700 (PDT)
Message-ID: <6524cf52.170a0220.18993.cd8f@mx.google.com>
Date:   Mon, 09 Oct 2023 21:13:06 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.6-rc5-135-g3fa39021ead0
X-Kernelci-Report-Type: test
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
Subject: pm/testing baseline: 46 runs,
 2 regressions (v6.6-rc5-135-g3fa39021ead0)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 46 runs, 2 regressions (v6.6-rc5-135-g3fa39021ead0)

Regressions Summary
-------------------

platform      | arch  | lab           | compiler | defconfig | regressions
--------------+-------+---------------+----------+-----------+------------
imx8mp-evk    | arm64 | lab-broonie   | gcc-10   | defconfig | 1          =

r8a77960-ulcb | arm64 | lab-collabora | gcc-10   | defconfig | 1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v6.6-rc5=
-135-g3fa39021ead0/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v6.6-rc5-135-g3fa39021ead0
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      3fa39021ead0c8a84117648a727ca8b2f8af3b3d =



Test Regressions
---------------- =



platform      | arch  | lab           | compiler | defconfig | regressions
--------------+-------+---------------+----------+-----------+------------
imx8mp-evk    | arm64 | lab-broonie   | gcc-10   | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/6524c5ae631c341553efd020

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.6-rc5-135-g3fa39=
021ead0/arm64/defconfig/gcc-10/lab-broonie/baseline-imx8mp-evk.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.6-rc5-135-g3fa39=
021ead0/arm64/defconfig/gcc-10/lab-broonie/baseline-imx8mp-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6524c5ae631c341553efd029
        failing since 27 days (last pass: pm-6.6-rc1-122-g07b618ec9d7a, fir=
st fail: v6.6-rc1-5-gb5eda4c9c923)

    2023-10-10T03:31:45.188138  + set<8>[   29.161892] <LAVA_SIGNAL_ENDRUN =
0_dmesg 159547_1.5.2.4.1>
    2023-10-10T03:31:45.188724   +x
    2023-10-10T03:31:45.297267  / # #
    2023-10-10T03:31:46.463119  export SHELL=3D/bin/sh
    2023-10-10T03:31:46.469177  #
    2023-10-10T03:31:47.967931  / # export SHELL=3D/bin/sh. /lava-159547/en=
vironment
    2023-10-10T03:31:47.973978  =

    2023-10-10T03:31:50.696962  / # . /lava-159547/environment/lava-159547/=
bin/lava-test-runner /lava-159547/1
    2023-10-10T03:31:50.703778  =

    2023-10-10T03:31:50.706907  / # /lava-159547/bin/lava-test-runner /lava=
-159547/1 =

    ... (13 line(s) more)  =

 =



platform      | arch  | lab           | compiler | defconfig | regressions
--------------+-------+---------------+----------+-----------+------------
r8a77960-ulcb | arm64 | lab-collabora | gcc-10   | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/6524c4b885f9d1a46defcf70

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.6-rc5-135-g3fa39=
021ead0/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.6-rc5-135-g3fa39=
021ead0/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6524c4b885f9d1a46defcf79
        failing since 82 days (last pass: pm-6.5-rc2-210-ga648a2d354da, fir=
st fail: v6.5-rc2-44-g6384f300e9f3)

    2023-10-10T03:31:59.948592  / # #

    2023-10-10T03:32:00.050729  export SHELL=3D/bin/sh

    2023-10-10T03:32:00.051454  #

    2023-10-10T03:32:00.152829  / # export SHELL=3D/bin/sh. /lava-11720029/=
environment

    2023-10-10T03:32:00.153463  =


    2023-10-10T03:32:00.254824  / # . /lava-11720029/environment/lava-11720=
029/bin/lava-test-runner /lava-11720029/1

    2023-10-10T03:32:00.255861  =


    2023-10-10T03:32:00.257712  / # /lava-11720029/bin/lava-test-runner /la=
va-11720029/1

    2023-10-10T03:32:00.322045  + export 'TESTRUN_ID=3D1_bootrr'

    2023-10-10T03:32:00.322561  + cd /lav<8>[   20.370947] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 11720029_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =20
