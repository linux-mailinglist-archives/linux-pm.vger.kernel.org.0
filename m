Return-Path: <linux-pm+bounces-37112-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C4A0FC20D9E
	for <lists+linux-pm@lfdr.de>; Thu, 30 Oct 2025 16:14:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3B1F94E72F4
	for <lists+linux-pm@lfdr.de>; Thu, 30 Oct 2025 15:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4CFF32ABF6;
	Thu, 30 Oct 2025 15:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MC3krj1k"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A70329C60
	for <linux-pm@vger.kernel.org>; Thu, 30 Oct 2025 15:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761837208; cv=none; b=GIVRA9de4vaeFgpecb4OPtvgTq/X+atYjWZEqtvX5EtzxOt2hO19qpG+0iZvpc3ykRjI6fYdQel1m7I1LI9WD3G1zhf00VReMoflJh7hfqZZLkL59kL87K+7MrPtOuo8xrgj2DKy7nb7kRjirULCvjV4+2DsK0XTA1ljWe7qHbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761837208; c=relaxed/simple;
	bh=4LZvzW9Kh+P42auNNJ0YzK0VaO1s27OYFzOhbaTw/iY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KUPm/SyMtqeTlSrb1OCT2vi4SjwuZaktO8+O+R9KVgwSvOd1xKRlppDLOXKdjLApbNLljn9gUo0syWIAjCX4X9eLGOlsIPmZ+tp4OQgq9MWsT5KgPmp6uRzSBra0oJCmurMLKPLAm6Va+Y5mTlWwN2OTsfVpi3mMQihc8XfFguU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MC3krj1k; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-78619d34979so12382937b3.2
        for <linux-pm@vger.kernel.org>; Thu, 30 Oct 2025 08:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761837206; x=1762442006; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4COQfU/3sWCyd46/b/oPZJ7AhRt72nzQkq06aF3DpQ4=;
        b=MC3krj1ksF7SfBaU9zscMdxwAvVG5rZU4U2Ps9E4tsOJ98shLETDmsZosy/UNviwXO
         mztR6OGnJgIjp4uQT2TxrNggcy1OAQE0unntSBAGmgnGZjVczoUG2ddqO561HDaGEut0
         RwSVIVay5yG8pQwbiLc9clOM03JNQjrhJyQK4AAsD1bDHwlhVSCDkSCTicvMZ1vPrhel
         4vasECfUZBAt5IVGtwJ/Rrn3QIUl9sK3jeWI+MuT5LPN50Gy6Qkezkzz9YfSkPxRcEMw
         whp44erlKUl2cc3R96GjKxozOplgh4EjAPDs3REX4rcgLumC9f6C+vvRGmeGEoTaqdqL
         qJYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761837206; x=1762442006;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4COQfU/3sWCyd46/b/oPZJ7AhRt72nzQkq06aF3DpQ4=;
        b=oTbenNFnqPGNQ771gouEZUeZHXFEdqH9TjGpXSb67piP1MB/2BEFej7cJR6VfigPSP
         4cYPzL6sEhrtRpqpmr+WUkKQGRSrnhQF6AKoDQltpGQoTX2W+1UztTHcQsPinEQOhsK9
         XTE70c3qTS00nenEsWcBvYy02MNOoMJL90CpZiVqq51y/Y8RbqrIkN+c6t8CaceNp6tG
         1x5Wum5gNMyw4akh2r5c/eamm3klYasp1wBJLMNF+HdsED50Cw9q5jsW9wLoxnENVUiH
         JBjlYYutRn0mDbK2zI3jnadkN8H6FkjmJQ8DLPmKTWq8/A55eUtZgKJhRKMxpCSDV5TM
         CKew==
