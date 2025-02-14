Return-Path: <linux-pm+bounces-22071-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F9EAA35A6E
	for <lists+linux-pm@lfdr.de>; Fri, 14 Feb 2025 10:33:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53D9616B7A5
	for <lists+linux-pm@lfdr.de>; Fri, 14 Feb 2025 09:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB00220B1EA;
	Fri, 14 Feb 2025 09:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nXyO6rlH"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F8934A08;
	Fri, 14 Feb 2025 09:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739525613; cv=none; b=jqWj9uOHLX7YIGaLxnx5A4wAAoshilgClKhF0peFsI7PJjKjgejX9hLNJ1Ss/mSxxh6J3Eckk8jCfMSvovnl/wBRvuASzYfkkSEacerZdP6Wi3i3ybKWsW6K0ARWNDoWoquH6Dxi4zB89x29gBFTvQwiNNo0DJ7W6eMaDhwEWLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739525613; c=relaxed/simple;
	bh=lT0duSczeOc63vKGL9+pI8VKFgMDps/fnkXoOfqdyXw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fM3TACRzKVXKfpVBYkNWpz7HyCv7NMR0nQYnmvtJk53MttKJzQ5RUt3zY2HAVjlRq+aVEq50suZ0xVW0xF7wtt6Uc/zxGUn8/55z4n43bWjSqMPywZIdtJNxbtFV3dGtX4NELzHoT/7Fdk7moJQB7c19xTgdYEOytyeWDS3BGAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nXyO6rlH; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2fc1f410186so2081157a91.0;
        Fri, 14 Feb 2025 01:33:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739525611; x=1740130411; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ouJI7+lhuUO5Y4jaomCd4wqj+zZjtecA9f0o1ku/ObU=;
        b=nXyO6rlHi5JaKYF2hxiPlU8SVzMkJpMESkag47Va2Q+GXx1snHDWnyJOYoiJ39Vyf9
         yhK3YxpxGWVukWs0Kpn6/r4xp7fhZ9+f0iYOz7C6N5dom86e77M38DbAglck+YfrHMfe
         uPlAs0eqBBDOa7M3tfQ4I9Xw4TewbDe5T/SLUzadz2kZcgv8at1F8nEJUBUi20+0CDs2
         10FUTdcw4RijuYuu24PIJU3myDp59EOETOmad56qPkldzHf6OJ0pvbDr8ZCT7UD/UUrl
         hUwiqKRN+FE32707rvXImUNgkG97UoMzXrBRhxR0Ay9EgICYT0LHwblhZeZ7feO3Xgef
         dysw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739525611; x=1740130411;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ouJI7+lhuUO5Y4jaomCd4wqj+zZjtecA9f0o1ku/ObU=;
        b=mw+rT4YcnV1/tRSqwj+2wK98mKfaraH+51yAT8xi8fdyd85lyikOwP4trFCGh4mPAV
         97iR2B8f459ympd8ciXyHYh8cPO75hKuC7PIOwQu1O1npDO9NPPCULwo1wBMReoDxuNy
         APbVk55TRpPtTCTeSbKWJUByVo8TC04deTAbUcCJ2Sw81TxM742h9zGwaNzrlv/1tp3v
         S6qTYCXcXiLRCVIJ6irlW3UgVOFXdJ4tOXZOy9D8Ie1TEckVdlGYITrv+o3zZPcJjTDt
         KRFgE3GIOOfuQ8PQ2oYU9z2QGXxmG2Rsi4C9lO06/IPqpHve2iVO9l89IGFPf9vGsGvf
         fE6w==
X-Forwarded-Encrypted: i=1; AJvYcCVpcurKYu+AmxZrNK/AxjlOX5jkR2+xhHsZK4lWKcfR7+c5NZjOgc6CpD3V2g3mgyaEaKM0zEaNMg==@vger.kernel.org, AJvYcCWnBJXrvX2u8TV+VeznVmhmMg3+6yu2JVWhfyXwc12TJrfV7TZoF0nVbMFdRG1cyeXIIQ93GGow@vger.kernel.org
X-Gm-Message-State: AOJu0YxCDHTl5pY7VkqnYo17E+Q28gdRbxHES1VKjRSSVk76GvnAY7Xt
	LY2j5DQJqhM4P5fCWZ5yV4C7QZL3R8QEJINSL2KsgZzgKbbvcF7W
