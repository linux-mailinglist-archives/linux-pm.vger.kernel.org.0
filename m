Return-Path: <linux-pm+bounces-29687-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7007AEBE72
	for <lists+linux-pm@lfdr.de>; Fri, 27 Jun 2025 19:31:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 413873B9745
	for <lists+linux-pm@lfdr.de>; Fri, 27 Jun 2025 17:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88DD22C159C;
	Fri, 27 Jun 2025 17:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ILADB2LJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F25E1C84C6;
	Fri, 27 Jun 2025 17:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751045493; cv=none; b=UkTn2yYfLvOKMpmMhY52JeimpSAL2ojjl3apz6p+pv1NFbdhkm6/mIXXwtGQksd6dPkBCaH5nDRsiIl8WOOEZivIl+tLg8s5gRfeG3jGo7aDV9Zf8AFq6PCJDa6f7NnSbyyT193FiKZHcI8hficEGPdhccxhqxHruci4JxyYwSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751045493; c=relaxed/simple;
	bh=2y4LiuOlJjR+L5bvSaQ8uJfBRplCVc+eNj3QdtNcQfU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=odlGN4MW7zOuMuOOGLh7qyIjwE6zum+6ocm166B+WTlxTyWAVYg5ogRlJpvDywwHm3iQVEfiYFFyBKWNKeqg4Ui3dYv4EM/epp7qtCHgELh9M5rHVqyUUgujMvkjtNxXpNCgN1+HAFMeo87ALJIB1fXwEGTkOe81vBk5WKTaHew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ILADB2LJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF5EBC4CEF3;
	Fri, 27 Jun 2025 17:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751045492;
	bh=2y4LiuOlJjR+L5bvSaQ8uJfBRplCVc+eNj3QdtNcQfU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ILADB2LJ/2bckd4i7hGoVPC88dNjlVFl4Aiih7dAYsQ13NtbWlBoWdSK02zKXWnX4
	 yB0AC6W64qxQ4dTs+/QFr0iCGtzCivrc9+x+jrn2azlNNrwqEpVYxm9QTqUZ2ljkSB
	 OWGJgqYfcHeRsZDnXMCQHfFhnrfApVqfixSKhXCU34uW4DAG2XUSjpASIxq1kt8Pn8
	 2xB2sXuvx1DQ4B05BX4ovMdg3AWbIQhm5v7ikLO74H0niCLWI6vP7FNxCPgWRLoPwZ
	 +mV5YFQVs4DQGUf8kIs56XWyn0yHJPy3EPC2PT0UeEF2pgancT4W+pG+UzWuB0djqu
	 zIoP9nup7ZGhA==
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-739dcdb012fso32716a34.2;
        Fri, 27 Jun 2025 10:31:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW+4WqWyV/5W8R5FDyyHXF7j1MHzQblzBsFClX4FO/ad4ftFgPDy9Ie+NW4Snw3L8QeWIv903j4Cim2oVg=@vger.kernel.org, AJvYcCWII2Y9QfLCUVlhM6He1quRogpla1HxEQyXiLFJP43djt513ly5uajWehY/Q/ez/+mbVH+i4Co08aM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaE0LRpaQLo4JUeWu1MNlEHEcEzJDiINVYNjRw1QVc7w+Shz2c
	HLlBZDVwzxjjqJt3fqPtUyw/m8Tru5UMZccKm7GcCb21a601smaImxsxlxJ0BPvF10hPg96BkzD
	4sh8NDcti9rPxTgWFW9RSvogWfqoW+MQ=
