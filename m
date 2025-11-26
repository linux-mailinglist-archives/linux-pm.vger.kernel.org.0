Return-Path: <linux-pm+bounces-38722-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 292A9C8A6E8
	for <lists+linux-pm@lfdr.de>; Wed, 26 Nov 2025 15:48:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 34CC24EF610
	for <lists+linux-pm@lfdr.de>; Wed, 26 Nov 2025 14:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 430303054EC;
	Wed, 26 Nov 2025 14:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lc5j4fBD"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A24530506D
	for <linux-pm@vger.kernel.org>; Wed, 26 Nov 2025 14:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764168287; cv=none; b=rg5cfQaXrHu0DGGU35jNetKEVul64THAFuznmege5pLjNPaUIc5QVLMrpcLzRNWHa4Rjq2CMyA0KGUskz61XhPb1cVNTTZuZUVkd9U22j1wUi8H/0nQSBJidtRzbu6PR6jW2AYtFzgBto4O2lbULSEGwFW8JNu/W6SOilPrPNlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764168287; c=relaxed/simple;
	bh=UqfRhGC7tcNDSS2rktztnsX08KO4ak4PJrEZQQuVV18=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GCIDjawy2crhLJJeaVxUTeFwd+Ziqx+QjaYe/7REBc8Jf6AePPBzLdrtU54i6Y930kirZErPB/hheImzX/w3WEjt+3037qp49xgg9lOVxhRGUKMs4exxQoFVlh8jSznh4yhiXO4EvDgHYr0sO7oJrjvmHOP+kYzZPYbnZ8X2RWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lc5j4fBD; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3436a97f092so8422967a91.3
        for <linux-pm@vger.kernel.org>; Wed, 26 Nov 2025 06:44:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764168284; x=1764773084; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UqfRhGC7tcNDSS2rktztnsX08KO4ak4PJrEZQQuVV18=;
        b=lc5j4fBDF8Id1M78Dzmuln4YZAw2qb1G+gbNAtfGxND1VZxmFBK9l+tb0PP5oEYNyn
         TOfm5Ge4dkP/vtlXxtBgdBnzg0/ojrde/e+DubyHilQ16y+yLFcv2Nbzrr40q7z30V4E
         DghW1yIKP0HICUBxCJDj6rU0exw8yImCWxejHPr1EIquyx9gLZLIo4qNvQXOQFLnOBmD
         DYF/fQMn6qrjxuia6lV2T6tukk2qnl5S4YzQuvENQjEURtb9SvsRbOEbWTIy8OAYg5gC
         AeWeotvvyIh9JCoOGgMurEPNWLSg0+vhmXPJ4m0o7kDWHNJvVP5Zs4UqeI3EAtJBNWOI
         zsgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764168284; x=1764773084;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UqfRhGC7tcNDSS2rktztnsX08KO4ak4PJrEZQQuVV18=;
        b=rEgOY/SlibnJ9CajMhd4x71lal9KDTx7t3ufBeS3J9WUwcEpBaC/JwGjoY2h09eKhQ
         PqgKzptpQzYhreRLkK6P9s6mymX0JZPWpgi8CTeaoWuzlMjYKUg3m2ff2pyXiIBtREzw
         65mL0T5ax6sz8OD3xik5MczuHoZMpKvsWbsMkM+SskTlY+cVtyTqM0tAK5STcWj45y9c
         VZE8FHZdsyCrGcxi9N1b8+6lCuIuXewJ9PXzKpgQBp/BcSH74D/vxO676tzjMsBxsLKK
         BvMAUzuuqISTGjXFxt2qOeRfgmBT99ClnLUUqTqQp7Y6NpouH6w19RgvdOIyJxkg1xbX
         eykw==
X-Forwarded-Encrypted: i=1; AJvYcCWzeJrr8D2IvqSaujQJHdc0A0YZL+1RNisb08zDjlEDYX8bmgFwdFnCLVI/n2YUall6PcqJZ5WO7Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YzpTgwuC986izQuTcOn3vorhb5hK4X9VVf052SpRnT27mdnvSPG
	8vGa1qh1MMSiOtB7EAVgAJoRaD4IFzO7ouCJ3hK+4MH4siQXK6qoyqpy
X-Gm-Gg: ASbGncuWfvpFR1JYpHxklJ+VcE7uErXW0eu1mWqH+uyOAh1tHT/bbPWnghMju0W3MID
	ISze6zIfueVNK/uZn42XcfS85xN1GI7SNDn/ROkEHu+R6GNOZ1ovfxNcHPQ6tL1YuWSsXEyarxO
	gVXSXVAQtlegahSKFwZvd8FQ3yU0Ftn/FAz86UYCeGa3zO6crt3du6jzaRdLl0z13eszd8Lh8yG
	7aMrpmDkTU0N4v9J36sakD6LooWIpfgksjRhsxxcy82/8kIGq37CXQJtSg1igbyPsQfIEf22Bu4
	hj1Pekv6S1hjSPd99pkxNWFo1s6wJYXoschOOpXw2BS/XK0z0SbmO0tAJItB0haX/Ax42kJpVnu
	+glkuo483XDdz+8Fr8bCi8rEHmn9J87wzWVr7lVKuJp9smuCzWsrnW8vKQtkWyT76Gs2lURfi6a
	o3eJHbqdQc+wr5UjyPNyBXfJyEpd5AD2X8CNy8sFqlgITnR3Kt9bedph4=
