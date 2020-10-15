Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6193E28F8C5
	for <lists+linux-pm@lfdr.de>; Thu, 15 Oct 2020 20:40:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388358AbgJOSkB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 15 Oct 2020 14:40:01 -0400
Received: from outbound-smtp45.blacknight.com ([46.22.136.57]:40627 "EHLO
        outbound-smtp45.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731154AbgJOSkB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 15 Oct 2020 14:40:01 -0400
X-Greylist: delayed 347 seconds by postgrey-1.27 at vger.kernel.org; Thu, 15 Oct 2020 14:40:00 EDT
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp45.blacknight.com (Postfix) with ESMTPS id 70AF2FAC87
        for <linux-pm@vger.kernel.org>; Thu, 15 Oct 2020 19:34:12 +0100 (IST)
Received: (qmail 19352 invoked from network); 15 Oct 2020 18:34:12 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.22.4])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 15 Oct 2020 18:34:12 -0000
Date:   Thu, 15 Oct 2020 19:34:10 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc:     Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org,
        Len Brown <lenb@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        rafael@kernel.org, Linux PM <linux-pm@vger.kernel.org>
Subject: Re: ACPI _CST introduced performance regresions on Haswll
Message-ID: <20201015183410.GU3227@techsingularity.net>
References: <c3566d2b-3da1-917b-2df6-f7dcfb33c8ed@intel.com>
 <20201006190322.GL3227@techsingularity.net>
 <25f31d3e-7a67-935f-93ba-32216a5084e2@intel.com>
 <20201006211820.GN3227@techsingularity.net>
 <2382d796-7c2f-665e-9169-5cdc437bf34c@intel.com>
 <20201008090909.GP3227@techsingularity.net>
 <dcf4266a-5769-8a6b-d8e1-e77553126861@intel.com>
 <20201008173436.GQ3227@techsingularity.net>
 <f6b04376-4214-ff5d-1069-890449a923e2@intel.com>
 <20201014223703.GT3227@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20201014223703.GT3227@techsingularity.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

> Yes, it's well hidden but it's there. If the profile is made custom, then
> the p-states can be selected and "custom" default enables C6 but not C3
> (there is a note saying that it's not recommended for that CPU). If I
> then switch it back to the normal profile, the c-states are not restored
> so this is a one-way trip even if you disable the c-state in custom,
> reboot, switch back, reboot. Same if the machine is reset to "optimal
> default settings". Yey for BIOS developers.
> 
> This means I have a limited number of attempts to do something about
> this. 2 machines can no longer reproduce the problem reliably.
> 

Turns out I didn't even have that. On another machine (same model,
same cpu, different BIOS that cannot be updated), enabling the C6 state
still did not enable it on boot and dmesg complained about CST not being
usable. This is weird because one would expect that if CST was unusable
that it would be the same as use_acpi == false.

This could potentially be if the ACPI tables are unsuitable due to bad
bad FFH information for a lower c-state. If _CST is not found or usable,
should acpi_state_table.count be reset to go back to the old behaviour?

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index 13600c403035..3b84f8631b40 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -1261,6 +1261,7 @@ static bool intel_idle_acpi_cst_extract(void)
 		return true;
 	}
 
+	acpi_state_table.count = 0;
 	pr_debug("ACPI _CST not found or not usable\n");
 	return false;
 }

-- 
Mel Gorman
SUSE Labs
