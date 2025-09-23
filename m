Return-Path: <linux-pm+bounces-35252-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF96AB96F87
	for <lists+linux-pm@lfdr.de>; Tue, 23 Sep 2025 19:12:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA3584A0A96
	for <lists+linux-pm@lfdr.de>; Tue, 23 Sep 2025 17:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCD01277008;
	Tue, 23 Sep 2025 17:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hFiXw4HX"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9814827603A
	for <linux-pm@vger.kernel.org>; Tue, 23 Sep 2025 17:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758647537; cv=none; b=PqsrbgkDOl4trsNP2Ihiau205k3e7v+ywhASFGtdAt2kbGsaeP+olUrjFocBUctJaLdf+J4gBDf3IeNb78xrDmcWpY/gr72zwK18cW6fyKffo2lDC/EH8mPgoCiDrDunPJDRI2f5+oHqEeIHZomWdlmFlG2ZwLE2yev0MNMuG+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758647537; c=relaxed/simple;
	bh=zmjtE0Pg9ybScWl+KNxugj6NRHATWz4NuVjQRnO/EH4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jZHf89eBuGgi7u387bJiNc4hBAy8gmc+DTImCDJ0kU3wzZTq/vf8ZPbuUqaJOc9HrQq9dVW5qdP6/EnOPKMmlm7BV0D62ZytL1Wmo8x8kUt1PAb3w6JlhOmrfDtKqQ9dkhApmAZf4+kseme4MiFJJOoOiZ99wpxJ+5fQkAzIUz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hFiXw4HX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 100FBC19422
	for <linux-pm@vger.kernel.org>; Tue, 23 Sep 2025 17:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758647536;
	bh=zmjtE0Pg9ybScWl+KNxugj6NRHATWz4NuVjQRnO/EH4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=hFiXw4HXVUrg8mFx6KKpJWQ0zXf/ujKcPwAJVY8w9Pe8+GwDQlyEgjP9TPyHGRKqk
	 qwN1/gBzoghKyIGpb/IjHqxv0JvBW28w0gS6eJqRhRmGKDUjFUFxFr4VJ+XeHB0s6M
	 O3bxOkSoyHY4oX+YJ/tEaQkqEjJrHb78henzjV4qX/0hCUgcnJKvrimN/8Kohvyjth
	 bLjtL6mSaUR3z7xmgi2rNbGg7ZTOsMAYgVjFaoa7NbqFsKx8ia2i62iyIZ7j7fsjIY
	 V3RunUfoCb44Nw6xK6vFWE3HpdmzOi0DpW5oOqo1n7VOW0uXOv2hWw61lIpv+5Cmmw
	 pJsS3+AJSX/yg==
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-62f926c7888so75061eaf.0
        for <linux-pm@vger.kernel.org>; Tue, 23 Sep 2025 10:12:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXA2rdGFUjiTqMJfnYO0C5/GazXSq31mZVo9O+BpeEWcPvzZx9ijh//SljdG5OxFxsv8z0nEubURg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzBCwlZ8sPQrSGpC22Bh7s5Ota3DhrohRC9Bz3yRFV2u+lOBCPy
	8b1+/RFFVJvkhwt6esOBSXaXRjIbq1IVsJGojk31ADRHskqIPnw3Gz27U9FtzKFGTYqLSg5l5no
	JsjS8M4yGlWGdAyzicl4i0CXYFrZNGcs=
X-Google-Smtp-Source: AGHT+IHOSQyeOX2xQmbUmiEzFwBxhPqNMWpEZ/dCxFg/s6P9IdxrIKUnE1S3WMtRGifCWrHavSLPTmCtP0Eog9z2aqQ=
X-Received: by 2002:a05:6808:80a6:b0:43b:ea80:d169 with SMTP id
 5614622812f47-43f2d19768dmr1755849b6e.8.1758647535301; Tue, 23 Sep 2025
 10:12:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJZ5v0guEkbMuMjS=aQRQdiiyUG_hxgu0imBX0kgho2womB0Hw@mail.gmail.com>
 <20250923161354.1307251-1-luogf2025@163.com>
In-Reply-To: <20250923161354.1307251-1-luogf2025@163.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 23 Sep 2025 19:12:03 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0j2UH31wJKsAE0Ppek9sSiGFbePZymzbuaLVNfKHXjK4A@mail.gmail.com>
X-Gm-Features: AS18NWD62UAzJRnQliopclNZf9FndoSJt3Hc02TH-qB6ft9kOc0CHGMVi2jrw98
Message-ID: <CAJZ5v0j2UH31wJKsAE0Ppek9sSiGFbePZymzbuaLVNfKHXjK4A@mail.gmail.com>
Subject: Re: [PATCH v6] ACPI: battery: prevent sysfs_add_battery re-entry on
 rapid events
To: GuangFei Luo <luogf2025@163.com>
Cc: rafael@kernel.org, michal.wilczynski@intel.com, dan.carpenter@linaro.org, 
	lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, lkp@intel.com, sre@kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 23, 2025 at 6:14=E2=80=AFPM GuangFei Luo <luogf2025@163.com> wr=
ote:
>
> The functions battery_hook_add_battery(), battery_hook_remove_battery(),
> and sysfs_remove_battery() already acquire locks, so their internal
> accesses are safe.

In fact, there are two locks in use, battery->sysfs_lock and
hook_mutex.  The latter is used for managing hooks and the former is
only used by sysfs_remove_battery(), so it only prevents that function
from racing with another instance of itself.

I would suggest using battery->sysfs_lock for protecting battery->bat
in general.

> acpi_battery_refresh() does check battery->bat, but its child
> functions (sysfs_add_battery() and sysfs_remove_battery()) already
> handle locking.

What locking?  Before the $subject patch, sysfs_add_battery() doesn't
do any locking at all AFAICS.

> In acpi_battery_notify(), battery->bat has no lock. However, the
> check of battery->bat is at the very end of the function. During
> earlier calls, battery->bat has already been protected by locks, so
> re-entry will not cause issues.

All of the battery->bat checks and the code depending on them need to
go under the same lock.  I'd use battery->sysfs_lock for this as
already mentioned above.

