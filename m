Return-Path: <linux-pm+bounces-16207-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4CCE9A9F7E
	for <lists+linux-pm@lfdr.de>; Tue, 22 Oct 2024 12:02:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F35D1F25142
	for <lists+linux-pm@lfdr.de>; Tue, 22 Oct 2024 10:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DC6719AA43;
	Tue, 22 Oct 2024 10:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NfKUELO3"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D76196C7B
	for <linux-pm@vger.kernel.org>; Tue, 22 Oct 2024 10:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729591321; cv=none; b=LKWWMLUYXXRrA0Mc3+TyK6ub16p+EhQ26Z1jGI7Td97l1jLBWuxA4wtIiNjRnTGeBqYMFQItZnhy/U3iPqbMtza/PUEt43a5C/XY/ZixItcxFK/lAuukdgQfJvWtM6ROyE0pgn3Nn9M14JdRJlVzS3XVbiszkFSyRt5/ZAcVfrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729591321; c=relaxed/simple;
	bh=I96aAoNGVWGbNGBTdzGxUwVMbxD20GupE6E78fUu938=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DdniQyyzsX9RPXw0uOPkbrpmAKdTrVprE0P/JlssTX1WbT0anmLraOcIPxYtbeWF9ADs5rP4AMEA91geORCBAlDwi+ShM8Q9cH4YJe9lO6ITtR6iXdyJqAtuWJ+79W88fw0Rljkadks0vQtvZWCfhLMPHLXYcOEM1XBn/kyqF48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NfKUELO3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD659C4AF0F
	for <linux-pm@vger.kernel.org>; Tue, 22 Oct 2024 10:02:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729591320;
	bh=I96aAoNGVWGbNGBTdzGxUwVMbxD20GupE6E78fUu938=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=NfKUELO3wLRpWF5MlJqashYGTtUXD5kEvphmQDkcaeitApzmHAj97y+quorAS0bVd
	 KWLINedcGZFryCglmWSKC2oA5W4VqR6UOSk0mNIYjWELeuYqyufDmkSsqDdrbSI8Kp
	 pdYCAGIl8g9oI1wMQ4kfQMI9NAsho9BRx3T9CRX9jZr+1B2NI5wm/YYmnZTK7MeYfu
	 qVsOme/6MvxlC/WJlpDDQg1M2eIP7hm+aRESGrHfsB2a6o5UOiRmXSO/TlPV9DzXqf
	 WxWKqGnHa+4J25TyMWjdD5XdD2/eLqp0HXy4gThdpTf6JAlJyzoGCGbxz6SghBKXxM
	 Se7RngSQIxkNg==
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-27ce4f37afeso2762666fac.0
        for <linux-pm@vger.kernel.org>; Tue, 22 Oct 2024 03:02:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVhCx42QxSOveebqoV0mTb8v+HRjTI8wsUyFT9LJrZb1rjCGuM0xwAEPUeebioBRkrHqRUYn3IZBQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzOBr0V95muzHVYN40MQDvJz1A1hJfc2ETuTXaT90t2BqkR9Bv/
	CnjB78g/5QV5UElnGze2bhrco+FU/vWOsPxcG3igUbZCi+vU4NAfYOIjJnj4kHJfAUbWPqKLi/d
	VVHi38W6N0nFOtHWJ13YqpK/rdhU=
X-Google-Smtp-Source: AGHT+IFoQfUc7Anj6TBDNa/DvGm5eoWTmPCksJ1Aq3Etev63pAYK/VGHTO20SwvhZ48NXKm0+cMBVG3eXRjvYa/lSpU=
X-Received: by 2002:a05:6871:29c:b0:286:f2cc:7a61 with SMTP id
 586e51a60fabf-2892c5436e7mr11351311fac.36.1729591320219; Tue, 22 Oct 2024
 03:02:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014094309.1430126-1-daniel.lezcano@linaro.org>
 <20241014094309.1430126-2-daniel.lezcano@linaro.org> <46d25358-bf23-44ec-8350-711252560b89@arm.com>
 <c5df4aae-70af-451e-a1be-57089f5fd848@linaro.org> <962dfad6-e2f0-44e3-b567-e0b72e2a2a11@arm.com>
In-Reply-To: <962dfad6-e2f0-44e3-b567-e0b72e2a2a11@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 22 Oct 2024 12:01:47 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iaYys8H_AcM_5SHHy0LxzZkok4sx=jji1wOGjZ+30rzg@mail.gmail.com>
Message-ID: <CAJZ5v0iaYys8H_AcM_5SHHy0LxzZkok4sx=jji1wOGjZ+30rzg@mail.gmail.com>
Subject: Re: [PATCH v5 1/4] thermal/netlink: Add the commands and the events
 for the thresholds
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org, 
	quic_manafm@quicinc.com, rafael@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Lukasz,

On Tue, Oct 22, 2024 at 11:39=E2=80=AFAM Lukasz Luba <lukasz.luba@arm.com> =
wrote:
>
> Hi Daniel,
>
> On 10/22/24 08:09, Daniel Lezcano wrote:
> > On 22/10/2024 00:02, Lukasz Luba wrote:
> >>
> >>
> >> On 10/14/24 10:43, Daniel Lezcano wrote:
> >>> The thresholds exist but there is no notification neither action code
> >>> related to them yet.
> >>>
> >>> These changes implement the netlink for the notifications when the
> >>> thresholds are crossed, added, deleted or flushed as well as the
> >>> commands which allows to get the list of the thresholds, flush them,
> >>> add and delete.
> >>>
> >>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> >>> ---
> >
> > [ ... ]
> >
> >>> +static inline int thermal_notify_threshold_up(const struct
> >>> thermal_zone_device *tz)
> >>> +{
> >>> +    return 0;
> >>> +}
> >>
> >> These 'return 0' look a bit odd. We usually use 'return -EINVAL' in
> >> not defined. Although, since we don't check the output of those
> >> functions  - we are OK. We just have to remember about these zeros,
> >> one day when we would like to add the check of the return.
> >
> > The return error really depends on the context of the call site. There
> > are other subsystems returning 0 when the service is not enabled (eg.
> > cpufreq.h, devfreq.h, device_cgroup.h, etc ...)
> >
> >
>
> Fair enough. As I said, we would just keep them in mind if we one
> day decide to add the checks of the returns.
>
> I'm waiting for your next version with the new locking scheme that
> Rafael asked and I will add my review tags.

My plan was to take this patch and replace the open-coded locking with
guards when applying it (that would be a mechanical change AFAICS).

I guess it's OK to add a R-by from you in that case?

