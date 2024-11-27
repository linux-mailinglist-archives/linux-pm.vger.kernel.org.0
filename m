Return-Path: <linux-pm+bounces-18142-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A25399DA314
	for <lists+linux-pm@lfdr.de>; Wed, 27 Nov 2024 08:28:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63FED2841BD
	for <lists+linux-pm@lfdr.de>; Wed, 27 Nov 2024 07:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20D7414EC4E;
	Wed, 27 Nov 2024 07:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bQMSM+4t"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F191474BF
	for <linux-pm@vger.kernel.org>; Wed, 27 Nov 2024 07:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732692478; cv=none; b=FApmrBs34x3Io42HZE3TIsM/o2b0OKu5Ge/oZ92WEDw4RJuqpjSywFx8lI8KCDtdeFniJaFCqqxoJbc6YXPT3DV5DzJajI7LR6RVwk2lkZUpSrJ/O2QEr9Q0N4e/y1fLvwY4AeoEnRgIvR97T55EPgh9/mlD+rQkXoEbmz0ZrQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732692478; c=relaxed/simple;
	bh=KuWXTb4LcW8/bpSbKWNdmhYeKVa50JrbQlRXOqHDf6g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nwVazttEmhKSVsz+bYi2OT+GljxcdXt+oH5uasjRvxlCmvnH3aIFVN7IZWAI9tYLiAViyK4VbdBeJKhWHgUn0KbuU49uEtizLLRWmpp8qK4TNWK97ChkVgLlNT0jWZCsPZrs8xOSjSzDjKQS9sA2zpeOtUDCBgqs+XBMRRg90iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=bQMSM+4t; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-aa531a70416so261680766b.0
        for <linux-pm@vger.kernel.org>; Tue, 26 Nov 2024 23:27:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732692474; x=1733297274; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1oZqeCiNDi+VUMlqaFu0Cj3Hfsp6EOFS1u82qR+tNuM=;
        b=bQMSM+4tw/vjfOX+jZyDjv6kOnjYxGY04hohNtiyyh0l4iXojvwLIiUZUqUbiEBFw1
         WoNz3d8wxTmWLHjZfdRGmWnxGBY6A6mSnM4NP7VGU3yLHBHTwo8HvN0J6AMJ7o8aoL9N
         Rj0Tu291pV8Htx5XSYXxFOeGqTWxQe65v0Vc0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732692474; x=1733297274;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1oZqeCiNDi+VUMlqaFu0Cj3Hfsp6EOFS1u82qR+tNuM=;
        b=ufYhIuBQu1+8vCDv5b+cdZqzv+T+VWTZhpyTaJyOlCHms8BPar5GwZ1bEctrbAN77n
         GDiwUBo8KBE7V78KNDFeWCOosN544k6YqbMLUVKD4S/xARZXA72VUNChTPJG+z0syZ0n
         1PUkvDu6+mwrh1r00MbtdXjjsL6FCLGLEERq7hcru7T/NBYYDlni7F7p7IK/TOKZvQXK
         0P1+ufdeq7wkF9OSV+cdN/SkiFaQmaqV1x5gl+kkdHNp1RUZMTXQvduNiD9WRtopsCaX
         SGA9G3TE7a+t9H6I+0cUO/iiN9SXYc9BZQH6VJClbbRAqNQEWzKofRQv2R6PdEQ9G0Te
         Bj8g==
X-Forwarded-Encrypted: i=1; AJvYcCUakVAzbB8803sW/2NJOQ1UDm46edSuMl2Z+GUuSTRPRJ2QXOhrW1i1Nn56yziXznsBGUW+tOrQbA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzLVcBhgVaOOj/PGHXm4sg4ayL2G6zLi9D4A1lxEvQQCj+AvRzi
	lqnT1ZNyn/VspRArkgPDEBCAylEAL25WGMFmy4qvOt4KHe44ONVOjvWOCItcNchOofK7hdzaJph
	IP99I
X-Gm-Gg: ASbGncssK31jN7XV/wa1CAEFtOB3/28h+lkE6iqNjW7TVT6CgVwPIDAdsqqvxT+2tBe
	vnJXZ9zLVZRDhPiprfy7v8dN7k2rm6SZj7yIG6bCXow0vnxUy34SCxgJP/XN1MHbxkxqxkOB2Hk
	7S+LKAOMwswLS39Cv432Rm7dW58sA+94RdAUrF+LVxk8sWumeCDSDKEH6mHAE7ww1f2/mFqck8K
	sNmQm6mUcBkDQ67Xbw7rYgoN9T9IUGJejQEX3/Ebia62P/hTKTx7Q+xYNKTMBKKDGbB7xXNUudf
	400lgjy41vIDVolW
