Return-Path: <linux-pm+bounces-35410-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D2916BA10AB
	for <lists+linux-pm@lfdr.de>; Thu, 25 Sep 2025 20:36:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A436B4E02DF
	for <lists+linux-pm@lfdr.de>; Thu, 25 Sep 2025 18:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D194D31A045;
	Thu, 25 Sep 2025 18:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SWw4JtDb"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE68319873
	for <linux-pm@vger.kernel.org>; Thu, 25 Sep 2025 18:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758825379; cv=none; b=HtsRZcZfdoKh1wko5HsKkTMB84YxIZLl+8kz6PTUf1rMLc/IAJ4bELyfXV8sLyxrE/P3TbGmXujBYpa/ITmGkjfnLhjW0ZVifTyMaplD3jU/uwFUJ2X9diVslkN3fz2Ohq7OnNlB7rk9RctZie80wKs7WNAyJ72c69niyWyQUU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758825379; c=relaxed/simple;
	bh=yTNcLmgvEDy9EISXeXBi6gHdiwI9LV3MmdEt8b5e8bU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=adJgauskNvY7FdCdedEPeM26yrsh2xAyihHgfmdKbCQkLmlnXP2keZnW4cN5IL7kAhB2yORjV70sC6hjUUHp0sWhOO5eeBn5oF8NxPoOcl5GywT5b4D0umH8d+gnKrzjWrxkIn/3GzKo+qIUBHpMzX165ysmy/IOP0m/Gm/Cq/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=SWw4JtDb; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3304dd2f119so1055267a91.2
        for <linux-pm@vger.kernel.org>; Thu, 25 Sep 2025 11:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1758825377; x=1759430177; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bv1I4Ic9wC08aXBbFZJljZdZZSbHg/OBO6m8rXTaTQA=;
        b=SWw4JtDbnI5I5wPq+33qixxb/11l6orQ0QZL5Sp5ZzVpec00eZJtfXey5rHg7D8fxI
         wI5TPYyWlO9L0BRvmSh8QDDi7hbC0sLvdHBXkeouPjDKiq/yemCq7m+mHl3d02ei20z8
         AgtMaWkOpXWvW0nD9NkSNwscGHy2JUaWz6FWY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758825377; x=1759430177;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bv1I4Ic9wC08aXBbFZJljZdZZSbHg/OBO6m8rXTaTQA=;
        b=FmPfS10Hz+9rClWts8Ez2OBP8bwcpCIOXgIJBvJ0XVUxJ0QiBGBMsM/cacRCq6VqDg
         jXfCrFhcSuDnjyeAi2fzOa/6XD8tFU/zSVNBT3JUqI+C6DZEEzNS03nvx9lgrr7edM2m
         khUKa3QkTjQAl8bL88bL5I/pmeJ6DnxREirYh+NOqm2dbM6lx9OsNRcx6KFaK2V1NQLJ
         qcBqwP8tVgNfCQVCwFFcuFfHi0g4Bl6akxDKS63tK7R0ELroTVWXzULxasyQKAElgNWR
         NIWYv2Rt70AgHEum5wIPzMZXyNH2lbp1fhfKW0zUYjLniXtEieRac30OZ0sedU9k7Vbu
         LPFg==
X-Forwarded-Encrypted: i=1; AJvYcCVzI1wB6NQzLOYcFe1V4567nORDIwirGDI7J5FD65lwi0PteaVENN1F1OUF8KHrP69cdzBKybQk5g==@vger.kernel.org
X-Gm-Message-State: AOJu0YwJtNW871Wl+UQa/OszS2kqau/Tug9s02tqb36lWH15uYBDXdn3
	F5noipY7J0g9TumRDEgiYYlN+yfqdaFjvkj444u2AW6fhJlMbAISx7Nhe16NgBEH3A==
X-Gm-Gg: ASbGncsTQdaHtwWJKWamSd+XWs5aShoLazRsE72Trpi6crfOJnIbvM2CbUsqxItiQGl
	2GIhOgo2ghtPEZ6M2kFIUxck8UFC1snvzfWASo0/2uGIv+14K64UVTMqpVpEZZprz9Hrk55C5kF
	+BJWUITBPRk7gboTapky2Fl+cYadb3absvkveqSR4EwJmYlsI0xnFJX+uCfBD/Vgmp69AAUrt/u
	qiNHWyp3i9crvCL2tyhcA/B8Ea1gdPtYlRVs6fND4r8B7TJkSTK8odX7pPUrq8kiD9fk6WPTwnE
	Pu72Oe9WEa60Y9RV2NKey0VoJo4ZSY3Vnz5yacOY4kfcPfp2hLUGW5ZIfAzc083V1UQ9w6Lh/q4
	Z5GN/zIeFF/TMTNtf9V3vzyt+EK6+H33W8GtzC+odgjegNkym0fLpQhYbqQCg
