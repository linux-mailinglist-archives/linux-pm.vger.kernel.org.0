Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4E4F3B76EB
	for <lists+linux-pm@lfdr.de>; Tue, 29 Jun 2021 19:09:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232638AbhF2RLw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 29 Jun 2021 13:11:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232398AbhF2RLv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 29 Jun 2021 13:11:51 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB62AC061760
        for <linux-pm@vger.kernel.org>; Tue, 29 Jun 2021 10:09:23 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id i4so11260708plt.12
        for <linux-pm@vger.kernel.org>; Tue, 29 Jun 2021 10:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=Kkuwpc8c1s2M1NVOMSd1Dnp43wkDDwWSz+fbMfsP6dA=;
        b=Q7QjQnVRiEDitKQmLTd0UjdfFCWdFNyt1BmZv0ZVZW7LMwG3LaGWsYmWkM4szloC/+
         GxMVqomgH7zb+S3GyZaFU86j58fsY7R83LFZpbiLynY4oLfpsHwiiNn9AYw4aV4sqXQ/
         cwOcb55L3WkOHGyLG3RlAqXcyPuaWd6batfsCEhiJ5yut6U1PZc892tG8cVkIyQXScry
         ALEewSVGd4wc0VNKmhc9szm2EmzCnzqBtjkqdPU9JiA84E2xo5CjEim3J3iA1VqPCalK
         rGUq6jBRw6D/Ouu8xPrmcvQmDamUqtLgFnxrlJdV3PzoGwoNw/Ha4NQ2zFk8BElWkSrF
         BiRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=Kkuwpc8c1s2M1NVOMSd1Dnp43wkDDwWSz+fbMfsP6dA=;
        b=FoOfB+YnOQoXEj1OvnmVtMjb6U+4PgUoPohz4BJKKUrsb1JMoG6bUG6WXQ3whZqDqJ
         5b0Qtdf20Z1SPIwTb4OtHPpXgSWSuFKFhXfQgLE12siQ7n0tQY3Uvx4iw8N/vWojfOur
         4Au1WOfuldv8SSpNyDOExCjyLnGfxBuszy4KFbYGok5dFItAY18chLgqJmm+dnmZZm3n
         x6H+oaTLIvhNw8w7NjqTU+vwWwEw79BEOgdp8VMmdMZjFwRpvUykTMXn9fFOq5DyVE5A
         l0skgr+MBl6GntCkk5aDUkbUZkfOfU2NzcpVHb+W5iZLOUU53sIe1d6X5c6LB5htpAse
         Uq2Q==
X-Gm-Message-State: AOAM530r7pq9NlrUyhvgp0Kisjg1KBk0w57thaRIvLeG8KXEUEnYthV0
        T27dYwLVQj9TtMaTqpvTmfvm1h5iudVsDdlN
X-Google-Smtp-Source: ABdhPJxHyG2RymXuraRXJRTKad/bdeZT/WjFduBIGdCMCOmqqHkP3vOut/sM6DtdMI4C6ptUUGC+Pw==
X-Received: by 2002:a17:90a:9205:: with SMTP id m5mr40003952pjo.172.1624986563407;
        Tue, 29 Jun 2021 10:09:23 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id d16sm3713289pjs.33.2021.06.29.10.09.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jun 2021 10:09:23 -0700 (PDT)
Message-ID: <60db53c3.1c69fb81.83ddb.b784@mx.google.com>
Date:   Tue, 29 Jun 2021 10:09:23 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: devprop-5.13-rc8-173-ge132b9a1079c
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
Subject: pm/testing build: 7 builds: 0 failed,
 7 passed (devprop-5.13-rc8-173-ge132b9a1079c)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 7 builds: 0 failed, 7 passed (devprop-5.13-rc8-173-ge132b=
9a1079c)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/dev=
prop-5.13-rc8-173-ge132b9a1079c/

Tree: pm
Branch: testing
Git Describe: devprop-5.13-rc8-173-ge132b9a1079c
Git Commit: e132b9a1079c9a25ae896d443b0eca1b272b5f5b
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
