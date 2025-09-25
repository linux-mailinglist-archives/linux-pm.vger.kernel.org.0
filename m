Return-Path: <linux-pm+bounces-35328-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2308B9DD94
	for <lists+linux-pm@lfdr.de>; Thu, 25 Sep 2025 09:26:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC3044A2E1E
	for <lists+linux-pm@lfdr.de>; Thu, 25 Sep 2025 07:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DB752E8B76;
	Thu, 25 Sep 2025 07:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="IwdK6NeL"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A8332DE6FF
	for <linux-pm@vger.kernel.org>; Thu, 25 Sep 2025 07:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758785200; cv=none; b=HmUmLr7CvHpm7SC4GsmClNiuMera9VlMejhwCXFFHapuWTLnY9DMgmVQg8pABa4Ox7tp2k9gRkbvSZF1DDNu1J189NrS9QHIR7zQYsV9SMhWFmJuGFiDtOzWWedBhasfh+K/oGfP6Yl+Q15uCeE+m7+RnmOa7Oto9UnX1ja8CwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758785200; c=relaxed/simple;
	bh=IZNehkJyXObPO8qrTZgEq7p0XEf8K/P7GfRMVj97KFE=;
	h=Mime-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hzPA4v6MMBDWSe/xpBPL2h19/fLRSathV75PkPgGTGlZmKcZui9jtt4yWFq+gOxsglRU0v/5c9ibTM484UViQz3rNJ8m4kY6lmSlcTYpe0EQN+4sxgPpExsssBm0DQX+NGlNncVQFBhuVUoj3U99jvSXwHEv2x6u4EJqrRswF5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=IwdK6NeL; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-62fa8d732daso1236564a12.3
        for <linux-pm@vger.kernel.org>; Thu, 25 Sep 2025 00:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1758785197; x=1759389997; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IZNehkJyXObPO8qrTZgEq7p0XEf8K/P7GfRMVj97KFE=;
        b=IwdK6NeLoU87AO+lnLT53fnbvHEX8uSf8fAtANXWxwMSD00XIE8br9sLHCqFvLo3vQ
         SquijhXy3ee5tLU11p5J8j0mAp/DmialGVhcd704UiCujq3LmV6pv6ClZudfA6lERjXG
         Vps2Voinq7ELtM8UNde1V2CEzEsQIJQOdCOTXePMKGjsVH/ORJLSfvDDQcJ2Wjm10vFz
         zcRtg4RwH+EDsZu581qifEi5ZzSgwvuNhImd89+BEbZxwSx1knPLBcGKYAeDdCi/arlc
         HvVltNF2PYWySJuYYjK73ZF3Gks4cHhfIfGZAcSes236qNfhBJkSYYyhmXLqBEec2APZ
         GqJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758785197; x=1759389997;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IZNehkJyXObPO8qrTZgEq7p0XEf8K/P7GfRMVj97KFE=;
        b=rkRyJW/dKNYilmK1j9gty6nAf/VyiEyi2AlUvZP0eSKPAz7LksBA9cHJQ0yg+14RU8
         m/Uuj6UZ3G8ihKGm4x67HT/s8ppMDol2Ac9S5shXDTwT5frZaAwm5DaX9A0kGYJnkJzi
         9GZM9kgU5Jz7u1UEm8pwkwf2GJ0oMv49gd0C6/3oQrLbCm0J5YtUGCs9aSDczcH+gozE
         snEPW0wsXQd0W2sqF+/X/uKB/0RdfJ09AuMX8afftmGULUzt5DP2pBDMs/sOnxxXwuXm
         B/EXSf7dts8G8fndYmDzaQCovU8WKwlGuai4r/UULND5Pr8CmXbophpUasTUu82On2cN
         kUow==
X-Forwarded-Encrypted: i=1; AJvYcCW/OJo3UXMjCHws7hBT0LLt0+9rj+wh3/uJYwB7+gHhnDs+/xrS8WJMGrWGq9s8JVdFbfmvyLBA5w==@vger.kernel.org
X-Gm-Message-State: AOJu0YyPCXyvhbNqnS3qRcuod2pFnkJsWAyYufawIspGhDbBklDiujoG
	noH7MXdlXKYmDxXeEJppJC7qOKJ5JVNXGPoON7O+RcAKkPqf+DiTaSyHiPUAWCOBifWpu3Y65Yr
	kAIU9A8rPDlpKn8BAh6BjCrayFCcG4IhbtsJzHMs6Lw==
