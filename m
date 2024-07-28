Return-Path: <linux-pm+bounces-11514-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E157B93E90E
	for <lists+linux-pm@lfdr.de>; Sun, 28 Jul 2024 21:29:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0CE21C20DD7
	for <lists+linux-pm@lfdr.de>; Sun, 28 Jul 2024 19:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D794964CEC;
	Sun, 28 Jul 2024 19:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="Fohzn95A"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2035D1E871
	for <linux-pm@vger.kernel.org>; Sun, 28 Jul 2024 19:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722194957; cv=none; b=Q60m+kzetw4BSysSciQKhVrVzy15Z6v+AqIENm43hqcN7WZVaB++rxcOLNe2MfOwZd6BR4+j/E0/QUrxhtokac8SZsm3FGmb4MGUBohab3AvX9vxSM9/g+C7S9ILkqrWqjksIiE3WKpo6ozuWHdMheME4Fq2k/XaubTHpauweas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722194957; c=relaxed/simple;
	bh=EkykgABaHcCxmbJIAQvVYicfYDpbFvhFUWVJqV2eFRE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kP73b0SJWUl28H4LjLK8fRwlh1O/FFv/SF+z/3MwKDtOwr9J/7c9fFFIAypkAYREHzR66CU59WkxITloRmkrjUmEVtX5nD98fwaB1PDA6/H2nrKkdn0zo1UQfLaPTS9gb70HXmTHk2P7OvlMdOf5Uii1rG4SflER8RCSq+yDcUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=Fohzn95A; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-368526b1333so597524f8f.1
        for <linux-pm@vger.kernel.org>; Sun, 28 Jul 2024 12:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1722194954; x=1722799754; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WE2U25ljnC8LiLYYAN5sivMKrYSYnSn08pdkngVEPFo=;
        b=Fohzn95A1CADOtUoycn5nDZmrbwTO+3CO0EFXuzsoJ1ntel6vBrvYB1bLf15FVYBDQ
         NU6yNqGr1BWjfUArSJUWP1hnCh0g8Rj+8MOfPPLS1vW3qZRnaLPw1yCM0nseMlx7R41S
         8epNedVSZsRwkGS5avePnOXgyuNBkDoaGwPOaOKdQ7XnFPDO3tj10nXJxkhcdA9qAc7C
         Mx0LTBycQtoEto/1imo+jFXKLLg2GBjpzNmD4uE1kV32KgxYeYHlQTxK8Fu04IHhjorF
         yDI2tds7LzEDI1W9XbyEcVaeKaGoRxaIISMmayvu61jnvFBIkGPVsMjQnTf3pZm4b230
         FSlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722194954; x=1722799754;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WE2U25ljnC8LiLYYAN5sivMKrYSYnSn08pdkngVEPFo=;
        b=ielDrMnn4dpbE6Lq0HeSr5Hqn9H7a7vbCTJUZAnpfiIBdZEAHYwR0Mjzl2t3gjec9A
         I88bN7dKAlADP/+Ox8xOool6J58dx2p1c72u5kALL9HjH+yVlp+DjxnHDaaH/qYhuPvC
         2oAV6Fbzy1p1QwNrd8UEQCLxalZFSOYBjpDZPGlNIAB4PdSvi2HKD1PJc52MYJRVGDZo
         ARjYy5GHgdqPHsFEyyG9ZmAEP4jdPUFSuQadqznAHn6NuPG7Xdf8SVAYdUxKgcYvhPeh
         Uy/XrLIVV/aHsC4qTs+aeuRbBPBGaxiQkTBkq3wjZumCFRevkMCFmAi/QJmqvCLm4veV
         nv2w==
X-Forwarded-Encrypted: i=1; AJvYcCUEFMjt341ajgF9WCvAxyuU5ON47zE9/hCpY/gboOlPtaXkYGFbub/ZB+ou/+wD3M8v/tH/dABgz2nytjD1k4T6Bn8HMEp6w9w=
X-Gm-Message-State: AOJu0Yz0lF4rDBx2LVKe6ZgKw5FOY6YTo7umJ2NhJVw3sbOkdMvIbwDv
	HtRK5m6g5ODKDQPN3jgJU7/SRsadAXQYF+vey9n43cSn0Ch8lBbE3a0rFKqujP4=
