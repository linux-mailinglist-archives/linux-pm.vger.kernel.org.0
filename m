Return-Path: <linux-pm+bounces-18441-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BE569E1977
	for <lists+linux-pm@lfdr.de>; Tue,  3 Dec 2024 11:37:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61561166737
	for <lists+linux-pm@lfdr.de>; Tue,  3 Dec 2024 10:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E8761E2318;
	Tue,  3 Dec 2024 10:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OiQ4EYKB"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E34D1E230D
	for <linux-pm@vger.kernel.org>; Tue,  3 Dec 2024 10:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733222257; cv=none; b=Qj4akJIgRD2aVTLzL/jyUhdJHaL1slQcerfeyI8kE4M15WSMj154vgB7hsgL2rMdiQkj6nDp0Vxt0QeDBNqQAZG1sSFs7p7AKpSdrR4hH0MudKO9g2GLa4qcRhtWnZ9EM8x/unoYNKqYYfDoTe336FNNMkh5nxbhIDER8GAb+XI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733222257; c=relaxed/simple;
	bh=+R7vJwnPN7TZBrcDtH1Pjz7Gzm8FFyIULIy2HXvkRK4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YVlKUWHdwpfG4nyW5vJVrF+zY8K7939ohXF9EY1U5BY79iV2H2rClkEP61swc6hWu5XWpV+UyRjDUwqBOBZTrHF4qb8dg0YdLhneuumZXp6KMevTwtszsF8FMs+fQNRFz9N0jXkO5MOs+/s3KqiQ7muWM7VwYmJC+qxMaDx/1Ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OiQ4EYKB; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e398dc7864dso3494424276.3
        for <linux-pm@vger.kernel.org>; Tue, 03 Dec 2024 02:37:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733222254; x=1733827054; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sPnwihfdsbfkm/uP14UR3jKNdvWL6NNpvOvZqmBYmGo=;
        b=OiQ4EYKBO06/1lE8xEkyaSRHsU5flCyEJToxmD7p2iClLZPHLvQjuARFuFEs+Q1KMz
         +NOSrnN9my4RbXhDsiiScwm2ynQ4uptLHz59T+5TF4g9NaUCgfFDaOVLamULxXEOjZ2t
         XhqrFqpF/fi8It823oV8jrg4iHmVE5PJnEnrKc+CuJ/IkfSx+CbL6iM+g8DFm5wJXA+x
         Y1EunYXL9ZCcdMSuXLnh2Rj+JhaEfz1zDZOtjlclIwseVI1qIrCuT4YoWNIUfJzfDhjp
         bAjRh42xpQBdO23QoagJrBO2FtcD680ojhX0qeanPTnbY8xwBezO57OPaIGPfnce7K9s
         JR0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733222254; x=1733827054;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sPnwihfdsbfkm/uP14UR3jKNdvWL6NNpvOvZqmBYmGo=;
        b=l2V73TQNkhSTAN4M/m4UNhQpIh8htHafYAUTgsvesBaVrobI+obc0Nkg2sJ2FujsQ3
         YuPb6Sq/NsCLJOLayJCNwSl7cGDzoLMp4YACLORKdEeD9PCNwHuM4yp8YgNwxUHBsmDu
         bq7IMQNqIZygo/MtQiDAHVnTeKHFFqd6xmgoHLCBkyWvmjfHVxdwt2sGoxecsYo5e+Vm
         hLRUBsvG8RMLZTau0ceYz1BqUQ/4qooyP7dFFJNWUEanRJmuPAEmHJUIyTy42UyH62GY
         Fo7Aqg/qewOyIHk3UCMUcOGmVVH90l8Mp5RmULAxv6d3m54GifgGxU577gH1BBWfjQ8H
         juIw==
X-Forwarded-Encrypted: i=1; AJvYcCW00CMyw7ygdCi6YExzVzeq16Euq5AvbGqDSMOtbR25RhwdOiqxdabp7PdjMi+xiMX/YlqkWvZhbQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6CUplbTqGWlhoGu/tVVBR6lLbHRcLJdm23PWIEellzgD1V0r+
	mkWaiJtapLt9B/lDJX795izOPDBCzYA1pkXtUGruzEbfj3uBN8cNd+wo5ZM+um/KpB58z3Kcep4
	iqhBfL5bG8FZlmywvZ6VXRkKQHrmmErwxVV1e/Q==
X-Gm-Gg: ASbGncsz/ZqQsnMKjuD9h7B2yfZX7kUiG5bdz25wtPycNZbZh7HRS+hPBXix8anReD2
	uNlTvfy/A27aUAwEgMOnGufNkNR1mqRG3
