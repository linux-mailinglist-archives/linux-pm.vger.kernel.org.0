Return-Path: <linux-pm+bounces-43099-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kIaGCC1CnWkMOAQAu9opvQ
	(envelope-from <linux-pm+bounces-43099-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 24 Feb 2026 07:16:13 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A0E6182593
	for <lists+linux-pm@lfdr.de>; Tue, 24 Feb 2026 07:16:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6B80A3051294
	for <lists+linux-pm@lfdr.de>; Tue, 24 Feb 2026 06:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EF901F5846;
	Tue, 24 Feb 2026 06:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="LuuMuITQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7842C2D7393;
	Tue, 24 Feb 2026 06:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771913705; cv=none; b=rkvZhQC36TrOjRR51xfAH4r0KqpvMZeJIXylkLOsw2sZL+KasPconsV6U59Dgqw+jID77jDYPJikUwY620tpfn5+mJmKG6xg9u5V5lWBhuewkpkvtHW1h59L5Th0+49j9KeA+Y5Q17nSoSF21lMTHZ9bKayDFryyGX156Wy/p34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771913705; c=relaxed/simple;
	bh=QcDufn3xlhbj1Rq1Nue63w7MTTSihoBn50RUpChiWhE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l4BVxmdpja8bRbUJXWJW7rE0Pq+oI3osNkBVU3PA+Erv35ZZnB5nWxs+U8aHGTp1dKoX1hobRJ0RAwmdMPyDRKror2tUbwDJLheJhvRBqwiCvHkFjBR5x+5dXZN4L5ALaRqQnHMxQv56Qg7iRBJ7WSrxQ4PVqremsn/IPBXPzNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=LuuMuITQ; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1771913699; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=QIJPzazOaalW7MX0aO4WtXqvM1VyjkLHNZ9TsbV6ckQ=;
	b=LuuMuITQdG5vcEmuB/nWfIU6LAmsYOBDHJtUM6hfj1eJdMgMMqxaQLiegUxyjDh/7lS94IhAJY8nRQ6qin+KqKlpcZlSWoIlJtKXI4UEJh7jqUNVCwvmvw5TMPLijxpM+lFysJselHRBFcgJncR3XV8PSp2obHIA8PW/lGkQej4=
Received: from 30.178.67.43(mailfrom:qinyuntan@linux.alibaba.com fp:SMTPD_---0WziWPiN_1771913694 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 24 Feb 2026 14:14:58 +0800
Message-ID: <fddaeb19-31f6-4b87-81d2-b12c072917ef@linux.alibaba.com>
Date: Tue, 24 Feb 2026 14:14:52 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: =?UTF-8?B?TW96aWxsYSBUaHVuZGVyYmlyZCDmtYvor5XniYg=?=
Subject: Re: [PATCH V1] tools/power turbostat: Fix RAPL MSR address selection
 on AMD platforms
To: Len Brown <lenb@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Xunlei Pang <xlpang@linux.alibaba.com>, oliver.yang@linux.alibaba.com
References: <20260130025358.4136660-1-qinyuntan@linux.alibaba.com>
 <CAJvTdK=RmwGqLkuZNYPck4f+tJStE0tZVeWX6qTASYa5b1FOFA@mail.gmail.com>
From: qinyuntan <qinyuntan@linux.alibaba.com>
In-Reply-To: <CAJvTdK=RmwGqLkuZNYPck4f+tJStE0tZVeWX6qTASYa5b1FOFA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-9.16 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43099-lists,linux-pm=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[qinyuntan@linux.alibaba.com,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[linux-pm];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alibaba.com:email,linux.alibaba.com:mid,linux.alibaba.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7A0E6182593
X-Rspamd-Action: no action

Hi Len,

Thank you for the quick response and for applying the fix to your tree.

I have tested the commit (16cc8f249c70) on our AMD platforms, and this 
issue is resolved. The turbostat tool now works correctly without the 
"msr offset 0x611 read failed" error.

Best regards,
Qinyun Tan

On 2/14/26 2:11 AM, Len Brown wrote:
> Thanks for noticing, reporting, and suggesting a fix!
> 
> Please let me know if this fix already in my tree does not address the
> issue for you.
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux.git/commit/? 
> h=turbostat&id=16cc8f249c702b7cbb4c2c2be7cd8f4fdd5d1d0c
> 
> -Len
> 
> On Thu, Jan 29, 2026 at 8:54 PM Qinyun Tan<qinyuntan@linux.alibaba.com> wrote:
>> idx_to_offset() uses valid_rapl_msrs to determine which MSR address to
>> return for RAPL counters (Intel's MSR_PKG_ENERGY_STATUS at 0x611 vs AMD's
>> MSR_PKG_ENERGY_STAT at 0xc001029b).
>>
>> However, probe_rapl_msrs() calls idx_to_offset() before valid_rapl_msrs
>> has been set - it's only assigned at the end of probe_rapl_msrs() after
>> successful MSR validation. This causes idx_to_offset() to always return
>> the Intel MSR address (0x611) during the probe phase, even on AMD systems.
>>
>> On Intel platforms this works by coincidence since the default (else
>> branch) returns the correct Intel address. On AMD platforms, this causes
>> turbostat to fail with:
>>
>>    turbostat: cpu0: msr offset 0x611 read failed: Input/output error
>>
>> Fix this by:
>> 1. Falling back to platform->plat_rapl_msrs when valid_rapl_msrs is zero
>>     (not yet validated). This ensures the correct platform-specific MSR
>>     address is used during the initial probe.
>> 2. Changing valid_rapl_msrs type from 'unsigned int' to 'int' to match
>>     plat_rapl_msrs type and avoid sign comparison warnings.
>>
>> Fixes: 19476a592bf2 ("tools/power turbostat: Validate RAPL MSRs for AWS Nitro Hypervisor")
>> Signed-off-by: Qinyun Tan<qinyuntan@linux.alibaba.com>
>> ---
>>   tools/power/x86/turbostat/turbostat.c | 12 ++++++++++--
>>   1 file changed, 10 insertions(+), 2 deletions(-)
>>
>> diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
>> index 5ad45c2ac5bd..449492d5e043 100644
>> --- a/tools/power/x86/turbostat/turbostat.c
>> +++ b/tools/power/x86/turbostat/turbostat.c
>> @@ -492,7 +492,7 @@ unsigned int quiet;
>>   unsigned int shown;
>>   unsigned int sums_need_wide_columns;
>>   unsigned int rapl_joules;
>> -unsigned int valid_rapl_msrs;
>> +int valid_rapl_msrs;
>>   unsigned int summary_only;
>>   unsigned int list_header_only;
>>   unsigned int dump_only;
>> @@ -2132,10 +2132,18 @@ struct msr_sum_array *per_cpu_msr_sum;
>>   off_t idx_to_offset(int idx)
>>   {
>>          off_t offset;
>> +       int rapl_msrs;
>> +
>> +       /*
>> +        * Use valid_rapl_msrs if available (non-zero), otherwise fall back
>> +        * to platform->plat_rapl_msrs. This allows probe_rapl_msrs() to call
>> +        * this function before valid_rapl_msrs has been set.
>> +        */
>> +       rapl_msrs = valid_rapl_msrs ? valid_rapl_msrs : platform->plat_rapl_msrs;
>>
>>          switch (idx) {
>>          case IDX_PKG_ENERGY:
>> -               if (valid_rapl_msrs & RAPL_AMD_F17H)
>> +               if (rapl_msrs & RAPL_AMD_F17H)
>>                          offset = MSR_PKG_ENERGY_STAT;
>>                  else
>>                          offset = MSR_PKG_ENERGY_STATUS;
>> --
>> 2.43.5
>>


