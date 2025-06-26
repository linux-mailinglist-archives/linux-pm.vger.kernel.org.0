Return-Path: <linux-pm+bounces-29611-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 590F1AEA589
	for <lists+linux-pm@lfdr.de>; Thu, 26 Jun 2025 20:42:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B93175620F8
	for <lists+linux-pm@lfdr.de>; Thu, 26 Jun 2025 18:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 875032ED172;
	Thu, 26 Jun 2025 18:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FlDlwvX0"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6352D2EBBBC
	for <linux-pm@vger.kernel.org>; Thu, 26 Jun 2025 18:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750963323; cv=none; b=rSRvT5CZVmp+Z5iaZ1K8SrlMvmokDVIrtqOjgHC4pCShIfB40Zsv1c/8JYG5rC3Ri6pPxzeacZvhjRF9BFjpaWl82IiyC53OgwqkMAYAtxOakHslFFOmH/4AyKxVZ3Tib0VPdhMW2omEa2bN61CZqu6VHgGda/FX6ueXrBJGFqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750963323; c=relaxed/simple;
	bh=oSH+uyYEs2L275InMRgKzvBdu+ZCytwzQlrMPmj47Ac=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NNhEQ83mLnQUii646W2ntnuhrOcC97n6LLByB2Ap6i33DIP0+MraMb6oM8r5LgYW4lI1J9KAuTBtOD+w2TZwQESKmZ6agjq3Bv18wVuxo4+FyRcx/xK2Fh95f9LwQA4VUSzZhUgq3gcoEBo3oqvj8awoi80eCE3llgvs7uux+j4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FlDlwvX0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1A15C4CEF2
	for <linux-pm@vger.kernel.org>; Thu, 26 Jun 2025 18:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750963322;
	bh=oSH+uyYEs2L275InMRgKzvBdu+ZCytwzQlrMPmj47Ac=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=FlDlwvX0LQKyKpT+nMX2MfKzk3Z7TSau5v5AEYk0dsQr3HBFyaqgMNtBPcL4eaf5R
	 xForqYsi22B19BHWAuvAEkmHgpbmTHO6d2iPaHNAHb/GlWn3XyRD5URBINumKxkc3E
	 i3g5XcJCyochVHvin8+Dv5SE2p0V5E4PYEUzWCKmEnL/nJjhrqAGO9+AULAInCsc0a
	 /kuUi/zFjReMPtLpdGfKnKVJLIBh0lrdbNYfsucd65VkcB3PJX1sD9ysc3bGVzzTYB
	 NIrqg28edmh1g2sDhddM5oaCqcUFukXwO7bgtWR/GEa3dNpUe0mXryLznEN5jma2Fi
	 Ou5dVA2KsiiDA==
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-6118b000506so464578eaf.0
        for <linux-pm@vger.kernel.org>; Thu, 26 Jun 2025 11:42:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWbAtpFyAaoiyhY2bL+T+Z9GNVr/GMB1OjQZm7YwAwKkapkDN8Xe+jOhzSUaWhiqsUGHZC6pBEsRg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0/OczXWPEsvNqTR8LotoW6jKDJycLCKhFiA5dPNlYjkBErpb3
	6Vpxt5PBqrCP58zdXhHasvuK0rfjtjqEuKMJGqSZ/g6byJpcI02eJVhgtbaGtE3G0BK0KKmxU6j
	w+hJU6hjYYnq3J7gTEsYiIfDHd7nlLlE=
X-Google-Smtp-Source: AGHT+IEmrPAdUCMPURIBxZDmifSkHLhGZoub/t1yDrvW+aUfIqoH2qX2gOtyAVWMmYsx3fb9j9P8rfCoElzDJiap+rU=
X-Received: by 2002:a05:6820:3093:b0:611:ac4e:f140 with SMTP id
 006d021491bc7-611b901a6admr315943eaf.2.1750963321999; Thu, 26 Jun 2025
 11:42:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250613214413.4127087-1-superm1@kernel.org> <dn6yc4swdyek4gz3bv7g4y5e6xzmo6vm5gkqqhmhbdhomnglbt@nsepw42i6hwz>
In-Reply-To: <dn6yc4swdyek4gz3bv7g4y5e6xzmo6vm5gkqqhmhbdhomnglbt@nsepw42i6hwz>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 26 Jun 2025 20:41:50 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hAxF0Rt3Xv+CySa3-rwWkODwG3mmSYxWQs-F3cqkZ-JA@mail.gmail.com>
X-Gm-Features: Ac12FXzJaY7TW7u8BsjbJtS8Xn0Ot9Y1XPuprFTic9mdQXn_mrlZ8A79MOn8K18
Message-ID: <CAJZ5v0hAxF0Rt3Xv+CySa3-rwWkODwG3mmSYxWQs-F3cqkZ-JA@mail.gmail.com>
Subject: Re: [PATCH] PM: Restrict swap use to later in the suspend sequence
To: Lucian Langa <lucilanga@7pot.org>
Cc: Mario Limonciello <superm1@kernel.org>, mario.limonciello@amd.com, rafael@kernel.org, 
	len.brown@intel.com, pavel@kernel.org, gregkh@linuxfoundation.org, 
	dakr@kernel.org, Andrew Morton <akpm@linux-foundation.org>, bhe@redhat.com, 
	christian.koenig@amd.com, linux-pm@vger.kernel.org, kexec@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 23, 2025 at 8:25=E2=80=AFAM Lucian Langa <lucilanga@7pot.org> w=
rote:
>
> On 13.06.2025 16:43, Mario Limonciello wrote:
> > From: Mario Limonciello <mario.limonciello@amd.com>
> >
> > Currently swap is restricted before drivers have had a chance to do the=
ir
> > prepare() PM callbacks. Restricting swap this early means that if a dri=
ver
> > needs to evict some content from memory into sawp in it's prepare callb=
ack
> > it won't be able to.
> >
> > On AMD dGPUs this can lead to failed suspends under memory pressure
> > situations as all VRAM must be evicted to system memory or swap.
> >
> > Move the swap restriction to right after all devices have had a chance =
to
> > do the prepare() callback.  If there is any problem with the sequence,
> > restore swap in the appropriate dpm resume callbacks or error handling
> > paths.
> >
> > Closes: https://github.com/ROCm/ROCK-Kernel-Driver/issues/174
> > Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/2362
> > Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>
> Tested this against 6.15.3 and 6.16-rc3.
> Adding my tag.
>
> Tested-by: Lucian Langa <lucilanga@7pot.org>

Applied as 6.16-rc material, thanks!

