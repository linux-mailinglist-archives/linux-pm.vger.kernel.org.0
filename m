Return-Path: <linux-pm+bounces-38988-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DE6AC98680
	for <lists+linux-pm@lfdr.de>; Mon, 01 Dec 2025 18:07:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01F5B3A2A94
	for <lists+linux-pm@lfdr.de>; Mon,  1 Dec 2025 17:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CC49334C06;
	Mon,  1 Dec 2025 17:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r+v2JAZz"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082EF314A85
	for <linux-pm@vger.kernel.org>; Mon,  1 Dec 2025 17:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764608854; cv=none; b=mjlk0k0IVA2PFAhcJw3b/LmfV5Cd2S4NjQJwawg5HcyxDg7h3/KFS3eCXS79DlTSfYKnxOFidc7xWcUzCkAoP/QW43xlf2lAwQ1UvNkk2E1dG/5BP+ncXN5vHW2OtS+lPquriyzWstwX6Z2tT9snPgJuiRGE/KY416uuVn79Azs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764608854; c=relaxed/simple;
	bh=xiWwzvyz7Rlla83ISfa50GWqSVXN0YacvadxydSCATE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jRJeHQUYBuIkXke2OluOEknBGNlojciOcsJYctfdtpWw94cPthfmOdDTxNmHOjyQabTCoTM/hysAidP3G2HyzFutQ32jd/dZKhHyq9QuCe3QkkB6U0hRL+IWZvY6zCGUWBZoJX33esSC51x3uoWa5M/fb6N+YPsqOQ97nXQlCJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r+v2JAZz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F2A7C4CEF1
	for <linux-pm@vger.kernel.org>; Mon,  1 Dec 2025 17:07:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764608853;
	bh=xiWwzvyz7Rlla83ISfa50GWqSVXN0YacvadxydSCATE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=r+v2JAZzyTIJ5aJ6JknJ+YpKxJrBWcHIqKYKP2qzaf495q4i3nyELrOQvB8mLstp+
	 4UGueKgXxuXXXmjD45oMl/zqwnzvpMS9C4JLxc4RO6aA/itvF3+zqLa5imwn6FMemM
	 nK7LEPblkN8RNicAs8leXRoB9Ogf2/8yik7wrfe4m9mth+AMDTq1/0lJw91MQ/xCrK
	 ubznBLpZfg6/2EmFPsnPjO+R7tk5CQxlN+tBaSR+hpDNh7/IGlB/gC4QKNDD7NzQKs
	 Qp6pWgUAdBZCxAWsUWwK4NjijtowifViCUjo9dhA9LZNZG+92nlJ6WN4jHBRoOFM0+
	 aya2R9g3tn7hw==
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-656d9230ceaso666079eaf.2
        for <linux-pm@vger.kernel.org>; Mon, 01 Dec 2025 09:07:33 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU/2dnxiyd+ONX2cxlATaibCQES+osXRlLkMpJ8TOYpOMyZC6wdqlMlxWvdcMn6hNYG/M7DmQA/NQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyWb/ilwX8CuPt+D6WjJuc/Vc+hEauhExYc+WkwiHQRvmS3S4dg
	aDxmu49sudD7CH5X67qmzE0T8BA+P8a/wsCEHhziE2dMAiX4999mYhOTJQ+lt2Z1DEvn8FVoA47
	bvKurZiibzhQyYpOzIZ9+/sj2EAByXhM=
X-Google-Smtp-Source: AGHT+IGD3E4Y2IombvopsszHzV4phZ13zyl7e2iR4xPl1q6OlkLNMnWu8nY6uX+Mmkf1LsPqK8KyCd57NcGKRvNN7do=
X-Received: by 2002:a05:6808:2e48:b0:450:5bbe:642c with SMTP id
 5614622812f47-4511294e691mr16326454b6e.12.1764608852867; Mon, 01 Dec 2025
 09:07:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251113191609.28574-1-ehemily@amazon.de> <20251113191609.28574-2-ehemily@amazon.de>
 <CAJvTdK=_v9q2eGMB6qG3iaDhXMzQHz-EJ4NeDEfBe2fbv+wKfQ@mail.gmail.com>
 <BEYP281MB5509D3D7A01DEC1FAAEB9DBDBADCA@BEYP281MB5509.DEUP281.PROD.OUTLOOK.COM>
 <CAJvTdKnjreryLA9KuuobwJShbVseHOyujmXBAXRuSUDsCZxSVA@mail.gmail.com> <BEYP281MB550957A6BA42B6371400472FBADBA@BEYP281MB5509.DEUP281.PROD.OUTLOOK.COM>
In-Reply-To: <BEYP281MB550957A6BA42B6371400472FBADBA@BEYP281MB5509.DEUP281.PROD.OUTLOOK.COM>
From: Len Brown <lenb@kernel.org>
Date: Mon, 1 Dec 2025 12:07:22 -0500
X-Gmail-Original-Message-ID: <CAJvTdK=Ty4W=5diU0D0JYHh70ZN4avKjodUoLhuz_D7+=3xcdA@mail.gmail.com>
X-Gm-Features: AWmQ_bmts8ARs5kmJVc_BC2Z1vj43UQ9hpyoCSRH8fnJj3YIlIx4xahg6ID__Zw
Message-ID: <CAJvTdK=Ty4W=5diU0D0JYHh70ZN4avKjodUoLhuz_D7+=3xcdA@mail.gmail.com>
Subject: Re: [PATCH 2/2] tools/power/turbostat: Fix division by zero when TDP
 calculation fails
To: "Ehlert, Emily" <ehemily@amazon.de>
Cc: "Zhang, Rui" <rui.zhang@intel.com>, 
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Emily Ehlert <ehemily@amazon.com>
Content-Type: text/plain; charset="UTF-8"

> Reading the MSR succeeds, but the read value is 0. So at least for the
> Nitro Hypervisor testing for 0 would be sufficient.

Great!

> I am not sure how
> other hypervisor solutions handle this issue, but I assume it will either
> be 0 as well or not provide the /dev/cpu/*/msr file.

Agreed.

The historic probe strategy blindly read the MSRs
and tried to determine anoint an MSR as present
if it behaved according to some heuristics.

Today we have MSRs enumerated in a table.
So we can use the reverse probe strategy --
probe the enumerated MSRs and disqualify
them if they don't read, or read 0.

Indeed, RAPL Package Domain is universal -- if that doesn't
work, then I think we can disqualify all of RAPL.

I'll send you a patch for this later today.

Len Brown, Intel Open Source Technology Center

