Return-Path: <linux-pm+bounces-13682-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F35E796D6ED
	for <lists+linux-pm@lfdr.de>; Thu,  5 Sep 2024 13:18:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8082AB23B13
	for <lists+linux-pm@lfdr.de>; Thu,  5 Sep 2024 11:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39BD6199EA8;
	Thu,  5 Sep 2024 11:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uzAUBhO4"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145C6199247
	for <linux-pm@vger.kernel.org>; Thu,  5 Sep 2024 11:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725535078; cv=none; b=S72yZ5nBNMX79ND/CmUcoINRvQphf0YSqqGQR5SpX+BSii2lrXD/ezil5vbnhUOxPXQadBoe9PkIo720uHge3EazBdN4IRHGbQA8YIeOmhOwDvmnHjuu5RA4LiafS9CUl2kwoR/2VMHhS13Y0Psqrcy483nJksgizKT/OD7dmP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725535078; c=relaxed/simple;
	bh=PP5ySlaq5PWbpixksI7Q0F3PiMl0BnaZDdT5NqFHVc8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FhBEWY+2/Ir/ZO0WYimxzw2DqR0HqMsgw+O9CrfIZ/NXwm+tuJC9Sj/wQhaU04GOsZ8Tzrz2Xs17+8wqunnQPD26eUEJBlGxbfaW2L+U2jUM+Njyx/K6adAOvTkZEW4Bq8WbhKkfysCPBsJaBder1ZlRGzyBkE5w7UlbDEXqaJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uzAUBhO4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFF29C4CEC3
	for <linux-pm@vger.kernel.org>; Thu,  5 Sep 2024 11:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725535077;
	bh=PP5ySlaq5PWbpixksI7Q0F3PiMl0BnaZDdT5NqFHVc8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=uzAUBhO4bT6s8uFybRoTT4OlCDvw+H2Bi3Pfw5UHcZ1pLFsf4YDrZm7A64jHEmAJg
	 iaDqNmKrQodo6ILSN7NW2wznNKoutlk+yF0rJE6cljx9mtEjpHyEFNLOin/KY55jmV
	 crbBqrwBi0Tg8AZWoh42um9qf2oqDvMZ8w+QN72JG/wj0pJKfVjmE03D41bEazPriC
	 F+ea+SE+YU2aS/CsuiuU+Sr1IF4erGK7alUBGt3KTDnk649OpI44ABxx3UUzh+AECO
	 geXmpZabfjxUaSDo6MAE5OqdgGMgkxZmfGzQSgOGk79EhXLB/wGL+UbTe+N6a5DgeO
	 yiZiA4dfwEXpQ==
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5df96759e37so396317eaf.2
        for <linux-pm@vger.kernel.org>; Thu, 05 Sep 2024 04:17:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVN8V20fDZyppH+XztijAqub+elaJQ23uKn8csgWkQpyokO4jIon2Jdd4bgamIrY7sgag8fEmE7hw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwuibpK8/6NQ9fZYWLtrD6+76Mcx8pHW67K6zeb6LnsxmH+wKFJ
	4kJ8f1A1f5+DTqM92kqH3s7sP2wd3JRPRx2JcpL8x4ETyt5TW/r+EYczsprKzBVjXhgVf/eAVOd
	oT7zEnh8gdiFxk7jUfRdgZTIghyM=
X-Google-Smtp-Source: AGHT+IGb0Mj6A/XEZ7rn/k1F8lnwFPHTuNeLipqaVkVJtnP9FLUNYGPAw62dLd2Uhf8hl+8w1cuIJsTZHvSIWLosvOE=
X-Received: by 2002:a4a:ee03:0:b0:5d5:b6d2:4749 with SMTP id
 006d021491bc7-5dfad01f6e6mr23129089eaf.8.1725535077290; Thu, 05 Sep 2024
 04:17:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a5980dad-c409-40ea-8442-3584c0441018@amd.com>
In-Reply-To: <a5980dad-c409-40ea-8442-3584c0441018@amd.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 5 Sep 2024 13:17:46 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0g9yrowBd4FDLTit1UJM=f0p5SQ9ean2L4RfvuGM3X3gg@mail.gmail.com>
Message-ID: <CAJZ5v0g9yrowBd4FDLTit1UJM=f0p5SQ9ean2L4RfvuGM3X3gg@mail.gmail.com>
Subject: Re: amd-pstate changes for 6.11-rc
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 4, 2024 at 10:06=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> The following changes since commit 9983a9cd4d429dc9ca01770083c4c1f366214b=
65:
>
>    cpufreq/amd-pstate-ut: Don't check for highest perf matching on
> prefcore (2024-08-23 11:07:58 -0500)
>
> are available in the Git repository at:
>
>
> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git
> tags/amd-pstate-v6.11-2024-09-04
>
> for you to fetch changes up to 9c68a3b03e8109f3917fd35f39043499897d4a79:
>
>    cpufreq/amd-pstate: Remove warning for X86_FEATURE_CPPC on certain
> Zen models (2024-08-28 10:15:00 -0500)
>
> ----------------------------------------------------------------
> second round of amd-pstate fixes for 6.11:
>
> * Fix an incorrect warning emitted on processors that don't
>    support X86_FEATURE_CPPC.
>
> ----------------------------------------------------------------
> Gautham R. Shenoy (1):
>        cpufreq/amd-pstate: Remove warning for X86_FEATURE_CPPC on
> certain Zen models
>
>   drivers/cpufreq/amd-pstate.c | 34 ++++++++++++++++++++++++----------
>   1 file changed, 24 insertions(+), 10 deletions(-)

Pulled and added to the linux-next branch in linux-pm.git, thanks!

