Return-Path: <linux-pm+bounces-37168-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CEB8C245B4
	for <lists+linux-pm@lfdr.de>; Fri, 31 Oct 2025 11:09:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 929761881AFA
	for <lists+linux-pm@lfdr.de>; Fri, 31 Oct 2025 10:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B50AC2EB843;
	Fri, 31 Oct 2025 10:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KC6hLbUp"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF43224B1E
	for <linux-pm@vger.kernel.org>; Fri, 31 Oct 2025 10:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761905066; cv=none; b=n56k/QwGzfNRgwi1kPfVW8UiT1ehqv98pmiHGm5vbwhWgwu5ak7QcVwDxq/HjMHYR1vulKB7CplpZbpD38e5H1JeJYU6fz1iNhb6ssBA0j9gBoD3Hh9nFe8hmBaSDebD5Nb+/heppT7KP1zcpamr6S34z2AXcvmqaa76TOJtIv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761905066; c=relaxed/simple;
	bh=1NPwAuVD0brkPDsGNU2qpw0U6GQjpBoksa6hfCKwLjk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pQ4F0qDQh3Gi4Ram0nfQjyZhYbUB8R4AbqTGxVxjAK01xJZNOH7ABvYO9+Ay/T9Q6bH9RZ+drMr+AvvxaFPLL8ipO916LkwfbaoN72hTQCnIOrU8EPaxG8VLWbiAFMfP2a811rk+gAo7ikYuKZRAs80KzUkYBzCITdMzgfMHKWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KC6hLbUp; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-78650258bacso3253527b3.3
        for <linux-pm@vger.kernel.org>; Fri, 31 Oct 2025 03:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761905064; x=1762509864; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l7tYEGFUqGaeBpHUvE79YnYVY5qHGH/JQgyafV2cAr4=;
        b=KC6hLbUpwlMQxk9+yKhg6ywRJI2XxyKAP96fQEBtA0DB88JnYiBMv0xdBIOsGmrSk0
         MrZyFxUETIfjeBHjdMseOrHyiNqnJ2OoJopT4QxzJOg5SUoLN36O7gcEdXDlFBkFvk3x
         xoMhq43DAIImqQxu3j5GyOQxi4vM7gb/bibSXvmCBQvKtSAYHGKLR56kwLxjasNN+FCU
         CjRkTayO6iJBdtmpIPYwbWLW5ChylLvaXLCtSD2Ec9UNJvBeKpm4qdn3cHFTObleTM2N
         7Ny1kcw+1o2cK5scQu1Ua5fVzKh+YvCn8TeI86nTTTszzN+FgxCLBgg710eiExswlTz4
         g2kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761905064; x=1762509864;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l7tYEGFUqGaeBpHUvE79YnYVY5qHGH/JQgyafV2cAr4=;
        b=RJPBG1p27ASYcejU5FQA8wfegPPF2MAClJlKwrYF+fjApKAXv/7P6LVq7okngLlhE2
         NT0gqsTn3Gg/rGFk/+PUasU2H8kyWvYXAc7ZJc2jBxieW/EWmhj6NZlgfSZauq/5Qj6R
         d8pHsVods3CHwJYM89H0j75FwDxc6++m0Ux/6BgdlRpux8Ecrt7SfDtkHuurYbRP2nw6
         itGrqGtvJ5W41J/FqvCBwZP8BMfL/8Tx9vvx+uattVBaQu/0/gaMBbRoKl2WPKYcx4N7
         e6lC/4r17a08BK/FhXTFky7k+4Xou3dQEGsGuTeZZ4cxigzV8TEhr1T/OUlh1i6PneDN
         XKOA==
X-Gm-Message-State: AOJu0YzmlZKtWi0YovxFXOJMeu54Elp73eV2g5IE3kyqcuEXmH/EVOOy
	IXPU8pBd2Hs14EAu0r53kiJxhf3rbvgV0S3Fe94QuyCSZnMseF9EDhMvB7d63PzrE7rtypB++A1
	1Yit5YB5KAb4Q7fKeVO5h+oHsLhpTCXWdSToDzrmaDQ==
