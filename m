Return-Path: <linux-pm+bounces-34290-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 35A80B50345
	for <lists+linux-pm@lfdr.de>; Tue,  9 Sep 2025 18:54:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A77F7B5D45
	for <lists+linux-pm@lfdr.de>; Tue,  9 Sep 2025 16:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF37B35AAA3;
	Tue,  9 Sep 2025 16:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="02cnPnG5"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA67535CEC7
	for <linux-pm@vger.kernel.org>; Tue,  9 Sep 2025 16:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757436849; cv=none; b=kEsTq4QG/uK6QDovKkXXMCHN/S8OUMxUIMz8G8sPftGQQRgcHyS4vp0ZT9JWEXZMgVBD189RsZob123+HJTsOIWvhvJWipxTTBUD8ftRPUq3WgbjGJQjcnuDt0BPoDih7EVJmUgLn7Tq/cYikp4igubKEP6uq4IMTHHWVp2z7M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757436849; c=relaxed/simple;
	bh=h2tBW9z9qtavE4/GQ4hxoUrDMkmeBsS59wkL6NhBrnw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SpsnrbDD6eK9MKkrI5UmoQDumf3Rp/TNEi9KdIF2i3m/F5MIWMFdwxbBr3fl4oucazCJwU3MlYJesL90T/q/9/3DG1l9TrFXLn7jK2jL/w+ju0RTSGbWsZVONC6rS0gtNAf7hgDPK3Yg0u9sdcPhXZ3quazbsCBbBjYoaLRUtyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=02cnPnG5; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-61d14448c22so229a12.1
        for <linux-pm@vger.kernel.org>; Tue, 09 Sep 2025 09:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757436846; x=1758041646; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h2tBW9z9qtavE4/GQ4hxoUrDMkmeBsS59wkL6NhBrnw=;
        b=02cnPnG5JHmzSOyhGYZnqqb4/5yn9bUz07e6w7jZkCDq0fOyqRUzEJVWBfK7oFMEgp
         iqzQP8qYR6oWI938UijKnHOngFnOMFIrgj2j7BDzC+RZbt6U7BUydF99VQVwr3ZraJIY
         dsCo4+ZAQWJbn/dYXEEAphG+fmw6MitBlnl9hs4BDQk9R59loD7An8YLwlLL69SNQptM
         9RTkUiGaBdQg6fbtsok4HlVmDZOe5cLPw5wdCNfcw2w/EOue3HDHAxO4me1Lav/UJurO
         UU0J2bgYlQZpdq6mFUmGWRpQTr7iZaBIgbIbtiTme2bfD6WZL8r7Xkn9wad0b/OXlSlu
         DkNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757436846; x=1758041646;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h2tBW9z9qtavE4/GQ4hxoUrDMkmeBsS59wkL6NhBrnw=;
        b=jCRSoTXBjXMlpf9zIuPQrm8eILl1qi5Cz7ur+JymUn/OUoajk7rFu30d4XDG+ARCTy
         oFgpxTJjbErNbNalZgKTB7BokJy/C1otc/kDvKV+8olg3iyFA7fUQIahTG8TmKXGfppt
         gkXSLSxxKbSFmL+YjVvHVf8AOu5rWhaJN12n7obDVTgLOvXt2cC8eXFnzqvEoy/nJ5YC
         mV7CPUuchPX2JniG2SlM+j4XNtToZwj20N8u0GwGSJFIswJn0vIp2skW+XwkqLWz5qRS
         yOYFYOA5FHYte/NZj9rvuYAFRDVErFsn8dRh2B4yYqnzLdCx/e50tqduHGR/e4+ZTxDM
         w9IQ==
X-Forwarded-Encrypted: i=1; AJvYcCXV+4Jz5RBi+UqmpWZtc3rrDa/MFCtOme7lLGdR93Kwh0sIfeDNGOry+Gln41kOijSRZ/Uv61JDmA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwbmPRIGLYfEKOjK1wzWBVoNxhwHNl64q08j9B+CJlkdzmELD1R
	15AkOEML7FWQETdrxAi/5t0t1ZSA90L4nJYPoJp9sM8MbeqkfqKEvdZoyVzeGHRlzlMbnz8h9tR
	ruTp4ksgahL8b3ew1PIhix7Ub7M3Y9TH+MKWI4tQs
