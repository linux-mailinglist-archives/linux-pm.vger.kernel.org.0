Return-Path: <linux-pm+bounces-26820-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFBEBAAE3AE
	for <lists+linux-pm@lfdr.de>; Wed,  7 May 2025 16:59:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C86F2981A15
	for <lists+linux-pm@lfdr.de>; Wed,  7 May 2025 14:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B19F1224FD;
	Wed,  7 May 2025 14:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s3H2ve6k"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E103289E1F
	for <linux-pm@vger.kernel.org>; Wed,  7 May 2025 14:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746629951; cv=none; b=ZgR/KYiM4jwbE8el/qXj/1qVQJETEr75H6ZCSvIKEwE0NtL4XfmR2zlUI4BsegfVqkytq7G8AloWyFIrGC5FS0IxiRUHIqCFZNr/TQUVxyf+o5qVZ/WmF2nP7btgEu7BqdyPUSAx+2QSk6Vr2lSC5vG6ljIKWE64VpW+mrrMBV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746629951; c=relaxed/simple;
	bh=pQ4rrrkQyrsJSu1Oydj2YpRuvmf+BczNVPtiyO2iXYo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BeUZWYyCHgOLIiANuSISMzh3NC/7IqwVSrnU50slINOm6jHkxwvF9wydx/eFWiIDAQhVMG3lzk+KDrLfjH3zgs+5o2e44pL/H8+vtDWNrGEYxk95gmgc33EYel8coFHh0ebbC8H/UrsdWlLTjWn277vYu3LJkVYxkKnJp46gcDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s3H2ve6k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08904C4CEE9
	for <linux-pm@vger.kernel.org>; Wed,  7 May 2025 14:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746629951;
	bh=pQ4rrrkQyrsJSu1Oydj2YpRuvmf+BczNVPtiyO2iXYo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=s3H2ve6k4f+hC3dQll7XS94s25l3LrkcKV20kEM2WMDhI3NI1ut2kRyZy7kpcKIJn
	 +DX04WjFQZ8FfDsBRkbY+6N9cEYALHXc1TyPzJbLeM40SLeti2BBsbWZToPewhG73r
	 ccEdD6KyTXjyt8htRkb7f0UO50dlfIcfp/u/IVCXA4FWgVIzkEaDa/KaIPbj83pTqv
	 ipzEFWd3LDnVXaU6XmiisFCNRMcUnSOGC3HVpx32HOdWO1WzlPZlNxEHV9D5VN2sFA
	 wSQuC903cFZoNQcrEWPQXProFSMyYu5f7MAmKvHfTwQD0wYH1U+s/RKMM2dppf3MuW
	 hQLnTinG7XPig==
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-72c14235af3so4397698a34.3
        for <linux-pm@vger.kernel.org>; Wed, 07 May 2025 07:59:11 -0700 (PDT)
X-Gm-Message-State: AOJu0YwxLe6QHcYkq/KNbt8lAnC0XSWr+TL2BlUts98SJOCHXkaJufSs
	N4yRppsrdYt9eLykmGOFmz0uV4Ubs8VJzavQM4Sxm6UdJai3mlM7HwsLiPmBrfmCxftuGn14Fvt
	GfInniQCGvxJx3PilBIjAfZhbZW8=
X-Google-Smtp-Source: AGHT+IG2jGg4Gw+mtrHimLnBHtTZnvgaDxMj6vzJiI/LGSl3ouIsD5werw44EnBCTNLYLshLXj8g6uQd4mXH4v505pU=
X-Received: by 2002:a05:6871:29a:b0:2d4:ce45:6985 with SMTP id
 586e51a60fabf-2db5be28b4dmr2084181fac.11.1746629940117; Wed, 07 May 2025
 07:59:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250502140119.2578909-1-sudeep.holla@arm.com> <20250507-crouching-lovely-wrasse-f85e90@sudeepholla>
In-Reply-To: <20250507-crouching-lovely-wrasse-f85e90@sudeepholla>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 7 May 2025 16:58:48 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jhQwbQqbDOz2ADeZWvBzA71XdLxhRJzCYL28fMM2DBiA@mail.gmail.com>
X-Gm-Features: ATxdqUGCI4AILRNC-HP-Tp3AOF4fDO-fl4F8YA3AQMgVbwTj7A5RwxA6JJAusF4
Message-ID: <CAJZ5v0jhQwbQqbDOz2ADeZWvBzA71XdLxhRJzCYL28fMM2DBiA@mail.gmail.com>
Subject: Re: [PATCH] cpuidle: psci: Avoid initializing faux device if no DT
 idle states are present
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Jon Hunter <jonathanh@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sudeep,

On Wed, May 7, 2025 at 3:56=E2=80=AFPM Sudeep Holla <sudeep.holla@arm.com> =
wrote:
>
> Hi Rafael,
>
> On Fri, May 02, 2025 at 03:01:19PM +0100, Sudeep Holla wrote:
> > Commit af5376a77e87 ("cpuidle: psci: Transition to the faux device inte=
rface")
> > transitioned the PSCI cpuidle driver from using a platform device to th=
e
> > faux device framework. However, unlike platform devices, the faux devic=
e
> > infrastructure logs an error when the probe function fails, even if the
> > failure is intentional or expected.
> >
> > To prevent unnecessary error logs, we can skip creating the faux device
> > entirely if there are no PSCI idle states defined in the device tree.
> > Introduce a check for DT idle states during initialization and avoid
> > setting up the device if none are found.
> >
> > This ensures cleaner logs and avoids misleading probe failure messages
> > when PSCI idle support is intentionally not described in DT.
> >
>
> As you pointed out in another similar fix that exist only in the linux-ne=
xt,
> I have also missed to point out that fact here. This is only present in
> the next. Let me know if you want me to drop the commit hash reference
> and repost it with -next prefix which I generally do and somehow clearly
> missed here. Sorry for that.

No worries.

The cpuidle branch hasn't changed, so this is applicable with no changes.

Applied now, thanks!

