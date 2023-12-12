Return-Path: <linux-pm+bounces-947-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24EE180EBEC
	for <lists+linux-pm@lfdr.de>; Tue, 12 Dec 2023 13:35:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4C0228123B
	for <lists+linux-pm@lfdr.de>; Tue, 12 Dec 2023 12:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 799D95A0F1;
	Tue, 12 Dec 2023 12:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="I2c3ikbJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A851C101
	for <linux-pm@vger.kernel.org>; Tue, 12 Dec 2023 04:35:38 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-40c2718a768so57291595e9.0
        for <linux-pm@vger.kernel.org>; Tue, 12 Dec 2023 04:35:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1702384537; x=1702989337; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=owJV1DmeJ4fzQxz4ZVEVTw4U+j7bkU+2Yl4dUuHEfQE=;
        b=I2c3ikbJ/2wJqLwAGrQdYeTsFwHl1s9Fe9+ErGqMcrp2x4nu/ikTUZ0M92N9v3iEZA
         6d8ZBaC3SbeKD6zhpYvzLYXQedgU2VF3SKH4l12xLkai804XtMErYfSPro6uCUIZMMwz
         BNQpbIuhwQLBbjw2GyYzEnIem7yNDgW7rsueakS6XYxQ3M1LjBZSvbRWVqJKBL8FCK5F
         ql6gbEpRNPupSsn6cCvPmD9KkXw6DdutmeI4l8SyY3SMgDSWJ2lxM08BZv6R0LS+0bFf
         gYGgZtaYzIYk33D9TfyydYVoUFKeZ3Zmrk5KAl+jUrrcXs3RjJ+3ssEiKxELHGCfaFlE
         a4qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702384537; x=1702989337;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=owJV1DmeJ4fzQxz4ZVEVTw4U+j7bkU+2Yl4dUuHEfQE=;
        b=Rk/Yf11uqIuV2qnV7N4CkATVGMUHO0/MUaBFOirgL9rbBy0UJU7T/qDewOTl8zWYdF
         Vfazj0c3EZFyeKqilVSeGDSkP7Coe7TiW0kQi0fmvvlBnQk+qLJ0aYsmNJhlPhyBWkz5
         ZKHTWLElW7CTxbdrRhwvKvcZbqAT2UMlYaBY1Q7XF1KcQrPQP59U69lEI+2WJnfShoVi
         PUXaOPj9AYx2JxOFHC3o1VnWukXgpw0/g7pSE0ylaBOVOp1uUgCaBiyDqnNurYGb1n94
         iYElvGLnSFENJu3mGZMkZIXFPaF7mpd4NxLYh7ZLXr08uOwLm2+iD8IFC3dJEbvDd07s
         Y8aA==
X-Gm-Message-State: AOJu0YwEGVCIlSnZGBNZdqbdQDCuPG/PV9cdJitTo/VPtlc+grfWTzOJ
	zC1EbY7QkFtvbysD5ln4N7GPgQ==
X-Google-Smtp-Source: AGHT+IHtJYYjSMLbQrW4WDwReSNA1pV0Ue24MB0zI+yINbXbwA+e9B9ECiPS7v9iybTpc4FYHC7brQ==
X-Received: by 2002:a05:600c:c1b:b0:40c:27af:2ac8 with SMTP id fm27-20020a05600c0c1b00b0040c27af2ac8mr3100333wmb.6.1702384537191;
        Tue, 12 Dec 2023 04:35:37 -0800 (PST)
Received: from airbuntu ([104.132.45.98])
        by smtp.gmail.com with ESMTPSA id bi8-20020a05600c3d8800b0040c43be2e52sm8959699wmb.40.2023.12.12.04.35.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 04:35:36 -0800 (PST)
Date: Tue, 12 Dec 2023 12:35:35 +0000
From: Qais Yousef <qyousef@layalina.io>
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	Lukasz Luba <lukasz.luba@arm.com>, Wei Wang <wvw@google.com>,
	Rick Yiu <rickyiu@google.com>, Chung-Kai Mei <chungkai@google.com>,
	Hongyan Xia <hongyan.xia2@arm.com>
Subject: Re: [PATCH 1/4] sched/fair: Be less aggressive in calling
 cpufreq_update_util()
Message-ID: <20231212123535.3yns5f4b6awiuesk@airbuntu>
References: <20231208015242.385103-1-qyousef@layalina.io>
 <20231208015242.385103-2-qyousef@layalina.io>
 <47ef274b-d9cc-4f4f-8134-2dced46005fa@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <47ef274b-d9cc-4f4f-8134-2dced46005fa@arm.com>

On 12/12/23 11:46, Dietmar Eggemann wrote:
> On 08/12/2023 02:52, Qais Yousef wrote:
> > Due to the way code is structured, it makes a lot of sense to trigger
> > cpufreq_update_util() from update_load_avg(). But this is too aggressive
> > as in most cases we are iterating through entities in a loop to
> > update_load_avg() in the hierarchy. So we end up sending too many
> > request in an loop as we're updating the hierarchy.
> 
> But update_load_avg() calls cfs_rq_util_change() which only issues a
> cpufreq_update_util() call for the root cfs_rq?

Yes I've noticed that and wondered. Maybe my analysis was flawed and I was just
hitting the issue of iowait boost request conflicting with update_load_avg()
request.

Let me have another look. I think we'll still end up needing to take the update
out of util_avg to be able to combine the two calls.


Cheers

--
Qais Yousef

> 
> So the 'iterating through entities' should be for a task in a non-root
> taskgroup which the condition (1) takes care of.
> 
> cfs_rq_util_change()
> 
>     ...
>     if (&rq->cfs == cfs_rq) (1)
> 
>         cpufreq_update_util()
> 
> [...]

