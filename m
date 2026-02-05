Return-Path: <linux-pm+bounces-42112-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QHBTJFoChGk+wwMAu9opvQ
	(envelope-from <linux-pm+bounces-42112-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 05 Feb 2026 03:37:14 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E5770EE029
	for <lists+linux-pm@lfdr.de>; Thu, 05 Feb 2026 03:37:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 58928300B9D8
	for <lists+linux-pm@lfdr.de>; Thu,  5 Feb 2026 02:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF1A32BE7B1;
	Thu,  5 Feb 2026 02:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KImo6pu+"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7709C29E116
	for <linux-pm@vger.kernel.org>; Thu,  5 Feb 2026 02:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770259031; cv=none; b=YPE0Plk5Z8HwXahykbmZkHN3CnY3i1AZF2DphoAOB4MK2GLjXhxxJRbRVhx8OXpx1JfMnwmyOKLcIRl7aDh99sdbyvXeLyyPdz6/6x0hdHxShLQI4Uka5Rp+UVKUWJTw4AxoCOPIZOM4Hg8yROzxjxO/4d5mbU/NwWifeYlL61k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770259031; c=relaxed/simple;
	bh=H8Kfzx9Lp7I6MDK4SPAtfArOuUFA6D2GabWF6wYG2GE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YiyqaUGNVLNpVHa5a6xEEb1Evw+mepeIuBkSHW9EGY01hfp/XqXSPFlZlkchgnjH3uqJu+viNKCUDQl8cnaIxcLhjLiRZx5GE/xX/bxo1UrOdr4+37aYwg51qlzNpJaO8LI0Hbdn6ojfBO7AF2bjuBu8MDGvHLWL6+/QyQVxozk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=KImo6pu+; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-81f4e136481so252540b3a.3
        for <linux-pm@vger.kernel.org>; Wed, 04 Feb 2026 18:37:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1770259031; x=1770863831; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9auqBzyZROG6PYPSiRaEXLsqMErIrz1GCxdJvW2tYdk=;
        b=KImo6pu+vkybr8iRAu4/9lK30g0dzu8LrJAdqnoAOF9yB5/e29HC70oI3IEyjtvdQq
         ZflK088sPC7om1LhT47YQc7k8mQaLKeFT2XmOHxP4iCZeGk6YpkoTuAo8kvt1sk7xlBB
         VkRiwIC5JyfSidDvbWHk7W/9+2GCkL4+rrMms=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770259031; x=1770863831;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9auqBzyZROG6PYPSiRaEXLsqMErIrz1GCxdJvW2tYdk=;
        b=jqgmby8urD2o2s1cfpXFsoGH1+orEWL6fHVydyBhKRAKRfOTLe9SeSXBnjuBG4Uhw8
         zBWXz2Z978Pqfz82kiE4VnKobHDcRXK8ldCVyqaPe11AdcITy7mGrq/c1cTfS0CWxKJb
         T6MvGv/Xn6GnB4J/Et0n6hlw1cyR/m8/sMO2PdYycwMUjEcAPmZI2MGIKq1LoTBX2VY4
         /mNBAabPWF0T7pYaq1c//Piv9O6FIqk4iG0266tb7gJOFAgPMIr7XlzS++c/LjFnew86
         KihyOG6ziV/k9r+npAKY1/wGay8kQ1tooy6ghxObixJqSqemsrn5HwY8K6bwxvYWAvr1
         aEhQ==
X-Forwarded-Encrypted: i=1; AJvYcCXNAoTf2HnkGmV1ugjT7iQUg8EhFJ0qPlE/DqpjyKV0v1Vnpyx+sE1ExLZk+JoTXm39QMAfnrC90g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5YCw3zAnnUIu9BLpO/Hyy6v9cN890oMwPQNHgeFahxb7k3JUs
	am3xcCayv/Po1z/te3tq1CBfzpexf1fw7+oFW30b5xc2UqZRcfkSGP9GIone7/syZQ==
X-Gm-Gg: AZuq6aISUZZL2rfjS82UHdJr+B78xlBr3wcdcMSl5mm6xe7qcuSErScrQ27yZpCxf84
	p6/gxGJwFm78TpKaLNKgpyK6sDrpO6OUS4Zb3w+ESH/ptmPW3m2EsQ7nTmTqw1vV/yqsLkgk5rg
	C28Mzx1lqOXHrmieTJcOfm6Th2+oZtxcL3/LM9hzaZFvqIqp5wWg69UBqd3YC8WyB7yiHseBn8c
	ljojVUcB9YBwCqx9xNFB0HxZNsUFsH94JIUykMzOat3SMiFdAF1g6gUZhbM0ixPQWzF5B5ksxO9
	b4hzK+Yd9q5M4fCBd6ZCi5Xms6L0a5MYGw/RUFLT3vNpB3/sI+epqIGZNY+zVLb+d4NuYYr+2iv
	arruWuYSuVcVRAPHabmiVkpmNf4qxkf1Zj93le6Yq8f6tZEPxkyvm4EtVeBUfp7oww9cWCZN8IA
	/Ubq7MA/xJSikmlAJBfF/CaYLwtZRTRydRZ8a3HJRsp6C8x/ZIotmrNptj7eWHpg==
X-Received: by 2002:a05:6a00:3a14:b0:81f:852b:a939 with SMTP id d2e1a72fcca58-8241c6a6532mr4516101b3a.63.1770259030797;
        Wed, 04 Feb 2026 18:37:10 -0800 (PST)
Received: from google.com ([2a00:79e0:2031:6:76ea:a716:1eee:9fa9])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8241d16a9afsm3689132b3a.5.2026.02.04.18.37.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 18:37:09 -0800 (PST)
Date: Thu, 5 Feb 2026 11:37:06 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Doug Smythies <dsmythies@telus.net>
Cc: "'Rafael J. Wysocki'" <rafael@kernel.org>, 
	'Christian Loehle' <christian.loehle@arm.com>, 'Harshvardhan Jha' <harshvardhan.j.jha@oracle.com>, 
	'Sergey Senozhatsky' <senozhatsky@chromium.org>, 'Sasha Levin' <sashal@kernel.org>, 
	'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org, stable@vger.kernel.org, 
	'Daniel Lezcano' <daniel.lezcano@linaro.org>
Subject: Re: Performance regressions introduced via Revert "cpuidle: menu:
 Avoid discarding useful information" on 5.15 LTS
Message-ID: <m7pzdjfjcm2gr4gpru3rk26o2wn5iarihff6kz3o7n3slsvonx@k6jkyemuywgk>
References: <004e01dc90b1$4b28f9e0$e17aeda0$@telus.net>
 <002601dc916e$6acbe650$4063b2f0$@telus.net>
 <CAJZ5v0gcSb_6QPMfHkjSMJ6OOF+PaCZrUKOafYQ++tHE2jBB4w@mail.gmail.com>
 <3b0720d2-9b72-48d0-998a-1fd091cec44f@arm.com>
 <5d4b624c-f993-49aa-95ab-5f279f7f6599@oracle.com>
 <8fd5a9d4-e555-4db1-aa02-8fe5b8a2962c@arm.com>
 <3395ad0b-425e-40f5-844c-627cff471353@oracle.com>
 <3f0cfac2-b753-413c-9a7e-0892c23cdbf4@arm.com>
 <CAJZ5v0j+jfTHog+rVO0816mofk7nSSKCt7dbwSa2QCpYSN013Q@mail.gmail.com>
 <005401dc9638$b3e2ea40$1ba8bec0$@telus.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <005401dc9638$b3e2ea40$1ba8bec0$@telus.net>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[chromium.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[chromium.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[chromium.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42112-lists,linux-pm=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[senozhatsky@chromium.org,linux-pm@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,chromium.org:dkim]
X-Rspamd-Queue-Id: E5770EE029
X-Rspamd-Action: no action

On (26/02/04 16:45), Doug Smythies wrote:
> >> What is "established" and "newer" for a stable kernel is quite handwavy
> >> IMO but even here Sergey's regression report is a clear data point...
> >
> > Which wasn't known at the time commit 85975daeaa4d went in.
> >
> >> Your report is only restoring 5.15 (and others) performance to 5.15
> >> upstream-ish levels which is within the expectations of running a stable
> >> kernel. No doubt it's frustrating either way!
> >
> > That is a consequence of the time it takes for mainline changes to
> > propagate to distributions (Chrome OS in this particular case) at
> > which point they get tested on a wider range of systems.  Until that
> > happens, it is not really guaranteed that the given change will stay
> > in.
> >
> > In this particular case, restoring commit 85975daeaa4d would cause the
> > same problems on the systems adversely affected by it to become
> > visible again and I don't think it would be fair to say "Too bad" to
> > the users of those systems.  IMV, it cannot be restored without a way
> > to at least limit the adverse effect on performance.
> 
> I have been going over the old emails and the turbostat data again and again
> and again.
> 
> I still do not understand how to breakdown Sergey's results into its
> component contributions. I am certain there is power limit throttling
> during the test, but have no idea to much or how little it contributes to the
> differing results.
> 
> I think more work is needed to fully understand Sergey's test results from October.
> I struggle with the dramatic test results difference of base=84.5 and revert=59.5
> as being due to only the idle code changes.
> 
> That is why I keep asking for a test to be done with the CPU clock frequency limited
> such that power limit throttling can not occur. I don't know what limit to use, but suggest
> 2.2 GHZ to start with. Capture turbostat data with the tests. And record the test results.


> @Sergey: are you willing to do the test?

I can run tests, not immediately, though, but within some reasonable
time frame.

(I'll need some help with instructions/etc.)

