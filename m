Return-Path: <linux-pm+bounces-39867-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F11DECD96E6
	for <lists+linux-pm@lfdr.de>; Tue, 23 Dec 2025 14:24:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B31CF3012BF0
	for <lists+linux-pm@lfdr.de>; Tue, 23 Dec 2025 13:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB78832C958;
	Tue, 23 Dec 2025 13:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WR4c+2lF"
X-Original-To: linux-pm@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC09018FC80
	for <linux-pm@vger.kernel.org>; Tue, 23 Dec 2025 13:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766496282; cv=none; b=dtSvLFLPu6ZvluktH5+8txXG3VdisuclUkEESeicjaqtvh9xkooS8KsE+/UaGFIEJmlweyIS06rE+PAn2WiVXrTqF5xJxZENNCBDRXzd+abYIYkfbYM+Ncb/+M48Vzo4LvrkO3KbxYiB3Ap9VwyUFKQnpHhQJMqx2zwaowIv/6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766496282; c=relaxed/simple;
	bh=gK9OawX9wp4zO4hKWlRpOJAObUdBEBomXpLLHsqO6C0=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=W0Ps7qxC4hNLQXTjxuXdRKcbXVBTuzId6CNVy8R1lWtk7KEE0BxfeLnIqZsJKgGn+EvL3noj/MMd+yfDKAceVFZsJqHLXtVvn2d/bsjo5LhJZ1pL0iqD3+kPcz0mpvbDsMEjKO+FbNn4lzipFa8nZWkTnWclxFiDx1OWFVWzuZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WR4c+2lF; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766496279;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3r1HPM/unsvbZO56nnrxtWQoJMqJCpBYI94PYL6ZtxE=;
	b=WR4c+2lFfIvdQb40t3rqkRZbRVQGzmv2O/DGz42S+WeOy/C7BMPSRD8LGd4OUpLlXkHQOG
	RmRIyXrgaVby+zIWi4R8quuKfGmdZEWCkgjpIVuWGrmxxqHm+umC7ihTW/b1/9l5Eu4i0j
	U/+kK+MaHGfqQWIJkCNZmgYjkW7xCMM=
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.4\))
Subject: Re: [PATCH] cpufreq: amd_freq_sensitivity: Fix sensitivity clamping
 in amd_powersave_bias_target
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
In-Reply-To: <3F396FA4-8DB6-451E-BF58-02646808FC3B@linux.dev>
Date: Tue, 23 Dec 2025 14:23:01 +0100
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Thomas Renninger <trenn@suse.de>,
 Borislav Petkov <bp@suse.de>,
 Jacob Shin <jacob.shin@amd.com>,
 stable@vger.kernel.org,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <D681EEAF-A449-4464-80B1-D5B73E53B042@linux.dev>
References: <20251202124427.418165-2-thorsten.blum@linux.dev>
 <20251202190904.27c9bc06@pumpkin>
 <3F396FA4-8DB6-451E-BF58-02646808FC3B@linux.dev>
To: David Laight <david.laight.linux@gmail.com>
X-Migadu-Flow: FLOW_OUT

On 19. Dec 2025, at 16:55, Thorsten Blum wrote:
> On 2. Dec 2025, at 20:09, David Laight wrote:
>> On Tue,  2 Dec 2025 13:44:28 +0100
>> Thorsten Blum <thorsten.blum@linux.dev> wrote:
>> 
>>> The local variable 'sensitivity' was never clamped to 0 or
>>> POWERSAVE_BIAS_MAX because the return value of clamp() was not used. Fix
>>> this by assigning the clamped value back to 'sensitivity'.
>> 
>> This actually makes no difference
>> (assuming od_tuners->powersave_bias <= POWERSAVE_BIAS_MAX).
>> The only use of 'sensitivity' is the test at the end of the diff.
>> 
>> So I think you could just delete the line.
> 
> The local variable 'sensitivity' is an 'int', while '->powersave_bias'
> is an 'unsigned int'. If 'sensitivity' were ever negative, it would be
> converted to an 'unsigned int', producing an incorrect result. That's
> probably what the clamping was meant to prevent.
> 
> However, calculating 'sensitivity' can be simplified from:
> 
> 	sensitivity = POWERSAVE_BIAS_MAX -
> 		(POWERSAVE_BIAS_MAX * (d_reference - d_actual) / d_reference);
> 
> to:
> 
> 	sensitivity = POWERSAVE_BIAS_MAX * d_actual / d_reference;
> 
> which makes it clearer that, in practice, 'sensitivity' is never
> negative. How about simplifying the formula as above, changing
> 'sensitivity' to 'unsigned int', and removing the clamping?

Hm, changing the formula could alter the integer arithmetic, potentially
producing slightly different results, and might even overflow.

I guess we should keep the formula as is and either defensively clamp
'sensitivity', as originally intended, or just remove the line (since
this seems to have been working since 2013 and as suggested by David).

I'm slightly in favor of clamping the value because the assumptions
aren't obvious to me.

Any preferences or other suggestions?

Thanks,
Thorsten


