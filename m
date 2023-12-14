Return-Path: <linux-pm+bounces-1136-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AFBD812AD0
	for <lists+linux-pm@lfdr.de>; Thu, 14 Dec 2023 09:54:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50FC41F21750
	for <lists+linux-pm@lfdr.de>; Thu, 14 Dec 2023 08:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F373E2575A;
	Thu, 14 Dec 2023 08:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Lfc5doqQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B556410B
	for <linux-pm@vger.kernel.org>; Thu, 14 Dec 2023 00:54:45 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-6cef5220d07so3132525b3a.2
        for <linux-pm@vger.kernel.org>; Thu, 14 Dec 2023 00:54:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702544085; x=1703148885; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rK0m97Zm4v3ovKFUMfkKXoPKkccjk/I4Bde8s/uqvK8=;
        b=Lfc5doqQYTSO3iZ1t4glMeEIbfVbUgGoDBdKF3BfalCUJ0aPbMhz6RzCxzXr45+Ycq
         H2xe/iBBS60GUA/r8+xa8d23GshQlyxXvPh9ON1b8rVSVRzdnS0snp4+BowcKqZum/v9
         HF3TUphGcgwAxCoEbMIcBtoKUFUWDTtFtR517N74ZJ2DhqtlfKqYyqYYQUDeRYE1irqj
         XDypx8kr88tXxGzrbakIO9JDQlHf6swdCrVAZxzw0rze4WkuCxpC9AHGdMsEwqcaLdgr
         ENBl2ZtxulWz+6NN+Mviwh1Ig1pUBBdZT3PSgG66nJWRDh9L5SErQbaqsh0RZ4d6Zc0s
         kw8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702544085; x=1703148885;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rK0m97Zm4v3ovKFUMfkKXoPKkccjk/I4Bde8s/uqvK8=;
        b=Aly1zvW9Q1RFrKtMfvTo4kWPkwtjb5V1j19RU4bOuPMqlcIu2Ah/Cl5TRmDgPQD97b
         +sAAn07A9gk0+IfQogUD3lKoXepd8mopGdDaqRv2Dtfh1cVUZE7hgCzF/ujwb9WNI1Pm
         ALEvzfUZUHQUJoj2JGzvRJ1qS4I7UWjnZttgBO7AEXsiMAUVhulHHOwnbmxg7OtfQ38+
         7iaZd1k0fkYrJFTSfPS3VsQvPrBjb/zSHXGcEpPc2tgz1np/58DqS39shIs/2mZwaJZn
         4gKoiXRkvn5I9Gp0zvjeNk9S1u2PDxakfM5D2Ch9wIL+5jpAcZ+PTfmixbVknfvQwJNt
         Mf+Q==
X-Gm-Message-State: AOJu0YxJEKuPD+LoZRPFfs4fKEyzjw23/zXVkeM8Ju5T6PeVZmvI20GT
	46o7flM4eRVfonJ5C0wO+fqsFIxIa7FKO6I+reFkUgVGxlaCdMMf
X-Google-Smtp-Source: AGHT+IGdI7/50FpKOUbpLtBvbGRJ2DilAJ+uakzY6Pk1C1l4dP/sR7vPujANsmVVA5EQ4ejpPjKjBk8CHE5FPrBpAJg=
X-Received: by 2002:a05:6a00:3a1d:b0:6d0:8b0d:b8c6 with SMTP id
 fj29-20020a056a003a1d00b006d08b0db8c6mr3981164pfb.34.1702544085168; Thu, 14
 Dec 2023 00:54:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231212142730.998913-1-vincent.guittot@linaro.org>
 <20231212142730.998913-5-vincent.guittot@linaro.org> <274a6562-46c9-4b03-9295-c24e5eb9e6cd@arm.com>
 <CAKfTPtDKRfF7QzwoDwkGKZ_DJS3ewBncifC37LADfNJwtQfiYA@mail.gmail.com> <e0b1a6a8-0163-4f7d-b876-b7a3e6c74b2e@arm.com>
In-Reply-To: <e0b1a6a8-0163-4f7d-b876-b7a3e6c74b2e@arm.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Thu, 14 Dec 2023 09:54:34 +0100
Message-ID: <CAKfTPtAU2ryefu-4cJ7YSV6Ji8Xofa-6=yAZ+EmUJ+qbsFCfZw@mail.gmail.com>
Subject: Re: [PATCH 4/4] sched: Rename arch_update_thermal_pressure into arch_update_hw_pressure
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: catalin.marinas@arm.com, bristot@redhat.com, linux-pm@vger.kernel.org, 
	juri.lelli@redhat.com, agross@kernel.org, viresh.kumar@linaro.org, 
	rafael@kernel.org, linux-kernel@vger.kernel.org, rui.zhang@intel.com, 
	dietmar.eggemann@arm.com, mgorman@suse.de, linux-trace-kernel@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, konrad.dybcio@linaro.org, 
	andersson@kernel.org, rostedt@goodmis.org, linux-arm-msm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, bsegall@google.com, vschneid@redhat.com, 
	will@kernel.org, sudeep.holla@arm.com, daniel.lezcano@linaro.org, 
	mhiramat@kernel.org, amit.kachhap@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 14 Dec 2023 at 09:53, Lukasz Luba <lukasz.luba@arm.com> wrote:
>
>
>
> On 12/14/23 08:36, Vincent Guittot wrote:
> > On Thu, 14 Dec 2023 at 09:30, Lukasz Luba <lukasz.luba@arm.com> wrote:
> >>
> >>
> >> On 12/12/23 14:27, Vincent Guittot wrote:
>
> [snip]
>
> >>>        update_rq_clock(rq);
> >>> -     thermal_pressure = arch_scale_thermal_pressure(cpu_of(rq));
> >>> -     update_thermal_load_avg(rq_clock_thermal(rq), rq, thermal_pressure);
> >>> +     hw_pressure = arch_scale_hw_pressure(cpu_of(rq));
> >>> +     update_hw_load_avg(rq_clock_task(rq), rq, hw_pressure);
> >>
> >> We switch to task clock here, could you tell me why?
> >> Don't we have to maintain the boot command parameter for the shift?
> >
> > This should have been part of the patch5 that I finally removed. IMO,
> > the additional time shift with rq_clock_thermal is no more needed now
> > that we have 2 separates signals
> >
>
> I didn't like the left-shift which causes the signal to converge slowly.
> I rather wanted right-shift to converge (react faster), so you have my
> vote for this change. Also, I agree that with the two-signal approach
> this shift trick can go away now. I just worry about the dropped boot
> parameter.
>
> So, are going to send that patach5 which removes the
> 'sched_thermal_decay_shift' and documentation bit?

Yes, i will add it back for the next version

