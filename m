Return-Path: <linux-pm+bounces-2204-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 439D182D95A
	for <lists+linux-pm@lfdr.de>; Mon, 15 Jan 2024 14:00:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57B1E1C218E1
	for <lists+linux-pm@lfdr.de>; Mon, 15 Jan 2024 13:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C677171DC;
	Mon, 15 Jan 2024 12:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m2s6hzVu"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1CBF171A3
	for <linux-pm@vger.kernel.org>; Mon, 15 Jan 2024 12:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705323500; x=1736859500;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=hyOaAcSuzbO9KxDONBafxs8vR7M+/yAvNOjrZugu4vY=;
  b=m2s6hzVuI7CQO5x+ZuY3/k+Ey4Jac6tf+2YL9Nz1TJOT2VRGatS2f4YL
   SqOOlSzdjWmHQsm1sFRJGLbzG+5F31E6TIjzd5hotHSF5vv/QnvTO14xx
   gu4DcgJHlXOt8QAVARF25GEvVaIbjeYlQO1mTXw8RfGoz+l2MqDte/+Yc
   MdfXP8b56TAy5MB8/PVG7WtJaybf3KuTff5ehEtXZpg6Jfftr81i8pRzV
   w5JsJfgekjYkl2vf4utS719+5dryp+Q8mMOKMQXmecJOlBwLxy9+a/XCf
   1ouK4KMR/IyimOJqIAMrEUG127pmkX4wa7sI/eD4YX7u0Aehb2cpsFdCd
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10953"; a="463889948"
X-IronPort-AV: E=Sophos;i="6.04,196,1695711600"; 
   d="scan'208";a="463889948"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2024 04:58:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10953"; a="1030635059"
X-IronPort-AV: E=Sophos;i="6.04,196,1695711600"; 
   d="scan'208";a="1030635059"
Received: from pwlazlyn-mobl.ger.corp.intel.com (HELO [10.246.16.73]) ([10.246.16.73])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2024 04:58:18 -0800
Message-ID: <539e87e1-c2a7-4337-a178-b2dfd0aeeb8a@linux.intel.com>
Date: Mon, 15 Jan 2024 13:58:16 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] tools/power turbostat: Add --no-msr option
Content-Language: en-US
To: Len Brown <lenb@kernel.org>
Cc: len.brown@intel.com, linux-pm@vger.kernel.org
References: <20240112124815.970-1-patryk.wlazlyn@linux.intel.com>
 <20240112124815.970-2-patryk.wlazlyn@linux.intel.com>
 <CAJvTdK=NRSGz_1Mi_2-zLmqv4VeFiFF25Yw+sqeNLTV--r4TNg@mail.gmail.com>
From: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>
In-Reply-To: <CAJvTdK=NRSGz_1Mi_2-zLmqv4VeFiFF25Yw+sqeNLTV--r4TNg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

> 6.7 added probe_platform_features().
> 
> Perhaps after it runs, we can simply update the result to disable
> those impacted by no_msr?
> 
> platform->has_cst_msrs = 0;
> platform->has_nhm_msrs = 0;
> platform->rapl_msrs = 0;
> etc.
> 
> that would avoid having to scatter no_msr in a lot of places.
> 
> of course that begs the question of what to do when a feature is
> available both via MSR and via perf -- which is about to happen...
> 
> it also adds a place for us to make an error when we add a feature --
> but even if we had a table and a bit to say whether the feature is
> available via msr, we'd still have the opportunity to mess that up...

Right. I thought about it, but I didn't like the idea of modifying the
platform information, because of the reasons you outlined above, but
also we might have some logic, along the way that cares if something is
present, but not necessarily use MSR driver (or any other method) to get it.

With these changes, sure there are some no_msr checks scattered around,
but they are usually close to where the data is acquired, making it easy
to add an alternative path.

Modifying the platform_features would require to "unconst" a lot of the
structures.

I think it's more clear to store a platform information in the
platform_features and leave no_msr just to store whether the user
requested the mode. This comes with a few extra checks, but leaves the
structures independent.