X-Google-Smtp-Source: AGHT+IF4Y09r+bkOF6lRkbwV+GQ7Ev0ePJgiaG1Uy2xMtT1jRRDOL9DCdlnx7ksb5G87YR8/J7GrzQ==
X-Received: by 2002:a17:90b:3884:b0:32e:9a24:2dd4 with SMTP id 98e67ed59e1d1-3342a257202mr4886405a91.14.1758825377384;
        Thu, 25 Sep 2025 11:36:17 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:ef44:9df6:231a:cd29])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-b57c55a0ef3sm2756772a12.37.2025.09.25.11.36.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Sep 2025 11:36:16 -0700 (PDT)
Date: Thu, 25 Sep 2025 11:36:15 -0700
From: Brian Norris <briannorris@chromium.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Pavel Machek <pavel@kernel.org>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	kunit-dev@googlegroups.com, Len Brown <lenb@kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] PM: runtime: Add basic kunit tests for API contracts
Message-ID: <aNWLnxtxS1tqiqbC@google.com>
References: <20250829003319.2785282-1-briannorris@chromium.org>
 <CAJZ5v0gGKsR0bVayyTXy1W9FLwVfG1S+gseH7jPKtggzZFNpfA@mail.gmail.com>
 <aMHjOJGaKi9cwbsn@google.com>
 <CAJZ5v0iELLPYBS6FKmX=DhoyQ2tDq9F9DAzuV0A8etv0dGeJvQ@mail.gmail.com>
 <aNMWa0SD5l4Cb6G_@google.com>
 <CAJZ5v0jnPsVrULF9+S-e+HvT+bik=+WA7FfXzFg5vfO8WhTy9Q@mail.gmail.com>
 <CAJZ5v0i0_r_=rsPzLmST7cZtGjHCP73t9aoXdVFa81J9nJmzsQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0i0_r_=rsPzLmST7cZtGjHCP73t9aoXdVFa81J9nJmzsQ@mail.gmail.com>

On Wed, Sep 24, 2025 at 07:34:31PM +0200, Rafael J. Wysocki wrote:
> On Wed, Sep 24, 2025 at 7:32 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > On Tue, Sep 23, 2025 at 11:51 PM Brian Norris <briannorris@chromium.org> wrote:
> > > On Fri, Sep 19, 2025 at 06:58:50PM +0200, Rafael J. Wysocki wrote:
> > > > Yeah, so I'd prefer to change this particular thing entirely,
> > > > especially in the face of
> > > >
> > > > https://lore.kernel.org/linux-pm/5049058.31r3eYUQgx@rafael.j.wysocki/
> > > >
> > > > which quite obviously doesn't take the return value of
> > > > pm_runtime_put() and pm_runtime_put_sutosuspend() into account.
> > > >
> > > > I would like these two functions to be void.
> > >
> > > Sure, I think inspecting put() return codes is generally a bad idea.
> > > 'void' would be cool with me, although maybe a bit impractical now,
> > > considering how many users look at the current return code.
> >
> > For pm_runtime_put() it's not that bad.  I have ~20 patches changing
> > all of the code looking at its return value to stop doing that.
> >
> > Interestingly enough, there's only one piece of that code (USB core)
> > doing anything remotely useful with that return value.  Everything
> > else is just garbage IMV.
> >
> > > So at a minimum, I'd separate "make 'em void" from my "document and test the
> > > API" work.
> >
> > But you can just skip them.
> >
> > > Really, I'm mostly looking at this area because I have to support driver
> > > developers trying to learn how to use the runtime PM API, and they
> > > wonder about the return codes. So if they exist, I'd at least like them
> > > to make sense.
> >
> > Sure.
> >
> > That said, as far as pm_runtime_put() and pm_runtime_put_autosuspend()
> > are concerned, you may as well just say "discard their return values,
> > you don't want to have to deal with them, and never ever pass them
> > verbatim to the callers of your code".

Sounds reasonable.

I'll drop any unit test expectations for pm_runtime_put() and
pm_runtime_put_autosuspend() return codes. But I'll leave
pm_runtime_put_sync().

> > > Anyway, for the particulars of this test: I can try to adapt the comment
> > > language a bit. But are you suggesting I shouldn't even try patch 2,
> > > which fixes the pm_runtime_put() return codes?
> >
> > Not really.
> >
> > > > Of course, there are existing users that check their return values,
> > > > but I'm not sure how much of a real advantage from doing that is.
> >
> > Well, see above. :-)
> >
> > >  At least some of those users appear to not exactly know what they are
> > > doing.
> >
> > Almost none of them do nonsense.
> 
> s/none/all/ (sorry)

Ha, thanks for the clarification :)

Brian

