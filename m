Return-Path: <linux-pm+bounces-30830-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15066B04F7B
	for <lists+linux-pm@lfdr.de>; Tue, 15 Jul 2025 05:49:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CDDA3AF628
	for <lists+linux-pm@lfdr.de>; Tue, 15 Jul 2025 03:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83DBF270EA3;
	Tue, 15 Jul 2025 03:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O/yaklxr"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571FF22083;
	Tue, 15 Jul 2025 03:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752551346; cv=none; b=WPS91AlZUfR4EtGTZ5WjFAenJTuYzpoAfIHFT0lqqTqYyeG9q9Ph78m3EfxnEVW8l9a4IdzhXOgY4As0dmda9Mjis1128MtJhyY8yBsmwelyejjcpZNYmYPT5pmh8sxtDUeld2B0caBPiB8O/F6qk7MhXKtx7b08zR3yQ5obz/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752551346; c=relaxed/simple;
	bh=gcY+rcVUM18+WL+0Uv5xjyIiT5YsGsvyMAcfAQ3GkXg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GLk7BbAzX3pW9aCh7+M1Ub71PrLGOPPb8u2gwn88xKQPNbFwg8Y86Z6llM4vwTnnwHXrcXTzX33wvGAdPt5QdHIMIv6HWDCMvi7QwYhpO4DAfokhCySAPmF3TjulDBKFUVOPMVRlV0UmB7AUgIvZQ5TVpiU3KCI0H9cgk/Cv9tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O/yaklxr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAD55C4CEE3;
	Tue, 15 Jul 2025 03:49:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752551345;
	bh=gcY+rcVUM18+WL+0Uv5xjyIiT5YsGsvyMAcfAQ3GkXg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O/yaklxrP0q+LJX8BWpX6hyeBc2f/KflPpHmmNR3Fd62d9XmHx1WSIpVtjpX7BwwV
	 HRDq7qIM1rE6yyfcgaHHeT5qm1qUGvAp/RnJz9fBjBMfe1PQ4pc+kvC2zYwjBI0G52
	 8thHGh4Iygy5PkoPsp5ZuQ6vB0eMp7V4Ycsy9tolXO6yIQkAaPvhq/Rdmo/LRHwVgN
	 EDmSV0Zbv7zVOf1f6N2bvOzCrs9+4aGMEYbCQwO/gY52OT+2mdIUzn9Y6g4splBD/g
	 TNlXtNb/z4kwuU7vw1+Du74z1+tgVmd5LCFDG1wXEJRtFjs3wwxbdJzREVRJiRHNcu
	 Qhby4nuvpwwvA==
Date: Mon, 14 Jul 2025 22:49:04 -0500
From: Rob Herring <robh@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>, kernel@collabora.com,
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2 1/4] dt-bindings: cpufreq: Add
 mediatek,mt8196-cpufreq-hw binding
Message-ID: <20250715034904.GA4699-robh@kernel.org>
References: <20250714-mt8196-cpufreq-v2-0-cc85e78855c7@collabora.com>
 <20250714-mt8196-cpufreq-v2-1-cc85e78855c7@collabora.com>
 <fd561a8c-f1a7-41c2-a686-abc89f5fa555@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fd561a8c-f1a7-41c2-a686-abc89f5fa555@collabora.com>

On Mon, Jul 14, 2025 at 04:41:30PM +0200, AngeloGioacchino Del Regno wrote:
> Il 14/07/25 16:08, Nicolas Frattaroli ha scritto:
> > The MediaTek MT8196 SoC has new cpufreq hardware, with added memory
> > register ranges to control Dynamic-Voltage-Frequency-Scaling.
> > 
> > The DVFS hardware is controlled through a set of registers referred to
> > as "FDVFS"; one is a location from which a magic number is read to
> > ensure DVFS should be used, the other is a region to set the desired
> > target frequency that DVFS should aim towards for each performance
> > domain.
> > 
> > Instead of working around the old binding and its already established
> > meanings for the reg items, add a new binding. The FDVFS register memory
> > regions are at the beginning, which allows us to easily expand this
> > binding for future SoCs which may have more than 3 performance domains.
> > 
> > Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> > ---
> >   .../cpufreq/mediatek,mt8196-cpufreq-hw.yaml        | 86 ++++++++++++++++++++++
> >   1 file changed, 86 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/cpufreq/mediatek,mt8196-cpufreq-hw.yaml b/Documentation/devicetree/bindings/cpufreq/mediatek,mt8196-cpufreq-hw.yaml
> > new file mode 100644
> > index 0000000000000000000000000000000000000000..26bf21e05888646b4d1bdac95bfba0f36e037ffd
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/cpufreq/mediatek,mt8196-cpufreq-hw.yaml
> > @@ -0,0 +1,86 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/cpufreq/mediatek,mt8196-cpufreq-hw.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: MediaTek CPUFreq for MT8196 and related SoCs
> 
> title: MediaTek Hybrid CPUFreq for MT8196/MT6991 series SoCs
> 
> > +
> > +maintainers:
> > +  - Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> > +
> > +description:
> > +  MT8196 uses CPUFreq management hardware that supports dynamic voltage
> > +  frequency scaling (dvfs), and can support several performance domains.
> > +
> > +properties:
> > +  compatible:
> > +    const: mediatek,mt8196-cpufreq-hw
> > +
> > +  reg:
> > +    items:
> > +      - description: FDVFS magic number register region
> 
> As already said in the other commit, we might just be able to avoid adding the
> magic number register region :-)
> 
> > +      - description: FDVFS control register region
> > +      - description: OPP tables and control for performance domain 0
> > +      - description: OPP tables and control for performance domain 1
> > +      - description: OPP tables and control for performance domain 2
> > +
> > +  "#performance-domain-cells":
> > +    description:
> > +      Number of cells in a performance domain specifier. Must be 1.
> 
> The description is redundant and doesn't add any real information, I think you
> should drop it.
> 
> Bindings maintainers, please, opinions?

Drop.

Rob

