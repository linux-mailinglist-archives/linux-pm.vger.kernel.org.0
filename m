Return-Path: <linux-pm+bounces-26369-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98EA0AA094D
	for <lists+linux-pm@lfdr.de>; Tue, 29 Apr 2025 13:11:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 249F31894F08
	for <lists+linux-pm@lfdr.de>; Tue, 29 Apr 2025 11:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52C0B2BEC43;
	Tue, 29 Apr 2025 11:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TEaDg9TL"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CABC2BE7C8
	for <linux-pm@vger.kernel.org>; Tue, 29 Apr 2025 11:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745925073; cv=none; b=JjT8D2NVKozRWWToeKVG7kqUVBSZSvlmMFev8krjx2TIXg4exs2P9jFm1K2Ic++kRN66c0qt1Qo7MDwrObirV6LX1xrTA5i4+wW3nNdPNrRVXX/hHwNRnJQWYMi4lDSZwPgpZCqxudcOy1fnlnIQeL5ffJ7MlPOx5mtkODdzZXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745925073; c=relaxed/simple;
	bh=D2BOPQmKj7TwsAsDqa8iaY61DYLGG7MTVKcZ7HNQsKU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=exmysm25h3CAbRU505s8Q/bqs51w2ts7+iD3MFDX7BQmcTkOCKVlu5wtxDP2cciI1cFoZ1QMmMNWkfiNNrrLhwQVfjJONGIpjQGrKMFluPzLuCTUgH3NxzAMtwKUvST8UGFrsFCu9eYnZdWx5ha+xJ/sL4BXZq9i5lBOWiqU/zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TEaDg9TL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A629CC4CEEE
	for <linux-pm@vger.kernel.org>; Tue, 29 Apr 2025 11:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745925072;
	bh=D2BOPQmKj7TwsAsDqa8iaY61DYLGG7MTVKcZ7HNQsKU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=TEaDg9TLt7H7H9tlrB5xxBqCZKNH161nHuy9PLHIwSEiHuS8CbkghUe1AZnMDgk4D
	 7tZvcezf43gsd8iMM1+66LUe0dEtABzAVklTvtRvnEvpc+DKN3bg650FeD/8/Q9d2a
	 LchXrab2dQAcmH7bOl+Z5P2V9tsmPH2OCzvLBIfnbqwXJxmGasMt4wy3n92FDe2ArT
	 Cdw8+UL/wArCSFzcWMJbKcKPg+rxa5gB78GG12P61pZ7epORWJ52EkQgSRGtlMLinD
	 IqQgx4xjw43WV18F61EIXsCxu6rPc5GNAhzP33/eSqmaKPyXVTXnurIjnDOigd/p6R
	 na778P9tigXkQ==
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-72ec926e828so1614185a34.0
        for <linux-pm@vger.kernel.org>; Tue, 29 Apr 2025 04:11:12 -0700 (PDT)
X-Gm-Message-State: AOJu0YwbcehibGgs0nGWszb6pzwoUWr29Vo+fY+mOLkgQytiXfTvBZKi
	BXz9AVSK14quk1ds7w4kcP72Cd64xgcHx8HTwVt3oyWsjza1lj4Epef6l2L3MNfYt1YYbdC2HTB
	SaIFk8P14e+BUDDtzcAep6uAONHA=
X-Google-Smtp-Source: AGHT+IE5kBugbGMufTjbQPSW0io8Y1pj0vSD8gtbNo3FGhjA2ipznUQ+lFBePzgjBe5qmhABIV2jBVMerUaDeVVgCQg=
X-Received: by 2002:a05:6870:4595:b0:29e:503a:7ea3 with SMTP id
 586e51a60fabf-2d9be8f1b56mr6404504fac.36.1745925071953; Tue, 29 Apr 2025
 04:11:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250410153106.4146265-1-sakari.ailus@linux.intel.com>
