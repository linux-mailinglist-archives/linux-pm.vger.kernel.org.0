Return-Path: <linux-pm+bounces-13688-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB2B196D754
	for <lists+linux-pm@lfdr.de>; Thu,  5 Sep 2024 13:39:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 653A1287AA6
	for <lists+linux-pm@lfdr.de>; Thu,  5 Sep 2024 11:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F202199E80;
	Thu,  5 Sep 2024 11:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l88QK/a3"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC300192D72
	for <linux-pm@vger.kernel.org>; Thu,  5 Sep 2024 11:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725536346; cv=none; b=KT00h9dIYb6EtqKTVKBnLlEl5KoxJVa1LGcWrfQ/M2Kmowx0suJd/98odAlZQN1Ce9muyPbMzjOLNyokZ0eRWTrQof4YkdloIrApdg+l49XkDSCJTeI8pyBeJdxlfU8if7aLhmLT7UfsWSuRm/TE3GXv/WoDDNT/DQsBRIW1j+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725536346; c=relaxed/simple;
	bh=7dThSnBD4jy2w+lNK4sQoHqZorzmpN8yffl06pPHXfY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tOQrTarB6nEr+6SuPnWceF+bAjnjG/niaT5CmRf1sX/mb8mUiN+qnIlMpw/UWYT+HgrdSj6mdiq69T7KWfXr2MbaoQL/HcKLS3YKaaaHTOdcneX/mdsZOpHEJzT/FYx72WafO43nrj241bxJE9HIypYQihF/ePKmZ0GMXPkcaFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=l88QK/a3; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e1a819488e3so725078276.3
        for <linux-pm@vger.kernel.org>; Thu, 05 Sep 2024 04:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725536344; x=1726141144; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jLrIko9Z9MxBDc0IDBCABFFMewp6y0UOpPNBPOn2Xow=;
        b=l88QK/a3fjAjpOG6VwKD1oPLrRaiyGRA7dUiVdGCXGQWF71DhFj68YBAfZ6HKcXbkQ
         ygIuyhdvImkdKzCjGZUw0kDRiUxh09i7TlfhTGHVqMzx33B4OxlfkYEH0hbMi9cQzeCJ
         wNAyF8LS4MAigFDB4RFVbUYeb6FyjZn31M1Kn241mv9w3avzKR+nA3/Z94fEUs4I5Vo6
         Es13IMNYPd5bDWdIbrkB8fiJ7YQccKW2C2tRgC23H8VZYOoQq69sbREiJUFK8MkQPzEM
         egXilzak+nTL0u3D9+ZzazX28Zzg7G6+MI+0cCBN8kfO0UjTb3gV8/0jQtZIgfQiEZXN
         q8lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725536344; x=1726141144;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jLrIko9Z9MxBDc0IDBCABFFMewp6y0UOpPNBPOn2Xow=;
        b=eLrsz969LFfAv7Zovm4kr2XtxvykLqn+/6gVNGghAp+EnDv9w79Ce1mM/ZcbddvfU/
         o3FlroO8dro/6EBfy70yJ7bELlist1vIS8Prdx38XidYD+tQVab/socSpDOXQ69V+KVS
         rEPAoLqzJnU6kvor5QpfJXwMXEuhoiakVkLjsVk21idfiBw33ngmLH5puqFYVqHpQUvR
         LfQDtuesxKrOs4x5IlEmMuHTayWpQyDI+Xo/JtZq4zMmch27PMebwvM0MhNZMD1KJU07
         mYz3g2xCgYy70RQCHL0MJP0Sm5WFcGluykImqcaEmRJ3uCj9lX4mcdqKpBDeImCiJHNJ
         WxOw==
X-Gm-Message-State: AOJu0YwXadIj25z7UaiwlEKGWWUyel0sFViMJ29xTuY15Sa69/8lWHkM
	1NnNidT/p2wZXQqu3yAd1+6z78R/vvEs9hbPw7+AYK0yQwfkunnXcoxch2Z7XLaBAQsi2ZeO8HN
	AN9D0shgUXpf+1TA3Bpb6KEJW7R9KkTGr1mN4BQ==
