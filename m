Return-Path: <linux-pm+bounces-13681-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A173196D6E4
	for <lists+linux-pm@lfdr.de>; Thu,  5 Sep 2024 13:17:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AFC41F21A7B
	for <lists+linux-pm@lfdr.de>; Thu,  5 Sep 2024 11:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2FC719882C;
	Thu,  5 Sep 2024 11:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JaTYY8rq"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95A62A1BF;
	Thu,  5 Sep 2024 11:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725535052; cv=none; b=k101IHAH0S+wkszG3GQ2QnzjyvHVmlbZUOSNhqDzDQhFICOQYBbbUCx9XJ4dM/ZjFoCwcLhrsCT0J/6y1+0xFKDH8IFycio7lbYu3DH2OpwH6oiQms88kjYzhcaqJyb5vpeJQoOUrAQwymgdEe97ic/Ztm+AMvdK/SZhxg68Ljk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725535052; c=relaxed/simple;
	bh=2bTgGPogJndOUdisITWVgnlUdPNq8gbXQX1LJa3+JEA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I8QvFpZvNZ6S7/XSl+hFX22toztaLXIl8ITLhKMC+ex3XBuIvAaNszVpBcbr6Tlt359HPFkYrpMIY5Xkxp4dhbuiqZN3YhXSQRZfZxpAxbDrUBZ2oiaCnrJ7lObZacFET5lFyLhKDIMHUd+RNYBcm9cEaUS/sS2M0qqNqSgzlrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JaTYY8rq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2451BC4CEC7;
	Thu,  5 Sep 2024 11:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725535051;
	bh=2bTgGPogJndOUdisITWVgnlUdPNq8gbXQX1LJa3+JEA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=JaTYY8rqHlT3lAJ+MgK9Yxe0FJO77hNAvd1MitvtC9+6s38tCSM498qJMs9nBdOKI
	 VqWc+2OmTpfdOK8rslzBUO6uUZoYvuVsgb4dGTu1S1AE7tRetzJwlf9a60goF/DaLX
	 hen39ktYC4kCWkk8bdR0SK2M73h2S5kO3rzk54iS3mEzak3RDdvnAdJa9U8x50XTux
	 wZcFBAnrxDPSthoGFrOosFVCStENY8KiZlPMM5ZCfIbOoUPFbbld7LWWYLT+K1ws1v
	 zdpRss5iGTiLKLRijL+gCpzn9qCEDD8LSIMakPQ6XrV4lbJ0DIK/X4du0C51Nfblc2
	 ICI48Y7uhG7Bw==
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5e017808428so390042eaf.1;
        Thu, 05 Sep 2024 04:17:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWGJW7WCOlIEnjDPQDS5Scx7n+g7WLlhuMYbIgXvIUaU4/v5fNNJr7kr2/Sek3NXN5jm3PEhevJ+nE=@vger.kernel.org, AJvYcCXUVY9r+g9l8PbXFXOmeje966zGGoo826CKxTxShEnhad+dC6u8nFmgqB7khVKMt5LwLs6F4fzZSdP0AJU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3MBzmju8Hg1HZL53owkbxXg6qTYzEQWK+1v++6IY2hs1qf0EH
	TjXhaQzVEJdLUn+keywwyXPNidISDncHMSz8DOb+iy7uWNzCrvZSVzUII1hTbl27ME+ue8L/N76
	aJFj6IE3WrRnjIIcep1pOCxmNFME=
X-Google-Smtp-Source: AGHT+IErBvLOnblhIfrrDVXA2ivRReqGmOQLiphztIFTh8YuhSOqUbf8aYXxp46O9CO9kbKYLXOldEaLiFKEnkNjnTw=
X-Received: by 2002:a05:6870:71c4:b0:278:65c:3c14 with SMTP id
 586e51a60fabf-27810b27295mr12299961fac.5.1725535050490; Thu, 05 Sep 2024
 04:17:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a226a5ab-b30f-47a8-825b-2ee073cbe28a@linuxfoundation.org>
In-Reply-To: <a226a5ab-b30f-47a8-825b-2ee073cbe28a@linuxfoundation.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 5 Sep 2024 13:17:19 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0g8NThqGj8qhi4w9OpfLCMFgNjT5tefxpRC+Bg8O4YHhQ@mail.gmail.com>
Message-ID: <CAJZ5v0g8NThqGj8qhi4w9OpfLCMFgNjT5tefxpRC+Bg8O4YHhQ@mail.gmail.com>
Subject: Re: [GIT PULL] cpupower update for Linux 6.12-rc1
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, shuah <shuah@kernel.org>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Thomas Renninger <trenn@suse.com>, 
	Thomas Renninger <trenn@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Shuah,

On Thu, Sep 5, 2024 at 12:02=E2=80=AFAM Shuah Khan <skhan@linuxfoundation.o=
rg> wrote:
>
> Hi Rafael,
>
> Please pull the following cpupower update for Linux 6.12-rc1.
>
> This cpupower update for Linux 6.12-rc1 consists of an enhancement
> to cpuidle tool to display the residency value of cpuidle states.
> This addition provides a clearer and more detailed view of idle
> state information when using cpuidle-info.
>
> diff is attached.

Pulled and added to the linux-next branch in linux-pm.git, thanks!


> ----------------------------------------------------------------
> The following changes since commit 8400291e289ee6b2bf9779ff1c83a291501f01=
7b:
>
>    Linux 6.11-rc1 (2024-07-28 14:19:55 -0700)
>
> are available in the Git repository at:
>
>    git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux tags/linux-c=
pupower-6.12-rc1
>
> for you to fetch changes up to 76fb981ad6774b82f06703c896b492c8659b543b:
>
>    tools/cpupower: display residency value in idle-info (2024-08-09 10:32=
:33 -0600)
>
> ----------------------------------------------------------------
> linux-cpupower-6.12-rc1
>
> This cpupower update for Linux 6.12-rc1 consists of an enhancement
> to cpuidle tool to display the residency value of cpuidle states.
> This addition provides a clearer and more detailed view of idle
> state information when using cpuidle-info.
>
> ----------------------------------------------------------------
> Aboorva Devarajan (1):
>        tools/cpupower: display residency value in idle-info
>
>   tools/power/cpupower/lib/cpuidle.c        | 8 ++++++++
>   tools/power/cpupower/lib/cpuidle.h        | 2 ++
>   tools/power/cpupower/utils/cpuidle-info.c | 4 ++++
>   3 files changed, 14 insertions(+)
> ----------------------------------------------------------------

