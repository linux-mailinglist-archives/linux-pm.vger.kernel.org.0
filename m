Return-Path: <linux-pm+bounces-22952-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C307A456B2
	for <lists+linux-pm@lfdr.de>; Wed, 26 Feb 2025 08:31:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D9D4175063
	for <lists+linux-pm@lfdr.de>; Wed, 26 Feb 2025 07:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 437D71624EA;
	Wed, 26 Feb 2025 07:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AjcsN5zj"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD87158DD4;
	Wed, 26 Feb 2025 07:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740555077; cv=none; b=rJUMvGsuPXKOLQnFg/2GIOI7uFdBikzHiLrL+B1hYG2CAbVAp6frPV/QA/GAy1jvg9gr3f2SYX1tl9sICZ+3IVQh8XQdyjNWNK/QAoeDV1AXAijdnxLharAG8kqnrnRrNarC5Gdf/89+tq810nAv17EKoFMg/rIbisd2nErqdZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740555077; c=relaxed/simple;
	bh=n/TpTWqi0cwuzL23ARR3Yy2I3BmPhnDJxEp6DXi/q9M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AcofmdwBXU2p6Fwrl/wMERXoZIkAaUvqcj+ag8IBc7+Xi58mnuPGrB+sG9v7KWWRWFY0WyNoHCQ73+V3bKNrYlO/WYzXAyn//qCpiEaAdels2zbrMEzq1DOAlvDccSNm0MQp6GOniW7243Tnhxq0pwzugs+sB3uPFgugUq3rCFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AjcsN5zj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81CF7C4CEE2;
	Wed, 26 Feb 2025 07:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740555075;
	bh=n/TpTWqi0cwuzL23ARR3Yy2I3BmPhnDJxEp6DXi/q9M=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=AjcsN5zjeK4FW6og5AQy5VoTKtWVTUdkhoQWUA0KZTt7Zb9QuRvBTYi4hY2lLPWwP
	 pxrMNSg5213oLpAWXXhryjlq4rhOBmVx4/uZUH4Kpieg8qfWk7X29vmoUk4aaccFYh
	 B09+KS4dW68HRIYWr+c3uoYz1Mj0hD2KBJirWm+L38tbj4HQeaNibqv/uw71qwyhUj
	 fMwqTb9UGRmfIplXtRnw8tF4SXOQoKYdwslvKsj3G+D48hewxLhB4wZjfyY/Y0Htgm
	 Yc8/6G9OdFdPvg3xdp4MHdjzONl2o3y8EDTRGUH9Nq9TseHROGoE9X6UG76cqQv6Xg
	 X12Aoc+CNVDhw==
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-abbdc4a0b5aso112940866b.0;
        Tue, 25 Feb 2025 23:31:15 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU/Dm/0la2BHvbeaIrecoeI5nnI/TvoG4BorzYUtAlDqFuXqpTvx8ov1kLCzNoBPsq43DrZgvahog==@vger.kernel.org, AJvYcCUNZtIWq/zmcb4A9/1E20rE9Ble7KpOpstf4cc9YLhpWQ/rUymc5XDg0DNoMh7UKrrAr0zExlLw@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+8WiFIRxS7Z2IMyvY4TKzMGfXSdu0v9qEJsA0nDVH3M4J3aFJ
	RIIhK6WJR1M/P6ouGqjKC6RN3Wmp2NCjiYtyZ/ldnXlkUbU3+kVZPrzgSlD/TIOlze+ph5wE3Yu
	uHdphOGb9G+T9Nw7L67492yfSeUo=
