Return-Path: <linux-pm+bounces-24441-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7919A6D3C3
	for <lists+linux-pm@lfdr.de>; Mon, 24 Mar 2025 06:43:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 182B27A5010
	for <lists+linux-pm@lfdr.de>; Mon, 24 Mar 2025 05:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 291DC16EB42;
	Mon, 24 Mar 2025 05:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rPBjfKRn"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 827EC2D052
	for <linux-pm@vger.kernel.org>; Mon, 24 Mar 2025 05:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742795023; cv=none; b=GnXtsVdSkUa8dhSKIyvlWTf7R5uY1Cj2DEcq+XbtTrxxJ7WWD3NeH8g4VzbZbsnF2L8Zp76QBqLgylbhSo4T+yJNVlamUCsw5rRrIs1CE++UVI302ytCjUAIWMpjyl65p8ePsQMDjG9KE7jW7Kb+Cg7AvXKpJXZfIdVrN1n9alg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742795023; c=relaxed/simple;
	bh=fDHDnmQOUKbYWvor4HRHMJSkRLSzGU857d5h+34i5GQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u9pzqlSUw50exmVrR5TFaQJ+qig7pRwWq1fsXpquy5lBIIRqDlhLTKdQyr8UuuFuiqoPUuY4hQYlirqMuIxOLcEMVzvIo+0kYgTXRNtTqTumUPFwsKHaTPBQAr9QdntKtr9210pRhEwqAGTBoyNt+CXEb9UZ9gI04pYCWjQDGCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rPBjfKRn; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-227b650504fso11841375ad.0
        for <linux-pm@vger.kernel.org>; Sun, 23 Mar 2025 22:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742795021; x=1743399821; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XZYqBd8vEY+viBvNer60WQXhZvWLjiw6xgE86uO2OEU=;
        b=rPBjfKRnVm8KDbb3TrXDHR6FEwfDcJfO4jkn341rsh2yCxAUZuy0PQXb6QzNmHw4GP
         j25mg4yzLN72SVD5R91Borrpqeix6i0wd3Mq1HS6FWmbSUrzrm5QkFjCoxUfv1w9UIdA
         DdKT3OMAZKLh9y9H65GrS0Cwi3AcJG4Ru7Nm18SjHWlxX5K+r4MKsY12B9j7VIyMoJs7
         hRag1O/FKbmHM7hoQWZbDgtSCC/5+NkxcuLj6UVw9+wzolaxZ3x1a23Piu2soXoReV5j
         5lIYUWA9gf3CgqguW8Lz38MosQlGg+EtrlDOTVD9u6qIUFDw+WzvOs8TdcRDycbRsKPz
         TJNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742795021; x=1743399821;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XZYqBd8vEY+viBvNer60WQXhZvWLjiw6xgE86uO2OEU=;
        b=jBIiz9Gc/4zYbQsNkFQAJnuCKNtC3cGwR6+7BXYlB0+xXqwphqVPPgbYcZluTsCht5
         adTOPN4IR3qPUKS1iMQf7SSuDlJN72MXo5sRgO9O3jkvlYzMgmBDEiW84lMY59mnQpC/
         xM9noWo2F0w1fYAAz4z17e0iSnrHLm2k/PJwPBYw6uqbCJlAkO/rSrUeksNLIFYjATbm
         xj9pZbNybKM8RjtryY6Z7X093z5O6Bro/amLnCrLVegjUI1ha3cpX7Fp84v9GUNwpQIs
         Y1AYCq3MxUYjInKW0fYPjoaf2QxzGYsKbhthzYpZsQkWNRcgXekRtgKkfJkWrxmKh+aN
         2FCg==
X-Forwarded-Encrypted: i=1; AJvYcCWGl3bmMu2ynhNw7zPaLrx54IDe3V4fVJhMw17e8pNxhJWvNvka1/pq27ItcyYJ57opgGdyMR2/eA==@vger.kernel.org
X-Gm-Message-State: AOJu0YydvzOjlptwj09Na1L76AValRMLuWAf0NYQL+9qYkvcrvqRatZz
	KLLL1Dg9/7DgkzvVqZ99/5D1yrEQHwXr/EArVlbwmpCPt8+8QodlBGwLs3P4+Gg=
