Return-Path: <linux-pm+bounces-34953-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87F2BB83F5A
	for <lists+linux-pm@lfdr.de>; Thu, 18 Sep 2025 12:05:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C37811C0522B
	for <lists+linux-pm@lfdr.de>; Thu, 18 Sep 2025 10:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 979CD2475D0;
	Thu, 18 Sep 2025 10:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A3mlRpTa"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7274427726
	for <linux-pm@vger.kernel.org>; Thu, 18 Sep 2025 10:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758189927; cv=none; b=MbC2GQMpjDCkC7QJOVE1v1Ow0Aip1d3pn9FKNNKJtfj76j5xX1dnA0Kyhpl+7lWC1O3EZqBAw2lUsmI2XiO6+PNPA9TKXnz/gJ5sySd+NlszK4y4sKWd14rKdJhoEbePiqHh/GHLKgSKkGuIGbbpEKztkLS41NLGmBiSlLApD6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758189927; c=relaxed/simple;
	bh=yHZg7E3K6d2YcLik+EA4wtgpp4DJ5xBkllPVHjfBqMQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JSkoRbBfslHqPLO8A0G2u3v3bO/Oi7mb4VA5StYyDxfb1j/YHcjBzz1tCCT905XCzLS16CT0xyWXAluayXMUdJ1q87lxPTyy6b+73PX4tD8nKEgDospis+c5/8e7hbCOszVeDW62Gbw/pE1WQZdhonSiAkjKefpNDH26bKkqArY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A3mlRpTa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FEE4C4CEFC
	for <linux-pm@vger.kernel.org>; Thu, 18 Sep 2025 10:05:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758189927;
	bh=yHZg7E3K6d2YcLik+EA4wtgpp4DJ5xBkllPVHjfBqMQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=A3mlRpTa7oEOUbgua0nsSo703yUbq9YO88eQ7cDMKuGM9sQs/GiY+CcaLRoeLdj7i
	 T4CHrvr19uKPHsVFjfRormVLGiuogt5c5gPXz0fUQffseoHN7j7jzvydx9L9EZeetG
	 nyoPJGklIkc/8dJ7lRNc7HyiQFTKOXVBP4bvSG/cE2nnj6jZdoP3Il8dXXeMEmVr15
	 RMXw3WEgf+NjSSUHqYOZ8CnYEzqa3llX8cQwmHja4JzVre2fuDZQ9rZ7AfPS6BZbs3
	 qamilhIJpDSXByqsFgyEP7EoB4Uu9F52UL7DtMhdPx7EBOEeHepgoSE7TPW5CdJ9rA
	 FIjVCdCHSHuFA==
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-74a61973bedso706634a34.0
        for <linux-pm@vger.kernel.org>; Thu, 18 Sep 2025 03:05:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV8724w19LIVOW/aBf+zr3UK1/EylEbbnTklyxTLftVa+OW111MvfdOC02Y0TEV7V5sQ6GRmIAgTw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxP90YQDjVZ3hSE/jNFxqJd1I0mHJ5G4leZLxY2lAIz7r3WPTZF
	K4/8VLFeyetYo8FZcSH08PtIQ4aWG0S8/+w/3a0g853Blan1KC9kGPPpYx5PXQXN9x4hI0kPBsu
	smk5eBnSmhUIo2/eJP9b+d6CvTz+88go=
X-Google-Smtp-Source: AGHT+IEPe+INRvhVzC1m5Sod1iKYNWcSFjc9f+McH5EIIs/1IuJG8CQVjUjpp0g11hyYud3XkLCARtsEo3f9zFkVRf0=
X-Received: by 2002:a05:6830:2b0d:b0:75a:ae3b:777a with SMTP id
 46e09a7af769-76313356781mr2903315a34.10.1758189926614; Thu, 18 Sep 2025
 03:05:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6191405.lOV4Wx5bFT@rafael.j.wysocki> <CAJZ5v0gEh-xoKdgAgUvnGzPV6AO51=ZagHXNCrC4BfRZk6Oydw@mail.gmail.com>
 <87h5x088mt.ffs@tglx>
In-Reply-To: <87h5x088mt.ffs@tglx>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 18 Sep 2025 12:05:14 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0h1DgQ2xWSEXjbiwAUES4DMKL8S+B5+ed9muWTwsfeNsA@mail.gmail.com>
X-Gm-Features: AS18NWAe_B-yQRdSp9aaQCx6krlTCfTW0SQdDJGiiMl9Szo-23iKagiwZkerVDg
Message-ID: <CAJZ5v0h1DgQ2xWSEXjbiwAUES4DMKL8S+B5+ed9muWTwsfeNsA@mail.gmail.com>
Subject: Re: [PATCH v1] smp: Fix up and expand the smp_call_function_many() kerneldoc
To: Thomas Gleixner <tglx@linutronix.de>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Linux PM <linux-pm@vger.kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 18, 2025 at 10:31=E2=80=AFAM Thomas Gleixner <tglx@linutronix.d=
e> wrote:
>
> On Tue, Sep 16 2025 at 16:13, Rafael J. Wysocki wrote:
>
> > On Tue, Sep 9, 2025 at 1:44=E2=80=AFPM Rafael J. Wysocki <rafael@kernel=
.org> wrote:
> >>
> >> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >>
> >> The smp_call_function_many() kerneldoc comment got out of sync with th=
e
> >> function definition (bool parameter "wait" is incorrectly described as=
 a
> >> bitmask in it), so fix it up by copying the "wait" description from th=
e
> >> smp_call_function() kerneldoc and add information regarding the handli=
ng
> >> of the local CPU to it.
> >>
> >> Fixes: 49b3bd213a9f ("smp: Fix all kernel-doc warnings")
> >> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > It's been a week and no feedback.
> >
> > Well, in the further absence of any, I'll assume no concerns and just
> > queue this up.
>
> Sorry, was distracted. No objections from my side. Did you queue it
> already?

No, I didn't.