X-Gm-Gg: ASbGncu3LMhmoUQ7ycALRrCa3H9W8XwNgDF/2mqugccGmyf18jQs5hiO713IiWkK2zi
	LiYBfwz0Ww+1CCcefTLYE/oyoc4Flr+VW4NpRaiWYd8N3cktWLY1yqIx5OlWWXSe8BI4Tfl2p27
	wCpgfF414kaSsTsHvBAQTZfO0ZaaNMG7R2SRKyFPT3VWC0mr8dKUr7aNxHp1VrALsjEmVpFQPTY
	EnREQhFdMLPv6v7aM5h+c1MaS77gQlKiFrwEfvEHw3f6W0CRickjpJEtmK/VEnsOa4yExhNKfH+
	KCF9lXq/m2/iYZmSVpax10w5+3/zxx6rZ2z14kg=
X-Google-Smtp-Source: AGHT+IGCGMGYkSnLBkbFtTxZW9P0kSJEuD3l5IL0wepaRidtzXfKw8D5KPLXBAJs61+ZGx7yFzk5jg==
X-Received: by 2002:a05:6a00:4643:b0:725:f1e9:5334 with SMTP id d2e1a72fcca58-7323c751ab9mr12977111b3a.8.1739525611225;
        Fri, 14 Feb 2025 01:33:31 -0800 (PST)
Received: from MacBook-Air-5.local ([1.245.180.67])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-adb5a52b07asm2178575a12.53.2025.02.14.01.33.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 01:33:30 -0800 (PST)
Date: Fri, 14 Feb 2025 18:33:22 +0900
From: "Harry (Hyeonggon) Yoo" <42.hyeyoo@gmail.com>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Huacai Chen <chenhuacai@loongson.cn>,
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@kernel.org>, linux-pm@vger.kernel.org,
	GONG Ruiqi <gongruiqi@huaweicloud.com>,
	Xiu Jianfeng <xiujianfeng@huawei.com>, stable@vger.kernel.org,
	Yuli Wang <wangyuli@uniontech.com>,
	Vlastimil Babka <vbabka@suse.cz>, Christoph Lameter <cl@linux.com>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Pekka Enberg <penberg@kernel.org>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: How does swsusp work with randomization features? (was: mm/slab:
 Initialise random_kmalloc_seed after initcalls)
Message-ID: <Z68N4lTIIwudzcLY@MacBook-Air-5.local>
References: <20250212141648.599661-1-chenhuacai@loongson.cn>
 <CAB=+i9QoegJsP2KTQqrUM75=T4-EgGDU6Ow5jmFDJ+p6srFfEw@mail.gmail.com>
 <CAAhV-H7i=WJmdFCCtY5DgE2eN657ddJwJwHGK1jgLKRte+VnEg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAhV-H7i=WJmdFCCtY5DgE2eN657ddJwJwHGK1jgLKRte+VnEg@mail.gmail.com>

On Thu, Feb 13, 2025 at 11:20:22AM +0800, Huacai Chen wrote:
> Hi, Harry,
> 
> On Wed, Feb 12, 2025 at 11:39 PM Harry (Hyeonggon) Yoo
> <42.hyeyoo@gmail.com> wrote:
> > On Wed, Feb 12, 2025 at 11:17 PM Huacai Chen <chenhuacai@loongson.cn> wrote:
> > >
> > > Hibernation assumes the memory layout after resume be the same as that
> > > before sleep, but CONFIG_RANDOM_KMALLOC_CACHES breaks this assumption.
> >
> > Could you please elaborate what do you mean by
> > hibernation assumes 'the memory layout' after resume be the same as that
> > before sleep?
> >
> > I don't understand how updating random_kmalloc_seed breaks resuming from
> > hibernation. Changing random_kmalloc_seed affects which kmalloc caches
> > newly allocated objects are from, but it should not affect the objects that are
> > already allocated (before hibernation).
>
> When resuming, the booting kernel should switch to the target kernel,
> if the address of switch code (from the booting kernel) is the
> effective data of the target kernel, then the switch code may be
> overwritten.

Hmm... I'm still missing some pieces.
How is the kernel binary overwritten when slab allocations are randomized? 

Also, I'm not sure if it's even safe to assume that the memory layout is the
same across boots. But I'm not an expert on swsusp anyway...

It'd be really helpful for linux-pm folks to clarify 1) what are the
(architecture-independent) assumptions are for swsusp to work, and
2) how architectures dealt with other randomization features like kASLR... 

> For LoongArch there is an additional problem: the regular kernel
> function uses absolute address to call exception handlers, this means
> the code calls to exception handlers should at the same address for
> booting kernel and target kernel.

-- 
Harry

