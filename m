Return-Path: <linux-pm+bounces-40212-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 88436CF4C31
	for <lists+linux-pm@lfdr.de>; Mon, 05 Jan 2026 17:41:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9759B3004EE0
	for <lists+linux-pm@lfdr.de>; Mon,  5 Jan 2026 16:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7168633F369;
	Mon,  5 Jan 2026 16:41:10 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5444024DCF9
	for <linux-pm@vger.kernel.org>; Mon,  5 Jan 2026 16:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767631270; cv=none; b=q2jsN9dUNf9GhaHxUyWglVVdGyPb49Lq4d/XGq+/szL7OaQWe16ApgE/EhM1DMD+sWq0ZRPrvbBKDoJX4ugdwWvMrQj6Sve98ZSRqjDjgBZEn1O9oC1qVzNuoFHuCp8deL86cuS17uQXG9XVgEkpDJFUz8+VbzhQYu14SenlwRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767631270; c=relaxed/simple;
	bh=TMLm26OuBnAHTALAzHGLrcPweP2kIlZy5syiZHCDa5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lIKIAQumB8H6/KWCzyVMGvys+XAfaZ+YHaTn72D7rPLuKM4WFnixJ9Ay6YD1Q0F8vxrymbfy7eBWhxrMJEzKhv9IO0tBfyRFkhdWV426d3+KujPrs+OpQuTyEtrqcGD47e2HxDbPw5GNKvb7EvkjtZe9qDBcJiPl/1iWyw/KFFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7c7533dbd87so99987a34.2
        for <linux-pm@vger.kernel.org>; Mon, 05 Jan 2026 08:41:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767631263; x=1768236063;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vxk0d5fp1ev1OLVNSeDlZ4p9oEopT3lz12yYdNgK0S8=;
        b=xQg7vhwV1Q1mAfM2mV5Ohxgqc1M5DJ9FjiGFNQJKg5Ab1400tqi53oukpXa/KvMy5R
         Mit6rAgJcjd/c3np0DRcE9oXprIJQBl4uW01z+5YIQlx+pBuyTyIr08GH1B8AjZwnOZl
         6H1txoq384UR7CyzCRZ/gowNnlexbaMIJPHY9utjvD1tEBy8uboIoGqsVZHYDnxjk9b9
         nz7J5ARn1pilC8oC1cPEB2YapFmNXE4OIeHdCfRE4wI6M3FAaz1xI9O79b54ng+9IeMy
         CUEMoAmEmiBaNshUQ2nuf4Le2Cw0HcZa2RxvtNDsGpPyt6HRO7qQQqMYmO2oDED9FpP/
         I1dg==
X-Forwarded-Encrypted: i=1; AJvYcCUUt41b44J5komxVkET5ejhrsYYM9x6f1Sad6pJAjVVdohQmkwPJx9hKHRQN+iJlqgA3OQdlZp8ZA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzAgwRcg63qCUQO5Jroc3ZRuGQlirj1TXj26QASAYe/b1n1eznQ
	8nwE7Q40Ee9Gzt6TrrY6vy+4C/iXQ5JxjFBki9/JAM2CWP2A6zlnsLc6
X-Gm-Gg: AY/fxX7C0jlFRppiorUv8/tdHSfQBvFBVEdx5v/QbYc5X40qQYUGKG/Lal+2GSxXaff
	2iiOYEEa8sXthQiQcuQTsMjz/mogc89X+c5xCWsBHVDhOwUR8+FXPvldQeUc3/skV27xNpXdfcY
	ew9f5VgvE3vXZKudp8Qy0w4V23SwwgV0RdnPxhL1Cf4uwM2m0nnWYEvHEjlZBksxIM/NOa0bl0j
	dI9wGnS2ox8sNf6HgbDKH88hMujbqWxi0Sf64sYy1Bjo3fGPP3PCqJsoVJab1uOITwkFB5de+j0
	W/3q4nW9KPH9yt6UghOkNa09qMmeNI5pBelIUMY6FTV+G4T+YspaEbr60nCysqIPiQTIexb1pXE
	GzUZZbuvzmLTAchZJK+HXoG0bMWZsHpAmlOg+kxbmAprhU+TeKHWiQ8KgfPhzDAf1QJTYFhnNkH
	qMq6BDzRK/hMKy
