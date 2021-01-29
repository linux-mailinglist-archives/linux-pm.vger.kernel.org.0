Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A63BC308E26
	for <lists+linux-pm@lfdr.de>; Fri, 29 Jan 2021 21:17:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232816AbhA2UI6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 29 Jan 2021 15:08:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232781AbhA2UG5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 29 Jan 2021 15:06:57 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49C77C0613D6
        for <linux-pm@vger.kernel.org>; Fri, 29 Jan 2021 12:06:17 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id j2so5747562pgl.0
        for <linux-pm@vger.kernel.org>; Fri, 29 Jan 2021 12:06:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=nGuUZMw55hxcG7Ma6KBmO7zSQWoS8fU4Ah14wBhwRlo=;
        b=f6NVuhQQ+QU1+9KRJwx+uOq/YrRklzEX/l5Zpbzm51dPOWsUnUS3exuvYdcdkTOlhU
         0ZYg5pSK97Gwcg11/sWmberMOAerGXANMN9LCtkH7CfCoTnB6EbttFV1ymG3SQPbofae
         Adfn+AU0gVTR116BqU2ZzDSuogmdHgE3drJNChiLbBpEzmJZMfaI+Q45fH/s9Pg3Js4Z
         GUvciCxX8QPbNYuHo8dWK4he/kphSnT7mTpX14Ua/JUUXqMWb5kX+xqi6akZY6wPW6Wa
         lpBi57Vu7Arc9wj+fa0fAjixYtAo8Yo8J+0BBLzW7jEebUA7t8mxv9Z7fvDvulAiCnBM
         0Z8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=nGuUZMw55hxcG7Ma6KBmO7zSQWoS8fU4Ah14wBhwRlo=;
        b=TJ3ftAxCOELMlEyn3U4PJTecQEp3W7oSR1TokXNDafNJwJl1uZ3y6GRbg1sQyNVbJf
         jfe59H6Fu8XOhSfEOt9FrTrAW1maO3KwYLd+eq3ovUdcjuQP4/xWD5qeVRhwzwWHWuMx
         mrx8tvsfBmjrsjRA/Sxt0q3kGB4jbSUlmNyMozGJ4hDrnlbjsjwjPiGdK85O+GZ64mhG
         hnRmPoq/Si2ZQaxDPuqINU02TxBJyhBOOFx84qKUUiLlAReu8RvOmB0xhAjajLeLU9d0
         ZBmJfFAyKjnl/2xFFSpvSLnA49gFnd4AYZ77+4jV2KQCFfGCYNpx1LeCKY92Fvju1kv1
         wLGA==
X-Gm-Message-State: AOAM533cXIRTutmB9lCsQAhtIfHe4HbWfKZWC8Ps69H/3m2j2q1Q28SJ
        FN4L41ODAJG6OZ4n6h6FcEGFvA==
X-Google-Smtp-Source: ABdhPJxcFmLyUCSKHAsjemzggjGNDOkvSp88h77ZsvKCMSrvXbeTUHEIPAw1lJXF4Wj21vTDticEZA==
X-Received: by 2002:a62:8f96:0:b029:1b7:75a9:a8b7 with SMTP id n144-20020a628f960000b02901b775a9a8b7mr5938848pfd.28.1611950776908;
        Fri, 29 Jan 2021 12:06:16 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id h15sm8364079pja.4.2021.01.29.12.06.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jan 2021 12:06:16 -0800 (PST)
Message-ID: <60146ab8.1c69fb81.2355d.3f3d@mx.google.com>
Date:   Fri, 29 Jan 2021 12:06:16 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: pm-5.11-rc6-71-ge86d494782b7e
X-Kernelci-Report-Type: build
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
Subject: pm/testing build: 7 builds: 0 failed,
 7 passed (pm-5.11-rc6-71-ge86d494782b7e)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 7 builds: 0 failed, 7 passed (pm-5.11-rc6-71-ge86d494782b=
7e)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/pm-=
5.11-rc6-71-ge86d494782b7e/

Tree: pm
Branch: testing
Git Describe: pm-5.11-rc6-71-ge86d494782b7e
Git Commit: e86d494782b7e43504b343d37b88c5c1d7af9ff6
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
