Return-Path: <linux-pm+bounces-11373-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D2CE93B86A
	for <lists+linux-pm@lfdr.de>; Wed, 24 Jul 2024 23:10:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 612151C23914
	for <lists+linux-pm@lfdr.de>; Wed, 24 Jul 2024 21:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F98113B2B0;
	Wed, 24 Jul 2024 21:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="uzap+bu7"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A8A13AD1C
	for <linux-pm@vger.kernel.org>; Wed, 24 Jul 2024 21:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721855417; cv=none; b=SuLa41mpI+Eibstdne96yAjXwJy+ktJ/ygW5G2fRHxLqO4TeMnO+ntNHETlVsmN7HKbPcymXfVI0Dhi1J11tU1JPJX5lMo3SmjvdN03JZmV539XCHJg4isudeIfp3H/OlkXiU4wA3Ebm1ydef1LTqfWlUwrGYLhgvt3T1OTVhGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721855417; c=relaxed/simple;
	bh=0ZM8sdx5JQCd6XeEJKPT0C7GyAux5FxWep2ZUayWK6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EQAs6dRxkka8dnhIv8XsnlkZC4wobh4L5wb1KSkkJvxhs/ypsDB1vGLPEVFGZqxG+hyKS0jq9YvX6KveEyBnn3AdBq90hC/4vOS1Yp+ji5LUUld+K4bHMNH3czlxAy4Jsfs5nwviyTEnBRoXoc5cGGznwkIcGmsqejTdzPX7l8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=uzap+bu7; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-42660b8dd27so1588585e9.3
        for <linux-pm@vger.kernel.org>; Wed, 24 Jul 2024 14:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1721855414; x=1722460214; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fdxF1Tt+tCYq4xCwhqWp3Jv/PoXXluEEvZ39wmanBaU=;
        b=uzap+bu73/PlF0+5whR7c2RD1lb5m0ekry0zFRYzeFraQTB5xJRKf2Qd3ZTloausXv
         CTeDOeIwqk1ImfqtOoZ0Q+1Gh4IQyoMnspo7svbQ2yvxbLtuQl+GkmlwBjjYB+EH2iYg
         qG7rpDD8c/IZfETX6AS8iyABlq0oZG1J7qaXg0Fz64YXLD397Lq18LvecRMXdSISA8Qj
         I2IZV5ca1m643IcZ8FAKU9fHQgBfI9dJ6jSKxlXaCdLReespntt9prEreulVvjq7lPr5
         gaMejFE0kuoBmEzHlaW50pT8aRFsB9HZKGUhpli7wQW9VELxTIy6mP9CKd8ZXUWDRaMp
         l5dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721855414; x=1722460214;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fdxF1Tt+tCYq4xCwhqWp3Jv/PoXXluEEvZ39wmanBaU=;
        b=g4hdzCmI9KPwy48vaHFraHRcCwbNCGBWl7VusB7yCPNChUioGyvCqMzw4WZue8DNST
         fz27C2525Rg/7cAGWNAHH9X5JZ/S3G0KonZEkVcPcGFUSK2iXmpK+xTDvG0XdMWvWi+a
         8iRwYcgmVtFZUEcfHMdni8oJGOD2NZg5zYoFPK49cFpIxRHtmJbVZiziYzx1Luq1/JHX
         My4QAb3aZbxlYGjMwEcm1uwq95HshowuXWFa1oxBVQM32R5cNkbQ349l47SNMhcwaysa
         R8wJCoDLaZy9rUp6JL9Cvk9Zn+blnfaUxsOM+NxcL5dagY+0wLh/0oJq2Pr6Tg19s/Xn
         3YUA==
X-Forwarded-Encrypted: i=1; AJvYcCXTvoffkVfXfspxUNtVZ7OWh1Xk9Z6yH9cTwXzzeVXUMtfK5H7fgaVd8s2u1Yit4xMPUbTgqxbwVJyL545ai4t2B/5vCfKHxl4=
X-Gm-Message-State: AOJu0YwWK4t9nzZhGlA/WkDYX3ed0anOy2aC7AqRyHr4hLUQ/efOtmx3
	57GTnvVaVVQpinJL5sea96nOAAeA/dW1p503t5ryoeRMwSGGg8Gin1fThtGv83o=