X-Google-Smtp-Source: AGHT+IHB+/g6e9V47pnpxmAmye3lJ/VxkZKU9rFdui8UdjiRcXh5PipvblPCywHW5A97MRQySwHSI6k66JTeOktv4h8=
X-Received: by 2002:a05:6830:f98:b0:72b:8c4b:8ef2 with SMTP id
 46e09a7af769-73afc6bf7f8mr3074163a34.24.1751045492030; Fri, 27 Jun 2025
 10:31:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5011988.GXAFRqVoOG@rjwysocki.net> <CAPDyKFpBTz0M8DmWHLLm7x4c8G5PpQNv0Zj7mrZ9BewTBi1skg@mail.gmail.com>
 <5a6d0684-3340-43ed-b520-933654515943@amd.com> <CAJZ5v0iJ65xxuHtJrWp1sC76FUzPHNpXB+xtHB=e4qTRSgAC4w@mail.gmail.com>
 <0412561d-6ed3-4823-b510-8600fd4fd1fa@amd.com>
In-Reply-To: <0412561d-6ed3-4823-b510-8600fd4fd1fa@amd.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 27 Jun 2025 19:31:20 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iRomtiFhYTndO016=zH+vDMkxJgq+EvqYfTFs-+cC8tA@mail.gmail.com>
X-Gm-Features: Ac12FXzzh0eSx2KHI7hyIDyZLwvuHa7xQTAMjvI3UWpAcrW0CcTmHGRyDsKBLD8
Message-ID: <CAJZ5v0iRomtiFhYTndO016=zH+vDMkxJgq+EvqYfTFs-+cC8tA@mail.gmail.com>
Subject: Re: [RFT][PATCH v4 0/2] PM: sleep: Handle async suppliers like
 parents and async consumers like children
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, 
	"Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	Chris Bainbridge <chris.bainbridge@gmail.com>, Saravana Kannan <saravanak@google.com>, 
	Sudeep Holla <sudeep.holla@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 27, 2025 at 4:01=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> On 6/27/2025 5:40 AM, Rafael J. Wysocki wrote:
> > On Fri, Jun 27, 2025 at 12:28=E2=80=AFAM Mario Limonciello
> > <mario.limonciello@amd.com> wrote:
> >>
> >> On 6/26/2025 4:46 AM, Ulf Hansson wrote:
> >>> On Mon, 23 Jun 2025 at 14:55, Rafael J. Wysocki <rjw@rjwysocki.net> w=
rote:
> >>>>
> >>>> Hi Everyone,
> >>>>
> >>>> These two patches complement the recently made PM core changes relat=
ed to
> >>>> the async suspend and resume of devices.  They should apply on top o=
f
> >>>> 6.16-rc3.
> >>>>
> >>>> They were sent along with the other changes mentioned above:
> >>>>
> >>>> https://lore.kernel.org/linux-pm/2229735.Mh6RI2rZIc@rjwysocki.net/
> >>>> https://lore.kernel.org/linux-pm/2651185.Lt9SDvczpP@rjwysocki.net/
> >>>>
> >>>> (and this is v4 because they have been rebased in the meantime), but=
 they don't
> >>>> make any difference on my test-bed x86 systems, so I'd appreciate a =
confirmation
> >>>> that they are actually needed on ARM (or another architecture using =
DT).
> >>>>
> >>>> Thanks!
> >>>
> >>> Hi Rafael,
> >>>
> >>> I haven't yet got the time to test these, but the code looks good to
> >>> me, so feel free to add for the series:
> >>>
> >>> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> >>>
> >>> Kind regards
> >>> Uffe
> >>
> >> I passed this series to some internal guys to test on a wide variety o=
f
> >> AMD x86 hardware.  The initial testing looks good.
> >> Will keep you apprised if anything pops up.
> >
> > Thanks!
> >
> > It would also help if you could check whether or not there is any
> > measurable performance (that is, system suspend and resume time)
> > difference between "before" and "after".
>
> Sure thing.
>
> Just to make sure we have an aligned measurement methodology:
>
> I asked them to do this both with and without the patches.
>
> * set /sys/power/pm_debug_messages before running and then capture all
> the timing prints.
> * add up all suspend events and get a total
> * add up all resume events and get a total
> * repeat 5 times
> * calculate averages for the 5 runs

Sounds good!

