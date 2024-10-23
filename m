Return-Path: <linux-pm+bounces-16303-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 10B069ACE6B
	for <lists+linux-pm@lfdr.de>; Wed, 23 Oct 2024 17:16:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3135F1C21876
	for <lists+linux-pm@lfdr.de>; Wed, 23 Oct 2024 15:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73B0519DF53;
	Wed, 23 Oct 2024 15:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EY690EMn"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B251E75809;
	Wed, 23 Oct 2024 15:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729696608; cv=none; b=Ox9sc4qYYt40AYK0KyzdYV2lXAHdStw22kYTTCUiduPrZyXKfQbttCuprY1rOltaixdgMe1/KlGGCIkmUOKc/DgO1k5DgfDmLy5FzY4lKudOrgmPp/Mkjox+HOdV0O9sdMt5iE9JJQ2t1IMVyFOykACoNPH5APXQ2610jQspc5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729696608; c=relaxed/simple;
	bh=FZaeFxwTakHihLrqx989jDhtPM0HQAzJj+unQOQ1nZY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jivu+B4MvsZu+/jPLZSwWS0POuQuGK9NrBtBOFKOF7UYSeJX/O91Pfb3WQdnCMXIkaIZ653sIVYszvFnmj0Mf6IkcOZXuvxTTPb0Ol2vxcguK4s7zitvC3vSi2VnBYXKwULcM3+aWU7qawwMN5Egs2viXKHB87pD27sFZb30Bsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EY690EMn; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5c9634c9160so7507922a12.2;
        Wed, 23 Oct 2024 08:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729696605; x=1730301405; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=phceHAwg+WXY0lkOFYuZkDTZVc3u9dtw1vIObZgqv+A=;
        b=EY690EMnNfOkjEh3yjwqGJgF1B3zyFPefeC4LrZiT0+8vAi0+6fNHH696ESTyy/7YS
         mJcU5HxONknPnUkw21OzIZsm057xP0/ubv96iNNhCy6gqMVUpVWrsTmc0v1nnmAHaD59
         BYLiAs2hu2h7JSEoApFcWX+akrQISVFe9kwEN9mIrOTTjmObLPPBfDQbOH1s9HpkI9Hf
         zHjfJKhpPoXhXOXWvDgW+2g3ebpDNfOG6yC9Dywqt46dwAr5Qg6H/Rh9KD+ZYxoYW8a8
         RNJXBXbu+8NQp0kNWoL4BszJVnLz284HWjmYb8MWZFrMfsJWcDPz4128Wotn+Ka1Lpnu
         4toQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729696605; x=1730301405;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=phceHAwg+WXY0lkOFYuZkDTZVc3u9dtw1vIObZgqv+A=;
        b=u2rsm1QUo2+pUU5JV+AxhSjHC0aOy49TJoYkmawrBo2FI65dT/ia0/c8taU328k1cf
         hN+xLm7gNyjGTKte6wLuEbJi8ukQmG9lOXclR0nIRcKSFY42BJHgUD/HBblAw3/jgY1s
         6Rx6LC2bDFA23E4LjElAdvuZOpPiyQbCs3GwtCxQULC6GNT1XTOt7WQ2eN5vk7BIKtn+
         N9iMddlyrMuHxVv1kGsgznZrGbhpW/1p6fgDLfjeYQrVz+F5gN0T5I5t0WmI4RIC5X+3
         bspmPB9hvmRBNMO/dbTQ25aJRP72IqMmt3lUoVdKLlhuVmBpSczdmFPZ219DQ1xdfNA7
         yskA==
X-Forwarded-Encrypted: i=1; AJvYcCWHmiPSsN02s/Ji0dUx1/FwIap8e04TiEvN8NBIgyiMyDJq1EXOySHp8l2LzMi/qpa3T3mdGEYchCFLJCr+@vger.kernel.org, AJvYcCWVlv99TQE3BfGa/QmePRHA+U0lyaJLOrh4Fs9hD9W0L0AAZXLQgZdvN4fkLCl19OxlHU4XBUUSrqeQL++uDyuMKuqy@vger.kernel.org, AJvYcCWd9Ou/nINyy+cIDY4iL7GyVwPmTf9L4EXh/2rlauxyJFbjUTOpZfupqq9G/aCgJi+KtbzVQNRPa+U=@vger.kernel.org, AJvYcCXEbZkTE6V/7+B2BQTBhq9V+aw52/L6y8peeDWs9dzaXJLRkWKOIQFf+6370/gQm4+vY5JA8zcz7uw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8MA86pupxMpgnIiav1i9dayRZW36WuZp7Ku2b8DD0BKcQqGNS
	YxaNuQ+flrflw7RP/rDfZVGe/BUTBco474T5GZ1tZAgYFPQJsv7LuLIu9WMRTjnVM6lwHTTy40g
	EHkn7VFEH4v0NeTJMQ7fnUGvvuqk=
