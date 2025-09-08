Return-Path: <linux-pm+bounces-34142-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F03AB4882F
	for <lists+linux-pm@lfdr.de>; Mon,  8 Sep 2025 11:22:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5ACA43AAE24
	for <lists+linux-pm@lfdr.de>; Mon,  8 Sep 2025 09:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1FD02EE61D;
	Mon,  8 Sep 2025 09:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WQyPMgAX"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95781D63EF;
	Mon,  8 Sep 2025 09:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757323336; cv=none; b=TcDdsnk1zWmVMEzXLOAXQk6Je2WvLXFHMzCdSqXFjsc0sT80cpz4eAI2AmpYkhr9bgix/9cvXWhWq7OsvCusz7JKvUe9UZH7Gh5WZaT25rfZAJAzLUlQYLHizbX4phI3XvjW8k8pWLgQivArK0FsonnyQdpZ4wTU7M+7whjQgXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757323336; c=relaxed/simple;
	bh=RQXADD0cS0ZVsnz4pMEqemDrTvOMGV2K8cYEaFDvCXE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PvVs5OQKe2sEN3fMRjpPr/YYeg5hdeFinxeX5oLy1oTwI4VFHBiohePiHJ73OzaVYnopHaCezT0grC/8Q0E/+ty8vQzn/cOXpqqq+JGyvh6wGOltM91U5vhUv1aGjqRa4StZuHqsUOV94teiXFg1hBZAVVkE6XDFMllq34Iia38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WQyPMgAX; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757323335; x=1788859335;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=RQXADD0cS0ZVsnz4pMEqemDrTvOMGV2K8cYEaFDvCXE=;
  b=WQyPMgAXAa57JwBOWlEtPMfdcjQ6wwXGwD1hy0lBmJ6eyZlpUkBvpSmI
   TugWoXTWL8SVcyLdmsMkB86SrUrp2v6wpQTBfeGhnOvLhAVd2jYBwsucb
   ru8CqyTnR6SAZW857mfZMi3Z3rB2fv+mUNhOSwTbe0XJeUhZuazdlG9IM
   yOQR/whN6YfhQdXNtlEz4crdnYL/lSSVnGw6XxegmQBe8boipFlZL+Ysb
   7kelUuFMpBTj6R0EOF0oYAxTfR3HtBU8JyjbFK+PBD3LlTxvUdcEb0W4S
   +KTiezptSo/8o8eecgkaKt5200pAgxMQzcMDf28dK5g3AuHusm0AWEASs
   g==;
X-CSE-ConnectionGUID: GtuG5Jj4R3aaRVl3MMGzLQ==
X-CSE-MsgGUID: FiU7uKF3SMGvA73qxZoYhA==
X-IronPort-AV: E=McAfee;i="6800,10657,11546"; a="70278467"
X-IronPort-AV: E=Sophos;i="6.18,248,1751266800"; 
   d="scan'208";a="70278467"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2025 02:22:14 -0700
X-CSE-ConnectionGUID: IWOIyFBNRUqNWsZB9TcL/Q==
X-CSE-MsgGUID: xab+wN7WQpWnqCl8fIlQAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,248,1751266800"; 
   d="scan'208";a="209904081"
Received: from carterle-desk.ger.corp.intel.com (HELO localhost) ([10.245.246.204])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2025 02:22:10 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Randy Dunlap
 <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Pavel Machek
 <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org,
 Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, "James E.J.
 Bottomley" <James.Bottomley@hansenpartnership.com>
Subject: Re: [PATCH v4] kernel.h: add comments for system_states
In-Reply-To: <20250907181719.0138c054@foz.lan>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20250904063631.2364995-1-rdunlap@infradead.org>
 <6089e22ddfdc135040cdeb69329d817846026728@intel.com>
 <20250905140104.42418fba@foz.lan>
 <34fb6a27a2c17c22c0ac93bebb0bbfd1a04d1833@intel.com>
 <atj2koasbiuf67rzr7bbdwpu4kcgkdsqt6rhz5vwpbryfqxm7z@mfmts3tnsasf>
 <2aad4540-ccdd-4519-9bed-7d8c7ccd009d@infradead.org>
 <20250906105627.2c0cd0d9@foz.lan>
 <d815f5c3-6e15-4758-8bf4-601d5543cab9@infradead.org>
 <20250906233028.56573fd6@foz.lan> <20250907153547.5d4271d9@foz.lan>
 <20250907181719.0138c054@foz.lan>
Date: Mon, 08 Sep 2025 12:22:06 +0300
Message-ID: <f6e0f7409df67e0554885cacb74023a8aad9a717@intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sun, 07 Sep 2025, Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> Heh, looking at Sphinx doc at:
> https://www.sphinx-doc.org/en/master/usage/domains/c.html:
>
> 	.. c:member:: declaration
> 	.. c:var:: declaration
>
> 	    Describes a C struct member or variable. Example signature:
>
> 	    .. c:member:: PyObject *PyTypeObject.tp_bases
>
> 	    The difference between the two directives is only cosmetic.
>
> I guess the best is to encode it as:
>
> 	prototype = args.other_stuff["var_type"]
> 	self.data += f"\n\n.. c:var:: {prototype}\n\n"
>
> And let Sphinx format it for us.

In the same vein, I believe we should let Sphinx format everything else
for us as well. Function parameters should use ":param foo: desc" and
struct/union members should be indented within the enclosing
struct/union.

I also think we're going way overboard with including e.g. struct
definition in the output. I'd just chuck those away and maybe add links
to kernel git source for the definition instead.


BR,
Jani.


-- 
Jani Nikula, Intel

