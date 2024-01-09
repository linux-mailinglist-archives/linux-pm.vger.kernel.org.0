Return-Path: <linux-pm+bounces-2017-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D915C828B32
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jan 2024 18:24:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3612A288370
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jan 2024 17:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1C033B290;
	Tue,  9 Jan 2024 17:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oAVJ3Vki"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689403B78B
	for <linux-pm@vger.kernel.org>; Tue,  9 Jan 2024 17:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704821011; x=1736357011;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=dQ/zjNa5R1aGqolilaWfdhz/3U3vkl1yq6Hgrj/XWUw=;
  b=oAVJ3Vkiqej6grCxdeo3iJxn9xYri4+eLBjXG7yzyaRLUiac6etvH+CJ
   uWanMX00BYYtq4YQk1LvkRfjRjozdKVTdQjyCW7lVsNKyQZ4hm5qrK/7T
   qFOeL4e9pIB91qriQ2q3NZ9+1S1lSlBtqGKWYLlFjs9mxUKeuBlypj6ag
   C+RBigmq9d9qqjsAGhfAKanb7YZGCeh1wZVaPfmTBxOzggoghWI+Iqxi5
   NirvRKreVMCI+UUSdngjlUZqOaSgr+mB9z5W/sSAlcPPNAG/Oxr47UrEs
   zZfMrplN56OFuw55tF1rrfhg9kuGWPC2t7QZrL6jiX5VAeKdm7rIrufyf
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="19770940"
X-IronPort-AV: E=Sophos;i="6.04,183,1695711600"; 
   d="scan'208";a="19770940"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2024 09:23:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="758056922"
X-IronPort-AV: E=Sophos;i="6.04,183,1695711600"; 
   d="scan'208";a="758056922"
Received: from jlawryno-mobl.ger.corp.intel.com (HELO [10.249.150.128]) ([10.249.150.128])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2024 09:23:24 -0800
Message-ID: <b4ce475f-614f-4596-965e-1e2d87176bed@linux.intel.com>
Date: Tue, 9 Jan 2024 18:23:21 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] pm: runtime: Simplify pm_runtime_get_if_active()
 usage
Content-Language: en-US
To: Sakari Ailus <sakari.ailus@linux.intel.com>, linux-pm@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 laurent.pinchart@ideasonboard.com,
 Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Lucas De Marchi <lucas.demarchi@intel.com>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Paul Elder <paul.elder@ideasonboard.com>, Alex Elder <elder@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Mark Brown <broonie@kernel.org>
References: <20240109133639.111210-1-sakari.ailus@linux.intel.com>
 <20240109133657.111258-1-sakari.ailus@linux.intel.com>
From: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298
 Gdansk - KRS 101882 - NIP 957-07-52-316
In-Reply-To: <20240109133657.111258-1-sakari.ailus@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 09.01.2024 14:36, Sakari Ailus wrote:
> There are two ways to opportunistically increment a device's runtime PM
> usage count, calling either pm_runtime_get_if_active() or
> pm_runtime_get_if_in_use(). The former has an argument to tell whether to
> ignore the usage count or not, and the latter simply calls the former with
> ign_usage_count set to false. The other users that want to ignore the
> usage_count will have to explitly set that argument to true which is a bit
> cumbersome.
> 
> To make this function more practical to use, remove the ign_usage_count
> argument from the function. The main implementation is renamed as
> __pm_runtime_get_conditional().
> 
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> ---

For drivers/accel/ivpu:

Reviewed-by: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>

Thanks,
Jacek