X-Google-Smtp-Source: AGHT+IGoe9wcQG7zaMf2n0bH4O9DhUNomfztRdDZyWgHh9DssAx3EIjRggFtWPZ2Zdqal/AXcNMgxtzRrpvIThvqlJc=
X-Received: by 2002:a05:6402:42ca:b0:5c9:6f8f:d7c6 with SMTP id
 4fb4d7f45d1cf-5cb8ace953fmr2572362a12.13.1729696604707; Wed, 23 Oct 2024
 08:16:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240922132636.34413-1-0xff07@gmail.com> <20240926005952.5ba2fda4@rorschach.local.home>
In-Reply-To: <20240926005952.5ba2fda4@rorschach.local.home>
From: Yo-Jung Lin <0xff07@gmail.com>
Date: Wed, 23 Oct 2024 23:16:32 +0800
Message-ID: <CAHhBtNomV6bCcau7sVU9G=pPWtX3XTvr4_pEkjqLGzs=-OZLUA@mail.gmail.com>
Subject: Re: [PATCH] trace doc: document the device_pm_callback events
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel-mentees@lists.linuxfoundation.org, ricardo@marliere.net, 
	skhan@linuxfoundation.org, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Jonathan Corbet <corbet@lwn.net>, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Rafael and the PM maintainers,

On Thu, Sep 26, 2024 at 12:59=E2=80=AFPM Steven Rostedt <rostedt@goodmis.or=
g> wrote:
>
>
> This needs an ack from one of the power management maintainers.
>
> -- Steve
>
>
> On Sun, 22 Sep 2024 21:26:28 +0800
> "Yo-Jung (Leo) Lin" <0xff07@gmail.com> wrote:
>
> > Add documentation for the device_pm_callback_{start, end} events
> > under the "Subsystem Trace Points: power" section.
> >
> > Signed-off-by: Yo-Jung (Leo) Lin <0xff07@gmail.com>
> > ---
> >  Documentation/trace/events-power.rst | 27 +++++++++++++++++++++++++++
> >  1 file changed, 27 insertions(+)
> >
> > diff --git a/Documentation/trace/events-power.rst b/Documentation/trace=
/events-power.rst
> > index f45bf11fa88d..7031954f7ed3 100644
> > --- a/Documentation/trace/events-power.rst
> > +++ b/Documentation/trace/events-power.rst
> > @@ -102,3 +102,30 @@ And, there are events used for CPU latency QoS add=
/update/remove request.
> >    pm_qos_remove_request     "value=3D%d"
> >
> >  The parameter is the value to be added/updated/removed.
> > +
> > +5. Device PM callback events
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> > +The device PM callback events are placed right before and after an inv=
ocation of
> > +a device PM callback during a system-wide suspend/resume attempt.
> > +::
> > +
> > +  device_pm_callback_start     "%s %s, parent: %s, %s[%s]"
> > +  device_pm_callback_end       "%s %s, err=3D%d"
> > +
> > +The first two parameters in both events are the same. They are:
> > +
> > +  - The name of the driver.
> > +  - The device whose PM callbacks get called.
> > +
> > +For device_pm_callback_start, the rest of the parameters are:
> > +
> > +  - The parent device of the device (if any).
> > +  - Level in the power management hierarchy the callback belongs to (e=
.g. power
> > +    domain, type, class, bus, driver). Some stages (e.g. early, late, =
noirq)
> > +    will also be explicitly mentioned in this string.
> > +  - The ongoing PM event. You may find definitions of those events in =
the
> > +    PM_EVENT_* macros in include/linux/pm.h
> > +
> > +For device_pm_callback_end, the only remaining parameter is:
> > +
> > +  - The return value of the PM callback.
>

I think it'll be helpful to have your feedback on this documentation
proposal. Would you kindly help take a look? I believe that any
feedback would be really helpful. Thank you!

Best,
Leo

