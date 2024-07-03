Return-Path: <linux-pm+bounces-10522-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39762925847
	for <lists+linux-pm@lfdr.de>; Wed,  3 Jul 2024 12:20:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08AB328AFA2
	for <lists+linux-pm@lfdr.de>; Wed,  3 Jul 2024 10:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35C7A155335;
	Wed,  3 Jul 2024 10:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c+wlb7UM"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB373143744
	for <linux-pm@vger.kernel.org>; Wed,  3 Jul 2024 10:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720001989; cv=none; b=RZCTHvf7aiRwWfrPc7kbXzZf0Xn1Ds4XJhWzXBl9qEZ78kJpAFEdcRJoJoAM3XetcLYPPAKGElqusrbD1ktgKE4mA4H2KTun/3cQWnFzSdx9G40ojOH5TD19q5Dhm/LV/cMMpFAr4YXdFEmNBGRRjH5xZyj+vNFqh9Oh8lUGBSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720001989; c=relaxed/simple;
	bh=Dr1Yt/KrYHkti6C1KYzV+Dlm4Qfz5vwM66rts5wWsJI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rzVlg0KTVg8/XBZeZt6hqZ7RlLeCNK2W3slvLzhA174lWoWnrscwmfCMpQ4KWZuCYDyfqqBmnyX6+1KoAwWhtV/K66lORe8Occosg2HPD+HWJ29RxBB9zTfB7RoOi8Stldi6NT80AWjHi37bxGnwDuiTojAUTrXV2oNh0n4w2jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=c+wlb7UM; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-711b1512aeaso3848437a12.3
        for <linux-pm@vger.kernel.org>; Wed, 03 Jul 2024 03:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720001987; x=1720606787; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WX20iHFYDh67zOaOY8ZhhJ6ZKT9LK6c3VfSACtwvVgg=;
        b=c+wlb7UMm1Td3HJlT0HfFIEvjcKjt+pp/vk6JHKzeSyWmDMPGBwiTaZ90w+zq+2WaP
         CxlTU5dRUOyzLZ8Dqn7fVo2bWxUW2CX29GIZlXfuNxwVhrKCvzK/2syhj6jGYMLPcLdQ
         hngqveN+P6b0g0747lmOMaQl5ziRFl/OiiHVRxipXISY3EpIJL64TAsgeY2LCnap8drI
         gERcOUQJI1sM61Am50zTH8MWtg8jY4eu7rjegytAj8Z8xaKm/O9y9UxzwEdhCWmoT17z
         oYJ/mZQl6UPXzZ1rAAz3rhIPJPCxF7qlQ9Zj4IuMGupjeoUwLNd9U8vUWzV7OFp9a8qT
         X9Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720001987; x=1720606787;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WX20iHFYDh67zOaOY8ZhhJ6ZKT9LK6c3VfSACtwvVgg=;
        b=Il4p0o+hrAklwVEkC8RqxHOAr4csBOVHEvvRGCL9NreiR0gqCvNNHdqGzeNdMEA+UP
         frcQO1rV5X7VPDDcPI50gLg4qWNntQ+WisG6vwmckZjlxWJmhE0ImSW0FLIKCLi0nhEw
         m0NGf8VDvljvfjc/a1ogkTyGG7dB8lkqevt0IpcxASS0e1KrBOcNXbPAs+qSqoSR8B4i
         +wJ7cCUPCl5JPJnx/68yDbPhBo7q1p+5BuDZvRYIJ20wWZJU66oW96AFxp5HU56GTOzN
         0YE90MOn7Tp3RhTC2dme8BpL/DWEze/TBdx0P+reXQG4RDmx7VDscDgLzDz2p6bg5o6O
         81cg==
X-Forwarded-Encrypted: i=1; AJvYcCWhol5wF8heRgz2gsWwXXJhhCEkmF+cW7jzhSUtfAtfZkCBFA9E7HvU7FCVa5VzWK4n8i3La5BpzzecwUUf/0DhYNifXCBMLPo=
X-Gm-Message-State: AOJu0Yyzu+AiOzWjL8hxUbyIrymegLqknZ8mVwVOUY5VqYmLKo7BVV7X
	WLhU8aQpVxwifQIKfLH/r6WLQGGF2o3dIhRjzrugSGj6RxOuqU9LqetSNZRAZsU=
X-Google-Smtp-Source: AGHT+IEvSWK3AHjhs//D5/KK7bYouCT5r+gWqcmSkgVEyw8WawTRpeA5e5mSwaWYHuM+L0bWLij7Yw==
X-Received: by 2002:a05:6a20:7f89:b0:1be:c81d:7314 with SMTP id adf61e73a8af0-1bef60ee48bmr16636953637.8.1720001987024;
        Wed, 03 Jul 2024 03:19:47 -0700 (PDT)
Received: from localhost ([122.172.82.13])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac11d96cbsm99891255ad.119.2024.07.03.03.19.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 03:19:46 -0700 (PDT)
Date: Wed, 3 Jul 2024 15:49:44 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Varadarajan Narayanan <quic_varada@quicinc.com>
Cc: vireshk@kernel.org, nm@ti.com, sboyd@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org,
	angelogioacchino.delregno@collabora.com, andersson@kernel.org,
	konrad.dybcio@linaro.org, mturquette@baylibre.com,
	ilia.lin@kernel.org, rafael@kernel.org, ulf.hansson@linaro.org,
	quic_sibis@quicinc.com, quic_rjendra@quicinc.com,
	quic_rohiagar@quicinc.com, abel.vesa@linaro.org,
	otto.pflueger@abscue.de, danila@jiaxyga.com,
	quic_ipkumar@quicinc.com, luca@z3ntu.xyz,
	stephan.gerhold@kernkonzept.com, nks@flawful.org,
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-clk@vger.kernel.org
Subject: Re: [PATCH v4 02/10] cpufreq: qcom-nvmem: Add support for IPQ9574
Message-ID: <20240703101944.tiyaweflcs6nkx4p@vireshk-i7>
References: <20240703091651.2820236-1-quic_varada@quicinc.com>
 <20240703091651.2820236-3-quic_varada@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240703091651.2820236-3-quic_varada@quicinc.com>

On 03-07-24, 14:46, Varadarajan Narayanan wrote:
> Add qcom_cpufreq_match_data for IPQ9574. This is used for tying
> up the cpu@N nodes with the power domains. match_data_kryo is not
> used since it doesn't set genpd_names. If genpd_names is not set,
> 'cat /sys/kernel/debug/qcom_cpr3/thread0' causes cpr3_debug_info_show()
> to crash while trying to read thread->corner->last_uV as
> thread->corner is NULL.
> 
> 	Call trace:
> 		cpr3_debug_info_show
> 		seq_read_iter
> 		seq_read
> 
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---
> v4: Update commit log to include stack trace
>     Introduce qcom_cpufreq_match_data for IPQ9574

Can I apply this without other changes ?

-- 
viresh

