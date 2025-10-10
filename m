Return-Path: <linux-pm+bounces-35893-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C608BCBFC5
	for <lists+linux-pm@lfdr.de>; Fri, 10 Oct 2025 09:53:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 15E4C4F317B
	for <lists+linux-pm@lfdr.de>; Fri, 10 Oct 2025 07:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4291625A350;
	Fri, 10 Oct 2025 07:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aRbGvTbW"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A097B240611
	for <linux-pm@vger.kernel.org>; Fri, 10 Oct 2025 07:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760082794; cv=none; b=SdydQ9d6l3mauRf5U2jKtqqvK2k1SZIc6CMMxi0i+IIaqq6DpSrYm5c7ixGnuNuAbaIdTeyiiCcvL0gcn9ET344mA2OZ2KSFWZvyIYwzdo0VW2IvfPlPWAe7ho0XuopMPFzwj3gjc0xG6+MnH0VPXPDImSAO1vQotwmXyafqqW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760082794; c=relaxed/simple;
	bh=DHqSm5NgIZTWpIeyFda2uZBgSRaGewPdAR8APEw7rw4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J5h7tokYvY+4AmlxGrP0UeA/fG98nuGWZvNlEse4k+LzY06xPFxnYOuCM8Z2I0d6rTcQEcCcluKiQGgNPWOi0hjdiVw99GzSRuyIyeppHPhR64e62j6gOYzz7rK+dl/JMxxE3jV3H9wrrzVcS3e1XMYD4cLtOuSq0psw3Nb6/3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aRbGvTbW; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-77f947312a5so17114597b3.2
        for <linux-pm@vger.kernel.org>; Fri, 10 Oct 2025 00:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760082791; x=1760687591; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DHqSm5NgIZTWpIeyFda2uZBgSRaGewPdAR8APEw7rw4=;
        b=aRbGvTbWWLAMowNzQK33UcmqpJ0C6uDinKM8TrTByNhUVnX4oT7RspCS97uboADmUv
         +iD0UuM1o2ZAMC02QdZq9+44d32SkGOEiupcnkUg46QEszZLQUiBOsefF6qZ6DUirTtT
         cVuytJSjzMvqbaI3yHySQs7KsETGzZSiAdOBcoAICKV9HHHev5jnfGeYJi1I+iBYOSpw
         jYkFRiURMY6sj7ibo5pYFDKglV0SJGrfpCwnZ5S6jO493tvuqb9VCQyLXAJES79YcSoa
         nd2ygwPHv0uI/4FzegbO8c33vf7gBMvKiau+WUmJNXG08Q7/u5npFNADQgfkerJFx2FX
         4lsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760082791; x=1760687591;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DHqSm5NgIZTWpIeyFda2uZBgSRaGewPdAR8APEw7rw4=;
        b=aUd9Cs4snQ/jo/JpwmuZYGyNnIfS9s3liWlmbY2mcJS8UFGTvI08RhzxuJ6HeV1Zra
         cqfh4JjkrzXqdA0WR1Po1QTUnCze02U0TiK4WPwkXEEBmyFb10GqsEcRZtJhOAVOvB7V
         R8s3rAiPo0H0eUHMnP934ydwjhzAtf4cjM2/uKTgJ3Isai8sbJq97HZfl0qqfkIqlk4e
         pOHfKaxrMouQpQdUMzoPMHdB9GUDtanEhGnrjCz/c8LxegwKTWs5SlrfZjr6iPr0j8ys
         47G+RFJ8AKZnUiSYdLpaDE89Azjv/ZwHYb32OENBgVE7Wx1r2bj1/u1+W9zxJtNQKZTP
         OToA==
X-Forwarded-Encrypted: i=1; AJvYcCWX6V/gRjwHAQWGJg7O84/b0CLb2JBvPRdy084Xc8SGiWwqvSURqHRJpx3r6Kl9ZK2t/Y5GWjKPXg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxbPmgaa+0R6fDL9IlTQrpZmvWi48gGhUjEEAhSb1VYLIISHZRS
	z4oSiNxAlk3d7HQY/TwvTsjy5RP6tFLk9AA3XQq/qoKt59mLhbiXa+evji0brnkxaxFEcPUFjHU
	CI98vRvM4XF+EWlr55C+x5oQ5BhcLt8i0sPcJy7cW7A==
