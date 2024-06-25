Return-Path: <linux-pm+bounces-9945-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B8069167E8
	for <lists+linux-pm@lfdr.de>; Tue, 25 Jun 2024 14:33:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4F281F27C45
	for <lists+linux-pm@lfdr.de>; Tue, 25 Jun 2024 12:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8078155305;
	Tue, 25 Jun 2024 12:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B6fZjpz2"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC7A414831F;
	Tue, 25 Jun 2024 12:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719318794; cv=none; b=NagYlL9f3ewqD1CmOxHXtVGz8IURXmjuUZy+OFyLRxl5yyohg39pI/qJ3XuMIYlKyLNKDDSxEtWEaBXPIEYFfAN47Q5IkJj/BZPjZge1xTTWAtxshod9560+wYua4WIUTNHb8dAvF7DjfNGH5bWVSRNiXfje4oaAv1vqooT8odE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719318794; c=relaxed/simple;
	bh=IvZsxcaW6DWWuyobmb7LUklrNc1sMFAOoDwMsv2+SXw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TA2Sj5VfsOm2FYfZ6AyviEz3a1G8T6ZcZTsr8oEht2wSOUstp1vRs0YxqlyZnD59yZQyhvF1CaC7UGFLc5C0bRIUBgSoco7kfal5NAhiUkz+7Jy6W5LD6WIXqWOFtMpmKy9cfxC0Ocago7hh4ppgMF2srjnx4KRORGoBjheROFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B6fZjpz2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 336B6C32786;
	Tue, 25 Jun 2024 12:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719318794;
	bh=IvZsxcaW6DWWuyobmb7LUklrNc1sMFAOoDwMsv2+SXw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=B6fZjpz2qM+OlaAn+QOLgRtJRLrNQmM07NvNguBZvqYOZ52EB8ncyg+CPkbfQpmj3
	 7/ihZezX9cYkMtriQFuAxMvQm3Ue7AYLSkBn/6RbF+RF2S6VsZ1yi7iXbGmC3xZTHE
	 IjqP4uhudcfn8XCtpC7+w1ILaJEbMA2Ew/1URK79ycgFE8dcyNCqbWFo7p5nYdujka
	 au9lyf7iBd8oQA8QVtiULXumJQn7Roex2VVU5uTe+JEuEHiiFh8thh08bi49bb0Wie
	 xfxorqF7b2Y7PxkR2thHf2niEzQtZ2atiZ7DPSGjpuz9atkM04FbMXz9+u6JZH6rPL
	 1B9rPvsH9usEQ==
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-25075f3f472so656859fac.2;
        Tue, 25 Jun 2024 05:33:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVCx55Ve+AzwWOtSunFIaJVcwhYU/h4l2uheD7fuv3EyU3SMGieS/q9sJF0lqGL6yDTXwyW4rVCkO3so/W371MX2Ar/13fH7ZYjnwUNZ+beTQJh0EhzTZSWbrlYVUTLy6jHT6SEj50=
X-Gm-Message-State: AOJu0YyzkEymJv+KXMNqjbi/Teeajn5P9hXkSjdN9YRqLaFo4w+8W1Ri
	iWn5V3dwgt8h92GHhBy/yIdFoopha7WzWhHSSbww4+kSzbIcwfn4oEF/WcK2W5CMI3MDBxR7N90
	T5zuI//tK/bZZoE17GBFH3MrQN1s=
X-Google-Smtp-Source: AGHT+IFRr9D925+0qBI83k8w0CC7kMzAiMaZXAnsNnt6khprfnp9xrRlQy4NDHwFieqMb3UKWHtgvj/qu3nKhOI02rA=
X-Received: by 2002:a05:6870:9a1b:b0:25d:d69:eaf with SMTP id
 586e51a60fabf-25d0d69146bmr7449277fac.4.1719318793453; Tue, 25 Jun 2024
 05:33:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <12464461.O9o76ZdvQC@rjwysocki.net> <ZnpzBuWbKxbrKvoR@hovoldconsulting.com>
In-Reply-To: <ZnpzBuWbKxbrKvoR@hovoldconsulting.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 25 Jun 2024 14:33:01 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gytZB=WcEhFkuoOOf_X1=QBYy7+FnVEWLavXzFZc5E=g@mail.gmail.com>
Message-ID: <CAJZ5v0gytZB=WcEhFkuoOOf_X1=QBYy7+FnVEWLavXzFZc5E=g@mail.gmail.com>
Subject: Re: [PATCH v1] thermal: gov_step_wise: Go straight to instance->lower
 when mitigation is over
To: Johan Hovold <johan@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Lukasz Luba <lukasz.luba@arm.com>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Zhang Rui <rui.zhang@intel.com>, 
	Jens Glathe <jens.glathe@oldschoolsolutions.biz>, Steev Klimaszewski <steev@kali.org>, 
	Johan Hovold <johan+linaro@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 25, 2024 at 9:34=E2=80=AFAM Johan Hovold <johan@kernel.org> wro=
te:
>
> On Sat, Jun 22, 2024 at 02:26:33PM +0200, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Commit b6846826982b ("thermal: gov_step_wise: Restore passive polling
> > management") attempted to fix a Step-Wise thermal governor issue
> > introduced by commit 042a3d80f118 ("thermal: core: Move passive polling
> > management to the core"), which caused the governor to leave cooling
> > devices in high states, by partially revering that commit.
>
> typo: reverting

Thanks!

> > However, this turns out to be insufficient on some systems due to
> > interactions between the governor code restored by commit b6846826982b
> > and the passive polling management in the thermal core.
>
> Care to elaborate on what went wrong here? In my test of the previous
> fix I saw the frequency ramping up in steps as expected when the
> temperature dropped. Under what circumstances would that fail to happen?

System suspend-resume would interfere with that as it would call
thermal_zone_device_init().

> > For this reason, revert commit b6846826982b and make the governor set
> > the target cooling device state to the "lower" one as soon as the zone
> > temperature falls below the threshold of the trip point corresponding
> > to the given thermal instance, which means that thermal mitigation is
> > not necessary any more.
> >
> > Before this change the "lower" cooling device state would be reached in
> > steps through the passive polling mechanism which was questionable for
> > three reasons: (1) cooling device were kept in high states when that wa=
s
> > not necessary (and it could adversely impact performance), (2) it only
> > worked for thermal zones with nonzero passive_delay_jiffies value, and
> > (3) passive polling belongs to the core and should not be hijacked by
> > governors for their internal purposes.
>
> I've tested this patch on the Lenovo ThinkPad X13s, where I could
> reproduce the rc1 regression, and things works as intended with the
> fix applied to rc5:
>
> Tested-by: Johan Hovold <johan+linaro@kernel.org>
>
> The CPU frequency still oscillates heavily but now with a more
> sawtoothed curve.
>
> Not sure if it helps with performance, though, as running the CPU at
> full speed as soon as we drop below the threshold (with hysteresis)
> also means that we get back to running at the lowest frequency even
> faster.

True, but assuming that the reason for the mitigation is still there.
If it's actually gone, it's better to stop cooling as soon as it can
be done.

Thanks!

