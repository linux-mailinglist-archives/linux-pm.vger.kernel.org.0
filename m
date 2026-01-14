Return-Path: <linux-pm+bounces-40852-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 64511D1EBC8
	for <lists+linux-pm@lfdr.de>; Wed, 14 Jan 2026 13:28:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 372553010AAE
	for <lists+linux-pm@lfdr.de>; Wed, 14 Jan 2026 12:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4EEC39281A;
	Wed, 14 Jan 2026 12:22:41 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92C5D2D0618;
	Wed, 14 Jan 2026 12:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768393361; cv=none; b=E4Ajnv9t8fEEwiy8Wf9bEXvNo7tMvnJMhN1WCE0yQbSSNC1F4ZEQKn+wP9vbpsxDaNZq1Rhgza/gNSw2NfZ+ttA6UYtz7UaJaEQs2XvzKdQvKejc/OZx45F1Pxm4k8ASHB6IE00tbs/znJUd0VvG0hVnyiXfaMcNh7qpeC95ux0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768393361; c=relaxed/simple;
	bh=zMb6wXd+8pW2iLhhU5stQfcUpnqBMCYhUyr2fLXib5U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AYxyBU9rRDtlDC4u0wCx9t64bMvJuem9oimMicIY2OSbPDkmkmMue6h4x2/kzHE25+ItSL2qub4HpmEH6fn/xAILr0hoLNLWGV+Boe5Tnq+dp9FUHHCz2oqLwvHJM3IECH5V8Xx1wrrPI2YSwwiAjOT5dSNrfMsSnedvPMr0oaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=foss.arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 61D3C1424;
	Wed, 14 Jan 2026 04:22:33 -0800 (PST)
Received: from bogus (e133711.arm.com [10.1.197.51])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 320D63F632;
	Wed, 14 Jan 2026 04:22:39 -0800 (PST)
Date: Wed, 14 Jan 2026 12:22:37 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: Sergey Shtylyov <s.shtylyov@auroraos.dev>
Cc: Cristian Marussi <cristian.marussi@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>, arm-scmi@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] cpufreq: scmi: correct SCMI explanation
Message-ID: <aWeKjehftu2GFj4m@bogus>
References: <e6c2e7af-ad87-4d38-9dbb-f9d6ae81fe83@auroraos.dev>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e6c2e7af-ad87-4d38-9dbb-f9d6ae81fe83@auroraos.dev>

On Tue, Jan 13, 2026 at 10:33:30PM +0300, Sergey Shtylyov wrote:
> SCMI stands for System Control and Management Interface, not System Control
> and Power Interface -- apparently, Sudeep Holla copied this line from his
> SCPI driver and then just forgot to update the acronym explanation... :-)
>

Yikes! Indeed it is copy-paste. Thanks for spotting and fixing this.

Reviewed-by:  Sudeep Holla <sudeep.holla@arm.com>

-- 
Regards,
Sudeep

