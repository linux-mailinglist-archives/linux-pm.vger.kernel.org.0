Return-Path: <linux-pm+bounces-38541-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C0596C84417
	for <lists+linux-pm@lfdr.de>; Tue, 25 Nov 2025 10:38:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B0FD94E514D
	for <lists+linux-pm@lfdr.de>; Tue, 25 Nov 2025 09:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D90562E093C;
	Tue, 25 Nov 2025 09:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GtHwaNJK"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAAF42D7813
	for <linux-pm@vger.kernel.org>; Tue, 25 Nov 2025 09:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764063496; cv=none; b=uuT2qB5w6xD0XUUzaRsRDJWEXfHWZbmz/3d3dvqotPzrJbBXpwi0zH9FrfSIvaejTFjSWjVFpSXj2xjhewfYCTg7voJz6+Nv8zv2y4oofKG1lHk06uwhxVOTYyU6WOETi0qypMWJg/99sREQUdZg/CrsyIMtnd/zrqhbrh2GimY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764063496; c=relaxed/simple;
	bh=mo9t3eTcMtPRtnzld/pfkRdf2OGTB/teUHj1p2RlGbk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QIkg+q7XJ/zH+WW6xeKlI90IU7ber+X6EmZ+U/3642OOq9+zJTdWJty/iMyZhkA1pWyK7/EWbomCX4jR8sYlrUMCcuXQWxH4NimOF1CO3CPbWZChTsSLvKv/KZPrqdwS4zlqcG1p01Po1NSnDr9MI6vhtpStnNkz5F3mO/AfxNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GtHwaNJK; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b739ef3f739so395211766b.1
        for <linux-pm@vger.kernel.org>; Tue, 25 Nov 2025 01:38:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1764063493; x=1764668293; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mo9t3eTcMtPRtnzld/pfkRdf2OGTB/teUHj1p2RlGbk=;
        b=GtHwaNJKVNFGcDAKBk9hOQ2W9RyBd8sFJTfsZCuOdDINo9JOU7btHBFsNecuJuluk4
         4G007QFzVyz/8OH47HMYkASS/T8byvHvudxefPCo0hupkO7TpXSJHeqc/Zh0FZvNF6Q8
         4pgqSibGa6LVx7YWWN02lvcbqyfP/RvbqmSQN9/BWX+RsRraxL+fmSEiDT8zui4p4TW7
         1bM8SBlvwG3tCmWS6mXBfdtdzgClShtzWGxU8xQCHdOkFZLPAVB1d+Vziie5xUbUw0ci
         sYnU1Mnji++eZWWhICx+Z0O16zjpXj7KhacN16YbV1jl9tGGOoYZqeK5Ji6Y9F031s9j
         EOmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764063493; x=1764668293;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mo9t3eTcMtPRtnzld/pfkRdf2OGTB/teUHj1p2RlGbk=;
        b=LlBRyWschTbhKQqZqmLPHF2RKBCUJ8OEC+d+shK2ze+aKhmbudnw5FX5GKAZeUArXx
         1ZdSLGkGd2vWeiTrqYHY+LRrFoT00DqpgM44V68s3Qala9Klvt+D9ok9FvS5c51fVlNr
         /qY3aiCc8x6p9lQQ3JHj7JlbiLqC822aVnxGZWDA7mLixWgnC+OEfLVywVlgadlzrVyI
         X7+v8CZr0+9nFljdrhmexfIMcLL57cR93c+HDAnzwobhSfMbA/F1T6cEt0eGFy5B8at+
         EPdJba6pRMzd72g+2WUasnTwwZ/Wt5ewo0/ywIc36zB2XcFomTcLeRK5/eD1xmBWw2iq
         /W4Q==
X-Forwarded-Encrypted: i=1; AJvYcCXFXogY7Ow3bkXm1+gTuVmvMP2606fcSGRLITL9KsV5koOQIkd5IDzYpHbs/YfGkpn4vdTvTxo0HQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyB9TP8TRa62hyUKNRSp3N9Ix6YKtRvqaK0ZBTyW8UuZnFeNfPh
	bEBvc0uBRW3nu/0GiLSRcV+7WixqWCPDHYaaog1HmgkWhYzO0OCMDOnmlZt9FbJ4j5ZEo1GEk35
	dbUt4txp1hdEboGbgOBcdw1VUUZofPHo7M2LIXLLizZOnJU3w5Jur
