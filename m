Return-Path: <linux-pm+bounces-18824-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 07E929E95AC
	for <lists+linux-pm@lfdr.de>; Mon,  9 Dec 2024 14:07:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17C4716193C
	for <lists+linux-pm@lfdr.de>; Mon,  9 Dec 2024 13:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AA3022ACFB;
	Mon,  9 Dec 2024 12:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bHjd5zGR"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC9DA35946;
	Mon,  9 Dec 2024 12:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733749126; cv=none; b=Nsbp00Moe7CDC3LEbpAthRxWf+lvyNnPVVZz5QXu/aphMvXef4Pyl34IQs2HnJe6TUr4Xw32rF9NYUS4OsdERQjS+WW4qoiOq0pRN1WA6cZq1Bk4YXpgEXmfkm2aE6SAFZLJoBOOCw03yTCeIfQXoROj8fo6/KNYA7Ctw7OLpIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733749126; c=relaxed/simple;
	bh=39XwaRiIOgVyQ9gMcbkLIIec+j+q9bvgkuWvu2oTlm8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NCCsAUu8F0ZiZ+4N+9HpGJhpJwwSKK2DoOHuJophvO7DJjtImTLpndixjZaieCNfwNzuswyGyAiUYXIP86UnUrqzBZ82bUIvrc3XhDPA9Ww181d82/Ptv2zGHmg9bmnq1c5AtQyXLj/e0Z76uB1ZR8Q6byKWV90B1mg0WaInleY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bHjd5zGR; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733749125; x=1765285125;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=39XwaRiIOgVyQ9gMcbkLIIec+j+q9bvgkuWvu2oTlm8=;
  b=bHjd5zGRteAy0LLE399fg3pKQPlZc9eacFPys0vIJExyLQIdoCt4Y4eI
   NcsCRhiJqWFUvPzKi5zwXaixv2eurtc/mREzGCoOPNzQ5vAnmfqf3PHrg
   ugCbPXP4W9wBwfw9e0/FiZ9G6g9DZJ85E/LL+O88bRJuTHNWRa6TvEVfY
   jTTzUIt9llrva8cEYYziW663Sv5S/HYPr5Bw/EvtQy9++gJbm/UWUYRRE
   h76RVf/eFIInuNSaAWWgxPVdxKa4oDODhuhv46p4T5kmZospJHto6sg8P
   IKLqt8w//gQfDWVCEKUl/vvaJd4EQ9Co1P36T6rEk4xdKxyvps7XRW4NY
   Q==;
X-CSE-ConnectionGUID: ndVH2g/sSu2R8emXRFpb5A==
X-CSE-MsgGUID: 9v2ptSVpTVuN8odmOhN0Fw==
X-IronPort-AV: E=McAfee;i="6700,10204,11281"; a="56522713"
X-IronPort-AV: E=Sophos;i="6.12,219,1728975600"; 
   d="scan'208";a="56522713"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2024 04:58:44 -0800
X-CSE-ConnectionGUID: N7Z3TsNpQhWTFX+xJ9OpYw==
X-CSE-MsgGUID: +jSOBsZBSTOSsQitpLUk+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,219,1728975600"; 
   d="scan'208";a="94897752"
Received: from oandoniu-mobl3.ger.corp.intel.com (HELO [10.245.245.98]) ([10.245.245.98])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2024 04:58:41 -0800
Message-ID: <8279ea30-fb41-4dae-966a-799f2d7d2592@linux.intel.com>
Date: Mon, 9 Dec 2024 13:58:33 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/4] SRF: Fix offline CPU preventing pc6 entry
To: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 rafael.j.wysocki@intel.com, peterz@infradead.org,
 dave.hansen@linux.intel.com, tglx@linutronix.de, len.brown@intel.com,
 artem.bityutskiy@linux.intel.com
References: <20241127161518.432616-1-patryk.wlazlyn@linux.intel.com>
 <Z1bDbLZkfrxlie3M@BLRRASHENOY1.amd.com>
Content-Language: en-US
From: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>
In-Reply-To: <Z1bDbLZkfrxlie3M@BLRRASHENOY1.amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

> FWIW,
>
> I have tested the series on AMD platforms and there are no issues.
>
> Tested-by: Gautham R. Shenoy <gautham.shenoy@amd.com>

Thanks!


