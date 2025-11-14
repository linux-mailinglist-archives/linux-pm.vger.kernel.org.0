Return-Path: <linux-pm+bounces-38052-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2F13C5E37B
	for <lists+linux-pm@lfdr.de>; Fri, 14 Nov 2025 17:26:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C9A0423A43
	for <lists+linux-pm@lfdr.de>; Fri, 14 Nov 2025 16:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C861D259CB2;
	Fri, 14 Nov 2025 16:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DUrrQ0J9"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1882C25A2DD
	for <linux-pm@vger.kernel.org>; Fri, 14 Nov 2025 16:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763137032; cv=none; b=eMqd6pr8sHxgU/pzTFOz4eTSwZv3fiXvm9gITWR1D+583wErghiZ2d0X6wYQK+dVKt/3FgKGW63RM2XEQWVYt3jQvHFJ3lDbAlj9+95DJB600pdTPHNPZlx+ivbjqkH+sFyWshOEHtWm7sWHiSav43vNl0KWdNoz02JH4c+OX5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763137032; c=relaxed/simple;
	bh=jvQ2Hpm8jqSuR1+Xm7nXJfomvqUBl5P8BIURnZpswlw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IaT95Y0c4uX7+V4EFzUEiNUKOu0PNpeNTrioPrcBIO63DEkuXJ6ehOldoXbFM+NSwK6+pxPBrGWwDeBhl6hPaoOp/K00LlELrc8/wpu1MwGln/VgCAwg+MgJihaTnGRmp/dXTM6e5dS60imIo/zvl1Bk4DRTiho59f3vr9pQyXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DUrrQ0J9; arc=none smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-63f95dc176fso1977474d50.1
        for <linux-pm@vger.kernel.org>; Fri, 14 Nov 2025 08:17:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763137030; x=1763741830; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+68C8P05ehiszBwfU5pbI3MewYs+8o/ivU0GxbGrBsA=;
        b=DUrrQ0J9GXSigdEiSF2B/Wswv67D4K2FadhyxMiDCS/EBffnrZ6pF795Bvh5EWCzGF
         4JB/sWaJl4m7C/sMQSopCSTCg0UbYCALBiupn3QVuYHoY/RsuhG8Y6nWonfUF0RqE89I
         wGKsIAr7DuXDtsGn7aFZJNEJ4EJR5A0CBoFKyf1FTVUZSJdPb3ArSMTumrbQ9jW7jqhB
         r+fm+H14MG09nrQnRNaNti13SD+xbEqi3n2++VuTEEWa4mAg5TW843BMBJ4zw2pWznGj
         Fn4frOYdMg2mzarLB59JHQZk/lH0bJVKJrZXkGHFkTQPv0Y5iplp+IcHcs4vcXjCXVkL
         +3Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763137030; x=1763741830;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+68C8P05ehiszBwfU5pbI3MewYs+8o/ivU0GxbGrBsA=;
        b=mTLcLUP85cOrTCnrLGwMswfT22FzIAw1nysvtn6Do5Jm7weNsTkmEEXJNljQLRp8lD
         Lha2uyiCN6wNCnhp4/YVz0HQ5GxeBNojYYzD7FJbGcLGE/OnsiaGhcfe86gpQMfu7pIJ
         ABxM9YEo09ajnjnxvHHOalSrdlpAAiDqL0+9YoFmirjf3a7AIpMkYefrQLDXBv0rMVGM
         9aR2JNNG52U6yTvJ/fFBR6GET6AfE7SvqWXM1q0J1jIJOA5sFKfAmonKgvttfZFowZbJ
         SzbtfqFnw9DrQ5OWwKg8N599HYEhJlLQ5YCtgPeN3LhKb05qkdyyUv/IS/z5yVLlLWE/
         dQpQ==
