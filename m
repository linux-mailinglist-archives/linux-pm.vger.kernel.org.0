Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 848312EEED6
	for <lists+linux-pm@lfdr.de>; Fri,  8 Jan 2021 09:55:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726377AbhAHIzP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 8 Jan 2021 03:55:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726241AbhAHIzP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 8 Jan 2021 03:55:15 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10FE2C0612F4;
        Fri,  8 Jan 2021 00:54:35 -0800 (PST)
Received: from zn.tnic (p200300ec2f0a3100e3d4b1ce3b15cc26.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:3100:e3d4:b1ce:3b15:cc26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9B3821EC0423;
        Fri,  8 Jan 2021 09:54:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1610096073;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=DfOI+qtpIgDYZlSH9SH7cbqpgIzK60Q5wwH9XVoeztk=;
        b=B11oJZIObs5KpbmSRCjSXUbUSZUTJj471hPW9L2Oq5tZnAcafsbVZTLT6YINap4S+a6CmO
        M7X3/PkaHyF+2rBSdhcZulWKVV9t7YT9SGpkQJs3teD0tFUq70b9ABgq89gqc2DMENb/Bd
        4VZ7HO/2ohz7mBUqlg7J+z3kBmc8Dck=
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     Tony Luck <tony.luck@intel.com>, Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>, linux-pm@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/2] Move ...mce/therm_throt.c to drivers/thermal/
Date:   Fri,  8 Jan 2021 09:54:28 +0100
Message-Id: <20210108085430.13449-1-bp@alien8.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

Hi,

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
 arch/x86/kernel/irq.c                         | 28 +++++++++++++
 drivers/thermal/intel/Kconfig                 |  4 ++
 drivers/thermal/intel/Makefile                |  1 +
 .../thermal/intel}/therm_throt.c              | 39 +++----------------
 drivers/thermal/intel/x86_pkg_temp_thermal.c  |  3 +-
 13 files changed, 69 insertions(+), 64 deletions(-)
 create mode 100644 arch/x86/include/asm/thermal.h
 rename {arch/x86/kernel/cpu/mce => drivers/thermal/intel}/therm_throt.c (96%)

-- 
2.29.2

