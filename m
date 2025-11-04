Return-Path: <linux-pm+bounces-37373-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E313C31FB2
	for <lists+linux-pm@lfdr.de>; Tue, 04 Nov 2025 17:11:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 78D184EBEA5
	for <lists+linux-pm@lfdr.de>; Tue,  4 Nov 2025 16:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC0593019B3;
	Tue,  4 Nov 2025 16:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vKk4Hw2X"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEFF92F6193
	for <linux-pm@vger.kernel.org>; Tue,  4 Nov 2025 16:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762272645; cv=none; b=D5z85AUGxE7B286AkziuyMfWqPLQFyuXXTbtdYt+OzGmLPcd4n+hcSGOf1mncRHV9oJN8wvLxPTQvtbRvZ/W0WWMF6h+93coYP9sDO2fcOIjagNtNVvhk8w0dNCdo/pdz7qHI+wze8FjWkJEdn/UoxwAD95lm9SpMGpPHtY7kj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762272645; c=relaxed/simple;
	bh=tMHZNaCUIS2ZKn8BTbrqTx0fNMqH0rxc2awpL4k48eM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mfWIRZjyz4C3T8epzXB2cbn1TOIV5Hrl4l1psPJsMBeRyiVW1N/fdmwiT26jHOMqheHydSh/0mORTKtzPACQUk9qiGzyaxzLh6JQVUdc5iPN1trOpfmiWzRL+MlceaoEib9b33BHAbr2QdNRc9mBigA+8/Z/zz++EbqhbHJfApE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vKk4Hw2X; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-78650258bacso39598217b3.3
        for <linux-pm@vger.kernel.org>; Tue, 04 Nov 2025 08:10:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762272643; x=1762877443; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RCZQkOK0PXpgSpmrJBWMlAt3eB1gpXLJouklLJTzSWg=;
        b=vKk4Hw2XuSVK1+fU5WaE+DIEc1mBvu2yeA+zTDHYjHvGmj8LRUcrS53kuaSuij9rrI
         heZTdnrlG+V1DixGuz3Mpc3srJ/mn5VXrXv7awMIX4M5ptGSxdz32/3v0x4VLvbtp8w4
         9m7EJ/SI8h+TaDwdIxRwaX2GlTIJCv+YLW9HtzwetVvp4yvjIFQRR5BVA72rF3awm4BC
         x2XXB1Iryfzoy3s4M/+744RuvBeNSGreFZatsyy+MN3tcyLGYh8dbxpQs7b447iWr3Fe
         UR9iyiXU21ibR/0i59XRvY5tBp4wF7pmiTlyT8HYiiHI0tPOBE+E/im90hgM0kZlLptJ
         13RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762272643; x=1762877443;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RCZQkOK0PXpgSpmrJBWMlAt3eB1gpXLJouklLJTzSWg=;
        b=Oyq9tMX4YSTS/H4C5KRQ73+UFjWzZDNb4el+iNUoNe0fGtdhP4VZTQlxGvqijusMRu
         gk9tq7+lcG6vRyrE3WvuaKIlUuLBsp/SmLZNut0xfXtQTys0qTRklCMtAx+oN5MDcivt
         pxz7gdE9NlrPwAGZsJrH5StHqhmrmbLtL7qQTANj7FscC8VwJqt3NdICfPNgcH2pq1ix
         SPdv3JyUHwuNVSmW+gp7bg91GAOJDtxbfJ9tHKCEMVhjL1BpHe1jDKEefcZ2jf0cNiGV
         SLUIhSmNE4J4OEctYFLOqnK2/MY/L3XrxKBkWXDG0RJDI9sAJiBQdwn6722qsUf56nhg
         GNNg==
X-Gm-Message-State: AOJu0YzzOkjqN3ywwbVmaRM973h/w3lX5gS66Y1+11o9aovuuJOoMh8V
	n+HXmNA/QKCn4UIlYq1HqZy8Ip7sLvATihvQmoCU+zotOI0JNc2GgIfAQ4okYfRCWXvQ69bmYsL
	msh4XwwOJwxU4C5r59y3IuYBnWAZN7usz+gzDyRnxCA==
