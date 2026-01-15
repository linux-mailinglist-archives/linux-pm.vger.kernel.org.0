Return-Path: <linux-pm+bounces-40937-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BEE49D25492
	for <lists+linux-pm@lfdr.de>; Thu, 15 Jan 2026 16:23:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1C44B3008DD1
	for <lists+linux-pm@lfdr.de>; Thu, 15 Jan 2026 15:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D37EF3B5311;
	Thu, 15 Jan 2026 15:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K0fVGP5f"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A3173B8D4E
	for <linux-pm@vger.kernel.org>; Thu, 15 Jan 2026 15:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768490513; cv=none; b=nsa/3/DEQIgl01opiL78mEO3u1FNd+CihWKyrKLzbqQkaa8DibAavGNlpvU52DgB8/KC8KtSREplDPgYFlt6OjjItRijY4HfCNI2EmvhLAgv+214FxMU4cXvLSxHOQzDsIiO/DaEdv7D4vjnQrtLsqi20uJhmqSEV9iqCtI+2SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768490513; c=relaxed/simple;
	bh=3mrmeybuzh9PgQXyTEyKUo1q9SHk4JU+LnlVDAEkQ6w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pnwzwENS/EMwG14rSWWukGxQe5fmr5Ox8lI07LrzoxbvFcgn2L5gl4XGqjDS30NWUVLhn+hUuTWtit0lb01KjVO05Q0nnqCukjI4BrRbdMnmo5qU0up1qQ/5vl40Yk0oLNfGyNHKk+6rgYP+U5G72d6BI4wS85dEYPid/pNeNNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K0fVGP5f; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-bd1ce1b35e7so659144a12.0
        for <linux-pm@vger.kernel.org>; Thu, 15 Jan 2026 07:21:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768490502; x=1769095302; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zFSOPl7QH14MMJkmhVI069FeYyKLf5eLmECuhHyuPZw=;
        b=K0fVGP5fj5vxPZHXuasjkrdrRkraXzVwrMEbO9lFSWUSnfm5l/LI9JMihaNDywvLtK
         BnZeCFkQBk4O1jNA47dDKetuVsbHlZkkDo+6fKVOa/Y81zKMEfuLUjOtFO/8MJ5vDbGH
         oY2PnpYaPPsetgFqZVxh1mfAGq8ph0drDaZPoQhhtmM4w+xSW4PyAXQcgoVJqFJK6kC+
         OaVmi1rgoC7z3Stq1if/m5osCmfVdkYkF2tKb2fYuLutzIDeDoFdQv1aKSHPOP6gP/VT
         S9nVGZc3If2qN1V41pvJv3epeTKmA6OVc3u+5DeKVGllslGeDrR9bNSOcl3RVxlntLme
         JjjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768490502; x=1769095302;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zFSOPl7QH14MMJkmhVI069FeYyKLf5eLmECuhHyuPZw=;
        b=RhPolNBKNtqQ9l1FwdErSO1mcEMTAaYKnxDkbvdhe8n/QkHRoVPG/TaWreTlWbCUNK
         8lFcPxOmIjBRoFEyuBT4lAHh+HlC25KkvXxy++Hxwq5yw7GFa8m76G9H9B/5deiqihPV
         Vu1zYwa3Pg8T9aQetaoaxfXuQAqsyRljVZrKLK7BxgnS5nKbegkAEnix6udGToiS61Zd
         f8qHAcAX7MasRobJajQ7PWYhJLnoYC5iYnmoDFjL0cIHl8Ve8OwlcJ277bV2RyGgrUEM
         fjtUo4OcBGVnKE/zvKSNnARYDkVp1YPjcYCrMSmuT2NC+H//12ewMoW6opAhSd1t5HUV
         1a4A==
X-Forwarded-Encrypted: i=1; AJvYcCXYob9O72BGShnXLYDcb6YmLVuWDGsLI4/BUqTdPiqX+J2/Q3VrTR0M7tK0cTuif7lBnmK/AHtCUQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyxmxHTX7EodCOCGRbrDncIOOuweubfklET/hoxnUML16A0XVU7
	cF1xM1kOsgNihCe+4SAfUy+y7M8EOKeSYYNyGi6uN0kSJ2eS958HDC78
