Return-Path: <linux-pm+bounces-15912-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B96E29A3158
	for <lists+linux-pm@lfdr.de>; Fri, 18 Oct 2024 01:27:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5FF3BB2196F
	for <lists+linux-pm@lfdr.de>; Thu, 17 Oct 2024 23:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 366E121D19F;
	Thu, 17 Oct 2024 23:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QrNLxfmj"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 799251F428B;
	Thu, 17 Oct 2024 23:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729207664; cv=none; b=DM1BfX0rKQ4Fm94FvIuIf25vYpCUZmCMKMSVaWfDoHIIqvoZgv2xetSpplg9CzM5xmaEQTFwekiN33JbDwxTU90LWfas1wv9MrzWSgiA1ndvgLs9cL1YlXHLnz9xnMfbN/SgQ4pAuiCRJbd3oO/QslZGwjFLQpjaaSGYEAdm64I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729207664; c=relaxed/simple;
	bh=ifz3yshYbLZ1aHxcRzTbeBb3kbz/UBxDdTmrzJaM2H4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u2ibPnahS3G+IYn4tU5BDFGXgi156x9xlriSCK2mmLrtJ+LIOKOlAj8jjKlIF9f66DJK+usiFSPNfffqNPTTpKSDoDAYZ7R4z2j50nUdMre+DRagA1x22+rBEXvCZfNMmZurhoSKjMQVNeaCCGy3vLRfdD+GkXFbmpr2e7I+3uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QrNLxfmj; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729207662; x=1760743662;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ifz3yshYbLZ1aHxcRzTbeBb3kbz/UBxDdTmrzJaM2H4=;
  b=QrNLxfmjHcET3J6uGVH/pOXn+d/6vjm+RsR+enw/XTnosTMq3gPDDkZn
   1WjM+D7j0OzTzGxy/oieGZ3hFzF3pUX3N98PXfiVarlQw39XM4PjD/s1c
   NENIr15vKL05WM6WnSwKJNRyvw4v3YF0ohNAuImrQu0byXQGBEI3NUMfo
   xP6NmLGf9quTNfJe8MoD9zkxUBbFG4EuGBKjG582tSTaTEDkzR7Sujw86
   nkBdab+oGcsXrwDnOkYX/l3WE/Ql/VIf111Goq1oUhK03y6WzRsWrUlsD
   YkkapQs3CGoRrT5/v94UnrioeXYcS3ZBcJCenC1U1eF4yKRxzmeXFu/pV
   Q==;
X-CSE-ConnectionGUID: HQJ6VIAIQ9G6sZh3obr6UA==
X-CSE-MsgGUID: kBa+XAqcRlGJSdXEhvFwKg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="28875879"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="28875879"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 16:27:42 -0700
X-CSE-ConnectionGUID: CiYqMp44SOCRf5IA5M4PGw==
X-CSE-MsgGUID: gErvNAL5QnW2fFCwIbd/GQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,212,1725346800"; 
   d="scan'208";a="109518421"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 16:27:42 -0700
Date: Thu, 17 Oct 2024 16:33:43 -0700
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Borislav Petkov <bp@alien8.de>, Hans de Goede <hdegoede@redhat.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	x86@kernel.org, "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Perry Yuan <perry.yuan@amd.com>, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-pm@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Subject: Re: [PATCH v2 05/13] platform/x86: hfi: Introduce AMD Hardware
 Feedback Interface Driver
Message-ID: <20241017233343.GA308@ranerica-svr.sc.intel.com>
References: <20241010193705.10362-1-mario.limonciello@amd.com>
 <20241010193705.10362-6-mario.limonciello@amd.com>
 <20241015035233.GA28522@ranerica-svr.sc.intel.com>
 <1395bee1-95a7-4d14-a5e8-0e1dc71fadac@amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1395bee1-95a7-4d14-a5e8-0e1dc71fadac@amd.com>
User-Agent: Mutt/1.9.4 (2018-02-28)

On Tue, Oct 15, 2024 at 01:09:42PM -0500, Mario Limonciello wrote:
> > 
> > > Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
> > 
> > I tried to find the HFI details on the documents in this "bug" but I could
> > not find them. What document in specific could I look at?
> > 
> > Thanks and BR,
> > Ricardo
> 
> Hi Ricardo,
> 
> It is spread out across multiple places.  This is part of the reason for
> patch 1 in the series outlines details of how it works.
> 
> The reason for that "collect all" Bugzilla for documentation is because the
> URLs for AMD documentation have undergone changes in the past and it makes
> it difficult to put stable URLs in commit messages.  So teams that want to
> reference documentation put it on a dump all bug for a stable URL to
> reference.
> 
> On that link you will find the APM, which will have some documentation
> specifically for the CPUID leafs used for topology identification and
> clearing history.
> 
> Read patch 1 and let me know if it covers what specifically you're looking
> for.  If it's still missing some info let me know what you would like added.

Thank you for your reply! I read patch 1. I was wondering specifically about
more details of the Class ID. I see that they have associated counters and
desired scheduling behavior.

I was also curious about the layout of the HFI table. I guess I can infer it
from patches 5 and 6 but if there is a picture already, I wouldn't mind. ;)


