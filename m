Return-Path: <linux-pm+bounces-33426-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 89B51B3C20C
	for <lists+linux-pm@lfdr.de>; Fri, 29 Aug 2025 19:50:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53CD92058A5
	for <lists+linux-pm@lfdr.de>; Fri, 29 Aug 2025 17:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2201A1F4631;
	Fri, 29 Aug 2025 17:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rAFZQ45K"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2C11A0B0E;
	Fri, 29 Aug 2025 17:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756489802; cv=none; b=rp4gM1kM9Rh0JS7GekeOKTnchXYMntDKPwtojDwYAIag5Rd1jx838f+e2LkOoY/lQ1zdzebXYvfnJOIkQ8qICkqS31hdcSggvwMW9YHXLQO4A2lUgl9/kd/1V1wVVjDcPP9/yqw4nGk1qVkT68ydw+YnkH0Ntcer9D4p6zCk6aM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756489802; c=relaxed/simple;
	bh=HO/RW4o9Nu4vySZPP932OA2JN2QhGXtVX+onF0gTyCM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kjdNY+qE6hcu6OlFI5RQQU2Nc+GKcV21my2D2QoUZ37TW89/Mld/pWQMHNEBDGFOGLb1jII8Qx8W2qCLOwqQ8vscxF1+S0XiVVMpUhMNxdZAyz42RqE0g5TxZ/ATaeootfR0YdBr20aRgFBZtFEVqewKQhqmnRAOuvgosutXrMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rAFZQ45K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BA38C4CEF0;
	Fri, 29 Aug 2025 17:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756489800;
	bh=HO/RW4o9Nu4vySZPP932OA2JN2QhGXtVX+onF0gTyCM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=rAFZQ45KrOxVq/z08MDEu8Fi2wFRq3vTPTLCl8CIHzckBY3L+J/uyxHmLdHA5tQLv
	 k6Ktm2gbbOgMv6+oMrF2CHvD3OiCOQ8TVSdhUxQBsVe+AA5wRG8z9gKTqAKKcUoOSr
	 ewtdcI0jnveU9pq7+m7eKaae19SoaSdfoc+BQQpSfADXZHB5ire9fS40Qp2pHdi89r
	 No6FwAxHsTHEVPhKJjrOJ1M0t+8zjMBAvCwPQjnkFOnnszLJCrvWR38Aaeb1rOJcP5
	 4CjyuJTSVWMLsAKltZthfEPHH+zoScoYUYtQDaorws+nff6756aCQPMs2iqIjwPH2H
	 Y0jnRhUz4Wa4Q==
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-61e1c0229b3so476017eaf.3;
        Fri, 29 Aug 2025 10:50:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVc/9SY+YX6zU5VT4vryBCqH6Z87/ggnfC/Y+HlmUXk9U/k6vyJ5SUsCs9NRRu5twhf2ojoVZT9qdTe3uk=@vger.kernel.org, AJvYcCXb6nvlQyv9h13qahIsXiS9aev5nQjpSqxQRjTDU97a4pWtpij2MBUiQPuwXd+0o81xxoLIokkj6SQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuLSc6ppDECpt3cWj1GSZzTU/F0KiSBUackrU5pzJ2DdVCaxTe
	75WV4R6F3KOYnNCk8gEQYCvHDWnBwGXC2K6WxLQciwP6PkIC96tGM0agI/V6ZNGMyndIcBbzt5/
	IQqFvq+ojbOyXPH9M9mqzL5ZQITnK8w8=
X-Google-Smtp-Source: AGHT+IH/4F7Y95yhr9HrfP2y6CmzjnYvNG/JUIFAcP9Ob3lK6l1fgTQA3LRGsf4/wxue1OwoidXj6aV8jDWQoNf/QI4=
X-Received: by 2002:a05:6820:824:b0:61e:14fe:dae7 with SMTP id
 006d021491bc7-61e14fee174mr3278356eaf.1.1756489799828; Fri, 29 Aug 2025
 10:49:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <724616a2-6374-4ba3-8ce3-ea9c45e2ae3b@arm.com> <CAJZ5v0gGchbaQWRq39JbrX8chca7uefef763coJeup+vUOfyCw@mail.gmail.com>
 <CAJZ5v0h=OG-wgcZBD8mZ51+kb7j3yeDZQt9XfO=fdasLRgQkEg@mail.gmail.com>
 <CAJZ5v0jdMHd7cRktE8xsQZMTkSK44LZCyFdWzDVLcasvfhJP-g@mail.gmail.com> <39dccf98-41da-4c54-a200-50f367cd0147@arm.com>
