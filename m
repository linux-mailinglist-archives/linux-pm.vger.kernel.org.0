Return-Path: <linux-pm+bounces-41738-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eIH6Karce2noIwIAu9opvQ
	(envelope-from <linux-pm+bounces-41738-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 29 Jan 2026 23:18:18 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F0F5B53B7
	for <lists+linux-pm@lfdr.de>; Thu, 29 Jan 2026 23:18:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 144AF301053E
	for <lists+linux-pm@lfdr.de>; Thu, 29 Jan 2026 22:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 118C2361DDF;
	Thu, 29 Jan 2026 22:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h2fgTsI1"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F72535292A;
	Thu, 29 Jan 2026 22:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769725095; cv=none; b=mHTr8wtfkvCu+t4Fb1QTQXS471aVNR0Cswpxvp0Im8gEcsbNpIifuRTG98KEjEitkKyvH1QvBsSHbuoTfANBnor5vVlnmtnCJ8fqa8evogNXHusqLCay5VwlLg3zZ673X90dZ2zQhfy/mBZtI/oHhPQ51KyWCeFWK0qHOhmscMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769725095; c=relaxed/simple;
	bh=SpQmP3s5APRPcJkas8FfGT5qY05Xsbx8Eb2rXgpFLxY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PH8gCMZsRzfAneSgeEgjO21dRmnNG2OlTqr9R7fZCItzkUoVya7qOwvcy9dbPXOxE+AuuZD6sfqGL7jyhWvpyAMPX4OAarGasobW+9lJPkhIFnxgBzsBgoWQfre318wJmi40U6BlVqqqgSmdNountsKnlZu+ojWoHUOhAjC8ppY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h2fgTsI1; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769725093; x=1801261093;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=SpQmP3s5APRPcJkas8FfGT5qY05Xsbx8Eb2rXgpFLxY=;
  b=h2fgTsI1UXeVk5vS1Fr96VCgExTbqKvPdahx8xU0dFyUL/3RI7PQXK2r
   E2hBntbzWX0Vy2xKuJkE9dsTv9WqkemNGiUDwEZFvNuxxbDhK4njJ6GYn
   H2cRsdG3WOHyogoPiJP7x6J90EuJmsGTHpO2jLTOt9X8xONZMMJAzL87E
   ZdsNDmPcI/IZZillr+WQuDzra56i/owkOuAFLpF1tAi6+X2S+vQjqhv+B
   3n5F5vgNJkixBZ66bPEdDfB4fI1t0WFFmZY/VMUKhi/FX5O71+R69K2Ao
   Tr9ugzldEk2z60IqokQ3lJSUudy1ulWpWua4XscPRMX8CnyQCxgtukfEE
   A==;
X-CSE-ConnectionGUID: cjpQW+MuRJyVnfWzvKESxw==
X-CSE-MsgGUID: m4Xt5KtHQdG3tsbEm8EnSw==
X-IronPort-AV: E=McAfee;i="6800,10657,11686"; a="81711499"
X-IronPort-AV: E=Sophos;i="6.21,261,1763452800"; 
   d="scan'208";a="81711499"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2026 14:18:03 -0800
X-CSE-ConnectionGUID: XjG7P7ZiQ4S2rwKZl5AucA==
X-CSE-MsgGUID: 4TELPUTFRNyqiXrJyiggQA==
X-ExtLoop1: 1
Received: from soc-pf446t5c.clients.intel.com (HELO [10.24.81.126]) ([10.24.81.126])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2026 14:17:56 -0800
Message-ID: <962b2210-5dac-45a6-8ef0-894b337e74cc@linux.intel.com>
Date: Thu, 29 Jan 2026 14:17:55 -0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/9] powercap: intel_rapl: Use GENMASK() and BIT()
 macros
To: David Laight <david.laight.linux@gmail.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260129183646.558866-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20260129183646.558866-4-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20260129215225.33cce6dc@pumpkin>
Content-Language: en-US
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20260129215225.33cce6dc@pumpkin>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-41738-lists,linux-pm=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sathyanarayanan.kuppuswamy@linux.intel.com,linux-pm@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,intel.com:dkim,linux.intel.com:mid]
X-Rspamd-Queue-Id: 5F0F5B53B7
X-Rspamd-Action: no action



On 1/29/2026 1:52 PM, David Laight wrote:
> On Thu, 29 Jan 2026 10:36:40 -0800
> Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
> 
>> Replace hardcoded bitmasks and bit shift operations with standard
>> GENMASK(), GENMASK_ULL(), BIT(), and BIT_ULL() macros for better
>> readability and to follow kernel coding conventions.
>>
>> No functional changes.
> 
> Assuming that changing values to 'unsigned long' doesn't have any
> subtle side effects.
> 
> ...
>>  	value = (ra.value & ENERGY_UNIT_MASK) >> ENERGY_UNIT_OFFSET;
>> -	rd->energy_unit = ENERGY_UNIT_SCALE * 1000000 / (1 << value);
>> +	rd->energy_unit = ENERGY_UNIT_SCALE * 1000000 / BIT(value);
> 
> That should really be:
> 	rd->energy_unit = ENERGY_UNIT_SCALE * 1000000 >> value;

Type change to unsigned long will not have any impact for this use case. 
However, as you noted, using right shift (>>) instead of division by 
BIT() is the correct approach here anyway.

> 
> While using BIT() for bit patterns is resonable, wholesale substition
> isn't really right - and that isn't a bit pattern.

Agreed. I will use right shift for 1 / (1 << value) use cases.


> 
> 	David

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


