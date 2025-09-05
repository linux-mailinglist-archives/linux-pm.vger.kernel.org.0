Return-Path: <linux-pm+bounces-34000-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B227B45DFA
	for <lists+linux-pm@lfdr.de>; Fri,  5 Sep 2025 18:23:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5538DA60D30
	for <lists+linux-pm@lfdr.de>; Fri,  5 Sep 2025 16:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55834309F00;
	Fri,  5 Sep 2025 16:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Vb7FbUY5"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16BFD309EFE
	for <linux-pm@vger.kernel.org>; Fri,  5 Sep 2025 16:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757089285; cv=none; b=LV+seKBJVLT6UEhqk748Ef/FBNIriDvfPuB5+jd+lFgjf+VMuuwWVTxGMGhWk7A0SHm7aUdRL2ST3pTsdv3S/1TZFxQkMJyh7iwz+g4jjHCaVGwQs6dw+7Lg6Zt7+p411Mo7KyXjZbme7ME4pIOxrtheBMkj/OASLM4Q4Sf6138=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757089285; c=relaxed/simple;
	bh=FhLxsW7N1SQCjS7MmdLttNnXs5yQWDLWyMtOjt5ZKog=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pCqWjndY/p14RfNEmgBstFSB8SAFp+W1aHwChrcQ6gpxEJRfSd5SAGtye2yUdzKfd1MgrPAutkE3fmxRXgcs/enJUbGeytazxWUHR1lkmTiRkiyuXukvzj5Wmoca5jNG/KTKArOdwIhBwBJtuX9sPjFeG0WT+aJYLMKVhYyb1w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Vb7FbUY5; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-55f646b1db8so2604335e87.0
        for <linux-pm@vger.kernel.org>; Fri, 05 Sep 2025 09:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757089281; x=1757694081; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l5WFFAiISakOGL7/w6h2pyckQlucNaVtb99jNidQbKk=;
        b=Vb7FbUY5umiTxiUnt6o+ORWaaY75uUhkoqj0iljQgEhswOwedpUxlicFQshEDWdy9d
         Ysu6acntohhP9+9J4KEl6ILFeX4iwsqWEnn0TczgllCngxiLzhaCX7BLFBLaIo9u5I/t
         mvApvvSMTotZHRcQ4RNiZa5cMTHJgMMSX61dsCzaRl47SFbwv5tLdEYvTaBOEZ70U1uv
         eweGmTA3JUWTEsdd3EgcG386WLkbiA/bs6TBOSVcV0N2hRGUOjePeE9GWBTXlFSG87kY
         fZqCpW1cWn4ZYekn/+3msQ3fENu4ca7hqnLGjwKGoRplHY203CNTsgUIUvxvwqcTdGE0
         LKDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757089281; x=1757694081;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l5WFFAiISakOGL7/w6h2pyckQlucNaVtb99jNidQbKk=;
        b=dLR/49Auvt0ZTo3Ufqhco8SuW0Gi9yiuu+ZrTcknOodtfXMip4HqU1PZZTYlOsxC/9
         69kEPPoh/K+sTn48LMNuMk6K/bRwZd4mQaxBaeviQ6GrjHr/LXj0xonvMq2h+02kUSJS
         ZWeZ9hJt36Wp4mzXsoYWHcE87NIyQTHe0yQWzBK2YUjxVnJpXvdJhkHPOkoYpY40HHuo
         krBXJWPpfu/QGsNydb8Kw2u62MWPfkhVr6P2yHePwvpAELSO203OEhm2tLPfKPtaQTIq
         S05rpENKrvQOx88jvWcP+15x7goYvamWusQTFYJX00hE3UsL11bUdR2FRZc5d9RRusLI
         Vf1A==