X-Gm-Gg: ASbGncuQBzPee2ceeWd9Ff39Ns1WxfkqkIsBhWmDHeu5rl7inOQW3y771W63qfSCBIc
	vxdCu64BAvLTZRHEyDOOufsiCGsj8Fr4SP4zOdnIFAlulC2eHWcOQeWIfsFPsafYTXuztbIstBY
	Ral5g8sN2fkFo+wp2h8vEZu09xCuWU/RqK0SWgpiC6wrq7NtXdvYsfJlhwmuzDN+Zfg4gyUzJ0Z
	CdCNYSKta0Qz1FbpxePWp3G1WwiXxUunTjUNvFXltRkY9LairQ6GlZsUeZ9xg==
X-Google-Smtp-Source: AGHT+IEut91HJmfSs3799eVqsxwdMr6zHhHhc1/iIvEv2KM762zD6NDcJ1Xclh6t3YwkDZrmCLW33rwcsKuTtN39sMc=
X-Received: by 2002:a05:690c:6008:b0:783:fa30:b783 with SMTP id
 00721157ae682-786485afedamr24175417b3.69.1761905063556; Fri, 31 Oct 2025
 03:04:23 -0700 (PDT)
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
 <CAPDyKFr=uVS0CsuFnTjXH+o+P+xrG7GKj2O92mGgqiSo-tk9Bg@mail.gmail.com>
 <CAJZ5v0g2TebJDR5SWdFfyU7dksShZV0qXeO+yP6V_QTCsE--AQ@mail.gmail.com>
 <CAPDyKFpBHZ758khTGhidcyYCwy7dDtkabJ4trg4K16BhWEpUYA@mail.gmail.com> <CAJZ5v0jdT28Q0mnyU_2RKEYWhEHhQvWBAzsra1Jp9dBCLSCO1Q@mail.gmail.com>
In-Reply-To: <CAJZ5v0jdT28Q0mnyU_2RKEYWhEHhQvWBAzsra1Jp9dBCLSCO1Q@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 31 Oct 2025 11:03:47 +0100
X-Gm-Features: AWmQ_blhjMdakPq54VnrjwOCuXofMbvgMHqoyIVU62N3sTzQMJnLhn4YdtuO4nA
Message-ID: <CAPDyKFo6DT0cagnEQ61_UkEet6Ao60xfFM=YJ3VQqUYH8KeJyg@mail.gmail.com>
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

On Thu, 30 Oct 2025 at 17:36, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Thu, Oct 30, 2025 at 4:13=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.o=
rg> wrote:
> >
> > On Thu, 30 Oct 2025 at 15:06, Rafael J. Wysocki <rafael@kernel.org> wro=
te:
> > >
> > > On Thu, Oct 30, 2025 at 1:44=E2=80=AFPM Ulf Hansson <ulf.hansson@lina=
ro.org> wrote:
> > > >
> > > > On Thu, 30 Oct 2025 at 13:29, Rafael J. Wysocki <rafael@kernel.org>=
 wrote:
> > > > >
> > > > > On Thu, Oct 30, 2025 at 1:26=E2=80=AFPM Rafael J. Wysocki <rafael=
@kernel.org> wrote:
> > > > > >
> > > > > > On Thu, Oct 30, 2025 at 1:23=E2=80=AFPM Ulf Hansson <ulf.hansso=
n@linaro.org> wrote:
> > > > > > >
> > > > > > > On Wed, 29 Oct 2025 at 15:53, Rafael J. Wysocki <rafael@kerne=
l.org> wrote:
> > > > > > > >
> > > > > > > > On Thu, Oct 16, 2025 at 5:19=E2=80=AFPM Ulf Hansson <ulf.ha=
nsson@linaro.org> wrote:
> > > > > > > > >
> > > > > > > > > Changes in v2:
> > > > > > > > >         - Limit the new QoS to CPUs  and make some corres=
ponding renaming of the
> > > > > > > > >         functions along with name of the device node for =
user space.
> > > > > > > > >         - Make sure we deal with the failure/error path c=
orrectly when there are
> > > > > > > > >         no state available for s2idle.
> > > > > > > > >         - Add documentation.
> > > > > > > > >
> > > > > > > > > Some platforms supports multiple low-power states for CPU=
s that can be used
> > > > > > > > > when entering system-wide suspend and s2idle in particula=
r. Currently we are
> > > > > > > > > always selecting the deepest possible state for the CPUs,=
 which can break the
