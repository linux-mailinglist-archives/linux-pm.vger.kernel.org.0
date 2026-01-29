Return-Path: <linux-pm+bounces-41662-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +DQ/ERmzemmK9QEAu9opvQ
	(envelope-from <linux-pm+bounces-41662-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 29 Jan 2026 02:08:41 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C1F07AA835
	for <lists+linux-pm@lfdr.de>; Thu, 29 Jan 2026 02:08:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E9A873036ED7
	for <lists+linux-pm@lfdr.de>; Thu, 29 Jan 2026 01:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88B5F2C159A;
	Thu, 29 Jan 2026 01:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rImBp6B8"
X-Original-To: linux-pm@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4719A310624;
	Thu, 29 Jan 2026 01:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769648891; cv=none; b=mkQ3E5aeX7Lx9UvE/q0lWqIr94URHp5JeXvJBeYFdMV4bHgO2KoxMwgP4Tc0afIY5sG1kSrGXtOXrGmM0/JchaK+9mTz1Jb9fH8DwTRB9CvjFLnn7Vg+AS1q2+8qAbbf0u0hqyLtWHiwYkwugVZY0BNlVmdikGSzT21eAdlbFes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769648891; c=relaxed/simple;
	bh=jmDhWuxJWDxCeN7/p3kSht7dkjA3Tl7MydVvPNlzoT0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N17Wf2RauLzWqXUinfLkBNiZXIu/4bB6EHYzJYa4cZ5KM5g4FJBcifAJS5UB7XVd2QLVWBJ0H0/sZiAqul1SQdMpE4UCgjeiaSYzeAUFieJq7fwlywEZXlrOLTaHWuH8jdrx9KF58ilvnNgWHqJtDlaOxlWQeICRyYDVPhUGwlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=rImBp6B8; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=1IuMORudo2OJtlyP5mwxKqHZD2Siz3SzFKaoDhDY5x8=; b=rImBp6B8najp0qvMyu9Q6VfgbX
	M0/TtDDl7wGDM7+R7cOW1tKCHVzSDo4L9zjuF1MGZibRFsadDCtXkKY9/spshGlMgr6TtWIbYGnbj
	3zf7XJqaMwyfD2sNoCE8kn1ms/L4Mis0Kk5sJ7+HRMNFY+14ZMwWld8RoTiXH1/3bo+K6ItgkrcWa
	DAuu750N26BUwfDCiagWIS5W8OfeZO53plkRUJ6MslN+jo5DI2r/0WXYHzwL+fO/1v9m4LF7jVhxo
	aHWAgYItOwqyoFdx0zUeqvQVvyv1qAzMkyg3iZ3RWWG1VerpnJn6FhUP/i2lYDAddLPpMLVTWwOzF
	39wNV8QA==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vlGW0-0000000H1uO-3SRy;
	Thu, 29 Jan 2026 01:08:08 +0000
Message-ID: <1c0b6a0f-abf6-43b9-84c9-5911087f23c4@infradead.org>
Date: Wed, 28 Jan 2026 17:08:08 -0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] Documentation: Fix bug in example code snippet
To: Patrick Little <plittle@gmail.com>, Joseph Kogut
 <joseph.kogut@gmail.com>, Lukasz Luba <lukasz.luba@arm.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Pavel Machek <pavel@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
References: <20260128-documentation-fix-grammar-v1-0-39238dc471f9@gmail.com>
 <20260128-documentation-fix-grammar-v1-2-39238dc471f9@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20260128-documentation-fix-grammar-v1-2-39238dc471f9@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-41662-lists,linux-pm=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,infradead.org:email,infradead.org:dkim,infradead.org:mid]
X-Rspamd-Queue-Id: C1F07AA835
X-Rspamd-Action: no action



On 1/28/26 2:33 PM, Patrick Little wrote:
> A semicolon was mistakenly placed at the end of 'if' statements.
> If example is copied as-is, it would lead to the subsequent return
> being executed unconditionally, which is incorrect, and the rest of the
> function would never be reached.
> 
> Signed-off-by: Patrick Little <plittle@gmail.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  Documentation/power/energy-model.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/power/energy-model.rst b/Documentation/power/energy-model.rst
> index 65133187f2ad..0d4644d72767 100644
> --- a/Documentation/power/energy-model.rst
> +++ b/Documentation/power/energy-model.rst
> @@ -308,12 +308,12 @@ EM framework::
>    05
>    06		/* Use the 'foo' protocol to ceil the frequency */
>    07		freq = foo_get_freq_ceil(dev, *KHz);
> -  08		if (freq < 0);
> +  08		if (freq < 0)
>    09			return freq;
>    10
>    11		/* Estimate the power cost for the dev at the relevant freq. */
>    12		power = foo_estimate_power(dev, freq);
> -  13		if (power < 0);
> +  13		if (power < 0)
>    14			return power;
>    15
>    16		/* Return the values to the EM framework */
> 

-- 
~Randy

