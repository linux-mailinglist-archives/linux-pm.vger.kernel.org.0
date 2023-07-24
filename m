Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5986975F478
	for <lists+linux-pm@lfdr.de>; Mon, 24 Jul 2023 13:07:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbjGXLHz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 24 Jul 2023 07:07:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231137AbjGXLHw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 24 Jul 2023 07:07:52 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDC7490
        for <linux-pm@vger.kernel.org>; Mon, 24 Jul 2023 04:07:30 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-6686ef86110so2245290b3a.2
        for <linux-pm@vger.kernel.org>; Mon, 24 Jul 2023 04:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1690196799; x=1690801599;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=o4CH15cyUZMW+X17A/a2L9cuu76ECP2y9lzr5R39Z6k=;
        b=O6upBsRHEf1GoTFmxplw8r0cHW4uDqF2/tvmhCVF2iJBOADQO0QiXDb8sqjoHX3t6i
         aV1+hutk1bhnFZreRDb+pjbf9pRB4bWWhKxmFaXS1PTshosTN0Epdn4/BwHxHr8/9/J3
         Ut/JXqpn8vpHiL51kO3yShhQ6zQo5Wjvwel+j4GXZhf2PG62KKRhAqRvMI2AnnKWiukF
         SZxjj2MnZMDlxTLOrgnhLHvzm8/A57NhZo6mq8FxXHmWeJVPatAQgWY0OZ+ujs+yY2r3
         EqQQ6kfGq4KdRY4L6sHRQZquCuDPy4iWnE7FKQ+BCuuU+rQ2lTmxjOiH69jEZ3A2OoTJ
         vxQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690196799; x=1690801599;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o4CH15cyUZMW+X17A/a2L9cuu76ECP2y9lzr5R39Z6k=;
        b=RwjyWiJzzWmgSXc9IFmhEtIds0lfmAK6gj6SaN0sNoKVFD6R37X39Q9eH8bll3VMtb
         P2KZWI5uurpYSXSPQRMysehguCXqEuNY9vZuH/30BnC2fYzlcbDVuZzFuRnQbyLY9HRo
         AG8wp8XrRd37FAyWEprgxGlKyDpReeWRHxYgIHzi5wm+w4dmh3FBvM1o5O1nugeicpa4
         JFi9C+xubeTp80Q//NQi2d5hBNV7fjrSYURm5S0X7G708w6kpBbl3G5QNaTWh3unaoCy
         iF6OPw/HQFsK/qlqO4SqBZ6t/RaO8cxd8gRpi0CFIu4DwIR+yNnnKy/cNVuYjMK7x3h5
         3lEQ==
X-Gm-Message-State: ABy/qLZ81tmVh0SUT2Tzyo6tmPDK2yUPuC1tCuEq8SEuCTm2U3bRo2iV
        LcX30+0bFuwOQ3H9YWcrV5s04A==
X-Google-Smtp-Source: APBJJlHv7xwe1C6wQIIkHwWaQo3tfvI9I5js8lL616SMV6hBPehrU1LdRGWhBe1vmPcUdrARAA/9ZQ==
X-Received: by 2002:a05:6a20:499:b0:135:6d5b:82a6 with SMTP id 25-20020a056a20049900b001356d5b82a6mr5569790pzc.62.1690196799255;
        Mon, 24 Jul 2023 04:06:39 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id h1-20020a170902f7c100b001b8b45b177esm3573155plw.274.2023.07.24.04.06.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 04:06:38 -0700 (PDT)
Message-ID: <64be5b3e.170a0220.a516b.581a@mx.google.com>
Date:   Mon, 24 Jul 2023 04:06:38 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
X-Kernelci-Kernel: v6.5-rc3-51-gcbda924b739da
X-Kernelci-Report-Type: build
Subject: pm/testing build: 1 build: 0 failed, 1 passed,
 4 warnings (v6.5-rc3-51-gcbda924b739da)
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

pm/testing build: 1 build: 0 failed, 1 passed, 4 warnings (v6.5-rc3-51-gcbd=
a924b739da)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v6.=
5-rc3-51-gcbda924b739da/

Tree: pm
Branch: testing
Git Describe: v6.5-rc3-51-gcbda924b739da
Git Commit: cbda924b739da26f43629bffb62e7a713fb2e060
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
Built: 1 unique architecture

Warnings Detected:

sparc:
    sparc64_defconfig (gcc-10): 4 warnings


Warnings summary:

    2    WARNING: modpost: EXPORT symbol "_mcount" [vmlinux] version genera=
tion failed, symbol will not be versioned.
    2    <stdin>:1519:2: warning: #warning syscall clone3 not implemented [=
-Wcpp]

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D

Detailed per-defconfig build reports:

---------------------------------------------------------------------------=
-----
sparc64_defconfig (sparc, gcc-10) =E2=80=94 PASS, 0 errors, 4 warnings, 0 s=
ection mismatches

Warnings:
    <stdin>:1519:2: warning: #warning syscall clone3 not implemented [-Wcpp]
    WARNING: modpost: EXPORT symbol "_mcount" [vmlinux] version generation =
failed, symbol will not be versioned.
    <stdin>:1519:2: warning: #warning syscall clone3 not implemented [-Wcpp]
    WARNING: modpost: EXPORT symbol "_mcount" [vmlinux] version generation =
failed, symbol will not be versioned.

---
For more info write to <info@kernelci.org>