> > > > > > > > > system-wakeup latency constraint that may be required for=
 some use-cases.
> > > > > > > > >
> > > > > > > > > Therefore, this series suggests to introduce a new interf=
ace for user-space,
> > > > > > > > > allowing us to specify the CPU system-wakeup QoS limit. T=
he QoS limit is then
> > > > > > > > > taken into account when selecting a suitable low-power st=
ate for s2idle.
> > > > > > > >
> > > > > > > > Last time we discussed this I said I would like the new lim=
it to be
> > > > > > > > taken into account by regular "runtime" cpuidle because the=
 "s2idle"
> > > > > > > > limit should not be less that the "runtime" limit (or at le=
ast it
> > > > > > > > would be illogical if that happened).
> > > > > > >
> > > > > > > Yes, we discussed this, but that was also before we concluded=
 to add a
> > > > > > > new file for user-space to operate on after all.
> > > > > > >
> > > > > > > To me, it looks unnecessarily limiting to not allow them to b=
e
> > > > > > > orthogonal,
> > > > > >
> > > > > > So what's the use case in which it makes sense to have a lower =
latency
> > > > > > limit for s2idle than for runtime?
> > > >
> > > > Honestly, I don't know, but I just wanted to keep things more flexi=
ble.
> > > >
> > > > > >
> > > > > > > but I am not insisting that it needs to be like this. I
> > > > > > > was just thinking that we do not necessarily have to care abo=
ut the
> > > > > > > same use-case in runtime as in the system-suspend state. More=
over,
> > > > > > > nothing would prevent user-space from applying the same const=
raint to
> > > > > > > both of them, if that is needed.
> > > > > > >
> > > > > > > >
> > > > > > > > It looks like that could be implemented by making
> > > > > > > > cpuidle_governor_latency_req() take cpu_wakeup_latency_qos_=
limit()
> > > > > > > > into account, couldn't it?
> > > > > > >
> > > > > > > Right, but I am not sure we want that. See above.
> > > > > >
> > > > > > I do or I need to be convinced that this is a bad idea.
> > > > >
> > > > > And there is a specific reason why I want that.
> > > > >
> > > > > Namely, say somebody wants to set the same limit for both s2idle =
and
> > > > > "runtime" cpuidle.  If the s2idle limit did not affect "runtime",=
 they
> > > > > would need to open two device special files and write the same va=
lue
> > > > > to both of them.  Otherwise, they just need to use the s2idle lim=
it
> > > > > and it will work for "runtime" automatically.
> > > >
> > > > Right. User-space would need to open two files instead of one, but =
is
> > > > that really a problem?
> > >
> > > It is potentially confusing and error-prone.
> > >
> > > > What if user-space doesn't want to affect the runtime state-selecti=
on,
> > > > but cares only about a use-case that requires a cpu-wakeup constrai=
nt
> > > > when resuming from s2idle.
> > >
> > > Well, I'm not sure if this use case exists at all, which is key here.
> > > If it doesn't exist, why make provisions for it?
> >
> > Well, because it's not possible to change afterwards as it becomes ABI.
> >
> > It would be silly having to add yet another file for userspace, down
> > the road, if it turns out to be needed.
>
> OTOH doing things without a good reason is also not particularly wise.

Right. As I said, I don't have a use-case at hand at this very moment
for why we shouldn't combine the constraints as you propose.

I will send a new version, unless someone speaks up and suggests a
different approach.

Kind regards
Uffe

