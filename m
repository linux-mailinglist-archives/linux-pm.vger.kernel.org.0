Return-Path: <linux-pm+bounces-42479-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id FZQuMaTci2k9cQAAu9opvQ
	(envelope-from <linux-pm+bounces-42479-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 11 Feb 2026 02:34:28 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 615CB12079B
	for <lists+linux-pm@lfdr.de>; Wed, 11 Feb 2026 02:34:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 91976300DEFC
	for <lists+linux-pm@lfdr.de>; Wed, 11 Feb 2026 01:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E6B923B615;
	Wed, 11 Feb 2026 01:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cqYRKg58"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28953218596
	for <linux-pm@vger.kernel.org>; Wed, 11 Feb 2026 01:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770773663; cv=none; b=KsmD52i2UO3fgSwuJ0YgwE0/sqal0LnXmUc36S5TDXd2pMItvhINlnaeSVZUDNoJTAfxBrcNjqjXFJRqB07USDyawyyU+ORt+duBEv2m5M6AmeOCZ6eUsvi36nUsz7onagNiRYPPmsUg8RXplTvGMkCLvYo/CgWdNnzzCXpFKDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770773663; c=relaxed/simple;
	bh=A8nICfib0TyQ1veAYiZTePZtta6HfMcxlT3QckErAro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LpaPa0WBszj7y0JacPoQHL/mLxZuvLmz4sbVNmA7ITZzv1wvQcjlRK0tW5ZqkHVrFYbhwuKj2qb2+fSzdE5P2Gp3dV3WIA64QRCa5ZHQW6fQpS6Cew1mZfXsF54ULGOYAE8Xpn2jHdHeFF0prLTABe418u4XDmv6IzPiTqW6Q/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=cqYRKg58; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2a8fba3f769so27223665ad.2
        for <linux-pm@vger.kernel.org>; Tue, 10 Feb 2026 17:34:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1770773661; x=1771378461; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=L8YQjWm58lWYBHnmQ2ylv8+SOgWGHnRAFzYCue4QlMc=;
        b=cqYRKg58YA2N555xOkDVinmSTHhH+8j/ZiZgyRcrfecq+ulNLzfl+qYs6dJQtDjiRA
         gcB0vaK6yBTskk3TXA8qHdBUxkOfEctAN+rUpntspW/g+lCo1b2bh1Me/5fLCi6dvXPC
         ycXYeJ4WlxQ4YHdNewxRkqLTkUJNjD624bqw4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770773661; x=1771378461;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L8YQjWm58lWYBHnmQ2ylv8+SOgWGHnRAFzYCue4QlMc=;
        b=WKAOiqOqkEBP2uCfrMp/JTlLZn1vu9kXU031JDJLXw/Ak9+Gp2aQEMElXiwGicrwIb
         D1+t4y12jYBx3SVo+5ji2D/UOCpxxu32eWO3sYg1dpWm5MfIVacOVcx8Km4SZUb3qtI9
         3eqttogVl/VNTCgfTc59oTdLX5aqsYkx3SlIb0hK5meSLMsVcTRgbdJFKCh1Zfwp8kzy
         FFVOLN7t2VFR/QwPWf9JygQMkFgf+WKQ/Gk/aNgfTPZO/pLCMJwfmCknLlCpTNPyTNAb
         u1tdrXlHftEZ5Cc6kAyyiVt22LkIUBKg3LRioy/ez4GmGeLjzYYhrH/wxZAqDo2dCKIn
         NoDw==
X-Forwarded-Encrypted: i=1; AJvYcCX2HUpocc0W+ctBp98gx+CKv9RVoEqWjDt1MSmdfGvxKmC+6zPsZ9ngC1ifGWX9x6ksM8V2QH27kA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxN1+fekpXyOizazW6P07ActSlmEiGzF/2p0KjrcYk4DY/LSvmT
	l5JKDiUa69cJxw85lITQfsG/Op6EzJCbKXana6CYOuLnuOunWBsIeTiQORg4KrpHTw==
X-Gm-Gg: AZuq6aJjp5821PKjx7tcMnoHrBYXvy5TDdI4l1ByStSJymScWbORBlpSgjDF4xyHjwb
	RiEs4ECty50UIEEUnoTbi8mw7WhdwYNLRvebMAFWri18xSiCoBd7En0EjF8Ysi6u9tvdVdvnfty
	2n28e1qtvcdMWNhknwJO5/FTTqFi+vfs2de9JazUoPNiS1UrV3KakSFqXCOoIqXEz87vNlnVwVe
	bCq/7rCIsitS7yYa8YIyAvc92bg7Ng9iFHuYYjldbeCwxcSvPZ9zdZ3TaDBqwfushE1JLfv1Sv0
	jVEA0uESHIYuMNugrN6xJ7b4IXYUqfSPCxZOvPjL1asiLogAMFr7dQ0vMScNZNPz5TE+DWGHp3V
	KTkKz1KJWC/mXYqNMZMQu9QSYaJVMEMO2Ml2C9FhcXRWlnw53iTcAyBAQ/P0l3cAWHI9Y5n6Vfz
	0aYb1f2n+YBHqoaXj59+gCKDg7zx+OlJfOBcnWjlaE53yQSwHxZv6ns09av0dRcg==
X-Received: by 2002:a17:902:d481:b0:2a7:63dd:349b with SMTP id d9443c01a7336-2ab102f4d0fmr38295215ad.10.1770773661497;
        Tue, 10 Feb 2026 17:34:21 -0800 (PST)
Received: from google.com ([2a00:79e0:2031:6:ec5:3497:e96b:e7be])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ab296e5a72sm3932525ad.0.2026.02.10.17.34.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 17:34:20 -0800 (PST)
Date: Wed, 11 Feb 2026 10:34:17 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Xueqin Luo <luoxueqin@kylinos.cn>, dsmythies@telus.net, christian.loehle@arm.com, 
	daniel.lezcano@linaro.org, gregkh@linuxfoundation.org, harshvardhan.j.jha@oracle.com, 
	linux-pm@vger.kernel.org, sashal@kernel.org, stable@vger.kernel.org
Subject: Re: Performance regressions introduced via Revert "cpuidle: menu:
 Avoid discarding useful information" on 5.15 LTS
Message-ID: <ba2bwuhcua2zakojk2wcksyxol76o7lmmceaunls4436gqh4ry@ys3mpganxhwy>
References: <006601dc965c$afe30280$0fa90780$@telus.net>
 <20260210093321.71876-1-luoxueqin@kylinos.cn>
 <67clm4sqv5cbqxjhjoyn4eodwocc2jm6piwky6cyv4zncfrp7p@izdkjc5db37j>
 <CAJZ5v0gxNdQG8O32PrBcSa3GGvQCYObrquuiUXyJ8kgPV=91Sg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0gxNdQG8O32PrBcSa3GGvQCYObrquuiUXyJ8kgPV=91Sg@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[chromium.org,none];
	R_DKIM_ALLOW(-0.20)[chromium.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-42479-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[chromium.org:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[senozhatsky@chromium.org,linux-pm@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-pm];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 615CB12079B
X-Rspamd-Action: no action

On (26/02/10 15:24), Rafael J. Wysocki wrote:
> On Tue, Feb 10, 2026 at 11:04 AM Sergey Senozhatsky
> <senozhatsky@chromium.org> wrote:
> >
> > On (26/02/10 17:33), Xueqin Luo wrote:
> > >
> > > In addition to the cpuidle statistics, measured system idle power is
> > > about 2W higher when this commit is applied.
> > >
> >
> > We also noticed shorted battery life on some of the affected laptops.
> 
> Was the difference significant?

I think I saw up to "5.16% regression in perf.minutes_battery_life"

