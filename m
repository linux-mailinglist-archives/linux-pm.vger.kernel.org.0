Return-Path: <linux-pm+bounces-20559-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63326A13EAD
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jan 2025 17:03:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7765188278D
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jan 2025 16:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13F7D22BAC1;
	Thu, 16 Jan 2025 16:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g6MBb8vi"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9301C1DDA17;
	Thu, 16 Jan 2025 16:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737043376; cv=none; b=SLo56fqteDkx7K6vSylMcIc89oMgnskPUnIGSHddfAeK3bXbfLA1DxVCza5Z2KWNQJsVyjrTUoUFLrvhrCXrSSoRrwzhfgM2xFYv+SznWDjuXq6xHi7fch11OzqJcbe65PTeBZuIL2GxibMO5eoEFjvyhv+t3c4ld1/7YhWcMVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737043376; c=relaxed/simple;
	bh=97p9b3mdL471MSKShwjo981bCu/leHm7j8x2aNa/8bE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f6W+E1+IONFoTYmi/1p944tAKin8k+4D5IHm80PmA/yTf+Edg3PRgRjFY+DE/MfDK+BQGYVG6faU9u/hFU035ux+tu2XUKoe/lHY6843ngQqBdAkXu7AN1ByDnJ6bBpblOMd6X+AYO8zii/tGSlV6LBVIzhx7POMRl0Tucly83Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g6MBb8vi; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737043375; x=1768579375;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=97p9b3mdL471MSKShwjo981bCu/leHm7j8x2aNa/8bE=;
  b=g6MBb8viVIetYi9naWHu9aI7Z1jevWlZS7QBdkT021kfV+BFLqKHYsFi
   ihi+qtogqAUsg5AjZl7zY5F7iigB3xkDFGTggryTh8SAd+bIezFAEtfgC
   rjiFCEu8SE7n3ma1efaqBp78sOm/xBnCgMoeAv/7wo7toQbrkaXitsp/0
   mMyezg3xGo0MPzvTQeXqqa2f5zWyLjYmBGweGAIg/qqdKv2zX0929YD+3
   TvbJ3tOh9WZKzRd4k005NM65hIQjDpA0q5UM0ChWHAcQa7Yk5c4Y9rJ8c
   X8+RSgTC97RdyqWXax5OgX2GtytT9e/0eFFFM6i1c9HMXxx4vx2i5/sFE
   A==;
X-CSE-ConnectionGUID: gz3kPbxTTomD2GCw9C2PDA==
X-CSE-MsgGUID: bzDgz2ibRvKjqiIsUkBMsg==
X-IronPort-AV: E=McAfee;i="6700,10204,11317"; a="37322375"
X-IronPort-AV: E=Sophos;i="6.13,209,1732608000"; 
   d="scan'208";a="37322375"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2025 08:02:54 -0800
X-CSE-ConnectionGUID: KN2BIi2GR5WoiJSewcaJXw==
X-CSE-MsgGUID: 22NScDJrTj2Bm1TWvLAm1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="105388009"
Received: from bergbenj-mobl1.ger.corp.intel.com (HELO [10.245.245.105]) ([10.245.245.105])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2025 08:02:51 -0800
Message-ID: <ac0babd8-2c05-4fe9-a2d0-9972172e1e92@linux.intel.com>
Date: Thu, 16 Jan 2025 17:02:38 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 0/4] SRF: Fix offline CPU preventing pc6 entry
To: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
 Dave Hansen <dave.hansen@intel.com>, x86@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 rafael.j.wysocki@intel.com, len.brown@intel.com, dave.hansen@linux.intel.com
References: <20250110115953.6058-1-patryk.wlazlyn@linux.intel.com>
 <e6c49f30-b32a-4ad0-98e2-634113011f90@intel.com>
 <5f24fe01b6dd0ae0e6d91209e143f2faff6ae017.camel@linux.intel.com>
 <860da841-fa82-4984-9e34-fba02e7aa556@intel.com>
 <fbdaf69ec121836db4d4611842bd0c1b93224bf6.camel@linux.intel.com>
Content-Language: en-US
From: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>
In-Reply-To: <fbdaf69ec121836db4d4611842bd0c1b93224bf6.camel@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

> * Because version 6.12 is LTS, there is a good chance that users of near-future
> new platforms will run 6.12 on them.
> * If a near-future platform happens to miss the firmware workaround for this
> issue, having these patches in 6.12 will likely mean that most users are OK.

Make sense to me. Any objections to adding "Cc stable v6.12"?


