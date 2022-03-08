Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB1274D0D0D
	for <lists+linux-pm@lfdr.de>; Tue,  8 Mar 2022 01:53:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244357AbiCHAyt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 7 Mar 2022 19:54:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237712AbiCHAyt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 7 Mar 2022 19:54:49 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3CA61155
        for <linux-pm@vger.kernel.org>; Mon,  7 Mar 2022 16:53:53 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id d17so7088600pfv.6
        for <linux-pm@vger.kernel.org>; Mon, 07 Mar 2022 16:53:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=WPNdv8S5fPwJfPBVpZy9CupWTv5Y0N8baPhuHLWLzL0=;
        b=62mnrfZIu9pJKDYHCI52QRk/qsDMb28w5YLRiz3QarYMakSaD2CJ0T6FPtdE0VJMHn
         iV5+/bt5Haq32js37VhlbijLwnLpXObkANNalS7zaDq1F6MAcY8Pj1I5DdLENmeyTp4O
         2BFX7MZby2MLtj3KlwkmVDkcV1KdgVrwdJXLFF6D5yGib1spRZuxxSIeEeCEWYRv9Gfn
         HD4Nf8Vd9Bs+RKbTMK4QDiuE7fp+fW11rO0YASzh6WkT3sWhfykwe31BaMBJn1WdEV0Y
         oHNmzuqNXtR4Nnwuvq1FSVApzCg9S1DREKuwizsMKL2mPz6CG3UQlVN1BHUAv1G2hpj3
         UKRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=WPNdv8S5fPwJfPBVpZy9CupWTv5Y0N8baPhuHLWLzL0=;
        b=hMEY/Bxld6pLdLSXi5+XhoJ3WZzrLbPLHvXd8GcIjLT09CKdPfQ3ph4uORHWIftcln
         jC4ZWk62fYrl6q/+Tsxf02P8ooY/RMM5cs/ILPq8H5Hgi2FHu+IsNd7S3ZGVp7KWtmpz
         HsQX+DgH9Qo2YW2Zwlb0NHp9iCS+JF0mkSk95DKgly6oVu3Q8CK1Au56auLv0xultYdY
         0pGa3fj9HGptYl6bI+kj9v8SaqZVWnug/JD6caqu0Iw5mCzwKUfaAPMJ5jCHdbM1ERGn
         8G2MVnQT1fD8E8rLuDvcVtWJOsJi/DjHeDotamSVrk3x3LQtE0xHf4uU4auwOax3WHTo
         yEbw==
X-Gm-Message-State: AOAM530B4fyI4gxyEf4iZzmL1FSjUE5ditri2Xdx/dXMU0DYAAIikws1
        JVNAxDtb0kfD6etEc/UgYAQUPw==
X-Google-Smtp-Source: ABdhPJzzVnGXOad7KV4YeJOB0hcJRCN0DMwoGF/6n7q5hcWRcW4NVAf9jMgVb6+QzM3QjKcXhqlebg==
X-Received: by 2002:a63:1c15:0:b0:372:ffcd:4d21 with SMTP id c21-20020a631c15000000b00372ffcd4d21mr11972671pgc.450.1646700833433;
        Mon, 07 Mar 2022 16:53:53 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id k4-20020a17090a910400b001bd171c7fd4sm525432pjo.25.2022.03.07.16.53.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 16:53:53 -0800 (PST)
Message-ID: <6226a921.1c69fb81.25e83.1ecb@mx.google.com>
Date:   Mon, 07 Mar 2022 16:53:53 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
X-Kernelci-Kernel: v5.17-rc7-126-g0b4cb964dac5
Subject: pm/testing build: 6 builds: 0 failed, 6 passed,
 1 warning (v5.17-rc7-126-g0b4cb964dac5)
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

pm/testing build: 6 builds: 0 failed, 6 passed, 1 warning (v5.17-rc7-126-g0=
b4cb964dac5)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
17-rc7-126-g0b4cb964dac5/

Tree: pm
Branch: testing
Git Describe: v5.17-rc7-126-g0b4cb964dac5
Git Commit: 0b4cb964dac51d55a3a3ed4db6536e8b4b31031a
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
Built: 6 unique architectures

Warnings Detected:

arc:

arm:

i386:

mips:
    32r2el_defconfig (gcc-10): 1 warning

riscv:

x86_64:


Warnings summary:

    1    arch/mips/boot/dts/img/boston.dts:128.19-178.5: Warning (pci_devic=
e_reg): /pci@14000000/pci2_root@0,0,0: PCI unit address format error, expec=
ted "0,0"

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D

Detailed per-defconfig build reports:

---------------------------------------------------------------------------=
-----
32r2el_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sect=
ion mismatches

Warnings:
    arch/mips/boot/dts/img/boston.dts:128.19-178.5: Warning (pci_device_reg=
): /pci@14000000/pci2_root@0,0,0: PCI unit address format error, expected "=
0,0"

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

---------------------------------------------------------------------------=
-----
x86_64_defconfig (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 s=
ection mismatches

---
For more info write to <info@kernelci.org>
