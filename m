Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81C141E8A72
	for <lists+linux-pm@lfdr.de>; Fri, 29 May 2020 23:50:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726975AbgE2Vut (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 29 May 2020 17:50:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728355AbgE2Vuq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 29 May 2020 17:50:46 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3CBDC08C5C9
        for <linux-pm@vger.kernel.org>; Fri, 29 May 2020 14:50:46 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id bg4so1757117plb.3
        for <linux-pm@vger.kernel.org>; Fri, 29 May 2020 14:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=HvoiZXZLChaJ6uK1AmN2gAkLgN6fSAXKxfC8iIqeQ9c=;
        b=HGPWlVMQNz0gB/7Pz+o39AZpH+voqhNt8baXgsszfmgZBODe2wonb4Hn+hcCeoKaWK
         l0FBYkHiXM7Y0L0zmB8r9aFt1Im1sfrGHQj0fEfIX/H1rG+T0kt/qdykGilZVrhm+6nD
         bZTMUKX134LekJRvT9X/+GoJsu4Lax2JZah9+/gmCEKrsMb5dXc755LdYdvx11Y6XPXX
         A3/AYxBfgYhPM5lJc+dNx+TpdeBj0QwDtPisYkHcYIDh5s4TgMMVKMevHitjsTZSNmiw
         jxt4bA1kuo3ycX9TLuq5fr3N/xx19acmshgpXsKleujGU3eBjZ1gL4c5xemS3xNGotSY
         unxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=HvoiZXZLChaJ6uK1AmN2gAkLgN6fSAXKxfC8iIqeQ9c=;
        b=Y28OYAHGrgH5XZDso2zyKo4hpahSA5IEybcTQYtfgTm2TM1B98mnEruTHsQCuNGqES
         WhcLbPOn+1OhFcdvN2zG04vwAJZlDCTajW3xglJ/KiK3fZ87L2HSJ+RQNW9bKJdZ4Ats
         VhpqMqZNSBG4x+66AwA98OV8CpawhNPE9y4YsMeRrXZASlS+U+MEumkUh7jjAkR52v5m
         D9D+U9c/5CTKivfnElAuCPfM9XVGE8hmA4ceOg1PrsiMtM9ZspF2TSeiz3E/M+rLW8P/
         3oopYqXQCnhNj62M1XPFJiAc9URVjpXRwLWv6UGEEXde+HTq/0xyYfzZmPuN6AziCpLt
         T7XQ==
X-Gm-Message-State: AOAM533zOl/u8R5MTBw0NmEYmkyRHvTyproD3zOjKb6K3k04rlwQMDsB
        iXzLlvpta44E3sY69PEdeDdeVQ==
X-Google-Smtp-Source: ABdhPJzvxiEP1BIsH/0/FlV5HqWR2A36O3AMc+YXnVfCIGHxqTEWnhIfdPZu6pjEl6SovrpKWGcDfA==
X-Received: by 2002:a17:902:7007:: with SMTP id y7mr9085455plk.161.1590789046227;
        Fri, 29 May 2020 14:50:46 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id k92sm371970pjh.2.2020.05.29.14.50.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2020 14:50:45 -0700 (PDT)
Message-ID: <5ed183b5.1c69fb81.d8f25.60dc@mx.google.com>
Date:   Fri, 29 May 2020 14:50:45 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.7-rc7-109-g1a09809dda81
Subject: pm/testing baseline: 26 runs,
 1 regressions (v5.7-rc7-109-g1a09809dda81)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org
From:   "kernelci.org bot" <bot@kernelci.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 26 runs, 1 regressions (v5.7-rc7-109-g1a09809dda81)

Regressions Summary
-------------------

platform        | arch  | lab          | compiler | defconfig | results
----------------+-------+--------------+----------+-----------+--------
bcm2837-rpi-3-b | arm64 | lab-baylibre | gcc-8    | defconfig | 4/5    =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.7-rc7=
-109-g1a09809dda81/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v5.7-rc7-109-g1a09809dda81
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      1a09809dda810120fadcc35d96872d9fd5ceb00c =



Test Regressions
---------------- =



platform        | arch  | lab          | compiler | defconfig | results
----------------+-------+--------------+----------+-----------+--------
bcm2837-rpi-3-b | arm64 | lab-baylibre | gcc-8    | defconfig | 4/5    =


  Details:     https://kernelci.org/test/plan/id/5ed179be737c7dc5061dba71

  Results:     4 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.7-rc7-109-g1a098=
09dda81/arm64/defconfig/gcc-8/lab-baylibre/baseline-bcm2837-rpi-3-b.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.7-rc7-109-g1a098=
09dda81/arm64/defconfig/gcc-8/lab-baylibre/baseline-bcm2837-rpi-3-b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2019=
.02-11-g17e793fa4728/arm64/baseline/rootfs.cpio.gz =


  * baseline.dmesg.crit: https://kernelci.org/test/case/id/5ed179be737c7dc5=
061dba74
      new failure (last pass: v5.7-rc7-92-g065693d08662)
      1 lines =20
