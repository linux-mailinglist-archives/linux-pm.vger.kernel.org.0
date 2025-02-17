Return-Path: <linux-pm+bounces-22204-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD28CA38307
	for <lists+linux-pm@lfdr.de>; Mon, 17 Feb 2025 13:32:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A06A3171386
	for <lists+linux-pm@lfdr.de>; Mon, 17 Feb 2025 12:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CBCB18FDD5;
	Mon, 17 Feb 2025 12:31:55 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 999DB7F9;
	Mon, 17 Feb 2025 12:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739795515; cv=none; b=MJ+49WQheyc3UPkXqL/3Mra02dF6FXFx4T1isxwAGN5+CZx/JPX+6Iia3PhsgmwZDvw4b805KjVOGDCiYvRZyTwirdmX6L54uttsJRgrRPwm1BHWhTbMAitENkdlLeaPjAI97llOUy7uueTiBQjj3TsVd04zghooRb+IUcsmDAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739795515; c=relaxed/simple;
	bh=mLoswGq4ee6hpNyl8OOh6wrbHYc6wwRA6DU8avtw+Tw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O7yxuRDRQtbItJauivYBZMKv3yOX1PjSGmiCrnvOtPbYJzLp/OBP7kG3HEObcRFpRAX0VQM/oAE8reUdXGNFB56q86fz1iqDePz1CxMOtgaZHLwI3Zgjvf4KzkvfcN0ZeBahvr8I4giXFrAxL6iXW7Orwj9qPWhOkysM0b3lmj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 16C171692;
	Mon, 17 Feb 2025 04:32:12 -0800 (PST)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 198303F5A1;
	Mon, 17 Feb 2025 04:31:49 -0800 (PST)
Date: Mon, 17 Feb 2025 12:31:47 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Keita Morisaki <keyz@google.com>, Ulf Hansson <ulf.hansson@linaro.org>,
	lpieralisi@kernel.org, linux-kernel@vger.kernel.org,
	daniel.lezcano@linaro.org, linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, rostedt@goodmis.org,
	mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
	linux-trace-kernel@vger.kernel.org, aarontian@google.com,
	Sudeep Holla <sudeep.holla@arm.com>, yimingtseng@google.com,
	Dhruva Gole <d-gole@ti.com>, Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH v5 RESEND] cpuidle: psci: Add trace for PSCI domain idle
Message-ID: <Z7MsM5Va5xi-Nuis@bogus>
References: <20250210055828.1875372-1-keyz@google.com>
 <CAJZ5v0hWNYB69ydM4--GNtLBgG3WS4MT+S10w46883kHnFMMEQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0hWNYB69ydM4--GNtLBgG3WS4MT+S10w46883kHnFMMEQ@mail.gmail.com>

On Mon, Feb 17, 2025 at 12:57:07PM +0100, Rafael J. Wysocki wrote:
> +Ulf
> 
> On Mon, Feb 10, 2025 at 6:58 AM Keita Morisaki <keyz@google.com> wrote:
> >
> > The trace event cpu_idle provides insufficient information for debugging
> > PSCI requests due to lacking access to determined PSCI domain idle
> > states. The cpu_idle usually only shows -1, 0, or 1 regardless how many
> > idle states the power domain has.
> >
> > Add new trace events namely psci_domain_idle_enter and
> > psci_domain_idle_exit to trace enter and exit events with a determined
> > idle state.
> >
> > These new trace events will help developers debug CPUidle issues on ARM
> > systems using PSCI by providing more detailed information about the
> > requested idle states.
> >
> > Signed-off-by: Keita Morisaki <keyz@google.com>
> > Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> > Reviewed-by: Dhruva Gole <d-gole@ti.com>
> > Tested-by: Kevin Hilman <khilman@baylibre.com>
> > ---
> > v1->v2: Split the ftrace event into two (psci_domain_idle_(enter|exit))
> >         and rephrase the commit message accordingly. Rebased onto the latest.
> > v2->v3: Add "Reviewed-by: Steven Rostedt"
> > v3->v4: Add the Tested-by label
> > v4->v5: Add "Reviewed-by: Dhruva Gole"
> >
> > Hopefully this patch gets attention from maintainers of
> > drivers/cpuidle/cpuidle-psci.c too.
>
> Lorenzo, Sudeep, Ulf, any comments?
>

Looks good to me. I left it to Ulf, FWIW:

Acked-by: Sudeep Holla <sudeep.holla@arm.com>

-- 
Regards,
Sudeep

