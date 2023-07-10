Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71F9E74DFD1
	for <lists+linux-pm@lfdr.de>; Mon, 10 Jul 2023 22:50:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbjGJUub (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 10 Jul 2023 16:50:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233272AbjGJUuS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 10 Jul 2023 16:50:18 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26E3D46A8
        for <linux-pm@vger.kernel.org>; Mon, 10 Jul 2023 13:47:51 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-66767d628e2so3201749b3a.2
        for <linux-pm@vger.kernel.org>; Mon, 10 Jul 2023 13:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1689021966; x=1691613966;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=WVW+7DFta/vPWcuWsePk1WrYWNSLBZmKza9xmUTJzFI=;
        b=xGjwYETYGqO5RJrdVYuVON5HSD1KSTuxVLp6BuXWXPQRtadNXJ1Pw+kGVKul1aVDqH
         hn57ecebRidDN6k8S6G6GgMHFjB42oNU2eI0jItH6Cm6hK2WOTsIpKvfhMQ5ed3CBFGo
         ToZhBy5iJsaTjl1Lkoe7SBRNcqEPmQclURJjJmZvWuNHZ+Ny1VtRlu3d0zT77fhf/Jge
         Cvmo1YLQ6o+vUzwxsrN1BgPtWxeqzHG/PjfBvRzh65Gh3YRxAQXCjmiUH72Zp5xP34j0
         6aIMQCADJ+oNsnkBH1KL6izvWKr4EfqyLY2oG4e8YINguMNZqpwunY7nu0ue5VUYpGlC
         M2JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689021966; x=1691613966;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WVW+7DFta/vPWcuWsePk1WrYWNSLBZmKza9xmUTJzFI=;
        b=d/sadvAM0u7T8fmRWGyKKoWZPq5nsTub4zvtBzj8zXeR5F476DwphRwJQVRQbl0RgB
         be64vNabyuGOrVS80TiBmJC3cBwPE1to6VMGSEaGWMRqJJgHT1ovlcMTqD+/pGM8FTj6
         AGmnmDd10JMk/CtME9x9u49lMbPBYX5ZgKMksn37ZO71LNyMriLKRfJf4S/g8XAR+v/5
         6HMwBKgY24GdcTNpxzbHdu1VgXcpyS0+ApsK2TRead6lIIKu5bHmehGdfNLyX8nkzVjb
         9N6Q8uaAiHlvcMZ28QdBjbXO5LxIOtCVLMPoTnWVvQj27bd7JnfP/HxR5AjOP5oKoHG1
         +Dyw==
X-Gm-Message-State: ABy/qLZgR8eEx/iG6ft68n8eR0fLAL21L18eyt6LeycyauoWAWNdCsUR
        qfjw+H0me7B3AgUT3T4s7hfPEg==
X-Google-Smtp-Source: APBJJlGFiZJ3DCzCx+xD1Mehgs2lbkL5OxWn7IbGbep2RH01thppjNIPJva+1jb3qLotS+XAYpbV+Q==
X-Received: by 2002:a05:6a20:3cac:b0:130:835b:e260 with SMTP id b44-20020a056a203cac00b00130835be260mr11336675pzj.52.1689021966243;
        Mon, 10 Jul 2023 13:46:06 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id y17-20020a1709027c9100b001b858a5affasm307816pll.162.2023.07.10.13.46.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 13:46:05 -0700 (PDT)
Message-ID: <64ac6e0d.170a0220.815c3.1256@mx.google.com>
Date:   Mon, 10 Jul 2023 13:46:05 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.5-rc1
X-Kernelci-Tree: pm
X-Kernelci-Report-Type: build
X-Kernelci-Branch: testing
Subject: pm/testing build: 2 builds: 0 failed, 2 passed, 4 warnings (v6.5-rc1)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 2 builds: 0 failed, 2 passed, 4 warnings (v6.5-rc1)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v6.=
5-rc1/

Tree: pm
Branch: testing
Git Describe: v6.5-rc1
Git Commit: 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
Built: 2 unique architectures

Warnings Detected:

arc:

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
haps_hs_smp_defconfig (arc, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0=
 section mismatches

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
