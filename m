Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14C6430483D
	for <lists+linux-pm@lfdr.de>; Tue, 26 Jan 2021 20:23:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726344AbhAZFrV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 26 Jan 2021 00:47:21 -0500
Received: from mail.skyhub.de ([5.9.137.197]:41000 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728573AbhAYNH6 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 25 Jan 2021 08:07:58 -0500
Received: from zn.tnic (p200300ec2f09db0060c9c38025ffa6e4.dip0.t-ipconnect.de [IPv6:2003:ec:2f09:db00:60c9:c380:25ff:a6e4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 391751EC04DF;
        Mon, 25 Jan 2021 14:05:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1611579946;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=hM/b/XGcvs4Dw1tgaHiDWLqnY29FFdGZW1BkxJIIpjs=;
        b=iW5KV97DEZ9rLsBVUgyizPmOVC1yrAZzQwdRId9gQ42MxN2yN9hwbu8Wx8oU5j0CNpjDTR
        8zbV8S+gfSdv2d2SAbaUMGlwlXD7lQJgjdNZP5z0YZojHT5OGCVkjKDKjSoJnKh06OmRtm
        s6Uw7OavL3taMDv4jKNYA/4mwV1+cfA=
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>, linux-pm@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 0/2] Move ...mce/therm_throt.c to drivers/thermal/
Date:   Mon, 25 Jan 2021 14:05:31 +0100
Message-Id: <20210125130533.19938-1-bp@alien8.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

Hi,

here's v2 which addresses peterz's comments to patch 2.

@thermal folks, lemme know if you have any objections otherwise I'll
route this through the tip tree.

Thx.

Changelog:
==========

v1:

so this has come up a bunch of times in the past and PeterZ is right
- that thing doesn't have anything to do with the MCE glue so move it
where it belongs.

Thx.

Borislav Petkov (2):
  x86/mce: Get rid of mcheck_intel_therm_init()
  thermal: Move therm_throt there from x86/mce

 arch/x86/Kconfig                              |  4 --
 arch/x86/include/asm/irq.h                    |  4 ++
 arch/x86/include/asm/mce.h                    | 22 -----------
 arch/x86/include/asm/thermal.h                | 21 ++++++++++
 arch/x86/kernel/cpu/intel.c                   |  3 ++
 arch/x86/kernel/cpu/mce/Makefile              |  2 -
 arch/x86/kernel/cpu/mce/core.c                |  1 -
 arch/x86/kernel/cpu/mce/intel.c               |  1 -
 arch/x86/kernel/irq.c                         | 29 ++++++++++++++
 drivers/thermal/intel/Kconfig                 |  4 ++
 drivers/thermal/intel/Makefile                |  1 +
 .../thermal/intel}/therm_throt.c              | 39 +++----------------
 drivers/thermal/intel/x86_pkg_temp_thermal.c  |  3 +-
 13 files changed, 70 insertions(+), 64 deletions(-)
 create mode 100644 arch/x86/include/asm/thermal.h
 rename {arch/x86/kernel/cpu/mce => drivers/thermal/intel}/therm_throt.c (96%)

-- 
2.29.2

