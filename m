Return-Path: <linux-pm+bounces-20467-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70FCCA11B96
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jan 2025 09:10:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD4D73A2A52
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jan 2025 08:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FCA0236EA4;
	Wed, 15 Jan 2025 08:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dIrIOtVx"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41EF422F3AF
	for <linux-pm@vger.kernel.org>; Wed, 15 Jan 2025 08:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736928623; cv=none; b=RiTjlToezEcbymukNg3Jp0zn3fOd74JJ+ph/1SwowC6tX5xqCy5dKvjo0llJZDdodkm1ykADjEX/vhE8DkzYk7DVdlvEqRfiA5ZeoI3eSmRg3uEW2xLxSw2fgEHguzqJadAlU3A8S7qEhN2YAQaHUm8Wmj/93k0ubhIP7Popmg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736928623; c=relaxed/simple;
	bh=rSwTyZY4I5TNQZ36ZJFKFd5AiHOfTKvtyj8x/+QVUg0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iIuE2sXEtyLMPYPDrJo+Dmwe5a+mdEtQr0DXtdKmWygFwU8BPBUGht7coUaCGPu7dfipUaeHFhVk+yebzUxHeyQf6I2ZsyKS4WuBrHlbhqYdq30j3Ei1Bam8HJk33hAPCSsAjxWVtIMvXUxqUDFkXTnCeSv2wffDuzk+gdt/Nrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dIrIOtVx; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4361f664af5so72524565e9.1
        for <linux-pm@vger.kernel.org>; Wed, 15 Jan 2025 00:10:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736928617; x=1737533417; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1nlujC6QW9DOxbgQu88fKo8xMxC9did6nFkho6eb1+s=;
        b=dIrIOtVxlbr7FiZJDETxgouesHNVnN89PJWMUVigT2DJtfD9cfHAIhTyrk7JUouAB7
         ouGD04Zk7rdb9kLVReRrEd9TcoKS4HGS2FSYZTiyTxnI88PHIuXUVB4m1SamyaIpRggs
         e9LjtzDsBXEKkna0S6BlCA3wRRz66wTW1Dub86FIop9XnVijsPw9pd55qS0p8emaJIYx
         FxRicmEY6ULKBgeRki5EIhMste02nW0mqxnxRQxw0PUJMOQyEp0DiMkS9MfGfR8riaOz
         X7ogX9HfLm2wt932nf9yz9oeyKwn7oaEFqsazSXmoi/A5hKV4lZ+N73pFHK/J52qCkcL
         c9WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736928617; x=1737533417;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1nlujC6QW9DOxbgQu88fKo8xMxC9did6nFkho6eb1+s=;
        b=eJD2InfJLB8W5cPD2EslV/WCGf1btditjbSq/W529rHTB1Y71wa/WKAoHoAY39obG7
         BYtOqUo0OhTo7RS60bENIeKiHODD+ruWkYYwdMJoLdPL7OXsP9X715uSJp6J+FllrdlW
         WrUnoxeCRQzA6REUdodLDn7R/fCKRy1Znhis0Hmp7OvRGxoSsHdL+Fu7Epq6CvnMQMpC
         U+B3Q0g/JGJD22piHcvWbBDC37y48LdvbCtTSfWFn1zoFjU/1X27NAnLCCb2Lvo9hHrI
         /Nq046Gf+75bhhMcOR0TVV5nEp0R1h7UkM0MmmKXBugOiQ6+TPxMHurZP0kHxlolNZ+h
         ayVw==
X-Forwarded-Encrypted: i=1; AJvYcCUhY+cxEhkjeGrgmhK1u9ggINViMPj64c3jm0WlOxIW5bBSGYWgEVrXfaA3q2arogVerG0QMfmsVQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9tHrNr33yaUDTf8uSLjyWMnKDb4JBX09dON9HXmuodm1Y4fr0
	fcCt1Jhh8+0j3Q+9lTpWaWRXmLpeucoOfYGwZQLoCdl1QqMNSq+O1JD0ZWMKxF0S4gkMG9+7wNd
	sg97JR4hL/PbzF1wBXAriHps5tfHtWfYTm1WB
X-Gm-Gg: ASbGncujSDC9ZSArD8Q36xh/CwtxWMfv8drX7IBmmxcqK6AViLcjCm79JifUuv7ijU/
	fFbK0VqjYHWzVo+LjR9HtCL044ihaVfXSvGr7aGE=
X-Google-Smtp-Source: AGHT+IHhKP0wJOfUy9od4g/NNQjnk61zdThxn9PvX2U21KhSdZgJSCMd8nQ1MmYDDqBdFfh8py1XuQLuANTkxeE5SU0=
X-Received: by 2002:a05:600c:4fc6:b0:435:172:5052 with SMTP id
 5b1f17b1804b1-436e2686492mr205213525e9.1.1736928617402; Wed, 15 Jan 2025
 00:10:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1736766672.git.viresh.kumar@linaro.org> <854f7b8c9cbcc7f38fe5ed548290f41224478b40.1736766672.git.viresh.kumar@linaro.org>
 <2025011430-humiliate-expansive-2ea4@gregkh> <20250115072050.72oeibi735k3pjdq@vireshk-i7>
 <2025011537-shuffling-unpaved-121a@gregkh>
In-Reply-To: <2025011537-shuffling-unpaved-121a@gregkh>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 15 Jan 2025 09:10:05 +0100
X-Gm-Features: AbW1kvZeDBtKIB47SxhBev21kWIcVphrl0cUCc4ZHAAIXqs1vCSm6c-wS9Iqvfo
Message-ID: <CAH5fLghwAQsriWru-hFs+4pcvmpzZRj7GNC190RL7vi6p9J7Mg@mail.gmail.com>
Subject: Re: [PATCH V7 03/16] rust: cpu: Add from_cpu()
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, linux-pm@vger.kernel.org, 
	Vincent Guittot <vincent.guittot@linaro.org>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 15, 2025 at 8:54=E2=80=AFAM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Wed, Jan 15, 2025 at 12:50:50PM +0530, Viresh Kumar wrote:
> > On 14-01-25, 19:44, Greg KH wrote:
> > > > +pub fn from_cpu(cpu: u32) -> Result<&'static Device> {
> > > > +    // SAFETY: The pointer returned by `get_cpu_device()`, if not =
`NULL`, is a valid pointer to
> > > > +    // a `struct device` and is never freed by the C code.
> > >
> > > I thought it was pointed out that it could be freed when a cpu was
> > > hot-unplugged?  Or is that a different device in the cpu code?  We se=
em
> > > to have 2 of them and it's not obvious which is which :(
> >
> > I did reply [1] to that earlier. The CPU can get unregistered but the
> > memory for the device is never freed (it is part of struct cpu). Some
> > calls on the CPU device may fail later on (if called for an unregisted
> > dev), but should never crash the kernel.
>
> Ah, but that's not really something that SAFETY should override, right?
>
> Yes, you know your implementation of this will stop using the pointer in
> the hotplug callback before it goes away but that's not documented here.
> And having the device "fail" afterward isn't really ok either as you are
> relying on the driver core to always check for this and I'm not so sure
> that it always does on all codepaths.
>
> But, I'm ok with this for now, as you are just copying the bad C model
> at the moment, but it really feels like a huge foot-gun waiting to go
> off.  Any way to put some more documentation here as in "use this at
> your own risk!"?

On the C side, how do you normally prevent uses of the device after it
became invalid?

Alice

