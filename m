Return-Path: <linux-pm+bounces-34071-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87B16B475C5
	for <lists+linux-pm@lfdr.de>; Sat,  6 Sep 2025 19:22:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B44EA42A26
	for <lists+linux-pm@lfdr.de>; Sat,  6 Sep 2025 17:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B242266EEA;
	Sat,  6 Sep 2025 17:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZcRTwoQe"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA80B15D5B6;
	Sat,  6 Sep 2025 17:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757179337; cv=none; b=uXqvMqJip1EgWAy7ZwlcPhj51Kh3e/Yt489K//k3+E2HsOZuL2gUckd5KZOohvf6R+RihmiujWOUvU+Q70rJwRHe4KBqTBJT9dvySiIdYgC96C9lLJ1+VtrddX6hNbEMx6CA8DEDtmFA5TyJkFg5NbfQo7dns/2Kmr+K/QjPqxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757179337; c=relaxed/simple;
	bh=GEjc/MZiSs5pA+NLyK1ocRIWX/r07ZJrV7YSReaHnLM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ucsc0Ln7sjDBjvb91x/SMl/aKISe7tYcAsn3aPtaiv/qEGwkRQXeHTD8mXPayNiL22knb4dJCizVFrrm9dkd60slDMpDa2Wp6O+7/5vzWlKusGfXt1+oT8z7044Nt0qld8ZIwdCsxSA6md1iqlPGtvV9l4PzlWX8RNumaqHc1GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZcRTwoQe; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-337cc414358so26404861fa.3;
        Sat, 06 Sep 2025 10:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757179334; x=1757784134; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SLBswoadtY/Z1Rk6E4ozam6v04Xnc0YdjRNFILOtZyE=;
        b=ZcRTwoQe3h+uBR4IR5TzfldISycKzJOIZgqn9QPBTPeHUogOwuJuYcNq9T/X57Guv+
         gBrX8jHoGcHq1RpMO4W5iUWLsfZOglrqLKOwFPnvRzqBvmGJF64jU5lfmnjIlykfsM8o
         e3kr2qTa2SVbts25JbI6ANFJA1DZWutwVFUx0I28zLqpeeumjBnFx1hhJGBwvVobg4Gv
         QqjmuFaSl8WxwSujQM/1t/P2eAT6v+3SWhzsFLWWHM0t7EoLakayL0ef9JYoTVk+qyaV
         aJ/kiHjjlwoXpyX0tlxDjb4C1Esd+bwSuNjeMr6EWczDgABXGSNcdrr3t4/YZ0reh2J/
         ZuGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757179334; x=1757784134;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SLBswoadtY/Z1Rk6E4ozam6v04Xnc0YdjRNFILOtZyE=;
        b=PoMOHHVfbDd/g11JNV9ja+5lzbGF1PTykBl2C+THZs8x9Ac9/rNpAHtqcCXU565FBH
         gNePl9EqUHGxjnHoI/rU6oAOMUnEKDsRhjNefHHPhJ9VuVrTcC0Zr5WVycuNW/E2Gb/S
         FmLkT+6vQiwKiR3Vp7QfU2Yh8I7WGcEjZq+VM3/JyEnHHI5wASE5/9u8JwLV4PbWbhRf
         3CvfEZtoVdST3Qf0ojkpEz9heT1FfGTA7xJety5rPHs3CIl6A3nvNLRLEd9tEJWRgu7x
         IEilyqwszfXXkg1yLYMOC8mZhYZ7uNmGT1Y5/C+zkZaAQoPugXLrTaGTDNPUr6+iuCCo
         LCuA==
X-Forwarded-Encrypted: i=1; AJvYcCU41S8XL+nmzVfBgOZ9zEyw4DeV3NVrRCvSoTRt5DnaFAzL2SRtVa/fCS2JVzHv2VArptOdBjgBzbo8BKZD@vger.kernel.org, AJvYcCUdsyFSFVSa6g0M8z7FkTBaeNNETLqLzxg9pT2Wi9wWJzliJexHMnQun1Zu/yDCx6QFcqHqwfQDf9Y=@vger.kernel.org, AJvYcCUw6s/VuT7TGw+PnUNL42eYi4Iv0rdmq7/Lz2Iu1D/KDyObAb8Dcqd3dcw/w9Jqb5fvthSWvruPnpAx@vger.kernel.org, AJvYcCWWnkgwT5tgDEb7iPckkMWjTprgomop5LJATv7OmDvdrRRoSi4xy1UxiKK5mhhTeWgYznqsSj8yJ2G9N5g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCBOt/++rXcq4I9p2EnjeVmL0CZuIH8h/J/UdoWfQdxAVFfn4j
	miAgANuK9rxZqhPkYBD3mhXS9n1xKFm7sNd/vOo/kGwI5mCDULMGknWANQz9DbPoyQ8zL5+szkp
	AZ/7V28MZ+I49qVTETXGqHuF5wQAMQVw=