X-Gm-Gg: AY/fxX7DmAz2v3x9NLPsgZsbbd2OAbsooGmPl7a5WsuvIcFty0MKKZ4qMijwyDlSeOP
	wDB2VgTkla7jky8RihaSXO7COxU4yjRqBfSerZJrgMyBG4FmcJSyQxvnCvdyaSQxahP2HSaPFsO
	CK0sRaXWM7ZsblcGJ+CsyYmsVQX2/LAFobz2Wjy1PFObpZ1mGIZmxX9jrkPenmGxV9VPnACbeaI
	kJL1uRmqp8wavlAnlk1zcwTZ4dDX2z2g7LT///SY63K5lvgLZ4vjEFuqwPpEr16YALPmOnS0Mwc
	slwjF8csSthLs08tovmQlSJkBfhuKCCSDCAltFntv883+JL/THa5itiN7xqWHQnAbagP3bwwOzp
	o8bTpYlLa06q0QpFI4shhI0PHgBn6Kvd8/QC9hMHwN+NwO2/J+87VLJoMYnD7DgdELTS0YOxm+g
	QDf3F4CEBf8Ou6T24L2xNHDo+8
X-Received: by 2002:a17:90b:180d:b0:330:82b1:ef76 with SMTP id 98e67ed59e1d1-3510b145a4dmr4806914a91.28.1768490501476;
        Thu, 15 Jan 2026 07:21:41 -0800 (PST)
Received: from google.com ([2402:7500:568:57ed:9f73:35b6:5a3b:786e])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-352678ef77fsm2307285a91.17.2026.01.15.07.21.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 07:21:40 -0800 (PST)
Date: Thu, 15 Jan 2026 23:21:36 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Daniel Palmer <daniel@0x0f.com>
Cc: geert@linux-m68k.org, sre@kernel.org, jserv@ccns.ncku.edu.tw,
	eleanor15x@gmail.com, linux-kernel@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 1/2] power: reset: Add QEMU virt-ctrl driver
Message-ID: <aWkGAEEpTBn5Fch8@google.com>
References: <20260112182258.1851769-1-visitorckw@gmail.com>
 <20260112182258.1851769-2-visitorckw@gmail.com>
 <CAFr9PXn9nzw=kmWqv_ZPZshhGuh0iAW5b=Csygt6WZOnmd2tig@mail.gmail.com>
 <aWiGCY4aEF5dZOqY@google.com>
 <CAFr9PXn66L8FxEydCrRDR=_pVtspsFO9hOvZuWNtEB5z=9Ds+Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFr9PXn66L8FxEydCrRDR=_pVtspsFO9hOvZuWNtEB5z=9Ds+Q@mail.gmail.com>

Hi Daniel,

On Thu, Jan 15, 2026 at 10:29:29PM +0900, Daniel Palmer wrote:
> Hi Kuan-Wei,
> 
> On Thu, 15 Jan 2026 at 15:15, Kuan-Wei Chiu <visitorckw@gmail.com> wrote:
> 
> > > FWIW: I have a driver for this in my "m68k with devicetree" tree. As
> > > far as I could tell the virt_ctrl thing in QEMU might get more
> > > features aside from power control.
> > > So I made it a misc device instead.
> >
> > Thanks for the note.
> > Just out of curious, are there currently specific plans to add
> > non-power features to virt_ctrl?
> 
> The docs here suggest that power control is the only currently
> implemented feature but doesn't have to be the only feature:
> https://github.com/qemu/qemu/blob/master/docs/specs/virt-ctlr.rst
> 
> > If new features are added, shouldn't they be exposed via separate
> > drivers in their respective subsystems, rather than consolidating
> > everything into a misc driver?
> 
> I guess if it did get new features maybe it'd be a multifunction
> device? Since nothing except power control has ever actually been
> implemented, maybe the way you have it right now makes the most sense.
> 
I agree that migrating to an MFD architecture would be the right move
if/when qemu implements additional features. For now, I will stick to
the current approach in drivers/power/reset as it fits the existing
functionality best.

Thanks again for your feedback.

Regards,
Kuan-Wei

