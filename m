Return-Path: <linux-pm+bounces-18066-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 498239D88F9
	for <lists+linux-pm@lfdr.de>; Mon, 25 Nov 2024 16:16:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C146AB283F0
	for <lists+linux-pm@lfdr.de>; Mon, 25 Nov 2024 13:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9DF71ADFF8;
	Mon, 25 Nov 2024 13:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SiCwo5k8"
X-Original-To: linux-pm@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D7A192B7F;
	Mon, 25 Nov 2024 13:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732542900; cv=none; b=TBFkvv0qjI5ANrjajRaReCmKCjWXF2GWTmAcMOuI68Pxnn7rRZMtCTgqWZkUFAO4Bzor9wy+zsjXM+TlqGrj/c4fMRGvBb9XO6W+n1wl5OKhieCydhseu0u+IY7eO2+3O/7R4dJHASc1ruCp4THgF27oH9ieWAmovVCbKNbkcZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732542900; c=relaxed/simple;
	bh=yxBXFiBk8ProWMrC0CI0/aOV7/EZ6crJMjJPgwtk4Y8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KejjvfqU+qZdmNGBfBvWMYK8FEaCcAgqK96MfIfUYV46/l1Lh7FFi44yYZoRag7qEYMmBq//2FW88MAlTFd2sKHbJz3poClV5qwcwmM67uNeHvG+gwB8zYMuCaL6eHNmpnd71qlCL2iCvT6HBBpURMwh01kE3VF5AJX/4skL1eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=SiCwo5k8; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=8yS586kbtpaPv/6exD32OF3hHBWdUKMGIUhYc33vO+A=; b=SiCwo5k8R9FpAeH9APCrvaHxnX
	EzMjeQT9njJ0hdewXMSrqS6ter3olRlqlUo+A6K9u0m/Guq0s9BiyIZn/JpNiatpcYCNb8Wtzvo6R
	0PGSK1VPoZPsEdOQ9NNKcEWsqj3fkakwjEDpjG6UEt9TIYLGsiQXUg/j4tyqeVPbYTi8IMGuJYiEQ
	ZeyE4Z6W9XSJGMyHeoz2TS+SXd3IWylu0cQuM7fKMtoN999MW316MYrvqURFZEV+crDYOUqiEs2oK
	C8JwqjYE5bYl/Sd88UxyNSVVTssDGBhXIYQ3gErstmN5bCS6OcR6JU5wofV4DKEDVxOWw3Lpw6Xfy
	ArSeF3dg==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tFZYE-0000000Bw9j-0Z4H;
	Mon, 25 Nov 2024 13:54:55 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id EBA8E30026A; Mon, 25 Nov 2024 14:54:54 +0100 (CET)
Date: Mon, 25 Nov 2024 14:54:54 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	rafael.j.wysocki@intel.com, len.brown@intel.com,
	artem.bityutskiy@linux.intel.com, dave.hansen@linux.intel.com,
	tglx@linutronix.de, gautham.shenoy@amd.com
Subject: Re: [RFC PATCH v4 8/8] acpi_idle: Disallow play_dead with FFH cstate
 on AMD platforms
Message-ID: <20241125135454.GE38837@noisy.programming.kicks-ass.net>
References: <20241125132029.7241-1-patryk.wlazlyn@linux.intel.com>
 <20241125132029.7241-9-patryk.wlazlyn@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241125132029.7241-9-patryk.wlazlyn@linux.intel.com>

On Mon, Nov 25, 2024 at 02:20:28PM +0100, Patryk Wlazlyn wrote:
> Signed-off-by: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>
> Suggested-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
> ---
>  drivers/acpi/processor_idle.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
> index 586cc7d1d8aa..4b4ac8d55b55 100644
> --- a/drivers/acpi/processor_idle.c
> +++ b/drivers/acpi/processor_idle.c
> @@ -803,7 +803,11 @@ static int acpi_processor_setup_cstates(struct acpi_processor *pr)
>  
>  		state->flags = 0;
>  
> -		state->enter_dead = acpi_idle_play_dead;
> +		/* AMD doesn't want to use mwait for play dead. */
> +		bool amd_or_hygon = boot_cpu_data.x86_vendor == X86_VENDOR_AMD ||
> +				    boot_cpu_data.x86_vendor == X86_VENDOR_HYGON;
> +		if (!(cx->entry_method == ACPI_CSTATE_FFH && amd_or_hygon))
> +			state->enter_dead = acpi_idle_play_dead;

So I don't like this. Less exceptions is better.

This *SHOULD* never trigger on AMD anyway, because they recommend IO
port C[23]. But if their partner BIOS engineer does a wobbly and they
end up in MWAIT anyway, it *should* all work regardless.

