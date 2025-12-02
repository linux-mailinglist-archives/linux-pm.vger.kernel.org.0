Return-Path: <linux-pm+bounces-39054-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41C28C9AD42
	for <lists+linux-pm@lfdr.de>; Tue, 02 Dec 2025 10:20:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11F0B3A2A63
	for <lists+linux-pm@lfdr.de>; Tue,  2 Dec 2025 09:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A82230BB9E;
	Tue,  2 Dec 2025 09:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ri1ADWAY"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7026D30648F
	for <linux-pm@vger.kernel.org>; Tue,  2 Dec 2025 09:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764667210; cv=none; b=XueLjUjA+JK89SXQRvD80w/wISdTuXbqr9VfqXHUC6ggKihHW8iigWTgeHCZ9p0hQNNKrY5S5RWROOQfhOz/AN7D8TURXXqSc6wE2rLWLKJi6eVPNw21IkZmJBGTzaWxrMMOxl2NHLyBUg7ZoJHkRAqq89GRDh+VppcbzXMywC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764667210; c=relaxed/simple;
	bh=p810/wFxt30+XMJuBKhOwELVApLhqTRZG35v7mtyi/I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S6jZcoxZjIPOIFDdbQ0W7pZncvq2BfyL8HdYVBcDc3no10BJIGRV95mfgkiXbjO1b83q/aYFgjVOtsC20hX41jNrxg6x1zazAFRxDpE6F6IF8otid4gHEL8uJ/eNta9YQIQBUFVbYLUJcxoLDsehV2yDjtqJpk1ZIbgmTY1Ak/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ri1ADWAY; arc=none smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-640d4f2f13dso4945517d50.1
        for <linux-pm@vger.kernel.org>; Tue, 02 Dec 2025 01:20:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1764667207; x=1765272007; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6/G1G7V8+zBE1pKIYtM+52VzsDzHzaIGvsTpLD+gMEI=;
        b=ri1ADWAYi2d17eMI8j/nh3hD1RWlbvfTM6l+fbC8huelJ3bWloMWT8G3nqz21W1wft
         fjwKHp0lC5fHx503Yi4wwCw/EdRCGbC+LkbNdsHbd4H+oiBZyr3EzVpIq2m0QDIpIgwK
         IhkRJV7AfHvq9y3pHaII0+zV5uCQY8zcM5N0cdDcW4YnhoDJs+HpboMzYG9nFtps4M4K
         llOq6t61nxMpNY6XVNuFPIdCGjG3Qf780yBeeTCnCLxDCS/T0snfS2RnQRhLmEkKculO
         VJzL4sAMsiLVBah7DC2ikpQAfG/lfoNencTiwiS6kLzwqZjQV+56W3HVCvqJBMDbWJY5
         46rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764667207; x=1765272007;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6/G1G7V8+zBE1pKIYtM+52VzsDzHzaIGvsTpLD+gMEI=;
        b=JSh9a1qmlrRaQD/K7gGfO1GPvEO8xNvbFvqpgz77HkAkom1a18ZwkbrZDQnX33ucex
         G1j6iWF3ikPe0I5Y/jIIlQZ17rtCqBkzHHthQiP88AC6FyQ2ske5qlMwkszA6mxfUA80
         5yTy2hNxcpD/NIxrnYS28gYasteNtU8vuctGvVx/D5qsTh6S8hCHooK5YV1FXHdJlWbZ
         Rw8OQzBaH8q1mnobJcci71W6qMZJn/D3uN0snRJFcfQyQs4EWKKaIMefqlXv/U7SEshI
         5a3lRWbbgaQoRfzvRIYhDwJcz6py76q3mHxf3q+g+l8xxxxghrZ0GkQ1n6MDve7hbaCG
         ZNcg==
X-Forwarded-Encrypted: i=1; AJvYcCW1gKrudViHe3tKnnnvk51Qem5cuOL1DdEpycKyQKYtlQzzL//6sLlGVuwMhOa+hu3rNMm1fxsG5w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxc623N26M0XeW5xSAMox4IcatEcNU82mXn1yAuBniSv5kUUYy8
	Ag6U+n6HFaXOvOrGdaxIC6pz1A2/Map1YfqDeG1hNgf0PRkttmp8cGs81yb1UszWKkG8s8n21yW
	Gq0I61CS2PEAqJDCO+SbHfbK8A2yE0WnjKBAYhv/KBw==
