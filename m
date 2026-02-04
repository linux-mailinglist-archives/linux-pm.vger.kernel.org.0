Return-Path: <linux-pm+bounces-42077-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0PfLFlZBg2kPkQMAu9opvQ
	(envelope-from <linux-pm+bounces-42077-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 04 Feb 2026 13:53:42 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BBD30E60AC
	for <lists+linux-pm@lfdr.de>; Wed, 04 Feb 2026 13:53:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 74C01301DE2A
	for <lists+linux-pm@lfdr.de>; Wed,  4 Feb 2026 12:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 697C03F23BE;
	Wed,  4 Feb 2026 12:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b="N1pnl685"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 138FB3EF0C1
	for <linux-pm@vger.kernel.org>; Wed,  4 Feb 2026 12:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770209272; cv=pass; b=Xz7a99kllHyR/XQR59JrNpsMFHD3FJuajMZGIPyBkrZsv6E7eOHAWX8FczwfB+I49z+OXDa3XSSpa8KI8clkL3cYiEEfjJVAXXmMyo4uUXlToPl40ToQ55/DVrY5DachsFgJyqQ8agJiY195/fYy2cMf/UYA06A9kwScc1EhrRY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770209272; c=relaxed/simple;
	bh=gzPdifQNN1kwwnTAjndJp4o3VuNeG1AwtKZeUr0gEqE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uJcZM96Bwy6ZRPOk7ajCCQ4hAB3fPiHGfvygqlSxB5iykoMLaInTw5snc0GYrTqtueITFn4s3ka+AdPji0wCJPWyXFlbtd72iB70Ija6YgNboKzbDK3LhrUQXj63myeBxdcOMksUdNiTZvC0aFSYgB+l/CkAFFjAIUrcxbVv5Cc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0x0f.com; spf=pass smtp.mailfrom=0x0f.com; dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b=N1pnl685; arc=pass smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0x0f.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0x0f.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-c6c444e89bcso489681a12.2
        for <linux-pm@vger.kernel.org>; Wed, 04 Feb 2026 04:47:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770209271; cv=none;
        d=google.com; s=arc-20240605;
        b=YvGe2zfyFqv0Cv9Yc3BuD/Z9kWeUobJrpG231lSi2KtNGH4mnNN1UJcAU0KDGOEo07
         glDM6MuU1xsQ29VPAkQ45iG3hbLkaPQCSjUi320peROTqRDh6/JPiTBCuXUpjPEZNzx+
         Z8cRPpE2JFyoGiEofrnJ+EXLpCXrFDaHnvEEhml2+IIR6HQ16O2Dk9m4VR5jpbdjQ9JW
         X96GhjI3WbMpiNoEAT+ukBHu0bicRXtIj1EbeFuF800PlPAfBaHcIaCHPp1pnoM19CXE
         9O4NXgEOXNyBgNpXNrxhGv76SxBaCsEcapHBl/I3MUTedRETeAIC0hyFRSyf4pnjlhca
         Tf0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=gzPdifQNN1kwwnTAjndJp4o3VuNeG1AwtKZeUr0gEqE=;
        fh=DlO9S9Pf1kn6PyivCsjARd50oPk1nllTlcat/c46jFE=;
        b=PEUkH9YJ9Y8mrglTILfyvWw6010rZ6+FoVKQtnzHMj6CCs7O+VozHCUd9Jty0Tqf1K
         rxjQg7LY9wGH3V3dmqNEjZlHs1t8XUEtxQ7za47puuqnOTTcoDYpiVuP+IPcMFoHIOox
         vmoSkTt0+uPpHkfoWxAP4natakyQ2fWfGZwdbGted8aL4vmsReQJTvAb2i4zgjaRMxGK
         RMO40eSJG+VgOI1BJ8W7pOffEf1B5e1DIiUfVtKre+cIlQVDFHPi2o2Kj5tjtOfstImr
         1Zrc8fp6YaQciJ8fwt7xO+63nlG81/BQ0CefmKZnRlt9C6dcM7zc8oXKYATZ2wXoiDPv
         oWZg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google; t=1770209271; x=1770814071; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gzPdifQNN1kwwnTAjndJp4o3VuNeG1AwtKZeUr0gEqE=;
        b=N1pnl685Ny421NXuU6eOT3o2kGAhRMSaiMZO7+F1vxJIyDbtvGdNTWdPMlsADArN7/
         AhTaVXivC3YHQbLjW02cyGKhg8He36mYGW8J9NCKzTPM4WdFBWuXG8rgqOjYpyZzDHvM
         W5jvlkQs4hQnjb0gP1Ad041QUh/aNokGV2E00=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770209271; x=1770814071;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gzPdifQNN1kwwnTAjndJp4o3VuNeG1AwtKZeUr0gEqE=;
        b=jHNkH5bN+nwifWfisZULp77GStu4KXcOHBicOaR2qze5R8aJdmXRDkrORzP3Eu1KL+
         VSlTyk6sxY6iff/HLSLsDpnAOFD1yj1+Hf1LLfaT9xqyU2iJFQFJowQjSqIGSySGmF/0
         eVPoLR67wW7XRaGE9Ru+69hVuw8Jj4jQwdMKJ/m0e0zNTXcOiHH7aqegP2JL4Ym0T1Ld
         yDIcQ97GcBxWtbbBb4rccdjgrWt1cjG+Ugdq18tWvTaUlG/bluBRq105AtnRJBF9D6VF
         ySRS2Cgpax7tM+4GTKZxZEjYardY7v1ZDYyTD7z6b52NS8NuSFQe3vdJIJLGz3ZVxMbR
         j7cQ==
X-Forwarded-Encrypted: i=1; AJvYcCX5UXypxtn9zN/Q7cMcLr50505Jjqx4QB9NmjbtsfeIykIGQJUIcRKlgjZoD13GedQ5CYeLUBj7hg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwcXFI7zqYgRU6MEmxz/0FIrCCfWi/CPTH06QwdZ09+mn2HH4i9
	oqzYmW+oI/dblHVEuqiugbcOqncAUGsStXVq7zX3AaSSJ9IUd7Az1/PBxMQUeD4OyTxJCLMguH3
	npd3/3alRITzNkKAd8QpmYZo+KJBesdEF5CsThCeGug==
X-Gm-Gg: AZuq6aKAcq8oCbwYP+WxeHyAojSPBZyxDRF2n8eIwAxtlYdN8ohkqe+ZwaMAgQGOG18
	MyGxbZyr9YNZbWzHRS4Jghh06cfxK8t1ZX0yvNjoxPn70PvM8M62+h7LCWrC/m8Ni5iAg4nzRm6
	+idFOTJ8+u5JIA3hyKlfeMrC9A4WyI+us4DbRqLjD2jKD/WR9flmBBjUqWLsXvELLf6Wxu2SwG2
	KMOXv8/l0BJWy+bzc5t2ptX7M+LqEnAJdlAYj4NTqmP3k4u6jEiAcM/RbIaJxI8/h/xhZUPjDzj
	Gx0QMMhH
X-Received: by 2002:a17:90b:2dcd:b0:349:7f0a:381b with SMTP id
 98e67ed59e1d1-354870cb817mr2271653a91.8.1770209271374; Wed, 04 Feb 2026
 04:47:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260203170824.2968045-1-visitorckw@gmail.com>
 <CAMuHMdUMBoLd8cKXMK64qjGfTqQfK21mDAXMh8DdJHkL7QbDVQ@mail.gmail.com> <e7ddd671-6e25-4114-9d4c-21ecebe82ef5@vivier.eu>
In-Reply-To: <e7ddd671-6e25-4114-9d4c-21ecebe82ef5@vivier.eu>
From: Daniel Palmer <daniel@0x0f.com>
Date: Wed, 4 Feb 2026 21:47:40 +0900
X-Gm-Features: AZwV_Qh5NVjLh6HCd9GiRsalccZbQsoSI1MyoYO3Q0La5tE6o0sRk3zeCgTPlm8
Message-ID: <CAFr9PX=heS=ywLCidd8o_BzS4TS5U=GA8yv7itzNFp5nuwf2XA@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Add QEMU virt-ctrl driver and update m68k virt
To: Laurent Vivier <laurent@vivier.eu>
Cc: Kuan-Wei Chiu <visitorckw@gmail.com>, sre@kernel.org, jserv@ccns.ncku.edu.tw, 
	eleanor15x@gmail.com, linux-kernel@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, linux-pm@vger.kernel.org, 
	Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[0x0f.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-42077-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[0x0f.com];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,ccns.ncku.edu.tw,vger.kernel.org,lists.linux-m68k.org,linux-m68k.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[0x0f.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@0x0f.com,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm];
	RCPT_COUNT_SEVEN(0.00)[9];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: BBD30E60AC
X-Rspamd-Action: no action

Hi Laurent,

On Wed, 4 Feb 2026 at 18:09, Laurent Vivier <laurent@vivier.eu> wrote:

> Please cc: me on the next version

FWIW support for the m68k virt machine also just got merged to u-boot:
https://lore.kernel.org/u-boot/177007672356.4123720.10843284111217950440.b4-ty@konsulko.com/