X-Gm-Gg: ASbGncsP8wIh4YqpaSrRrIKnkw2Ajjg2v3hd9JYxjStSomBQB5YYrxM2aravgR8+UEW
	AKOGgvkpkq46O6bKqP93yYs75O+nRjOpvwcb+9Vs0aNglrqDzMxf1lg93mMlRaOrxOZu0WCOfN7
	U7NhSS8nNOPB7tVtDCB6A5SKXWnMBbppcc9VQZV7gj0ecxJnMuKFBE9K7tejahv7AEltmAbIqx/
	f6SolYrt4CQj4MzlHWZV8q2vLMIlPkNHyo5A8/pz4CNkhjSJ1KoYSAM0FSKOri4Ge0MAAnR/NU9
	iGkOd4BLUbifnLwPXYv1YDfF
X-Google-Smtp-Source: AGHT+IEiD2ghBDLGbpnWfAviqFfQgamd4YC2mxYJR6MhqguJJYUPykAEg38zFd2GjKtsTno5OW+gqQFfmuXHZTefq9I=
X-Received: by 2002:a17:906:c14d:b0:b72:599:5385 with SMTP id
 a640c23a62f3a-b76c566c5f7mr214992266b.61.1764063493243; Tue, 25 Nov 2025
 01:38:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251125032437.2056626-1-kaushlendra.kumar@intel.com>
 <71ea7728-6808-4bdf-9437-3746ff8664fc@arm.com> <LV3PR11MB8768D5F17B1F9575DE2804B6F5D1A@LV3PR11MB8768.namprd11.prod.outlook.com>
In-Reply-To: <LV3PR11MB8768D5F17B1F9575DE2804B6F5D1A@LV3PR11MB8768.namprd11.prod.outlook.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Tue, 25 Nov 2025 10:38:01 +0100
X-Gm-Features: AWmQ_bn-Imgz6UC61gL_x3_rUqbs6p0QhqYULfG1cPO5WebWsoS586J04tfAdMk
Message-ID: <CAKfTPtChUavg0TYK_BiA9NnR-9_A1nz49kMASf6g8vCwhpJzcg@mail.gmail.com>
Subject: Re: [PATCH] sched/cpufreq: Fix capacity calc in shared policy update
To: "Kumar, Kaushlendra" <kaushlendra.kumar@intel.com>
Cc: Lukasz Luba <lukasz.luba@arm.com>, 
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "rafael@kernel.org" <rafael@kernel.org>, 
	"vschneid@redhat.com" <vschneid@redhat.com>, "mgorman@suse.de" <mgorman@suse.de>, 
	"dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>, "juri.lelli@redhat.com" <juri.lelli@redhat.com>, 
	"peterz@infradead.org" <peterz@infradead.org>, "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>, 
	"mingo@redhat.com" <mingo@redhat.com>, "bsegall@google.com" <bsegall@google.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 25 Nov 2025 at 10:23, Kumar, Kaushlendra
<kaushlendra.kumar@intel.com> wrote:
>
> Hi Lukasz,
>
> On 11/25/25 XX:XX, Lukasz Luba wrote:
> > Hi Kaushlendra,
> >
> > On 11/25/25 03:24, Kaushlendra Kumar wrote:
> >> In sugov_next_freq_shared(), the CPU capacity is retrieved only for
> >> the CPU that triggered the update (sg_cpu->cpu) and then incorrectly
> >> applied to all CPUs in the shared frequency domain during the loop.On
> >> heterogeneous systems with CPUs of different capacities sharing a
> >> frequency domain, this causes incorrect frequency selection.
> >
> > How is this possible?
> > Is it old or new Intel SoC (a chip name would be also welcome)?
>
> This is with respect to intel platforms which has E-cores and P-cores.

Do you mean that they share the same frequency domains ?

>
> >
> > I would like to hear Rafael's view on such platform configuration.
> >
> > It looks like a hack and the next needed step would be a similar hack
> > to calm down EAS and EM in the energy estimation code...
> >
> > Do we really want to support such configuration in the generic code?
>
> I understand the concern about maintaining the optimization in the hot path.
> Lets hear Rafael.
> >
> >> Calculate per-CPU capacity in the loop and track maximum across all
> >> CPUs for proper frequency calculation.
> >
> > I've changed that loop to speed-up the hot code path triggered from the
> > scheduler. For most platforms (till now) it's fine to get the cpu
> > capacity once for all cpus in the policy.
> > A lot of code is based on this assumption.
>
> Agreed, the hot path performance is critical.
>
>
> >
> > My gut feeling tells me that it won't be the last needed code change
> > if we go that path...
>
> You're right to be cautious. Let's investigate the EAS/EM implications and
> have more complete assessment of this change.
>
> Thanks for the feedback.
>
> Regards,
> Kaushlendra