X-Google-Smtp-Source: AGHT+IGppW1Qd19xCXi6HJe83SmCYZ7SlVJKGJJjltXlvgTIANrDzPucrs7Ro3p3zODPH5eW80YBUw==
X-Received: by 2002:a05:6402:348c:b0:5d0:35ba:f12f with SMTP id 4fb4d7f45d1cf-5d080be41fbmr2277083a12.14.1732692474127;
        Tue, 26 Nov 2024 23:27:54 -0800 (PST)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa50b5b9040sm678666666b.186.2024.11.26.23.27.53
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Nov 2024 23:27:53 -0800 (PST)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5cfc264b8b6so4723a12.0
        for <linux-pm@vger.kernel.org>; Tue, 26 Nov 2024 23:27:53 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUwMPP2sAQwfB8t9R/SMAS5WOKuJ/da3zj34QJ1g6fUuwQyhTBkHPmNkt8tb0t2lBOITqQzwOOVzg==@vger.kernel.org
X-Received: by 2002:aa7:d80b:0:b0:5d0:3ddd:c773 with SMTP id
 4fb4d7f45d1cf-5d0819b8bf8mr48974a12.4.1732692472728; Tue, 26 Nov 2024
 23:27:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241125-mt8192-lvts-filtered-suspend-fix-v1-0-42e3c0528c6c@collabora.com>
 <20241125-mt8192-lvts-filtered-suspend-fix-v1-1-42e3c0528c6c@collabora.com>
 <CAHc4DNKmGA-MjTWdZhKygiaRwN7mHnMCf8UPUxH_V16uZifzFg@mail.gmail.com> <f38e4283-7133-4865-b4fe-eafb6bd30534@notapiano>
In-Reply-To: <f38e4283-7133-4865-b4fe-eafb6bd30534@notapiano>
From: Hsin-Te Yuan <yuanhsinte@chromium.org>
Date: Wed, 27 Nov 2024 15:27:16 +0800
X-Gmail-Original-Message-ID: <CAHc4DN+S6mBy_VRTWEqp-uA13zUyadtqPoo+-WZTmwYHofpkcg@mail.gmail.com>
Message-ID: <CAHc4DN+S6mBy_VRTWEqp-uA13zUyadtqPoo+-WZTmwYHofpkcg@mail.gmail.com>
Subject: Re: [PATCH 1/5] thermal/drivers/mediatek/lvts: Disable monitor mode
 during suspend
To: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>
Cc: Hsin-Te Yuan <yuanhsinte@chromium.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Alexandre Mergnat <amergnat@baylibre.com>, Balsam CHIHI <bchihi@baylibre.com>, kernel@collabora.com, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	Chen-Yu Tsai <wenst@chromium.org>, =?UTF-8?Q?Bernhard_Rosenkr=C3=A4nzer?= <bero@baylibre.com>, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 26, 2024 at 9:37=E2=80=AFPM N=C3=ADcolas F. R. A. Prado
<nfraprado@collabora.com> wrote:
>
> On Tue, Nov 26, 2024 at 04:00:42PM +0800, Hsin-Te Yuan wrote:
> > On Tue, Nov 26, 2024 at 5:21=E2=80=AFAM N=C3=ADcolas F. R. A. Prado
> > <nfraprado@collabora.com> wrote:
> > >
> > > When configured in filtered mode, the LVTS thermal controller will
> > > monitor the temperature from the sensors and trigger an interrupt onc=
e a
> > > thermal threshold is crossed.
> > >
> > > Currently this is true even during suspend and resume. The problem wi=
th
> > > that is that when enabling the internal clock of the LVTS controller =
in
> > > lvts_ctrl_set_enable() during resume, the temperature reading can gli=
tch
> > > and appear much higher than the real one, resulting in a spurious
> > > interrupt getting generated.
> > >
> > This sounds weird to me. On my end, the symptom is that the device
> > sometimes cannot suspend.
> > To be more precise, `echo mem > /sys/power/state` returns almost
> > immediately. I think the irq is more
> > likely to be triggered during suspension.
>
> Hi Hsin-Te,
>
> please also check the first paragraph of the cover letter, and patch 2, t=
hat
> should clarify it. But anyway, I can explain it here too:
>
> The issue you observed is caused by two things combined:
> * When returning from resume with filtered mode enabled, the sensor tempe=
rature
>   reading can glitch, appearing much higher. (fixed by this patch)
> * Since the Stage 3 threshold is enabled and configured to take the maxim=
um
>   reading from the sensors, it will be triggered by that glitch and bring=
 the
>   system into a state where it can no longer suspend, it will just resume=
 right
>   away. (fixed by patch 2)
>
> So currently, every so often, during resume both these things will happen=
, and
> any future suspend will resume right away. That's why this was never obse=
rved by
> me when testing a single suspend/resume. It only breaks on resume, and on=
ly
> affects future suspends, so you need to test multiple suspend/resumes on =
the
> same run to observe this issue.
>
> And also since both things are needed to cause this issue, if you apply o=
nly
> patch 1 or only patch 2, it will already fix the issue.
>
> Hope this clarifies it.
>
> Thanks,
> N=C3=ADcolas

Thanks for the explanation!

Regards,
Hsin-Te

