Return-Path: <linux-pm+bounces-20895-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D2B5BA1AB1E
	for <lists+linux-pm@lfdr.de>; Thu, 23 Jan 2025 21:23:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC4BA188E347
	for <lists+linux-pm@lfdr.de>; Thu, 23 Jan 2025 20:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2DFB1BD9E5;
	Thu, 23 Jan 2025 20:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F2HTLWdr"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87DD51BBBCF;
	Thu, 23 Jan 2025 20:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737663794; cv=none; b=GU2Y8hT5WqAvWBRGL1tFM5du/QxWacoBvP6wM7CqniKgTPIZevUSe9sQcRqWLThtpC5LCFAbfcsvvcvYUruegSOe0uGsK7DCr+R/AYt7/7WD+wK+9YziSJ3khZD0Mv2bIUpS/vzI4Gn4H8ZbRQz47Yce599ERRdQ2aX4fxVzBwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737663794; c=relaxed/simple;
	bh=/o3pzg47qzK2DuVov2Rd5ZbRyGQiTF3K8gIMnIKed8g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FB3d7V6YF7UpmZjRV8y106ysN/g7wOQGV1cCVEh16I5gKRU85vdB2MOenkmFbjWMpMfVkNQv1/UX+rTHtLpRGzgRpkL37UMaugquMGpnGiOgsdTvs2OBtlzZsp5MTReUG3XtWcl9gzYd/CkOWzsiWbLVIg9fMlLz5V3OOSp9UHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F2HTLWdr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2154C4CEE2;
	Thu, 23 Jan 2025 20:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737663793;
	bh=/o3pzg47qzK2DuVov2Rd5ZbRyGQiTF3K8gIMnIKed8g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=F2HTLWdrfD/Dj2M9gtcqW0oTQcTMPwFMIH+ngZ2jwbs5HEPP5d6zr7NkTHiF0H2QZ
	 gYEAzElLn5AwEe3pa3CMnqIZKBv3JmM7VNt79GUPEEHqZTI7Y4Bt1ovgSThNIle4nW
	 mmphlDBPYrMo4ENQatQfmUCUmDo4C8CK84dLNGWo99bTCDtlaXcO4hRJRpjXMcsdiV
	 G5EeBbbKh4SSnDaAIE6ChNo06Tj2JCDNqCnh4YbDIhbr1ROwRrgWp9HjX+R8Mq4DwE
	 SXTphUSK3LbmyKrOJnuPZpYjqBbq+TKSEXr7BSSnBnbgqRjrf5VCI+WTL7NTd4Cj0/
	 M75L/jzKj6M3Q==
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-2a3c075ddb6so729651fac.2;
        Thu, 23 Jan 2025 12:23:13 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUz5QPuBxtQLldQPZ3vKUpwln3/ZFEYr0j31i0XFJSEU/7R0Y7OfSV6Wilt6EYIUIM1De6X/DeSue5uyoQ=@vger.kernel.org, AJvYcCV0eYmPWTUkZ7iGcUGHRs5YbAfmCVFpc4PBFjLcr9gdbO7nLRs6xaOhq4lSSQ02XqRZMdlrc1j9Gjw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwD3UkADkrm7nfDcpD9L1Y4aYnmjcyEGg8pGstD/9JnuEszn0Ue
	MWVWOmNOEKPI62Pwtf7aQKTCVPTwEBb1ekwk4ybeGptmW2rNImWnMTM1WLEe8sfRpm7xFQPJEG+
	fBZyVcWwtHXl89gT5MfvygR5w1u8=
X-Google-Smtp-Source: AGHT+IGKBCFNRqK20+/uCHxzPlOteqKRHon1vQEvXJCMrN40Z9vh7642R2XNpWCjBVhAimooCET0CCY49DYlPj1Y1zU=
X-Received: by 2002:a05:6871:a4c9:b0:277:caf7:3631 with SMTP id
 586e51a60fabf-2b1c08466bfmr17108997fac.5.1737663793108; Thu, 23 Jan 2025
 12:23:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250116154354.149297-1-andriy.shevchenko@linux.intel.com>
 <CAJZ5v0izBnSGjmjO7T+_gEhrSib0==_bRXnsLEdzEjbH0cZDqg@mail.gmail.com>
 <Z4kwK6JCm5RDI4nG@smile.fi.intel.com> <CAJZ5v0jdqtyF_Prf6TETwaLJ3Cr3sK4rFnU68C5ioqKq8OF02A@mail.gmail.com>
 <Z4k0zGk83gtilO0n@smile.fi.intel.com> <CAJZ5v0iJPHPE9pJx2VTz5OwinwyLPD=H3SQJGViyt4_9uAgwNA@mail.gmail.com>
 <Z4pdh4LNSOzkatoi@smile.fi.intel.com>
In-Reply-To: <Z4pdh4LNSOzkatoi@smile.fi.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 23 Jan 2025 21:23:02 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0ihURJTjYNhzmxa4gtz0giRUfNGgR4p9kys0zHfXAQY=Q@mail.gmail.com>
X-Gm-Features: AWEUYZllU_ou3rfSTNQPYbiFmSXRzLpAX7PTHras34vfIgZ-eKv-zR0EMvncixY
Message-ID: <CAJZ5v0ihURJTjYNhzmxa4gtz0giRUfNGgR4p9kys0zHfXAQY=Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] PM: Revert "Add EXPORT macros for exporting PM functions"
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>, 
	Pavel Machek <pavel@ucw.cz>, Richard Fitzgerald <rf@opensource.cirrus.com>, 
	Adrian Hunter <adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 17, 2025 at 2:39=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Thu, Jan 16, 2025 at 08:18:19PM +0100, Rafael J. Wysocki wrote:
> > On Thu, Jan 16, 2025 at 5:33=E2=80=AFPM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > > On Thu, Jan 16, 2025 at 05:27:59PM +0100, Rafael J. Wysocki wrote:
> > > > On Thu, Jan 16, 2025 at 5:13=E2=80=AFPM Andy Shevchenko
> > > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > > On Thu, Jan 16, 2025 at 05:09:29PM +0100, Rafael J. Wysocki wrote=
:
> > > > > > On Thu, Jan 16, 2025 at 4:44=E2=80=AFPM Andy Shevchenko
> > > > > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > > > >
> > > > > > > The introduced macros are not doing what they intend for, nam=
ely
> > > > > > > they won't eliminate the code when CONFIG_PM=3Dn.
> > > > > >
> > > > > > I don't think they have ever been expected to eliminate the cod=
e then.
> > > > > > They just don't export the symbols in that case.
> > > > >
> > > > > Then I'm really puzzled with (potential) usefulness of them to be=
gin with.
> > > > > Having a dead code that is not exported is doubtful benefit.
> > > >
> > > > Arguably, exported dead code is even worse.
> > > >
> > > > Anyway, it is hard to say what they are good for if there are no us=
ers.
> > > >
> > > > My point really is that you don't need to add anything beyond "this
> > > > stuff has no users" to get it removed and arguing about what the
> > > > unused stuff was intended for is not very useful so to speak.
> > >
> > > I see. Shall I send a v3 with the reduced commit message?
> >
> > It's there in my queue and I can take care of the changelog, so no need=
.
>
> Ah, thanks!

Applied now, thanks!

