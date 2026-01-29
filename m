Return-Path: <linux-pm+bounces-41661-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4MD+HvuyemmK9QEAu9opvQ
	(envelope-from <linux-pm+bounces-41661-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 29 Jan 2026 02:08:11 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F1556AA7FF
	for <lists+linux-pm@lfdr.de>; Thu, 29 Jan 2026 02:08:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8DE3E3012263
	for <lists+linux-pm@lfdr.de>; Thu, 29 Jan 2026 01:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFF6424679C;
	Thu, 29 Jan 2026 01:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="liRGX9I2"
X-Original-To: linux-pm@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFDD417C211;
	Thu, 29 Jan 2026 01:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769648888; cv=none; b=lzVVQKnIDFGKMsIbWVG/u12ATpQNzUqUwcLE51awsyg39l8T9OZ8b8pRDUi/HndMAHN+x3IgUlJ5x0qEc8TFpiQ0et28tvEiNTH4ZI22x2VDhK4xp5HFK16Rua0h+2s/GZB+b28Lk64AgqrENgDKdBOc0gawPDhqqHWKdlEBMd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769648888; c=relaxed/simple;
	bh=hH7hpNuuk250378KgVoveSmuIcV7t5ugJr4/6o4AroM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Lu8ZG2W+RahozMNCNNVKjYKHnDXy8MvntRgsivSS1UMDJHFxhRzddIPJUSkfiCefIqZ856fGYK0N5+3YUWYHUllEsoOOefmFvSg4MaTr4FlJHRkcU10c0nuFM8g0F98RlkDl4mSxKvtoxdq/kaJQZhvM93uKzGNNApU9Vv4/QPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=liRGX9I2; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=VGckf5VUEfiU+9RfQobR4u99DufrNO9iUBywgMAfJyA=; b=liRGX9I2VVXa4DRjKPDKBGJplE
	c3lxr5bbSLg3862RIlG31AlEEgl3QmfixWU5CxhN4lO189s5UIbbOmfR+HX4EWKO9xvW24tDhDwPE
	hSVcmnmMBJge1PUbShphzih1tAkcQSYY1FdYZrgthTf443GuBC1ObHa6fN71SRbf0gjl296/iOEHG
	2tajH4/iZgMuqsZecHbOOF181CRGvK60BYXUKdDMMnGPFl26fjqVyuw+r2zUitbbJ4LaXm23xG1Sq
	SEhojQOV7SiatBvBVvVY7eq2ZeLb1UmMSlXeQbqXghOLir9EfMcGMAbR+ztLPwU8ZJ4x7OUfc1efW
	qy06YXcA==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vlGVw-0000000H1uO-3izM;
	Thu, 29 Jan 2026 01:08:04 +0000
Message-ID: <e0b19d1d-6e7b-4873-af6a-94dc2434d668@infradead.org>
Date: Wed, 28 Jan 2026 17:08:04 -0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] Documentation: Fix typos
To: Patrick Little <plittle@gmail.com>, Joseph Kogut
 <joseph.kogut@gmail.com>, Lukasz Luba <lukasz.luba@arm.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Pavel Machek <pavel@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
References: <20260128-documentation-fix-grammar-v1-0-39238dc471f9@gmail.com>
 <20260128-documentation-fix-grammar-v1-1-39238dc471f9@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20260128-documentation-fix-grammar-v1-1-39238dc471f9@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-41661-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com,arm.com,kernel.org,lwn.net];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rdunlap@infradead.org,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,infradead.org:dkim,infradead.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F1556AA7FF
X-Rspamd-Action: no action



On 1/28/26 2:33 PM, Patrick Little wrote:
> Fix typos in Documentation.
> 
> Signed-off-by: Patrick Little <plittle@gmail.com>


Acked-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.
> ---
>  Documentation/power/energy-model.rst     | 14 +++++++-------
>  Documentation/scheduler/sched-energy.rst |  8 ++++----
>  2 files changed, 11 insertions(+), 11 deletions(-)
> 

-- 
~Randy

