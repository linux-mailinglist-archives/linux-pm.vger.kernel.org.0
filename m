Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9EB17D67B2
	for <lists+linux-pm@lfdr.de>; Wed, 25 Oct 2023 11:58:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232985AbjJYJ6p (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 25 Oct 2023 05:58:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232584AbjJYJ6o (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 25 Oct 2023 05:58:44 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DCFB9C
        for <linux-pm@vger.kernel.org>; Wed, 25 Oct 2023 02:58:43 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1ca6809fb8aso39421445ad.1
        for <linux-pm@vger.kernel.org>; Wed, 25 Oct 2023 02:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1698227923; x=1698832723; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=aRyfqwVe4epC4ninZBr4B9QSxVHuHLaPNDy5xwVEjfA=;
        b=YNiIJFqRKhQlSbySOrZbGrFX52dGVhhlCozKMITE4mfP92ZIJyerazuwAo8dnS5UsA
         90oio8xkYmmeksE8AI/KIpR4xKUWav6CGqSHZQS6oEtLwCuKjN+hMaGp6mbuZRm/jbvI
         cwOgcPXLFUEbANtJRr0eq/nZLWci6J32Ch3JM2PpzYN2aEhU16t6U2INh5bTnm8SW8MF
         WtX0rlqiUZCftFPY7sics2RuZ73BlEttVaBn+XZg/sbT2gi0rxplg606pTXFGZ10ZvDE
         sBZCrHp/emqplR8O6zxATjSmvtbBXUpKvU/fiaWsN9Fv4u7p+GpWxpMxchsMf9CZJUQZ
         wIVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698227923; x=1698832723;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aRyfqwVe4epC4ninZBr4B9QSxVHuHLaPNDy5xwVEjfA=;
        b=MfzF8neACDdjlO4um4/aQCHbU05jkVbFamXnmSHI8JG6bKX2jh3V0M8QczBGL9S1Ku
         elAaVeG4+xkzQOQtQ+hUGeo94L2t6AXM69YeIOXp6qm3eFRjO0ubyQNtO9gFDHMtlnKF
         UpMSM+5OBdpelm174Joc66WioC1VsQNYjA07L8ezTzuF/dpYWsJQDbPLaijJ05W/+gmL
         4HJz8F826ILuucwpraxMfXfSYFy6LvEjJy2Wd6KDybP4dpD3LdmDX5969dQp6/S5r47Q
         AIiBVXEmG7irZzPI6/lpFrfw6TjTfpI1fUECmJBG0g+eRmlo26JRF1TbYoUdEqsZoG5E
         dJ0Q==
X-Gm-Message-State: AOJu0YxLA9h+zcJaR9mjfbdrK9fczQnyjJXIsXJIE986JttSNHshCHjk
        nheEzqn/exrpLq5RoNJXLZp02g==
X-Google-Smtp-Source: AGHT+IFgwT+DIbRaW7h4tJrDM7OF1h02sBkSa/yVOAr+EDDL+Zq2GbUeIJfHoPbysS4bcS+M/zAlWQ==
X-Received: by 2002:a17:903:110e:b0:1c4:72c9:64fc with SMTP id n14-20020a170903110e00b001c472c964fcmr13776668plh.22.1698227922837;
        Wed, 25 Oct 2023 02:58:42 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id ix4-20020a170902f80400b001c74718f2f3sm8868032plb.119.2023.10.25.02.58.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 02:58:42 -0700 (PDT)
Message-ID: <6538e6d2.170a0220.af259.d369@mx.google.com>
Date:   Wed, 25 Oct 2023 02:58:42 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.6-rc7-168-g29c6df37ad20
X-Kernelci-Report-Type: test
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
Subject: pm/testing baseline: 48 runs,
 1 regressions (v6.6-rc7-168-g29c6df37ad20)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 48 runs, 1 regressions (v6.6-rc7-168-g29c6df37ad20)

Regressions Summary
-------------------

platform           | arch  | lab         | compiler | defconfig | regressio=
ns
-------------------+-------+-------------+----------+-----------+----------=
--
kontron-pitx-imx8m | arm64 | lab-kontron | gcc-10   | defconfig | 1        =
  =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v6.6-rc7=
-168-g29c6df37ad20/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v6.6-rc7-168-g29c6df37ad20
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      29c6df37ad201908c1985e8e7f1dc59457348246 =



Test Regressions
---------------- =



platform           | arch  | lab         | compiler | defconfig | regressio=
ns
-------------------+-------+-------------+----------+-----------+----------=
--
kontron-pitx-imx8m | arm64 | lab-kontron | gcc-10   | defconfig | 1        =
  =


  Details:     https://kernelci.org/test/plan/id/6538dd94508ed6c9b3efcef6

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10
  Plain log:   https://storage.kernelci.org//pm/testing/v6.6-rc7-168-g29c6d=
f37ad20/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-pitx-imx8m.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.6-rc7-168-g29c6d=
f37ad20/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-pitx-imx8m.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6538dd94508ed6c9b3efc=
ef7
        new failure (last pass: v6.6-rc6-164-ga1b138ca64c6) =

 =20
