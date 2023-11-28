Return-Path: <linux-pm+bounces-330-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A19F7FB02F
	for <lists+linux-pm@lfdr.de>; Tue, 28 Nov 2023 03:44:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAC37281C23
	for <lists+linux-pm@lfdr.de>; Tue, 28 Nov 2023 02:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B19945385;
	Tue, 28 Nov 2023 02:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1298018B
	for <linux-pm@vger.kernel.org>; Mon, 27 Nov 2023 18:44:12 -0800 (PST)
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-1f060e059a3so2979830fac.1
        for <linux-pm@vger.kernel.org>; Mon, 27 Nov 2023 18:44:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701139451; x=1701744251;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vIiaYcLNnVL5JRkmIsJYvI+qpf8l8XSpov4hm7Y7NQo=;
        b=YMGtxauSXpxJpogUWnxbEWtejasxwSCbYZ2JgEgq4he4kFPRdYdqgPZVDJCBuIwyQ+
         jFtiro7efU80TfXM0WkKp5DOAf7bD24QGNXjENuRDyVM7zXzjbhn2SRj+q3mfvFESTaX
         Wl9HF/fUZ8f4YzeiyAYpKHTnxyKiv3fxTjllVPaLCxqZX4Tg5dfSz76ejJPA5DqFtigb
         FhB0+H5rI0o5WivDIt04gS4X0PGLz8r5zgdaxorsYd3xhff0KYGS0sNSe+ql68ONtH8r
         8N+Fi+xHDs9WhThrvtnrLYPe8KksBtWhiY2bCvXQYQMgJF3E61qUlThQvLMVElzXdzF7
         pVCw==
X-Gm-Message-State: AOJu0YzxkzdVwFQJrT+yL6Y0tTS971tXv+mzOPYQkshwf+yRq+ftSWhZ
	kvEVsV11RDVWxILv2ohl86U3nVVvF/atziVM8+Ylvuel
X-Google-Smtp-Source: AGHT+IHVa1l4HUorp7Zryq7B+TJfBtHCdRMrdQ2VRHOZb8dnE+lDwjGFjjtJw4chTC04edC7wl8uE6djnThrKCFyZx8=
X-Received: by 2002:a05:6870:524b:b0:1fa:3014:adaa with SMTP id
 o11-20020a056870524b00b001fa3014adaamr9713514oai.19.1701139451402; Mon, 27
 Nov 2023 18:44:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <00d201d96670$e15ab9d0$a4102d70$@telus.net> <CAJvTdKmv-6rp=z=emS1VGdWgTmRfhSUrmUPLk8Hj+5=CvH0+nw@mail.gmail.com>
In-Reply-To: <CAJvTdKmv-6rp=z=emS1VGdWgTmRfhSUrmUPLk8Hj+5=CvH0+nw@mail.gmail.com>
From: Len Brown <lenb@kernel.org>
Date: Mon, 27 Nov 2023 21:44:00 -0500
Message-ID: <CAJvTdKmG2JkJBy4UNc101JZUHzUaC=a=U9Xwg9MgQs7wcDvYrA@mail.gmail.com>
Subject: Re: [PATCH] tools/power/x86/turbostat: Fix added raw MSR output
To: Doug Smythies <dsmythies@telus.net>
Cc: linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 27, 2023 at 9:31=E2=80=AFPM Len Brown <lenb@kernel.org> wrote:
>
> Hi Doug,
>
> I recall puzzling what to do for the system summary row for a RAW added M=
SR.
> In your example 1-package system with a package-scope MSR your patch
> does the trick.
>
> But if there are N packages, the summary will ignore all but the last
> one, which it prints.
>
> Similarly, if the MSR is core or CPU scope, the system summary ignores
> all but the last one, which is prints.
>
> So I concluded that printing nothing, er, zero that is, on the system
> summary row for a RAW MSR was the least likely to confuse somebody.
>
> I'm thinking that the first two hunks of your patch for thread and
> core don't make sense because of this.
> I'm thinking that the last hunk, for package, makes sense, but only on
> a single package system?

Oh, one more bit...
"turbostat --cpu cpu-set" can accept "package" as the cpu-set.  This
will print out one row per package, and will give you the information
that you really want -- even on a multi-package system.  However, it
isn't as pretty as the system summary that you printed, because it
pre-prints the headers (and the system summary) every interval.

It may make more sense to tweak (or simply filter) the output of
"--cpu package" to produce the output you are looking for....


--=20
Len Brown, Intel

