Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BFC463B2E9
	for <lists+linux-pm@lfdr.de>; Mon, 28 Nov 2022 21:22:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232565AbiK1UWh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 28 Nov 2022 15:22:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233404AbiK1UWh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 28 Nov 2022 15:22:37 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9128E2BF9
        for <linux-pm@vger.kernel.org>; Mon, 28 Nov 2022 12:22:36 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id w79so11638759pfc.2
        for <linux-pm@vger.kernel.org>; Mon, 28 Nov 2022 12:22:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=M3MO5vFk2kM37Nj/bWCMnz5TC5LJxzgeKioKGOU80Q0=;
        b=zbgsKaCKFR9yolPHx7jTdDDh1sGKyc3byZ6m58Q2V5NIj2+F+XVE59ZRjYHSyN6e6t
         L8jji2npJornTB2k4g9sS96wVntUKiAbdS0KHPRzxwFRwFANLmPmyZ1+0DGWy3bzb0j5
         X2E3PzXFGpxX6LuC4YNb0I93xF/w4SEfVMab7bPeVVt0ejIGiaIsL5oHRzjhd8+iu21p
         KiKQOeLBQPau7COY7xrMhndHYL94B3kHuAAmBDSu9N6o5D+BkgkUAYFT2OMstgjNLRUj
         qmfzDIrT6JrdX81I84vWOmlNsMr1qTsUkjZW31FZ0BXtX86k7xAU3Jq/73Gb+utL+0Wy
         fFYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M3MO5vFk2kM37Nj/bWCMnz5TC5LJxzgeKioKGOU80Q0=;
        b=36NLkBuNGZnV00tIizVQENJovcBSBjwBVwPrBXr+u/PMICkiIXxitjuNGX3pLcBIGv
         B60QghDqU4rGD0eGccgcyOaFJUgxMKq3n/0pSrpZnTXHjP0lQEzX29uKtSWUtEKpaPoR
         XdgO8dStjL7p14ohPpjdtlF7d7H6HPspzfYxasip3FbwkkLF7XTKL2kZ4ShULBPGbGxy
         Xv8TmhGDUPRethlnr+OwduZTZTex6in2FfuH77rSAOG4wSH8RneVhV99B8+6n+qZgMkY
         /5Hut/oZCIo1pRe4LGrX7cHij5uy3ARFIAPx8VJqNMStOCoVEPRCp5tbff3HavGeN9n5
         oiTA==
X-Gm-Message-State: ANoB5pkuivfMBkQakMewouMHc4VEWS0qAJYzzkZglEyc8euIaaIhgcx6
        70UM5lIKXBCgGndQzJcQEQliXg==
X-Google-Smtp-Source: AA0mqf4FxJRvZu0wFW7Bv0VCF6ZJ9xrbpJH2RKTEn81PorUFljRXFLcaqEBNB8kjJy9NJZQOv7CiyQ==
X-Received: by 2002:aa7:91d6:0:b0:574:c543:f804 with SMTP id z22-20020aa791d6000000b00574c543f804mr17032560pfa.51.1669666956080;
        Mon, 28 Nov 2022 12:22:36 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id s64-20020a637743000000b00476db6fe510sm7135475pgc.75.2022.11.28.12.22.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 12:22:35 -0800 (PST)
Message-ID: <6385188b.630a0220.6675f.a06b@mx.google.com>
Date:   Mon, 28 Nov 2022 12:22:35 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Kernel: v6.1-rc7-96-gdee69e7005ce
X-Kernelci-Report-Type: test
X-Kernelci-Tree: pm
Subject: pm/testing baseline: 25 runs,
 1 regressions (v6.1-rc7-96-gdee69e7005ce)
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

pm/testing baseline: 25 runs, 1 regressions (v6.1-rc7-96-gdee69e7005ce)

Regressions Summary
-------------------

platform   | arch | lab           | compiler | defconfig          | regress=
ions
-----------+------+---------------+----------+--------------------+--------=
----
odroid-xu3 | arm  | lab-collabora | gcc-10   | multi_v7_defconfig | 1      =
    =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v6.1-rc7=
-96-gdee69e7005ce/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v6.1-rc7-96-gdee69e7005ce
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      dee69e7005ce309e619155eb6372f287212e27f7 =



Test Regressions
---------------- =



platform   | arch | lab           | compiler | defconfig          | regress=
ions
-----------+------+---------------+----------+--------------------+--------=
----
odroid-xu3 | arm  | lab-collabora | gcc-10   | multi_v7_defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/6385138da360e173b52abcfa

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.1-rc7-96-gdee69e=
7005ce/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-odroid-xu3.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.1-rc7-96-gdee69e=
7005ce/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-odroid-xu3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20221125.0/armel/rootfs.cpio.gz =



  * baseline.dmesg.emerg: https://kernelci.org/test/case/id/6385138da360e17=
3b52abd01
        new failure (last pass: pm-6.1-rc7-97-g0b54caa6f14b)
        1 lines

    2022-11-28T20:00:55.433256  kern  :emerg : Disabling IRQ #147
    2022-11-28T20:00:55.453325  <8>[   22.282404] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Demerg RESULT=3Dfail UNITS=3Dlines MEASUREMENT=3D1>   =

 =20