X-Gm-Message-State: AOJu0YzZs2oqX9k2NNLbHgejbqfyspKW5WisNqR3gUSjXHGs5iargFon
	tCFMyyZt7ZJefqeq0Y1uqTZc6EVyhyUXAEa4uTyc1Uf/b+6D38bgnOOSgO6PGsMi0dYOPTQxE5+
	JGopDUf4GVff+8esrU1XxME0lUzAy6pX/yhwU4yT0/Q==
X-Gm-Gg: ASbGncvRzQPtEm6WSNrJF9sUSYWavb66ClbkhaEU8SLHwUvp01EuziF1INompRTMYmM
	l3oKHlywrBR9LLsuSOB9ypdCa8qzK3DfSpVVX4E+XfsaIZ8JSVbEBYNd4qpYbI7LmulrfKR3e3G
	M2vERcZgsJNCNCX3Fl2MLQcqjby0E/t6Iy/Hh7M3PQgSvXjycNigbPC4Us/Bpm2SpC2RpKMXrpc
	09PdwUqCQvpy0Oha6FY0LH9MwiL0aVZ4Hu9AU6+kUycFCe5H/Yt7567VOIzPi33lWztJWnS
X-Google-Smtp-Source: AGHT+IEgl+53+xVIpNx265m6xqVaVzDLYtfsMuYpDq/HyQpNXpcYzvl86YayDl9WX2cRTzUBgfmVHWp/0OwN+1Uhe6s=
X-Received: by 2002:a05:690c:504a:b0:780:f9f7:1c4b with SMTP id
 00721157ae682-786390d3f7bmr29250837b3.33.1761837205781; Thu, 30 Oct 2025
 08:13:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251016151929.75863-1-ulf.hansson@linaro.org>
 <CAJZ5v0i_0K6+nCvBC55Bbu7XuKYjHrky3uG_aZ3aM0HMymcfeg@mail.gmail.com>
 <CAPDyKFpYfLJ1F1ynLAZLJBoWp+Uk-k2B0796_yWQTNg4xT9zew@mail.gmail.com>
 <CAJZ5v0igMhr=N90As66dioXXzL8YL11PN3k49n5-yoPuHNR-_w@mail.gmail.com>
 <CAJZ5v0jSvU7=bmscRyQrvoWA0q=AgbDE3Ad1jf+4PTdzZgSNjw@mail.gmail.com>
 <CAPDyKFr=uVS0CsuFnTjXH+o+P+xrG7GKj2O92mGgqiSo-tk9Bg@mail.gmail.com> <CAJZ5v0g2TebJDR5SWdFfyU7dksShZV0qXeO+yP6V_QTCsE--AQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0g2TebJDR5SWdFfyU7dksShZV0qXeO+yP6V_QTCsE--AQ@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 30 Oct 2025 16:12:49 +0100
X-Gm-Features: AWmQ_blf0zyNKfrORMoqLZv73Dd3HNaOv_nSPiu2DZwurZLSwec8TwHbzKR5H2g
Message-ID: <CAPDyKFpBHZ758khTGhidcyYCwy7dDtkabJ4trg4K16BhWEpUYA@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] PM: QoS: Introduce a CPU system-wakeup QoS limit
 for s2idle
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, 
	Peter Zijlstra <peterz@infradead.org>, Kevin Hilman <khilman@baylibre.com>, 
	Pavel Machek <pavel@kernel.org>, Len Brown <len.brown@intel.com>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Saravana Kannan <saravanak@google.com>, 
	Maulik Shah <quic_mkshah@quicinc.com>, Prasad Sodagudi <psodagud@quicinc.com>, 
	Dhruva Gole <d-gole@ti.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 30 Oct 2025 at 15:06, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Thu, Oct 30, 2025 at 1:44=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.o=
