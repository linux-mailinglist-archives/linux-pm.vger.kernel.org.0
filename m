Return-Path: <linux-pm+bounces-42029-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6KzlJdOygmn/YAMAu9opvQ
	(envelope-from <linux-pm+bounces-42029-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 04 Feb 2026 03:45:39 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1073BE0F86
	for <lists+linux-pm@lfdr.de>; Wed, 04 Feb 2026 03:45:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5BCBB3020252
	for <lists+linux-pm@lfdr.de>; Wed,  4 Feb 2026 02:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 484B82D7814;
	Wed,  4 Feb 2026 02:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NQClxZG8"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC8201684B4;
	Wed,  4 Feb 2026 02:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770173136; cv=none; b=Khw2MEGRWgxcqqAUZ32Ly5xfXfhpRt2IcbkjuWT15DOc4Dnn9NQPAYlUYaD40TaoIgNSlfSqZ0ixUt1JsC4mENPMst4Ic8VHeG9Msiu4zl18vCPjhgt3CplOZorGwDnM4yuZVjEw86S09HRRp/Og7jHgNbUYg0H9p6w01/Hkbsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770173136; c=relaxed/simple;
	bh=qLboBc28TQbYjZjrQ9HYidTciCpuWVfQZxiDZM7dw3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TqboaqGNT1t/+2Y+nT/K1ikjlrKfmprAP1JAsVxNDNu9PDBUOXDj+TE6GrCgy21r2Mq/IAtsJExWlQtJZPwH3wypS1U0BMDl3kT1lwq98rwMOkXI0MpTHI7o43rZY3UL7YErhH32DKeP4eBOFgcmihmXvMXfufRlljrZuADe4Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NQClxZG8; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770173134; x=1801709134;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qLboBc28TQbYjZjrQ9HYidTciCpuWVfQZxiDZM7dw3M=;
  b=NQClxZG816mjJMDRy9b38Tpk2v0wOG3PDTNiDZpOTmfY1PwFH68Znoj6
   6M9QCBtBrGrgd8Pn8ef1lpZpB4+nDlVdrbV4i7de6qlmBnlLGHVdWrgcV
   qHY2Cpb8Ux/O814beKaGYNz6RtpTpRVl4r+8QUwwTGkqWmD9k4FazyViZ
   a14K7gZye6QKWxNeLOy5KEzcA25fnAQ63w6UIUtgjp8sTCarSG2z5oEvZ
   TDvlmL4h3vhTIGx1ljMEqyHfmbK8DOVP7WYjSV8LoedOv832jfWgGX6Vz
   f7UmCl/8tRQU+kDa+UjN60p0DFE0FRKyjjWX9HkTU9HsqCoys+ZugSw2q
   Q==;
X-CSE-ConnectionGUID: oghZf1o0QzGuLFIHg0JJlg==
X-CSE-MsgGUID: sVJ06r1tQVu2mqdZNTRN4A==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="58933097"
X-IronPort-AV: E=Sophos;i="6.21,271,1763452800"; 
   d="scan'208";a="58933097"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 18:45:33 -0800
X-CSE-ConnectionGUID: Y1KOjNm7TGGNI5D6z7n1EA==
X-CSE-MsgGUID: YPNLNw6UQS6aowQmLk3gSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,271,1763452800"; 
   d="scan'208";a="210100468"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.245.168])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 18:45:31 -0800
Date: Wed, 4 Feb 2026 04:45:29 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: MyungJoo Ham <myungjoo.ham@samsung.com>
Cc: Chanwoo Choi <cw00.choi@samsung.com>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Kyungmin Park <kyungmin.park@samsung.com>
Subject: Re: [PATCH v1 1/1] PM/devfreq: Remove unneeded casting for HZ_PER_KHZ
Message-ID: <aYKyyeF_RqgHiSdn@smile.fi.intel.com>
References: <20260114093115.276818-1-andriy.shevchenko@linux.intel.com>
 <CGME20260114093125epcas1p17c29852c6b5b066057b60c9a7795be77@epcms1p5>
 <20260120093220epcms1p528ac87fa1d924dae9981c4f049337571@epcms1p5>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260120093220epcms1p528ac87fa1d924dae9981c4f049337571@epcms1p5>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-42029-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@linux.intel.com,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[smile.fi.intel.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:email,intel.com:dkim]
X-Rspamd-Queue-Id: 1073BE0F86
X-Rspamd-Action: no action

On Tue, Jan 20, 2026 at 06:32:20PM +0900, MyungJoo Ham wrote:
> >HZ_PER_KHZ is defined as UL (unsigned long), no need to repeat that.
> >
> >Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> >---
> > drivers/devfreq/devfreq.c | 5 ++---
> > 1 file changed, 2 insertions(+), 3 deletions(-)
> >
> 
> Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>

Can it be applied, please?

-- 
With Best Regards,
Andy Shevchenko



