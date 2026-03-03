Return-Path: <linux-pm+bounces-43522-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wBlGEjQmp2k3fAAAu9opvQ
	(envelope-from <linux-pm+bounces-43522-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 03 Mar 2026 19:19:32 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AEA411F52B8
	for <lists+linux-pm@lfdr.de>; Tue, 03 Mar 2026 19:19:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9DACA30B6085
	for <lists+linux-pm@lfdr.de>; Tue,  3 Mar 2026 18:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89C07351C23;
	Tue,  3 Mar 2026 18:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MTqJRQVB"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6598532AAA0;
	Tue,  3 Mar 2026 18:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772561753; cv=none; b=qG25flSJObprnneD2gJdx5M5z27bkbNyDcTsDmnGxtADxvrQ/iBlVfFrpz7slfDA6fA5oixH8XLBa329S7tJV4r1Esyhts2oc201tDMrA9rKV1M53CWXPDVjkgBhctIZFZa2qsXhNFi6Lovn8Y6DK8swuSX4t19w4GerXE/dMRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772561753; c=relaxed/simple;
	bh=+SrioeYUZSxMnEuDGHr6OMW+zO4o7LsPUlakyCy8mh0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FusTw7YRocyWtQb2LZ7Dq/Zbm33dn1Jn0cf1tY1NIK6Bet6WDs/PlPHOyk5TQXR6KPy6Q1zZlV+YUrciscs70Pt15TnY9qE6ysnS+dGCqL2thyeVj+E30wxDWo5lVXxdKvqvYQDsaOSLk2/ZayLi6jHo0kPav/kjg8g2QtHSqwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MTqJRQVB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6501C116C6;
	Tue,  3 Mar 2026 18:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772561753;
	bh=+SrioeYUZSxMnEuDGHr6OMW+zO4o7LsPUlakyCy8mh0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=MTqJRQVBQWzzKaIobxPPkTrZrY7fJ03gAL6Fr/ATxpY2BklJtb0rvGSjSMX+L7vQF
	 G47y19pvUS2iDLNc/PRnlq+dU7bYdq2p84s28Z6Vn8Y0sx5+4k7xZ7BoJbtD8yms3p
	 ie0se/dsyQ/SSbQNbgvUcK1UDhOka7ff+Y84OWI9DfMBmu47z7u6SAr2pfZRhK2X3+
	 bTSxrTzDFYNsPCsJ778uHnjOr9yMnFjaUmOxdzBqm04EGy8prWuJnjQeXWgWKi96WF
	 q1/q6ap9pGfGjlGdcDS5/rMApGKJ88sME3oTtzzMqyem424wd6saSdAfxHfgH0ppPY
	 25T4UFWeCqC3w==
Message-ID: <3ce56e1d-ab5c-44f1-af09-679e714833a7@kernel.org>
Date: Tue, 3 Mar 2026 11:15:49 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cpupower: Add support for setting EPP via systemd
 service
To: Jan Kiszka <jan.kiszka@siemens.com>, Thomas Renninger <trenn@suse.com>,
 Shuah Khan <shuah@kernel.org>, "John B. Wyatt IV" <jwyatt@redhat.com>,
 John Kacur <jkacur@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <b44f2af7-360b-4f4c-8541-04008ead7dcb@siemens.com>
Content-Language: en-US
From: Shuah <shuah@kernel.org>
In-Reply-To: <b44f2af7-360b-4f4c-8541-04008ead7dcb@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: AEA411F52B8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-43522-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shuah@kernel.org,linux-pm@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,siemens.com:email]
X-Rspamd-Action: no action

On 2/20/26 23:21, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> Extend the systemd service so that it can be used for tuning the Energy
> Performance Preference (EPP) as well. Available options can be read from
> /sys/devices/system/cpu/cpufreq/policy0/energy_performance_available_preferences.
> The desired one can then be set in cpupower-service.conf.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
> 
> Changes in v2:
>   - improve commit message
> 

Applied to https://web.git.kernel.org/pub/scm/linux/kernel/git/shuah/linux.git/log/?h=cpupower
for my next pull request to Rafael.

thanks,
-- Shuah

