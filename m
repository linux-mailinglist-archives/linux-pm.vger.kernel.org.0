Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64A9520A2BA
	for <lists+linux-pm@lfdr.de>; Thu, 25 Jun 2020 18:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406064AbgFYQPP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 25 Jun 2020 12:15:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406057AbgFYQPN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 25 Jun 2020 12:15:13 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C1ECC08C5C1
        for <linux-pm@vger.kernel.org>; Thu, 25 Jun 2020 09:15:13 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id q90so2739204pjh.3
        for <linux-pm@vger.kernel.org>; Thu, 25 Jun 2020 09:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=LiR+vvBj/1zG53Aljjyp+mWfuQeKPL4gCZSBIMws0J8=;
        b=jMnJrRJf/2MMXx8vq3QHNLgJDXpORh9Cbqi1vvxRZY4RmEktiws4bUmCMv8gHNAQic
         Up/PeaxGpztX/mg2MCcqH2bmDt/QaCwymZhhwMRXrA1FALCvZw9cDjQdX600NfQ1rbZX
         D70mTkRP+SYL2qKfNaSCQ4lX7r17La40Vgo4gC+let9jsiLHApLhIq24WM5MYP6uN6Wc
         pUKiTTkZLF1NlMbJ9nKLAFckgGSanPktFRQgFJcNsx+hoJVdh3NkH1tO7LS8Yx2AQhiK
         sGVDQTyr7XRPGhklcwvK6QCXLJSZ7QeyxYujluxFeBxNFY2umapVSY96BEcDdXZEd7Mf
         OxEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=LiR+vvBj/1zG53Aljjyp+mWfuQeKPL4gCZSBIMws0J8=;
        b=V/JjjLg0vkkmZJ0JVSKlcV7nouspxQelJSu9C304HxhOG3CJHy4LBbeEq05YY3tmpH
         bup7XPMITN4jWcKuwszw0MTkKRhAJg1iGJGLtBL/XjwDU84V8ioKoEjo8d1kAcgoyCzB
         GLx+og09xDRjLslPLRmBvRxpjd+Pz+sE4BMKlDP2Oi0uiFupwkWvn1MVy3hIjNg57lLp
         YHG2yUptwahwoEV23Qtko2gDRdXQdq1t0B8UrMdsRVHzpeiEMrOsu8LJKwz6EJ1eNR7x
         34F5Rk8Wnb/Stbl0LmOjfm3cF8DQRxCYil3LG1t210aVExaJPDmS7p4ygahKunbVXn4u
         Pelg==
X-Gm-Message-State: AOAM531HE+RVyGo7Wwj8efJ0LNeuaWBHcsBdeXYtYwoeACBBZLAGOv3I
        SGW8MaJgzh0DtCS6/tEilu584Q==
X-Google-Smtp-Source: ABdhPJxLo3cgvmx8uIiOPVtNRhmD3w7jlg+qeALu2byDvfHbN84bZy5cMGScAeUERTeIH+ygJF15Nw==
X-Received: by 2002:a17:90a:2ec6:: with SMTP id h6mr4192447pjs.82.1593101712791;
        Thu, 25 Jun 2020 09:15:12 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id j23sm2374141pfn.3.2020.06.25.09.15.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 09:15:12 -0700 (PDT)
Message-ID: <5ef4cd90.1c69fb81.43355.5179@mx.google.com>
Date:   Thu, 25 Jun 2020 09:15:12 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v5.8-rc2-24-gdcc4e8ba3539
Subject: pm/testing baseline: 44 runs,
 1 regressions (v5.8-rc2-24-gdcc4e8ba3539)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 44 runs, 1 regressions (v5.8-rc2-24-gdcc4e8ba3539)

Regressions Summary
-------------------

platform        | arch  | lab          | compiler | defconfig | results
----------------+-------+--------------+----------+-----------+--------
bcm2837-rpi-3-b | arm64 | lab-baylibre | gcc-8    | defconfig | 4/5    =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.8-rc2=
-24-gdcc4e8ba3539/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v5.8-rc2-24-gdcc4e8ba3539
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      dcc4e8ba353955cbf43d70c71f1bd543839e2094 =



Test Regressions
---------------- =



platform        | arch  | lab          | compiler | defconfig | results
----------------+-------+--------------+----------+-----------+--------
bcm2837-rpi-3-b | arm64 | lab-baylibre | gcc-8    | defconfig | 4/5    =


  Details:     https://kernelci.org/test/plan/id/5ef4c395d7ae53114997bf13

  Results:     4 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.8-rc2-24-gdcc4e8=
ba3539/arm64/defconfig/gcc-8/lab-baylibre/baseline-bcm2837-rpi-3-b.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.8-rc2-24-gdcc4e8=
ba3539/arm64/defconfig/gcc-8/lab-baylibre/baseline-bcm2837-rpi-3-b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2019=
.02-11-g17e793fa4728/arm64/baseline/rootfs.cpio.gz =


  * baseline.dmesg.crit: https://kernelci.org/test/case/id/5ef4c395d7ae5311=
4997bf16
      failing since 1 day (last pass: v5.8-rc2-8-g43bad67922e1, first fail:=
 v5.8-rc2-12-g3f291d339bdc)
      1 lines =20
