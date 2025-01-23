Return-Path: <linux-pm+bounces-20888-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7E18A1A96D
	for <lists+linux-pm@lfdr.de>; Thu, 23 Jan 2025 19:12:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9DCF3AC8B8
	for <lists+linux-pm@lfdr.de>; Thu, 23 Jan 2025 18:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E05D7153BF8;
	Thu, 23 Jan 2025 18:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nbe3o7Ap"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77D81E884;
	Thu, 23 Jan 2025 18:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737655959; cv=none; b=YLWLcQrAY63nzr0EPdg5hMG2bgqtXRFfSflprARUdFbZ97pEzwmqYAV+SznTiLhzGCC/gZt/afF7vCl8iy7k/qq5rHGsR0Em9LWOyJ6PbxQkKBIWgg2TV6O43EMfKJVWdxTbVWYMemayRrm53EfuBOnN1alK4j+1X4OPg5BLLl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737655959; c=relaxed/simple;
	bh=bgGuNN3BkUioqWQdr28i+ANADw4gDPKLHIRGAtMGMAs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iv5O/UtXWBojqZd6K3P7hYw2nvsquQSmdfjU11GmeEeEl7ByEKPDyUxcNgAw7a6SP7/dh5g5p/Q606CLysngIIvMzTP5U20B9MmL4+g9uWIZisFhYuSjrES6w2W5KH7XLipBRFPUb9HfmERQVCoGQ0A7lZIfHs36L0JG341tSY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nbe3o7Ap; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 397B3C4CEE5;
	Thu, 23 Jan 2025 18:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737655959;
	bh=bgGuNN3BkUioqWQdr28i+ANADw4gDPKLHIRGAtMGMAs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=nbe3o7Ap9u495xOf2OGY1Cmr2ZB/mP//qXpdc9lSAZvcjA5+mKWAo6VGtqRwrZpvH
	 4WrkPZIPJEBpftuXejgx9+G9YJHXoQVf4b3/l5vKKT8Lk+IK0Mq/6gB/AypqYoaIzo
	 a8yXzIEbC2w87VbFOBUXzP/R8Oyw6jEgh4kYdBUi6epcF3Vuu8Zk5yZP+/oKl9HBCh
	 VdMgpSZeUaZfoj9sYBEZ61d7Omng9euRUNXJxI2BfBSM2+GEMx1knFJ5mqwp+RVzE6
	 RSHFjKcAcVqr4VsP9G3dj5j8bC13SmfvD9FnPrWQh8ceCD/92FZRJwqTfGfhwag0FB
	 9XwfyELgga3qQ==
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-2a3a40c69e3so650176fac.0;
        Thu, 23 Jan 2025 10:12:39 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUIkr+SNkFjRbhjR89mm0gpqIkdltwy4S8GxH5D1AT65Ds9wUfbNwxF7Aam7MYqxIklnvSO58d+IPU=@vger.kernel.org, AJvYcCUQiUq/4bwKThYr4+5RlbxULIyFF2LdU6PGEKZtKw0Ntcl9XOqY4CiHBMPTq4yYA8p7nUMrN3fd0w+57nU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzlRIo+QsvvOfuKQl8oYVUpP5hb5DdFQtZttb41C1hucrVPnyw
	wH+cO6B7Lqm/yxCChW1ygycsBumascT6yCJ/7sQIqz9DvrKHNyfwXBz+KiRmXWJt7PQOy6FkonT
	LjqpAf+QBdjtHllaFPkRwUzoFkGI=
X-Google-Smtp-Source: AGHT+IGlrX0pmVqYV8aiYCaj3YGZ/jrq7LwUByecTETBFyv4c1xa0wRgpzIknGKPtXL5LNfT58MhkG6kxAsB6L5V6c0=
X-Received: by 2002:a05:6871:7887:b0:29e:6547:bfe1 with SMTP id
 586e51a60fabf-2b1c0842a07mr15751219fac.4.1737655958431; Thu, 23 Jan 2025
 10:12:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4953183.GXAFRqVoOG@rjwysocki.net> <13679187.uLZWGnKmhe@rjwysocki.net>
 <842b1500-9f4f-47e5-9777-ee89351f956e@arm.com> <00fffcc11f41ffd069c499010e89244d4ccb6cec.camel@gmail.com>
In-Reply-To: <00fffcc11f41ffd069c499010e89244d4ccb6cec.camel@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 23 Jan 2025 19:12:27 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gXVYQM5EcQPfEKfLwjoj4yEFF1Lh2q1oXvuFmRyL5JGg@mail.gmail.com>
X-Gm-Features: AWEUYZluNV4iGCeGRJ1exubgEOqYj1L5HxaaPG9OwHi-aPZBVa768h2YvFJ_G3w
Message-ID: <CAJZ5v0gXVYQM5EcQPfEKfLwjoj4yEFF1Lh2q1oXvuFmRyL5JGg@mail.gmail.com>
Subject: Re: [PATCH v1 1/4] cpuidle: teo: Add polling flag check to early
 return path
To: dedekind1@gmail.com
Cc: Christian Loehle <christian.loehle@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, 
	Linux PM <linux-pm@vger.kernel.org>, Aboorva Devarajan <aboorvad@linux.ibm.com>, 
	LKML <linux-kernel@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 23, 2025 at 5:54=E2=80=AFPM Artem Bityutskiy <dedekind1@gmail.c=
om> wrote:
>
> On Fri, 2025-01-10 at 13:16 +0000, Christian Loehle wrote:
> > This would then enable intercept-detection only for <50% of the time,
> > another option is to not allow intercepts selecting a polling state, bu=
t
> > there were recent complaints about this exact behavior from Aboorva (+T=
O).
> > They don't have a low-latency non-polling state.
>
> What folks think about the following idea.
>
> Idle governor algorithm essentially predicts the sleep time (step 1), bas=
ed on
> that, the idle state gets selected (step 2).

No, it's kind of the reverse nowadays.

Step 1 is to preselect an idle state using the idle duration
information from the recent past and step 2 is to refine the selection
using the sleep time information (unless step 1 by itself is
sufficient).

In particular, teo doesn't attempt to predict the idle duration.  It
basically picks up the deepest idle state that wouldn't have been too
deep in the majority of cases taken into account.

> What if we add a sleep time factor and expose it via sysfs. The predicted=
 sleep
> time would be multiplied by the factor (between steps 1 and 2).
>
> Default factor value is 1 (or 100%). If users want teo be more hesitant
> selecting deeper idle states, they can set it to 0.5 (or 50%) or some oth=
er
> value < 1. I users want teo to be more enthusiastic about selecting deepe=
r idle
> states, they set the factor to a value > 1.
>
> We could expose it via sysfs and allow changing in some reasonable range.
>
> The idea is to let users adjust the level of idle governor (teo in this c=
ase)
> enthusiasm regarding deep C-state.

For teo, that value from user space would effectively work as an upper
boundary for the target residency of idle states to select and there
is not too much difference between this and the existing PM (CPU
latency) QoS (limiting target residency is equivalent to limiting exit
latency).

If you want a "latency bias" knob, for teo it might be something
related to what is regarded as a "sufficient majority".  Right now it
is hardcoded to "over 50%", but it may be a different fraction in
principle ((e.g. 5/8, 2/3 etc.) and it may be tunable within some
limits.

