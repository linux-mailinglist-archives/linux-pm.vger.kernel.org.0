Return-Path: <linux-pm+bounces-2027-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EFE82828CED
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jan 2024 19:56:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2270A1C236EA
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jan 2024 18:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E623063B5;
	Tue,  9 Jan 2024 18:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jIA/PY4i"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3275F3D0A0
	for <linux-pm@vger.kernel.org>; Tue,  9 Jan 2024 18:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704826600; x=1736362600;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=aE3ff8M+7qBQOh1HzGNJxIhpPkN57Xv7xJTB7yKAJRU=;
  b=jIA/PY4iYJKiiFi3oI4AB3FVtf3H8vUdWid3WtYXpg40quTGXVgApqwk
   ybriIx8Ze7iu9VxmAIoc5NE7LRCU+8bx2EXdKxZ2qvvW+TjHl84F6Xnnd
   rDa0zQDUrqEjzp+NpDaLWeetz5b8G55pkowwi9kItnPZOQ7PLWtxdQYpN
   QM/WQtj/i1wmhM4DDPHb9LDeRJV8W9rQpxbGCJXknz0QgZXHmb8jUFueT
   WVwy/U2qkiLR6d3Yp9prO+Swq4CIH1K+lbyGhnnUj7BoKgLPJRSOW8Ebc
   vr1wYXSei7lwlPE6NgUICOEhXZv5b/BVKkmQ9FRlTf2Rgsb8Yp3mrrfNm
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="484476249"
X-IronPort-AV: E=Sophos;i="6.04,183,1695711600"; 
   d="scan'208";a="484476249"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2024 10:56:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,183,1695711600"; 
   d="scan'208";a="16375921"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2024 10:56:38 -0800
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id 84D6711F8DE;
	Tue,  9 Jan 2024 20:56:35 +0200 (EET)
Date: Tue, 9 Jan 2024 18:56:35 +0000
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 2/2] pm: runtime: Add pm_runtime_put_autosuspend()
 replacement
Message-ID: <ZZ2W4-kYfNXQnkW_@kekkonen.localdomain>
References: <20240109133639.111210-1-sakari.ailus@linux.intel.com>
 <20240109133639.111210-2-sakari.ailus@linux.intel.com>
 <20240109164047.GB27655@pendragon.ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240109164047.GB27655@pendragon.ideasonboard.com>

Hi Laurent,

On Tue, Jan 09, 2024 at 06:40:47PM +0200, Laurent Pinchart wrote:
> Hi Sakari,
> 
> Thank you for the patch.
> 
> On Tue, Jan 09, 2024 at 03:36:39PM +0200, Sakari Ailus wrote:
> > Add __pm_runtime_put_autosuspend() that replaces
> > pm_runtime_put_autosuspend() for new users. The intent is to later
> > re-purpose pm_runtime_put_autosuspend() to also mark the device's last
> > busy stamp---which is what the vast majority of users actually need.
> > 
> > This is also described in pm_runtime_put_autosuspend() documentation.
> > 
> > Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> 
> This looks good to me, so
> 
> Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> 
> Do you plan to patch the existing users tree-wide ?

As noted on the cover letter, these are found here:
<URL:https://git.kernel.org/pub/scm/linux/kernel/git/sailus/linux-next.git/log/?h=pm>.

-- 
Regards,

Sakari Ailus

