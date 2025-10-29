Return-Path: <linux-pm+bounces-37051-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BE41C1BB67
	for <lists+linux-pm@lfdr.de>; Wed, 29 Oct 2025 16:39:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB7A61895686
	for <lists+linux-pm@lfdr.de>; Wed, 29 Oct 2025 15:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C0B02F6924;
	Wed, 29 Oct 2025 15:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="acl3aMc7"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A942F5A32
	for <linux-pm@vger.kernel.org>; Wed, 29 Oct 2025 15:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761752343; cv=none; b=gbTRWg4gk8J2ZTs71Nw1ad96agZq42RkoVhqH//jIEkPeQ5QmlFLfc8ID3fz7rNpPBuDC06i5VwL9QwnlyQc9fZC9aNa+Bg8MpN1kBSIoivULWbO7z+E7C20PNZ5OkGlJ8CUyA+I+YvXlwKcHuzxlffYqexDk4qpkz0Ooo0Fb68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761752343; c=relaxed/simple;
	bh=Zw9Abyl2gi+Yxti27ETWddwvP2cLZARrh4XjUeuUrG4=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H/VTiBwLE/OVgy4V6mn6AvpV8pF24YlPJQ9N2e4SRAcoaGR8ARY70DxsSGi0e49Bt7FeHS6t5Db2TIZQKYcCjErBcsC0QtEOsQ08gVE9iXQJLzL2MLtpuxtsV6BcnE0q4xxC+fKEtn6wRJ7HIhIWbEJnzIT9de5YrPUfX+NgB5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=acl3aMc7; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-47112edf9f7so49333955e9.0
        for <linux-pm@vger.kernel.org>; Wed, 29 Oct 2025 08:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761752340; x=1762357140; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=G/SkdXpdQ2mlM7MBq3PkE7aXo/4arz2IJ0OU1Ygc0S4=;
        b=acl3aMc7R33B1Ggd25dH8hebrv90bObJjLzkHPoM94n/6dJ76Lk9bVLDJXzIAGJYlQ
         9TlSNDg3qZyBWpe3q5nsrXIqZgIYcgSIh7GLXubh2clDTJF6vxpO7ULxp5KxJ0ABjQ4V
         xh3poVOq+vQojsz8qgnTh2oVDaDfX+b3a6OtPAeurGoHtYYU416iG6dFws+MWToCjQ4q
         y+TB74nxOFYYyVa5MGrv/ZWoz1REjgKaGGYBfdMIN+D2Bs8V/fPKnRxISy6P3Uhi7/F2
         PnR0PWaIYClWLBojzQs0BcOlAVfkH1PSyqoFRjsJyxbvtSg6Eq9VwpVNlyCt7rp84pW4
         +uAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761752340; x=1762357140;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G/SkdXpdQ2mlM7MBq3PkE7aXo/4arz2IJ0OU1Ygc0S4=;
        b=j8syvlmEsSv/HoRSdyjaHOxi9dlWg8DC9nkYkjXXYxv3YYv1iNtjgt3I4aiadWeSDh
         XHiZr18KwdKT0cTtxURzVVPpUkIN38HAUC6Y9OLbw1E6LVrX8Y6gD96tUfHoMSrxzwV/
         KRkiCfPFJfWzpU0r6S5HaZyPIQZ7dZHDyUFK6YK2XO/Wu20rimtVUUqzJmgEOJs4nelG
         qpwAzueSWQEbWimZH++MqjHVK+I8SaChK2LXYtyGBwdTBpReTYoI1LwSf8ZHmLVf/Op/
         DWRln+ksw0LWULw/pHLmx3rA+BDzDHcSNjyXwUXyGjxtBP+sUt4TH53TldlT4rvyl8UU
         WViA==
X-Forwarded-Encrypted: i=1; AJvYcCWL8/CX8yrVqDu1hlfmLHJZ0U+h0RhkwRQIza/pXDYyzAZBSUFfInPJgAsu5kF6U4iO3RD6xDeZow==@vger.kernel.org
X-Gm-Message-State: AOJu0YyH0noQmDs911r4UvA3hsB4z4QDZCuCx9lsJFSZMp2Mci39JshO
	3E57y0DbaSa5H9bLm1JLyH+pNdpSlI+ALdt6/btRi/HcliFnuVEQCbP6
