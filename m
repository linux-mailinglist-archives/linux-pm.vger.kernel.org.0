Return-Path: <linux-pm+bounces-38182-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 229FEC6A150
	for <lists+linux-pm@lfdr.de>; Tue, 18 Nov 2025 15:47:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CCFF3342960
	for <lists+linux-pm@lfdr.de>; Tue, 18 Nov 2025 14:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF79A30EF91;
	Tue, 18 Nov 2025 14:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lMtMRxRW"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAFFB2F5480
	for <linux-pm@vger.kernel.org>; Tue, 18 Nov 2025 14:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763477231; cv=none; b=PmDJkcN3zLdSlRtKli/fwo21WZHPRVkdOPq3Z/32EfU9X1G0Cwd0/f+CgHISc2t3JIoOFxGs8xRVpIv9fJgcQROOWVC3bn026QTOgmVDFJeVaiMYQL/OlLjapChya1lNBzqBeMGPZoefECqiJoPu4CjKGQv9E7arlXFW2M//3Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763477231; c=relaxed/simple;
	bh=ICprrTCzS46zLOEdTFy3pFpHuN3bM7na6VyO1c78UJM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VxdH6sV46v9Bm2DBe4mvAr93mQ87pn+0gtH7YJ9cVP0NAK/33q7CCz76/vWpLYYuDg3rdCZdhw7MXLmTPrz6mjSaT2sbJQMr9yrVKIQT99Qq1DWzaOs4HLo58izbP+Me/aRiMsKAOz+UbTsOBkrOPaYsG5iCWS6ZEWzoijhn61M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lMtMRxRW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A577C2BCB4
	for <linux-pm@vger.kernel.org>; Tue, 18 Nov 2025 14:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763477230;
	bh=ICprrTCzS46zLOEdTFy3pFpHuN3bM7na6VyO1c78UJM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=lMtMRxRWVFpC122i+c+hz0MWUlrNFzGVqe5gcDDOyYwop/NgEW6oq73y3nk0HWiRi
	 xMoWgOkA2m+ixLU6kEkkukyZreOQ+QX9W011XxaWEHCK6E4fBPyn9SKPP8WGnzqWUC
	 ZrLyOBIcErnOn/mcSwBUJ+92y9QBnNyFnYjoErZ1SzKojeotRrLk9sFhzCuCGrepdP
	 4WGjL7O0YH+u7+5g5jaw7y8tK4Cl4XzdMHn87hyKIov9XLcZOoCnpM+wIpQQPgpwjs
	 517lW+pxZiblUg/Z1sW9wAe6UKPjceF3bYJRbNZ4icq3oQZ27BSR1AWHDiatR3vuaj
	 cPLq7mRKVyzqg==
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-657509d761dso1240271eaf.0
        for <linux-pm@vger.kernel.org>; Tue, 18 Nov 2025 06:47:10 -0800 (PST)
X-Gm-Message-State: AOJu0YyHXH9vYuHBi2XD2hzaPE+A6q2ZrYUDLu1slabpAm/jxi3GbYoI
	YNLrNb/oj/hFIItnf/XnXZ4uLzGkzE5LwwYD7zL3R7M+KgVQOlIHkBUid+iGm2qDOuqBp3JuA2B
	5TCqr//9RtyCbjzOHyp3gMyEW5Ep3QdM=
X-Google-Smtp-Source: AGHT+IH8UQvQU/YsALMlwAiFKf1ochMk9D87SoHqtxN0SpVUmK4zec5YtGAuMBSItCbYPtK1bVKllcQMmDzSiqhNMzQ=
X-Received: by 2002:a05:6820:c307:20b0:657:63b1:660 with SMTP id
 006d021491bc7-65763b10a13mr997228eaf.4.1763477229559; Tue, 18 Nov 2025
 06:47:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251028101814.3482508-1-kaushlendra.kumar@intel.com>
 <CAJZ5v0gXS0TgAF6AqboN_NKGXxx7onsK8QRv7eCVQFStkQXJXQ@mail.gmail.com> <62c63a985c63eb73941d7edecc088f909aebb114.camel@linux.intel.com>
In-Reply-To: <62c63a985c63eb73941d7edecc088f909aebb114.camel@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 18 Nov 2025 15:46:58 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jKLZB_SbOFnYXkUAvXO3tuxcRC3VXYqDdSTuk4ai5L4Q@mail.gmail.com>
X-Gm-Features: AWmQ_bnuvhjOV4Mmp071qE_Z-fprvYyuFM9kFhETeAlOhcd2t2oZJ-CPBY-2S5g
Message-ID: <CAJZ5v0jKLZB_SbOFnYXkUAvXO3tuxcRC3VXYqDdSTuk4ai5L4Q@mail.gmail.com>
Subject: Re: [PATCH] powercap: intel_rapl: Add support for NOVALAKE processors
To: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>, 
	Kaushlendra Kumar <kaushlendra.kumar@intel.com>
Cc: linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 17, 2025 at 11:07=E2=80=AFPM srinivas pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> On Tue, 2025-10-28 at 13:31 +0100, Rafael J. Wysocki wrote:
> > On Tue, Oct 28, 2025 at 11:20=E2=80=AFAM Kaushlendra Kumar
> > <kaushlendra.kumar@intel.com> wrote:
> > >
> > > Add RAPL support for Intel NOVALAKE and NOVALAKE_L processors using
> > > the core defaults configuration.
> >
> > Srinivas, any concerns?
> >
> No. Except in the subject say "Nova Lake" instead of "NOVALAKE" to be
> compatible with existing style.

Done (and analogously in the changelog).

Applied as 6.19 material with the above changes, thanks!

