Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D67E4DDE0F
	for <lists+linux-pm@lfdr.de>; Fri, 18 Mar 2022 17:10:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238631AbiCRQLT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 18 Mar 2022 12:11:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238762AbiCRQKu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 18 Mar 2022 12:10:50 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 755191F606
        for <linux-pm@vger.kernel.org>; Fri, 18 Mar 2022 09:09:26 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id w8so7284237pll.10
        for <linux-pm@vger.kernel.org>; Fri, 18 Mar 2022 09:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=VrQ8UoT3WyyUk4R4GIeofrthx4UdgDa33DSlcJxR/fQ=;
        b=7fJ+HhDV0mG/nOOX0g59Fvg8T4AZxXsBI7sDkeNhjPhN/y2lqrV9jxuxsfPZu2gUDd
         ZLOKQOrR6CSGs4TKF81hS+CB10A0fg7Npm34lmsBSmMTH7SXSlgKHacYNKXtM56izO9l
         lnxv2Iepb/hzkV00PyInloI4A9A6e/mfGjfBJcHK1ao93lugs5U3+nVZ16hG228jNngc
         lOJtE4emVT1llZwgGhrjldqo0fx6SY29+N86VouMJ8e46TPtVBWeHQIPq7yI3YN+EOhv
         ib21jyfBgJKJ5IRX+fVVSSPK4hMQxmtlxzgoJ7xAbCM85ucFvnJihLzLFCwMGVAeA1FY
         IJuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=VrQ8UoT3WyyUk4R4GIeofrthx4UdgDa33DSlcJxR/fQ=;
        b=2Wrucwm1WqbN0rXwecKcZLy+dlYsThm35UFFsG/PA5FhLPFyEzBCkm9i6EjTt1VBQf
         CxmRttilgJ+2bsFbok8bW03gpXJA/av2pfc7pIQHdQ3nW1QvdqAyNJ3jC0s3P6PBkH8g
         W+zNzs5G/rrVvywgpI5dO1Yi/h6ZG6DsLsHVPwFLbr0NJ09UHOkTqUi9BN5J5r2XukIc
         2dxwJYWhlkAabLezhkFKUlYCIgTgxQ5Dudx56BUxDLDdocBCYe+tYNnyEGTsnl/kquxS
         Q5xTTOYQYwYBbEl27drBz937KPBBkPNXIl+w7DUrF9ZD9fC4iNucgcFfDXPCNlKONtvN
         6quw==
X-Gm-Message-State: AOAM530VsJ0+o4YeEGJgWbQsgeJi6Z6boU1LIseeBIy7Q3vPDjqkeeeK
        cj464Jqb672qSxDEq7ensVuiEw==
X-Google-Smtp-Source: ABdhPJxjbYSg84K4ZAGE4hx1vBjMlAKLnq8LXABrEkq4XxI9Bk6MG+UNgTGitXi42gavlv73h7x8Wg==
X-Received: by 2002:a17:90a:5293:b0:1bc:a544:a638 with SMTP id w19-20020a17090a529300b001bca544a638mr11909115pjh.174.1647619765555;
        Fri, 18 Mar 2022 09:09:25 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id s6-20020a056a0008c600b004f667b8a6b6sm10544092pfu.193.2022.03.18.09.09.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Mar 2022 09:09:25 -0700 (PDT)
Message-ID: <6234aeb5.1c69fb81.ad2b0.bfb2@mx.google.com>
Date:   Fri, 18 Mar 2022 09:09:25 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: acpi-5.17-rc9-163-g2a20faf0630e
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
Subject: pm/testing build: 7 builds: 0 failed,
 7 passed (acpi-5.17-rc9-163-g2a20faf0630e)
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

pm/testing build: 7 builds: 0 failed, 7 passed (acpi-5.17-rc9-163-g2a20faf0=
630e)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/acp=
i-5.17-rc9-163-g2a20faf0630e/

Tree: pm
Branch: testing
Git Describe: acpi-5.17-rc9-163-g2a20faf0630e
Git Commit: 2a20faf0630ecb8c908001d89f0a9bc1a9845685
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
Built: 7 unique architectures

---
For more info write to <info@kernelci.org>