X-Google-Smtp-Source: AGHT+IGMYaVh69F2L70U1YfpLKbsmB59ZXz2Bt6iYAFEiGmuUND6Bo12GuMRcJHyl6mZ2mABlZYw1A==
X-Received: by 2002:a9d:5383:0:b0:7c7:51e4:1360 with SMTP id 46e09a7af769-7ce466c7bd6mr9852a34.13.1767631263477;
        Mon, 05 Jan 2026 08:41:03 -0800 (PST)
Received: from gmail.com ([2a03:2880:10ff:8::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ce45ffbeb6sm167097a34.22.2026.01.05.08.41.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 08:41:03 -0800 (PST)
Date: Mon, 5 Jan 2026 08:41:01 -0800
From: Breno Leitao <leitao@debian.org>
To: Christian Loehle <christian.loehle@arm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-team@meta.com
Subject: Re: [PATCH] cpuidle: menu: Remove incorrect unlikely() annotation
Message-ID: <izltvlkmxwk4txk7vz4td5ytx3p7itlmdqyawc75halhmt22dh@jt34fctgso2h>
References: <20260105-annotated_idle-v1-1-10ddf0771b58@debian.org>
 <73439919-e24d-4bd5-a7ed-d7633beb5e4f@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <73439919-e24d-4bd5-a7ed-d7633beb5e4f@arm.com>

On Mon, Jan 05, 2026 at 03:17:05PM +0000, Christian Loehle wrote:
> On 1/5/26 14:37, Breno Leitao wrote:
> > The unlikely() annotation on the early-return condition in menu_select()
> > is incorrect on systems with only one idle state (e.g., ARM64 servers
> > with a single ACPI LPI state). Branch profiling shows 100% misprediction
> > on such systems since drv->state_count <= 1 is always true.
> > 
> > On platforms where only state0 is available, this path is the common
> > case, not an unlikely edge case. Remove the misleading annotation to
> > let the branch predictor learn the actual behavior.
> > 
> > Signed-off-by: Breno Leitao <leitao@debian.org>
> > ---
> >  drivers/cpuidle/governors/menu.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governors/menu.c
> > index 64d6f7a1c776..ef9c5a84643e 100644
> > --- a/drivers/cpuidle/governors/menu.c
> > +++ b/drivers/cpuidle/governors/menu.c
> > @@ -271,7 +271,7 @@ static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
> >  		data->bucket = BUCKETS - 1;
> >  	}
> >  
> > -	if (unlikely(drv->state_count <= 1 || latency_req == 0) ||
> > +	if (drv->state_count <= 1 || latency_req == 0 ||
> >  	    ((data->next_timer_ns < drv->states[1].target_residency_ns ||
> >  	      latency_req < drv->states[1].exit_latency_ns) &&
> >  	     !dev->states_usage[0].disable)) {
> > 
> > ---
> > base-commit: 34aa263125b6732375abcb908d73d98169154bb5
> > change-id: 20260105-annotated_idle-d6b614ecd207
> > 
> > Best regards,
> > --  
> > Breno Leitao <leitao@debian.org>
> > 
> > 
> 
> Fine with me per se, I don't think the unlikely() annotation makes a
> difference for the 'good case' either, but if you run into this I'd be curious
> if you can see a difference with menu (which should stop the tick on every idle enter
> regardless) and teo (which should never stop the tick on state_count == 1).
> Alternative you can also just change the menu branch to not stop the tick.
> I'd like to know if we need something more sophisticated generally here.

Probably not. I am just running PROFILE_ANNOTATED_BRANCHES tests on some
production arm64 host and addressing those that are making wrong
assumptions.

