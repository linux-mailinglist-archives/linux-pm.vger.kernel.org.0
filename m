Return-Path: <linux-pm+bounces-35418-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD32DBA13E3
	for <lists+linux-pm@lfdr.de>; Thu, 25 Sep 2025 21:43:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67B174C165D
	for <lists+linux-pm@lfdr.de>; Thu, 25 Sep 2025 19:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FB3D31DDB7;
	Thu, 25 Sep 2025 19:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SGz/XuAs"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2AE31DDA4
	for <linux-pm@vger.kernel.org>; Thu, 25 Sep 2025 19:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758829389; cv=none; b=DwekHaABT2z3sfUwdFccoq4Gd9WSjUZl6jCQB7aZqCOn4LyMhbWm7kkFt8YRAZRuLjPI7kxy8DA7vb0ndcIVl+uLWH7mhVZJH8c40egzGlw5Roieh61McSEylnML3LGbVwdjHxhtGo8TqrKaUFjqtx3sEbApmGB0au21ZgRfpJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758829389; c=relaxed/simple;
	bh=p9m63qbztqA2ZqEB3vay13lZfWLkiMoeU3IbsD91HtQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lbY6IWDo03ohGdge0y+h5F+sRVw3duorwWtJZZvjP+TBYIq+cRf1o7HyYSboARpWlhP+LGOlybZ3WThMiFfZWMZjmJODa2ijxdPBaRrcMNVoEn7rtl5x5avTeU1cPgeT8J+E6hd7oFSrcESall0+3jPAm1VKvLbDeeRXA46Wo/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SGz/XuAs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D156BC116B1
	for <linux-pm@vger.kernel.org>; Thu, 25 Sep 2025 19:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758829388;
	bh=p9m63qbztqA2ZqEB3vay13lZfWLkiMoeU3IbsD91HtQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=SGz/XuAsTcbinLOkMaW3WcuGwlFZyjFoUUa46dWdmi/brQ1lON5MX5V8MZ15S05C6
	 rvD/OTN1fjCHqI0nvjZfQmiL09uMKwEcstJra8PLJkWUZFdNeZczW3E9pZnwoTuv5/
	 nyXhQWuRWq70tnEAc8N5jQFOA2ev30fqyrgt4GTIikqMf4zxXC6F0S1JHjLEd7cXLQ
	 iA19uDSt6bAT93TPe0gE/Ary/xQwOJSO0lpLZrXyXWBs4REdf77yB6wZaEVGueamSc
	 sC4/68uoOFBQ22Si8MlcING/n/vVR0s/mae/eSwopo8dw610JUHoo6NKF7HtljFD8u
	 KQzJfBLVQ9Acw==
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-30cceb749d7so596208fac.2
        for <linux-pm@vger.kernel.org>; Thu, 25 Sep 2025 12:43:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUvfcmJSZlbrRFnz3cT6FgBOkRbx4hB7x/RjLKa4Xt9UCgQMBGSpqdfGr/K+yR6+t9rVzSxsvxn4Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YxXSsM3DYSDp2kqf9GLLn3nAJn4cZ2FHTnPxkM2TXlETr6DNNaO
	Mj87T5HN4ufw+gb2ttLVV1PF31EQD/E6ADXr33UlvBreFN/FBQzr2sGW1K+dvWWjtE2TFpL6ud+
	ge3HfqQ0ljMlLqHQ+VAiZHk0zkhp6JtI=
X-Google-Smtp-Source: AGHT+IE0ATqGlqZj1sCcE+gRnWpmVL5hKu3YF8bbl3xq78q2hcxItFzplLROHYVH/k48RmO/ChuvoYn9fUH38EOxfJA=
X-Received: by 2002:a05:6871:487:b0:321:2c50:30cb with SMTP id
 586e51a60fabf-35ebfac6d20mr1946262fac.12.1758829388150; Thu, 25 Sep 2025
 12:43:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250925185108.2968494-1-superm1@kernel.org>
In-Reply-To: <20250925185108.2968494-1-superm1@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 25 Sep 2025 21:42:56 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jCnmQSXRfSxD8rmn1Y=yuq-tSeOv3AgryowLJErZYRgQ@mail.gmail.com>
X-Gm-Features: AS18NWAaKYsDERrfCLjBdjk_K5aGDYw84ebSbsufMfMQNSWk0Kcqs8ZuEg2bUSE
Message-ID: <CAJZ5v0jCnmQSXRfSxD8rmn1Y=yuq-tSeOv3AgryowLJErZYRgQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] Fixes for hybrid sleep
To: "Mario Limonciello (AMD)" <superm1@kernel.org>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Samuel Zhang <guoqing.zhang@amd.com>, 
	"open list:RADEON and AMDGPU DRM DRIVERS" <amd-gfx@lists.freedesktop.org>, 
	"open list:HIBERNATION (aka Software Suspend, aka swsusp)" <linux-pm@vger.kernel.org>, Mario Limonciello <mario.limonciello@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 25, 2025 at 8:51=E2=80=AFPM Mario Limonciello (AMD)
<superm1@kernel.org> wrote:
>
> From: Mario Limonciello <mario.limonciello@amd.com>
>
> Ionut Nechita reported recently a hibernate failure, but in debugging
> the issue it's actually not a hibernate failure; but a hybrid sleep
> failure.
>
> Multiple changes related to the change of when swap is disabled in
> the suspend sequence contribute to the failure.  See the individual
> patches for details.
>
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/4573
>
> As it touches two subsystems it either needs to go through linux-pm
> or drm.  Patch 3 has an Ack from Alex, this should merge through
> linux-pm.
> ---
> v3:
>  * Push all calls for gfp mask changes into power_down()
> Mario Limonciello (AMD) (3):
>   PM: hibernate: Fix hybrid-sleep
>   PM: hibernate: Add pm_hibernation_mode_is_suspend()
>   drm/amd: Fix hybrid sleep
>
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |  2 +-
>  include/linux/suspend.h                 |  2 ++
>  kernel/power/hibernate.c                | 14 ++++++++++++++
>  3 files changed, 17 insertions(+), 1 deletion(-)
>
> --

All applied as 6.18 material, thanks!

