Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C787A785B99
	for <lists+linux-pm@lfdr.de>; Wed, 23 Aug 2023 17:11:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231163AbjHWPLk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 23 Aug 2023 11:11:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235160AbjHWPLj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 23 Aug 2023 11:11:39 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F1BD10D
        for <linux-pm@vger.kernel.org>; Wed, 23 Aug 2023 08:11:35 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-68a3daf4cf7so2622959b3a.3
        for <linux-pm@vger.kernel.org>; Wed, 23 Aug 2023 08:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1692803495; x=1693408295;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=UWdNKpqWbXnmL/3cFcZHTXLeF1gjyYhF9O0rRcXs67Y=;
        b=M6vd1B564pHM2CEwIJ87eKT3d5MklAJ1zKGH3OjyP6zRhciKd34lU/n8IdK29IJNGK
         s7Z+Lve5frRjSYFj3BYQEGwI8DWYhEQkM08vxx6eBNp9nygzTY+lfYilT6Zdm+XlM7ye
         eZke9CyveQK/m6wjkTl+Jy/jJ3oo+/EKa9WdCvWUO7l5mOk1J2S8Zhusq4A90JbsdkCP
         XgZ5UR5nBWytqeA4q74X+UBU/phhza3TUBdP6OaAv1BOtDHTDzL+GntgZB3Pz82ULzHz
         UI/XZHSjmo6zCQibNwGd5KNvlw+6fO5eFmO448+Wu95+cmsk0qoV1TNvYj2xig7bDzMg
         ObEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692803495; x=1693408295;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UWdNKpqWbXnmL/3cFcZHTXLeF1gjyYhF9O0rRcXs67Y=;
        b=L1qcGJ0wkdSUh/4g+Qyq+WuPsaQj/jXiSK+DPCupy4ErgZzuxuSUGwNyzSTXgTOG5N
         DAZhgPn113P8oTU4d9PtOoUsXKGM17p2Wc7Rrjs4QqFUTvATFTcwcA2zuwvxq+D51pxr
         FDwxLKNL6XG9PivUbzhsCL8ZDS1p0Vs4bVeQqe8hvSh7AHzcTKXiOr94iqCTxtf7qsex
         QFpJWQm6jGTXRzIF1fkGvidzwNgMRb8T5KIGotPg/WxxIBq9/s64A7tYKpRc0zDpEV+I
         YocGJ5qnpB32hJNP8/0sNlHNN4ytu92C66WY6qx5E9tIMsAv6OYC8c4xMaRRNUKVC1GI
         aZFQ==
X-Gm-Message-State: AOJu0Yw2118WhjWbN/OV8ffOT7C1QAyPm8bGWHh/yb2O4As3ntCZ4a8C
        WggeTkkbCfgBnzgXTN0SFkdic7osqaj1VP7MQLU=
X-Google-Smtp-Source: AGHT+IFDdr6jRX0ifDj+DgZhEl32TnDzAMLJfFxNAO4R9d7drRb7MRcSZ/g7JFUfqN/u3drqutYe3A==
X-Received: by 2002:a05:6a00:2e95:b0:68b:eb60:c0a4 with SMTP id fd21-20020a056a002e9500b0068beb60c0a4mr69523pfb.6.1692803494956;
        Wed, 23 Aug 2023 08:11:34 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id ey14-20020a056a0038ce00b0068bc2c76393sm1627363pfb.21.2023.08.23.08.11.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 08:11:34 -0700 (PDT)
Message-ID: <64e621a6.050a0220.cc244.416e@mx.google.com>
Date:   Wed, 23 Aug 2023 08:11:34 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v6.5-rc7-135-ge76f1fef0ffe
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
Subject: pm/testing build: 7 builds: 0 failed, 7 passed,
 4 warnings (v6.5-rc7-135-ge76f1fef0ffe)
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

pm/testing build: 7 builds: 0 failed, 7 passed, 4 warnings (v6.5-rc7-135-ge=
76f1fef0ffe)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v6.=
5-rc7-135-ge76f1fef0ffe/

Tree: pm
Branch: testing
Git Describe: v6.5-rc7-135-ge76f1fef0ffe
Git Commit: e76f1fef0ffede1783d4d1f6f3248807e41b066d
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
Built: 7 unique architectures

Warnings Detected:

arc:

arm:

i386:

mips:

riscv:

sparc:
    sparc64_defconfig (gcc-10): 4 warnings

x86_64:


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
32r2el_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sec=
tion mismatches

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
sparc64_defconfig (sparc, gcc-10) =E2=80=94 PASS, 0 errors, 4 warnings, 0 s=
ection mismatches

Warnings:
    <stdin>:1519:2: warning: #warning syscall clone3 not implemented [-Wcpp]
    WARNING: modpost: EXPORT symbol "_mcount" [vmlinux] version generation =
failed, symbol will not be versioned.
    <stdin>:1519:2: warning: #warning syscall clone3 not implemented [-Wcpp]
    WARNING: modpost: EXPORT symbol "_mcount" [vmlinux] version generation =
failed, symbol will not be versioned.

---------------------------------------------------------------------------=
-----
x86_64_defconfig (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 s=
ection mismatches

---
For more info write to <info@kernelci.org>
