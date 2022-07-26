Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B675B5808DA
	for <lists+linux-pm@lfdr.de>; Tue, 26 Jul 2022 02:57:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbiGZA5Z (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 25 Jul 2022 20:57:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbiGZA5Y (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 25 Jul 2022 20:57:24 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACB6C255BA
        for <linux-pm@vger.kernel.org>; Mon, 25 Jul 2022 17:57:23 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 23so11794113pgc.8
        for <linux-pm@vger.kernel.org>; Mon, 25 Jul 2022 17:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=oL+RvM30ZxxUjxj+rQjp8iYxeRkpoR15cHSpkyaxSJI=;
        b=6AtsATvgfkxu9XICJ4tcK6IOmifzQLYvOewerNcU+m78ruB/pMs5i8oAIJvZAExohE
         JDYXcLzMdrGOKpPrSNxWiGBvdiS2mP6cImQqHX8kibFOi/UQW+D83KSOnDJoRNDgSuMF
         5dbisThh2w1qouyzjiHexZbqhRnncU5ZwNtK3DKqCiut2nlLddQLH6Ik6+v1L/o5hfVb
         yNwjhKu9CCJkK5/RDZpvXLTAGY67gVaydMsH8LG8sX56o9RGdldQHo7GGKM5twnp+1eO
         vnhli4xDlMmtrRphbGYTVEfA3D/8RlWMSsOkvNICDPZkh7uLiq4B9FLLsW51YC7+Y9y6
         KQSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=oL+RvM30ZxxUjxj+rQjp8iYxeRkpoR15cHSpkyaxSJI=;
        b=c44rxecAINs10zPqLd5gqRNPqmeZAUCnHH0tlgiDURvm1sKxzrwEuisRmm7GmJapGO
         Q8mo1aPxKpDExA00VP5tHeMVXdir21Z/EmJGk5h0zefEr6PY8eC10mKxlwi97Xu+Tk6E
         BAriXy3sf9+V6gaHXyQU5DT4Ys0p4VdyI3XSWxhX4ysIieM7N2tY0VhoapKpORk/yk/S
         w1g9/V95mtdJ7MsaAkiqnzjIu6Z0j4kyBQhXIEGYbKKZjcHUAaIG0yCK391ba2ZSuMaF
         YScfKXBra2LsNYdXEoM0ZjZzCXsBOm0sHJHWbQnBwp8N943L5xAUvfHezFenGJBLwus7
         btxQ==
X-Gm-Message-State: AJIora8ReQ4ITWrE1sAIKgNgQykdgJbXih6eZanS2VkKtvD94yxQBbQg
        jJQwU9KkAb77QvKCRQ5Vr0yAJTSd+qpbQCIN
X-Google-Smtp-Source: AGRyM1tf44noG62HMyETlljJwexiTtiDyO0Q94Yps3QIsl3FxILAi2pjZn1HW/W7/clgInCHKjcing==
X-Received: by 2002:a65:57c6:0:b0:415:c329:5d49 with SMTP id q6-20020a6557c6000000b00415c3295d49mr12592051pgr.581.1658797043248;
        Mon, 25 Jul 2022 17:57:23 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id m15-20020a17090a158f00b001f10b31e7a7sm9447833pja.32.2022.07.25.17.57.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 17:57:23 -0700 (PDT)
Message-ID: <62df3bf3.1c69fb81.76184.e6ec@mx.google.com>
Date:   Mon, 25 Jul 2022 17:57:23 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.19-rc8-79-gb3f10ca8bf191
Subject: pm/testing baseline: 98 runs,
 1 regressions (v5.19-rc8-79-gb3f10ca8bf191)
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

pm/testing baseline: 98 runs, 1 regressions (v5.19-rc8-79-gb3f10ca8bf191)

Regressions Summary
-------------------

platform              | arch  | lab         | compiler | defconfig | regres=
sions
----------------------+-------+-------------+----------+-----------+-------=
-----
kontron-kbox-a-230-ls | arm64 | lab-kontron | gcc-10   | defconfig | 1     =
     =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.19-rc=
8-79-gb3f10ca8bf191/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v5.19-rc8-79-gb3f10ca8bf191
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      b3f10ca8bf191b812bf40c0911a22ce8ce67d13a =



Test Regressions
---------------- =



platform              | arch  | lab         | compiler | defconfig | regres=
sions
----------------------+-------+-------------+----------+-----------+-------=
-----
kontron-kbox-a-230-ls | arm64 | lab-kontron | gcc-10   | defconfig | 1     =
     =


  Details:     https://kernelci.org/test/plan/id/62df2f4ca76a0551eadaf066

  Results:     94 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.19-rc8-79-gb3f10=
ca8bf191/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-kbox-a-230-ls.=
txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.19-rc8-79-gb3f10=
ca8bf191/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-kbox-a-230-ls.=
html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220718.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.mscc_felix-probed: https://kernelci.org/test/case/id/62=
df2f4ca76a0551eadaf06f
        failing since 48 days (last pass: v5.18-rc7-183-g45785e0ed597, firs=
t fail: v5.19-rc1-2-g6a8964e282382)

    2022-07-26T00:03:12.016724  /lava-145300/1/../bin/lava-test-case
    2022-07-26T00:03:12.017054  <8>[   18.913339] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmscc_felix-probed RESULT=3Dfail>
    2022-07-26T00:03:12.017249  /lava-145300/1/../bin/lava-test-case
    2022-07-26T00:03:12.017433  <8>[   18.930345] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dleds-gpio-driver-present RESULT=3Dpass>
    2022-07-26T00:03:12.017618  /lava-145300/1/../bin/lava-test-case   =

 =20
