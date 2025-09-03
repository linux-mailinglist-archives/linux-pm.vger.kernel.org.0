Return-Path: <linux-pm+bounces-33771-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69094B42C30
	for <lists+linux-pm@lfdr.de>; Wed,  3 Sep 2025 23:54:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15B8A4854DE
	for <lists+linux-pm@lfdr.de>; Wed,  3 Sep 2025 21:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC7FA2EB84B;
	Wed,  3 Sep 2025 21:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="ZxF5ALnS"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB7902AE77
	for <linux-pm@vger.kernel.org>; Wed,  3 Sep 2025 21:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756936458; cv=none; b=cx5zxW6yOKx1/84WFgQDD+XLp8GbQ9Abq5CYlVXO9SqQ+eBLncVqOhoLCyn+vHGHqs4itszxMytoqxm2EC3qX6QPbwHgQErI4fNjqOkCoieJ6WERRTg2GNiNhSHS8EQXTKSGZJ8L+YiUM6I47+H7OX1UIYOMzgOcMEFd5OjjST0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756936458; c=relaxed/simple;
	bh=tswpR0eGqHosqIn747IEZC9EzPHFnq+U1jAp/krTHUE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VUlbUEq/sulk4b0dG7GCQeFnlwga+XqbPHTOBILMqQFp4f9Uob8Loji7nT+doNGa5UWb9FpYEaUhgN3BaJ+8IlkBQ4f0uTKkyYvupMbVz6NnwAth/vTit+lJVf/fRAC7POYaQVODPYYuYuHTdS0NVxtAMhNiEMfrPGpMcjkzmkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=ZxF5ALnS; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7f901afc2fbso37157285a.0
        for <linux-pm@vger.kernel.org>; Wed, 03 Sep 2025 14:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1756936456; x=1757541256; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iWRgOnL0eoFk2ynixMqxAVyWo1C3OiiDh4wrpd6Cmnw=;
        b=ZxF5ALnSUUaShuhYrRlDUZ4Q3HhPIxoE90rDO/IkgM0bxi5+uBH9eHjZwDZ7iuANY2
         HYoeusXOpjpPlAX/PFyFjQreU17Avex88jDg06CQxWnCqdiPr+sc9KinyyLmFBsbXpd7
         8nSrsEhwOIfrvhcxlbSYVNj6pmRvZnS07n6d6fuPqaENlc+uxPIRCb11aMgLyZVqIfRi
         H4Hvx3QzNjDqyXmBw7b7+PexBu4+kC+Qge46c9krKBIFPg1yUK8p4kAdLoom07XH5RU7
         jmPjIeu0JAyYiJXYYO3HqCz9dSqWKgXrztxpb3aTQrgCspq4L7FUG1xX0PYKVw8ppHr7
         oGeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756936456; x=1757541256;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iWRgOnL0eoFk2ynixMqxAVyWo1C3OiiDh4wrpd6Cmnw=;
        b=mFDUTqnNSWETPy09yDiG6GrWYFjG2ARRpueNCDwogZzyXyGQQHcOA+G4WSnRywIYAu
         EMTcpZi8/VVfipNE84WjdawHq9uWICvetFmn/jAOWRgPqnBUeTWBXC/y8pMJuB5mg/lC
         uztg+lhB0Xa0cnKUUl3yOfiJwKno5jr0JoEEaqgI4k0e9h5w2jGU7nMYEGTTrxCIDLo1
         vjaEwOB939/0/JIKwgAhIL3D12NKQKycLmHC3SQ0B90G0nD3uvLa5/XG91lCFW1SdNXk
         1AREr+mSR3m1RbZMo/7RwTtIJMBxkVy0kvKrrJ26wMtxU5jXwG26o2CZHg4omk7bhtGB
         /mlg==
X-Forwarded-Encrypted: i=1; AJvYcCVgOPiVz/TAQ70yF7sqlxE/FDw4Jx/8V5yuh8e4BqLog+kU1t4+xan396Qpw/c2mPEvBVAEryZZIA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyMCsriqDyTIS0Wbukz1FLMwgIawHmyOd3lNGcoEXmuA949Uxm7
	kzXyZflS0vn0l1pThzBJpBAmy2pfhWAWN59y+2T9yboNVa2xbGghO/LH0WL92HQ3yA==
