Return-Path: <linux-pm+bounces-36876-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA965C0C52B
	for <lists+linux-pm@lfdr.de>; Mon, 27 Oct 2025 09:34:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96A6C19A0FBE
	for <lists+linux-pm@lfdr.de>; Mon, 27 Oct 2025 08:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 311A52E7198;
	Mon, 27 Oct 2025 08:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kyLYAXnn"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1631DF27D
	for <linux-pm@vger.kernel.org>; Mon, 27 Oct 2025 08:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761554074; cv=none; b=J03wKLvG2nO2SUxXZxKOtoAtBUAGO8+a1vHyMNIS4McmuNjjiITC+CVyTgcZW2LXiRXmGIxCbkFhCBtlfBxXe4t3Pzlxbe3v9vSoAvOi4wJTV/uHdA44TERs7gH58SnKe6y10bhDbAiOIBI37uRmsP1Owrn8V1XVeajiSx/EBzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761554074; c=relaxed/simple;
	bh=hZTN/tQMYZInh7JvxfdJgJoSNB55wm3j6jMjFgi+HkU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mh13T4nFgE1/h5Txuf+wjsbWDqGTHNnaHb8hMgiLjgqap1FaO6S4lTxw27lz9+DW45iAeALdc0WQN6byR6vgP1GxMeESUoxPG33x8TUaPyE0gTz/d+QcCXt3kN+nu26wbcmWiE1SCO9oOsG0vSAu9hEetYowfLNToxqZrIkvB+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kyLYAXnn; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b6d2f5c0e8eso897239666b.3
        for <linux-pm@vger.kernel.org>; Mon, 27 Oct 2025 01:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761554070; x=1762158870; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QXqA2AyYDwMAn5NeiBjETLweOL3QhYSqRjqxrljQDYI=;
        b=kyLYAXnni860iyXZipirj1ouWIpiOII1jtdMfjXMlErQ6dOum3GjUR1FmWlO51eCaf
         ooziWpmNBHa6xn87D336Taz6sYkrjM+ClNFD3FNo7aM/VUs1r7c6avi4YIhAVhgYCPEk
         uL+Mk4M1ARpwbIbbYlc1B/sof3Bf3eJ1buTuFf/xsM8AyBXsA3ZiIKmL46OkJpHARTml
         2HAt85RckGpaqPqYaU/Di8gBH8JtTf23CEqF4ZnQeJbtUdIbYsff5Psolv0MCInD2/cG
         NRdFLB9gqa+D9XoHOURy2+xLIVVp5QbP6845dopJzXbFaihzSDEeKmQo6nkMh3SSv4oa
         FRKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761554070; x=1762158870;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QXqA2AyYDwMAn5NeiBjETLweOL3QhYSqRjqxrljQDYI=;
        b=qHggjLkSu8oobeFNZwVO9Zi7EdU+ei1Rcy2Vg91TSl+S+aaBn1enZxat7SyCb3NzEP
         pJ+PFouMgHYYFvy0HqSY6tYLbUmMt5q/9btsnJT3yPjtaVraxf1JfqPMoGjxirF07bhI
         bO0RI7NRC50E8UdH7UmPo+b0oaXcO2HwUYQCPX9FlyxnpOU4y2Zr6VeQWO+nSUPmy8MN
         3AmCKwTvwIxvSJwaVD5GEk67SEaGoz+RuLSOAczm3lAwdM30Jw0Z1R2oFVD53bmdJu3S
         5lMRm2RUXs/ldyti5uYqQwEl+mpJVY0N/VeVwJgB1R0Uw/foiv3KHKdCkAekAfxPjeJd
         ypAA==
X-Forwarded-Encrypted: i=1; AJvYcCXzevlGK/G6IUk1CBDdCSX0ISQoyEZ902H6FwMrreIzrBAl098+HRinZ7FsmMLIcVm3vH0YpUMf+g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+e6nsDpY5G60yWpN8dBqe9QGSllLaHr0yYt3C2+2RVm4OZJkL
	7Usqu6KUQKuZnpoRy0yOHuSrGx2T06VOA6DgygWV/fIjwiBB9lZb20LEvpSCM0pdoQ1rAQX0bZS
	67xZ34JMjqzbzcx+i0Ld06MU9Z3fGfnOcH4IPpPo=