X-Forwarded-Encrypted: i=1; AJvYcCXGIAvuRuqNZOlJRwI7LIdY2/D/sTcnSzAVWw7mwtS0V2QNRsI8eUmK3BvgRbbXGWoKIaC8YSn4Tg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwR1VjLBOaiTlv0c33hZzLqIRaNmjuq0pqj5aIrp9m3ouZtmaAy
	jbN28JNYgmwgLPWOpYo/5ClzD0B/Bo3xzY+LWjmHFaolYbXTBLGyn64MwjNwdebLvTUQqlw0i7+
	cIFcvEqoGcvWAC0XRsdoHYygiBXAj2i9AD/dfKyC7sVm6IwZ3cqFUExE=
X-Gm-Gg: ASbGncuhLPsyaIDsarF2tGm1NUdkE18/vK//JfBuX8XVfJJKJKRXuUb3RgPOmH3ALiA
	pGHe9dtz8uA6BXxvTHNNsWRQsObhOk6Agd3spB990j3kxnbdfiTwgmFlppI1J2xwMtUj4U5EwGk
	LOdDamcuBPx0KVqK3qGJ4PL7uaYPaKYl/fv6ACrXjWzCr0lLlunJ+hPYAe8uoQxLcmAvkOqyj1s
	6gc58TD5IcPjcneZT8BHcP/RII5/L/rYXx772H8O/jO5Kb7X9I=
X-Google-Smtp-Source: AGHT+IECqCoJEQFJEoXiFIgxbW0WXoCjBAMPomhwUyHK1hQjSLnX3Y/Z3kwYoh71qzWompk3QBquPOz4QaH7kdtc4Qk=
X-Received: by 2002:a05:6512:4608:b0:55f:61de:5359 with SMTP id
 2adb3069b0e04-55f708bcd00mr6079153e87.24.1757089281135; Fri, 05 Sep 2025
 09:21:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250905090602.105725-1-marco.crivellari@suse.com>
 <20250905090602.105725-2-marco.crivellari@suse.com> <CAJZ5v0jr1-dD9_cWrgunkXEsqE25CsHwpB5U0Zn_z7ztXRbSeg@mail.gmail.com>
In-Reply-To: <CAJZ5v0jr1-dD9_cWrgunkXEsqE25CsHwpB5U0Zn_z7ztXRbSeg@mail.gmail.com>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Fri, 5 Sep 2025 18:21:09 +0200
X-Gm-Features: Ac12FXxjxVOTarCKOZNujM62DbxcO3umsAjV-eUPbQCaZ37gBHhXya5kewHvPMo
Message-ID: <CAAofZF6uid+TAcz6P9WDXHWXrJMjNHdqgFuN8kf4w=ZSf7t5AQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] PM: WQ_PERCPU added to alloc_workqueue users
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Michal Hocko <mhocko@suse.com>, Pavel Machek <pavel@kernel.org>, Len Brown <len.brown@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 5, 2025 at 4:04=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.org=
> wrote:
> Duplicate paragraph.
>
> > This patch adds a new WQ_PERCPU flag to explicitly request the use of
>
> Using phrases like "this patch" in kernel patch changelogs is
> discouraged because the patches become commits when they go into git
> and then the language becomes slightly odd.  You can say "this change"
> instead.

Hello,

Thank you for the advice!

> > @@ -1012,7 +1012,7 @@ EXPORT_SYMBOL_GPL(pm_wq);
> >
> >  static int __init pm_start_workqueue(void)
> >  {
> > -       pm_wq =3D alloc_workqueue("pm", WQ_FREEZABLE, 0);
> > +       pm_wq =3D alloc_workqueue("pm", WQ_FREEZABLE | WQ_PERCPU, 0);
>
> I have no strong opinion on the change itself.
>
> While preserving the current behavior is prudent, this particular
> workqueue may as well be better off as WQ_UNBOUND.

Thanks for the info, about this specific wq.

All the users have been massively converted in this step.
So we added WQ_PERCPU if WQ_UNBOUND wasn't present, to make explicit
it is per-cpu - as you said, keeping the current behavior.

A next step will involve exactly what you said: remove the WQ_PERCPU flag
where not necessary.

Thanks!

--=20

Marco Crivellari

L3 Support Engineer, Technology & Product




marco.crivellari@suse.com

