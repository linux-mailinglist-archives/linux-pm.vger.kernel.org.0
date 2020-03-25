Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01C5B191E48
	for <lists+linux-pm@lfdr.de>; Wed, 25 Mar 2020 01:55:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbgCYAzl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 24 Mar 2020 20:55:41 -0400
Received: from cmta20.telus.net ([209.171.16.93]:53900 "EHLO cmta20.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727261AbgCYAzk (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 24 Mar 2020 20:55:40 -0400
Received: from dougxps ([173.180.45.4])
        by cmsmtp with SMTP
        id GuFxjJjQxYkAEGuFyj2TCO; Tue, 24 Mar 2020 18:50:55 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telus.net; s=neo;
        t=1585097455; bh=vYUYZhWdzni3k9yF0sT6VpET+CBSIDMl//6cnXP+1wg=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date;
        b=1pIxDudeOrDjFkNP5XxaFejmkvlZ+E1cQoMVR9cr8qIIbbNmvwxQ0LDCiiWXYkmnp
         dWXwdoeW/nkYgMbmTMxhfy76b+dQK9nIY+9u+FhA7yVUaIzRJfLRNENys9z4oKyf8P
         eVklh30GXWfyjg5xhFMAczkr3XNQsqTYxYrsZSBRfG/aQXfodoUwxPzz167hw6rpac
         2rMLkxD6qViWdKruWqNtbNOiziGPyj8vPY0wVMTcJLN3LvWIvSUln0+XXijGeEy5cy
         PODH4MVvNwBCdUsOuN6CGpUKb5/GBVLEhcYMhrKj07pfU/EN7On8I8vFO6MyOghQJS
         KIWvLtawdpkzw==
X-Telus-Authed: none
X-Authority-Analysis: v=2.3 cv=caqsUULM c=1 sm=1 tr=0
 a=zJWegnE7BH9C0Gl4FFgQyA==:117 a=zJWegnE7BH9C0Gl4FFgQyA==:17
 a=Pyq9K9CWowscuQLKlpiwfMBGOR0=:19 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19
 a=kj9zAlcOel0A:10 a=QyXUC8HyAAAA:8 a=ctVjbXThj1diqwFriuMA:9 a=CjuIK1q_8ugA:10
From:   "Doug Smythies" <dsmythies@telus.net>
To:     "'Len Brown'" <lenb@kernel.org>, <linux-pm@vger.kernel.org>
Cc:     "'Len Brown'" <len.brown@intel.com>,
        "'Antti Laakso'" <antti.laakso@linux.intel.com>
References: <081c54323b27d8d4b40df6b2375b9e1f6846d827.1584766216.git.len.brown@intel.com> <abdcbdb265264f736df316622a695ad30019c05f.1584766216.git.len.brown@intel.com>
In-Reply-To: <abdcbdb265264f736df316622a695ad30019c05f.1584766216.git.len.brown@intel.com>
Subject: RE: [PATCH v2 09/10] tools/power turbostat: Print cpuidle information
Date:   Tue, 24 Mar 2020 17:50:52 -0700
Message-ID: <003101d6023f$70975750$51c605f0$@net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 12.0
Thread-Index: AdX/POAWdEVxnJZVR9KcDWu6dcP75QDAEhWQ
Content-Language: en-ca
X-CMAE-Envelope: MS4wfIcErS4gDKgkzEza4VkbIt2lttvNoDXqC9Hn0y/aimn0zkPB5xJXj0YQN6aif/EtkJvxb+uzekn2RWCVxHfdKbxuSBw76mXCSOwiAdAdOZ1ZVBN19/jy
 AptOk/OLRie9kYLwxL4XWJg24xGMGvUUI2fQmIGIXgU94NjMH2srU6u2Nm1tn9y9jZFcCdunjClWANTzzUepHHzpxOQ9RKruhVhOVFkO/aSmAwDuI0Ggo4V0
 7C0CKO1BYzAkTEHwmkZSYv6pB6iPvy9bi5xcfC+CqrA=
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Len,

On 2020.03.20 21:55 Len Brown wrote:

> From: Len Brown <len.brown@intel.com>
>
> Print cpuidle driver and governor.
> 
> Originally-by: Antti Laakso <antti.laakso@linux.intel.com>
> Signed-off-by: Len Brown <len.brown@intel.com>
> ---
> tools/power/x86/turbostat/turbostat.c | 26 ++++++++++++++++++++++++++
> 1 file changed, 26 insertions(+)
>
> diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
> index 77f89371ec5f..05dbe23570d4 100644
> --- a/tools/power/x86/turbostat/turbostat.c
> +++ b/tools/power/x86/turbostat/turbostat.c


... 

> 
> static void
> dump_sysfs_cstate_config(void)
> {
> @@ -3516,6 +3533,15 @@ dump_sysfs_cstate_config(void)
> 	if (!DO_BIC(BIC_sysfs))
> 		return;

I do not understand why this information needs to be
a function of the --show options and not solely a
function of the --quiet option.

My reasoning is that I almost always want all the information
possible in the start spew of stuff, and if I don't I'll
use --quiet option. However, I rarely show more than
about 6 columns at a time resulting in intermittent inclusion
of this information.

> 
> +	if (access("/sys/devices/system/cpu/cpuidle", R_OK)) {
> +		fprintf(outf, "cpuidle not loaded\n");
> +		return;
> +	}
> +
> +	dump_sysfs_file("/sys/devices/system/cpu/cpuidle/current_driver");
> +	dump_sysfs_file("/sys/devices/system/cpu/cpuidle/current_governor");
> +	dump_sysfs_file("/sys/devices/system/cpu/cpuidle/current_governor_ro");
> +
>  	for (state = 0; state < 10; ++state) {
>  
> 		sprintf(path, "/sys/devices/system/cpu/cpu%d/cpuidle/state%d/name",


