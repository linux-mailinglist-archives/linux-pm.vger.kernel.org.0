Return-Path: <linux-pm+bounces-17608-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21E889CDC55
	for <lists+linux-pm@lfdr.de>; Fri, 15 Nov 2024 11:18:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBDD8285652
	for <lists+linux-pm@lfdr.de>; Fri, 15 Nov 2024 10:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFA92190055;
	Fri, 15 Nov 2024 10:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oGKEDxeL"
X-Original-To: linux-pm@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1739B188012;
	Fri, 15 Nov 2024 10:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731665915; cv=none; b=PCAIiIxcSyWx/NXqByNT9GmrJo3iL4e/I2fv3xU+DP1FUkxGm+ASdZi0TwpP0zkXBBlUSLOjccwNsLESUyVnyEOBWm1eqhIqlC5Pn6AF2RHVpDfHs333ZS/PDIeL7CKYiIlucuT45P+uDRccuMzZqGE+9ybgpRWnX9fciG0zfz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731665915; c=relaxed/simple;
	bh=NCeXdrtbCXnZ/6c2PhQZNMcuJ1Y/G/EdsI8JLBOkXM8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BcqVU8PuPWW417j9bYe3cFd6kabZOL4yyLevEcfFKMGRT+mcx7LxTQodqGNWnD6FSb10hRoL3NnaUVNZHb3M4Yzebv/21avV6bqgrNHXzE9zpLE6L4V8mgU7QZc+5jbBSy7sZXheoVF7fURKlHMZRkvVzvO9jSU4fqzVKBvx9no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=oGKEDxeL; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=u9bGAkj45ETjGu75HoQHVC2KI4Q+04ecXMZ4ktu+SQ0=; b=oGKEDxeL6dy8wV65cwDH2XKg1l
	pfcB+p8D8T89ThGdPeD9l17aEdmdL5qOFSPOqvUWkWXiykkQdRtDMCUX6fU4mSgH3Ljer2TgwZPQo
	BgD/AiVsyxY9TGUgJ1/2ChZeA07AvUAqGoHyXipoCbN2Ot4jptamSU/B6qF8XWzVOK26K2nn1o4y6
	UFPf+E5HNK9f6ZL743WsuASmCrov5jYqVzRQBOh0b5tmnibhFYP+HJVYhFXUbrWzrnxZgpI7lnMqn
	ibeOSH1NuNxNLc7bJPvLaPSRu03V/dFFunrNnn+ddHhPSYyHwd75Bexl0wabSCfrF+E4zda3ug8OO
	Z1quPWNg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tBtPC-00000000Da5-1AYt;
	Fri, 15 Nov 2024 10:18:23 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id E09B430066A; Fri, 15 Nov 2024 11:18:21 +0100 (CET)
Date: Fri, 15 Nov 2024 11:18:21 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	x86 Maintainers <x86@kernel.org>,
	Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>,
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>,
	Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH v1] ACPI: processor_idle: Use acpi_idle_play_dead() for
 all C-states
Message-ID: <20241115101821.GB22801@noisy.programming.kicks-ass.net>
References: <2373563.ElGaqSPkdT@rjwysocki.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2373563.ElGaqSPkdT@rjwysocki.net>

On Thu, Nov 14, 2024 at 06:47:55PM +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Notice that acpi_processor_setup_cstates() can set state->enter_dead to acpi_idle_play_dead() for all C-states unconditionally and remove the
> confusing C-state type check done before setting it.
> 
> No intentional functional impact.
> 
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/acpi/processor_idle.c |   12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> Index: linux-pm/drivers/acpi/processor_idle.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/processor_idle.c
> +++ linux-pm/drivers/acpi/processor_idle.c
> @@ -803,12 +803,12 @@ static int acpi_processor_setup_cstates(
>  		state->enter = acpi_idle_enter;
>  
>  		state->flags = 0;
> -		if (cx->type == ACPI_STATE_C1 || cx->type == ACPI_STATE_C2 ||
> -		    cx->type == ACPI_STATE_C3) {
> -			state->enter_dead = acpi_idle_play_dead;
> -			if (cx->type != ACPI_STATE_C3)
> -				drv->safe_state_index = count;
> -		}
> +
> +		state->enter_dead = acpi_idle_play_dead;
> +
> +		if (cx->type == ACPI_STATE_C1 || cx->type == ACPI_STATE_C2)
> +			drv->safe_state_index = count;
> +

Thanks!

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

