Return-Path: <linux-pm+bounces-18440-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AEF79E195C
	for <lists+linux-pm@lfdr.de>; Tue,  3 Dec 2024 11:34:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31C96164B6F
	for <lists+linux-pm@lfdr.de>; Tue,  3 Dec 2024 10:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04A1A1E22F1;
	Tue,  3 Dec 2024 10:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JEox6NxT"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 420881E1C2D
	for <linux-pm@vger.kernel.org>; Tue,  3 Dec 2024 10:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733222046; cv=none; b=CFKbk6a/iq0VpMbvzFobgn4o2XOfsIyfUgRrZkDMqvgXH6ZW5z/mR72r9naMVjCq0pRn+O+caD/Tc74oF7otjT1LCwQYdtcizu03QPBQd5xLrVsW1soeEIKqa8q5V4Aqdt1CeSkcAYICfPyYpNb1GqKfSHYkcuyrbFe05RbdwuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733222046; c=relaxed/simple;
	bh=oiqw8XoND2FmbU2/4SsQo7fLmzHerYiYCF+7G5GlT3A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NaMELJ3u5FB0xGCoh6QbBZMGpykeqSfLhDfCZ8edYO70Yu4hqUaqupfWIBMSPl3JiKYBktPNY2Pd7qm1m0t5gB4fS2FAji0jNvWOeABrxFzIKQxFQ8c9MyoCxqQKMSEv6m9YhOCP3tsNP1ldB1g4n9niip0sQsJfJFnNRfU32oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JEox6NxT; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e3989d27ba3so2711346276.1
        for <linux-pm@vger.kernel.org>; Tue, 03 Dec 2024 02:34:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733222044; x=1733826844; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jQK7ar67JKwYglynwKxJGbvJNteSxjk5U1jE75IemO4=;
        b=JEox6NxTHnYjaLK+eOr9J+k2YtFECZ+G33+qyikQV0sVsLqC1wDtKEbrsmsy0Jvtrb
         d/ZKmXpCC4iIzS//ApZBBKY4vGp611ogWZR8iEKXyEIs3qZUNcP1suErdsAmQOT9aohS
         RQhp0337oXp8CUlU0nxPRcBOubcKHeWzqfKuRlxpv9eHN/jLTv8nppa/NSurnFOWkMqc
         ZR1j/5k7bdb0yG+eO3+YJKTd+FrqMzbCx395bexF0wiOVU330FbMlYPKVzZbr2wuWrU7
         cvPRA+Q6isbW0SBcPsEQpiTVuuFrKzUS+O/SQuttIE/EOjbL59VQXbQ6+vz73JR2nwpX
         fKEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733222044; x=1733826844;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jQK7ar67JKwYglynwKxJGbvJNteSxjk5U1jE75IemO4=;
        b=hz/ZNkCMsnCECXoydsiDp+9VHQkJKqOpDg5zidZi9/0Z1sqMi1X+p/oH2MvuHl/WBD
         Ytmr/pHO5yxmnv0hcnBHRx3uUEQuXz3vs6n7WiypqZSm6BvRTK8XOOGYqXoxCSoo5oWg
         JTpLvu6xSVN9opF3VayNmN+dX+SQHz0oi/6kVg8jqzDzPPkVuCpG0CT1/E2qV4M2h2E6
         NbBm4c3PrsJrIf4Qv4tMxujU8tdPEKVy+cf6LsnAZXKRT10SvU9jVs2hM7eU+koWLYVB
         5YcxRTUHMHSDd4i9D97/I6D331knAGYXdE/ErEKqk5hfUho1gfRppMSDcJBg5pH9LSFm
         7ZAg==
X-Forwarded-Encrypted: i=1; AJvYcCWeI1MZ2QT1hbaXKkEZaw8Uw1nxuF8hAksgrW+SP7xYe+PHKXfJjCwBsvhkvCZ2d9mOQNzqo4Lueg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzHt4pjWFGmvAEeS4KdIgfSzjNrR2s1+hSsc0xEVTAedoadcMb4
	X3FkgR+vnkz4mnCph5jSZv94uXA9bvgGvlbJABdv+1D8pjOAi9L9Zc34ICyzpyNXhPrDe5rHw75
	VuaNb03Tt0XaD7UX/KNA9C/eR4wVZmmbVlxYfgg==
X-Gm-Gg: ASbGnctym9OGEf7bR909Dz44hKyZH0CrnW5TJCMgOMc1b2VrJRpoAlSKxooyT/K7lCQ
	XZteqnwJ/vmy9/AN1uhBtvq3thRk1TbVj
