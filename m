Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3219F495B1A
	for <lists+linux-pm@lfdr.de>; Fri, 21 Jan 2022 08:46:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379137AbiAUHqN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 21 Jan 2022 02:46:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379093AbiAUHqM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 21 Jan 2022 02:46:12 -0500
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74408C061401
        for <linux-pm@vger.kernel.org>; Thu, 20 Jan 2022 23:46:12 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id m6so25093333ybc.9
        for <linux-pm@vger.kernel.org>; Thu, 20 Jan 2022 23:46:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=6VGlaNwo012lzA+7kz/lrPF90trnFFi6FJ6/mHic+hs=;
        b=xMPuSfeAAlBJoeqTa7zrkdfi+fcCQodwVxBlhLKj0MhKB1NnACApVZgTImEC6sApU8
         9AvVAlCAqJoyMWZ+Bgz1mADiqpeMprrtN8j4Q6zppP3f4GT2ZXfcqw1LKFaBA9WlhIxq
         4TeGYRYUwQV84j7lGnjGaacA+AmlgWCaxzWLNkDqHNv+vDZW6S1SpJf15evnnWP2rPGg
         wI3YE75QumJ8g5TyAOH6Djrq5nRfxp1gHViE1mIi5Q9+WJwHBskFL1YPMI1gycvpkiu5
         /7b5FtsKvlMBUX9pGLIeU0Fr9sZIl6/PdsUCZtjU/vvDU2ObGsMkqhEcpf9OOibLtvNc
         B5pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=6VGlaNwo012lzA+7kz/lrPF90trnFFi6FJ6/mHic+hs=;
        b=F6R0wcNGyKRsWChpXhjsY6JjIshCnrLavYWLo5Pd8nV1LXpsv2z7jv14+lR4hnnq8n
         cxgM4eNY0D+mDRtwisbd6x4MdXhYinvW77oiY8rXPMDWdFkeYdP1lhOlq4IV2qGjQLti
         M8Tsi3HLog5M4sdgWRmtJTqanDAF+ebLvUMUfhg67klNIbcDo40uVHHsi1CsEDm4ErGB
         wkrQ0zXVSjFZJPIyqvbXr3MFrambnYeCD9qzOA6hWxjuciw9NLua1Vsh/fhkDXnizMeC
         N4rBaw0uGCbDqK1dzioyMkxipsSKUCoj0Nq4lUP9eU0cutvGGqljPKplPXd0ZheECD10
         kAYQ==
X-Gm-Message-State: AOAM5333U0EHgz7oH0/Su1nXwpdNcTVw2qT2HRcNHyxZBKxjl3BnsaF2
        xT9JYtaqqk8rJZlOs2qB7t3ApIjpoOaD8Cv4l3Nls1UUVy6XiQ==
X-Google-Smtp-Source: ABdhPJwK9URes+a+U/H7ToYTf1isUH/kpRc2JSjoWu9Z7aUB1iVP5o2fLVMPV8e7sZaI40IlE/NocAVbxaMs+F8uP7I=
X-Received: by 2002:a25:8e89:: with SMTP id q9mr5016082ybl.520.1642751171389;
 Thu, 20 Jan 2022 23:46:11 -0800 (PST)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 21 Jan 2022 13:16:00 +0530
Message-ID: <CA+G9fYvuEqeoLO6dC_qtGyRUz=UPv5i0C3jZ_n9nz5kWOuCHYQ@mail.gmail.com>
Subject: [next] parisc: allnoconfig: ERROR: modpost: Section mismatches
 detected. Set CONFIG_SECTION_MISMATCH_WARN_ONLY=y to allow them.
To:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-parisc@vger.kernel.org, regressions@lists.linux.dev,
        lkft-triage@lists.linaro.org, Linux PM <linux-pm@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>, pavel@ucw.cz,
        rppt@kernel.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Linux next-20220121 parisc allnoconfig build failed with gcc-9/10/11.

make --silent --keep-going --jobs=8 ARCH=parisc
CROSS_COMPILE=hppa-linux-gnu- 'CC=sccache hppa-linux-gnu-gcc'
'HOSTCC=sccache gcc'

WARNING: modpost: vmlinux.o(.text+0x1c8): Section mismatch in
reference from the function ksys_sync() to the function
.init.text:memblock_alloc_try_nid()
The function ksys_sync() references
the function __init memblock_alloc_try_nid().
This is often because ksys_sync lacks a __init
annotation or the annotation of memblock_alloc_try_nid is wrong.

ERROR: modpost: Section mismatches detected.
Set CONFIG_SECTION_MISMATCH_WARN_ONLY=y to allow them.
make[2]: *** [/builds/linux/scripts/Makefile.modpost:59:
vmlinux.symvers] Error 1

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

metadata:
  git branch: master
  git repo: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
  git describe: next-20220121
  kernel-config: https://builds.tuxbuild.com/23zIAxC4uCgy4zadA01JYyOwCR4/config
  build: https://builds.tuxbuild.com/23zIAxC4uCgy4zadA01JYyOwCR4/

# To install tuxmake on your system globally:
# sudo pip3 install -U tuxmake
#
# See https://docs.tuxmake.org/ for complete documentation.
# Original tuxmake command with fragments listed below.

tuxmake --runtime podman --target-arch parisc --toolchain gcc-11
--kconfig allnoconfig

--
Linaro LKFT
https://lkft.linaro.org
