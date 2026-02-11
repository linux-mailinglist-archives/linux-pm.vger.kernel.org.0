Return-Path: <linux-pm+bounces-42509-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8HoBJdGnjGnVrwAAu9opvQ
	(envelope-from <linux-pm+bounces-42509-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 11 Feb 2026 17:01:21 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B251125EAA
	for <lists+linux-pm@lfdr.de>; Wed, 11 Feb 2026 17:01:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E6DFA301467F
	for <lists+linux-pm@lfdr.de>; Wed, 11 Feb 2026 16:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 353792E92A6;
	Wed, 11 Feb 2026 16:01:10 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24D6B3EBF17;
	Wed, 11 Feb 2026 16:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770825670; cv=none; b=e6DGE2tjNkXnyYEVW0Jkz75nVXgGEUi858y5b0iENT31jVLfOeZ0wPbRzXP3Nv16L4r0zHuNnYixJk+WBChFL3KJUQB9LQy89FPofs3qv9dXCdOOfuM+71lZnSKDsgWdIHVcHTLp71CqviN+93EGgY0KXYbTX6KiJR17BYjAOns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770825670; c=relaxed/simple;
	bh=u08AD1YbiNVGYI3Y2C3r8qA3ry88SvQe0E3MD2DYfZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jm3nvTY5YoI2lVgMLmilJlalZTzjjnR1MkdEPMl8wOS7ia1NBMOaTzndRiEbgyVVxNnviIXj5vMnt31wkbidvLbH+dIrYIQluzff0ECWEHVKDeemOt9gtcRzcv1qhsK2MqgTJfHjq6kxN02j9TRy4oUbjR5nlRTv7qF3kqcIpsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F1CBF339;
	Wed, 11 Feb 2026 08:01:01 -0800 (PST)
Received: from arm.com (arrakis.cambridge.arm.com [10.1.197.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1A8943F632;
	Wed, 11 Feb 2026 08:01:03 -0800 (PST)
Date: Wed, 11 Feb 2026 16:01:01 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Ankur Arora <ankur.a.arora@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
	bpf@vger.kernel.org, arnd@arndb.de, will@kernel.org,
	peterz@infradead.org, akpm@linux-foundation.org,
	mark.rutland@arm.com, harisokn@amazon.com, cl@gentwo.org,
	ast@kernel.org, rafael@kernel.org, daniel.lezcano@linaro.org,
	memxor@gmail.com, zhenglifeng1@huawei.com,
	xueshuai@linux.alibaba.com, joao.m.martins@oracle.com,
	boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Christoph Lameter <cl@linux.com>
Subject: Re: [PATCH v9 03/12] arm64/delay: move some constants out to a
 separate header
Message-ID: <aYynvZXsuZlcxyZX@arm.com>
References: <20260209023153.2661784-1-ankur.a.arora@oracle.com>
 <20260209023153.2661784-4-ankur.a.arora@oracle.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260209023153.2661784-4-ankur.a.arora@oracle.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[arm.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,arndb.de,kernel.org,infradead.org,linux-foundation.org,arm.com,amazon.com,gentwo.org,linaro.org,gmail.com,huawei.com,linux.alibaba.com,oracle.com,linux.com];
	TAGGED_FROM(0.00)[bounces-42509-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RSPAMD_URIBL_FAIL(0.00)[infradead.org:query timed out,arm.com:query timed out,linux.com:query timed out,oracle.com:query timed out];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	RSPAMD_EMAILBL_FAIL(0.00)[will.kernel.org:query timed out,linux-arm-kernel.lists.infradead.org:query timed out];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[catalin.marinas@arm.com,linux-pm@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,infradead.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.com:email]
X-Rspamd-Queue-Id: 2B251125EAA
X-Rspamd-Action: no action

On Sun, Feb 08, 2026 at 06:31:44PM -0800, Ankur Arora wrote:
> Moves some constants and functions related to xloops, cycles computation
> out to a new header. Also rename some macros in qcom/rpmh-rsc.c which
> were occupying the same namespace.
> 
> No functional change.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Bjorn Andersson <andersson@kernel.org>
> Cc: Konrad Dybcio <konradybcio@kernel.org>
> Cc: linux-arm-kernel@lists.infradead.org
> Reviewed-by: Christoph Lameter <cl@linux.com>
> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

