Return-Path: <linux-pm+bounces-43575-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aCwDDhAXqGlTnwAAu9opvQ
	(envelope-from <linux-pm+bounces-43575-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 04 Mar 2026 12:27:12 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A71BC1FEF8B
	for <lists+linux-pm@lfdr.de>; Wed, 04 Mar 2026 12:27:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9DDA030F57D6
	for <lists+linux-pm@lfdr.de>; Wed,  4 Mar 2026 11:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCA2F3A8741;
	Wed,  4 Mar 2026 11:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T5TSj4w6"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C1AA3ACA5D
	for <linux-pm@vger.kernel.org>; Wed,  4 Mar 2026 11:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772623541; cv=pass; b=uyKaxl9+peDAqZQ4TpzStrYWonJPuWMKgShII/m9fI0co6NIkgawxvJilGsPkvs3+TKmWDvk98P6ShJ7izOHMt+Wt5x/HLLmW8jl+dQTlYblrWYfCcZJd3tBoMFo1uB6nGZfCQWO9WYHPYMtqnnn0ZCQSJYSzkGy4yEQ5fVMxSM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772623541; c=relaxed/simple;
	bh=BtRkwfk+PNdh4uDlD82Pllah5hbXu3rUufazzxcR51E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Au1r5nbe7MnT1g6kdWS1g++yNwFUdLYp5ppNubiw+M4uWSNGwBhCGegi+12GirhrN0AQZSxTHYnJBfQA5W4tIEXS8+AZdQnf9c+b//UCIi2kTiRB3hbCOTTuRoKGf8aU2R10dtXsdfuYY3CnEYZmHPyxnSghikH3ye8rYBHxa2s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=T5TSj4w6; arc=pass smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-389fad34e2eso110393901fa.3
        for <linux-pm@vger.kernel.org>; Wed, 04 Mar 2026 03:25:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772623538; cv=none;
        d=google.com; s=arc-20240605;
        b=ZapSmF5xEqeCFY7HWPTTeLcBgZRLpr/MdlYKG3ya0X31I9VXFpn0o0RtoPgswAuTwa
         9hUt7IFMfBWFsdCIVQFUYXmiIMxfOHSGUeHEtzHpQ5WFdnimKPKfvIzTIcocZoJRwpXO
         9yP94jw+n22mFkiwimtKBST5LPerJnfYr5zQhogdvx8qh00Tg3x0n/U/84bOYU24KdRk
         2wn3iWDEUx7qLRdkRxu134r0XOG4ckLmgqpj9S7KE0u5AdP7K2tlbpLKvBL91oc3PT2K
         TwDlmGSoRtBaXJYngozXbN1xuzKdq4VchjR5DKuyu3CZbFoed/R2LJTOIuzv9Gv8OdzG
         2GmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=BtRkwfk+PNdh4uDlD82Pllah5hbXu3rUufazzxcR51E=;
        fh=0dgeAWIipId1ulypJCzYzoPPI7pVYfbAcWZ8DgkEYXk=;
        b=RQHVeya8Fa+xty41yb9zxCEOhEmJmlHG7W+2IBayFYiQvzwEdgz9gUfj12JdtoDtWX
         MEbg1t9t2lxtsBMZPm7ft0CMY28UlkxB+wpK89IApd1StTrIEFnt/VCu302/J2HkNYat
         wiu0ODCy2NGHy8NkCfTX6+KAlJ9SMCiDQrC0mMUDs/dOo1rFtc3MznUFX0WhORBYdYJz
         PO5wAeNYQrAMNDkwZpRmjLBZVF7m6cwfthlf8H2HpG3Kxc5zME8PbGinh0kwAMVrUMI0
         5yKEdA1/hijrDrjIHLkltHQ617JqNVjJvswBewNuGL+/SvRZV07GHm4HixZ09wHyq+9H
         gCUQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1772623538; x=1773228338; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BtRkwfk+PNdh4uDlD82Pllah5hbXu3rUufazzxcR51E=;
        b=T5TSj4w6YCcC4FcTV6sQlVtlR/cP1rXYBQyMaBw4auw11Qxr5TsfT/b9zY0h/hxcCp
         WGzPCjDl9GNUYFje2mMmJrUfuCAORYICS+TveH0DmZWNu7ki540wkABoJ7+c41AOFuz8
         SYCslW0b23vF7nThUSsFxm7lpAmw+s00qxjGxIbwwSs5BL4kafcVq8bhyr7lXnZs7+bj
         635y9nXCQHzOGJeakmKJYh4FLYeN8/SYGT9onxMk1Q1Fi0op0oJ4mscr5QhnMsJCdzfJ
         smckrREdLSXLcbBS0cBGaMko/AvqF6t3iGrd3/CnuroLgTd5mllTqj4RB9OGxxzWksvQ
         Xksw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772623538; x=1773228338;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BtRkwfk+PNdh4uDlD82Pllah5hbXu3rUufazzxcR51E=;
        b=HLK9pgZ9L+FYi91SC2Zfj75aABjkp27BrHCQn1kD960IOtcnNkY754UTaW7f1GUEm8
         4PmyrwtCdNU4oas4vNHlAIhKfLJ1EhvmchZEGS5XiQIXFE61nK6t9IqJhRGCmI4OPyVa
         X2Y4KTZ+RsEh8kMo5QednSqiSTe+jtLO+plMnui3Y2RESWJtAHtJJDXFGDbUZQTcEskT
         yAPup1QBcU3K+owvXdQ/9Z9wld6lfjPf2iZ8RqQiP3SJ+1m6goa7VUCLplpX6/AMtBb2
         lGymAq7ZAWIsVe1dz1WnzDfLxa3sOB5lLIhqylhNEPPb/hGvaVufrJ7L9zC3ZkWyBKTR
         D+oQ==
X-Forwarded-Encrypted: i=1; AJvYcCXPy6oiQPa1LJc0hIiadqAqCE/2uMYh8o9gcYGjkF9hNXtDXLeT/14sLmwOeNy5exP5u8zB8E+70w==@vger.kernel.org
X-Gm-Message-State: AOJu0YxwfZrFpq0+xAd4OdokHdbROPHr0rrse3/8V6TL+v0jx27p654N
	q8rnwaD1dITZjulnoSMjwksK2Y5UhK/9oQqOaj0Oduz/OohCFsztqFmFRAYlJz3Wff95kssEpNA
	EGBjokFt4xSbOlVgBolv0h9AqlzaPDv19qoPo/bLLnyq+fRsZhZrJ9Mo=
X-Gm-Gg: ATEYQzwUKcwMFTyx/zwvw9StdOIlNa60JkS7bhYSWbNNV7GWpuuVqpMvXmQT+RMr1V8
	hfaN14IoIsRSCGGlvCQLADTflYZahcWXGuzRc1oLFMnHI9Z8yRPv9ALJ9mE7EeiQ2qYbEhQNZAb
	KkAPqe4t9Gjh1as0PuoO71uwyoBmCGbrUWZfrOTaNtIu+CbnluEV36KOx+fmEaFBtqgAil9KhDC
	7f5/4OiNBzDhw6fUJLp1jMuCRo9pGoAAEijVcpbkwTGw7+uioSsUYRSym3f5k0ZFEA0nnYRGhlW
	7FhIwzh8
X-Received: by 2002:a2e:bc85:0:b0:38a:291c:dbcc with SMTP id
 38308e7fff4ca-38a2c5b1e30mr14538301fa.19.1772623538449; Wed, 04 Mar 2026
 03:25:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260304101457.7470-1-ulf.hansson@linaro.org> <aagINsZj6sgR7pNY@pluto>
In-Reply-To: <aagINsZj6sgR7pNY@pluto>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 4 Mar 2026 12:25:02 +0100
X-Gm-Features: AaiRm50EmpkkbwvQCpRktsjqw5A47RE-7PTWTUJApXKOBbCTS7pFpVE9W3izezc
Message-ID: <CAPDyKFqQQF1BJODNNuRLAathyM4oRFfXJfcx83Db2usRbxQPgw@mail.gmail.com>
Subject: Re: [PATCH] pmdomain: arm: Add print after a successful probe for
 SCMI power domains
To: Cristian Marussi <cristian.marussi@arm.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>, linux-pm@vger.kernel.org, 
	arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: A71BC1FEF8B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43575-lists,linux-pm=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ulf.hansson@linaro.org,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[linaro.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pm];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid,linaro.org:dkim]
X-Rspamd-Action: no action

On Wed, 4 Mar 2026 at 11:24, Cristian Marussi <cristian.marussi@arm.com> wrote:
>
> On Wed, Mar 04, 2026 at 11:14:57AM +0100, Ulf Hansson wrote:
> > It can be discussed how useful a print is after a successful probe. In the
> > SCMI power domain case it's seems valuable, as it let us inform about the
> > number of initialized power domains too, which is fetched from firmware.
>
> Hi,
>
> yes indeed we tend to print such 'summary' info at the end of a
> successful probe in other SCMI drivers.
>
> LGTM.
> Review-by: Cristian Marussi <cristian.marussi@arm.com>

Thanks! I have queued this up for v7.1.

Kind regards
Uffe

