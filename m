Return-Path: <linux-pm+bounces-17675-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 096C89D00E1
	for <lists+linux-pm@lfdr.de>; Sat, 16 Nov 2024 22:07:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A0332881EB
	for <lists+linux-pm@lfdr.de>; Sat, 16 Nov 2024 21:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A20319AA63;
	Sat, 16 Nov 2024 21:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rwk7rjdf"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92FFC194A52
	for <linux-pm@vger.kernel.org>; Sat, 16 Nov 2024 21:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731791236; cv=none; b=RTwuSt/tjUKPNnTnfwaApQwv/UUwy85fUsQkml80w8S3u9RbL5zWrXPdW2zkNkdDnUo1pLWgzdUdMrtWPSDJNumsa5ozhF0zvC6mn+4gXivoijbz+/kgZG56jf7YmuJJzlF3GcBMO20p5cdu4nzqstZJw6VmwlplsohWuCiBOcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731791236; c=relaxed/simple;
	bh=wqpBju2iQvdpkaXSz/WHEClr7FInLdLGK3LXpaMShVM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lcHBD5nT6YOftotxBVC9HxgJI7MxxVkjqHSwbF2FMQHelX7P78OnYChTe7QFC4bsTEo18zjVgKGR1jYpknn1Z9wlAtYlwPUF7JI/OybZmqqfUrmUP9QdtFyEVkuWwcv3zL/9OioD8EC03seH43XWheon/iyOPA3vgpV8PBA+38k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rwk7rjdf; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7240d93fffdso1558382b3a.2
        for <linux-pm@vger.kernel.org>; Sat, 16 Nov 2024 13:07:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731791234; x=1732396034; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wqpBju2iQvdpkaXSz/WHEClr7FInLdLGK3LXpaMShVM=;
        b=rwk7rjdfg+UtK/a/ImbNZ8JXUq1XYgsv1sTBJszEg0EJHlnlTI8T8dejlDOlVY4sbY
         aSAV0Msj+DVxUHiUzQ9Q3gT8j8yCO4lK5I+q2GUBGFT8++L5bDgpdf12fLnJbgz7Vd6/
         T5ABMFBwECjBtl56ffrMnm/E8dhEk57i/iFmyr/qwrMOLenYp03yh4Q+upKFq9cSkE/J
         OqfU/bdOiCnUwpYlF5wlgvM7gWO5IAhRReMNChFiJInXvb7Dfu/V1LDUn6xFKkby7Any
         HbIAvL9CCDKlaZvSa+WkqXh2ZK1gCo6QocW3AbAkdA/IDO/QeWwlhs2r+CG6HSdMuxEP
         yvVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731791234; x=1732396034;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wqpBju2iQvdpkaXSz/WHEClr7FInLdLGK3LXpaMShVM=;
        b=gDK4YJ9wsPt6UN7+ft5tJO4G55mqIz+FzJiksi2i8FzwsgsO8KCoikCx+wk4gKw59v
         gI0p0FfuIsTPFLvCRI2sPgohjMmlvAsd3hsWx7PJCK9gtZeg706VMRDshXFuUyAsNzyf
         7VEInKEiZf+A6/xpK0Mi4V3zxoTEz3Zo4F1H9PkgSGhr7AW3vvJl+xnOmOEhR5QU8RrP
         3Yt0XlNo6Uyc808xC/vVM8H7tj+GZ7gSzw97KStnUm6hLn+0Usk7zSViacVv8O4DPM7g
         K3r5ViHhOHw51hMKEhbkTgI+MZ6I0rcz5fKTRcCqpAgBn+gHBl/6UY1lqqG90SNOyXU0
         qhrg==
X-Forwarded-Encrypted: i=1; AJvYcCUtaSa1h8RmhJg0Uym9xZUbTApfFb28jJNahDnKRRFXVTlTJPfvu08+nasAulpNgm+sw46w6gSOKw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwTc01wF9HbH0/6G5JPEQ/bw/yVZI5yMVDMYTT7S6hy737NbgDS
	9Ek2Zrv8oSrAVGTylreeQXIT/gm20OndeThb/KRw7II3or9fqLiDXYDg064XiDcrU2lrf72efBi
	n2sqYbiwdGsbrdXQ/XIbRhWFoFRXHerzYbkDd
X-Google-Smtp-Source: AGHT+IGvCeKtnZ1h3atqVG9XoO7JlLn/f8YQvwAVTd4IG9CzW/z20P072kn2t4NdRfdPdSWzeZ9Kgu9wcExWmWgdIJ8=
X-Received: by 2002:a17:90b:1812:b0:2ea:2906:a700 with SMTP id
 98e67ed59e1d1-2ea2906aa50mr6456929a91.25.1731791233460; Sat, 16 Nov 2024
 13:07:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241114220921.2529905-1-saravanak@google.com>
 <20241114220921.2529905-2-saravanak@google.com> <2024111648-drilling-jubilant-1285@gregkh>
In-Reply-To: <2024111648-drilling-jubilant-1285@gregkh>
From: Saravana Kannan <saravanak@google.com>
Date: Sat, 16 Nov 2024 13:06:36 -0800
Message-ID: <CAGETcx-+ThXuG_JsFRj+mOL8RY-eECb5_NvUPAQQxpWnZJiDKw@mail.gmail.com>
Subject: Re: [PATCH v1 1/5] PM: sleep: Fix runtime PM issue in dpm_resume()
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, 
	Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Marek Vasut <marex@denx.de>, 
	Bird@google.com, Tim <Tim.Bird@sony.com>, kernel-team@android.com, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 15, 2024 at 11:43=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Thu, Nov 14, 2024 at 02:09:15PM -0800, Saravana Kannan wrote:
> > Some devices might have their is_suspended flag set to false. In these
> > cases, dpm_resume() should skip doing anything for those devices.
> > However, runtime PM enable and a few others steps are done before
> > checking for this flag. Fix it so that we do things in the right order.
> >
> > Signed-off-by: Saravana Kannan <saravanak@google.com>
>
> This looks like a nice generic fix as well, should it go to older
> kernels?

Yeah, it's meant to be a generic fix. But I'll feel better about it if
someone familiar with this code can give it a Reviewed-by.

And as I look at it... I have a bug in there. I think it should be
goto Complete and not Unlock! No idea how my devices didn't get freed
after a few suspend aborts!

I can send it out as a separate patch too if you want. And depending
on when it lands, I can keep it or drop it from v2 of this series.

Thanks,
Saravana

