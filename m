Return-Path: <linux-pm+bounces-6409-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CD7C8A5105
	for <lists+linux-pm@lfdr.de>; Mon, 15 Apr 2024 15:22:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD4FC2846ED
	for <lists+linux-pm@lfdr.de>; Mon, 15 Apr 2024 13:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45C7812B169;
	Mon, 15 Apr 2024 13:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lNab3ihK"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 211E412B15A
	for <linux-pm@vger.kernel.org>; Mon, 15 Apr 2024 13:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713186343; cv=none; b=ovL9w6kXM/fgrX63jXivxYWJgWeupJjwUVgHWPfaygs88g74cawMAE61ayIXcGPdzuD+OacCZcTbCgYWRGiGe+tBI5dClqibobBnbFcpQg2g1E10dAiLAO8EfXPeZ53yDwkRV6G1vLa26egBctIg/uc9FE0COfeVSZHyiNnkuhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713186343; c=relaxed/simple;
	bh=UdcgrZvcg3EuKBm8pkI93+p4iO+n+BuFBvHk6daYNqA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nGY8yw2nwqnGwoAb1p7Bk/9PNeld3r9IFkocgFEACi+q7e8Kgfr2YI0XHcjjflQ1s2/LxBdCXYEi0Dhb+g6hWTggOjKtGe6fnwBHphOCKFhiJ9ZURIzYNaNmv03zra5LEH4o+vQZtmdDdxJL1qGZOjntASrypm3MEfoZCYLRL4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lNab3ihK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DC90C4AF07
	for <linux-pm@vger.kernel.org>; Mon, 15 Apr 2024 13:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713186342;
	bh=UdcgrZvcg3EuKBm8pkI93+p4iO+n+BuFBvHk6daYNqA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=lNab3ihKiDKu6NfPP+YPLRY4VkH6H6T3vqq3mQ+i9TmlQro7Itd7IUkU9gGavndyL
	 mqNH1CsyEhALN9XlaZZK4ebyRrSryFsVG1+EHRspbMUavz2/Wge/oNAouJ8t/EGnBh
	 zZsWmzjgdHucTcJ+qf2Sjoq/z1sKM6Nf441TRcSv0fnau84pKSF76xD7/PTl+2Xeaq
	 qqOL0rpUrism8/Ju0vzzmn27TF8LLNtsyuEaVTnL+O4NN9I0Ur6cSUmefjm6hW4n0w
	 IkoLNTaruNEKO3OCbQYpgzeSic0VDaLkx4mg57a73vEwWTZQQecWcu4K2T4Vo9GfVU
	 MhyL5CFM42w5g==
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-22f0429c1ebso244590fac.0
        for <linux-pm@vger.kernel.org>; Mon, 15 Apr 2024 06:05:42 -0700 (PDT)
X-Gm-Message-State: AOJu0YzaOxD3cUyfr4bMFX9CLQaqZENyg+HIRSmTwEE2wxG6Skx4/4YJ
	smEkbE2uq6ctTVMnXc3zvPveq7ZlLiMqCRkke9d76ZqN5YHu6sGzRLExXFHg9sLAh9Gp2cgcwFe
	RI3Ig/TCtGjUYApWLRilPZnW/MaY=
X-Google-Smtp-Source: AGHT+IEkiofY0bovfF49b5TF7HacpZWF6tx0JiIgegohMn8jgBSjJy7ABLTv+4XKMMsLjR5Sj0v1KmccSaT65eTDvYs=
X-Received: by 2002:a05:6870:b411:b0:22e:b2ea:5758 with SMTP id
 x17-20020a056870b41100b0022eb2ea5758mr11136386oap.0.1713186341987; Mon, 15
 Apr 2024 06:05:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <b702c59f-7a5b-48f5-a726-a4840ce05c3f@panix.com>
In-Reply-To: <b702c59f-7a5b-48f5-a726-a4840ce05c3f@panix.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 15 Apr 2024 15:05:31 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0j48UTHj1cFNUR=EUuW1zugYxktX_t_tJFhFG5rNExyWA@mail.gmail.com>
Message-ID: <CAJZ5v0j48UTHj1cFNUR=EUuW1zugYxktX_t_tJFhFG5rNExyWA@mail.gmail.com>
Subject: Re: Kernels 6.8+ no longer resume fully after a hibernate
To: Kenneth Crudup <kenny@panix.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, 
	"Wysocki, Rafael J" <rafael.j.wysocki@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 13, 2024 at 7:21=E2=80=AFPM Kenneth Crudup <kenny@panix.com> wr=
ote:
>
>
> I can't resume my system (Dell XPS 9320) after a hibernate in any 6.8
> kernel (incl. the recently-released 6.8.6); the resume apparently
> succeeds, but things are non-responsive and I suspect it's the disk I/O
> system.
>
> I use a swapfile, if it matters.
>
> I've been trying to bisect this failure for a while with no success, but
> in the process I'd determined the 6.7 series fails in the same way and
> was fixed sometime between v6.7.2 and v6.7.3.
>
> I had to reverse "good" and "bad" in the v6.7 bisection due to the "not
> ancestor of" issue (so I may not have done it properly, but I've
> attached the bisection log) but was able to allegedly track it to commit
> 9bd3dce27b0 ("PM: sleep: Fix possible deadlocks in core system-wide PM
> code"), but trying the kernel committed immediately before (and after)
> that didn't seem to make a difference.

If running the kernel without this commit (which you did IIUC) doesn't
make a difference, then it certainly is not the culprit.

However, converging the bisection on it indicates a problem with
device dependencies on your system.

Can you please try

# echo 0 > /sys/power/pm_async

and hibernate after that?

If it resumes correctly (and reproducibly), at least one device is
resumed too early in the async case.

