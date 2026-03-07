Return-Path: <linux-pm+bounces-43893-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +HZoMvb9q2mfiwEAu9opvQ
	(envelope-from <linux-pm+bounces-43893-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Sat, 07 Mar 2026 11:29:10 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E19022B0D0
	for <lists+linux-pm@lfdr.de>; Sat, 07 Mar 2026 11:29:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 72DF4300F5CF
	for <lists+linux-pm@lfdr.de>; Sat,  7 Mar 2026 10:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95A53374753;
	Sat,  7 Mar 2026 10:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tQZVGDp5"
X-Original-To: linux-pm@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161DE30BB97
	for <linux-pm@vger.kernel.org>; Sat,  7 Mar 2026 10:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772879347; cv=none; b=ttghB2h1d/DzAyocjI7AN2NsS/lkRob43s44gtFPdCYff6NFEkVRPhaDA4oR9NPZXpSCUGyXYVj2y/8t3OrWBgEJvji4fbbz9Sd7c31+QND/YpMuGeNgu6enzZJq4yjG+o2rJ9LpS07p/c6p96wZE2KfP6ukBqdeP6e5+pcoeGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772879347; c=relaxed/simple;
	bh=ZqnMWuFNvDkRIvArOV8O4w1Fh9L2ypA0GJte+TskoUE=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=NtUqW4V4tqTFo4ZsyeMbBugYnMoZeBXz528m5wbR2NHSKfBtHuhneaG1ztUfF88QbCUh/t7xcqp8kf5+fivb701XsgVodR13P7NZAEzHmSlmGcQrZ9Rf/uMSDCAaT238bnW71GQU5b+Fry6aNh9bkaTvN1Hl00iIydB4xoIRc2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tQZVGDp5; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772879343;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZqnMWuFNvDkRIvArOV8O4w1Fh9L2ypA0GJte+TskoUE=;
	b=tQZVGDp5gMZZ3dXdl6jjDpsk42lJFnH2jc/EYHQZE9N+n9WBCSRYi45Ttqouspz9cwRorj
	HYpHVEypXZC+gzoVdu7LKRv5SLU7sMwEpXCu5d4q2gcTtsvEsRODynKDJB1rIw25TF2pku
	jrYmH/A64iT0EicNtzCKSh6cnyNAq4g=
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.4\))
Subject: Re: [PATCH RESEND 2/2] thermal: sprd: Fix raw temperature clamping in
 sprd_thm_rawdata_to_temp
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
In-Reply-To: <20260307102422.306055-2-thorsten.blum@linux.dev>
Date: Sat, 7 Mar 2026 11:28:30 +0100
Cc: stable@vger.kernel.org,
 linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <688F36E4-511F-4C41-9EB8-5B14BA410AE3@linux.dev>
References: <20260307102422.306055-1-thorsten.blum@linux.dev>
 <20260307102422.306055-2-thorsten.blum@linux.dev>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@kernel.org>,
 Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>,
 Orson Zhai <orsonzhai@gmail.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Chunyan Zhang <zhang.lyra@gmail.com>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: 2E19022B0D0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-43893-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,intel.com,arm.com,gmail.com,linux.alibaba.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linux.dev:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thorsten.blum@linux.dev,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.959];
	TAGGED_RCPT(0.00)[linux-pm];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alibaba.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.dev:dkim,linux.dev:email,linux.dev:mid]
X-Rspamd-Action: no action

On 7. Mar 2026, at 11:24, Thorsten Blum wrote:
> The raw temperature data was never clamped to SPRD_THM_RAW_DATA_LOW or
> SPRD_THM_RAW_DATA_HIGH because the return value of clamp() was not =
used.
> Fix this by assigning the clamped value to 'rawdata'.
>=20
> Casting SPRD_THM_RAW_DATA_LOW and SPRD_THM_RAW_DATA_HIGH to u32 is =
also
> redundant and can be removed.
>=20
> Fixes: 554fdbaf19b1 ("thermal: sprd: Add Spreadtrum thermal driver =
support")
> Cc: stable@vger.kernel.org
> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
> drivers/thermal/sprd_thermal.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
> [...]

Feel free to squash them as they touch the same file and fix the same
commit.

Thanks,
Thorsten