X-Gm-Gg: ASbGncs13ciqIRFvApfl1XvKj2fZU6LL+GcFWKfjP5WTHd1ofrJNXrAXpbpIAADGemm
	A7FfiJDPPPbArEwpUdL+IuCoAHNubafBZ8P1fwDLYLDZvCO5ysGUG1f1Dn7+Xnaa/WSGSmbNKPb
	ABV9KgBbdKnfq7FWEEabGEvT6rL41Ipjt4uUqbYVYAzEnV/QmHPVYEfhootMf74/DYwj+mcay2V
	OK+heJntvabzObColBKQ1uYElnbWM+RZ43NdKYZQqS90NEJzM7OZxUynJm8yNvs9SB4pMCDbnaA
	/n5dphr+CtxHNiarZgcmPlXT3FUOpA==
X-Google-Smtp-Source: AGHT+IF4Ku7VBi6Rz5YATQmMp4K6m21OtDlsrRJ8R6TX/Zwi0y9zuA5CLxTmowv0xMLnRyevU+7TIZF7WyaAwQdIbqQ=
X-Received: by 2002:a17:906:6a12:b0:b40:b6a9:f70f with SMTP id
 a640c23a62f3a-b6d51aefb9amr1645192766b.4.1761554069622; Mon, 27 Oct 2025
 01:34:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251024-aheev-checkpatch-uninitialized-free-v2-0-16c0900e8130@gmail.com>
 <20251024-aheev-checkpatch-uninitialized-free-v2-2-16c0900e8130@gmail.com>
 <aPvAm1E7CvQfOIuS@stanley.mountain> <81e6af8eea5b0399d1685797d0ea6a6ebc273270.camel@gmail.com>
 <aP8CxkXYAitKB3vx@stanley.mountain>
In-Reply-To: <aP8CxkXYAitKB3vx@stanley.mountain>
From: ally heev <allyheev@gmail.com>
Date: Mon, 27 Oct 2025 14:04:18 +0530
X-Gm-Features: AWmQ_blvkJ9ZtBmHKBSTV_q6E3sXqzi4cxX3zWvk57-nTx4mfsifVuvdEYK6e1U
Message-ID: <CAMB6jUGEJeOVKUEpeFosBFA3QsQk3kgdt_e1EAQJi_yqJp7H-A@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] add check for pointers with __free attribute
 initialized to NULL
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Dwaipayan Ray <dwaipayanray1@gmail.com>, Lukas Bulwahn <lukas.bulwahn@gmail.com>, 
	Joe Perches <joe@perches.com>, Jonathan Corbet <corbet@lwn.net>, Andy Whitcroft <apw@canonical.com>, 
	workflows@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, David Hunter <david.hunter.linux@gmail.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, Viresh Kumar <vireshk@kernel.org>, 
	Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, linux-pm <linux-pm@vger.kernel.org>, 
	dan.j.williams@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 27, 2025 at 10:57=E2=80=AFAM Dan Carpenter <dan.carpenter@linar=
o.org> wrote:
> > General question about the process for my understanding:
> > Is checkpatch run on full tree by CI or someone and results reported
> > regularly ?
>
> Newbies run it regularly.  Otherwise it gets run on subsystem CIs and
> the zero-day bot runs it on new patches but it will report the old
> warnings as well under the "Old warnings" section.
>
> > My understanding was that we would run it only on patches
> > before submitting them Or we just run it on full tree before adding
> > new checks to understand if they are catching real issues
>
> Eventually someone will look at all the warnings.  And probably it's
> going to be a newbie and so we need to be careful with warning where
> newbies might introduce bugs with their changes.
>
> regards,
> dan carpenter
>
Makes sense. Thanks!!
---
aheev