X-Gm-Gg: ASbGnct9kipHQ2uEMOjUXVhmxEIa3BJuy1OKwEcA3u1OB/dXUx7hdyQ41Ct4ja4uU/S
	rc7wiqHDtINLjht0wqKzUX5Gzl5BjUXZ0SRNBwgJMZlQxlNmjy4yWzFP3jLM7tlgpRYmGTDns0U
	SU/5WBT49qqWoMBvUFcTLK6w5ch8TW49iQ6J/3RjWQ5o7Ov3OxoN5HWFD9pSb5Y55m1vgPdvfzs
	c5jI5J78GWRPoMMKnqJMyIY9cKuOIBTfvw/PnOaYCKfhXqPFhFnAVk=
X-Google-Smtp-Source: AGHT+IHIuRq2aKoS3kEjqYzebKZlwD2uOrphU5fkaOYcf/p/e9onUEd1fbAZ1KbzoQawzSyO+8wUa2PQlZBj/Dw4WRI=
X-Received: by 2002:a05:6402:d60:b0:61c:d36d:218c with SMTP id
 4fb4d7f45d1cf-6234d3ee779mr244623a12.0.1757436845803; Tue, 09 Sep 2025
 09:54:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909090659.26400-1-zhongjinji@honor.com> <20250909090659.26400-2-zhongjinji@honor.com>
 <aL_wLqsy7nzP_bRF@tiehlicka> <CAJuCfpFCARoMJ8eniYdZ3hSaM_E3GvfRBV1VD1OohOfJpP87Hg@mail.gmail.com>
 <aMBZfYUN9qtcXXtL@tiehlicka>
In-Reply-To: <aMBZfYUN9qtcXXtL@tiehlicka>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 9 Sep 2025 09:53:52 -0700
X-Gm-Features: AS18NWAskqfJSKzjlCIyKddbks8of4_LFzBxNZe2p1mk8JK6wEwUqIe8FiYXcFc
Message-ID: <CAJuCfpFsgTmmSGEzK6TF62TNr4d4E+Art4ghfB3dHxQYMHJ2ww@mail.gmail.com>
Subject: Re: [PATCH v8 1/3] mm/oom_kill: Introduce thaw_oom_process() for
 thawing OOM victims
To: Michal Hocko <mhocko@suse.com>
Cc: zhongjinji <zhongjinji@honor.com>, rientjes@google.com, shakeel.butt@linux.dev, 
	akpm@linux-foundation.org, tglx@linutronix.de, liam.howlett@oracle.com, 
	lorenzo.stoakes@oracle.com, lenb@kernel.org, rafael@kernel.org, 
	pavel@kernel.org, linux-mm@kvack.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, liulu.liu@honor.com, feng.han@honor.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 9, 2025 at 9:44=E2=80=AFAM Michal Hocko <mhocko@suse.com> wrote=
:
>
> On Tue 09-09-25 09:27:54, Suren Baghdasaryan wrote:
> > On Tue, Sep 9, 2025 at 2:15=E2=80=AFAM Michal Hocko <mhocko@suse.com> w=
rote:
> > >
> > > On Tue 09-09-25 17:06:57, zhongjinji wrote:
> > > > OOM killer is a mechanism that selects and kills processes when the=
 system
> > > > runs out of memory to reclaim resources and keep the system stable.
> > > > However, the oom victim cannot terminate on its own when it is froz=
en,
> > > > because __thaw_task() only thaws one thread of the victim, while
> > > > the other threads remain in the frozen state.
> > > >
> > > > Since __thaw_task did not fully thaw the OOM victim for self-termin=
ation,
> > > > introduce thaw_oom_process() to properly thaw OOM victims.
> > >
> > > You will need s@thaw_oom_process@thaw_processes@
> >
> > Do you suggest renaming thaw_oom_process() into thaw_processes()
> > (s/thaw_oom_process/thaw_processes)? If so, I don't think that's a
> > better name considering the function sets TIF_MEMDIE flag. From that
> > perspective less generic thaw_oom_process() seems appropriate, no?
>
> Please see the discussion for the patch 2.
> TL;DR yes rename and drop TIF_MEMDIE part and update freezer to check
> tsk_is_oom_victim rather than TIF_MEMDIE.

Oh, sorry. For some reason that part of the email thread ended up as a
separate email in my mailbox and I missed it. Your suggestion there
sounds great.

>
> --
> Michal Hocko
> SUSE Labs

