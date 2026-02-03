Return-Path: <linux-pm+bounces-41955-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AAGRDlHVgWkCKgMAu9opvQ
	(envelope-from <linux-pm+bounces-41955-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 03 Feb 2026 12:00:33 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D1D40D8032
	for <lists+linux-pm@lfdr.de>; Tue, 03 Feb 2026 12:00:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 13FB33004DC0
	for <lists+linux-pm@lfdr.de>; Tue,  3 Feb 2026 11:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A46D32C33D;
	Tue,  3 Feb 2026 11:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bBRpzMFW"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8229223184A
	for <linux-pm@vger.kernel.org>; Tue,  3 Feb 2026 11:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770116431; cv=none; b=qu1XzslAmC3oUcnfNYtx/Aqw/X4CdOT7bFp1xMUZyqbNDW9mMrYW6K/BKgtmQao6ezbeboziyn2g4pjskpqQ00aJ93SPiXvxLywuIug5h2ASpZIy7olWACfAHXqSWU+k9AI7T1op3cZhXxwYyfhiUtTS1XNOANlNYJKvI18mgzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770116431; c=relaxed/simple;
	bh=hudPfaB5Y8u+39+QhqcnbqU4DSfvZiJpkZwi23yNzcM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tfHRW5JvFLMu1aWnv9DdExZZL+SlYY+1GfZyNU35MKfCq5x6rd7AsVqCdSVQ8l/KYUyXqix6WtAxujNPzCzSX71ZyhYaFuSTVDj+E+pA3kSW1zeUyvRxYvvSzuOFv/zWWCoqqdRYrtK0zt4wGYysRAwG0TWQZeThk1G1nLfTQ1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bBRpzMFW; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-2b6b0500e06so8095288eec.1
        for <linux-pm@vger.kernel.org>; Tue, 03 Feb 2026 03:00:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770116428; x=1770721228; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0JgnMsXOh9YRopf/e3+gz8PgFtk2UitVTNFeIUt3zTk=;
        b=bBRpzMFWc8IrJor0xe+IV8RxvGmwWg2IpM+53bbVASZd4OkxSngWIl2MFsLiOonJoJ
         xcJZQcwaXuyOVM4fqJxUwBvA18HTc/8qpo8MKA3ce1MrHwEBbmkQoyrVPTW16jNpRso6
         ntlLX8WJ3qOMSVmTJKjPs91RM0TI6BRM7U/fR84Mj4wF7q6LHua4cLe3cNcBSOj692a8
         oZjPP5rPdXcjhmS+qCQchB4Yp60mtm4DX6JoAeaiaMUGA4x3dxt3nxItVVc7orX6nLju
         8FIWXxyczFTl+olaraL90nsYdL3tT4xxoCsNtlgv3m7FkABGH/qxnK9B86rwKq1lsEh5
         07dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770116428; x=1770721228;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0JgnMsXOh9YRopf/e3+gz8PgFtk2UitVTNFeIUt3zTk=;
        b=r+h3JNgsMTIBx8Cu4SLoKsyU1QF+jJET48+aJiPUHhgHOEYhXWVeQ191eAg7p5bA26
         LK4c2oQPgQfOqFTnKQ6KyW8kMCLX7jHHHX7mJe2Lh9lXFxjjxGXtQkB4C0MC3EpRKmXn
         k/6ekfKWBnXLX5RmaSD+p11UROoc0AtKiJZO/MAQKjfFlrVd8XEHiBSlPZEobG38dVYq
         bcRiWwP0+Is3Tewq5SL+8n+RHLfSiZqXVugi01ivHAo0dOppVLRYvBVOffgf2JZfhfLg
         PLhcx0VG/FbeYbmpnPqftfCstpQt05aPH/f70s+ts6lyqcY8gU6eUwLZnrRDCpjc3Cwi
         H0Og==
X-Forwarded-Encrypted: i=1; AJvYcCXODHCbHu0hvLj7C5lAA0gMfnP8EsS81g0ipq6f9CmOC1UDFyhaMl5f9vu1gBsuc3Glq+GsA7NnuQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwLP4jJ/oU2Y6RScsGRJEbITPrkV3UYJ+hZhd5EQdHbObMkHCbm
	Ple8ubr5gYyRAwAnEcbMeqj/DvsMPtOmvHuqLYF2r7Ejf8HilvoF6I5+
X-Gm-Gg: AZuq6aI4j1H+fQD9cQwFb8ySjRiVJx5VJIvRJed/T7Lx7BTs3jblsPStrCWf/espFz9
	2rfM867xclaklFmnzxHIAkAPahAetPre2LQ0pxKFLUbAiy1bhWCZFiYel3LbmOcJA7TQhHZD4/k
	lqDZzGW/EiYW6dlG2uU9tPES8oya4rH6kgItzAPv0uIfSwo9fCX8Bx+ixHPYS8Mv6+1z1OJv3zX
	2TX9y5w6Ia6YlatpDuoyzdSlLv60h4dPZptQ8niJOfuriLuxt13NwDiMeYZp9++UI6DnkPTziIZ
	Wa5CrUoAWhqIQTu0FAr6OXMcPHD/+YuVfGwByb+/A1622aJDtGhCtcu+STIvT5TlSHWFYWa/Zu3
	wJN119XmIjLYuqsCTvbgtGLFfxuJ0m57yl8lBOQ7zf7HFIEd2MchxUgd6gi+KLJrEqi7jHxR9OJ
	mTcYlIz3bwI2NTeHg6JbCr0MG1RR5MlzVZmIVkCFY4m6ZGyX+u
X-Received: by 2002:a05:7300:4306:b0:2a4:7f22:cc0d with SMTP id 5a478bee46e88-2b7c8909ad3mr6722053eec.32.1770116428294;
        Tue, 03 Feb 2026 03:00:28 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:ea13:571:b19b:36])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b7a1add664sm22262633eec.26.2026.02.03.03.00.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 03:00:27 -0800 (PST)
Date: Tue, 3 Feb 2026 03:00:24 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Pavel Machek <pavel@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sebastian Reichel <sre@kernel.org>, 
	=?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>, Ion Agorria <ion@agorria.com>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, linux-leds@vger.kernel.org, 
	linux-pm@vger.kernel.org
Subject: Re: [PATCH v1 6/9] input: keyboard: Add driver for Asus Transformer
 dock multimedia keys
Message-ID: <aYHU5g5iOVjrHrE_@google.com>
References: <20260201104343.79231-1-clamor95@gmail.com>
 <20260201104343.79231-7-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260201104343.79231-7-clamor95@gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-41955-lists,linux-pm=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitrytorokhov@gmail.com,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D1D40D8032
X-Rspamd-Action: no action

Hi Svyatoslav,

On Sun, Feb 01, 2026 at 12:43:40PM +0200, Svyatoslav Ryhel wrote:
> +static void asus_ec_input_event(struct input_handle *handle,
> +				unsigned int event_type,
> +				unsigned int event_code, int value)
> +{
> +	struct asus_ec_keys_data *priv = handle->handler->private;
> +
> +	/* Store special key state */
> +	if (event_type == EV_KEY && event_code == KEY_RIGHTALT)
> +		priv->special_key_pressed = !!value;

Is this functionality supposed to be triggered by any keyboard or only
the dock one?

Thanks.

-- 
Dmitry

