Return-Path: <linux-pm+bounces-33016-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79CD5B33DBD
	for <lists+linux-pm@lfdr.de>; Mon, 25 Aug 2025 13:11:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58D5D164C25
	for <lists+linux-pm@lfdr.de>; Mon, 25 Aug 2025 11:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E2572DC347;
	Mon, 25 Aug 2025 11:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DfS4GTeP"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4CB623B636
	for <linux-pm@vger.kernel.org>; Mon, 25 Aug 2025 11:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756120275; cv=none; b=hms1mt4JdiZyxXqAv5l8+T/0YK1WxVIvE71i5eWguXMyW3f1i7mgX4DT1D8AOmvu3RFs92sRoJEe0Td9s+inc3l6Ik/vy37h4D0WWQg3GyBOUSz2TlCmqhs/mjVhNzRqI3CopB1eyWyH4ar3v9sdnOPeTHbc3YGG4SmjEq9kx5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756120275; c=relaxed/simple;
	bh=9T85XlPVxjsls3Rlx9bwrVlQwEhAtvR/Hq5JgqQU8mk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J1pZKsTsIXxH3RABHcFzmYZES/4M9ZN4qY31f+0ZfxB/+F2tO/zyamxqf6dNOqbZ39QEJ6hkSsijGks/8OpZGdK00qutJmq95j5Wgsh+Aqvif9L33nHoRdFBhPQbnirSdO3eyN+eTcS5oY5qP/9JvRW5H1BKIj3CIaywXn35CIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DfS4GTeP; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756120272; x=1787656272;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9T85XlPVxjsls3Rlx9bwrVlQwEhAtvR/Hq5JgqQU8mk=;
  b=DfS4GTePtFU95xO3ao7wsnEGZT8Wwk8WV7zbaW6ubKJKDlbzk3d1MG+j
   U4keGARQi9ZEICzrtDVkbwSf6rLfaJgHGgAVB2C+Pt9YNoAD02EyDE/4p
   3vSBx/VVYnyq8xe+Gv/iHWEVYl+c3rS1hTUKNfzA9pnvlNxzebBnp2s47
   fF9/Pod1N03v/8fCLpse5+gZIIJPaBXgclX2gEnQuklYb5zGX74y6hDQS
   jEuhjXaYZgUnBiAOTP3uiLFR35CLPWu+n50NgECgEUrLVIjRmOnTzbKM5
   MlE2pPFQPYbDk0w6jtkc809xB+viH9wHVb2CI4zbCtyTTaj3/17Vc38f5
   g==;
X-CSE-ConnectionGUID: P+0XcQxhQYOboAENgp1W5g==
X-CSE-MsgGUID: A9IjG2WWQLG2loFUdc0IeA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="80920698"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="80920698"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2025 04:11:11 -0700
X-CSE-ConnectionGUID: Bl2SDyvxRGS2vNb8/oiJtA==
X-CSE-MsgGUID: 5iGC4vmkTc+SvSwIo2ubBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="168478774"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa006.jf.intel.com with ESMTP; 25 Aug 2025 04:11:10 -0700
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id F2B6495; Mon, 25 Aug 2025 13:11:08 +0200 (CEST)
Date: Mon, 25 Aug 2025 13:11:08 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Zha Qipeng <qipeng.zha@intel.com>, Len Brown <lenb@kernel.org>,
	linux-pm@vger.kernel.org
Subject: Re: Pkg%pcX values do not add up to 100
Message-ID: <20250825111108.GR476609@black.igk.intel.com>
References: <774d9a96-0120-4009-8fd7-78387267b194@molgen.mpg.de>
 <20250825105509.GQ476609@black.igk.intel.com>
 <9ba4a892-f67a-4e18-a9a4-4aee777261bd@molgen.mpg.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9ba4a892-f67a-4e18-a9a4-4aee777261bd@molgen.mpg.de>

On Mon, Aug 25, 2025 at 01:04:19PM +0200, Paul Menzel wrote:
> Dear Mika,
> 
> 
> Am 25.08.25 um 12:55 schrieb Mika Westerberg:
> 
> > I'm not an expert here but if some of the CPUs are not in any of the power
> > saving states then they should not be counted.
> 
> So there is some kind of Pkg pc*1*(?) state, and that is where the missing
> percents are spent in?

Well if a CPU is running instructions then it obviously is not in any power
saving states. IIRC that state is called C0 (and it's not any package C
state).

Others can correct me if I'm wrong.

