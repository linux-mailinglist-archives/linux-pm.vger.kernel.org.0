Return-Path: <linux-pm+bounces-18080-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24A369D8978
	for <lists+linux-pm@lfdr.de>; Mon, 25 Nov 2024 16:37:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56AE7B28712
	for <lists+linux-pm@lfdr.de>; Mon, 25 Nov 2024 14:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F175F1B0F06;
	Mon, 25 Nov 2024 14:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qpc1V091"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72DE21AB53A;
	Mon, 25 Nov 2024 14:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732546101; cv=none; b=lb3Thybhh3YtUN+HaXLz9qNyvhuARgf1ixl+Uj+OTU/4uc3TGKESVD7JWRFR8byasrOMVW4feUCHNN9GnbCECX5FYMjpBFqscwXDPYuRU0y2qp0pZ9VQTffVyQgYYDUDtWsaFz9Cjgp33EqyrHB3rp8p0rmqke3umlNF0Rfcr2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732546101; c=relaxed/simple;
	bh=c8syC6EboaoPViwH9Zdgo5EwnQTLFlVNffqwPCyJFbU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kyveGXgSvI15qptEVHfpIUdGn5kt7KnLvmT/8C5Pb4zfGXHyr+FRi6KBZlfbG4AFIJZOu75qquqAi3QC4/EDRAH2Z3ABKVDG7V1vemMjsL5ZNgwtv/O5Hnb+33SNQRK0eF60VNNQGtP6ezpxqBSp7Wn2pFaCNq0ltRBSoAuU4F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qpc1V091; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732546101; x=1764082101;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=c8syC6EboaoPViwH9Zdgo5EwnQTLFlVNffqwPCyJFbU=;
  b=Qpc1V091QaSehPRFAecev1tgoQOEj5iUoeKy6FH+l7P+0TOOM84XHIcM
   XHpNlIDBnZ2b53HeBbMaxlJtGYz7nOdM2pyx/BeV6645pDRN687KDmKie
   lKq7w6fkryhiFb0xk2hgenXry2mxoB7TBUJwGnSm8r1+1kxWQsnuAnysB
   szIS8at4hptuhlyPS/aAdc6dY5+Xuq/QvJvItoe7Z/iruGQVvxsywy8qM
   Fu61yZtDOPcB1S+KssxOcmulSgmqtIHgHXt54O6yWnwoBmYIaXrIq6420
   Btlxg/HpKGf6KDkMcMYYfNmNayEFqUkDMUvDYfnRnsH1L9e/DRW3hFx7Y
   A==;
X-CSE-ConnectionGUID: IywBJX+6QlCj8YAJh7Yw0Q==
X-CSE-MsgGUID: LIv24YHNRzyjvPekhNVc7g==
X-IronPort-AV: E=McAfee;i="6700,10204,11267"; a="44050393"
X-IronPort-AV: E=Sophos;i="6.12,183,1728975600"; 
   d="scan'208";a="44050393"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2024 06:48:18 -0800
X-CSE-ConnectionGUID: r+E+iEXlS3qsISW7H3Nn5w==
X-CSE-MsgGUID: lBLQZcWrT8KR7GhH94dp/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,183,1728975600"; 
   d="scan'208";a="95392406"
Received: from bergbenj-mobl1.ger.corp.intel.com (HELO [10.245.245.34]) ([10.245.245.34])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2024 06:48:14 -0800
Message-ID: <9b38b1ff-1755-4648-ae2e-9c7cce94c2b1@linux.intel.com>
Date: Mon, 25 Nov 2024 15:48:09 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 6/8] intel_idle: Provide enter_dead() handler for
 SRF
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 rafael.j.wysocki@intel.com, len.brown@intel.com,
 artem.bityutskiy@linux.intel.com, dave.hansen@linux.intel.com,
 peterz@infradead.org, tglx@linutronix.de, gautham.shenoy@amd.com
References: <20241125132029.7241-1-patryk.wlazlyn@linux.intel.com>
 <20241125132029.7241-7-patryk.wlazlyn@linux.intel.com>
 <CAJZ5v0gpSCWMLxekbe2LWmfAxoJ3AzqLuJ7SAFp8+F1n1wUCtQ@mail.gmail.com>
Content-Language: en-US
From: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>
In-Reply-To: <CAJZ5v0gpSCWMLxekbe2LWmfAxoJ3AzqLuJ7SAFp8+F1n1wUCtQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

> Is this still the case with the latest firmware?
>
> If so, this could be the second patch in the series if [1-3/7] are dropped.
>
> Otherwise, I don't think it is needed any more.
I discussed this case with Artem or Len off-list, before.
The idea is to add it for SRF too, to make sure that you get PC6, even on old firmware.

Just as reminder - the whole patch series is here to guard for future platforms too.
The SRF is just the one the problem was observed on.


