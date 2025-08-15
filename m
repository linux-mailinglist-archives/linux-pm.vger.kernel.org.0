Return-Path: <linux-pm+bounces-32418-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F553B27438
	for <lists+linux-pm@lfdr.de>; Fri, 15 Aug 2025 02:49:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5AA31891A57
	for <lists+linux-pm@lfdr.de>; Fri, 15 Aug 2025 00:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D404070824;
	Fri, 15 Aug 2025 00:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ibCFfDo4"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1652B481CD
	for <linux-pm@vger.kernel.org>; Fri, 15 Aug 2025 00:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755218961; cv=none; b=ZNO4G9rNKF7usi/6fouKRkaDLsZSo2PlRxw1xiclVMdf/yl2lrO35+OODePto63GlVXN9wf8qPlu88G+rvF9dAl8pBZ6bMvmG/EfB0VasKKMX0qdWZoDQA5jcmzUONbYOXcMosrOu7tx1kgIhNV4o8xpo5XFSMdQV9/trGnUXz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755218961; c=relaxed/simple;
	bh=vPDeq+2DCIie7wbpdXgHvtiU9ESJbF1yvqLVOyQUXC0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MB4iif5QN9W3KJbmu3XV1erdJImNST5kESH0pAbUizktPwDH2kVLfqiKwyrFSW2QQOJz1m3TTjXRwzr0qTadHCc3ZJqaDzKr6+IujCFc4YCJ0ABKVhJ6cmtDJT0y8dLEMUA0ziwqx9vSODIE5q1h+0jhj7NIyuoWedTSUHqHTng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ibCFfDo4; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-afcb7a7bad8so206995866b.3
        for <linux-pm@vger.kernel.org>; Thu, 14 Aug 2025 17:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755218958; x=1755823758; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rxJI9V2/5brGzu15gMcFVUD4p8pvOCSJS6i60fiFax4=;
        b=ibCFfDo4niZKbK8VGF7buhwHR2+S604wvt+VrWQvy/6sIFW+OWwGmuNRHS1noKLT2+
         oILIPRLCFj1RwQe/zMa3gMcY2speuSt2aKhMBZJGx72tcnE+peP1eit8yizbKh7l1SmV
         5tzlUJ4NVOwfk8m5cHSOowWjhBK0Z6OpDNxWoooublhSwWUoaAlhDQ2yKKL897umD2xk
         hpvOsCDbWDkXwY1VoOQ/WpiZGi1j7+z/+BjJKPo/J1tXuD7bjQ5JmDhQasuWLmOh816J
         ETLiHSPJoXpaWENzsnDuRa0tOdssd5RRbG706SN887w8tWtmYkYyZ1GXUDX7EQsoFmDV
         Qczg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755218958; x=1755823758;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rxJI9V2/5brGzu15gMcFVUD4p8pvOCSJS6i60fiFax4=;
        b=wrNi0NskGtGl1nVrtUc6KWNGFBfxJpxtJm4YRAEuEnMsFvtqAw8Z8teJfGuE2Lrnjw
         0bJniEmu6lfwF/MNkoXSYF2EQVG89qs+F+0LtwsaJdbBNwwpoD70uVFlzxUQDiw/oB5y
         TURNK1R2w0uM1vFGBH1onkqDGiuSJ9svbEqkOmFy3Q+6/fvw5/VFMu4S2ZKqm7Ervimh
         IPEgmcPT+4oVZ4BLVBWk6XBh7eiymgaDEY2ymrXTiUw2+TlSmAVH1CRFQ2RXmAin8KfA
         tLRyeG/89MOwoDHCEQgdn1IP1oMNq+i4PX+kuXPQ7NxPvm096rrq6t0DZWX6lhlRG2te
         29dw==
X-Forwarded-Encrypted: i=1; AJvYcCXwP0eV6NwzVxne7OjrgIONpd4qtS185F6gFI5bOmQ3Js3RuXLi28IH5mQvcOuWlGHRi5GtpMDX7Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7ZRDt7uGJuHD3XcS3comw1lP6TTrn9dwfvC56ki0nNCPGarO1
	009x39DbCdxr7BW9DGhhCuU7f9ZSqFFtHz2KRbVdQstk5qqIqvVYZ/OjCqGkNHi9cnL+yAuq6hS
	xGmVgJSrDJiUstiGeiXGzAh8WOzYPPNLxKpEXB9uK
X-Gm-Gg: ASbGncuiO6hNHI642WfgxnRF+EQ010N2I0SqowQujV5d37G342+kb3zWhO1Wu+7RS2T
	WVnxP3h5csz8/5jEqsWYsCXo6ft7KnRrinAM/5CAxKxfzSBc4qkYJKFUJu06D6/p2r7BwVuit9v
	KlsNhX+eopnCwidPNBv9fp+Uledb6dvy7xmJ31tYlYO4+LmrQefwCELVzzuK2YdylpQOXVagvUE
	Vq0Iuss6wgj5Re+2jxYzlNSOW5kXcz/lBD+RAbwSkvP
X-Google-Smtp-Source: AGHT+IFt4k6OFVoKePCnvLLuvP5qwSUYLc1MlmMCMEp0GFJhfY9RjqXDNaX0k0KuFHceKDLyi7aTSGbDNYEPxRGz1Lg=
X-Received: by 2002:a17:906:fe44:b0:ae2:9291:9226 with SMTP id
 a640c23a62f3a-afcdc2bda87mr13464766b.59.1755218958152; Thu, 14 Aug 2025
 17:49:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250812232126.1814253-1-wusamuel@google.com> <2025081359-survey-sprinkled-e6dc@gregkh>
In-Reply-To: <2025081359-survey-sprinkled-e6dc@gregkh>
From: Samuel Wu <wusamuel@google.com>
Date: Thu, 14 Aug 2025 17:49:07 -0700
X-Gm-Features: Ac12FXw4bTiBvMbUfA5qcuR0BBiSCS1moprtqKFT3glNKO2GbV4EfI6aS7GTsqA
Message-ID: <CAG2Kctr8rzjjPtc3d-fCEtqxxkQacNKgBqstHZWgE9-xUmNLeA@mail.gmail.com>
Subject: Re: [PATCH v1] PM: Support aborting suspend during filesystem sync
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Lukasz Luba <lukasz.luba@arm.com>, 
	Saravana Kannan <saravanak@google.com>, kernel-team@android.com, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 12, 2025 at 10:53=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Tue, Aug 12, 2025 at 04:21:23PM -0700, Samuel Wu wrote:
> > +static bool suspend_fs_sync_queued;
> > +DEFINE_SPINLOCK(suspend_fs_sync_lock);
> > +DECLARE_COMPLETION(suspend_fs_sync_complete);
> > +void suspend_abort_fs_sync(void)
> > +{
> > +     spin_lock(&suspend_fs_sync_lock);
> > +     complete(&suspend_fs_sync_complete);
> > +     spin_unlock(&suspend_fs_sync_lock);
> > +}
>
> Why no documentation for this public function that you added, but yet
> you added documentation for a static function that no one can call?
>
> thanks,
>
> greg k-h

Thanks for catching this; updated in V2 of patch.

-- Samuel Wu