X-Forwarded-Encrypted: i=1; AJvYcCV6bGqkpMtcOP4z9lDp/SqcDO1ia9CXid88RkPByGF2rW4/85WA6HdXzRNOYbYZpGavkuBOnpx2Rg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6a7baiEGT3Ev+DAj8bTa8FOhKKXvM2Pve0bCdDHi2buahqS78
	krt6/v1+IfZ2wcPKEyNCM/40CIenQi1Q0dkwufmoAQ2sYY3qHegueDDJvYfMOg9XgbNwu+016uQ
	LupfxegnAfHDLKZPysKEY4lgSsesQNTx7Q4Nz9GRPCw==
X-Gm-Gg: ASbGncu61NQrD8cweISUUrUq8F5IQNNouV+3HV4L+OlbGdYtV6Cl7bRfr3jh4W+ChM3
	5ZvRe3+6YV+M01PKlh4gxudCd9QNmEcn73fTQzTM7fklcdq5ecm+pTujbEPa/+OoLmt3gANRjst
	bVICWZi5Em9vcbs8YCK9uzZ6rEB/fWZdz3R+TgZAZg5U7ft18WNs0pdBD/DsiR7ag1XgIF0AQV0
	wLbCiuj6lR8xxEkPmxxKwVDBTDFlzJ54mKyYD3a2E8Fid6SIwmlRxfPWXo9gI6bMXvQ5RAB
X-Google-Smtp-Source: AGHT+IF2u3OHz+gDlMtDxnSWseapvAQvqP7XLj7Iw/7dpTrGPniYJ5fgz5OjyeTX2Hv74MloNFC74k8FEtz04zmSx1c=
X-Received: by 2002:a53:d057:0:10b0:63e:2d17:6a67 with SMTP id
 956f58d0204a3-641e75bbe5cmr2760050d50.28.1763137030018; Fri, 14 Nov 2025
 08:17:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251105095415.17269-1-ulf.hansson@linaro.org>
In-Reply-To: <20251105095415.17269-1-ulf.hansson@linaro.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 14 Nov 2025 17:16:33 +0100
X-Gm-Features: AWmQ_bnGF5L9SDMykII4EF15vkBInQsc-nLOhsh7Tw7Z2aJya79QRcFM--SxzKQ
Message-ID: <CAPDyKFqtJDoFwCB8_GG1XUVmmbQw=Wc+CEfuC0V3qqB6Xz3YtA@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] pmdomain: Improve idle state selection for CPUs
To: "Rafael J . Wysocki" <rafael@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <maz@kernel.org>, 
	Maulik Shah <quic_mkshah@quicinc.com>, Sudeep Holla <sudeep.holla@arm.com>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Ben Horgan <ben.horgan@arm.com>, linux-pm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 5 Nov 2025 at 10:54, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> Platforms using the genpd governor for CPUs are relying on it to find the most
> optimal idle state for a group of CPUs. Although, observations tells us that
> there are some significant improvement that can be made around this.
>
> These improvement are based upon allowing us to take pending IPIs into account
> for the group of CPUs that the genpd governor is in control of. If there is
> pending IPI for any of these CPUs, we should not request an idle state that
> affects the group, but rather pick a shallower state that affects only the CPU.
>
> More details are available in the commit messages for each patch.
>
> Kind regards
> Ulf Hansson
>
> Ulf Hansson (2):
>   smp: Introduce a helper function to check for pending IPIs
>   pmdomain: Extend the genpd governor for CPUs to account for IPIs
>
>  drivers/pmdomain/governor.c | 20 +++++++++++++-------
>  include/linux/smp.h         |  5 +++++
>  kernel/smp.c                | 22 ++++++++++++++++++++++
>  3 files changed, 40 insertions(+), 7 deletions(-)
>
> --
> 2.43.0
>

FYI, I have queued this for v6.19 via my pmdomain tree. Please let me
know if you have any further comments or objections to this!

Thomas, thanks for your guidance around this topic!

Kind regards
Uffe

