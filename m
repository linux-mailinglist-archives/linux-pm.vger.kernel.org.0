Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD7713DF238
	for <lists+linux-pm@lfdr.de>; Tue,  3 Aug 2021 18:10:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232384AbhHCQKz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 3 Aug 2021 12:10:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232261AbhHCQKx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 3 Aug 2021 12:10:53 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 883A4C06175F
        for <linux-pm@vger.kernel.org>; Tue,  3 Aug 2021 09:10:42 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id g23-20020a17090a5797b02901765d605e14so5355331pji.5
        for <linux-pm@vger.kernel.org>; Tue, 03 Aug 2021 09:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=+2lzaldxagZ66VCul4a1GoQm695criSNo8+6BEZDDDU=;
        b=OH96pakzmlGPIGzOjjDEKH8FiA9ppInwr2qjhjCX2gdbE4tmUlDd+/c7ntCnbjKhV4
         S5GGFwRfCejkcFr2SNFLmfDoHAd3qjAo0ICw++E4qp/DJo2tCsWubvSQ21gWGRHLLVm7
         69f3ij9N8sNSJTNoLhvCfNvkvx8GwZ3e0p740WRY5/NGviSsBvDIl3o24lO3QszHfH+h
         wzP/r4hQD/A5jxynQcezxZpKqgd2RrDRE1zfHsa0j5XpIUV2KMvPFqolc3FsYSn69DYt
         buGSMmqQB7yC/9ieEhdWsdbrqHB/VHsjY6Fo1felfWZwlVlnYF6YE9TpUQwF5vyp+KRE
         vvOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=+2lzaldxagZ66VCul4a1GoQm695criSNo8+6BEZDDDU=;
        b=jYSTdUP6cIsQK832nskD4O9WLKLSscdjuyoPyzo1otZv2zprgnCDoqjyXbo9ipKpRx
         MSQi2aavHHkDvDO8o6bg8WXkUn1OfHGFLfUme+KE4B7B4/HSDGCUi5fXrrRSuWnzg6Al
         k/vzdfwBRQi0wmMzfPKwZdsrp9wnhZjy9olaeqRKrinuwWEtz1k3JS72II7ZBZSztql5
         25s1tZuOv6/JPXhHRMZ8xJCPACcQPsQg871Ts2TP05SWmnMkYvAlmcOj2uRt1SGbgACD
         ER+mT7fmkAjs2ww2gdZED7Oz8NOqMO5ESj7UQAyyocTSfRpc0uEfTwgb9kUydw7ST2tV
         C8yw==
X-Gm-Message-State: AOAM530RDOtd9PxbE5oQJ3n7M/ICdDzNJhDEFAEE4Y8UVEw/RVMLEOkq
        LOw/bArKspBuczK9WnT+17M5gQ==
X-Google-Smtp-Source: ABdhPJzZxddOlMKvyNuDgSz+8ux+B9ALkzCM69sk1EOaTnDQWqHgz5JbrVjZzhqOd772fSv8PmkJqg==
X-Received: by 2002:a05:6a00:1904:b029:3b9:e4ea:1f22 with SMTP id y4-20020a056a001904b02903b9e4ea1f22mr13988387pfi.79.1628007042044;
        Tue, 03 Aug 2021 09:10:42 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id ge21sm3173713pjb.55.2021.08.03.09.10.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 09:10:41 -0700 (PDT)
Message-ID: <61096a81.1c69fb81.7db55.954e@mx.google.com>
Date:   Tue, 03 Aug 2021 09:10:41 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v5.14-rc4-14-g392ac3ea48ca
X-Kernelci-Report-Type: build
Subject: pm/testing build: 7 builds: 0 failed,
 7 passed (v5.14-rc4-14-g392ac3ea48ca)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 7 builds: 0 failed, 7 passed (v5.14-rc4-14-g392ac3ea48ca)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
14-rc4-14-g392ac3ea48ca/

Tree: pm
Branch: testing
Git Describe: v5.14-rc4-14-g392ac3ea48ca
Git Commit: 392ac3ea48ca393968b11b98ea9e026203b1bcee
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
Built: 7 unique architectures

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D

Detailed per-defconfig build reports:

---------------------------------------------------------------------------=
-----
32r2el_defconfig (mips, gcc-8) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sect=
ion mismatches

---------------------------------------------------------------------------=
-----
defconfig (riscv, gcc-8) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section mi=
smatches

---------------------------------------------------------------------------=
-----
defconfig (arm64, gcc-8) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section mi=
smatches

---------------------------------------------------------------------------=
-----
haps_hs_smp_defconfig (arc, gcc-8) =E2=80=94 PASS, 0 errors, 0 warnings, 0 =
section mismatches

---------------------------------------------------------------------------=
-----
i386_defconfig (i386, gcc-8) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sectio=
n mismatches

---------------------------------------------------------------------------=
-----
multi_v7_defconfig (arm, gcc-8) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sec=
tion mismatches

---------------------------------------------------------------------------=
-----
x86_64_defconfig (x86_64, gcc-8) =E2=80=94 PASS, 0 errors, 0 warnings, 0 se=
ction mismatches

---
For more info write to <info@kernelci.org>
