Return-Path: <linux-pm+bounces-30336-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC571AFC3FB
	for <lists+linux-pm@lfdr.de>; Tue,  8 Jul 2025 09:29:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 207C1188283E
	for <lists+linux-pm@lfdr.de>; Tue,  8 Jul 2025 07:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC68722ACFA;
	Tue,  8 Jul 2025 07:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rnNJ/iLT"
X-Original-To: linux-pm@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C20191F9C;
	Tue,  8 Jul 2025 07:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751959739; cv=none; b=C86Jl+hOzIXweiCO4av8WeqoEjHUoikJ1FyojrikWYZkUcCyj6vHk4uSfuGqLySIVO9aJyrqfG9jXO2InQgTXc8Vn397YLOdlJX2zVckza9IQ5JoVphC/EUS2qZQisKrnEV+KogXcPA91YQL7lpwDIr0R4Xce7WaSHgBRI3mplU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751959739; c=relaxed/simple;
	bh=s7Evmnh6Gipudvk1AS9YSQ/CsQTCNrU+hI/Beq0AyHI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LYw6PnOm/uFXyvu4VshEGL/ci3Tlo7vx7Briocv9N2RXLDMzKOLP/vFJurgs1pUNn4SvCyLPqntvvhtmIfSpmTQDXZZYxmswM3vcG9mouZiKrY/y3dCQaCffYabj33nX3wxZIkNA2s0nn3iSCXYhjjqFNhvDEeTZx5O15g4qXEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=rnNJ/iLT; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=0Ergzn50ihNUK+Gr5rgy2htRMdsTV3F1Y6+lOnHjGwU=; b=rnNJ/iLT9KfKYNXcgB9FH3X6sV
	mostdoK1iG7DNpnRjGqXSXj2eIhylmOOho3mIo3MYhcrfHx1fBXaTerBRa/S+zI1fBNwEpnOpjzzy
	XZgjDPZ8g5OHZA0hgXEYUJMiDJrA55QdyQaYMP/CgViBmwfLwOLnqUsMsKE3CGtu62H21uQNyPY7F
	snsjXZ7vLXR4oSbW5MTMN/VloEwi6DYBaIZRbx7LEIaSCCx7K5Bt7bcEiJSbjlWMIZcJa/RcLC91y
	+LdGIuJ96iyySCQgpsQafm+1dK3TZb6JzdPI8PHfSzG0oGoZwrJo4op7+ruNuqSEi5rSznk8qV3lD
	7tFHvonQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uZ2l3-0000000GPl5-0Q2t;
	Tue, 08 Jul 2025 07:28:53 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id B396630065D; Tue, 08 Jul 2025 09:28:52 +0200 (CEST)
Date: Tue, 8 Jul 2025 09:28:52 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: timvp@google.com, Michal Koutn?? <mkoutny@suse.com>, rafael@kernel.org,
	pavel@kernel.org, tj@kernel.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, lujialin4@huawei.com,
	chenridong@huawei.com
Subject: Re: [PATCH next] sched,freezer: prevent tasks from escaping being
 frozen
Message-ID: <20250708072852.GD1613376@noisy.programming.kicks-ass.net>
References: <20250703133427.3301899-1-chenridong@huaweicloud.com>
 <n23vsu6y6cjf2vwdbfcjl2mj7venvpzpblncoa7adn3q5r4lph@qsfa3deqtamc>
 <f4c4f465-72b9-4682-99e6-c249ecab8572@huaweicloud.com>
 <8dae8006-e63d-467f-bb7c-e8470878e534@huaweicloud.com>
 <20250704075718.GA2001818@noisy.programming.kicks-ass.net>
 <85fc85e8-af92-4d58-8271-9bf4aeb0a63d@huaweicloud.com>
 <bdc5a4d3-6942-4ba2-a13d-35f2e13c0b37@huaweicloud.com>
 <20250707101019.GE1613200@noisy.programming.kicks-ass.net>
 <c63a1698-2d93-4105-8641-ecec69b48523@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c63a1698-2d93-4105-8641-ecec69b48523@huaweicloud.com>

On Mon, Jul 07, 2025 at 07:32:59PM +0800, Chen Ridong wrote:

> Below is the race condition scenario:
> 
> get_signal				read freezer.state
> try_to_freeze
> __refrigerator				freezer_read
> 					update_if_frozen
> WRITE_ONCE(current->__state, TASK_FROZEN);			
> 					// The task is set to frozen(now, frozen(task) == ture).
> 					// we suppose other tasks are all frozen.
> 					// set cgroup frozen when all tasks are frozen
> 					freezer->state |= CGROUP_FROZEN;

Ooh, yes, now I see. Somehow I kept missing update_if_frozen().
Sometimes reading is hard :-) Thanks!

> // freezing(current) will return false,
> // since cgroup is frozen(not freezing)
> break out
> __set_current_state(TASK_RUNNING);
> //bug: the task is set to running, but it should be frozen.

