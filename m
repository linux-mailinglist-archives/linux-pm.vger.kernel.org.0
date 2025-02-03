Return-Path: <linux-pm+bounces-21251-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 50305A25208
	for <lists+linux-pm@lfdr.de>; Mon,  3 Feb 2025 06:32:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB7D018842DB
	for <lists+linux-pm@lfdr.de>; Mon,  3 Feb 2025 05:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 721BD38FB9;
	Mon,  3 Feb 2025 05:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="IhEt0J1/"
X-Original-To: linux-pm@vger.kernel.org
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46794A31;
	Mon,  3 Feb 2025 05:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738560753; cv=none; b=TxHoQWriQ/uXwnJF7LZXXR3yrD/Eu4lEc61yQzx/oMH+Ubkuu4cYnrVuMDLkQ6xizTaaHoJEaj5UYVBz7eZ2ZaHk7PSxhc9x/6XEZXIh+w+ZPD1sdEkk92tK5vHB37YOqVWJmpn45+mtvif1Dn0UVfB7Kdwhznz85u2RlPwN/Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738560753; c=relaxed/simple;
	bh=eGOn5dFfGAgVayjEzz+z3LRXFqGKO19ZQPoQCSAh5PM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VbhWq+ibKFHGr2LqarrOzapa/ZgVJgXinZbZKJUCATgWRE4g44H1w9SrfdYNFCOkGXixktRySrNiT//6qIprxhrM3abT0n1ibKLGStQynpyL0JEadMYwtScezI9fUG+jS9vpJfymkxr3CcOSrRLQwkn6+92BdvKU+iZKjv8LE0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=IhEt0J1/; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 5135WABI2079317
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Sun, 2 Feb 2025 23:32:10 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1738560730;
	bh=sJRCeXGc4CmZX5CorqP/Un236xITOhXU5/Sey4Z70Gc=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=IhEt0J1/bmpse9TL/fuyWBscEypWazoerivCRiD2WQRmva9xbW6XL3QTNcZhKNT0w
	 OEbogSKsQWmx+habwrp7dO/4TQ35wsj3fCgkWAS8BuogrhZ4TytHNRSG2TEtsZhoXP
	 CaLx/PPTvMw2GuWjQJTjqRphY1gD0q25xARWvL1M=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 5135WADP081440;
	Sun, 2 Feb 2025 23:32:10 -0600
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 2
 Feb 2025 23:32:09 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sun, 2 Feb 2025 23:32:09 -0600
Received: from localhost (lcpd911.dhcp.ti.com [172.24.227.226])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 5135W8x0077312;
	Sun, 2 Feb 2025 23:32:09 -0600
Date: Mon, 3 Feb 2025 11:02:08 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Keita Morisaki <keyz@google.com>
CC: <rostedt@goodmis.org>, <mhiramat@kernel.org>,
        <mathieu.desnoyers@efficios.com>, <linux-kernel@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>, <lpieralisi@kernel.org>,
        <sudeep.holla@arm.com>, <rafael@kernel.org>,
        <daniel.lezcano@linaro.org>, <linux-pm@vger.kernel.org>,
        <aarontian@google.com>, <yimingtseng@google.com>,
        Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH v4] cpuidle: psci: Add trace for PSCI domain idle
Message-ID: <20250203053208.l4o2o5g3imdzl6vj@lcpd911>
References: <20250202104211.2764016-1-keyz@google.com>
 <20250202104608.2766080-1-keyz@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250202104608.2766080-1-keyz@google.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Keita,

On Feb 02, 2025 at 18:46:08 +0800, Keita Morisaki wrote:
> The trace event cpu_idle provides insufficient information for debugging
> PSCI requests due to lacking access to determined PSCI domain idle
> states. The cpu_idle usually only shows -1, 0, or 1 regardless how many
> idle states the power domain has.
> 
> Add new trace events namely psci_domain_idle_enter and
> psci_domain_idle_exit to trace enter and exit events with a determined
> idle state.

Thanks for this, will really ease those psci idle debugs for everyone!

> 
> These new trace events will help developers debug CPUidle issues on ARM
> systems using PSCI by providing more detailed information about the
> requested idle states.
> 
> Signed-off-by: Keita Morisaki <keyz@google.com>
> Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> Tested-by: Kevin Hilman <khilman@baylibre.com>

Reviewed-by: Dhruva Gole <d-gole@ti.com>


-- 
Best regards,
Dhruva Gole
Texas Instruments Incorporated

