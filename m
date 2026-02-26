Return-Path: <linux-pm+bounces-43270-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iF07AnKLoGnekgQAu9opvQ
	(envelope-from <linux-pm+bounces-43270-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 26 Feb 2026 19:05:38 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 751DA1AD39B
	for <lists+linux-pm@lfdr.de>; Thu, 26 Feb 2026 19:05:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5E49A30B7A2F
	for <lists+linux-pm@lfdr.de>; Thu, 26 Feb 2026 17:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C107355F28;
	Thu, 26 Feb 2026 17:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="TKMlnirF"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B88336EF5
	for <linux-pm@vger.kernel.org>; Thu, 26 Feb 2026 17:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772127785; cv=none; b=tfSnuTOlw5lhPpGfQtJiJRuMl1C18JPH1caPxkkrrXnFSUTkrL5FoECdLsOvHTd0x8Bf3FHy6Gmo+HWVY6obgtJSeYAiVh/wElVUTP0D6zGDxIHpR3zRW/J/7x7vROaRrAAvwFI6nQlUPAM4UHFNcJEIPG80HlMJR6FVtRjV8rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772127785; c=relaxed/simple;
	bh=TYhqrrbcg22Dn9bgzoDvcu6N8lq5PSptPyxhon7j960=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sSEbmpC5/y7FcaOjpzylXU1IoRnlwGrr91+SWJKgPrS7cvDjXTGvOFyocCgACg3ExiFBn7znW68KiY6CbHgMoNuTjCXKKCoSpIUogXPgIsyCWGoVTvZeQ3DiKGlqO0ynfGb1WM8OnrYCLVlrUL3exdCIHD0Wu3PfBmRfG4ZOOQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=TKMlnirF; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-8273e0fb87aso558216b3a.1
        for <linux-pm@vger.kernel.org>; Thu, 26 Feb 2026 09:43:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1772127783; x=1772732583; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=T/IHXXTn0vtbnJv9war7IL8u63QkAq3MWJ9m7L/min4=;
        b=TKMlnirFJpzc6H/kbNevaV7l7TKRLrpRYfoHMQGyS/B8GlS7ILrWxh+94YxZU/BZHY
         62S4GAeI2n63VLDG0GiF8utteubT1SNU0Yw2p73bCLjyEKBzoVF59CVGYlBw5rEdJEl7
         h+WEOMPraoHLbbEFFgxc46NtY0B8RebLhHsggvGA7jVok7hxr2AcNPeSx/RorVQ5onRg
         0HidySpP7b/ihYU5sqH36J7ngdzhW1LNzFWnQW8gjtJ2WibsVgnhrtsdSgf3iwU50QLr
         wdW8BJVQxh1Mqy0CM2TFE8n4Enl3ZslvAF8BwUWQqXIxIgCnWIqnPPt2G68R62Loq1ed
         bx2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772127783; x=1772732583;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T/IHXXTn0vtbnJv9war7IL8u63QkAq3MWJ9m7L/min4=;
        b=YZ6k2AU0d/DwkxsMzY7Hi3/UVNWj2TC1DzNCUHTn+t2M/nGZk/panCZ2x9RJi4DLPj
         gxr16lxDKpVKuqc8wwZxWeDFhq+7xo++1j1PUU4iZTRNdioyJa9pMLY9Z+qnbO+Lv5Ug
         vy5FLmpD4RZupCW+ATa/oEKAHKcflozH1cQr6PAk4v+zW8w6SbVQDxdThS5dH1O7hLeu
         mOiM1MXdWYsuaeVWSLfT9vzk7hqIdHxdbrtJx1ClHSppNvZT1x+xB7jVRw1fvYlArOR8
         pU27RzxG0HTRg12uYlyRLySs0+ooCz9DfMMrIpfYROwJ0uDK2aLCvIfb/RY4m+FwbL09
         pLug==
X-Forwarded-Encrypted: i=1; AJvYcCWyRjNP8VHDHjDyu6ZgbalYLxXjymphlWxCLCGdMJud3814vcAkGqNcf5wyJ9ob6tX4X+WU7U07Gg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yylq3LqcPvh4Szj9QsH5BKhQiVrVnXK5LkIyypcfq03Yq5tLdMF
	MReh+qIlMqwBECts6EJ5PJmDv2VmbyDCfIQvxCRQpRHeNxTyaZXiFvBT7v3VJKt1Nnc=
X-Gm-Gg: ATEYQzylsPiOGMQkSac53iT0/9zS3Rze2UmdFgI14I7y88g3c2LRWv1fbsUBwoW6/9L
	aj9HfSkvw23Vubx2g5UMvigcN0nyLYK9ZnoRxLiKPFadMtqvcqM53Odj5hXFsbTdb+1SaTKv1tw
	0jEfUbMses8ODMjgas0msp1D8Ldj1o4fg0m8zzQZ2TRWxF2HpTd4g4Y5/b5eAK2oe7/EPHn0UnO
	HtSMHAqX4CtvE7DVsOV3MfLUKpCKtFLwSiu+6s5y7+mNfDGmdSvoxnsBOzEqEHLUi6WBDgaHRT1
	iUMm7VeyJnpZfXqOMgF13BilPu2ga/65si+iwWwNXeP1JShEUU+KQCjCgSYyIrRKrEviBBg5e3I
	WMuQLKyp0tTJvZqz1QZl6I04mwGxdSu8Wdy4bcdc5e5Rc6L02VSesByv+A4Pna4SQJNaAq2UXXH
	pvyUaEwX+j0a2S4WWFNb4p
X-Received: by 2002:a05:6a20:c709:b0:33f:4e3d:afed with SMTP id adf61e73a8af0-395c3b04066mr68709637.33.1772127782712;
        Thu, 26 Feb 2026 09:43:02 -0800 (PST)
Received: from localhost ([71.212.200.220])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c70fa82cf71sm2494686a12.26.2026.02.26.09.43.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 09:43:01 -0800 (PST)
From: Kevin Hilman <khilman@baylibre.com>
To: Kendall Willis <k-willis@ti.com>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 linux-pm@vger.kernel.org
Cc: Dhruva Gole <d-gole@ti.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] pmdommain: add support system-wide resume
 latency constraints
