Return-Path: <linux-pm+bounces-42896-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8NNnFaKGl2n3zgIAu9opvQ
	(envelope-from <linux-pm+bounces-42896-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 19 Feb 2026 22:54:42 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E64E162F7A
	for <lists+linux-pm@lfdr.de>; Thu, 19 Feb 2026 22:54:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 907D0301485D
	for <lists+linux-pm@lfdr.de>; Thu, 19 Feb 2026 21:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1C0C318EFA;
	Thu, 19 Feb 2026 21:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eyZoXa04"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26FEC29B79B;
	Thu, 19 Feb 2026 21:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771538074; cv=none; b=LDfDa0LXXPFS/6gPhfSFnGOOKOwVs26ag/dqOR86qe8k9laYQfpI/y5JbrdlZMYwzdEoRzabc5VNc9sMivT4A58M1wJl/Xm6DWgBOL6eGHhoWH4Da0XpT8SpPdJY8lMO/YU/dGHax2+suFp9nVjI5MT+hOHrdS3T/n48z1CtzXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771538074; c=relaxed/simple;
	bh=jagUBTaMCIQfudCOmXqFI8P9Z4QR8ZxmREKJ1O7JsuQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qlLlspWpcPPVh0suq338giqVmuYx7dpn7/5J+VmVeVtmWv40NdplfqziuHlWeEW1JVCQKRrPUgmcZUUAIfnreHWWtk23LfgDK5WfXwvEHiQhWoOazQnwnsyqR1YToL9I4XF8OPl7Hq1m5CeCS8EwqjytR1b6NqqWP7FYKvg5DbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eyZoXa04; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771538073; x=1803074073;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=jagUBTaMCIQfudCOmXqFI8P9Z4QR8ZxmREKJ1O7JsuQ=;
  b=eyZoXa04xab54OQlwi5cBOFPLX1O34/dH+BKf8RfyTiDGZPjhFEmXHD4
   Az4Ya9cEEl4RrSTHxOWlThzTYuWzLrQegjt5qDJFyPt6FvJxtLmTj/A9x
   DVEonDpV61k7csktUFNg6prdfs6Fb7frXVWUSjqzZ6QyhaOxYqtQzeTKn
   P2f89e6gDQvNlCJ7eh/HDPS4k9ObVtNjFlq0Jz/QxkQD14BzFzUH8H6xg
   cq0WNnSVBx8VXYzZ7hC+/Oy9+EykfM64nciBmwfM6gF18LTymtJj8z8gG
   ec2dbD7Sq9phCdITltgIMk8wxz9SkU9kVdzpeHkIGZ5AX8Qmcez3bCZ/h
   g==;
X-CSE-ConnectionGUID: NNdo2p+5QfKEUmxmNpS6lw==
X-CSE-MsgGUID: 6F8nsNP9R4iYrY1Sb/YcAA==
X-IronPort-AV: E=McAfee;i="6800,10657,11706"; a="72339465"
X-IronPort-AV: E=Sophos;i="6.21,300,1763452800"; 
   d="scan'208";a="72339465"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2026 13:54:33 -0800
X-CSE-ConnectionGUID: bJJDZJ6KRf2KbpccunroVw==
X-CSE-MsgGUID: DMR1zxleTuCaJ6JgJF4CAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,300,1763452800"; 
   d="scan'208";a="213762370"
Received: from soc-pf446t5c.clients.intel.com (HELO [10.24.81.126]) ([10.24.81.126])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2026 13:54:33 -0800
Message-ID: <09db5a83-980c-432e-adbc-2582680c8cf9@linux.intel.com>
Date: Thu, 19 Feb 2026 13:54:32 -0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] PCI: pciehp: Fix hotplug on Catlow Lake with
 unreliable PME status
To: "Rafael J. Wysocki" <rafael@kernel.org>, Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20260213231428.613164-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <9b639ed0-1765-4cca-814e-18a1260e01b9@linux.intel.com>
 <CAJZ5v0iaKU6QJ7sxYCS21H0fv99DBNny-_bXzKH4g8RXgFuN6w@mail.gmail.com>
 <7b4dd756-2ab7-4331-b560-268f9cff0887@linux.intel.com>
 <CAJZ5v0gcZ5vs4WcS0GhvQrG9Kf05LNrNfd+oXz3WDdCA0xGjjw@mail.gmail.com>
 <aZbEDldZxV1KG_5B@wunner.de>
 <CAJZ5v0gF244JC5C9pLqmzxUuQkxMOXXBf92ckTKfeo9n8wgb1w@mail.gmail.com>
Content-Language: en-US
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <CAJZ5v0gF244JC5C9pLqmzxUuQkxMOXXBf92ckTKfeo9n8wgb1w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-42896-lists,linux-pm=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sathyanarayanan.kuppuswamy@linux.intel.com,linux-pm@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-pm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,wunner.de:email,intel.com:dkim]
X-Rspamd-Queue-Id: 3E64E162F7A
X-Rspamd-Action: no action

Hi,

On 2/19/2026 3:09 AM, Rafael J. Wysocki wrote:
> On Thu, Feb 19, 2026 at 9:04 AM Lukas Wunner <lukas@wunner.de> wrote:
>>
>> On Wed, Feb 18, 2026 at 06:33:15PM +0100, Rafael J. Wysocki wrote:
>>> First, keeping the ports in D0 may gate runtime PC10.  Does it not?
>>
>> The Root Port in question is on the PCH.  I'm not sure, does keeping a
>> PCH Root Port in D0 also prevent PC10 entry or is that only the case
>> for Root Ports on the CPU die/tile?
> 
> If it is located in the PCH, it should not gate PC10 if in D0 at least
> in theory, but it would be good to verify that.
> 
> Of course, it will still gate S0ix entry through runtime idle, but
> that's a bit moot if the platform is unable to enter S0ix through
> runtime idle anyway for other reasons (which is quite likely), or if
> the power difference between S0ix and PC10 is small.

I will gather current PC10 and S0ix numbers. If there is a significant
difference between the two power savings, I will implement the
pme_is_broken() approach.


> 
>> If this does cause a power regression, the pme_is_broken() approach
>> suggested upthread might be a viable alternative.  It'll allow the
>> Root Port to go to D3hot but will keep interrupts enabled in the
>> Slot Control register.
> 
> Sounds reasonable to me.

Sounds good. 

> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


