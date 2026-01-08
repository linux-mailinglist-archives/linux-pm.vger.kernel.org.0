Return-Path: <linux-pm+bounces-40480-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A630D044CD
	for <lists+linux-pm@lfdr.de>; Thu, 08 Jan 2026 17:21:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2962732E82C3
	for <lists+linux-pm@lfdr.de>; Thu,  8 Jan 2026 15:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45F8D24EF8C;
	Thu,  8 Jan 2026 15:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EX+9HNYj"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23450248F68
	for <linux-pm@vger.kernel.org>; Thu,  8 Jan 2026 15:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767887643; cv=none; b=dbYU7VX1XcVNgNw3fneq1pOo8zmk0Am73GmOrVUyW77qKN7T7ZuJ3bWRumWNfGHAAMMzBaHHE+mE0ayJ3PHCDSI3XVE4ql4EUXJO9An+Cgj9Zw8SXmibV4e9z6WwelbVb/aDXfm3sH5yqQe9h+tuOEh2AnF2+EcSIVfF9mSRR/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767887643; c=relaxed/simple;
	bh=icF2Ycts9XtujqX5M3NJLoNCbL5jHViZBSxw22k4EwY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nz0JtvtEvGZTS70U7UVmiM6oJeK14gHsdltMshHRFvps92UILBAIjhS+nTW/UtqAsIAlWbClak0gjm9ck2u3ZJCcQTvohocjya4J8b6IyapqHR2/aS//VxkARLAHCRrw/63WkNooKfU2be8VtARdB7IiAc5Z3GBvbxoNcBC4CMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EX+9HNYj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1C41C116C6
	for <linux-pm@vger.kernel.org>; Thu,  8 Jan 2026 15:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767887642;
	bh=icF2Ycts9XtujqX5M3NJLoNCbL5jHViZBSxw22k4EwY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=EX+9HNYjf9snlSmGNjWMGCCDgcZvicMLFjTdR36hInhe2jb2l69Upq0JdCQx8HDw1
	 ii34Mkl9irZEApmDQUTxcZnyZo3KaHZTt6pYLqCLhFhvR2kRUK72p6n55qAsa0HFe3
	 NItZrxPQ3Zogi+KE+vrjeU5YPDKaBWFBUxSSUlSrmmHzd3IIVOgKwsD+rqCkRIFO7h
	 Kf8cFgIxF/n0sv5LkuJei10gQPelVGGhWEId2dalOnaFkxwkvdXPN4uilZpKKiXjDj
	 TVmFAukOF6Mal9/xLqLUUqPSsmJK2Tj4e5PhZ3Q6GMupGZllpMfwbSvDfPL2Xd9M01
	 Se4ErlK0VKu+Q==
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7c750b10e14so1454437a34.2
        for <linux-pm@vger.kernel.org>; Thu, 08 Jan 2026 07:54:02 -0800 (PST)
X-Gm-Message-State: AOJu0YwpR5ktmJpdAd7LEJX3tlKayZxXVqNNxGVcIwDhrOXvkGYuzc+h
	FQ4pWjLyABaw3cIFEMW1fI7RGwnYKkJ+L4xIEmawYPhhMKyqolYvPhQhkH6x9P6PejQ4dgVKL7D
	YeVx0IRPxwA1yDTBP92B9X5fh9lV+SBo=
X-Google-Smtp-Source: AGHT+IF82WTTsmHsmU7K5OOZAoxss+6Rx8OOyWi3bIClaM2WO5Qd3/aF/CETtF9CBwk3MfcXJ2A/yFfx60V647uBoY0=
X-Received: by 2002:a05:6830:2645:b0:7c5:31b6:435c with SMTP id
 46e09a7af769-7ce50bf0b1emr3132298a34.29.1767887641814; Thu, 08 Jan 2026
 07:54:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251230061534.816894-1-tianyaxiong@kylinos.cn> <d5ee5e5b-d636-47c7-83e6-b58cab9f4d6e@arm.com>
In-Reply-To: <d5ee5e5b-d636-47c7-83e6-b58cab9f4d6e@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 8 Jan 2026 16:53:51 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jJqMcG43S_rmFC6S3DRM9+x9m8wx7YdEkuUWGpohBw_g@mail.gmail.com>
X-Gm-Features: AQt7F2r2cbBICiSQZAX_GCFSrCrQmBH4n3aap4b-cRfH3NGIwQynKOBBvsuWRxo
Message-ID: <CAJZ5v0jJqMcG43S_rmFC6S3DRM9+x9m8wx7YdEkuUWGpohBw_g@mail.gmail.com>
Subject: Re: [PATCH 1/2] PM: EM: Fix incorrect description of the cost field
 in struct em_perf_state
To: Lukasz Luba <lukasz.luba@arm.com>, Yaxiong Tian <tianyaxiong@kylinos.cn>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 30, 2025 at 10:36=E2=80=AFAM Lukasz Luba <lukasz.luba@arm.com> =
wrote:
>
>
>
> On 12/30/25 06:15, Yaxiong Tian wrote:
> > Due to commit 1b600da51073 ("PM: EM: Optimize em_cpu_energy() and remov=
e
> > division"), the logic for energy consumption calculation has been modif=
ied.
> > The actual calculation of cost is 10 * power * max_frequency / frequenc=
y
> > instead of power * max_frequency / frequency.
> >
> > Therefore, the comment for cost has been updated to reflect the correct
> > content.
> >
> > Signed-off-by: Yaxiong Tian <tianyaxiong@kylinos.cn>
> > ---
> >   include/linux/energy_model.h | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/include/linux/energy_model.h b/include/linux/energy_model.=
h
> > index 43aa6153dc57..e7497f804644 100644
> > --- a/include/linux/energy_model.h
> > +++ b/include/linux/energy_model.h
> > @@ -18,7 +18,7 @@
> >    * @power:  The power consumed at this level (by 1 CPU or by a regist=
ered
> >    *          device). It can be a total power: static and dynamic.
> >    * @cost:   The cost coefficient associated with this level, used dur=
ing
> > - *           energy calculation. Equal to: power * max_frequency / fre=
quency
> > + *           energy calculation. Equal to: 10 * power * max_frequency =
/ frequency
> >    * @flags:  see "em_perf_state flags" description below.
> >    */
> >   struct em_perf_state {
>
> Good catch, thank you!
>
> Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

Applied as 6.19-rc material, thanks!

