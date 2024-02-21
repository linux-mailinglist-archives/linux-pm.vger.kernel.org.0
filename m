Return-Path: <linux-pm+bounces-4205-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 960E385E509
	for <lists+linux-pm@lfdr.de>; Wed, 21 Feb 2024 18:57:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B76121C241FB
	for <lists+linux-pm@lfdr.de>; Wed, 21 Feb 2024 17:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40E1483CDF;
	Wed, 21 Feb 2024 17:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="grs3g+Tx"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7514584055
	for <linux-pm@vger.kernel.org>; Wed, 21 Feb 2024 17:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708538239; cv=none; b=DR7+0K8G4Z6sPXMbZkLEg0gw0x623xPCrg6tJzfWXY6CaTKt3tounCdPRoJGIDkZpJMpC3KNqsea/8vqCyWjIeq0OZwoVQ0Y6pY5ZzEz8Rc0P0ukIBVQHqStFun7jUWUaB/F5qGLgGpVbAE4k3MIYlbucsiyZLdSHyQZ0e1uIAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708538239; c=relaxed/simple;
	bh=snF2AHY120g3OhxA2vENPtcrzHOEEZsmVGU8tDA7DVc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bL27TfPzIw9a/nxP+/7Ly5NjeEwYiWnz3YbH08xkGQAnmKtjYUBSB2B2ak7HiuSEhOYs8aXWu2ADa6ESkXb6SKCJ9UxCYmuqh1lglRYg02s4dty4ZxZ3B7c6nAytvb47qyK/LDagDIVmaTkNrdDWfoG2AEWW2RQ2n12OZdqrU88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=grs3g+Tx; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-564e4477b7cso110a12.1
        for <linux-pm@vger.kernel.org>; Wed, 21 Feb 2024 09:57:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708538236; x=1709143036; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TNXJGwZ1V9rRdN3pg0jgyM1bnXXSlvPDHdCD030Tkqc=;
        b=grs3g+TxMO16uAGgKnZcudGakRDZfecL5XTEFG9ss2Voo9F35kOIDveQwItKuz7sjv
         0J1V0p81CDM3Qa806IT325Zg78T+3FNFzu9N32yiFuWKB82K6MWq9nLMvwEUn4AoSiVA
         VpmClX0qXO4UKKKuklGinDSGO4JTOOUwSaFHRlUuWC/sEUXd56rKSGu3uKxdGBHRpCXu
         DHCgwgc9ZMj7qBQd1hlaokn24vOFpV4dRBIZiD5jDm4ykztIrTESrhYt5p9fGydmiBvH
         SeOoXC8Zbb0DGjonhK5j+vatUMFvknxmsIG2mY5UBeBMkELd0CHUppSsgHp8Pr8bGKdc
         cLJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708538236; x=1709143036;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TNXJGwZ1V9rRdN3pg0jgyM1bnXXSlvPDHdCD030Tkqc=;
        b=wzhn5iGEzv1gEEwMywgfb9nOuK/6PmiMApwzXEwxrRzQ+rpXDlXz24SjB7S1r/E4uU
         t98eKJzLsNzIjvAIRU/ktxcAqL0ut0j2idZ/OxkHORbOGZcRmKtsKTeof0i72K7i+LV+
         CctoqDpWWm4v2+vxNGOE8/4ykkDOtRKN9nbQaDss3mBfHd8Onf0lKSPGgHOf+wrn8Yb4
         jWg9Hj3bgPyf7qdSVLH8ynmCF2PcwDu8n/kUaO8PSKjosiDJQ99gT/Ea9xBu72dkrh2t
         j5jQb8TFt44KAQeKqR/TmHjfhfc0UvoG/yaHi2p23aoA1ZcnL4C0FZPYVl/ouGIWFai0
         VjzA==
X-Forwarded-Encrypted: i=1; AJvYcCX9SftMcPfI5IUCjBvThQw21X3GY0UxrhxdZ/6Ob/xqKOQ5rk1iAhikLOCBstfRbZxqGN8DI/vfDlxgSu5BfczTFfe0dJbeXQM=
X-Gm-Message-State: AOJu0Yy+5CidGqda4iyAJDdiNL8yMOT50aX2+d4Ekf8pwekgTsW4aSuH
	e8ztAfScMvB4KcuCFqBXVuFqsYXlKqy+9awugYkZ8bqGV9YEYzDUOg3U14Lbq+vn9PQAL8ZofQQ
	8pWu1vC8sUn+Whe2/nRJ3ZQYRzDgS0atj4o2A
