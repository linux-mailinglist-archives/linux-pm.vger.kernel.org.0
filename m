Return-Path: <linux-pm+bounces-18443-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 955309E1BAB
	for <lists+linux-pm@lfdr.de>; Tue,  3 Dec 2024 13:07:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA585B64D32
	for <lists+linux-pm@lfdr.de>; Tue,  3 Dec 2024 10:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 821091E25EE;
	Tue,  3 Dec 2024 10:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H0CCYRTl"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19861E048F;
	Tue,  3 Dec 2024 10:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733222880; cv=none; b=gMffWFx/5+LI7zYRRhblpO7I1nc8PSLVj9Twty+SeirwEKoVBKH4zSDY4GeiQZdOM/Fs8uxbSFBgqzBvAFHj70DLivlWLkfuxhryLYIjm4FjSNWupE8HhfcZiWbJLwAOp4bq5RJkX5Zv/0kSRXhCTYknierpFlgL9TuAw4ErBik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733222880; c=relaxed/simple;
	bh=BcOsH/YOUd0qjb+lCoHLHHXm+hf++DGpsNwgIINzoIM=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ezUp/atxGbH9dg6cSycNe4vsYKKvjuNtHbFdxUaGrzmOEuyIH6peAdbAAlSNo1fnkedPfQY+3lBp/xPMBa71gcVBKMsSOnCwoy2rC3RsLj2JO/gJPsWHHNF7ydb7/PlS5pnabAr+VTvkfLkQsTjqENr3lZCpwM3NhjocTxWUwi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H0CCYRTl; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-434aa472617so45724115e9.3;
        Tue, 03 Dec 2024 02:47:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733222877; x=1733827677; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=LpUnABsULWmGSRfspOn9ot1oEJsbuvsgUg5VbDOLzbU=;
        b=H0CCYRTlkiKkUf2CQKSXOXHJHNpc9c5J2XCjKPkNrASzyPlLfPRJ1M4KiLvWXU75fQ
         I38SGsh3zinNSpMCyEUP52AfQbDe2EDiUPfL/O8pE8dXB5OG5DW4f4a9Sg38JCfE4U1E
         R77G5e7s5TWNcn++1/Di3PbhPKXHZgR9Xl0mPposBA1b4oJY4AKWOZBiqDB7VKcu9H8Z
         tYIndiF+E1rni5ChcI1TmuONpJT+b5QB9moo8EtTVGZLFpjIDHhngVOO9JrSWmYZ+xCJ
         uknfLUS8dLpCIsponglkp6dzKt+VMNKebYUQabe8wfRPaQbx03hWqQXZ3vDoqRVLrMhn
         4klw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733222877; x=1733827677;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LpUnABsULWmGSRfspOn9ot1oEJsbuvsgUg5VbDOLzbU=;
        b=SrWsz2KBVWOxe9mWa+l9soxspwWSQC2zLmT4LzmqXgGx+Q+YHXqlepPY5EZJ7nBFce
         ALHC8ukzllx89BxY2IkKm+RiGxHiJtH/83k4D3ixrGM6/iXh0+wREN1FFhLbTT/yjgrM
         9VtdIEqeN2L4xa26qPNphZinQh75HVNUMFA7jYaNlW/xmNm2dfPC+i3J+1JW+YFcqrYr
         PR1okAbmQiuubfPr8T/xrgDbuOYKSe60+UgbRBry0QTOVDxzUl2Ay9MXoM5J/Nqrc3Fv
         aJHrXQtTVVipH++EOKhXOX+xS31Xyo21WAFA2PVTTEsDy75sAm0zoWhY7xTQ1qAC8LQZ
         ysDg==