In-Reply-To: <20250410153106.4146265-1-sakari.ailus@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 29 Apr 2025 13:10:59 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iSNwPLLjvoHdgZRUG6_=EEZUrs6tvrfKAymRD8PH9-4g@mail.gmail.com>
X-Gm-Features: ATxdqUGCFmrTPn68QJSVhD2xWfcqVtF5WZwc1zlf42by5Dpu1aPgjng2J05bBFQ
Message-ID: <CAJZ5v0iSNwPLLjvoHdgZRUG6_=EEZUrs6tvrfKAymRD8PH9-4g@mail.gmail.com>
Subject: Re: [PATCH 0/7] Update last busy timestamp in Runtime PM autosuspend callbacks
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Len Brown <len.brown@intel.com>, Pavel Machek <pavel@kernel.org>, 
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Apr 10, 2025 at 5:31=E2=80=AFPM Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:
>
> Folks,
>
> The original plan for adding pm_runtime_mark_last_busy() calls to
> functions dealing with Runtime PM autosuspend originally included a few
> intermediate steps of driver conversion, including the use of recently
> added __pm_runtime_put_autosuspend(). The review of the set converting th=
e
> users first to __pm_runtime_put_autosuspend() concluded this wasn't
> necessary. See
> <URL:https://lore.kernel.org/all/20241004094101.113349-1-sakari.ailus@lin=
ux.intel.com/>.
>
> This set extends the inclusion of the pm_runtime_mark_last_busy() call to
> the _autosuspend() variants of the Runtime PM functions dealing with
> suspending devices, i.e. pm_runtime_put_autosuspend(),
> pm_runtime_put_sync_autosuspend(), pm_runtime_autosuspend() and
> pm_request_autosuspend(). This will introduce, for a brief amount of time=
,
> unnecessary calls to pm_runtime_mark_last_busy() but this wasn't seen as
> an issue. Also, all users of these functions, including those that did no=
t
> call pm_runtime_mark_last_busy(), will now include that call. Presumably
> in the vast majority of the cases a missing call would have been a bug.
>
> Once this set is merged, I'll post further patches to remove the extra
> pm_runtime_mark_last_busy() calls. The current set of these patches is
> here
> <URL:https://git.kernel.org/pub/scm/linux/kernel/git/sailus/linux-next.gi=
t/log/?h=3Dpm-direct-on-next>.
>
> It'd be best to have all merged within the same cycle.
>
> The changes in the patches to remove the pm_runtime_mark_last_busy() call=
s
> have been generated using the following Coccinelle spatch:
>
> @@
> expression E;
> identifier label, rval;
> @@
> - pm_runtime_mark_last_busy(E);
> ...
> (
>   label:
> |
> )
> ...
> (
>   pm_runtime_put_autosuspend(E);
> |
>   pm_runtime_put_sync_autosuspend(E);
> |
>   pm_runtime_autosuspend(E);
> |
>   pm_request_autosuspend(E);
> |
>   (void)pm_runtime_put_autosuspend(E);
> |
>   (void)pm_runtime_put_sync_autosuspend(E);
> |
>   (void)pm_runtime_autosuspend(E);
> |
>   (void)pm_request_autosuspend(E);
> |
>   return pm_runtime_put_autosuspend(E);
> |
>   return pm_runtime_put_sync_autosuspend(E);
> |
>   return pm_runtime_autosuspend(E);
> |
>   return pm_request_autosuspend(E);
> |
>   rval =3D pm_runtime_put_autosuspend(E);
> |
>   rval =3D pm_runtime_put_sync_autosuspend(E);
> |
>   rval =3D pm_runtime_autosuspend(E);
> |
>   rval =3D pm_request_autosuspend(E);
> )
>
> Sakari Ailus (7):
>   Documentation: pm: runtime: Fix a reference to
>     pm_runtime_autosuspend()
>   pm: runtime: Document return values of suspend related API functions
>   pm: runtime: Mark last busy stamp in pm_runtime_put_autosuspend()
>   pm: runtime: Mark last busy stamp in pm_runtime_put_sync_autosuspend()
>   pm: runtime: Mark last busy stamp in pm_runtime_autosuspend()
>   pm: runtime: Mark last busy stamp in pm_request_autosuspend()
>   Documentation: PM: *_autosuspend() functions update last busy time
>
>  Documentation/power/runtime_pm.rst |  50 ++++----
>  include/linux/pm_runtime.h         | 187 +++++++++++++++++++++++++----
>  2 files changed, 186 insertions(+), 51 deletions(-)
>
> --

Am I correctly expecting a v2 of this series to be posted?

Thanks!