In-Reply-To: <057547c9-773e-4ba2-a754-aede29d07daa@ti.com>
References: <20260205-topic-lpm-pmdomain-device-constraints-v2-0-61f7be7d35ac@baylibre.com>
 <20260205-topic-lpm-pmdomain-device-constraints-v2-3-61f7be7d35ac@baylibre.com>
 <057547c9-773e-4ba2-a754-aede29d07daa@ti.com>
Date: Thu, 26 Feb 2026 09:43:01 -0800
Message-ID: <7h342nqu3e.fsf@baylibre.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[baylibre-com.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[khilman@baylibre.com,linux-pm@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-43270-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[baylibre.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[baylibre-com.20230601.gappssmtp.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_HAS_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,ti.com:email]
X-Rspamd-Queue-Id: 751DA1AD39B
X-Rspamd-Action: no action

Kendall Willis <k-willis@ti.com> writes:

> Hi Kevin,
> On 2/5/26 18:29, Kevin Hilman (TI) wrote:
>> In addition to checking for CPU latency constraints when checking if
>> OK to power down a domain, also check for QoS latency constraints in
>> all devices of a domain and use that in determining the final latency
>> constraint to use for the domain.
>> 
>> Since cpu_system_power_down_ok() is used for system-wide suspend, the
>> per-device constratints are only relevant if the LATENCY_SYS QoS flag
>> is set.
>> 
>> Signed-off-by: Kevin Hilman (TI) <khilman@baylibre.com>
>> ---
>
> Were you planning to also check the CPU devices QoS latency constraints 
> in the cpu_system_power_down_ok function? At present, this patch does 
> not add that functionality so if the PM_QOS_FLAG_LATENCY_SYS is present 
> for a CPU device, the QoS latency is not taken into account.

I did not add that functionality because the CPUs are managed by the new
system-wide /dev/cpu_wakeup_latency, which is already checked.

Kevin

