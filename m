Return-Path: <linux-pm+bounces-10877-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9132092BB84
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jul 2024 15:38:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2DFA1C23CA0
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jul 2024 13:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D45216D9B4;
	Tue,  9 Jul 2024 13:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TmPGTSwh"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04FBA16D4C8
	for <linux-pm@vger.kernel.org>; Tue,  9 Jul 2024 13:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720532209; cv=none; b=pNJF74smb21r9ZHb9Y/0FMFKTPTe6/zP4QqeOXebaBE5OBEkeq8gCRvqD2VCrShlFWLLJ6XcHKbUdy7XquUwcm/I3qZFpp1N1N4S1mUIjkBB9J1mqYqf3YUKHE+iaaq2dr4hMWecFWoyfEK76/Nz2kmvYnitz4YYC4Igi5n/AH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720532209; c=relaxed/simple;
	bh=Onc/w0W8oRYcL0nlkLqAaGGC05n10oVyNR6/WGfjgEY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iJ5wDBNcGh8ssHMqIxtJQGZ8Yn6BrCY4El2vs9/tixemdfiyD/xIA6/jHmi7x8ZqxlsUlvBfDfWU7vD1xfMIZ/sRP5JOHe8D9JscqKxgIXnjQt8x33ha4g/CIvaPJknsJazmsEBniSZP9ytzBvBr/o2/Nh+IHN70VVbSYFUDEsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TmPGTSwh; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-447e2d719afso18282111cf.0
        for <linux-pm@vger.kernel.org>; Tue, 09 Jul 2024 06:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720532207; x=1721137007; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Onc/w0W8oRYcL0nlkLqAaGGC05n10oVyNR6/WGfjgEY=;
        b=TmPGTSwhhyAV4cjd0l1IUaQCuEk9eNBsPGO2/hVROmb0jF1uGQEbKKMi/IExfHZRs+
         BYJrdSo/IvcQeM/XnO3mDS0TEgYnbzY3vVFGeVAMSqKhjjki5MT2Gum/VMeF3NHRi001
         owG9Cs86Mq/llplhxSzo4ScOBpMNxIQtsbmPD/PSikxaNaY7Hmkx7riojYzVVFQoemK7
         N+jsW7uhwsnjrlnbCc6Nzrr5aayCvc/TaoV+BlnmcxOgqmB0d1No6uYdschNvdKkla8i
         VnXEaSo4cTEjtGS39p+otkeJybimHdc/T1fvDDCQFYEim1LSKY7Du8bWz6zs0dVt4ZPC
         a0vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720532207; x=1721137007;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Onc/w0W8oRYcL0nlkLqAaGGC05n10oVyNR6/WGfjgEY=;
        b=rUy05Gn4qMsJz2Lbj77JR+requZXAmxltB19BVfU0DtxuRVLDwAmR9y7Ny/DXwgndH
         GUlHZUe2JmwIApAaOJLDqXv9+qkZby5awpqptO8UhYnM2WmrmbFWV0TYoZyalGsw12/k
         X+HNCFyFGKYw0xT/oOu5IOFkrZrGcuCx2nh5jiyYV5ndYnE8hJMreDyv98dL39dyyP53
         ETks+pPwep9QTh6cf4v99aLWjQTQ1PPKmaCIb3UOxxJhRRllR4CYMpxA/IGzRnHxsgrP
         AW/XZCfRVmqBKFivTp+nLr0TKwebf32x6OipZDgBKDR1Cos7yQDUUXqYqkeaTx3BS0lY
         aWQQ==
X-Forwarded-Encrypted: i=1; AJvYcCXez/iTRvaL2xxsMkeICcLrWK+zL4TjVZ88q6277ZacW06DPkpXkuA2VQffbPxk5xwG1fp9q+qRnAovMQB/w0ixKk4C7rwGpUs=
X-Gm-Message-State: AOJu0YyYdAFqhFURgG3tPoTY5JoE1OAKaeatcRvKFEmnSYrjPVjIRa7P
	8+TQ8NrCI6llhjgk76HL16qpgMTr2kgRcD2vKJHztYamOxZWfVARXR2AodERawlBijPFBZAVbqQ
	YbPsv8bLOLp8g2BM/Zv9TgU7p2+OvrazGGBpVqA==
