Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8165C705B06
	for <lists+linux-pm@lfdr.de>; Wed, 17 May 2023 01:12:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbjEPXMA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 16 May 2023 19:12:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230434AbjEPXL6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 16 May 2023 19:11:58 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A804D49DB
        for <linux-pm@vger.kernel.org>; Tue, 16 May 2023 16:11:57 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-6434e263962so40838b3a.2
        for <linux-pm@vger.kernel.org>; Tue, 16 May 2023 16:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1684278717; x=1686870717;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=MiUx4flpFMnBgutuWUJr5v/u3KwgJjqF2SWGzqqvges=;
        b=rqj3jHfpqghUZfr+TkTpDZc0zpvny0rd4kaN1kLWZhGmKnObtu5vx6r6Y7y/gV6eoa
         WhJ39HgyJpRy+ulTLSQxFcv6XEGwJcRH5QJButpv4xshRxvNmPy4yhslxTO5wTpQZJLs
         B5PmEBTIcDGQCBZfKw8Mn018Wrr0OhMxcAsF7Svz1khF62V0UejES9aDX5NlgYI99P3e
         EeD5gj7LG+55b1rGre1ZrOg+nfhsEqD9rKy5gRJUD4K982D7CozWHk8xOvFTbNfYQqeL
         8nBf4lu3sWSHnUCHXVS6I6lLP7/en0HXdktL/Nd9Gfqt9rII+U+mIFPSSCJgF8FqBkbY
         4N7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684278717; x=1686870717;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MiUx4flpFMnBgutuWUJr5v/u3KwgJjqF2SWGzqqvges=;
        b=eb6WFT5ppAIvEGaWn1c3hGKQ1rAjBjO2Xw2gQf6KIi65ysV07VPosTAXE1edF2VsoI
         0C6/ziFJqLwDXgj5aJFfKN++CNXQS/uSdLrwe5Y0aLbbR3xoMAfLD2/7Ih4OyRy3fL59
         599qObrFuda3ZNBD5Gu627Pp+x2Fp/KMHkykDOpK/82SvKa+W9VncoWJvbl8RbOgAamF
         h9sOkp/DmuLCS64pQ9ACD0I+VRr5EStSqZbc0RK1bddPX4LwGiXg5A+huKnPxfJWZGId
         OpvokyO66tuOhwGwQe9r5gjQx5Q/y87aBhfuB59Am55PdOw/0fKrBHFTDX+RjoYCZ/1x
         ECqQ==
X-Gm-Message-State: AC+VfDxxppHuuV/HtJy2WeahOiaDT44YIQSVW7/1xBh6lS2e3CHmnRPI
        6CVVK5mOAsuSvxGXGpNZXRPqMA==
X-Google-Smtp-Source: ACHHUZ4Ph/5F4+O/xLXsvmPVpMHWuB1EfmJTzFuQgo0a1p0OjsCxYGu3ThHuAHAd9Lnj+QhM59ufIg==
X-Received: by 2002:a05:6a00:22d3:b0:64a:a432:f313 with SMTP id f19-20020a056a0022d300b0064aa432f313mr23611029pfj.31.1684278717155;
        Tue, 16 May 2023 16:11:57 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id h5-20020a62b405000000b0062dd9a8c1b8sm13877423pfn.100.2023.05.16.16.11.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 16:11:56 -0700 (PDT)
Message-ID: <64640dbc.620a0220.456e2.b503@mx.google.com>
Date:   Tue, 16 May 2023 16:11:56 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v6.4-rc2-4-ga3c2d8b60e2f
X-Kernelci-Report-Type: test
Subject: pm/testing baseline: 52 runs, 2 regressions (v6.4-rc2-4-ga3c2d8b60e2f)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 52 runs, 2 regressions (v6.4-rc2-4-ga3c2d8b60e2f)

Regressions Summary
-------------------

platform          | arch  | lab           | compiler | defconfig | regressi=
ons
------------------+-------+---------------+----------+-----------+---------=
---
rk3399-rock-pi-4b | arm64 | lab-collabora | gcc-10   | defconfig | 2       =
   =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v6.4-rc2=
-4-ga3c2d8b60e2f/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v6.4-rc2-4-ga3c2d8b60e2f
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      a3c2d8b60e2f540d2be15247beb23d60872eafa1 =



Test Regressions
---------------- =



platform          | arch  | lab           | compiler | defconfig | regressi=
ons
------------------+-------+---------------+----------+-----------+---------=
---
rk3399-rock-pi-4b | arm64 | lab-collabora | gcc-10   | defconfig | 2       =
   =


  Details:     https://kernelci.org/test/plan/id/646403a3411bce5ec92e85f7

  Results:     3 PASS, 3 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.4-rc2-4-ga3c2d8b=
60e2f/arm64/defconfig/gcc-10/lab-collabora/baseline-rk3399-rock-pi-4b.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.4-rc2-4-ga3c2d8b=
60e2f/arm64/defconfig/gcc-10/lab-collabora/baseline-rk3399-rock-pi-4b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/arm64/rootfs.cpio.gz =



  * baseline.dmesg.emerg: https://kernelci.org/test/case/id/646403a3411bce5=
ec92e85fe
        failing since 1 day (last pass: v6.3-rc7-189-g704d7a52a540b, first =
fail: v6.4-rc2)
        2 lines

    2023-05-16T22:28:28.710043  kern  :emerg : Internal error: Oops: 000000=
0096000006 [#1] PREEMPT SMP

    2023-05-16T22:28:28.710581  kern  :emerg : Code: 97f9b910 f9405680 5286=
4a61 72a686c1 (b9400800) =


    2023-05-16T22:28:28.710931  <8>[   23.983915] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Demerg RESULT=3Dfail UNITS=3Dlines MEASUREMENT=3D2>

    2023-05-16T22:28:28.711261  + set +x

    2023-05-16T22:28:28.711577  <8>[   23.985947] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10343255_1.5.2.4.1>
   =


  * baseline.dmesg.alert: https://kernelci.org/test/case/id/646403a3411bce5=
ec92e85ff
        failing since 1 day (last pass: v6.3-rc7-189-g704d7a52a540b, first =
fail: v6.4-rc2)
        12 lines

    2023-05-16T22:28:28.685026  kern  :alert :   ISV =3D 0, ISS =3D 0x00000=
006

    2023-05-16T22:28:28.685590  kern  :alert :   CM =3D 0, WnR =3D 0

    2023-05-16T22:28:28.685939  kern  :alert : user pgtable: 4k pages, 48-b=
it VAs, pgdp=3D0000000079391000

    2023-05-16T22:28:28.686261  kern  :alert : [0000000000000008] pgd=3D080=
0000078d4d003, p4d=3D0800000078d4d003, pud=3D0800000078d4e003, pmd=3D000000=
0000000000

    2023-05-16T22:28:28.686572  <8>[   23.960278] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dalert RESULT=3Dfail UNITS=3Dlines MEASUREMENT=3D12>
   =

 =20
