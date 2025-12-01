Return-Path: <linux-pm+bounces-39002-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 41BF8C98D13
	for <lists+linux-pm@lfdr.de>; Mon, 01 Dec 2025 20:14:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3503E4E1EFA
	for <lists+linux-pm@lfdr.de>; Mon,  1 Dec 2025 19:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71E2323C4FF;
	Mon,  1 Dec 2025 19:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B35oOzKt"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C33C23AB87
	for <linux-pm@vger.kernel.org>; Mon,  1 Dec 2025 19:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764616477; cv=none; b=Y13ZOBM6julRqk5UW7FhakQY1JLp/u3n+IM82TLtgynBH1eM8IXHO11EHteNKc+3StSUVddny2ODRQJCSYTUZh+Tab+aBFTI4Bvnnbdugz9aQhyHgjxjE5qPCqiNMo2OaL3JKlNFbbva+pVErcfnvqbl/aKcwgzLKIUa2qPCZZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764616477; c=relaxed/simple;
	bh=7jfkaZtqobutyxAPwnyT8Q3otUIU/JsJ5ygLDNdwHNQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rfS+D//WLBxZWwKZxT0TsWQKun0QRQlGBL3Lmt2xdJbfifqy1PlvVxhuiKFz3iC9zst3zavU7qjKtBkWi0uRsa0c/oZTrXgJ+BX1Dr1vIWJPxoaMtMR2JBgzv3bYkHCPFbgPeM2X3mTAIiK90cxhSBCK/2eGwaoAvmYWthfx9R8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B35oOzKt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8958C4CEF1
	for <linux-pm@vger.kernel.org>; Mon,  1 Dec 2025 19:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764616476;
	bh=7jfkaZtqobutyxAPwnyT8Q3otUIU/JsJ5ygLDNdwHNQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=B35oOzKtMD1v1LzHpQYz01Y8yp/ViMWvrWQZCK98v9CJy9Efl8aJD/89FJv8nkc66
	 JoyxNsRcPMDzZ5Y6Kg+gdnpgsNZMHRkXDuBaIsBO7T/6R+F+cJr64an3tgM7krLI/Y
	 fHuJc+ZYb5BMcZpcXoFELFDJVY3i1fr3lveVCKJNDqT0Rjs15KiaKl3PBWAush9Ob3
	 zWILSavYYZkD1ylrJvOfTQGj/nAPbv5aBKVVJy2jvL/w+Kn7Yu7we9PcCVuzod80Aj
	 EP7QLlAjXoLrOHfKnVHtRrZy+h45N6fn4t994sORzbRTm35OPzmIVm9p2hK6WrKm7d
	 gpa5bnGamPUUA==
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-656b52c0f88so1703876eaf.0
        for <linux-pm@vger.kernel.org>; Mon, 01 Dec 2025 11:14:36 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW3+tLpI8ebLvAUzwoJ+Z60gPotVuGav31kE1SU3wT9+15L8VsRZCmNn0nqifhsj7XYvWtkt0/lSg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8J+oBuLMp0Sr0qL87gsszoyft13p+EGp0OGfnaHp67XSujTwJ
	bPebxErZnlOZO6++hdUNfI0HRO3axOzcvXpuO6thgCUj4bUzVW/e6e6nv9BJ5rHey8WQ64MSLKe
	NYbAjF6mVfvy+RMbw7dS2thhdG9evgC0=
X-Google-Smtp-Source: AGHT+IGbyBgggpUMgnDvsKXrjtsFhGtCrzvwsrsXmb3NJcxvjktKqe3EEYSwR+31pXMs2DaWKYxVufVo+2C/ofi3d1I=
X-Received: by 2002:a05:6808:309d:b0:44d:baae:fb0a with SMTP id
 5614622812f47-4514e5f9020mr12688863b6e.5.1764616476325; Mon, 01 Dec 2025
 11:14:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251113191609.28574-1-ehemily@amazon.de> <20251113191609.28574-2-ehemily@amazon.de>
 <CAJvTdK=_v9q2eGMB6qG3iaDhXMzQHz-EJ4NeDEfBe2fbv+wKfQ@mail.gmail.com>
 <BEYP281MB5509D3D7A01DEC1FAAEB9DBDBADCA@BEYP281MB5509.DEUP281.PROD.OUTLOOK.COM>
 <CAJvTdKnjreryLA9KuuobwJShbVseHOyujmXBAXRuSUDsCZxSVA@mail.gmail.com>
 <BEYP281MB550957A6BA42B6371400472FBADBA@BEYP281MB5509.DEUP281.PROD.OUTLOOK.COM>
 <CAJvTdK=Ty4W=5diU0D0JYHh70ZN4avKjodUoLhuz_D7+=3xcdA@mail.gmail.com>
In-Reply-To: <CAJvTdK=Ty4W=5diU0D0JYHh70ZN4avKjodUoLhuz_D7+=3xcdA@mail.gmail.com>
From: Len Brown <lenb@kernel.org>
Date: Mon, 1 Dec 2025 14:14:26 -0500
X-Gmail-Original-Message-ID: <CAJvTdKmr=AVo7UQP28EeD6oLzyeOM+vGCjZZMBo1bV=4n1pcmg@mail.gmail.com>
X-Gm-Features: AWmQ_bkXzyBAA4uCvx8rm8nPgZ7viyFTbRj9LgTD7jCC7b0T2y3P04Itv3otEf0
Message-ID: <CAJvTdKmr=AVo7UQP28EeD6oLzyeOM+vGCjZZMBo1bV=4n1pcmg@mail.gmail.com>
Subject: Re: [PATCH 2/2] tools/power/turbostat: Fix division by zero when TDP
 calculation fails
To: "Ehlert, Emily" <ehemily@amazon.de>
Cc: "Zhang, Rui" <rui.zhang@intel.com>, 
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Emily Ehlert <ehemily@amazon.com>
Content-Type: text/plain; charset="UTF-8"

> I'll send you a patch for this later today.

Please try the latest turbostat in my public tree:
git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux.git turbostat

The top commit should be this:

commit 4b295ae45d3e6eb4d811c8fc2408b9e4e91c9474 (turbostat, next)
Author: Len Brown <len.brown@intel.com>
Date:   Sun Nov 30 00:11:22 2025 -0500

    tools/power turbostat: Validate that RAPL MSRs really exist

    Even though the platform->plat_rapl_msrs enumeration may be accurate,
    a VM may deny access to the underlying MSRs.

    Probe if PKG_ENERGY is readable and non-zero.
    If no, ignore all RAPL MSRs.

    Reported-by: Emily Ehlert <ehemily@amazon.de>
    Signed-off-by: Len Brown <len.brown@intel.com>

