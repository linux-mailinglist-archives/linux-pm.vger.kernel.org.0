Return-Path: <linux-pm+bounces-7985-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BA518C99CE
	for <lists+linux-pm@lfdr.de>; Mon, 20 May 2024 10:26:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D60AD1C20C8E
	for <lists+linux-pm@lfdr.de>; Mon, 20 May 2024 08:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BC671BC58;
	Mon, 20 May 2024 08:26:45 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 545E0182DB;
	Mon, 20 May 2024 08:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716193605; cv=none; b=RvZwSEYbGbs8gHiBfPGwoRO31B/pPaybWHT46Ynpq4hCx8Y0G5GkszZZ7nUJx0dM+S5lzS2VwKMiQtJYJfMogfncJTF258wds181J4DEBvu4hH6LFOd20Z/z+kNJN4W5mHvspTNipAL20xFfNccQ6ISN9lpgbtBGNysw+tOTlfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716193605; c=relaxed/simple;
	bh=0dPuaAUfJq5Ff9j1D+i4NZ2UxHkBIoSc3A5G/S0n7y0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y1DtENN3Yy8tu1yD5NLV2ARbWWAj1GOp824sUTZfaIIYpRhwFsV3cDjSJy7oni+OYObltOnoxA9iwv6z/ZRLi/gTlZmgLtmWgpx5zs7qAcYDoV2J+xVL2fq37pdIqgzaFyRpOZWHc4rV3pAF415YA8LaLUYYrG0a4qlQkXgOinI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6AAF9FEC;
	Mon, 20 May 2024 01:27:05 -0700 (PDT)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D09223F766;
	Mon, 20 May 2024 01:26:39 -0700 (PDT)
Date: Mon, 20 May 2024 09:26:23 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Javier Carrasco <javier.carrasco.cruz@gmail.com>, Yangtao Li
 <tiny.windzz@gmail.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Chen-Yu
 Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel
 Holland <samuel@sholland.org>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, linux-pm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] cpufreq: sun50i: fix memory leak in
 dt_has_supported_hw()
Message-ID: <20240520092623.6ce850e1@donnerap.manchester.arm.com>
In-Reply-To: <20240520073339.rf6laivnglmww3bf@vireshk-i7>
References: <20240503-sun50i-cpufreq-nvmem-cleanup-v1-0-0a2352cac46b@gmail.com>
	<20240503-sun50i-cpufreq-nvmem-cleanup-v1-1-0a2352cac46b@gmail.com>
	<20240510174937.0a710104@donnerap.manchester.arm.com>
	<20240520073339.rf6laivnglmww3bf@vireshk-i7>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 20 May 2024 13:03:39 +0530
Viresh Kumar <viresh.kumar@linaro.org> wrote:

Hi,

> On 10-05-24, 17:49, Andre Przywara wrote:
> > On Fri, 03 May 2024 19:52:32 +0200
> > Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:  
> > > diff --git a/drivers/cpufreq/sun50i-cpufreq-nvmem.c b/drivers/cpufreq/sun50i-cpufreq-nvmem.c
> > > index 0b882765cd66..ef83e4bf2639 100644
> > > --- a/drivers/cpufreq/sun50i-cpufreq-nvmem.c
> > > +++ b/drivers/cpufreq/sun50i-cpufreq-nvmem.c
> > > @@ -131,7 +131,7 @@ static const struct of_device_id cpu_opp_match_list[] = {
> > >  static bool dt_has_supported_hw(void)
> > >  {
> > >  	bool has_opp_supported_hw = false;
> > > -	struct device_node *np, *opp;
> > > +	struct device_node *np;  
> 
> Why is the opp pointer removed ?

Because it's now declared *inside* the for_each_child_of_node_scoped loop
below, courtesy of this new macro. The idea is that by doing so, any
"break;" will exit the scope, triggering the cleanup routine. The loop
running till "the end" will also make "opp" exit its scope, triggering the
same routine.

Cheers,
Andre

> 
> > >  	struct device *cpu_dev;
> > >  
> > >  	cpu_dev = get_cpu_device(0);
> > > @@ -142,7 +142,7 @@ static bool dt_has_supported_hw(void)
> > >  	if (!np)
> > >  		return false;
> > >  
> > > -	for_each_child_of_node(np, opp) {
> > > +	for_each_child_of_node_scoped(np, opp) {
> > >  		if (of_find_property(opp, "opp-supported-hw", NULL)) {
> > >  			has_opp_supported_hw = true;
> > >  			break;
> > >   
> 


