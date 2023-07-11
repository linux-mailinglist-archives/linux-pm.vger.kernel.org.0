Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21D1C74F843
	for <lists+linux-pm@lfdr.de>; Tue, 11 Jul 2023 21:09:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231266AbjGKTJd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 11 Jul 2023 15:09:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbjGKTJc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 11 Jul 2023 15:09:32 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E41C170B
        for <linux-pm@vger.kernel.org>; Tue, 11 Jul 2023 12:09:31 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-52cb8e5e9f5so3877918a12.0
        for <linux-pm@vger.kernel.org>; Tue, 11 Jul 2023 12:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1689102571; x=1691694571;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=asCZyZ9HFpR6s9Nkpl+Kthe/NXqPSPboBgGQ3MRKnE0=;
        b=GP0qRMQlKuYPtwB1+ZJJOGc1MITkdfAYBhIq6wbV4fmJfqfhui7DcNPRHCE0L6Ecve
         vabhnrK9yFHNehxIdKz4JBzdtZjLuiN+OiCZFHgJuTq7n3f2vm64DKOpdIfQieRT662B
         nCaxW/ADD/obxVS8DqB5EinRnfShJAY1/jU4hd4ULKQARahXYLpSff1NAy2EB6SaOwAq
         /frPitEks6Cgb9rEuRz1cNSuPWU3tDbQGWCFw7cl/UWgKnYXTzoLrcnn3aZGRxMvx1CD
         vQJuxz1Wa1OPq+Ufd+pKCqF7dY6EhRk6DX9YS7OA4D9TlwR0a2PwCMIjqcZ5F6xhzTpu
         u2KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689102571; x=1691694571;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=asCZyZ9HFpR6s9Nkpl+Kthe/NXqPSPboBgGQ3MRKnE0=;
        b=GKdGIh7YTefTS64g3ALqFqH3os6DwfplK7HS07CedzRkONq0Hy6fIgXEk+y3NNj7rz
         L7t9VJrkCJZ8M7XAqQVcU2263ouxNVYtwmoAnooACzKsqyjr3fnLkabWQ3qVjA1xxbHz
         IU+Q4pI04N2UdIhdys9s1RkkHRgfY4NqEM79JRz1b1uBffRMZ+Cin+jXAN0UecdnOPR1
         et49d98vbrbqCWk94SI5pJe7BP6HmOFbaeL/jTsg0E8yL6c0rgiiLILu+oT74pph+UTd
         O5AtlVo5bjV6/e2T1L58lt31gwPNy2a8il4QT0MrOlR2HqXBXNIA8sNLQS7EvbkU4SeJ
         SGOQ==
X-Gm-Message-State: ABy/qLb9bbyNhAWj9jj23fiNItzF+CMrItMEfdT4Iwdf4ySgUgZyjLqB
        tveF9i2OTPE8DtXkdkDZNR1V9A==
X-Google-Smtp-Source: APBJJlFFN/uCmKXDwgXa7/bSp7SdbX5FkQXK6YS1zfi0i53Au2LVZoADjiz8jJVLALDaxabV0OPcsQ==
X-Received: by 2002:a17:90a:8c01:b0:25c:18ad:6b82 with SMTP id a1-20020a17090a8c0100b0025c18ad6b82mr23361986pjo.21.1689102570923;
        Tue, 11 Jul 2023 12:09:30 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id in15-20020a17090b438f00b00262d079720bsm8422664pjb.29.2023.07.11.12.09.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 12:09:29 -0700 (PDT)
Message-ID: <64ada8e9.170a0220.69234.ff34@mx.google.com>
Date:   Tue, 11 Jul 2023 12:09:29 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.5-rc1-15-g61ca8e67fe61
X-Kernelci-Tree: pm
X-Kernelci-Report-Type: build
X-Kernelci-Branch: testing
Subject: pm/testing build: 5 builds: 0 failed,
 5 passed (v6.5-rc1-15-g61ca8e67fe61)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 5 builds: 0 failed, 5 passed (v6.5-rc1-15-g61ca8e67fe61)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v6.=
5-rc1-15-g61ca8e67fe61/

Tree: pm
Branch: testing
Git Describe: v6.5-rc1-15-g61ca8e67fe61
Git Commit: 61ca8e67fe61d3df255cede64416b70502c3232d
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
Built: 5 unique architectures

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
defconfig (arm64, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section m=
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
