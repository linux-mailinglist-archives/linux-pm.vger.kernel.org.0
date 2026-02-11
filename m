Return-Path: <linux-pm+bounces-42518-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YFXyAlu/jGmisgAAu9opvQ
	(envelope-from <linux-pm+bounces-42518-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 11 Feb 2026 18:41:47 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D19B126B04
	for <lists+linux-pm@lfdr.de>; Wed, 11 Feb 2026 18:41:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A1FE930022E8
	for <lists+linux-pm@lfdr.de>; Wed, 11 Feb 2026 17:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCDA834DCFC;
	Wed, 11 Feb 2026 17:41:43 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C8DA32A3DA;
	Wed, 11 Feb 2026 17:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770831703; cv=none; b=LIM6sMlIKINn9EaVzm74xcrJj+dkAIIm3uR/wpTlQs4l9km1Rdsy/E2LNSxxoM33Nez6mlD2Y2yMRJSTgvGNpzHi5hcIotCrmT9pIrFCnRTMpwjMCisqAbPfu95wpMWt65qpYAWyReLjYFQY5MF526EhbMYaFdn76okfmlmUZgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770831703; c=relaxed/simple;
	bh=ZILNHAM2+Zr33iLAB4nQIpiribl+a79iiJRFGYam2nI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lMimDq+waDB07rxtRVwCNI/9aUus3iZWAoXPBfL09lgBTTQttK2Kcun2lrNwc1OebT/9bIAC5ZOTd3soj6hC/l3nVHqYzahVlksEiJ7EqRQA2nLvl/qwMSlFsLkF5Roumxy7Ngc1sR5jT/07b3zlGFnGuVhranz3Wah09jQ27Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DEEE6339;
	Wed, 11 Feb 2026 09:41:34 -0800 (PST)
Received: from arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EE6DF3F63F;
	Wed, 11 Feb 2026 09:41:37 -0800 (PST)
Date: Wed, 11 Feb 2026 17:41:35 +0000
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
	Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [PATCH v9 08/12] locking/atomic: scripts: build
 atomic_long_cond_read_*_timeout()
Message-ID: <aYy_T9rbU2-xfFX1@arm.com>
References: <20260209023153.2661784-1-ankur.a.arora@oracle.com>
 <20260209023153.2661784-9-ankur.a.arora@oracle.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260209023153.2661784-9-ankur.a.arora@oracle.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[arm.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,arndb.de,kernel.org,infradead.org,linux-foundation.org,arm.com,amazon.com,gentwo.org,linaro.org,gmail.com,huawei.com,linux.alibaba.com,oracle.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42518-lists,linux-pm=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[catalin.marinas@arm.com,linux-pm@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,arm.com:mid,arm.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1D19B126B04
X-Rspamd-Action: no action

On Sun, Feb 08, 2026 at 06:31:49PM -0800, Ankur Arora wrote:
> Add the atomic long wrappers for the cond-load timeout interfaces.
> 
> Cc: Will Deacon <will@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