X-Google-Smtp-Source: AGHT+IGieBwCGp1ECmxryncPYyi3r957SefzYuTlHBgpp8Lk7jz3qwLnAxBAaJ10d7ZTmmPhPmfgf1P51pspPyb5g/s=
X-Received: by 2002:a50:9fc1:0:b0:563:afb0:28a with SMTP id
 c59-20020a509fc1000000b00563afb0028amr238422edf.0.1708538235826; Wed, 21 Feb
 2024 09:57:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221164112.846409-1-vilasbhat@google.com> <20240221121420.2e32fd00@gandalf.local.home>
In-Reply-To: <20240221121420.2e32fd00@gandalf.local.home>
From: Vilas Bhat <vilasbhat@google.com>
Date: Wed, 21 Feb 2024 09:57:03 -0800
Message-ID: <CAJNZHTTeFJvCjxUX_e_RVtJWcXW=1cjdF8EqvojnObm7jiyLKg@mail.gmail.com>
Subject: Re: [PATCH v1] PM: runtime: add tracepoint for runtime_status changes
To: Steven Rostedt <rostedt@goodmis.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Saravana Kannan <saravanak@google.com>, 
	kernel-team@android.com, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2024 at 9:12=E2=80=AFAM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
> On Wed, 21 Feb 2024 16:41:10 +0000
> Vilas Bhat <vilasbhat@google.com> wrote:
>
>
> > diff --git a/include/trace/events/rpm.h b/include/trace/events/rpm.h
> > index 3c716214dab1..f1dc4e95dbce 100644
> > --- a/include/trace/events/rpm.h
> > +++ b/include/trace/events/rpm.h
> > @@ -101,6 +101,42 @@ TRACE_EVENT(rpm_return_int,
> >               __entry->ret)
> >  );
> >
> > +#define RPM_STATUS_STRINGS \
> > +     { RPM_INVALID, "RPM_INVALID" }, \
> > +     { RPM_ACTIVE, "RPM_ACTIVE" }, \
> > +     { RPM_RESUMING, "RPM_RESUMING" }, \
> > +     { RPM_SUSPENDED, "RPM_SUSPENDED" }, \
> > +     { RPM_SUSPENDING, "RPM_SUSPENDING" }
> > +
> > +/*
> > + * ftrace's __print_symbolic requires that all enum values be wrapped =
in the
> > + * TRACE_DEFINE_ENUM macro so that the enum value can be encoded in th=
e ftrace
> > + * ring buffer.
> > + */
> > +TRACE_DEFINE_ENUM(RPM_INVALID);
> > +TRACE_DEFINE_ENUM(RPM_ACTIVE);
> > +TRACE_DEFINE_ENUM(RPM_RESUMING);
> > +TRACE_DEFINE_ENUM(RPM_SUSPENDED);
> > +TRACE_DEFINE_ENUM(RPM_SUSPENDING);
>
> You could do what everyone else does:
>
> #define RPM_STATUS_STRINGS                      \
>         EM( RPM_INVALID, "RPM_INVALID" )        \
>         EM( RPM_ACTIVE, "RPM_ACTIVE" )          \
>         EM( RPM_RESUMING, "RPM_RESUMING" )      \
>         EM( RPM_SUSPENDED, "RPM_SUSPENDED" )    \
>         EMe( RPM_SUSPENDING, "RPM_SUSPENDING" )
>
> #undef EM
> #undef EMe
> #define EM(a, b)        TRACE_DEFINE_ENUM(a);
> #define EMe(a, b)       TRACE_DEFINE_ENUM(a);
>
> RPM_STATUS_STRINGS
>
> #undef EM
> #undef EMe
> #define EM(a, b)        { a, b },
> #define EMe(a, b)       { a, b }
>

Thanks for the comment, Steven. I did notice both methods of defining
enum values for tracepoints and chose this method because it felt
clearer. Could you clarify on why the method you suggested is
preferred?

> > +
> > +TRACE_EVENT(rpm_status,
> > +     TP_PROTO(struct device *dev, enum rpm_status status),
> > +     TP_ARGS(dev, status),
> > +
> > +     TP_STRUCT__entry(
> > +             __string(name,  dev_name(dev))
> > +             __field(int,    status)
> > +     ),
> > +
> > +     TP_fast_assign(
> > +             __assign_str(name, dev_name(dev));
> > +             __entry->status =3D status;
> > +     ),
> > +
> > +     TP_printk("%s status=3D%s", __get_str(name),
> > +             __print_symbolic(__entry->status, RPM_STATUS_STRINGS))
>
> This will be what you want with that last redefine of EM*()
>
> -- Steve
>
>
> > +);
> > +
> >  #endif /* _TRACE_RUNTIME_POWER_H */
> >
> >  /* This part must be outside protection */
>