X-Gm-Gg: ASbGncvbN+ujHR5+kJBXcU3/rwUeQ6s2RDIpJj0LEiaKCIc/hKtfKEgyT6RXLYEVKk9
	iA/arEMXpYZMxy3pKaPqHqETPxWcVlOIVxIUhjWVpxkWrx8buOhWJgTN+aYc9s0WB6joNWjpg49
	39SJtZp0dbV5Cxq0pxeupHonl0yx+RDLGNNckIZBT6ne0uiXBKW1Hj74XPAIqJUidYJGydAYhAn
	iyQe1g7G8I08bx/vQ==
X-Google-Smtp-Source: AGHT+IGUttnd6bDIZZjIggXw9ycYs2qWr2c6QGeJLhOasz1kEwDXyb69WjepMI4Phdw9wN75p2CmHZHYwxDU9qdmFR0=
X-Received: by 2002:a2e:b8c9:0:b0:338:f:5ce9 with SMTP id 38308e7fff4ca-33b52891a56mr8562581fa.20.1757179333524;
 Sat, 06 Sep 2025 10:22:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250903-t210-actmon-v2-0-e0d534d4f8ea@gmail.com>
 <20250903-t210-actmon-v2-3-e0d534d4f8ea@gmail.com> <20250904-groovy-sheep-of-wizardry-ad0ae9@kuoka>
In-Reply-To: <20250904-groovy-sheep-of-wizardry-ad0ae9@kuoka>
From: Aaron Kling <webgeek1234@gmail.com>
Date: Sat, 6 Sep 2025 12:22:02 -0500
X-Gm-Features: Ac12FXzXqB-Wxx7_0jaBO62-jVTmudr9H9J1HjyTysGTyoh4yJxcTiHR8B2v-C0
Message-ID: <CALHNRZ-3paF4jEVJCbaWt3S3BYLdDT2tHo9K6XrB-eiB6qSEHQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/8] dt-bindings: memory: tegra210: emc: Document OPP
 table and interconnect
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, MyungJoo Ham <myungjoo.ham@samsung.com>, 
	Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, 
	Dmitry Osipenko <digetx@gmail.com>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 4, 2025 at 3:11=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel.org=
> wrote:
>
> On Wed, Sep 03, 2025 at 02:50:09PM -0500, Aaron Kling wrote:
> > These are needed for dynamic frequency scaling of the EMC controller.
> >
> > Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
> > ---
> >  .../bindings/memory-controllers/nvidia,tegra210-emc.yaml    | 13 +++++=
++++++++
> >  1 file changed, 13 insertions(+)
>
> I asked to order patches within patchset in some logical way. First
> patch was memory, second other, third again memory.
>
> There are no dependencies explained, so this looks like groupping
> unrelated patches, therefore SPLIT finally the patchset per subsystem.
>
> >
> > diff --git a/Documentation/devicetree/bindings/memory-controllers/nvidi=
a,tegra210-emc.yaml b/Documentation/devicetree/bindings/memory-controllers/=
nvidia,tegra210-emc.yaml
> > index bc8477e7ab193b7880bb681037985f3fccebf02f..6cc1c7fc7a328bd18c7c0be=
b535c1ff918bcdb2a 100644
> > --- a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra=
210-emc.yaml
> > +++ b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra=
210-emc.yaml
> > @@ -33,6 +33,9 @@ properties:
> >      items:
> >        - description: EMC general interrupt
> >
> > +  "#interconnect-cells":
> > +    const: 0
> > +
> >    memory-region:
> >      maxItems: 1
> >      description:
> > @@ -44,12 +47,19 @@ properties:
> >      description:
> >        phandle of the memory controller node
> >
> > +  operating-points-v2:
> > +    description:
> > +      Should contain freqs and voltages and opp-supported-hw property,=
 which
> > +      is a bitfield indicating SoC speedo ID mask.
> > +
>
> No opp-table?

All other tegra devices have the opp tables in standalone nodes, not
as subnodes to their users. I followed that style here, see patch 8.

Aaron

