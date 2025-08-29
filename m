Return-Path: <linux-pm+bounces-33366-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 00A50B3B2B0
	for <lists+linux-pm@lfdr.de>; Fri, 29 Aug 2025 07:47:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4EDE581DD5
	for <lists+linux-pm@lfdr.de>; Fri, 29 Aug 2025 05:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A1D71FF1A0;
	Fri, 29 Aug 2025 05:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TE5t6oE+"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99B51A5BBC
	for <linux-pm@vger.kernel.org>; Fri, 29 Aug 2025 05:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756446457; cv=none; b=MlF32lomc4JiFrsNvPc2d81PTXLy3e20YQt4NkkFLoi47WGbhN/11labuKuhtU37/UARzSCFG5YLo1jZOIRNl9hWxY7VgKRtTlYDA+ejhmgG9HvJNOZMBBMxSdg//BeEQ8tMcevFJIUWclw8FttPkm2Vx+OzPh/4QcOVLBnC018=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756446457; c=relaxed/simple;
	bh=Uc/dxRivCX32A5tn4YeaGlRsjiI0bzG6wUPU4K0jjr8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nJw+/gU4TIC87dTYouCezfTJEx/bEyyVFAAZkVOsWTga1LNOV8n7z+HMv5LHI9mJ/QdVKP5gX9HQdt/J16a2A58cCvdjXet2MQp95E81CR+9cgoYT8x5bUzOl8Tb/f64cGFSG+94ivRl731JnZaUiVaSy99KzcgOXbj2FhZ4KLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TE5t6oE+; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3277c603b83so1020704a91.2
        for <linux-pm@vger.kernel.org>; Thu, 28 Aug 2025 22:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756446455; x=1757051255; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SVM2NB/+Q5TwegaC+cQ6efQn2fgkr/tPokgrfCaQZxo=;
        b=TE5t6oE+sSNp0wtZAsyN7SGkWm5OBrOZGJ2WSMgvlBpJ9J/mr+CTynl2bwrO2qcxXA
         yHg6RoGLseTsTCmhccPBImAAxoYTxkpNihWmAGljgrb7EBCFYrf5uFoLP/04vWt2Piep
         YGKg/6ww1CV4IPg1zWNLmMzvjufUI3HofaLMyqEM4tZxbeVUZJK7PllhWFLVJxVgS0f/
         yNRJ61OgazNG6G1MatJ/qNbiEhDE2hPMXYdUwcb5i9TDoLKd0EtZDhz/rL8SAIk4kt7o
         j2C0GfQPjlKUqnzrJczczOtZnGoAVIuJnI/8lOAZg1KMciVg1Iv29u40ZwbwApnmEF8l
         Q1yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756446455; x=1757051255;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SVM2NB/+Q5TwegaC+cQ6efQn2fgkr/tPokgrfCaQZxo=;
        b=KavBGlVByEkMQnJ65uYIOPRmsJCtD/NVJ1pxkYii3NQX47stZQhKWAvNp4v+2ZVSLQ
         23k2zzPz4WXbprOw0TqZ8iO95P0sismFJE+c95ESBpckf7eH+fNyqzUZdhnyg5X6Ue5o
         N4gqTLLTg0x3mQsyo6BL7gbEHR6FpmsRNiYRexb8Xs+XoKV6VBzzuSD2g+iQQy8ap/WJ
         pWVDwlaXMGkapjvLAdHlxuQ98y9DZ9egF8n+1j50DTCGXW/mdIjkm3ztK+8OZQ0NJ5bE
         s0o8BQCmevrhlGtsBNg6O89zYzUspPwFo40r+L0nMrZLjTBWYOpLMaqrEUK9BKxKUAjP
         WYqQ==
X-Forwarded-Encrypted: i=1; AJvYcCXJsvKUa2epue1IXUrrPEvb2ithXOfqgrB8fag6y5bbCUG/fdGPXgO1Z9O+clY+mY+VQgLOq6aOkw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyr911HnwuRxnQO6XwEAdAUFcuicqwBZKuQeK3/uywMOg9/EN9+
	g3XH20HUI+ZgfW4OecaOeHZl7MsFOsEMIPicLDCifuvfhzEUnJuhjLXj3YlQPlmsFVQ=
