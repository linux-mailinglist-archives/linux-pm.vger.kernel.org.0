Return-Path: <linux-pm+bounces-30502-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8961FAFEF41
	for <lists+linux-pm@lfdr.de>; Wed,  9 Jul 2025 18:56:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C99F54A3BED
	for <lists+linux-pm@lfdr.de>; Wed,  9 Jul 2025 16:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ADD2221FC6;
	Wed,  9 Jul 2025 16:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U/UdVOQX"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306F61FBCB1;
	Wed,  9 Jul 2025 16:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752080160; cv=none; b=HoBmWiD2gSr5Nt9E7hCtvz34abOMCKPlUDPbjEukODDMqnXNjQf6dk9pYYSTPFE9U4Kmeo0gfDZgXmSliYdwuzXlGrCPDgnh36X9bnalNxUqPnCfmkELooCrOQcGZmPpQwFLJn/KmX2v/ZxSKps7KoZ1h092grvmzEW86exuNus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752080160; c=relaxed/simple;
	bh=s/nX8zIHBhz7UzymyaWsPZGQQ2RKaw+8h1/MMQwig60=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jXnsJ1qWQcbKJg+kTuCwgZlrs6xPF1dIPFypSZi0aPoFxkAuNGCsP16jEJUiEpAMCN6BuD1KJLt5EBOx82vWyR/1EHDBJrm94BJX0OwlzX7Lc2rfdb23KXCEgWf9j8AtJMh43TTLrOQRPRDJs3hkGgvQqqae0HLb22yIHIlLUus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U/UdVOQX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D228AC4AF09;
	Wed,  9 Jul 2025 16:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752080159;
	bh=s/nX8zIHBhz7UzymyaWsPZGQQ2RKaw+8h1/MMQwig60=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=U/UdVOQXVmJEsmdVD1AsBg5HBpSzOUI1TZShH/yMS15dEBsXh5s+bL0yo+mHEuheF
	 NOnoZrImJwF7we9U6+7ESNJhAyMuj6q0SVmPymnLHmAon+EebWOQuSyftxKIE3J3jg
	 f3HkXB7x61Bq4BgvxWKe4Fdsqxat+YPN2qr6h07ErO9iOL0FEcoku1BCfSnl9l2tsh
	 q4bxTS+v8pI68sL3lpCT/Bpwn7CobJpyV1PRSKrkVjMdMqVx7aYWqy4urXLnLVykaQ
	 1y0REjV4M/7UDXzYfF9KnMiKyLtOpGrA0Qw9bHkwnaal2fpuqhtg1kvcZPEG/teStJ
	 V4rRR2i9WyFPA==
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-2ef891cd058so71720fac.1;
        Wed, 09 Jul 2025 09:55:59 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUYxDBHtoKAIdyz5RIjZCC+KnBfr5Ck7yOa9u2ZXAvcoxc+27GMgKONWFPnrI2yVrIb4UW1CYoI@vger.kernel.org, AJvYcCWNQRDL5krIOs7a4maCTZyUtsdUWDjETeiljGNzFh82sMACcgzu6HNGVsgylCv2s7mwVGJmJE+sKg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwFGUB4dE9FZIg97QOcnPR2+vphca2LGLz9emLJQjL1Zs6Thy5s
	NfT05/J4RPhSnIrTAylEIrR4PlrEW1/D9Nwbb8L8uSSOBRyLVG23qvfbAd+6lHdw9y1rm1ngAVx
	5iA+sEifUAMqT/lrVhn9rL6T/zZAnU/Y=
X-Google-Smtp-Source: AGHT+IHxv3XyTmAE7BWnt5snY9w8QZkCASN2KwEpMUnGi9WrPdGJGGZnolR2Q0GJi5QXAyrvQ+bxSShfBvGLYf4yfn0=
X-Received: by 2002:a05:6871:2b1c:b0:2b8:e4b9:47a3 with SMTP id
 586e51a60fabf-2fef871c3e8mr2134957fac.22.1752080158987; Wed, 09 Jul 2025
 09:55:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250708000215.793090-1-sashal@kernel.org> <20250708000215.793090-6-sashal@kernel.org>
 <87ms9esclp.fsf@email.froward.int.ebiederm.org> <aG2AcbhWmFwaHT6C@lappy>
 <87tt3mqrtg.fsf@email.froward.int.ebiederm.org> <aG2bAMGrDDSvOhbl@lappy>
 <87ms9dpc3b.fsf@email.froward.int.ebiederm.org> <29441021-5758-4565-b120-e9713c58f6d8@amd.com>
In-Reply-To: <29441021-5758-4565-b120-e9713c58f6d8@amd.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 9 Jul 2025 18:55:47 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gWD+pnkhWbW0ZF8+5PYxX6qRbeNoRuVo=CpwmMMLFjDg@mail.gmail.com>
X-Gm-Features: Ac12FXx_bufmZGZgpHOzEG3RZctbXShNv4NKhZDCMLVWf0RX27NUB7NRU_usyCE
Message-ID: <CAJZ5v0gWD+pnkhWbW0ZF8+5PYxX6qRbeNoRuVo=CpwmMMLFjDg@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 6.15 6/8] PM: Restrict swap use to later in the
 suspend sequence
