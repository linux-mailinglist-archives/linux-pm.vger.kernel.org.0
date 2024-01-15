Return-Path: <linux-pm+bounces-2194-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAF1E82D758
	for <lists+linux-pm@lfdr.de>; Mon, 15 Jan 2024 11:28:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0631282270
	for <lists+linux-pm@lfdr.de>; Mon, 15 Jan 2024 10:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8464101C2;
	Mon, 15 Jan 2024 10:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JJ2W2ztF"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390BB101C1
	for <linux-pm@vger.kernel.org>; Mon, 15 Jan 2024 10:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705314511; x=1736850511;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=8XFNEOiyDh/WE6l71Fz8dJ9+yfoDeTyvN2io9Qc/7B0=;
  b=JJ2W2ztFK7WCTK7XDuD0jh7bR4oaXycXuwiIcH2YkISrnfyx0RHrpKQM
   60r0TyqyS9NZkWD1yG4N136h0mmN2a+sQ+hR7mtjGvp2k0co9jgxeRTdT
   E5kBMqEZ2t670uCN35aag2Fop+8W9tFBLm+h81/DRa6H6NhMUweasXYnB
   S0L9DDMfYPXVh1FOerk1FkODc6ZTP5jQvTjFshGkbvs1DF92cNZLd9c0Z
   qN6yFofEwMBx0swu9mZ8ClDkv5XgDGGUpqoB8l8u2y2BsO21nbfLlH8py
   axahE8ZQu3lTHjJIUaOoMT3NOphCtrNNm0w7JnF1NYkXTKSlQ0cqIB2Qf
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10953"; a="390034676"
X-IronPort-AV: E=Sophos;i="6.04,196,1695711600"; 
   d="scan'208";a="390034676"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2024 02:28:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10953"; a="1030601924"
X-IronPort-AV: E=Sophos;i="6.04,196,1695711600"; 
   d="scan'208";a="1030601924"
Received: from pwlazlyn-mobl.ger.corp.intel.com (HELO [10.246.24.219]) ([10.246.24.219])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2024 02:28:29 -0800
Message-ID: <be5911d1-5364-48c5-aefd-9f37e56feefd@linux.intel.com>
Date: Mon, 15 Jan 2024 11:28:15 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] tools/power turbostat: Add reading aperf and mperf
 via perf API
To: Len Brown <lenb@kernel.org>
Cc: len.brown@intel.com, linux-pm@vger.kernel.org
References: <20240112124815.970-1-patryk.wlazlyn@linux.intel.com>
 <20240112124815.970-5-patryk.wlazlyn@linux.intel.com>
 <CAJvTdKkX8LAY5ZOzodzJWS3hafaF5094s1aRNsxXMh3Xfky8jg@mail.gmail.com>
Content-Language: en-US
From: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>
In-Reply-To: <CAJvTdKkX8LAY5ZOzodzJWS3hafaF5094s1aRNsxXMh3Xfky8jg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

> When this patch is applied (on top of the --no-msr patch), then with
> --no-msr, we should still see Busy%, Avg_Mhz, Bzy_MHz, and IPC -- but
> we do not.

That's true only on some platforms, unfortunately. It's because, to get
the tsc_tweak we need to read an MSR. That being said, there are
platforms that do not require the tsc_tweak and I got it working, but
after rebasing I must have left too many bits in the
bic_disable_msr_access() and now we are being "too conservative" about it.

Will fix.