X-Gm-Gg: ASbGncsMql2maoCzFONZ5931peO3HjlsGKlD38PRyiGQYh78pOXaz53XQ3hNfk3n1S4
	HbTamndIKBTBK7HzafKI++go1MYgmoHwvLCHA+GD98qQLV7/aK6+KIWIO2c32zLJA8HQYqgj6kv
	+RqpztLtZKGBOAVR+xzMi0zghp0jwyzJpiltTb+DjL2nCa6fVhiFAp8oYZeJ0Gt2nGmyxP1Iq1T
	kqLPxGnmzyVdiU=
X-Google-Smtp-Source: AGHT+IFoMSBXt4dDM2m7skZhYltT4ezcqzojlUVcokaY1XjlusJW2CedcRxZC1Hj7bu6NzSzFDDNWZXCUGhtawMVbwc=
X-Received: by 2002:a05:6402:42ce:b0:62e:e5b3:6388 with SMTP id
 4fb4d7f45d1cf-6349fa81093mr2108322a12.19.1758785196810; Thu, 25 Sep 2025
 00:26:36 -0700 (PDT)
Received: from 44278815321 named unknown by gmailapi.google.com with HTTPREST;
 Thu, 25 Sep 2025 02:26:36 -0500
Received: from 44278815321 named unknown by gmailapi.google.com with HTTPREST;
 Thu, 25 Sep 2025 02:26:36 -0500
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250923153146.365015-1-fam.zheng@bytedance.com>
 <40419dea-666e-4a8d-97a7-fa571d7122f4@intel.com> <AEC34AE1-AEB5-4678-AC9D-39155E97D86C@zytor.com>
 <CABgc4wTjc9nxmB16LkxiOL5gYO9K8kr46OqM=asyUkX7cT50Sg@mail.gmail.com>
 <CABgc4wThvZrxBLb0JRiROCws12qLNUxwcb4cJa_W63qh41apjg@mail.gmail.com> <585D086B-733C-4274-B274-794F360E8E33@zytor.com>
In-Reply-To: <585D086B-733C-4274-B274-794F360E8E33@zytor.com>
From: Fam Zheng <fam.zheng@bytedance.com>
Date: Thu, 25 Sep 2025 02:26:36 -0500
X-Gm-Features: AS18NWCTT_nnIvTOBeuqZvc8QEsP14wdwP9TFottPFdBIlDmadovY0Q4T0MAh1U
Message-ID: <CAG+v+KZL8teU5ReRNEJ2sdKgP02+K26DLMt2=KapZPfqcSWM3A@mail.gmail.com>
Subject: Re: [External] Re: [RFC 0/5] parker: PARtitioned KERnel
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: fam@euphon.net, Dave Hansen <dave.hansen@intel.com>, linux-kernel@vger.kernel.org, 
	Lukasz Luba <lukasz.luba@arm.com>, linyongting@bytedance.com, songmuchun@bytedance.com, 
	satish.kumar@bytedance.com, Borislav Petkov <bp@alien8.de>, 
	Thomas Gleixner <tglx@linutronix.de>, yuanzhu@bytedance.com, Ingo Molnar <mingo@redhat.com>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, x86@kernel.org, 
	liangma@bytedance.com, Dave Hansen <dave.hansen@linux.intel.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, guojinhui.liam@bytedance.com, linux-pm@vger.kernel.org, 
	Thom Hughes <thom.hughes@bytedance.com>
Content-Type: text/plain; charset="UTF-8"

> From: "H. Peter Anvin"<hpa@zytor.com>
> The difference is that this is highly invasive to the OS, which affects developers and users not wanting this feature.

Yeah that makes sense, thanks for clarifying. By having a hypervisor
at least in early boot of secondary kernels, we don't need to patch
device enumeration etc. In the kernel code.

Once the kernel is up, it can be then promoted to run directly on bare
metal, so zero performance overhead.

Fam