In-Reply-To: <39dccf98-41da-4c54-a200-50f367cd0147@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 29 Aug 2025 19:49:48 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0ii4sdpjfNpbxiLKZrooTKgvvSsSbPMc6j3fjZNckhkvQ@mail.gmail.com>
X-Gm-Features: Ac12FXxQ6SEzJLNJ7-awPOC2SCeXVGjRGQgCs2L0cKVq4ssD9m6qbbsk0eU_0aY
Message-ID: <CAJZ5v0ii4sdpjfNpbxiLKZrooTKgvvSsSbPMc6j3fjZNckhkvQ@mail.gmail.com>
Subject: Re: [PATCH] Revert "intel_idle: Rescan "dead" SMT siblings during, initialization"
To: Christian Loehle <christian.loehle@arm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm <linux-pm@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 28, 2025 at 11:44=E2=80=AFPM Christian Loehle
<christian.loehle@arm.com> wrote:
>
> On 8/28/25 20:06, Rafael J. Wysocki wrote:
> > On Thu, Aug 28, 2025 at 6:13=E2=80=AFPM Rafael J. Wysocki <rafael@kerne=
l.org> wrote:
> >>
> >> On Thu, Aug 28, 2025 at 4:44=E2=80=AFPM Rafael J. Wysocki <rafael@kern=
el.org> wrote:
> >>>
> >>> On Thu, Aug 28, 2025 at 4:26=E2=80=AFPM Christian Loehle
> >>> <christian.loehle@arm.com> wrote:
> >>>>
> >>>> This reverts commit a430c11f401589a0f4f57fd398271a5d85142c7a.
> >>>>
> >>>> Calling arch_cpu_rescan_dead_smt_siblings() in intel_idle_init with
> >>>> boot parameter nosmt and maxcpus active hotplugged boot-offline CPUs
> >>>> in (and leave them online) which weren't supposed to be online.
> >>>>
> >>>> With the revert and nosmt and maxcpus=3D12 on a raptor lake:
> >>>> cpu     online  capacity
> >>>> cpu0    1       1009
> >>>> cpu1    0       -
> >>>> cpu2    1       1009
> >>>> cpu3    0       -
> >>>> cpu4    1       1009
> >>>> cpu5    0       -
> >>>> cpu6    1       1009
> >>>> cpu7    0       -
> >>>> cpu8    1       1024
> >>>> cpu9    0       -
> >>>> cpu10   1       1024
> >>>> cpu11   0       -
> >>>> cpu12   1       1009
> >>>> cpu13   0       -
> >>>> cpu14   1       1009
> >>>> cpu15   0       -
> >>>> cpu16   1       623
> >>>> cpu17   1       623
> >>>> cpu18   1       623
> >>>> cpu19   1       623
> >>>> cpu20   0       -
> >>>> cpu21   0       -
> >>>> cpu22   0       -
> >>>> cpu23   0       -
> >>>>
> >>>> Previously:
> >>>> cpu     online  capacity
> >>>> cpu0    1       1009
> >>>> cpu1    0       -
> >>>> cpu2    1       1009
> >>>> cpu3    0       -
> >>>> cpu4    1       1009
> >>>> cpu5    0       -
> >>>> cpu6    1       1009
> >>>> cpu7    0       -
> >>>> cpu8    1       1024
> >>>> cpu9    0       -
> >>>> cpu10   1       1024
> >>>> cpu11   0       -
> >>>> cpu12   1       1009
> >>>> cpu13   0       -
> >>>> cpu14   1       1009
> >>>> cpu15   0       -
> >>>> cpu16   1       623
> >>>> cpu17   1       623
> >>>> cpu18   1       623
> >>>> cpu19   1       623
> >>>> cpu20   1       623
> >>>> cpu21   1       623
> >>>> cpu22   1       623
> >>>> cpu23   1       623
> >>>>
> >>>> Signed-off-by: Christian Loehle <christian.loehle@arm.com>
> >>>> ---
> >>>> Rafael, I don't immediately see how to fix this properly so I won't
> >>>> try to, feel free to treat this as a bug report.
> >>>
> >>> Sure, thanks for reporting this!
> >>>
> >>> Well, I think that cpuhp_smt_enable() is missing a check.  It looks t=
o
> >>> me like it should do the topology_is_primary_thread(cpu) check like
> >>> cpuhp_smt_disable().
> >>>
> >>> I'll cut a test patch for this later.
> >>
> >> Something like the attached one, perhaps.  I haven't tested it yet,
> >> but I'll do that later.
> >
> > Works here AFAICS, but my test system is not hybrid.
>
> Yep, on my end as well, thanks!
> Tested-by: Christian Loehle <christian.loehle@arm.com>

Thanks for testing and let me submit a proper patch.

