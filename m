Return-Path: <linux-pm+bounces-17291-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA9A59C3726
	for <lists+linux-pm@lfdr.de>; Mon, 11 Nov 2024 04:48:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DBFC1F21EC8
	for <lists+linux-pm@lfdr.de>; Mon, 11 Nov 2024 03:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A163F146A79;
	Mon, 11 Nov 2024 03:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e3DvrBT/"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 088344595B
	for <linux-pm@vger.kernel.org>; Mon, 11 Nov 2024 03:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731296933; cv=none; b=PX0uSIRifHujMwFAu4gj4exC6GyShAyJfqGoe4pe86JLgySHKWRm3o0j70Vi2jLaeKRZTIE8nuclHuZrahCBOxVH/eSwLnmiL2WcisCXCUA1M6i3WFPa9Q3r2/loWRSDZRBPUqxo6cWArMz2e1qcA2f24MK2RaoVUmsEj3Y/ffQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731296933; c=relaxed/simple;
	bh=DAqC1m0UzBkEna+kh4qJ5m7WFoRARHIRxJyd6v1CUH4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cfwqm14L3v50ryrn2xlsZM/kKhZQi+TldzZRTXpunYJ9UMj7WX+oGAZRVt2kCF+uIHDKT0O0i07RDdCT/aXr7s25DfnNQDiUHHD7OsO7siqGzvt+Hszg0wpg8L+GEayeduTBT6AVIT9KiTQ2jyVhr2mOYmhn+48ovr4VY0mE8sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=e3DvrBT/; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2e2e2d09decso3807178a91.1
        for <linux-pm@vger.kernel.org>; Sun, 10 Nov 2024 19:48:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731296931; x=1731901731; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cyBoacIe/beqOmXqqDNGWcJXEOI0SPSE7QTB0nEVwZQ=;
        b=e3DvrBT/J+Htj8XjSxfaDDW04HOp1eS2HphyVdXSYkGtn3fZiUTrmXQ3SbxispmDTp
         KN/Z4Rpvj+syXIsD1zK2DbcmrBOssx+3eHZJ1X7txi+9rqgqwktv5oileP2rTJibWki1
         mi4zv+GYszyYnVVO2GwuZ7CK9+n+cu4MatDW6a7DhdiUDF4mUxZUC1VOFn9VzAgvhbId
         xCo3IBjwn9gk+alVOXnVKcpd22s9Q4g4PRvcZI+S5dlRUIcqdsmP67Ok6bJWbSdSDKwW
         1L5fghlHRNXhJdADYithh0e8l5MVN1+qBK4DyY5nbUgvoMV43QL1c+t/KOcnicVHmXB3
         0lCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731296931; x=1731901731;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cyBoacIe/beqOmXqqDNGWcJXEOI0SPSE7QTB0nEVwZQ=;
        b=bQZzP8zuApXCn392ZJsw0rbKWCrQtCBGW1FNGL5q6KEN6q2IS+0w0m8tNtXP4siI/K
         oNaHmNIU4UISK3Oc/EvqF0O/SjttF7EiYh1owvwyPgnK2uCbsfzp6HdFYvtZv39+FgFE
         t00fU0WB1EDPfQ1576GkpJSurQaERGeRuHJi3/hriOxlHp3uAuX88RuVi1wEVulRLSex
         lGly8tok0i7Ep++c0xYhum5hbOVZoTFr4dIs+yoyifU6jYWMxqZRUiQAfklUUjfUxQ52
         XEizQql5irrF29ks2N2XHOrgmukUmhmNVPcWjok5fDdDrRrpT+hujiKHzYvECHKY1KJI
         sB1A==
X-Forwarded-Encrypted: i=1; AJvYcCWuq1j7H613qinPr0H17pWzhtQyohA3p1Sp/9rmaMY2T3tFD1T73rfJZ32sipfAF3wKaswgIibM+A==@vger.kernel.org
X-Gm-Message-State: AOJu0YyiWLDBT9RaH4l1JJTkUi7lhSVlkbfFufB+9plWtsSYJyivKhKb
	IwaK6KzGrsYFkbVwtWEYkwE08fU6dQbq0wnIu8DhiZQrNwQKYPHhEy5OlPq2cKU=
X-Google-Smtp-Source: AGHT+IGYrXj9oPlPSmY8T67CTPIqdUFk8LRkxz3VZqL+QyxxAM/tx5DxSPFaPEc+Y36IKUhOf2R9rw==
X-Received: by 2002:a17:90b:39c5:b0:2d8:b043:9414 with SMTP id 98e67ed59e1d1-2e9b1f8e54emr14638700a91.18.1731296931268;
        Sun, 10 Nov 2024 19:48:51 -0800 (PST)
Received: from localhost ([122.172.86.146])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e9a5fd180fsm7451733a91.33.2024.11.10.19.48.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Nov 2024 19:48:50 -0800 (PST)
Date: Mon, 11 Nov 2024 09:18:48 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Sibi Sankar <quic_sibis@quicinc.com>
Cc: sudeep.holla@arm.com, cristian.marussi@arm.com, rafael@kernel.org,
	morten.rasmussen@arm.com, dietmar.eggemann@arm.com,
	lukasz.luba@arm.com, pierre.gondois@arm.com,
	vincent.guittot@linaro.org, linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	quic_mdtipton@quicinc.com, linux-arm-msm@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH V7 1/2] cpufreq: scmi: Fix cleanup path when boost
 enablement fails
Message-ID: <20241111034848.wyryvgeqvu33jilm@vireshk-i7>
References: <20241031132745.3765612-1-quic_sibis@quicinc.com>
 <20241031132745.3765612-2-quic_sibis@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241031132745.3765612-2-quic_sibis@quicinc.com>

On 31-10-24, 18:57, Sibi Sankar wrote:
> Include free_cpufreq_table in the cleanup path when boost enablement fails.
> 
> cc: stable@vger.kernel.org
> Fixes: a8e949d41c72 ("cpufreq: scmi: Enable boost support")
> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
> ---
>  drivers/cpufreq/scmi-cpufreq.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Applied. Thanks.

-- 
viresh