X-Google-Smtp-Source: AGHT+IG2scPjtVAXf9nEKI3l/EN+JmBquZI8G7Ofzyty/BbMRzaMcLv0Q0Cuw4yoEG/OI+Q41jbqYX6lsRoODakwg1Q=
X-Received: by 2002:a05:6902:2601:b0:e1a:b168:8053 with SMTP id
 3f1490d57ef6-e1ab16881a3mr15652183276.17.1725536343783; Thu, 05 Sep 2024
 04:39:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240819-lpm-v6-10-constraints-pmdomain-v2-0-461325a6008f@baylibre.com>
In-Reply-To: <20240819-lpm-v6-10-constraints-pmdomain-v2-0-461325a6008f@baylibre.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 5 Sep 2024 13:38:27 +0200
Message-ID: <CAPDyKFrFX_UeYWuZtQPoxHbZb0CwpLRA=QcMFsALwuiFTY3T5Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] pmdomain: ti_sci: collect and send low-power mode constraints
To: Kevin Hilman <khilman@baylibre.com>
Cc: linux-pm@vger.kernel.org, Nishanth Menon <nm@ti.com>, Vibhore Vardhan <vibhore@ti.com>, 
	Dhruva Gole <d-gole@ti.com>, Akashdeep Kaur <a-kaur@ti.com>, Sebin Francis <sebin.francis@ti.com>, 
	Markus Schneider-Pargmann <msp@baylibre.com>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 20 Aug 2024 at 02:00, Kevin Hilman <khilman@baylibre.com> wrote:
>
> The latest (10.x) version of the firmware for the PM co-processor (aka
> device manager, or DM) adds support for a "managed" mode, where the DM
> firmware will select the specific low power state which is entered
> when Linux requests a system-wide suspend.
>
> In this mode, the DM will always attempt the deepest low-power state
> available for the SoC.
>
> However, Linux (or OSes running on other cores) may want to constrain
> the DM for certain use cases.  For example, the deepest state may have
> a wakeup/resume latency that is too long for certain use cases.  Or,
> some wakeup-capable devices may potentially be powered off in deep
> low-power states, but if one of those devices is enabled as a wakeup
> source, it should not be powered off.
>
> These kinds of constraints are are already known in Linux by the use
> of existing APIs such as per-device PM QoS and device wakeup APIs, but
> now we need to communicate these constraints to the DM.
>
> For TI SoCs with TI SCI support, all DM-managed devices will be
> connected to a TI SCI PM domain.  So the goal of this series is to use
> the PM domain driver for TI SCI devices to collect constraints, and
> communicate them to the DM via the new TI SCI APIs.
>
> This is all managed by TI SCI PM domain code.  No new APIs are needed
> by Linux drivers.  Any device that is managed by TI SCI will be
> checked for QoS constraints or wakeup capability and the constraints
> will be collected and sent to the DM.
>
> This series depends on the support for the new TI SCI APIs (v10) and
> was also tested with this series to update 8250_omap serial support
> for AM62x[2].
>
> [1] https://lore.kernel.org/all/20240801195422.2296347-1-msp@baylibre.com
> [2] https://lore.kernel.org/all/20240807141227.1093006-1-msp@baylibre.com/
>
> Signed-off-by: Kevin Hilman <khilman@baylibre.com>
> ---
> Changes in v2:
>
> - To simplify this version a bit, drop the pmdomain ->power_off()
>   changes.  Constraints only sent during ->suspend() path.  The pmdomain
>   path was an optimization that may be added back later.
> - With the above simplification, drop the extra state variables that
>   had been added to keep track of constraint status.
> - Link to v1: https://lore.kernel.org/r/20240805-lpm-v6-10-constraints-pmdomain-v1-0-d186b68ded4c@baylibre.com
>
> ---
> Kevin Hilman (3):
>       pmdomain: ti_sci: add per-device latency constraint management
>       pmdomain: ti_sci: add wakeup constraint management
>       pmdomain: ti_sci: handle wake IRQs for IO daisy chain wakeups
>
>  drivers/pmdomain/ti/ti_sci_pm_domains.c | 76 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 76 insertions(+)
> ---
> base-commit: ad7eb1b6b92ee0c959a0a6ae846ddadd7a79ea64
> change-id: 20240802-lpm-v6-10-constraints-pmdomain-f33df5aef449
>
> Best regards,
> --
> Kevin Hilman <khilman@baylibre.com>

Besides a couple of minor things that I have commented on for each
patch, this looks okay to me!

Taking into account the other series that this depends on, what is the
best merging strategy? Is it safe for me to take it through my
pmdomain tree?

Kind regards
Uffe