X-Google-Smtp-Source: AGHT+IGJ789O8/cpiMDOtqTDu0XCjDmHvNriEyJZhkhHYK5mnMb8D1j8jF1kXltIWk7q4f/dmnhwdEP46Xk2IGin9MI=
X-Received: by 2002:a05:6902:1023:b0:e33:1492:cd63 with SMTP id
 3f1490d57ef6-e39d39e657bmr1297740276.8.1733222044243; Tue, 03 Dec 2024
 02:34:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241202151228.32609-1-ansuelsmth@gmail.com> <CAPDyKFqrY7uLD8ATqH0LghmkHgApQSsGtvGkOTd8UVazGu0_uA@mail.gmail.com>
 <674dd60f.7b0a0220.2ba255.7b7a@mx.google.com> <20241202205738.GA3149730-robh@kernel.org>
In-Reply-To: <20241202205738.GA3149730-robh@kernel.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 3 Dec 2024 11:33:28 +0100
Message-ID: <CAPDyKFo6j__CoReyAbeLJkA8JJQhJVc=umNesQRZKm-RxFHCwA@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] dt-bindings: cpufreq: Document support for Airoha
 EN7581 CPUFreq
To: Rob Herring <robh@kernel.org>
Cc: Christian Marangi <ansuelsmth@gmail.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, upstream@airoha.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 2 Dec 2024 at 21:57, Rob Herring <robh@kernel.org> wrote:
>
> On Mon, Dec 02, 2024 at 04:45:17PM +0100, Christian Marangi wrote:
> > On Mon, Dec 02, 2024 at 04:42:33PM +0100, Ulf Hansson wrote:
> > > On Mon, 2 Dec 2024 at 16:20, Christian Marangi <ansuelsmth@gmail.com> wrote:
> > > >
> > > > Document required property for Airoha EN7581 CPUFreq .
> > > >
> > > > On newer Airoha SoC, CPU Frequency is scaled indirectly with SMCCC commands
> > > > to ATF and no clocks are exposed to the OS.
> > > >
> > > > The SoC have performance state described by ID for each OPP, for this a
> > > > Power Domain is used that sets the performance state ID according to the
> > > > required OPPs defined in the CPU OPP tables.
> > > >
> > > > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > > > ---
> > > > Changes v4:
> > > > - Add this patch
> > > >
> > > >  .../cpufreq/airoha,en7581-cpufreq.yaml        | 259 ++++++++++++++++++
> > > >  1 file changed, 259 insertions(+)
> > > >  create mode 100644 Documentation/devicetree/bindings/cpufreq/airoha,en7581-cpufreq.yaml
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/cpufreq/airoha,en7581-cpufreq.yaml b/Documentation/devicetree/bindings/cpufreq/airoha,en7581-cpufreq.yaml
> > > > new file mode 100644
> > > > index 000000000000..a5bdea7f34b5
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/cpufreq/airoha,en7581-cpufreq.yaml
> > >
> > > [...]
> > >
> > > > +examples:
> > > > +  - |
> > > > +    / {
> > > > +        #address-cells = <2>;
> > > > +       #size-cells = <2>;
> > > > +
> > > > +        cpus {
> > > > +            #address-cells = <1>;
> > > > +            #size-cells = <0>;
> > > > +
> > > > +            cpu0: cpu@0 {
> > > > +                device_type = "cpu";
> > > > +                compatible = "arm,cortex-a53";
> > > > +                reg = <0x0>;
> > > > +                operating-points-v2 = <&cpu_opp_table>;
> > > > +                enable-method = "psci";
> > > > +                clocks = <&cpufreq>;
> > > > +                clock-names = "cpu";
> > > > +                power-domains = <&cpufreq>;
> > > > +                power-domain-names = "cpu_pd";
> > >
> > > Nitpick: Perhaps clarify the name to be "perf" or "cpu_perf", to
> > > indicate it's a power-domain with performance scaling support.
> > >
> >
> > Will change to cpu_perf. Thanks a lot for the review!
>
> Is that defined in arm/cpus.yaml? No.
>
> The current choices are perf or psci though those aren't enforced (yet).
> Or nothing which is my preference if there is only 1 power domain.

Right. It's not really clear in arm/cpus.yaml what name to use for a
perf domain, except for "perf" for SCMI.

If we want to move towards some alignment, perhaps we should update
the DT doc to make "perf" the common suggestion? I can send a patch if
you think it makes sense?

Even if there is only 1 power-domain at this point, we never know if
another one turns up later, for whatever reasons. That said, isn't it
better to be specific about a name, already at this point?

Kind regards
Uffe