X-Google-Smtp-Source: AGHT+IF4aVLJZTXs6DWskBUTH+Pae5/oC+LQ2xfj0Qva/yeE2Qcj66zhX/z3IgQV0twO/dscRVVbKQ==
X-Received: by 2002:a05:600c:a04:b0:426:5ee5:3129 with SMTP id 5b1f17b1804b1-42805433066mr1850205e9.2.1721855413659;
        Wed, 24 Jul 2024 14:10:13 -0700 (PDT)
Received: from airbuntu (host81-157-90-255.range81-157.btcentralplus.com. [81.157.90.255])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-428057a6283sm2649975e9.32.2024.07.24.14.10.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 14:10:13 -0700 (PDT)
Date: Wed, 24 Jul 2024 22:10:12 +0100
From: Qais Yousef <qyousef@layalina.io>
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Hongyan Xia <hongyan.xia2@arm.com>,
	John Stultz <jstultz@google.com>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6] sched: Consolidate cpufreq updates
Message-ID: <20240724211012.mxb6vgbhurk7rcvc@airbuntu>
References: <20240619201409.2071728-1-qyousef@layalina.io>
 <f281ba07-d54a-460a-8f78-f7eb6bd8ed88@arm.com>
 <20240628015200.vw75huo53redgkzf@airbuntu>
 <d510f41a-1225-46d9-a2d7-ff9e6ff599d2@arm.com>
 <20240705002205.nnrgq7savzvsoqgl@airbuntu>
 <2e988929-142c-4e69-8e2e-2f3e64c9f08c@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2e988929-142c-4e69-8e2e-2f3e64c9f08c@arm.com>

On 07/05/24 13:50, Dietmar Eggemann wrote:

> > Yes I am referring to SCHED_IDLE policy too. What is your expectation? AFAIK
> > the goal of this policy to run when there's nothing else needs running.
> 
> IMHO, SCHED_IDLE tasks fight with all the other FAIR task over the
> resource rq. I would include SCHED_IDLE into this switch statement next
> to SCHED_NORMAL and SCHED_BATCH.
> What do you do if only SCHED_IDLE FAIR tasks are runnable? They probably
> also want to have their CPU frequency needs adjusted.

Okay I added it. I think there's room for improvements, but will pursue this in
future patches after more thinking.

> > I am not seeing the issue, could you expand on what is it?
> 
> I tried to explained it in the 4 lines below. With a local 'decayed'
> update_cfs_rq_load_avg() and propagate_entity_load_avg() set it every
> time update_load_avg() gets called. And this then determines whether
> update_tg_load_avg() is called on this cfs_rq later in update_load_avg().
> 
> The new code:
> 
>   cfs_rq->decayed |= update_cfs_rq_load_avg() (*)
>   cfs_rq->decayed |= propagate_entity_load_avg()
> 
> will not reset 'cfs_rq->decayed' for non-root cfs_rq's.
> 
> (*) You changed this in v3 from:
> 
>   cfs_rq->decayed  = update_cfs_rq_load_avg()
> 
> 
> >> update_load_avg() itself. They will stay decayed after cfs_rq->decayed
> >> has been set to 1 once and will never be reset to 0. So with UPDATE_TG
> >> update_tg_load_avg() will then always be called on those non-root
> >> cfs_rq's all the time.
> > 
> > We could add a check to update only the root cfs_rq. But what do we gain? Or
> > IOW, what is the harm of unconditionally updating cfs_rq->decayed given that we
> > only care about the root cfs_rq? I see more if conditions and branches which
> > I am trying to avoid.
> 
> Yes, keep 'decayed' local and add a:
> 
>     if (cfs_rq == &rq_of(cfs_rq)->cfs)
>         cfs_rq->decayed = decayed

I still don't see a problem here. If we don't do it this way, how the outcome
of frequency selection will change? You're replacing set-but-not-cleared with
never-set, and un unconditional write with a branch.

I updated the code to only set for root cfs_rq anyway in spite of not seeing
any tangible benefit.


Thanks!

--
Qais Yousef