X-Gm-Gg: ASbGncuiW2P/z3AZhOA/RvYMol4cz6LljU0Nx/Tqri94cea1p0B0abmzuZVQ5ZsnOed
	hJggRVn9kjO7J6YdNNzhFwg4P9tx6mK/d2kdu+Ctvilc05MB4qC3PxcWMJHoTaDSWnmTq3MVUrn
	fmYqgpsMSCfM1vsMY/orFGIfLHMnWn1bT/oYFGwxQjnJ24WAILg2GKCBI0uWcVCC9RHegXuD16F
	h4PoqQo/frOmZYWVn2Aox/9vPSsYwQD9kqco2yeTowIUHAkvf5Qmov+bLFM6oCGdz10hqPY
X-Google-Smtp-Source: AGHT+IGkuXbyoaToK4qQVOIq1jOXA5nA48QYY8kbFfQjrvu13g6Gdd42PllY5qa8o5Gb82O7qdj6GQJgrMUUbzFAi9U=
X-Received: by 2002:a05:690e:1c5:b0:641:f5bc:699c with SMTP id
 956f58d0204a3-6432938698amr16869251d50.74.1764667207316; Tue, 02 Dec 2025
 01:20:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251104-topic-8280_mxc-v1-0-df545af0ef94@oss.qualcomm.com>
 <176418784438.1591314.8587929353938909456.b4-ty@kernel.org> <20251201201440.GA4041208-robh@kernel.org>
In-Reply-To: <20251201201440.GA4041208-robh@kernel.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 2 Dec 2025 10:19:30 +0100
X-Gm-Features: AWmQ_blwJAvHgHxPWpmsgj8k232zQrocoHHqDGTT9KF0aRc5ngfB3LfIo4gucIo
Message-ID: <CAPDyKFoGQJA5UY-96HvfoA7WMb5wYFXFFfFREpMmK29GE7-Nag@mail.gmail.com>
Subject: Re: (subset) [PATCH 0/5] Define VDD_MXC for SC8280XP
To: Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Johan Hovold <johan+linaro@kernel.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Taniya Das <quic_tdas@quicinc.com>, Imran Shaik <quic_imrashai@quicinc.com>, 
	Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>, Jagadeesh Kona <quic_jkona@quicinc.com>, 
	"Bryan O'Donoghue" <bryan.odonoghue@linaro.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Krzysztof Kozlowski <krzk@kernel.org>, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, 
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 1 Dec 2025 at 21:14, Rob Herring <robh@kernel.org> wrote:
>
> On Wed, Nov 26, 2025 at 02:10:41PM -0600, Bjorn Andersson wrote:
> >
> > On Tue, 04 Nov 2025 20:31:05 +0100, Konrad Dybcio wrote:
> > > This has somehow been omitted, leading to potentially stale votes.
> > > On the flip side, the domain will now be powered off, which will
> > > uncover any omissions we've made in the DTs so far.
> > >
> > > Reasonably tested on an x13s without pd_ignore_unused (camera still
> > > works).
> > >
> > > [...]
> >
> > Applied, thanks!
> >
> > [2/5] dt-bindings: remoteproc: qcom,sc8280xp-pas: Fix CDSP power desc
> >       commit: ca079ec3ebed19a12c1bf080496dacbc6fdfbb39
>
> This has was picked up, but the .dts change was not, so there's a bunch
> of new warnings. What's the plan? I know it's separate trees. Can you
> please take binding and .dts changes like these together if there aren't
> driver changes?

I was planning to pick up the driver (pmdomain) and dt doc changes, as
usual. Although, I was waiting for the discussion to reach consensus
around dts patch (patch5), maybe it did?

Bj=C3=B6rn, perhaps easier if you pick the series via your qc-soc tree and
send them as fixes? If so, feel free to add my ack on patch4 (the
pmdomain patch).

Kind regards
Uffe

