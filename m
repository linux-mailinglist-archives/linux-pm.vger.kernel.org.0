Return-Path: <linux-pm+bounces-41736-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qEr5J6LWe2klIwIAu9opvQ
	(envelope-from <linux-pm+bounces-41736-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 29 Jan 2026 22:52:34 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 40F87B51A0
	for <lists+linux-pm@lfdr.de>; Thu, 29 Jan 2026 22:52:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BEC9730039A5
	for <lists+linux-pm@lfdr.de>; Thu, 29 Jan 2026 21:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD595366816;
	Thu, 29 Jan 2026 21:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="di9xeQC5"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59FCE311C21
	for <linux-pm@vger.kernel.org>; Thu, 29 Jan 2026 21:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769723549; cv=none; b=b6KQ38YJPO1HY1fi00KmiR/VXMO+MO5EMr+Xn0fSYOESF8PlqOfJEEiqFjWlYRTHIvM0Dg1gyR2V0LabvdO5svv0XcEFplD5yYWwMwdd3jabJOQsj8UltL2/6k7ZTxgEgxww82mvRBBpvyRKnpUvPGjdREmHjfSDfC/GsiAm2SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769723549; c=relaxed/simple;
	bh=iweSHJtypL+EPMfaF3reSRoiAnkQsyy65w7ipUaRS5U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SJy9jzHomMn+EeEMk9JH632BYlsLEpjZNawSrYs/nG/oo88jcQX7Nb9PlYQXyH/BtBI1eDj0siVNE1zm2Aze/xnEgulPIrKd97niQgnZIiOLPU9Kal7AGfj6y83SSHGBhaE8MwD+e/jCh662K5O4DGrqUNFZwe2ojZ3f8s6vZfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=di9xeQC5; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-48068ed1eccso13288295e9.2
        for <linux-pm@vger.kernel.org>; Thu, 29 Jan 2026 13:52:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769723547; x=1770328347; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ForbHPxhK2XNBAXRzpBPafliEsiPoSlc2Fuk+bA3eOE=;
        b=di9xeQC5wPWNKLnqEofm46wsWFvBqdx+kqN1tHkAjv8f9WMottwtxTpczH1ZAwEEHP
         apdBCIgVgbg7dygWKh1BCDe/G0wSUApYEB9AgXuQmQMMXW9wIilJix62pEVF/jy8g7S1
         tmCys8tDKpEq+z69g2LZ6OfJnm1qudCEwH03T37Rpn8+4cyI56FeoVNPzjnUY6IDsy0P
         C5APVnm9EOfGY90MJ1w8BalUlCLV8yyemkROQIWtNt+Y5qN+tCaYJ1pbdQSpIny53lI5
         DIk0L82HveOQ3KHdOLK+h8cQxuUUAfr8Lo2DAeDw477+3dxCrr284F3Z5SDn3OVoGwKh
         i6Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769723547; x=1770328347;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ForbHPxhK2XNBAXRzpBPafliEsiPoSlc2Fuk+bA3eOE=;
        b=C4PGySgMFIQ5X5m7eXWWMSSJknAj5GvfIcysK3vtmKTaHTiPYpaaMVDR5wnUbKUF7n
         Pwi1dXLBixAp+y+DJ1A8WgumkH/We+ZsWksnn0w+IivSmVO/Nsp3mkVubrn6ScW/fo8E
         pXGWaEOqQUcK4sDpEOjm9PmU0iVJ9wsDuP5VGcChirdH/E1PgLTkgS+w9j8ajY3yrMRg
         LP9MxWuBM5WbnxmZyNubDVrmZuLOa7b/H+GYjFMUaN/e8kWI3BeLGdjxV3WtRD/+JXva
         Nm2c8ad4oeTUkp5ZOgf2cjSxeg4me+0nF5aGAb7Vejez0jkLsg/X8NMPTcbCAtfaC77y
         A/Og==
X-Forwarded-Encrypted: i=1; AJvYcCXI7tzf7+i2onS1IlQRp9auRBDVLnr8VdM+YvTFICclIYNdTljtnzrfAjzN+WkPwjh5bbpF17YUjg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwgBm5jSvYySBtsrFkubxnQSP7m5QjgsoQcosXbShYh7xFvlosm
	I1nfHLIHgLGAfZYfrZ7v325nlc4cu4UADsqd33qGsOhc00hCtpArNOsZ
X-Gm-Gg: AZuq6aKI49SG5E/BChH9wPOa0V5HzHpQlCPSlccaYJtdY+j4cXBvC4TlyEQHxuXC8Iw
	5T9E3iJktESZ41tKGrEAnNBNCWLsUGrtPfaJsfYgBtZC4w7UNFzj4JXe3yTxuFtw9snnOavAxCP
	5DGnJWsA/3CZu35hwctnVBfdYBGLZ2h0GZwOZVWyJvoQsXD2fWFW48mM4TmMYS5gsWvhg4JHZ3r
	LxWz7DbPpQHXhNNt9YkXop6JoHvvrsWsWH68edMYGWa27fcAaz2Z0p+N8o9Pvgylnk7jZIk3htT
	mYpqGpcDpBAj7EMO/EcHF878fobQejTDPQlO2vHsT9z/bjexRSh7J1bMSJ6kNsJdpmbuMl4ihm7
	wKQkM0cLq3qLAYpo15wkAYK9mL0xG3rGg8JYB/6mMhP7GiAiu9qq8YF7kZGEWYyAtLAy9LsMugF
	XrfGTtELKCa++u9uixO2+jLbmhUXstiUAQKpXennJ6M2l68EinZGIx
X-Received: by 2002:a05:600c:4f09:b0:477:755b:5587 with SMTP id 5b1f17b1804b1-482db44d1b1mr5930005e9.8.1769723546512;
        Thu, 29 Jan 2026 13:52:26 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-482dbcf9c3fsm2626395e9.4.2026.01.29.13.52.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 13:52:26 -0800 (PST)
Date: Thu, 29 Jan 2026 21:52:25 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Daniel Lezcano
 <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, Lukasz Luba
 <lukasz.luba@arm.com>, Srinivas Pandruvada
 <srinivas.pandruvada@linux.intel.com>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 3/9] powercap: intel_rapl: Use GENMASK() and BIT()
 macros
Message-ID: <20260129215225.33cce6dc@pumpkin>
In-Reply-To: <20260129183646.558866-4-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20260129183646.558866-1-sathyanarayanan.kuppuswamy@linux.intel.com>
	<20260129183646.558866-4-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-41736-lists,linux-pm=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,linux-pm@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: 40F87B51A0
X-Rspamd-Action: no action

On Thu, 29 Jan 2026 10:36:40 -0800
Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com> wrote:

> Replace hardcoded bitmasks and bit shift operations with standard
> GENMASK(), GENMASK_ULL(), BIT(), and BIT_ULL() macros for better
> readability and to follow kernel coding conventions.
> 
> No functional changes.

Assuming that changing values to 'unsigned long' doesn't have any
subtle side effects.

...
>  	value = (ra.value & ENERGY_UNIT_MASK) >> ENERGY_UNIT_OFFSET;
> -	rd->energy_unit = ENERGY_UNIT_SCALE * 1000000 / (1 << value);
> +	rd->energy_unit = ENERGY_UNIT_SCALE * 1000000 / BIT(value);

That should really be:
	rd->energy_unit = ENERGY_UNIT_SCALE * 1000000 >> value;

While using BIT() for bit patterns is resonable, wholesale substition
isn't really right - and that isn't a bit pattern.

	David