X-Gm-Gg: ASbGncs1w7HPUTD0FKSTLDJO8recACNaFdYs13xxYb+vew+dktrBMxZf4jbAghozxYg
	vZInpN8H4/4zkkidzp44hEisUcau4ifRfWEZjCA1gmMqh/9rqcUdpXRxAhNRriJhpqCWW++gyd5
	f9PIN3GaHzfGBs2btFO6Cs+syqrOCXjRAGfFLgMtvG2mnWSG3AfwnBHrXZcP60MZO4aTDBEOuB7
	PorI3qUGmiBjUefwTEOGDBDly1/X8uzEYSnjjSPNvF5JWL1yMmE5oE/MEAKbo6Z7BgzCQ3+sX8X
	/K1dHwwEeIsnxtrefpTfajm2n4WYNcPTNRv+prU2/FBQc8DNXKdy1W5ZphueUUlPMbF76O2uJ8s
	ztN3Pz+8RXdlQCmtRKNHPbanc1dtV5g95jijexXTM
X-Google-Smtp-Source: AGHT+IE8dw4k/KGdYZTX/v7KzznvvPVdvFeyTtaQcGhN2f5ubQ2hCe5z/yb9tY8RXq8ykcDEwkDi1Q==
X-Received: by 2002:a05:620a:450b:b0:7f8:dc79:317c with SMTP id af79cd13be357-7fed2f47b4amr1752914885a.11.1756936455749;
        Wed, 03 Sep 2025 14:54:15 -0700 (PDT)
Received: from rowland.harvard.edu ([2601:19b:681:fd10::207])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-80af4b3bda6sm155836585a.39.2025.09.03.14.54.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 14:54:15 -0700 (PDT)
Date: Wed, 3 Sep 2025 17:54:12 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	ryan zhou <ryanzhou54@gmail.com>, Roy Luo <royluo@google.com>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: Re: [PATCH] drvier: usb: dwc3: Fix runtime PM trying to activate
 child device xxx.dwc3 but parent is not active
Message-ID: <59951c2d-60e8-47a8-a43c-00b92e095043@rowland.harvard.edu>
References: <5d692b81-6f58-4e86-9cb0-ede69a09d799@rowland.harvard.edu>
 <CAJZ5v0jQpQjfU5YCDbfdsJNV=6XWD=PyazGC3JykJVdEX3hQ2Q@mail.gmail.com>
 <20250829004312.5fw5jxj2gpft75nx@synopsys.com>
 <e3b5a026-fe08-4b7e-acd1-e78a88c5f59c@rowland.harvard.edu>
 <CAJZ5v0gwBvC-y0fgWLMCkKdd=wpXs2msf5HCFaXkc1HbRfhNsg@mail.gmail.com>
 <f8965cfe-de9a-439c-84e3-63da066aa74f@rowland.harvard.edu>
 <CAJZ5v0g9nip2KUs2hoa7yMMAow-WsS-4EYX6FvEbpRFw10C2wQ@mail.gmail.com>
 <CAJZ5v0gzFWW6roYTjUFeL2Tt8kKJ_g5Q=tp2=s87dy05x-Hvww@mail.gmail.com>
 <38b706cc-5966-4766-9165-51935fdcd790@rowland.harvard.edu>
 <CAJZ5v0h=i9XF_SQMOhz3P+4SAH3Qy-r1oUiiw7Bp=PcRnJjVbQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0h=i9XF_SQMOhz3P+4SAH3Qy-r1oUiiw7Bp=PcRnJjVbQ@mail.gmail.com>

On Wed, Sep 03, 2025 at 09:30:47PM +0200, Rafael J. Wysocki wrote:
> I personally think that it would be reasonable to simply preserve
> device states in error paths unless they have been changed already
> before the error (or suspend abort due to a wakeup signal).

The problem is complicated by the interaction between runtime-PM states 
and system-sleep states.  In the case, we've been considering, B changes 
from runtime-suspended to runtime-suspended + system-suspended.  
Therefore the error path is allowed to modify B's state.

> By this rule, B would be left in runtime suspend if it were still in
> runtime suspend when the error (or suspend abort in general) occurred
> and then it doesn't matter what happens to A.

More fully, B would be changed from runtime-suspended + system-suspended 
back to simply runtime-suspended.  Unfortunately, none of the PM 
callbacks in the kernel are defined to make this change -- at least, not 
without some cooperation from the driver.

> The PM core can do something like that for the drivers opting in for
> runtime PM integration assistance, so to speak.  That is, drivers that
> point their ->suspend() and ->resume() callbacks to
> pm_runtime_force_suspend() and pm_runtime_force_resume(),
> respectively, or set DPM_FLAG_SMART_SUSPEND (or both at the same time
> which is now feasible).  Otherwise, it is hard to say what the
> expectations of the driver are and some code between the driver and
> the PM core may be involved (say, the PCI bus type).

Setting DPM_FLAG_SMART_SUSPEND really does sound like the best answer.

But there still should be some way the PM core can make resumes easier 
for drivers that don't set the flag.  Something like: If the device is 
in runtime suspend with SMART_SUSPEND clear, perform a runtime resume on 
the device's parent (and anything else the device depends on) before 
invoking ->resume.

Alan Stern