X-Gm-Gg: ASbGnctT7IGt5YQGtmjMyLOYFTRXfT0umRODnh1Lh+08JIoaGIsJa9yk7qS3GNL1moP
	FGypJjQPTNJV9aKl7XNfS5pK4HnYelJWmeKKl8DSjtzmhYOe1F7NerPULLYde4V2DDf03v5lF9A
	uezt9/sbFvI1tQpjkKkspuiB4upKc1bILvtmOhF4lbg/4ykca9CswsCv/H/TTMXpGXjUPgNaeNL
	kk/yTwXfQ9xLnLNXau1VSUFETbIFLxFfZk/bfQ4tgFQXg1y/1YJYBhjMH/TP242HYMPT16mUGFW
	3FRfQYuNU2fcltbT/MIHwzGwuh2xJB435uNaKFUt5CmCd+g/dCRjkRYck/6VOLFnRGJk+OGIRhg
	9Pu3CQWAafBru+yEMRg+zWcrUML0QYZELCAnN9s/HdWwtJQixtk8ySmHhhbhaTk1+Wru7kEDcXQ
	04WQJX0462h4s0ry4fWDeO43i/bGFV
X-Google-Smtp-Source: AGHT+IEzD+uGSug6873FGiGzyiOsrvPNmJnfAKGaP1jUpjdYCDVFQsBwG2AhSPlYElGJj06L5fCBdA==
X-Received: by 2002:a05:6000:1a8a:b0:428:3be9:b465 with SMTP id ffacd0b85a97d-429aefbe046mr2473566f8f.51.1761752339128;
        Wed, 29 Oct 2025 08:38:59 -0700 (PDT)
Received: from Ansuel-XPS. (93-34-90-37.ip49.fastwebnet.it. [93.34.90.37])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952de4a1sm27473610f8f.37.2025.10.29.08.38.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 08:38:58 -0700 (PDT)
Message-ID: <69023512.5d0a0220.3cccb7.8e65@mx.google.com>
X-Google-Original-Message-ID: <aQI1DSo99grsrFdk@Ansuel-XPS.>
Date: Wed, 29 Oct 2025 16:38:53 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Ilia Lin <ilia.lin@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Raag Jadav <raag.jadav@intel.com>, Arnd Bergmann <arnd@arndb.de>,
	linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] err.h: add ERR_PTR_CONST macro
References: <20251029133323.24565-1-ansuelsmth@gmail.com>
 <aQIzoGnvZWYuHuoQ@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQIzoGnvZWYuHuoQ@smile.fi.intel.com>

On Wed, Oct 29, 2025 at 05:32:48PM +0200, Andy Shevchenko wrote:
> On Wed, Oct 29, 2025 at 02:33:19PM +0100, Christian Marangi wrote:
> > Add ERR_PTR_CONST macro to initialize global variables with error
> 
> ERR_PTR_CONST()
> 
> > pointers. This might be useful for specific case where there is a global
> > variables initialized to an error condition and then later set to the
> > real handle once probe finish/completes.
> 
> Okay, this has two caveats:
> 
> 1) naming is bad as it suggests something about const qualifier (and not, it's
> not about that at all);
> 
> 2) it doesn't explain what's wrong with ERR_PTR().
>

It can't be used for global variables as it does cause compilation
error.

I wanted to use ERR_PTR to set the __smem handle instead of freecode
(void *) -EPROBE_DEFER and notice the compiler doesn't like using
ERR_PTR().

Then the problem is clear as static declaration require constant value
for initialization and ERR_PTR is a inline function.

This is why ERR_PTR_CONST following the pattern that was used for
FIELD_PREP -> FIELD_PREP_CONST that was also introduced for similar
case.

So yes this is specific for case of static global variables.

> ...
> 
> Note, I'm not objecting an idea as a whole.
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 

-- 
	Ansuel

