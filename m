Return-Path: <linux-pm+bounces-40350-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 208FACFC79B
	for <lists+linux-pm@lfdr.de>; Wed, 07 Jan 2026 08:59:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9BDCF3001FE8
	for <lists+linux-pm@lfdr.de>; Wed,  7 Jan 2026 07:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA34627A461;
	Wed,  7 Jan 2026 07:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="G5A4psOb"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E464913C918;
	Wed,  7 Jan 2026 07:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767772736; cv=none; b=DfllPROrSFvnqTLW9S5klQ3MEwm/1D9kDGLnfg6Ulhyk0IWmU4tm6K8IHO1KmSj9eZuQwSCBmx4+J5YrEWFP8J1VDOBCeGpyQx7b7Z13Y6sh9afuDg8Gucqxuu7KA7TFpLcOgjPiggo66hvrCAjhNxk/tPJsyI54DmPyo/dgSP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767772736; c=relaxed/simple;
	bh=dmzZTxpIHt2uGOFJD8/OYHYyUjiWQvJYXn16+ZOaHKM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EC4IylKlYW8SJNKpBMLXsutChPNku0k4TmFCjnlhHtrp+up7gIPRqB41xcx0u7CUr+53i4cPRXGt8kRTMs0MHnc1XnjVVF1kVzj8SwFT41hpDADaWmc5I4Hfty7gB6umLkddWjIxDGhPaNLl/a+ZM1ghnUt860njsVyLh6A0FVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=G5A4psOb; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=References:In-Reply-To:Cc:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=thXQiaz4V3xKqgoiOZ2lNAUVELY4RtoHKX/hnesmgSk=; b=G5A4psObg/OHz/aSvIp3H3c0DU
	HZ+LDivnOsBnKQnsN7y6kX7PH4mi3V3aSsacBmRwPtc5XLy6Px/tVIk9fTyOWXgddCM/7lW4AkHpF
	cqMP/uFuhQ1c8GcU1/v0HYFBHY0IdHjv2p1CZLeXkj9LjY/ejhrA/gE+3tgkBYGATYqyqhgGwSe72
	Gtvza3aH5pdE3SsyvMRDmBlzHOsW3XQbySHs/noTZbRY+VQ+hSBWUeu2ZjGvvqLnRKRPrvmcZPZFY
	HWyF6ylHQjAMatbzAedXBXhYptVbQTt13+oNxNaDYnahUUpEyndYeFoJkI+hQm71Ch3OFNJAgxCf1
	1aXRVtYg==;
Date: Wed, 7 Jan 2026 08:58:45 +0100
From: Andreas Kemnade <andreas@kemnade.info>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Nishanth Menon <nm@ti.com>, Kevin Hilman <khilman@kernel.org>, Haotian
 Zhang <vulab@iscas.ac.cn>, "Rafael J . Wysocki" <rafael@kernel.org>,
 linux-omap@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] omap-cpufreq: Fix regulator resource leak in probe()
Message-ID: <20260107085845.2196cf93@kemnade.info>
In-Reply-To: <y2xyyyyhdoxflj4doa4y3a7prjqulcw63bdkor3fo3qsbmxvzy@dvhmfxkkzdqs>
References: <20251215030327.1771-1-vulab@iscas.ac.cn>
	<20260105101412.0ac7baa7@kemnade.info>
	<pjmwnxp6wae3bbmzmzys4r5szw6ywxphi4qtmpmg7jsqadc5fm@fvozoujr4mi5>
	<20260106182946.1c54d769@kemnade.info>
	<y2xyyyyhdoxflj4doa4y3a7prjqulcw63bdkor3fo3qsbmxvzy@dvhmfxkkzdqs>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; aarch64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 7 Jan 2026 11:27:42 +0530
Viresh Kumar <viresh.kumar@linaro.org> wrote:

> > But the fix is good for stable. So I would propose to add this
> > fix (to let it propagate to stable) and deorbit this driver.  
> 
> I don't think it is worth adding to stable when there are no users.

ok, thet commit is from v4.9, oldest longterm is 5.10.
So also no users in longterm kernels, so we do not need the fix at all.

Regards,
Andreas

