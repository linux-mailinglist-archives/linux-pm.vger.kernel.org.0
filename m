Return-Path: <linux-pm+bounces-41580-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IFMYKUoteWk9vwEAu9opvQ
	(envelope-from <linux-pm+bounces-41580-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 27 Jan 2026 22:25:30 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EEFDC9AB0B
	for <lists+linux-pm@lfdr.de>; Tue, 27 Jan 2026 22:25:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 767B6302D5D4
	for <lists+linux-pm@lfdr.de>; Tue, 27 Jan 2026 21:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE03D29A31C;
	Tue, 27 Jan 2026 21:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="BGgwXnBG"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5D8299949
	for <linux-pm@vger.kernel.org>; Tue, 27 Jan 2026 21:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769549114; cv=none; b=BMxsNDrwi6VKM3yhdoVBxCXZtHYm+EMksn6Ma9Lef4GDNmD/e0pyTwEXkpHMRhyHfO3L+zDQO1sx4wLclKWwsLd/+1t0DJNr3tdWBDjoaNNnRxPIh/nYAGEB0AsAP9CMesoMEfnEE7yZuQdo6umi5YsnVslw3rRo/IaP166O9eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769549114; c=relaxed/simple;
	bh=jVg2sq0i2FG6o9FjCNKPhQuA6q+fa0mYRD/1zcVfWOM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iEi5mWv8g96X3DvDXOfWQZ4jIYy5t3dOsG6Epoq83F4BiKHWNIWxEVFHv2uxegZU4bMrKFLENe1pEuWWoIyd9bUdBvf1I0ca6bpA7qk+eK5XMrnqpienyKq2r7Sa2p8noOAF8b4kuZL6afp6MqVPoglTce5T30LG7omH6eTJzdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=BGgwXnBG; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-bc29d64b39dso2236758a12.3
        for <linux-pm@vger.kernel.org>; Tue, 27 Jan 2026 13:25:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1769549112; x=1770153912; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=jVg2sq0i2FG6o9FjCNKPhQuA6q+fa0mYRD/1zcVfWOM=;
        b=BGgwXnBGh0/SbIpmnx29/DCLhzfO2G9Avq91v9MwxLoHfBUe4/7yvYTi9yAoDnzx/D
         ImXv0owabmKIzW3YlF6PWksYIEF/YDiROhPw5iMmGLPX8VDs7eU9jK0dNmYeQ2xnvMbC
         degS8potCaACqXdA3lA9BUrZPV2SOInMh3tWQjH+NwXxSNow+OJ8uZM+MQLYycc42M8E
         GeF/nwTGv9p4gM4GJsWMle5bBPmZXTgiwXuZS6fYfeTGsZ3ty8e5dOItGtjXPHpntAvn
         aD3nLMNWP9GGrubLXoCdeJ3dC2o53kDdhhid4eZ+FMCDtRt3MwY3kcvdwaPINzq1firf
         4zLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769549112; x=1770153912;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jVg2sq0i2FG6o9FjCNKPhQuA6q+fa0mYRD/1zcVfWOM=;
        b=E5vq6BMNXxL/86Wd7VgpVHw/ckzj8iN9N4b0/OrnNBp+ajPLj69N0FQJ1o/V+D0gMN
         0XjH7f8wJLWhHUUD6i5Kj5ayE9zzOndXr2SBWQRQBsFysYMdjTsrI9bYAhrGgFCTIDFD
         uZlBqhvLX3dbMqfbPGXybGQkxBUcn5FprcdJyK0r0yKeI3C2D8yMfGOAZXOo/qMgSQfr
         tNS7wQJNXYXQzm7m/cCq9qRCObT4bzkOgDHkFxjr/3UsRnMqGis2qZydW7Sb1HNsPG3F
         tlmSnMWx1yxQTdymK2F7TB91mqcW8k3R5I8Z+Df0Z7s69NIlNJ2tlJzy5eRpa/Lh1pIs
         aD4w==
X-Forwarded-Encrypted: i=1; AJvYcCXdlPPSRdSNeutkvzFiOldlqRyl9U7PJfPvFhptSTMiKy6yZJdIIIqBZBhNBiFSkDEP/Tl8xhDK3g==@vger.kernel.org
X-Gm-Message-State: AOJu0YyGO5PDX2Uz6pwOPk7Ly279xu7rwnGsmx4qwxQBmcKo9htCoN/g
	S4RFMJvenX2XbQp+I0Q1dkh8adGzghX3MqiUoyU9+LXzPsG7GVCA0oQMriYbEaIl730xZJbCYMs
	4aCs2GlM=
X-Gm-Gg: AZuq6aIixEntddKlh0wRlAGwiZQByK+2KVzQbxGRnvYSNmPpOnDIiMoefL47mLQBmxg
	e48weixFMbCCyf3/bgQ1RFcxALpMdbftzzpb+urZPffkS0RpLQ3dBwCK2EYhugOK2r6Bw3ABAsV
	kFObQFL21OF1CoryM7AQs5GcQkvwzuu3eO3hC5aeNKatKlyP9/m35klp2SWYS5JH/KcGPYyvxVc
	S7OPmJBanDRkmmwERcWL4/qO8cnckAawf1dtSi9Wl59wDbI/kxHHWd3GMa9DAHOCCqnQN4kI2Pq
	GoY4daWMjRn+8WyyYx0nw3iYZtC9Yo9aZdPKQizCrc0CiislViEONpTXQ0LhUUUh667saRW8l92
	1jq16oLhSMeRYd5//lPWf45maFdd0xp3+AuPhSV4GmzSTafXjWGMXC73wkMKPU/JC7SR6BAfGdV
	U0yljjCSgM
X-Received: by 2002:a17:90b:3a81:b0:34c:cb3c:f544 with SMTP id 98e67ed59e1d1-353fecde876mr2663861a91.14.1769549111946;
        Tue, 27 Jan 2026 13:25:11 -0800 (PST)
Received: from localhost ([71.212.200.220])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-353f61dfac1sm3475922a91.9.2026.01.27.13.25.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 13:25:11 -0800 (PST)
From: Kevin Hilman <khilman@baylibre.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, Ulf Hansson
 <ulf.hansson@linaro.org>, Dhruva Gole <d-gole@ti.com>,
 linux-pm@vger.kernel.org
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] pmdomain: core: Extend domain idle states debugfs
 support
In-Reply-To: <20260119143121.161583-1-ulf.hansson@linaro.org>
References: <20260119143121.161583-1-ulf.hansson@linaro.org>
Date: Tue, 27 Jan 2026 13:25:11 -0800
Message-ID: <7h8qdi6954.fsf@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[baylibre-com.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[baylibre-com.20230601.gappssmtp.com:+];
	DMARC_NA(0.00)[baylibre.com];
	TAGGED_FROM(0.00)[bounces-41580-lists,linux-pm=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[khilman@baylibre.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EEFDC9AB0B
X-Rspamd-Action: no action

Ulf Hansson <ulf.hansson@linaro.org> writes:

> This small series moves around and extends the information that genpd shows for
> the domain idle states in debugs.
>
> Please help review and test!

Reviewed-by: Kevin Hilman <khilman@baylibre.com>

