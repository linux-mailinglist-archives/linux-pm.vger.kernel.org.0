Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAE4F28F51E
	for <lists+linux-pm@lfdr.de>; Thu, 15 Oct 2020 16:47:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388685AbgJOOqp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 15 Oct 2020 10:46:45 -0400
Received: from mail.skyhub.de ([5.9.137.197]:48138 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388305AbgJOOqR (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 15 Oct 2020 10:46:17 -0400
Received: from zn.tnic (p200300ec2f0ed2005c4d90d75300802a.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:d200:5c4d:90d7:5300:802a])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4CBCD1EC0328;
        Thu, 15 Oct 2020 16:46:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1602773176;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=rpunifJ24jwRTZS2TIiqk+YVW7s/WrEZ0ErJ6Xjz+kk=;
        b=PsR5+v0QW6IRQyCgmP8YtQlaL/SmzuwT8hmSisd/dUW41yOTWs8mwj+R1VF6JT/MfiwbcS
        K/ZgmuoYcIxH89Y4Wg7x6P7vZ4OT2Dx2nbr8EmiSYaHWhbT61CpGLhbhtzoQyZdqzbce1k
        cWEizykX+SN1q/GTgbsaYvh/lQ1RzMQ=
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     Thomas Renninger <trenn@suse.com>, Shuah Khan <shuah@kernel.org>,
        Len Brown <lenb@kernel.org>, linux-pm@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/4] x86: Remove direct use of MSR_IA32_ENERGY_PERF_BIAS
Date:   Thu, 15 Oct 2020 16:45:59 +0200
Message-Id: <20201015144603.27933-1-bp@alien8.de>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

Hi all,

here's something from my todo list: remove all in-kernel tools use of
that MSR and lastly drop it from the allowed-MSRs-list in the filtering.

Out-of-tree tools should do a similar, trivial conversion.

Constructive comments are, as always, appreciated.

Thx.

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

