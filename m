Return-Path: <linux-pm+bounces-10743-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91BF1929C55
	for <lists+linux-pm@lfdr.de>; Mon,  8 Jul 2024 08:37:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D32B280DA6
	for <lists+linux-pm@lfdr.de>; Mon,  8 Jul 2024 06:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3837713AF9;
	Mon,  8 Jul 2024 06:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bywO3buZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC5B101F7
	for <linux-pm@vger.kernel.org>; Mon,  8 Jul 2024 06:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720420640; cv=none; b=kXGP7jG3TQmt4nluklDiByYV0Rn0Ctjwpk4xh5uDH4ik0+u0lTPj5QgjMua8KPZHqi+7PUb2ByX5px0ouAeovOqAISjKWkga2e22r9zMIBrkJLij6tC58ichIVg+VlxUaPfyzDBt87BffXwgovTs6DWpMCO5mrSSsg16D+iHh+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720420640; c=relaxed/simple;
	bh=9XH+A+A6pdQhS/+ynwXmaeoQJ2J+3srt7+L2hiZznZ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eb4/LCK0aeIbJTgVjP05bDld0FK06B//pvqjvWpVrj77h8snGWhI9PSM7JEeAif/ao7GmYKWDeRG0kjs8XKVJJ09L2hI0JE78vuWNHgQeAEnrZmnhzxgT/CbqoBA3mKFWoCqYXlF14u8jszdmd0967NVhc0aI4hPNuz3cTpmeVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bywO3buZ; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2c97ff39453so2404234a91.0
        for <linux-pm@vger.kernel.org>; Sun, 07 Jul 2024 23:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720420638; x=1721025438; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9XH+A+A6pdQhS/+ynwXmaeoQJ2J+3srt7+L2hiZznZ0=;
        b=bywO3buZUdxpNrcvoWwPkTVXHrEo4GfcDYGFzlGh81MGEOMLfywJPjnSHWRp+8s6X7
         ka7nBEpJIChIg01ycgZE8DsNeor3Uo0smg1BpWACHteBgenyJyclmEer4zKVzrHCgG4Z
         RmLIMOfzHGkrlJUwzvWsDiVR0ktw90rh0UI1W//7REpoaHR6wXvtvmhJhT1ovET0C5nH
         KFhJO+NhdUniXiFZ3rKLRUZZBsaadddWPJa5HlNmBAy6Kx8Ik9mU0RukCvL0Vo6lyDNb
         95Es2THK7Xx0Cel8NSYoA5+uUnpbnnQuXW/T24ZJ2r11j8qwpgrfLFsOD7RoxLKHjwko
         ozLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720420638; x=1721025438;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9XH+A+A6pdQhS/+ynwXmaeoQJ2J+3srt7+L2hiZznZ0=;
        b=QMxfefTRhpczyeSxVrh1zYxeDEq8C3J7S6hYhIf41CnqzeNGUMLdJVVf3hZ9ffQSZh
         lj31HCDGUbGfg5T5MQEJxU+VhjK8ci2TZ+f9dmFrPU++Q3p/1AVOmFIKRzsYtK56mzkl
         2CBtIpxNrpxQ3qjPUKmBPiIEp+/n7uJJ2fMKBV8FySFGDtTBTOMV/ycIJU8Ln3Sr1ZHn
         5rtfnko7qEgrQxhPzSrIQ8/z15Nly0fhyyQLFz9A5rwoZTYVe+A4Uw5syqUEO++J4rwE
         24rM550wVnq4mYlx8ZBgS7wU4kzoMtTU2z7qn/3Uu9DFpk8LVkSjifnk8e+ngfURhV3C
         zGdA==
X-Forwarded-Encrypted: i=1; AJvYcCWXc0sP9af0vlDVxE7DMJg7yxackyxgfq9EelSSItMLrzzrX1AjX6Ta+kqFI5TFZvpfGN+jg0UTJLzg7m35F3943M4kFkg5j8c=
X-Gm-Message-State: AOJu0Yz3cJDIsfOvPSOX21egexRTwJj4BMayB8f8sOPYP0Ow1ZB6D7fs
	VqydWsID/CC6zio4yt5oGBkMhJWk7LKNVmCdvHMDTeldef06/T52fbra1c/sLeUPuq0eLkp1LPf
	KP1TAUdhUvVzlyHL1ckcAGvRVkqiNvZYJEwp/Cg==
X-Google-Smtp-Source: AGHT+IHjePj0LxGfR2nvdNbd5IvGhQSRQUzfXtW9Tgm1FFUXiJudOU0iSHUIUplho3zA+arT6C/C1fet0EhIf1iW6Zw=
X-Received: by 2002:a17:90b:4c89:b0:2c3:11fb:a163 with SMTP id
 98e67ed59e1d1-2c99c502fe3mr9745271a91.6.1720420638031; Sun, 07 Jul 2024
 23:37:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240619031250.2936087-1-tj@kernel.org> <20240619031250.2936087-3-tj@kernel.org>
 <ZnM2ywDVRZbrN6OC@slm.duckdns.org> <CAKfTPtBPObGdcaQF5nKqr4042f-+5obTMm_S6S+=3_Ct33ZMyw@mail.gmail.com>
 <Zog5-Yd5wV0-Y76y@slm.duckdns.org> <CAKfTPtDeA4OTPJmEHd-wKToYwDVizcny-_qxEuDUA-OcaVm2Uw@mail.gmail.com>
 <ZonzAdyd6zb2Sm06@slm.duckdns.org>
In-Reply-To: <ZonzAdyd6zb2Sm06@slm.duckdns.org>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Mon, 8 Jul 2024 08:37:06 +0200
Message-ID: <CAKfTPtDE2rWbRouf8zRyM3UpTfK1k_xrWmvAs-zfoRZqM3zGsw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] sched_ext: Add cpuperf support
To: Tejun Heo <tj@kernel.org>
Cc: rafael@kernel.org, viresh.kumar@linaro.org, linux-pm@vger.kernel.org, 
	void@manifault.com, linux-kernel@vger.kernel.org, kernel-team@meta.com, 
	mingo@redhat.com, peterz@infradead.org, David Vernet <dvernet@meta.com>, 
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Content-Type: text/plain; charset="UTF-8"

On Sun, 7 Jul 2024 at 03:44, Tejun Heo <tj@kernel.org> wrote:
>
> Hello,
>
> On Sat, Jul 06, 2024 at 11:01:20AM +0200, Vincent Guittot wrote:
> > > There's scx_enabled() and scx_switched_all(). The former is set when some
> > > tasks may be on sched_ext. The latter when all tasks are on sched_ext. When
> > > some tasks may be on sched_ext but other tasks may be on fair, the condition
> > > is scx_enabled() && !scx_switched_all(). So, the above if statement
> > > condition is true for all cases that tasks may be on CFS (sched_ext is
> > > disabled or is enabled in partial mode).
> >
> > My point is that if there is no fair task, cpu_util_cfs_boost() will
> > already return 0 so there is no need to add a sched_ext if statement
> > there
>
> I see, but scx_switched_all() is a static key while cpu_util_cfs_boost()
> isn't necessarily trivial. I can remove the conditional but wouldn't it make
> more sense to keep it?

I prefer to minimize (if not remove) sched_ext related calls in the
fair path so we can easily rework it if needed. And this will also
ensure that all fair task are cleanly removed when they are all
switched to sched_ext

Thanks
Vincent

>
> Thanks.
>
> --
> tejun