X-Gm-Gg: ASbGncuhpl28kBs1UyLe5fXiWiW8gGLiHXXst5ea5Dc4B6UHzA5sMp8oDi1yLKNu1Ga
	rpiIIM6jckROs+bb88teHEtMrgl/YsiiVcWgR9ZTfdWNap+Wr20KNLGWbU9SPn0+7OwLFjFRmlD
	g8HTF3h0sUC1O5pUZkNfUvRGYA/3gH0gLlLDaN5bi2Jue7UJoK/AguGoL99WHFbIr8Q3TLF96NC
	206OiQ1U9ROFOTnJUz3eL3DzJo9P/hvUWPror8UahmdYhFrzxHVFFvpr1r1rOD/SHNTxoEE3RFU
	3TMyIL1aYuUiXb5V/DgfexHDVPNivRhoHWvbcwZJR0IQMg==
X-Google-Smtp-Source: AGHT+IG7ucfZiFRoh0M2V5ggHMX64UITYEnNDz5nQP04P/WihSFxf9WsMLMFop+iaLC/4c9SxWUzIQ==
X-Received: by 2002:a17:902:ec82:b0:21f:6fb9:9299 with SMTP id d9443c01a7336-22780d8bfe0mr197243365ad.27.1742795020544;
        Sun, 23 Mar 2025 22:43:40 -0700 (PDT)
Received: from localhost ([122.172.83.32])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22780f3a846sm61958045ad.51.2025.03.23.22.43.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Mar 2025 22:43:39 -0700 (PDT)
Date: Mon, 24 Mar 2025 11:13:33 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Chun-Jen Tseng =?utf-8?B?KOabvuS/iuS7gSk=?= <Chun-Jen.Tseng@mediatek.com>
Cc: "cw00.choi@samsung.com" <cw00.choi@samsung.com>,
	"rafael@kernel.org" <rafael@kernel.org>,
	Project_Global_Chrome_Upstream_Group <Project_Global_Chrome_Upstream_Group@mediatek.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"myungjoo.ham@samsung.com" <myungjoo.ham@samsung.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kyungmin.park@samsung.com" <kyungmin.park@samsung.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH v3 1/3] cpufreq: mediatek: using global lock avoid race
 condition
Message-ID: <20250324054333.sgwwksawnybx3lp4@vireshk-i7>
References: <20250214074353.1169864-1-chun-jen.tseng@mediatek.com>
 <20250214074353.1169864-2-chun-jen.tseng@mediatek.com>
 <20250219054209.erwfp7sgzchaiuds@vireshk-i7>
 <e8337c5eee0cadb797bacf26b00f1ca303c5147f.camel@mediatek.com>
 <20250321045624.mwm2mnkqeow5uids@vireshk-i7>
 <2a73b5ca35692c8ffa68c9ff0df73e24a592967d.camel@mediatek.com>
 <20250321060148.adhxjexpnm4dkpnt@vireshk-i7>
 <e1c2c12bace22d1803d16ecbfb32129518d87157.camel@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e1c2c12bace22d1803d16ecbfb32129518d87157.camel@mediatek.com>

Hi,

Thanks for sharing the details this time, it makes it much clearer
now.

On 24-03-25, 03:21, Chun-Jen Tseng (曾俊仁) wrote:
> I think the best configuration sequence is as follows:
>   cpufreq policy -> set frequency -> CCI governor get
> CPUFREQ_POSTCHANGE NB -> choose CCI frequency -> set CCI frequency
> 
> However, in drivers/devfreq/governor_passive.c#L77,
> get_target_freq_with_cpufreq() retrieves the current frequency of each
> policy,
> and it determines the CCI frequency based on the frequency of each
> policy.
> 
> But if policy-0 and policy-6 enter simultaneously, the CCI governor
> might get an incorrect frequency.

Yes it may fetch the current frequency (or last known one), but that
shouldn't be a problem as the postchange notification for policy-6
should get called right after and should fix the issue. Right ?

I don't think this is a race and if this requires fixing. clk_get()
for any device, will always return the last configured value, while
the clock might be changing at the same time.

What's important is that you don't get an incorrect frequency (as in
based on intermediate values of registers, etc). Note that the last
configured frequency isn't an incorrect frequency.

> cpufreq policy-0 -> set frequency -> CCI governor get
> CPUFREQ_POSTCHANGE NB -> choose CCI frequency -> set CCI frequency
> => during this time, the CCI governor gets policy-0 and policy-6, BUT
> policy-6 may change frequency by cpufreq driver at the same time.

Sure, and I don't see a problem with that. The issue is there only if
we can reach a state where CCI is left configured in the wrong state.
Which I don't think would happen here as the postchange notifier will
get called again, forcing a switch of frequency again.

-- 
viresh

