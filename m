Return-Path: <linux-pm+bounces-20829-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D807BA19EF3
	for <lists+linux-pm@lfdr.de>; Thu, 23 Jan 2025 08:28:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BD57168A70
	for <lists+linux-pm@lfdr.de>; Thu, 23 Jan 2025 07:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61F5920B7E7;
	Thu, 23 Jan 2025 07:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jkgNbWKU"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CBFD1C1F0C;
	Thu, 23 Jan 2025 07:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737617274; cv=none; b=Ig0vWJHmBUGjMbl2yePm4GCWn/Qciatbi6DtXttJX1Arv9onnW9Gq2DExwTuep+CWEMx36LHqfWXM5QIDPBfkN/CzX22m5NH5i3GWvX5JsGMc3EdJ7kWPfapAVvNm6J4gaZIFmWINJckvFx8sp33UXhjvmCUCKX9lhiI5G6YIuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737617274; c=relaxed/simple;
	bh=gdr9OSLvfa/rDxAwNiHVCieR3Q9qH1tE8U7hPjzIo2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JENeVJsL0J41+Pij56VWDpg2+8cCaKcjwX1RsncPeU88YrcBOxBYhDvlG3gi6WDD+WZpW2RPabo4ON+EEBPnIPeCDs6xaKwJMowrX8l4gtIhWKVboZBhSN9n/MopORWrSeFFO1+aALlOGHoKj4VMusqbaYVwHYTDq1J14R7Imno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jkgNbWKU; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737617272; x=1769153272;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gdr9OSLvfa/rDxAwNiHVCieR3Q9qH1tE8U7hPjzIo2Q=;
  b=jkgNbWKUeD6pFnqsALkJE8mw2NP+7J17aJ6oThW7DVNRA63vIciV0MY4
   HMnD2S+sk6iuiDXL3bH0ZjFWwk8bQoTHrwsofmMtgxRmZVf2PC34+dPF5
   J2cuviuB78FJ/mCqU2i1XA4MUc3mA6hJhaRCkBFnEyAeVsm1ub7+zV64Y
   wXIBWeQSN7LNy58vHHLyWLLWnkJzdQfwBRKorLYiRYZcrC+HC5RtsZth+
   j+9F1jYjX5FuHMjJBogVRIJhKShoJsmQXo9efRB0xwuJQX9LH6AyMjrv8
   JtKVwkQBlGLsuhJuuBULln818aCwGF8anDb42FAmJY+nO3oJXA2Aw2QSG
   Q==;
X-CSE-ConnectionGUID: Xfu0ECBOS5i5Aff/kUeexQ==
X-CSE-MsgGUID: OFf7UllpTme6hs4HvGeh0Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="38206719"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="38206719"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2025 23:27:52 -0800
X-CSE-ConnectionGUID: 4VXT0TrlRmmXcoj/lpPvJw==
X-CSE-MsgGUID: qDTHyeruT8CCrMlh51oj/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="107233295"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2025 23:27:48 -0800
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id 2C27611F95E;
	Thu, 23 Jan 2025 09:27:45 +0200 (EET)
Date: Thu, 23 Jan 2025 07:27:45 +0000
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Linux Media <linux-media@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Block Devices <linux-block@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Power Management <linux-pm@vger.kernel.org>,
	Bingbu Cao <bingbu.cao@intel.com>,
	Tianshu Qiu <tian.shu.qiu@intel.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	Jonathan Corbet <corbet@lwn.net>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
	Rajmohan Mani <rajmohan.mani@intel.com>
Subject: Re: [PATCH 1/3] media: ipu3.rst: Prune unreferenced footnotes
Message-ID: <Z5HvcW2WXibhsTgm@kekkonen.localdomain>
References: <20250122143456.68867-1-bagasdotme@gmail.com>
 <20250122143456.68867-2-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250122143456.68867-2-bagasdotme@gmail.com>

Hi Bagas,

Thanks for the patches.

On Wed, Jan 22, 2025 at 09:34:54PM +0700, Bagas Sanjaya wrote:
> Sphinx reports unreferenced footnotes warning on ipu3 docs:
> 
> Documentation/admin-guide/media/ipu3.rst:592: WARNING: Footnote [#] is not referenced. [ref.footnote]
> Documentation/admin-guide/media/ipu3.rst:598: WARNING: Footnote [#] is not referenced. [ref.footnote]
> 
> Fix above warnings by pruning unreferenced footnote to intel_ipu3.h
> UAPI header (already referenced in its full path in "Running mode and
> firmware binary selection") and by directly link to v4l-utils repo in
> ov5670 configuration example with media-ctl (since the example is in
> literal code block).
> 
> Footnote numbers are unchanged.
> 
> Cc: Rajmohan Mani <rajmohan.mani@intel.com>
> Fixes: dc794d3d2424 ("media: staging: ipu3-imgu: Move the UAPI header from include under include/uapi")
> Fixes: 34fc0e1bf892 ("media: doc-rst: Add Intel IPU3 documentation")
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>

The issues fixed by this patch have already been fixed in commit
688c0a6907a7c6e6776f314195c10536f249b37f (in media tree).

-- 
Kind regards,

Sakari Ailus

