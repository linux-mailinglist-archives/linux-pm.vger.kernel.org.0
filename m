Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79F6A4C845B
	for <lists+linux-pm@lfdr.de>; Tue,  1 Mar 2022 07:50:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232427AbiCAGvK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 1 Mar 2022 01:51:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232304AbiCAGvI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 1 Mar 2022 01:51:08 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85CC51C930
        for <linux-pm@vger.kernel.org>; Mon, 28 Feb 2022 22:50:28 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id a5so12490757pfv.9
        for <linux-pm@vger.kernel.org>; Mon, 28 Feb 2022 22:50:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=Sfl8928v05xWfKsk0IOIUH5EiECPGA71Q2IijjyXnxs=;
        b=SOTgXjQtuwPGe5hbQq7Xb8N3eHJLwIkjOdYkvb98+Okel+HMG0Gn1vWBzPc456DWKj
         Pl3POPDT+Y7Z9/F8srPe325BK59mB7UHkf1bO40BuQF2GHDPglhwebgeO5UIbbo10rYV
         skTi33gw6p8m4EdO0jB0udT9itwVft+5S8FaO2Ls4RNFnogn8dP1veXh9+IwDh6p2NPz
         atBNCOf+svMNglj5GnSyT0bPh+ilY46A8xi8ccmewA/xIYUpfQaSFXek360MgwVyoZvj
         vNQrknv+levdzloR+ngLy98bHJbjz+jFKVVhFQ4k34tq+6GK8pr23mIRs//k53qblMkr
         vSLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=Sfl8928v05xWfKsk0IOIUH5EiECPGA71Q2IijjyXnxs=;
        b=NRPo4WP1oenc5GGfa4nVbUboCIJo98WZrJEQjIzeXCwlA4bGt+DXylHtjjBzLSJr2o
         3PlQP5iTWnxTuNfGkais9PM1lWpiKTFgVnj5xmestcX85yGClqzkkYLIkJ7CICE1xQRv
         CwZkhGjdQobo+3FdjBXCGXIajASn7FrgZt/DH+x6yK8XWESQjA6Uijhnt2LoigpH56Hq
         eONaTGJn+RxoXE9lEvmrXJWw45Yz9RjsAl+nPmyc55QZFRaMh1HKizv0qnGpOvhEnUQY
         HAXbfmV4krxvIe8Muo+J6AWomOPlSAwABNKL7plBYSwedD+4s70msPcXGYjSuIlPEWsl
         k/2A==
X-Gm-Message-State: AOAM532X4BFQNtxHab4WinKAmClsqJ8H+AA+6ltRYevkORhlit1iI4UO
        etHgSZamqXUP0MQQ9XSI0WnlHdoOEMBzJ7AtaAk=
X-Google-Smtp-Source: ABdhPJwp4PIztMOt4Jt/WkkNjltEG5KWCHBanHopotnCgfI6JxByCV4SGjCqFW7tqYQm5QtoOmQbdQ==
X-Received: by 2002:a63:4814:0:b0:36d:87fb:f1ed with SMTP id v20-20020a634814000000b0036d87fbf1edmr20502476pga.594.1646117428062;
        Mon, 28 Feb 2022 22:50:28 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id b21-20020a056a000cd500b004e1e0d3ed18sm16038304pfv.2.2022.02.28.22.50.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 22:50:27 -0800 (PST)
Message-ID: <621dc233.1c69fb81.773a.962c@mx.google.com>
Date:   Mon, 28 Feb 2022 22:50:27 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
X-Kernelci-Kernel: v5.17-rc6-78-gac62facbd440
Subject: pm/testing build: 4 builds: 0 failed,
 4 passed (v5.17-rc6-78-gac62facbd440)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 4 builds: 0 failed, 4 passed (v5.17-rc6-78-gac62facbd440)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
17-rc6-78-gac62facbd440/

Tree: pm
Branch: testing
Git Describe: v5.17-rc6-78-gac62facbd440
Git Commit: ac62facbd440da5ba31f5b4b137c234815b6c2d2
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
Built: 4 unique architectures

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D

Detailed per-defconfig build reports:

---------------------------------------------------------------------------=
-----
defconfig (riscv, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section m=
ismatches

---------------------------------------------------------------------------=
-----
haps_hs_smp_defconfig (arc, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0=
 section mismatches

---------------------------------------------------------------------------=
-----
i386_defconfig (i386, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 secti=
on mismatches

---------------------------------------------------------------------------=
-----
multi_v7_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 se=
ction mismatches

---
For more info write to <info@kernelci.org>