X-Google-Smtp-Source: AGHT+IGsG8YQ1ggZzCdJnuPl8QhAuveUqLW8ajO21T6RKY94XRehmhGe1lb+y5bziuBa+IeNh+8txdT/gnk+MIJW+FM=
X-Received: by 2002:a05:6902:2d45:b0:e39:9749:bb2b with SMTP id
 3f1490d57ef6-e39d3e1c5f4mr1383026276.29.1733222254485; Tue, 03 Dec 2024
 02:37:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241202151228.32609-1-ansuelsmth@gmail.com> <CAPDyKFqrY7uLD8ATqH0LghmkHgApQSsGtvGkOTd8UVazGu0_uA@mail.gmail.com>
 <674dd60f.7b0a0220.2ba255.7b7a@mx.google.com> <20241202205738.GA3149730-robh@kernel.org>
 <674e1fc4.050a0220.a615a.6ff9@mx.google.com>
In-Reply-To: <674e1fc4.050a0220.a615a.6ff9@mx.google.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 3 Dec 2024 11:36:58 +0100
Message-ID: <CAPDyKFrb4-oJT2TMgw0SU035S2nO8LZZEOrQOz2mN+pFgZcYDA@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] dt-bindings: cpufreq: Document support for Airoha
 EN7581 CPUFreq
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Rob Herring <robh@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, upstream@airoha.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 2 Dec 2024 at 21:59, Christian Marangi <ansuelsmth@gmail.com> wrote:
>
> On Mon, Dec 02, 2024 at 02:57:38PM -0600, Rob Herring wrote:
> > On Mon, Dec 02, 2024 at 04:45:17PM +0100, Christian Marangi wrote:
> > > On Mon, Dec 02, 2024 at 04:42:33PM +0100, Ulf Hansson wrote:
> > > > On Mon, 2 Dec 2024 at 16:20, Christian Marangi <ansuelsmth@gmail.com> wrote:
> > > > >
> > > > > Document required property for Airoha EN7581 CPUFreq .
> > > > >
> > > > > On newer Airoha SoC, CPU Frequency is scaled indirectly with SMCCC commands
> > > > > to ATF and no clocks are exposed to the OS.
> > > > >
> > > > > The SoC have performance state described by ID for each OPP, for this a
> > > > > Power Domain is used that sets the performance state ID according to the
> > > > > required OPPs defined in the CPU OPP tables.
> > > > >
> > > > > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > > > > ---
> > > > > Changes v4:
> > > > > - Add this patch
> > > > >
> > > > >  .../cpufreq/airoha,en7581-cpufreq.yaml        | 259 ++++++++++++++++++
> > > > >  1 file changed, 259 insertions(+)
> > > > >  create mode 100644 Documentation/devicetree/bindings/cpufreq/airoha,en7581-cpufreq.yaml
> > > > >
> > > > > diff --git a/Documentation/devicetree/bindings/cpufreq/airoha,en7581-cpufreq.yaml b/Documentation/devicetree/bindings/cpufreq/airoha,en7581-cpufreq.yaml
> > > > > new file mode 100644
> > > > > index 000000000000..a5bdea7f34b5
> > > > > --- /dev/null
> > > > > +++ b/Documentation/devicetree/bindings/cpufreq/airoha,en7581-cpufreq.yaml
> > > >
> > > > [...]
> > > >
> > > > > +examples:
> > > > > +  - |
> > > > > +    / {
> > > > > +        #address-cells = <2>;
> > > > > +       #size-cells = <2>;
> > > > > +
> > > > > +        cpus {
> > > > > +            #address-cells = <1>;
> > > > > +            #size-cells = <0>;
> > > > > +
> > > > > +            cpu0: cpu@0 {
> > > > > +                device_type = "cpu";
> > > > > +                compatible = "arm,cortex-a53";
> > > > > +                reg = <0x0>;
> > > > > +                operating-points-v2 = <&cpu_opp_table>;
> > > > > +                enable-method = "psci";
> > > > > +                clocks = <&cpufreq>;
> > > > > +                clock-names = "cpu";
> > > > > +                power-domains = <&cpufreq>;
> > > > > +                power-domain-names = "cpu_pd";
> > > >
> > > > Nitpick: Perhaps clarify the name to be "perf" or "cpu_perf", to
> > > > indicate it's a power-domain with performance scaling support.
> > > >
> > >
> > > Will change to cpu_perf. Thanks a lot for the review!
> >
> > Is that defined in arm/cpus.yaml? No.
> >
> > The current choices are perf or psci though those aren't enforced (yet).
> > Or nothing which is my preference if there is only 1 power domain.
> >
>
> I would also prefer not having to define the names property but I guess
> that is mandatory for the PD APIs? Maybe Ulf can confirm.

No, that's not needed.

dev_pm_domain_attach() attaches a single PM domain, without requiring a name.

But as stated in the other thread, to be future proof, I would suggest
using a name already at this point. Even if it's not required.

Kind regards
Uffe

