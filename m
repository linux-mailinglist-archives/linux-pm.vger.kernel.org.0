Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 407DE3A337E
	for <lists+linux-pm@lfdr.de>; Thu, 10 Jun 2021 20:44:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbhFJSqR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 10 Jun 2021 14:46:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230311AbhFJSqR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 10 Jun 2021 14:46:17 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37F28C061760
        for <linux-pm@vger.kernel.org>; Thu, 10 Jun 2021 11:44:04 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id m13-20020a17090b068db02901656cc93a75so4291189pjz.3
        for <linux-pm@vger.kernel.org>; Thu, 10 Jun 2021 11:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=1RL8wFndK6sDEIZap+p/i6TcmMxgS94iZieBsZVZmI8=;
        b=yVX/l2AgaaeXrCvcDK5sxOPoPk/+M0rtUE5EcoCN+wZrIBf9bR/7UNdMPMA+X5fX2n
         GU5OOAFkJ83UItQxhtiKoqV6FT3ltw9J0wwtM1+V3MjfDMvDalHnXmvJnu+dqLskn6GC
         Y7vA0WJdY4MrOqskI0SlItfXW8meNHUgsGbXwdtjOqThMf7B/CmYsiA50FUmeoQ8wnRi
         73ORQtXH5rOnya5oO/YwzQkNmWp0Yjrw2MKDWhIXXkc5iiXgUEYxCldU8oRjix4Dsy7r
         RcEQYu/nO5fvJh62LfWg2DvG3w+9MBotaxjs9WZPeMTG2jDUFNFKagqs44znmY56LNPt
         S0qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=1RL8wFndK6sDEIZap+p/i6TcmMxgS94iZieBsZVZmI8=;
        b=UnyAMNCGZa9o478dO8QXSxdeDl8qM3RUyLGf+ftwXJZuoqEoLLpBfI00JYz/vAKH+h
         Zox0c0nME4gBYg7DOATn7O++UpLBaWnml8KN1nX0T0NvPEEs25eHtsqpaUDYaxhWfIfp
         XpQ0PBh2+1XlqsK/g9UdVkO5jgNVIG7ZXbhjgkpEwQ3WWYFm3cQy6iprYCIn4HHhSgfv
         rkOIkO5dc39QJCWKCaplBru67AvlWxismVZ9xaJZuK7hXHpuz8noobZrRfy080iHZ/Y2
         iXethuaNznW9rtE7e57U8zrWV3FMGU4e2JPdH89/7CK16nGWvfck6NCLjBSe2Irsps7q
         gcDw==
X-Gm-Message-State: AOAM530m+WVMRw0cgZCQHZo4XdiWgKJ9bW5lv3FCpTc1E9odXlD+wo7l
        eAzZJiPnRaaBKYOgD2BUL8M0Iox4XMZCaUU2
X-Google-Smtp-Source: ABdhPJwFoW/ma4pm3ZRE+HXv3OT91kaAAvFpd69nt+AxNQLuIaf5RDW0vtoodXSmGpSg0CjTGjhFIQ==
X-Received: by 2002:a17:902:8c91:b029:f3:b4da:4600 with SMTP id t17-20020a1709028c91b02900f3b4da4600mr134352plo.30.1623350643709;
        Thu, 10 Jun 2021 11:44:03 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id h12sm3144832pfq.72.2021.06.10.11.44.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 11:44:03 -0700 (PDT)
Message-ID: <60c25d73.1c69fb81.d1ab9.a13c@mx.google.com>
Date:   Thu, 10 Jun 2021 11:44:03 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.13-rc5-103-ga72d57d38055
X-Kernelci-Report-Type: build
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
Subject: pm/testing build: 7 builds: 0 failed,
 7 passed (v5.13-rc5-103-ga72d57d38055)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 7 builds: 0 failed, 7 passed (v5.13-rc5-103-ga72d57d38055)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
13-rc5-103-ga72d57d38055/

Tree: pm
Branch: testing
Git Describe: v5.13-rc5-103-ga72d57d38055
Git Commit: a72d57d38055f31e713e57d59999b04027b74e0d
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