X-Gm-Gg: ASbGncsTKcIAtznOCijsqWgIN7X0ncEn9HNEAdNbLHz8gaBg3PkoV56cSfS3kYU8OoV
	Ce30FSxyNBEMes9G97/o4Cfjb6lWUjdlC4gTEwvzYy+o08dKR65UZso3keuPfdypW8rCr9Zvhl2
	nr5lmENHfQJWTkApebbwS7Rt5Ldb1of7WGwEXRfc9DWD+1QPtBw/zlDpWq+FmL4qVqZliDuK6kj
	5YIVnZKcviPj2mWUK2sBmUc61L5crklpNxHP0Z6OViUQVadgv/kHPL9fVWkKDkyNSrqngql
X-Google-Smtp-Source: AGHT+IGoBJ7dj/daPV033+YTLrW6W6IAC2ATCveJzBWWpO5Rm8eyRupRQCOVnUXUyBg4Uiz/jxxQ4NJoDndnHRsGMNc=
X-Received: by 2002:a05:690c:6904:b0:786:6a75:b70e with SMTP id
 00721157ae682-7866a75c4aamr82722117b3.66.1762272642803; Tue, 04 Nov 2025
 08:10:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251016151929.75863-1-ulf.hansson@linaro.org>
 <20251016151929.75863-3-ulf.hansson@linaro.org> <7h1pmik3w9.fsf@baylibre.com>
In-Reply-To: <7h1pmik3w9.fsf@baylibre.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 4 Nov 2025 17:10:06 +0100
X-Gm-Features: AWmQ_blMmvPtRaS782H67TViX009pK-Dm3rCb2Ej9ytYm3XuvgPqul_EeNpNdmg
Message-ID: <CAPDyKFr1bC1=3psegT0DM0tPQaCUm1DoOxV3xBa-gVV6oSuRVA@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] pmdomain: Respect the CPU system-wakeup QoS limit
 during s2idle
To: Kevin Hilman <khilman@baylibre.com>, "Rafael J . Wysocki" <rafael@kernel.org>
Cc: linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, 
	Peter Zijlstra <peterz@infradead.org>, Pavel Machek <pavel@kernel.org>, Len Brown <len.brown@intel.com>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Saravana Kannan <saravanak@google.com>, 
	Maulik Shah <quic_mkshah@quicinc.com>, Prasad Sodagudi <psodagud@quicinc.com>, 
	Dhruva Gole <d-gole@ti.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 1 Nov 2025 at 01:11, Kevin Hilman <khilman@baylibre.com> wrote:
>
> Ulf Hansson <ulf.hansson@linaro.org> writes:
>
> > A CPU system-wakeup QoS limit may have been requested by user-space. To
> > avoid breaking this constraint when entering a low-power state during
> > s2idle through genpd, let's extend the corresponding genpd governor for
> > CPUs. More precisely, during s2idle let the genpd governor select a
> > suitable low-power state, by taking into account the QoS limit.
>
> In addition to a QoS limit requested by userspace, shouldn't any
> per-device QoS limits from devices in the PM domain with CPUs/clusters
> also be considered?
>
> Right now, if a device is in a PM domain that also contains CPUs, any
> per-device QoS constraints for those devices should also impact the
> state chosen by s2idle.

I am not so sure about that. The existing dev PM QoS latency is
targeted towards runtime suspend of a device and the genpd governor
also takes it into account for this use case.

If we would start to take the same dev PM QoS latency constraint into
account for system suspend (s2idle), it may not be what the user
really intended. Instead, I think we should consider extending the dev
PM QoS interface, to allow the user to set a specific latency limit
for system wakeup. Then the genpd governor should take that into
account for s2idle.

>
> I just tried a quick hack of extending you cpu_system_power_down_ok()
> function to look for any per-device QoS constraints set all devices in
> the PM domain (and subdomains).  It takes the min of all the per-device
> QoS constratins, compares it to the one from userspace, and uses the min
> of those to decide the genpd state.
>
> That has the effect I'm after, but curious what you think about the
> usecase and the idea?

It makes sense, but as stated above, I think we need a new QoS limit
specific for system suspend.

Rafael, what's your thoughts around this?

Kind regards
Uffe