X-Google-Smtp-Source: AGHT+IHi3xtgg7YnzI+Jcx9Fcs6Gq+0rcQxYqtCtagcYKIrjfDLBAA746+JXeNVbIEwIs5vU6Tjo09OUkoTnu+CKb/k=
X-Received: by 2002:a17:907:9721:b0:abc:675:223a with SMTP id
 a640c23a62f3a-abc0ae56749mr1978891266b.12.1740555074027; Tue, 25 Feb 2025
 23:31:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250212141648.599661-1-chenhuacai@loongson.cn>
 <CAB=+i9QoegJsP2KTQqrUM75=T4-EgGDU6Ow5jmFDJ+p6srFfEw@mail.gmail.com>
 <CAAhV-H7i=WJmdFCCtY5DgE2eN657ddJwJwHGK1jgLKRte+VnEg@mail.gmail.com>
 <Z68N4lTIIwudzcLY@MacBook-Air-5.local> <CAAhV-H5sFkdcLbvqYBGV2PM1+MOF5NMxwt+pCF9K6MhUu+R63Q@mail.gmail.com>
 <Z686y7g9OZ0DhT7Q@MacBook-Air-5.local> <202502190921.6E26F49@keescook>
 <CAJZ5v0hZZdRPwp=OgPw4w8r9X=VbL6Hn6R4ZX6ZujNhBmMV3_A@mail.gmail.com>
 <CAAhV-H5UaEbA0DrAUfROJoiatwrjsge4DNcVTJi=8vtk2Zn+tQ@mail.gmail.com> <202502251240.49E8674AD@keescook>
In-Reply-To: <202502251240.49E8674AD@keescook>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Wed, 26 Feb 2025 15:31:03 +0800
X-Gmail-Original-Message-ID: <CAAhV-H43RS9Kfj__eHrzffUcC6BSESYTc0JiKWsn+Bg2BJkyZw@mail.gmail.com>
X-Gm-Features: AQ5f1Joxu_UopkQPLBA-KePS9ihPAB59eMx7EfEIEvM6WCCIkK02RbSokQ5Flgw
Message-ID: <CAAhV-H43RS9Kfj__eHrzffUcC6BSESYTc0JiKWsn+Bg2BJkyZw@mail.gmail.com>
Subject: Re: How does swsusp work with randomization features? (was: mm/slab:
 Initialise random_kmalloc_seed after initcalls)
To: Kees Cook <kees@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Harry (Hyeonggon) Yoo" <42.hyeyoo@gmail.com>, 
	Huacai Chen <chenhuacai@loongson.cn>, Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	Pavel Machek <pavel@kernel.org>, linux-pm@vger.kernel.org, 
	GONG Ruiqi <gongruiqi@huaweicloud.com>, Xiu Jianfeng <xiujianfeng@huawei.com>, 
	stable@vger.kernel.org, Yuli Wang <wangyuli@uniontech.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Christoph Lameter <cl@linux.com>, David Rientjes <rientjes@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Pekka Enberg <penberg@kernel.org>, 
	Joonsoo Kim <iamjoonsoo.kim@lge.com>, GONG Ruiqi <gongruiqi1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 26, 2025 at 4:41=E2=80=AFAM Kees Cook <kees@kernel.org> wrote:
>
> On Tue, Feb 25, 2025 at 07:35:13PM +0800, Huacai Chen wrote:
> > I have investigated deeper, and then found it is an arch-specific
> > problem (at least for LoongArch), and the correct solution is here:
> > https://lore.kernel.org/loongarch/20250225111812.3065545-1-chenhuacai@l=
oongson.cn/T/#u
>
> Ah-ha, so it seems like some system start was being incorrectly shared
> between restoration image and hibernated image? Yeah, that's important
> to fix.
>
> > But I don't know how to fix arm64.
>
> Is arm64 broken in this same way?
ARM64 is broken but I don't know whether it is in the same way, I just
know this patch can solve ARM64's problem:
https://lore.kernel.org/linux-mm/CAAhV-H7i=3DWJmdFCCtY5DgE2eN657ddJwJwHGK1j=
gLKRte+VnEg@mail.gmail.com/T/#m6ca3bd9fd3fe519161f28715279d0dc371027506


Huacai

>
> --
> Kees Cook

