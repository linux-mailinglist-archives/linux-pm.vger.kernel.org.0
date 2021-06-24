Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4286D3B3442
	for <lists+linux-pm@lfdr.de>; Thu, 24 Jun 2021 19:00:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbhFXRCr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 24 Jun 2021 13:02:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbhFXRCp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 24 Jun 2021 13:02:45 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F3A8C061574
        for <linux-pm@vger.kernel.org>; Thu, 24 Jun 2021 10:00:25 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id c15so3260559pls.13
        for <linux-pm@vger.kernel.org>; Thu, 24 Jun 2021 10:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=/y1fay4uLLn0vbRutVxnngDZ4C4oYBKVEDc/l3qP3RI=;
        b=BeM7A7NjsqfZUL8NgbY/qncUhn5RnmLXnaf9viunQ9L1wx0GyX40VIcUMQRvWDduK6
         kAsjSecXlOkixnyRrz2MOTbsY64I60IFK4NdNAvJ3dW8W8qZxr34X1XsFtbBeBmioMeu
         s1QRw8/DDWfSTUc+8pTh7cVrwk9YMbgdSA3olNzpimukpq/XLwSQNhMwBuzv3JZhCQg1
         QUZ04kLp87jmUnhEjD4i2J8wKhs+EbiKeVYZR2gBcw9q8YfI+hQ4O9I/TM5gFgeBzBlD
         6JpqxXi+okQf6M2ftL4cnvH/QFaFu08uztSEvlk0dG/50mQVaUggm8nYJ7nTYm+loCCk
         mYBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=/y1fay4uLLn0vbRutVxnngDZ4C4oYBKVEDc/l3qP3RI=;
        b=B3kLqgde48QakvwyncLGr8wJhg8//1fBPl76lewgg/5mpsBdKvvwMWJUb4gGpciY7v
         lGHqduzbZTgbbr9XNmEejU9A7+K7Sg7G+Lsu9YqgFbP5WVvEtFvF61/IWs+rW5qr/qko
         bWmfQ+s8RkdofNKRdiQXPqJIbOWnz+/huIlhagRNNL9wagJCRcfzS7rYukddSR9qJqZJ
         UzjZKP/+7bNWJqHMASVar84dOfQtmH5qVgAIhYmMoJKhRXJfNmd9Y4zBPLKLPtbljGq4
         dtWxvUAKpF9Id7kusHCMev49poludnJiCcgRgMKt0crBeK+eGvjIN2d8iUzgFjF+ACD4
         gbMA==
X-Gm-Message-State: AOAM530tWdEOt8DOg3lVQo/DagfX2MiFKusXloi8ln/wKHQTvHW+VkHU
        B7w812oe8Tuezwxotd2hqtSLqQ==
X-Google-Smtp-Source: ABdhPJw7Nbm4pk5ERM3Zqpy7XR0uI8JiTrIJDqQ9KyiWX2RSw9YPChTXbg1Pg98e9CBjL2iiho0HAg==
X-Received: by 2002:a17:90a:d58f:: with SMTP id v15mr8442516pju.117.1624554025067;
        Thu, 24 Jun 2021 10:00:25 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id bp2sm3098468pjb.20.2021.06.24.10.00.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 10:00:24 -0700 (PDT)
Message-ID: <60d4ba28.1c69fb81.1ce10.8470@mx.google.com>
Date:   Thu, 24 Jun 2021 10:00:24 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: pm-5.13-rc8-159-g3304616e985f
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
Subject: pm/testing build: 7 builds: 0 failed,
 7 passed (pm-5.13-rc8-159-g3304616e985f)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 7 builds: 0 failed, 7 passed (pm-5.13-rc8-159-g3304616e98=
5f)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/pm-=
5.13-rc8-159-g3304616e985f/

Tree: pm
Branch: testing
Git Describe: pm-5.13-rc8-159-g3304616e985f
Git Commit: 3304616e985fa1c05e1a111375480fc88d71a574
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