X-Forwarded-Encrypted: i=1; AJvYcCU7A5N9X1vFQF6GOduoN1FPa6Udb4DR3VN+3uZwMDSCNNstcuPO7TrVXepb7o0cJh3mSkx3R8ET9j+8RiaL@vger.kernel.org, AJvYcCWDWPd2RsvTjPWLyKhyRWLIpuVaRuN0TpBNqLce9hljMr6JfKSxEMYO1wiFXoq/wp88CehkMNbaTpI=@vger.kernel.org, AJvYcCXs/w+19NNcAXYVOAetEfFaEulL04TQINoldBMM6PY7PU/DlSiSaXS/kaiIrHOVg20T5jDPvVOCaveN@vger.kernel.org
X-Gm-Message-State: AOJu0YyQv7JMxCW5N9t7FzhRsN9iIvPJ+TYgr4hC5muMz97EMCs18bDY
	b0AiSktyhoKFtuzohjMdYGlVa02dNzMONVkyWPkealjshNjupp76dnUB7g==
X-Gm-Gg: ASbGncvC325jb3wwwccG3Rnr5uAyqL5yGnTxctn09B5KZEbWcKziz9nLTZ9CYCeTR9Q
	Vf5JN42bud9cabhYxdAvaS4oKY5VtUQcDBG6+yXO4luve1z6WDRg4yKPR1tDDvwlG4GuVy3TMVa
	LBBMJmEmIx7nNMjR9wVEMIG6kMVMNzwBEixlJee+X9wNA2uCrSsts8waYAV26Jy2LL3kK+S/yOc
	4l8IeX657FvLYLt+QKL37Iu9LWrHGLr0lFtCAbwY38ChRpX8NDN9d7SRFZ+4zlqHdNFgVKUE7z+
	OCGBwQ==
X-Google-Smtp-Source: AGHT+IEcvxKULQvZ0AGJeUaKLgigFDpZIVKxIZtM+IyAs3cN7nNgaLZ1L2XXIEIKTNKA7XHEZt80WQ==
X-Received: by 2002:a05:600c:3b8c:b0:434:a4bc:535b with SMTP id 5b1f17b1804b1-434d09bf66dmr16319695e9.11.1733222876642;
        Tue, 03 Dec 2024 02:47:56 -0800 (PST)
Received: from Ansuel-XPS. (93-34-91-161.ip49.fastwebnet.it. [93.34.91.161])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434aa7d1a90sm215537385e9.32.2024.12.03.02.47.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 02:47:56 -0800 (PST)
Message-ID: <674ee1dc.050a0220.13fa34.f758@mx.google.com>
X-Google-Original-Message-ID: <Z07h11mY06p03YdQ@Ansuel-XPS.>
Date: Tue, 3 Dec 2024 11:47:51 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Rob Herring <robh@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	upstream@airoha.com
Subject: Re: [PATCH v4 1/2] dt-bindings: cpufreq: Document support for Airoha
 EN7581 CPUFreq
References: <20241202151228.32609-1-ansuelsmth@gmail.com>
 <CAPDyKFqrY7uLD8ATqH0LghmkHgApQSsGtvGkOTd8UVazGu0_uA@mail.gmail.com>
 <674dd60f.7b0a0220.2ba255.7b7a@mx.google.com>
 <20241202205738.GA3149730-robh@kernel.org>
 <CAPDyKFo6j__CoReyAbeLJkA8JJQhJVc=umNesQRZKm-RxFHCwA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFo6j__CoReyAbeLJkA8JJQhJVc=umNesQRZKm-RxFHCwA@mail.gmail.com>

On Tue, Dec 03, 2024 at 11:33:28AM +0100, Ulf Hansson wrote:
> On Mon, 2 Dec 2024 at 21:57, Rob Herring <robh@kernel.org> wrote:
> >
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
> 
> Right. It's not really clear in arm/cpus.yaml what name to use for a
> perf domain, except for "perf" for SCMI.
> 
> If we want to move towards some alignment, perhaps we should update
> the DT doc to make "perf" the common suggestion? I can send a patch if
> you think it makes sense?
> 
> Even if there is only 1 power-domain at this point, we never know if
> another one turns up later, for whatever reasons. That said, isn't it
> better to be specific about a name, already at this point?
>

Ok to summarize

- cpu node: use perf for PD
- cpufreq node change node name to power-domain
- Fix OPP format (already done)

Did I miss anything? It's strange these case weren't catch by
dt_binding_check. Sorry, wasn't aware of all these common name.

-- 
	Ansuel