rg> wrote:
> >
> > On Thu, 30 Oct 2025 at 13:29, Rafael J. Wysocki <rafael@kernel.org> wro=
te:
> > >
> > > On Thu, Oct 30, 2025 at 1:26=E2=80=AFPM Rafael J. Wysocki <rafael@ker=
nel.org> wrote:
> > > >
> > > > On Thu, Oct 30, 2025 at 1:23=E2=80=AFPM Ulf Hansson <ulf.hansson@li=
naro.org> wrote:
> > > > >
> > > > > On Wed, 29 Oct 2025 at 15:53, Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
> > > > > >
> > > > > > On Thu, Oct 16, 2025 at 5:19=E2=80=AFPM Ulf Hansson <ulf.hansso=
n@linaro.org> wrote:
> > > > > > >
> > > > > > > Changes in v2:
> > > > > > >         - Limit the new QoS to CPUs  and make some correspond=
ing renaming of the
> > > > > > >         functions along with name of the device node for user=
 space.
> > > > > > >         - Make sure we deal with the failure/error path corre=
ctly when there are
> > > > > > >         no state available for s2idle.
> > > > > > >         - Add documentation.
> > > > > > >
> > > > > > > Some platforms supports multiple low-power states for CPUs th=
at can be used
> > > > > > > when entering system-wide suspend and s2idle in particular. C=
urrently we are
> > > > > > > always selecting the deepest possible state for the CPUs, whi=
ch can break the
> > > > > > > system-wakeup latency constraint that may be required for som=
e use-cases.
> > > > > > >
> > > > > > > Therefore, this series suggests to introduce a new interface =
for user-space,
> > > > > > > allowing us to specify the CPU system-wakeup QoS limit. The Q=
oS limit is then
> > > > > > > taken into account when selecting a suitable low-power state =
for s2idle.
> > > > > >
> > > > > > Last time we discussed this I said I would like the new limit t=
o be
> > > > > > taken into account by regular "runtime" cpuidle because the "s2=
idle"
> > > > > > limit should not be less that the "runtime" limit (or at least =
it
> > > > > > would be illogical if that happened).
> > > > >
> > > > > Yes, we discussed this, but that was also before we concluded to =
add a
> > > > > new file for user-space to operate on after all.
> > > > >
> > > > > To me, it looks unnecessarily limiting to not allow them to be
> > > > > orthogonal,
> > > >
> > > > So what's the use case in which it makes sense to have a lower late=
ncy
> > > > limit for s2idle than for runtime?
> >
> > Honestly, I don't know, but I just wanted to keep things more flexible.
> >
> > > >
> > > > > but I am not insisting that it needs to be like this. I
> > > > > was just thinking that we do not necessarily have to care about t=
he
> > > > > same use-case in runtime as in the system-suspend state. Moreover=
,
> > > > > nothing would prevent user-space from applying the same constrain=
t to
> > > > > both of them, if that is needed.
> > > > >
> > > > > >
> > > > > > It looks like that could be implemented by making
> > > > > > cpuidle_governor_latency_req() take cpu_wakeup_latency_qos_limi=
t()
> > > > > > into account, couldn't it?
> > > > >
> > > > > Right, but I am not sure we want that. See above.
> > > >
> > > > I do or I need to be convinced that this is a bad idea.
> > >
> > > And there is a specific reason why I want that.
> > >
> > > Namely, say somebody wants to set the same limit for both s2idle and
> > > "runtime" cpuidle.  If the s2idle limit did not affect "runtime", the=
y
> > > would need to open two device special files and write the same value
> > > to both of them.  Otherwise, they just need to use the s2idle limit
> > > and it will work for "runtime" automatically.
> >
> > Right. User-space would need to open two files instead of one, but is
> > that really a problem?
>
> It is potentially confusing and error-prone.
>
> > What if user-space doesn't want to affect the runtime state-selection,
> > but cares only about a use-case that requires a cpu-wakeup constraint
> > when resuming from s2idle.
>
> Well, I'm not sure if this use case exists at all, which is key here.
> If it doesn't exist, why make provisions for it?

Well, because it's not possible to change afterwards as it becomes ABI.

It would be silly having to add yet another file for userspace, down
the road, if it turns out to be needed.

Kind regards
Uffe