X-Google-Smtp-Source: AGHT+IERTSAgwbdPI+91YriwOzlv6tsOwquTRIr1AmhW4kXLS68xQIhgKZNqW5f0iaTmPqd8NKw63w==
X-Received: by 2002:a5d:5227:0:b0:36b:5d86:d889 with SMTP id ffacd0b85a97d-36b5d86d95cmr3268206f8f.6.1722194954420;
        Sun, 28 Jul 2024 12:29:14 -0700 (PDT)
Received: from airbuntu (host81-157-90-255.range81-157.btcentralplus.com. [81.157.90.255])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b36857f23sm10432058f8f.78.2024.07.28.12.29.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jul 2024 12:29:14 -0700 (PDT)
Date: Sun, 28 Jul 2024 20:29:13 +0100
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
Message-ID: <20240728192913.ocesyzgsmcu632ds@airbuntu>
References: <20240619201409.2071728-1-qyousef@layalina.io>
 <f281ba07-d54a-460a-8f78-f7eb6bd8ed88@arm.com>
 <20240628015200.vw75huo53redgkzf@airbuntu>
 <d510f41a-1225-46d9-a2d7-ff9e6ff599d2@arm.com>
 <20240705002205.nnrgq7savzvsoqgl@airbuntu>
 <2e988929-142c-4e69-8e2e-2f3e64c9f08c@arm.com>
 <20240724211012.mxb6vgbhurk7rcvc@airbuntu>
 <962a0fe6-c6bf-415a-9c57-ecb259bd0066@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <962a0fe6-c6bf-415a-9c57-ecb259bd0066@arm.com>

On 07/27/24 10:15, Dietmar Eggemann wrote:
> On 24/07/2024 23:10, Qais Yousef wrote:
> > On 07/05/24 13:50, Dietmar Eggemann wrote:
> 
> [...]
> 
> >> I tried to explained it in the 4 lines below. With a local 'decayed'
> >> update_cfs_rq_load_avg() and propagate_entity_load_avg() set it every
> >> time update_load_avg() gets called. And this then determines whether
> >> update_tg_load_avg() is called on this cfs_rq later in update_load_avg().
> >>
> >> The new code:
> >>
> >>   cfs_rq->decayed |= update_cfs_rq_load_avg() (*)
> >>   cfs_rq->decayed |= propagate_entity_load_avg()
> >>
> >> will not reset 'cfs_rq->decayed' for non-root cfs_rq's.
> >>
> >> (*) You changed this in v3 from:
> >>
> >>   cfs_rq->decayed  = update_cfs_rq_load_avg()
> >>
> >>
> >>>> update_load_avg() itself. They will stay decayed after cfs_rq->decayed
> >>>> has been set to 1 once and will never be reset to 0. So with UPDATE_TG
> >>>> update_tg_load_avg() will then always be called on those non-root
> >>>> cfs_rq's all the time.
> >>>
> >>> We could add a check to update only the root cfs_rq. But what do we gain? Or
> >>> IOW, what is the harm of unconditionally updating cfs_rq->decayed given that we
> >>> only care about the root cfs_rq? I see more if conditions and branches which
> >>> I am trying to avoid.
> >>
> >> Yes, keep 'decayed' local and add a:
> >>
> >>     if (cfs_rq == &rq_of(cfs_rq)->cfs)
> >>         cfs_rq->decayed = decayed
> > 
> > I still don't see a problem here. If we don't do it this way, how the outcome
> > of frequency selection will change? You're replacing set-but-not-cleared with
> > never-set, and un unconditional write with a branch.
> 
> This seems to be a misunderstanding. The problem is not with the
> frequency selection.
> 
> The issue I see is when you set 'cfs_rq->decayed' for a non-root cfs_rq
> it stays set forever since there is no code to reset it. This leads to
> the fact that update_tg_load_avg(..., UPDATE_TG) is then always called
> for this cfs_rq within update_load_avg() whereas before 'decayed' was
> evaluated with each invocation of update_load_avg().

Ah I see you're talking about the if condition. I got you now, sorry it took
a while :). Yes this was wrong. I did follow your advice anyway and changed it
as you suggested in v7.

Thanks!

--
Qais Yousef