To: Mario Limonciello <mario.limonciello@amd.com>, Sasha Levin <sashal@kernel.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, patches@lists.linux.dev, stable@vger.kernel.org, 
	Nat Wittstock <nat@fardog.io>, Lucian Langa <lucilanga@7pot.org>, 
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, rafael@kernel.org, pavel@ucw.cz, 
	len.brown@intel.com, linux-pm@vger.kernel.org, kexec@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 9, 2025 at 6:35=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> On 7/9/2025 12:23 PM, Eric W. Biederman wrote:
> > Sasha Levin <sashal@kernel.org> writes:
> >
> >> On Tue, Jul 08, 2025 at 04:46:19PM -0500, Eric W. Biederman wrote:
> >>> Sasha Levin <sashal@kernel.org> writes:
> >>>
> >>>> On Tue, Jul 08, 2025 at 02:32:02PM -0500, Eric W. Biederman wrote:
> >>>>>
> >>>>> Wow!
> >>>>>
> >>>>> Sasha I think an impersonator has gotten into your account, and
> >>>>> is just making nonsense up.
> >>>>
> >>>> https://lore.kernel.org/all/aDXQaq-bq5BMMlce@lappy/
> >>>
> >>> It is nice it is giving explanations for it's backporting decisions.
> >>>
> >>> It would be nicer if those explanations were clearly marked as
> >>> coming from a non-human agent, and did not read like a human being
> >>> impatient for a patch to be backported.
> >>
> >> Thats a fair point. I'll add "LLM Analysis:" before the explanation to
> >> future patches.
> >>
> >>> Further the machine given explanations were clearly wrong.  Do you ha=
ve
> >>> plans to do anything about that?  Using very incorrect justifications
> >>> for backporting patches is scary.
> >>
> >> Just like in the past 8 years where AUTOSEL ran without any explanatio=
n
> >> whatsoever, the patches are manually reviewed and tested prior to bein=
g
> >> included in the stable tree.
> >
> > I believe there is some testing done.  However for a lot of what I see
> > go by I would be strongly surprised if there is actually much manual
> > review.
> >
> > I expect there is a lot of the changes are simply ignored after a quick
> > glance because people don't know what is going on, or they are of too
> > little consequence to spend time on.
> >
> >> I don't make a point to go back and correct the justification, it's
> >> there more to give some idea as to why this patch was marked for
> >> review and may be completely bogus (in which case I'll drop the patch)=
.
> >>
> >> For that matter, I'd often look at the explanation only if I don't ful=
ly
> >> understand why a certain patch was selected. Most often I just use it =
as
> >> a "Yes/No" signal.
> >>
> >> In this instance I honestly haven't read the LLM explanation. I agree
> >> with you that the explanation is flawed, but the patch clearly fixes a
> >> problem:
> >>
> >>      "On AMD dGPUs this can lead to failed suspends under memory
> >>      pressure situations as all VRAM must be evicted to system memory
> >>      or swap."
> >>
> >> So it was included in the AUTOSEL patchset.
> >
> >
> >> Do you have an objection to this patch being included in -stable? So f=
ar
> >> your concerns were about the LLM explanation rather than actual patch.
> >
> > Several objections.
> > - The explanation was clearly bogus.
> > - The maintainer takes alarm.
> > - The patch while small, is not simple and not obviously correct.
> > - The patch has not been thoroughly tested.
> >
> > I object because the code does not appear to have been well tested
> > outside of the realm of fixing the issue.
> >
> > There is no indication that the kexec code path has ever been exercised=
.
> >
> > So this appears to be one of those changes that was merged under
> > the banner of "Let's see if this causes a regression".>
> > To the original authors.  I would have appreciated it being a little
> > more clearly called out in the change description that this came in
> > under "Let's see if this causes a regression".
> >
>
> As the original author of this patch I don't feel this patch is any
> different than any other patch in that regard.
> I don't write in a commit message the expected risk of a patch.
>
> There are always people that find interesting ways to exercise it and
> they could find problems that I didn't envision.
>
> > Such changes should not be backported automatically.  They should be
> > backported with care after the have seen much more usage/testing of
> > the kernel they were merged into.  Probably after a kernel release or
> > so.  This is something that can take some actual judgment to decide,
> > when a backport is reasonable.
>
> TBH - I didn't include stable in the commit message with the intent that
> after this baked a cycle or so that we could bring it back later if
> AUTOSEL hadn't picked it up by then.

I actually see an issue in this patch that I have overlooked
previously, so Sasha and "stable" folks - please drop this one.

Namely, the change in dpm_resume_end() is going too far.

> It's a real issue people have complained about for years that is
> non-obvious where the root cause is.
>
> Once we're all confident on this I'd love to discuss bringing it back
> even further to LTS kernels if it's viable.

Sure.

