Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C51037AA302
	for <lists+linux-pm@lfdr.de>; Thu, 21 Sep 2023 23:45:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232161AbjIUVp6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 21 Sep 2023 17:45:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231717AbjIUVpj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 21 Sep 2023 17:45:39 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9E258A64
        for <linux-pm@vger.kernel.org>; Thu, 21 Sep 2023 14:27:00 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-690d2441b95so1091079b3a.1
        for <linux-pm@vger.kernel.org>; Thu, 21 Sep 2023 14:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1695331620; x=1695936420; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=PWFT1Rjfog1YLOcYzu6UZ0PRxfnlSYROTbim2Vy/sfU=;
        b=ck4rjRB22WLq2/vBvWAS4M4uURO2hxzon6UYPvZ31IMdSLUdiHUEiJmbogQCqJtZfL
         6q+YKDNM4HnQUCKTOWwB5VWkWVEDCDtt8qdeMqIWNJ/v8JuT4+9EbuZxC5tAkJadYcR4
         HDAeJMw79b7XPYukAbdeJiVUshQTUXQmCosgiP3OIe5PUBnHSRjh3eMJbyNcJegAcwYZ
         piaBryWdhiFLwcrUusznVU4uKTurP8IszhwXVk3BigLOHpEw6blsUPDRmqaIk+XbGudZ
         vaLCgwXPtEfV6i1PyAkGTOjcx6umOnAmtVEceSaC40Q+pduQcBnQsiK20xH1pBOv5VPV
         bQlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695331620; x=1695936420;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PWFT1Rjfog1YLOcYzu6UZ0PRxfnlSYROTbim2Vy/sfU=;
        b=BKfwIVuxMg4DdGJjrqiVq/RJEuKhdrNr6ycAkgftzz6twTPfROq+Y9j3fbZAnO7O6/
         nxGB7Wcc/A7azpLmX7955U6GbkBdXzqdAtFtflnhM+noccT44ZlKMb7RiEjp46AbRGQU
         wwDma5Yg9EPfyNFNUuKyVPzcj9rq8PV5YXEetx2SeKDbNiwTe94DTTGXVB6is/rdhVia
         JbiP4LOSp1ETYj93fsa9KUZ1Wds4ye+Pum5qvbJl9NXEj+iv4djhMzWQHUn0CWtC6ESc
         +IaYKMX8+/I9lhdvx9VBL1ulfxa2ktWrOcqWEIukHRHxJ431u85hcrn17gsxZGwNPu+c
         1Eow==
X-Gm-Message-State: AOJu0YwSJclToKDfRWAqcod4W3D2xjeKmSdZDnEIUhW0wWAILoo1rQt2
        SuoOxj9NyP8XZQGsJu4GrjtVGoMOlTyiQ4GRbqydhQ==
X-Google-Smtp-Source: AGHT+IGHl+k0BZvTc61Uxv8LowxVdMvaIYGNFLdlKVFONwLHo7OygstbDX6rrkEEmCdy1DVN22bu3Q==
X-Received: by 2002:a05:6a00:d73:b0:68f:cc67:e709 with SMTP id n51-20020a056a000d7300b0068fcc67e709mr1059165pfv.16.1695331620112;
        Thu, 21 Sep 2023 14:27:00 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id h1-20020a62b401000000b0068fde95aa93sm1831977pfn.135.2023.09.21.14.26.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 14:26:59 -0700 (PDT)
Message-ID: <650cb523.620a0220.95565.8ea6@mx.google.com>
Date:   Thu, 21 Sep 2023 14:26:59 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v6.6-rc2-36-g57594c77e5b2
X-Kernelci-Report-Type: build
Subject: pm/testing build: 8 builds: 0 failed, 8 passed,
 4 warnings (v6.6-rc2-36-g57594c77e5b2)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 8 builds: 0 failed, 8 passed, 4 warnings (v6.6-rc2-36-g57=
594c77e5b2)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v6.=
6-rc2-36-g57594c77e5b2/

Tree: pm
Branch: testing
Git Describe: v6.6-rc2-36-g57594c77e5b2
Git Commit: 57594c77e5b24fac60e3171dd6fe1199c18323fd
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
Built: 8 unique architectures

Warnings Detected:

arc:

arm64:

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
defconfig (arm64, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section m=
ismatches

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