X-Google-Smtp-Source: AGHT+IFbY6+qvqocJnF91c8cRGW6w2sl4YtsuoGZuQkrm2HWP2P7YQnkbM6czb/WQ8nm2/0yW0zSzCFDvYSYvR4R3Sg=
X-Received: by 2002:ac8:73d6:0:b0:447:e591:2d27 with SMTP id
 d75a77b69052e-447fc364793mr29602491cf.6.1720532206879; Tue, 09 Jul 2024
 06:36:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240619031250.2936087-1-tj@kernel.org> <20240619031250.2936087-3-tj@kernel.org>
 <ZnM2ywDVRZbrN6OC@slm.duckdns.org> <CAKfTPtBPObGdcaQF5nKqr4042f-+5obTMm_S6S+=3_Ct33ZMyw@mail.gmail.com>
 <Zog5-Yd5wV0-Y76y@slm.duckdns.org> <CAKfTPtDeA4OTPJmEHd-wKToYwDVizcny-_qxEuDUA-OcaVm2Uw@mail.gmail.com>
 <ZonzAdyd6zb2Sm06@slm.duckdns.org> <CAKfTPtDE2rWbRouf8zRyM3UpTfK1k_xrWmvAs-zfoRZqM3zGsw@mail.gmail.com>
 <Zowt7pVWFB-Of-me@slm.duckdns.org> <CAKfTPtB=77c-RsJ23suNZVf7qByeGSjYQJbiEU4JpXU6DezNLQ@mail.gmail.com>
 <ZoxVZPCrWokjfmFY@slm.duckdns.org>
In-Reply-To: <ZoxVZPCrWokjfmFY@slm.duckdns.org>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Tue, 9 Jul 2024 15:36:34 +0200
Message-ID: <CAKfTPtAjFvOPByPyeAURN3gw0yp8ByVmpa99_dGEZiTGw_Fawg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] sched_ext: Add cpuperf support
To: Tejun Heo <tj@kernel.org>
Cc: rafael@kernel.org, viresh.kumar@linaro.org, linux-pm@vger.kernel.org, 
	void@manifault.com, linux-kernel@vger.kernel.org, kernel-team@meta.com, 
	mingo@redhat.com, peterz@infradead.org, David Vernet <dvernet@meta.com>, 
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 8 Jul 2024 at 23:09, Tejun Heo <tj@kernel.org> wrote:
>
> Hello, Vincent.
>
> On Mon, Jul 08, 2024 at 09:51:08PM +0200, Vincent Guittot wrote:
> > > Unless we add a WARN_ON_ONCE, if it doesn't behave as expected, the end
> > > result will most likely be cpufreq sometimes picking a higher freq than
> > > requested, which won't be the easiest to notice. Would you be against adding
> > > WARN_ON_ONCE(scx_switched_all && !util) too?
> >
> > A WARN_ON_ONCE to detect misbehavior would be ok
>
> I tried this and it's a bit problematic. Migrating out all the tasks do
> bring the numbers pretty close to zero but the math doesn't work out exactly
> and it often leaves 1 in the averages. While the fair class is in use, they

hmm interesting, such remaining small value could be expected for
load_avg but not with util_avg which is normally a direct propagation.
Do you have a sequence in particular ?

> would decay quickly through __update_blocked_fair(); however, when all tasks
> are switched to sched_ext, that function doesn't get called and the
> remaining small value never decays.
>
> Now, the value being really low, it doesn't really matter but it's an
> unnecessary complication. I can make sched_ext keep calling
> __update_blocked_fair() in addition to update_other_load_avgs() to decay
> fair's averages but that seems a lot more complicated than having one
> scx_switched_all() test.
>
> Thanks.
>
> --
> tejun

