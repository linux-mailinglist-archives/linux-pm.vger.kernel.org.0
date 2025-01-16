Return-Path: <linux-pm+bounces-20580-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09FB1A14226
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jan 2025 20:18:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E91E3A97B5
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jan 2025 19:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 102CE1DE894;
	Thu, 16 Jan 2025 19:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xx9BVE+9"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB8432770B;
	Thu, 16 Jan 2025 19:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737055113; cv=none; b=Ctk4Fztczzd9W7ZRu78MV11jrEhuWfsQHGrCoKORKh9G+vcGzSd8GZNRAjueQBGdYHkCvrHlYFqAevzOJv9ywc4wAdE4AtwSgyqQj7t/Nkccb2F9oeTBU6/QAk7lv1GGHHfjPInb/KRY1HWU17QIUbOlD0UpYCnLF+eYG55cApo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737055113; c=relaxed/simple;
	bh=qkVzc8ntZGU3vcsiv66aD1p3e+2jfB8xq5Gsl2THvWY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fKtLp/YpQx3uLUk80Fo7ucmyFXqQiHuMtXk98Bac8H2e7+vdqSfeN4x0HFsFbzXvThBwNXTwhXs9JoWC/MZxi3hveAiPBqgI66T3VOUWWKcQZFnMpZXn8nWSr4em1Q9DZmJ7RxbPdlYWWUfQCbEz/hjyNNrTWmwK1FdtDV/YlwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xx9BVE+9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73E92C4CEE3;
	Thu, 16 Jan 2025 19:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737055111;
	bh=qkVzc8ntZGU3vcsiv66aD1p3e+2jfB8xq5Gsl2THvWY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Xx9BVE+9Ht3pO0aovRKVw0blbojDAVIWL8vvMBAUHuYyVuaQ92JlbqOAppzKdeL9T
	 Pw42zcsJTGniHyVnZl5ueeDFBByM8ZTA8QshLonLzkVYQu00PhnpAAe0eXm5CyqlIH
	 K8WpoYQiXPDSVnsxcHXUvuKWqqVJ1lCKTSgloeK2Y7rEub/7WIOmyra1TviIfQceu+
	 MibarO3KuanmjSvVMOPLVZ8s/LAZ7di2QmX2zMuA+BTOR9yrhTWdxenv0M/st7ZjkE
	 hquyqri9jRX/NUds8PbK28sht4W5WghKbaB3Bo6zBgFekGi8JrJ0hKIPcgbLfDNoUn
	 IrfzG+a5SeGTA==
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3eb98b3b63dso485886b6e.1;
        Thu, 16 Jan 2025 11:18:31 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUQhU2QwBJb+3IEMYx6kwJA7dwPlCHHLBCgwirmturR1Gy6gyWDVte418OdOD9C/G9v0BdvSxT2v6k=@vger.kernel.org, AJvYcCVlPjCowDd1nEb4Wnle49J1lP/NoAOCPgreui9VZUu3SVd7C7zJuj5CFPkPRatBRvkbfz6iLdYcwWGKRW0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzom2CJMSmQVWmurVjudXAJuqWxC9M1K133L3NalOOkTm3NOp1g
	AcQuThF/X0NSL+HjWfA86GtcYW5GL32qRWCRjxSz0zWWUr2Mh9P3Tkk0J39/jkKMnsB/dmlD7wh
	2WqaYi95ZNsAzlNZlhcUv0TAg6zg=
X-Google-Smtp-Source: AGHT+IE9PvKYvkWWn2tqEsp2nVqCGz0MO9AJ/HMuwld1RL7gfp+yEXSqF+iOojaFmVSQ1iVZYSPsOB1IMemuY+8yc4c=
X-Received: by 2002:a05:6808:3386:b0:3e7:ad4c:e856 with SMTP id
 5614622812f47-3ef2ee26544mr21373080b6e.35.1737055110718; Thu, 16 Jan 2025
 11:18:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250116154354.149297-1-andriy.shevchenko@linux.intel.com>
 <CAJZ5v0izBnSGjmjO7T+_gEhrSib0==_bRXnsLEdzEjbH0cZDqg@mail.gmail.com>
 <Z4kwK6JCm5RDI4nG@smile.fi.intel.com> <CAJZ5v0jdqtyF_Prf6TETwaLJ3Cr3sK4rFnU68C5ioqKq8OF02A@mail.gmail.com>
 <Z4k0zGk83gtilO0n@smile.fi.intel.com>
In-Reply-To: <Z4k0zGk83gtilO0n@smile.fi.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 16 Jan 2025 20:18:19 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0iJPHPE9pJx2VTz5OwinwyLPD=H3SQJGViyt4_9uAgwNA@mail.gmail.com>
X-Gm-Features: AbW1kvYt-mBp0uJvYxmE5y9je6yCGOqZSZDn1uHN44rTndja7N5nwPnsUOYZswo
Message-ID: <CAJZ5v0iJPHPE9pJx2VTz5OwinwyLPD=H3SQJGViyt4_9uAgwNA@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] PM: Revert "Add EXPORT macros for exporting PM functions"
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>, 
	Pavel Machek <pavel@ucw.cz>, Richard Fitzgerald <rf@opensource.cirrus.com>, 
	Adrian Hunter <adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 16, 2025 at 5:33=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Thu, Jan 16, 2025 at 05:27:59PM +0100, Rafael J. Wysocki wrote:
> > On Thu, Jan 16, 2025 at 5:13=E2=80=AFPM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > > On Thu, Jan 16, 2025 at 05:09:29PM +0100, Rafael J. Wysocki wrote:
> > > > On Thu, Jan 16, 2025 at 4:44=E2=80=AFPM Andy Shevchenko
> > > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > >
> > > > > The introduced macros are not doing what they intend for, namely
> > > > > they won't eliminate the code when CONFIG_PM=3Dn.
> > > >
> > > > I don't think they have ever been expected to eliminate the code th=
en.
> > > > They just don't export the symbols in that case.
> > >
> > > Then I'm really puzzled with (potential) usefulness of them to begin =
with.
> > > Having a dead code that is not exported is doubtful benefit.
> >
> > Arguably, exported dead code is even worse.
> >
> > Anyway, it is hard to say what they are good for if there are no users.
> >
> > My point really is that you don't need to add anything beyond "this
> > stuff has no users" to get it removed and arguing about what the
> > unused stuff was intended for is not very useful so to speak.
>
> I see. Shall I send a v3 with the reduced commit message?

It's there in my queue and I can take care of the changelog, so no need.

Thanks!