X-Gm-Gg: ASbGncsFY+t6Csk9/uNvQ+ixfu7QaTqQ5P/x2E7bV0q+SGtDQT/wDJ6fqMDFBkCQ31W
	Ac230bGOzRHzDQrdpZmj0EBdRM15nmCrQOBBDPba1yGvjXBaGX6S70nmXOhTtmKIfrxOzMVHg1D
	5gxER5dPJv+pqeIrRIJI1JU/lwcwh1/XApwrVr1i1WcXOIY73VLsJUBJgB+8EAbcp8gsKdCkv2x
	38vC/S63ZtjfEWvtM3ql9v/4j2hh7NLIU9BdwQZEvryH7rplK9KNva06HezVZPojk+Io8MbJm6T
	NiejP6y/UDO1SvKRfQ/2O7zLLlgr5Ple3BtQ1Zz+ItTyZxfp2OMAcwjtLzbA86J6IsduRh3WPvl
	wTc9aV2P90tPJFVmNkQuOiOZONgCjmoBtL70=
X-Google-Smtp-Source: AGHT+IFGFRX8jr8klOJHgeApacbbUnrvb94Dt+QaaXsozbhIjGsZDvjH/LL4aUVoWgpbErAkB6CKrg==
X-Received: by 2002:a17:90b:3c0e:b0:327:dce5:f635 with SMTP id 98e67ed59e1d1-327dce5f897mr3153327a91.25.1756446454625;
        Thu, 28 Aug 2025 22:47:34 -0700 (PDT)
Received: from localhost ([122.172.87.165])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-327d93547f4sm1536101a91.11.2025.08.28.22.47.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 22:47:33 -0700 (PDT)
Date: Fri, 29 Aug 2025 11:17:31 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: "myungjoo.ham@samsung.com" <myungjoo.ham@samsung.com>,
	"kyungmin.park@samsung.com" <kyungmin.park@samsung.com>,
	"cw00.choi@samsung.com" <cw00.choi@samsung.com>,
	Chun-Jen Tseng =?utf-8?B?KOabvuS/iuS7gSk=?= <Chun-Jen.Tseng@mediatek.com>,
	"rafael@kernel.org" <rafael@kernel.org>,
	Project_Global_Chrome_Upstream_Group <Project_Global_Chrome_Upstream_Group@mediatek.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH v3 1/3] cpufreq: mediatek: using global lock avoid race
 condition
Message-ID: <20250829054731.utl6pmgan6sg4mfn@vireshk-i7>
References: <20250219054209.erwfp7sgzchaiuds@vireshk-i7>
 <e8337c5eee0cadb797bacf26b00f1ca303c5147f.camel@mediatek.com>
 <20250321045624.mwm2mnkqeow5uids@vireshk-i7>
 <2a73b5ca35692c8ffa68c9ff0df73e24a592967d.camel@mediatek.com>
 <20250321060148.adhxjexpnm4dkpnt@vireshk-i7>
 <e1c2c12bace22d1803d16ecbfb32129518d87157.camel@mediatek.com>
 <20250324054333.sgwwksawnybx3lp4@vireshk-i7>
 <06356a55cdb3c34dfc716349d1967f95655b0ab2.camel@mediatek.com>
 <20250416080517.feansrkpycsynk6t@vireshk-i7>
 <CAGXv+5FyR8bt16nLvS0V=_YRWM6G7V0OOpxctA+_4hVnnCjDtg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXv+5FyR8bt16nLvS0V=_YRWM6G7V0OOpxctA+_4hVnnCjDtg@mail.gmail.com>

On 28-08-25, 15:26, Chen-Yu Tsai wrote:
> Maybe a different set of eyes will help. I talked to Chun-Jen offline,
> and I'll try to explain what I understand.
> 
> First of all, the issue lies not in cpufreq, but in the CCI devfreq,
> and how the passive devfreq governor is linked to cpufreq.
> 
> The CCI hardware unit on the MT8186 is sensitive to frequency changes.
> If the performance level of the CCI unit is much lower than either
> of the CPU clusters, it  will hard hang the whole system. So the CCI
> devfreq must always take into account the performance level of both
> clusters, or in other words the settings of both cpufreq policies.
> 
> Since the cpufreq policies only serialize with themselves, it is possible
> for one policy to change and trigger a devfreq update, and when the
> CCI devfreq driver is doing its calculations, the other policy changes
> and causes a big deviation from the assumed performance levels, leaving the
> CCI into a non-matching performance level and causing a system hang.
> 
> So I think we need to handle CPUFREQ_PRECHANGE events for the frequency
> increase direction, as well as enlarging the devfreq mutex to cover
> the CPU frequency tracking bits in the passive governor.
> 
> I hope that makes sense.

If some sort of serialization is required in the CCI driver, then a
lock must be present there to prevent the issues.

-- 
viresh

