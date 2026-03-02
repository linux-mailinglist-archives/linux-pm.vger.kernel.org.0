Return-Path: <linux-pm+bounces-43385-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MBJOFQ1ApWm36gUAu9opvQ
	(envelope-from <linux-pm+bounces-43385-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 02 Mar 2026 08:45:17 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 52EE81D4192
	for <lists+linux-pm@lfdr.de>; Mon, 02 Mar 2026 08:45:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 769233008A5C
	for <lists+linux-pm@lfdr.de>; Mon,  2 Mar 2026 07:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D86BE38550F;
	Mon,  2 Mar 2026 07:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uf+UY05i"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C102383C8D
	for <linux-pm@vger.kernel.org>; Mon,  2 Mar 2026 07:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772437493; cv=pass; b=AQsLUwfw6Uz27KV5ALqJ4KKmvRUNjOkh7l8KsuXXkQXnJfNSWKs39aDBPGAWG3AeglgZBuUGUFk4K3VZeYFoUzeCiNI3orXt2vKeNd0vsxLOqofvJlV7ssUSfiC1oD2zOVJKM/42RpFSCyklLvDqeoQF1pTzT/Vgkn/8p/4ohtE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772437493; c=relaxed/simple;
	bh=eHQq0Mn4I5jgVFbKAU7X9z4l/FCPH9tFnBxQuMQ3Nmg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AUOj/G6yWdNTFXYLW/4l8JG3DM26hMnYFfmYUpHqgJuuHgUOzXP5rqKeIhChlYG3H80/9Fh0AqJCa/hThhxPepNclV9wijeKhW/aC1vKoslxB86Xkdw2M6GlhHDVmuJi1n3eh6KeKsFafgwhfDt5FK4+0ZVpDJZ9lzP2dYYEwYo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uf+UY05i; arc=pass smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-4399851b14bso2860660f8f.1
        for <linux-pm@vger.kernel.org>; Sun, 01 Mar 2026 23:44:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772437491; cv=none;
        d=google.com; s=arc-20240605;
        b=h8AtCvbwzwE4WjlkZRn+qAtmbt64Ap75dLv+60Wfsxv034RJFordkVPrz0IR40leAo
         YYRPAoirWMF5957o+mUW3qbkEU8oHIvP1Hc42jMBvajCMXcERwJ//KFUAwyyjvtr5XL1
         DRBKBDFdFmHJvUmdpXpWMrqRXHMcqPhXAJmdhtsQQOzT8a+3n/GNqQuc7O2MsUHJT7kL
         fSosiiKWqLuVJckh2KY5eSZ2U1Fp9EPLAg6NPEkZ0P9nfVf2rwGw/6O1tRzKEyB4s65x
         Usc7IUjvw/fqp4kG0KOHMYvR5GEZmEZRKPa18yEC6ScpqoqwNlIHMI2rel3c+c7qHUCU
         4lbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SigtsR5BoloHk2svJ3ROPknj1i2mSRr9B2CFMiOEu7E=;
        fh=a0+HapsVEptgVnfoQgsG0pqv1c4r0eYGCZtzOfHTcEA=;
        b=JhEZ/FMgTkRmmOZYchkoPIJ9Ka1QLf0jDZkcljvx2kg35hb3WoEyb9CuF3bKsXxQtm
         H+rFcpAlIwKfaButg+8OL5HdgLRaX8vSrgbpxWdwIB5GohtAbCE15q/CRxdy1bgzhh+S
         DU3PytVHik2iiC7/ITosMSQwCesqBZYNlNDYgrCns1DsRaJvpe/kaq9EvAQEMjnMB+lK
         3kTfsYjHbHsJJ4qLHUE1tBMnlvWsOYlCfseLkqFlI32uN3lH8XLI2H3+nmkm6fIxKkQt
         9zPK/OSENEzQtPpa8Tpfe8OOuwcwDjZRVnKT3Fe1kMdhin1rYO7POWIspWoNcguyqZal
         nCWQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772437491; x=1773042291; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SigtsR5BoloHk2svJ3ROPknj1i2mSRr9B2CFMiOEu7E=;
        b=Uf+UY05i3mLQ8qL7dN9blvPw3eR7hWP08uI9OIaYzcQXXbfClLmR90+/1MLq1FiAMh
         WeGAbA0srwT5zSaSLzWlTRdB9JooiQqfeMOhnCbTdvRXi1cxmD5jioEmFzBwe4iPFc6Z
         FTheGVgo5CC8YzAYXsWOmVM6rwNN/u3EebzTM1mwurhSNCvtXjHg+bMRqfMKNY2y0h93
         l3oWSDEXQPs233lircd8xW/Sdq59MCi9CR6/BH31k4TEMkrneahYXCYx/SEPqs+2sslK
         42+FX4uIwuOhR1s8hzD9mZ+Q33Xhf/Jbo1diTqmO/0CJuRYwq+1WcjaLfniVf6nl0jEU
         ojOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772437491; x=1773042291;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SigtsR5BoloHk2svJ3ROPknj1i2mSRr9B2CFMiOEu7E=;
        b=k10+KkcDgzhZCWh1QnMLVBRR+SjjloiwMYp4T1PA9wFPmDSqiP75fk3WmOFXmmucYV
         A1++HFBfUoDIJOcZXtZYvT0/QOptpB4Z4OdVREO6tjzCIAyJl0ob/6DdNdYZVDG9u8w7
         EBiMQa2udVVbuUCPl3rQJ4RSose9wJ7GiCJo70lE9JU1/JhYZ6WyxLY4KXviwP93Q2wk
         j6ZJ1KHSTbFNzn1aZkLbO/JJR+QB1XwTxOJPTFdrsgHQfHO84z3vZjXccGb/RbHJkoJA
         Tk8NZSj/HY/iUgREAtkk0lwpJJyV78U7HZU8Jf2YPiVDhTxJ6mWwUZ9WHNR08Ms9LdWI
         GKtw==
X-Gm-Message-State: AOJu0YyM+kZIMDrN1k27XvdLehNwshLVLlAU39HbYj4gBXTerWOJFgb/
	YynwQa4KsEZkLpz84C4pwOAi8W1iwpsqSQfIh/9BPQXoPKyG8i6lOGUA5mln28dIy3XgIVAkzh1
	yqjPM9SmVxuc7HylC2/ouIb8VXZbgBrQ=
X-Gm-Gg: ATEYQzyC9N1teCiZYyTNB/Jl8K+BkovNao8q8JYW7b106HjBWd+JQkjk88ePVGSb+Hs
	c6izIMP8rIuc0SP2cf34WyJS+iKlwhMmJH6iD1LFCloZLjJVT5DY37bQlkPhNhRGv4RJrcmi0L8
	rpwJ7/vok0flO2cFQbCA4ZDCLQetAGTQHThmAS1tsJRBB3q/LNwSEhPH7CUlYZcQRSgYSVuhlZm
	PTrhI4uLsGO9xWjjUpfJ5E0b26lnzvAQ/YjOeF+SsKlPrdQZK1f9t9qLnyrsLLVNl2ALEO8ZxW2
	Q0Q7NtJF
X-Received: by 2002:a5d:4b4a:0:b0:439:a958:434b with SMTP id
 ffacd0b85a97d-439a95845e5mr8886180f8f.2.1772437490839; Sun, 01 Mar 2026
 23:44:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260130134021.353688-1-clamor95@gmail.com>
In-Reply-To: <20260130134021.353688-1-clamor95@gmail.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Mon, 2 Mar 2026 09:44:39 +0200
X-Gm-Features: AaiRm51JxTLkFNuDN7fE4liCNRLR1WY7QHBspjY6N0jJ1_EFAS6d0jT8oUv6g1o
Message-ID: <CAPVz0n2YUvFvO5MT7wTWX+yDxMvvXbh+ZBTMVNCENVny_PPAQg@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] power: supply: cpcap-battery: pass static battery
 cell data from device tree
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, Tony Lindgren <tony@atomide.com>, 
	Svyatoslav Ryhel <clamor95@gmail.com>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SORTED_RECIPS(3.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43385-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,atomide.com,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[clamor95@gmail.com,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	RCPT_COUNT_SEVEN(0.00)[7];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 52EE81D4192
X-Rspamd-Action: no action

=D0=BF=D1=82, 30 =D1=81=D1=96=D1=87. 2026=E2=80=AF=D1=80. =D0=BE 15:40 Svya=
toslav Ryhel <clamor95@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> Add an option to populate battery cell properties from the device tree if
> the driver cannot access the battery's NVMEM.
>
> Svyatoslav Ryhel (2):
>   dt-bindings: power: supply: cpcap-battery: document monitored-battery
>     property
>   power: supply: cpcap-battery: pass static battery cell data from
>     device tree
>
>  .../bindings/power/supply/cpcap-battery.yaml  |  1 +
>  drivers/power/supply/cpcap-battery.c          | 27 +++++++++++++++++++
>  2 files changed, 28 insertions(+)
>

Hello Sebastian!

Would you mind to pick these 2 patches if you are fine with them?

Best regards,
Svyatoslav R.

> --
> 2.51.0
>