X-Google-Smtp-Source: AGHT+IHummo04b5kVbBJyoIrPHDE8VmoM3OG1AtPvD6Slv0OYi4AJMuN93Vlql2XFyAQieTb6Wtltg==
X-Received: by 2002:a17:90b:4d8c:b0:340:f422:fc76 with SMTP id 98e67ed59e1d1-3475eacec4cmr6289074a91.0.1764168284055;
        Wed, 26 Nov 2025 06:44:44 -0800 (PST)
Received: from ?IPv6:2401:4900:8fce:eb65:99e9:53c:32e6:4996? ([2401:4900:8fce:eb65:99e9:53c:32e6:4996])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bd75def6314sm19465405a12.7.2025.11.26.06.44.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 06:44:43 -0800 (PST)
Message-ID: <ed88d805835d38635899d591148d5daf88f77d7c.camel@gmail.com>
Subject: Re: [PATCH RESEND v6] checkpatch: add uninitialized pointer with
 __free attribute check
From: ally heev <allyheev@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Dwaipayan Ray	
 <dwaipayanray1@gmail.com>, Lukas Bulwahn <lukas.bulwahn@gmail.com>, Joe
 Perches	 <joe@perches.com>, Jonathan Corbet <corbet@lwn.net>, Andy
 Whitcroft	 <apw@canonical.com>
Cc: workflows@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Dan Carpenter <dan.carpenter@linaro.org>,
 David Hunter <david.hunter.linux@gmail.com>, Shuah Khan
 <skhan@linuxfoundation.org>, Viresh Kumar	 <vireshk@kernel.org>, Nishanth
 Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,  linux-pm
 <linux-pm@vger.kernel.org>, dan.j.williams@intel.com, Geert Uytterhoeven	
 <geert@linux-m68k.org>, James Bottomley
 <James.Bottomley@hansenpartnership.com>
Date: Wed, 26 Nov 2025 20:14:34 +0530
In-Reply-To: <4ef74e2b-74a9-4778-a3f2-d873cf6b7478@kernel.org>
References: 
	<20251125-aheev-checkpatch-uninitialized-free-v6-1-70e8bb1e9175@gmail.com>
	 <58393a1f-272b-41be-9ebd-ae03678cb738@kernel.org>
	 <43f43063b81da41b693d5eb8178d5c55ebaaa168.camel@gmail.com>
	 <4ef74e2b-74a9-4778-a3f2-d873cf6b7478@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-11-26 at 09:10 +0100, Krzysztof Kozlowski wrote:
> On 25/11/2025 17:11, ally heev wrote:
> > On Tue, 2025-11-25 at 16:09 +0100, Krzysztof Kozlowski wrote:
> > > On 25/11/2025 14:32, Ally Heev wrote:
> > > > uninitialized pointers with __free attribute can cause undefined
> > > > behavior as the memory randomly assigned to the pointer is freed
> > > > automatically when the pointer goes out of scope.
> > > > add check in checkpatch to detect such issues.
> > > >=20
> > > > Suggested-by: Dan Carpenter <dan.carpenter@linaro.org>
> > > > Link: https://lore.kernel.org/all/8a4c0b43-cf63-400d-b33d-d9c447b7e=
0b9@suswa.mountain/
> > > > Link: https://lore.kernel.org/all/58fd478f408a34b578ee8d949c5c4b4da=
4d4f41d.camel@HansenPartnership.com/
> > > > Acked-by: Dan Williams <dan.j.williams@intel.com>
> > > > Signed-off-by: Ally Heev <allyheev@gmail.com>
> > >=20
> > >=20
> > > <form letter>
> > > This is a friendly reminder during the review process.
> > >=20
> > > It looks like you received a tag and forgot to add it.
> > >=20
> > > If you do not know the process, here is a short explanation:
> > > Please add Acked-by/Reviewed-by/Tested-by tags when posting new versi=
ons
> > > of patchset, under or above your Signed-off-by tag, unless patch chan=
ged
> > > significantly (e.g. new properties added to the DT bindings). Tag is
> > > "received", when provided in a message replied to you on the mailing
> > > list. Tools like b4 can help here. However, there's no need to repost
> > > patches *only* to add the tags. The upstream maintainer will do that =
for
> > > tags received on the version they apply.
> > >=20
> > > Please read:
> > > https://elixir.bootlin.com/linux/v6.12-rc3/source/Documentation/proce=
ss/submitting-patches.rst#L577
> > >=20
> > > If a tag was not added on purpose, please state why and what changed.
> > > </form letter>
> > >=20
> > >=20
> > > Best regards,
> > > Krzysztof
> >=20
> > Oopsie. I should have sent a new version instead of resending a failed
> > one. I have updated the `UNINITIALIZED_PTR_WITH_FREE` error description
> > in the checkpatch doc as outlined in v6 changelog, so, didn't add a
> > Reviewed-by tag
>=20
>=20
> Again, your changelog should explain the reason. Second, you implemented
> reviewer suggestion, received the tag so why do you think that Rb tag
> does not apply?
>=20
> Best regards,
> Krzysztof

Sorry again :(. I thought the new changes, although minor, would entail
new comments. I have experienced this in my old patches

Regards,
Ally

