Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74D0E29F46A
	for <lists+linux-pm@lfdr.de>; Thu, 29 Oct 2020 20:03:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725822AbgJ2TDM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 29 Oct 2020 15:03:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725779AbgJ2TDM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 29 Oct 2020 15:03:12 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1CF1C0613CF;
        Thu, 29 Oct 2020 12:03:11 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0ce9003d743c4902fedd6b.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:e900:3d74:3c49:2fe:dd6b])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9264A1EC04CB;
        Thu, 29 Oct 2020 20:03:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1603998189;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=5g6+L4dmcjH0AZJZPbI+QWg3eUgbDM06/9Jfcu8DQ28=;
        b=ho+Au2HMYcADRJAr1mGTsWhNAGn+r0OL7URMHYVD45z49M51RYnJbMvs5GerfJ9ZwznJ3Z
        sx+zWL+Nma2gP4IMsCYrEX7u7cAIhZ8F5sc5+oOhtUN6rgERXgmBYfZQswKnmUA6nAmTST
        ABo6YFJDzAGgTqCTvw/aA2yJPaMGqcI=
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     Thomas Renninger <trenn@suse.com>, Shuah Khan <shuah@kernel.org>,
        Len Brown <lenb@kernel.org>, linux-pm@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 0/4] x86: Remove direct use of MSR_IA32_ENERGY_PERF_BIAS
Date:   Thu, 29 Oct 2020 20:02:55 +0100
Message-Id: <20201029190259.3476-1-bp@alien8.de>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

Hi,

here's v2 with some of Shuah's comments integrated.

If no one has anything against it, I'll route them all through tip.

Thx.

---
Changelog:

v0:
--

here's something from my todo list: remove all in-kernel tools use of
that MSR and lastly drop it from the allowed-MSRs-list in the filtering.

Out-of-tree tools should do a similar, trivial conversion.

Constructive comments are, as always, appreciated.

Borislav Petkov (4):
  tools/power/cpupower: Read energy_perf_bias from sysfs
  tools/power/turbostat: Read energy_perf_bias from sysfs
  tools/power/x86_energy_perf_policy: Read energy_perf_bias from sysfs
  x86/msr: Do not allow writes to MSR_IA32_ENERGY_PERF_BIAS

 arch/x86/kernel/msr.c                         |   3 -
 tools/power/cpupower/lib/cpupower.c           |  23 +++-
 tools/power/cpupower/lib/cpupower_intern.h    |   5 +
 tools/power/cpupower/utils/cpupower-info.c    |   2 +-
 tools/power/cpupower/utils/cpupower-set.c     |   2 +-
 tools/power/cpupower/utils/helpers/helpers.h  |   8 +-
 tools/power/cpupower/utils/helpers/misc.c     |  48 ++++++++
 tools/power/cpupower/utils/helpers/msr.c      |  28 -----
 tools/power/x86/turbostat/turbostat.c         |  29 ++++-
 .../x86_energy_perf_policy.c                  | 109 ++++++++++++++++--
 10 files changed, 204 insertions(+), 53 deletions(-)

-- 
2.21.0

