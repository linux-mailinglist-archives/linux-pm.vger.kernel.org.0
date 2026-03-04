Return-Path: <linux-pm+bounces-43568-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eNuLObIJqGn2nQAAu9opvQ
	(envelope-from <linux-pm+bounces-43568-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 04 Mar 2026 11:30:10 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E39D1FE5C3
	for <lists+linux-pm@lfdr.de>; Wed, 04 Mar 2026 11:30:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AB6BA31A3E83
	for <lists+linux-pm@lfdr.de>; Wed,  4 Mar 2026 10:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 097DC3A2544;
	Wed,  4 Mar 2026 10:24:05 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5BE236A00F;
	Wed,  4 Mar 2026 10:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772619844; cv=none; b=bcEQ7GU9Kp9PQdffR9fHATZDwZ0MIZpQS8LbXLNpT5XtrcvaViIuMp5V6JSosJcHRUexoWgNVWNFKqU6R5sGT3vLmfXgxjss4E28BpaLUL0fO7/cDI7B/0b5HjnasIoAGXkfGdl7YoZHkH3KqgzBeL/aYmLUXV+7W03BMhKNsCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772619844; c=relaxed/simple;
	bh=tAH5Fh//r0yTs3/fYZ1gphLpXoMSTNidzCwnGpKutrU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nMzAJYF1DRAwNta2kOMFyJNTBFeGb9I0ccZqlrpFz9qWHuAK+8juBzjGzc3c8n+1MYhqAdwgzlIbx619cP00ddbphdoN/g5OEqEVK4aATSpdpYmHnhTM/YGmMdHU9jNiEIPMFhQCBhdEvNn20Gh7GagBybMxUt179Y8a+ZjQTE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DE86E339;
	Wed,  4 Mar 2026 02:23:55 -0800 (PST)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 01EEF3F7BD;
	Wed,  4 Mar 2026 02:23:59 -0800 (PST)
Date: Wed, 4 Mar 2026 10:23:50 +0000
From: Cristian Marussi <cristian.marussi@arm.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>,
	Cristian Marussi <cristian.marussi@arm.com>,
	linux-pm@vger.kernel.org, arm-scmi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pmdomain: arm: Add print after a successful probe for
 SCMI power domains
Message-ID: <aagINsZj6sgR7pNY@pluto>
References: <20260304101457.7470-1-ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260304101457.7470-1-ulf.hansson@linaro.org>
X-Rspamd-Queue-Id: 7E39D1FE5C3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.86 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[arm.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43568-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cristian.marussi@arm.com,linux-pm@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.915];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,arm.com:email]
X-Rspamd-Action: no action

On Wed, Mar 04, 2026 at 11:14:57AM +0100, Ulf Hansson wrote:
> It can be discussed how useful a print is after a successful probe. In the
> SCMI power domain case it's seems valuable, as it let us inform about the
> number of initialized power domains too, which is fetched from firmware.

Hi,

yes indeed we tend to print such 'summary' info at the end of a
successful probe in other SCMI drivers.

LGTM.
Review-by: Cristian Marussi <cristian.marussi@arm.com>

Thanks,
Cristian

