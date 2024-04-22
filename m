Return-Path: <linux-pm+bounces-6812-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9DE08AD074
	for <lists+linux-pm@lfdr.de>; Mon, 22 Apr 2024 17:18:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EE471F2176F
	for <lists+linux-pm@lfdr.de>; Mon, 22 Apr 2024 15:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A15DF152DFE;
	Mon, 22 Apr 2024 15:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eBD51g3d"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA85152DF7
	for <linux-pm@vger.kernel.org>; Mon, 22 Apr 2024 15:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713799100; cv=none; b=cB27N+3dggYGpimmo/umytRRaO9XhwQrlTa8i1QxJF9WLeFBk1uCo2panB+exjrqCF5bwZB91ZDjX2IKNMytkoRSEaO65wG9sF84wuhAKPS+SIXkXnufYlfMQpiIFevGSc9v3RtmbMYPMp6sInHPbtTw7V3Q5a3wsH9VKsFr4d8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713799100; c=relaxed/simple;
	bh=5YjGqfzgv40xmebXZOHleeAdlXHBU5L4cI2cN54u96Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UpMUACbZinZe5WORWiMWKnStDlu6pm7qzlLegJlmT623Xffm14bltqwrMxVxl1gyAVWVIe2JQawe5JgU0s5SLRTM1WdGtq98tuJqrT+oHgBr74q9u/Qd6XpIHBnnPNh891tIheGgULc3wIkWzAezt//rF4HT0+KzL0PO0c/gNfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eBD51g3d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FAEEC32783
	for <linux-pm@vger.kernel.org>; Mon, 22 Apr 2024 15:18:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713799100;
	bh=5YjGqfzgv40xmebXZOHleeAdlXHBU5L4cI2cN54u96Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=eBD51g3dkIrPOR2keA/F/6Npplw7K7yWo3/T8NEOaHbpA1c3gYjwF8Ig6QoADHalj
	 77KB8r8z5X5YWTDT2NOZtvNMDAW60Bk+TGISVpMgJlAOWaK5OO/byzCsXIndPzreKY
	 Op558M7ZEIhSrsKUOgIJ27cI6e/inBrVhWEhUujsadYY+GLFG8djSpEKnQFgpyBV+N
	 B7pc9xrv0kgyoZbL4bL9qOsbvpd+O02SWjnm76jCHzCfm01Xhp7mm9NiX62sEA7ycn
	 wTv6bBRp6EfPF4ya2a2pKl4Bk52p+jah7Wuj+0N9ETE+EMzTheaSXOc+ubzukohkr5
	 hlf+Ly8K4009w==
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5af12f48b72so20897eaf.3
        for <linux-pm@vger.kernel.org>; Mon, 22 Apr 2024 08:18:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX9AF4BJNLcOmdeqvXAJBVlZDPPHzu92hXMBgq8yFOh8u/ugs/2I6tBvLng9j2wDstuZQNeOoZdkrPe4WEwpCM9NhnSp6mt5eQ=
X-Gm-Message-State: AOJu0YynSHuvbIqACMKal+0X8w9WW3Ei8FVQ21N2CUrZmmp1zJxxwisi
	bn/U9iuza6FBtRE46ABKtWl86SSVJpbLYlQmy/nug3u4KCUpwWkG1hpUPCoHpbQ2a85OUlnGEL8
	/6e6z2brQ9/e1GT7Sf5tvg4dPlWA=
X-Google-Smtp-Source: AGHT+IEnTr90VNyMqACLC6Ypq4evbZDgZLsPELgOFwUr894Cdn6ws13j/FNnacuhH+6NQaM3rcPlUpnjQYPsuiVdqfw=
X-Received: by 2002:a05:6820:ecb:b0:5a4:7790:61b4 with SMTP id
 en11-20020a0568200ecb00b005a4779061b4mr11171225oob.0.1713799099276; Mon, 22
 Apr 2024 08:18:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240422093619.118278-1-xiongxin@kylinos.cn> <37847b26-1c1e-48d3-a74e-bd2bcc6e1fda@amd.com>
 <CAJZ5v0gmF0Lcy_nHSvTDnu4C3N0mipaeJqHff=00fgWdtwOzMw@mail.gmail.com> <2888cd41-65d9-4832-a913-399a074de7a9@amd.com>
In-Reply-To: <2888cd41-65d9-4832-a913-399a074de7a9@amd.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 22 Apr 2024 17:18:04 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0ggFGSsPKWxowqn89WtLbmXVjUWZvc5KO-ab-UZHagR+Q@mail.gmail.com>
Message-ID: <CAJZ5v0ggFGSsPKWxowqn89WtLbmXVjUWZvc5KO-ab-UZHagR+Q@mail.gmail.com>
Subject: Re: [PATCH] Revert "include/linux/suspend.h: Only show pm_pr_dbg
 messages at suspend/resume"
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, xiongxin <xiongxin@kylinos.cn>, len.brown@intel.com, 
	pavel@ucw.cz, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 22, 2024 at 5:02=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> On 4/22/2024 09:45, Rafael J. Wysocki wrote:
> > On Mon, Apr 22, 2024 at 4:33=E2=80=AFPM Mario Limonciello
> > <mario.limonciello@amd.com> wrote:
> >>
> >> On 4/22/2024 04:36, xiongxin wrote:
> >>> This reverts commit cdb8c100d8a4b4e31c829724e40b4fdf32977cce.
> >>>
> >>> In the suspend process, pm_pr_dbg() is called before setting
> >>> pm_suspend_target_state. As a result, this part of the log cannot be
> >>> output.
> >>>
> >>> pm_pr_dbg() also outputs debug logs for hibernate, but
> >>> pm_suspend_target_state is not set, resulting in hibernate debug logs
> >>> can only be output through dynamic debug, which is very inconvenient.
> >>
> >> As an alternative, how about exporting and renaming the variable
> >> in_suspend in kernel/power/hibernate.c and considering that to tell if
> >> the hibernate process is going on?
> >>
> >> Then it should work just the same as it does at suspend.
> >
> > Well, this is not the only part that stopped working AFAICS.  I'll
> > queue up the revert.
>
> I just tested the revert to see what happens to other drivers but it's
> going to have more collateral damage.
>
> ERROR: modpost: "pm_debug_messages_on"
> [drivers/platform/x86/amd/pmc/amd-pmc.ko] undefined!

What about removing the "pm_suspend_target_state !=3D PM_SUSPEND_ON"
part from pm_debug_messages_should_print()?

This should be as good as the revert from the POV of restoring the
previous functionality.