X-Gm-Gg: ASbGncuci3VW6XGGGQNZUxthqkLHn4ziJpkP2wU2tNlC3uoOyjYsObRoXW4qvtpFsNN
	3KMjvLDJJIRyckTqE2Osjrn5lBpYdwPQwY1+WNQxl2ZWXE4Igd5y6PZfew3XCROo/wgcnteJG/R
	KlurFDDFK31VBNL/0JUqjCLPunOiDIfihkOTmFw8PBTQNp3/wt42wh6xjxy/TDAFwYyuxCygheY
	gFYK+MS7+Tbl6sCuQ0AgX+K+3u4GkeVUVs0eQa85w==
X-Google-Smtp-Source: AGHT+IEnyq80ACUu37tcZXlzziIoOjXYva5YJrTeAlxVjWlNNTGe7b3l2TEzAxaUZRDoT0ueLBKhVdK8QVQuA2xTx2E=
X-Received: by 2002:a53:b806:0:b0:635:4ecd:7599 with SMTP id
 956f58d0204a3-63ccb8dba03mr7918670d50.39.1760082791492; Fri, 10 Oct 2025
 00:53:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251003150251.520624-1-ulf.hansson@linaro.org> <20251006-barnacle-of-pragmatic-faith-e6ca0d@sudeepholla>
In-Reply-To: <20251006-barnacle-of-pragmatic-faith-e6ca0d@sudeepholla>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 10 Oct 2025 09:52:35 +0200
X-Gm-Features: AS18NWDvepcO2JLruDjD5wrLTae5DuV85tbk2iUenQa_mEnTJqXVNaVAhQe1lcQ
Message-ID: <CAPDyKFq64RD6UAjfLyKSBG3EU=T0DFk7v6jzBCBTGGg_U784Jw@mail.gmail.com>
Subject: Re: [PATCH 0/3] pmdomain: Improve idlestate selection for CPUs
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Maulik Shah <quic_mkshah@quicinc.com>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, 
	linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 6 Oct 2025 at 17:36, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Fri, Oct 03, 2025 at 05:02:42PM +0200, Ulf Hansson wrote:
> > Platforms using the genpd governor for CPUs are relying on it to find t=
he most
> > optimal idlestate for a group of CPUs. Although, observations tells us =
that
> > there are some significant improvement that can be made around this.
> >
> > These improvement are based upon allowing us to take pending IPIs into =
account
> > for the group of CPUs that the genpd governor is in control of. If ther=
e is
> > pending IPI for any of these CPUs, we should not request an idlestate t=
hat
> > affects the group, but rather pick a shallower state that affects only =
the CPU.
> >
>
> Thinking about this further, I=E2=80=99m not sure this issue is really sp=
ecific to
> pmdomain. In my view, the proposed solution could apply equally well to
> platforms that don=E2=80=99t use pmdomain for cpuidle. Also, I don=E2=80=
=99t see why the
> solution needs to be architecture-specific.
>
> Thoughts ?

From PSCI PC-mode point of view (I assume that's your main target with
this above comment?), it would *not* make sense to bail out for
idle-states that could affect other CPUs too - because the CPU only
votes itself.

However, if there would be an IPI pending for the current CPU that is
about to enter idle, we should bail out. Although, as stated in the
other thread, we already have the need_resched() thing that helps out
with that, I think.

That said, I think this change is mostly interesting from pmdomain
point of view.

Let me comment on the architecture-specific part in the other thread,
as it seems like Marc also had some comments around that.

>
> I understand it won=E2=80=99t handle all IPI cases, but generic helpers l=
ike
> local_softirq_pending() and irq_work_needs_cpu()
> should already cover some of them in a platform-independent way.

Thanks for your suggestion, but unfortunately these don't really help
as they only have information about the current CPU.

Kind regards
Uffe

