Return-Path: <linux-pm+bounces-32434-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 501FCB2806E
	for <lists+linux-pm@lfdr.de>; Fri, 15 Aug 2025 15:14:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10C663BE510
	for <lists+linux-pm@lfdr.de>; Fri, 15 Aug 2025 13:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B20473019CE;
	Fri, 15 Aug 2025 13:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VFRTSx5v"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 046F222A4F8
	for <linux-pm@vger.kernel.org>; Fri, 15 Aug 2025 13:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755263645; cv=none; b=G1jy8gWOld/UoqWHbsoPMcVMHAVwstuTym7Pl2kpfVq3kevip0w42TzPNUdZiJVFsKlKeqsx5rUmLO225KlNRVqB3RsK7KQno1ic72IJAzQpO/gEvML5d/XVzWl/uMbbBQ/yox561CXE2PMPWD+/NTl1/f2SZ331NTrVANa+ITk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755263645; c=relaxed/simple;
	bh=aDTuk3M3dnlTn+CYUcvmx4uCcGqPjuQSOHcwS0mGbYU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZexZE6HHP57w+HBM2ZGA7YStDSxjruEboHteN64detAW5f3uCvErDiQbIHZjy13y0Iplc4yEYKjD/52CpGuqe8hktmBnDrSpT8v530AsmjDNtIOKcuZjl3L/Vm4bxJYU9iWUhHnMNb5eHqBJnSL2n+kFwu8QeDUT0KhM3yeJSrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VFRTSx5v; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-45a2534aecdso329295e9.0
        for <linux-pm@vger.kernel.org>; Fri, 15 Aug 2025 06:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755263641; x=1755868441; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aWVd3a6QjlDIBu/GZcAsaGjfMi/nlIyITb4lz5jcIMk=;
        b=VFRTSx5vOjyiiu/sX3teVTJsO96X0avxm0h1/PiV6emeK31o9GKq3EJtJqURzYNkl4
         qOqUWT1og4tF9Q+XeKtvzBBT+kgQz/78/pFNDrSZvgNUQT7XuQib6zd76mKGE1Cck0IB
         /C42bIk6GyrE2Y54193qvnmbAc79hcHv+9GGBZUB4KQZrE9vIA+mCtHj9GoO+6gt2MRn
         adsHHQXl9h2xFuSsa3qv4WKoNEAJLAAdpk4xmiBmxQfamJLvImdwOUaDXE1Y60XYm0v9
         e329cM8Azc2gEqZVKzW+73gTKZ9J/IrcpdOOxyidAfFX3W02MSZLLHx3avUy1XKoKB4t
         brgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755263641; x=1755868441;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aWVd3a6QjlDIBu/GZcAsaGjfMi/nlIyITb4lz5jcIMk=;
        b=jkzaWDKnpyuAGncJkjXmPdzTVFvWO1ExqBg6HYNdCbFVptaJ+d2OC26mIN+U6OZH3O
         PFjSKiKF8en2mh+AelMv6R08MxMe49cspABlHNtSo06lBlcsqMg/qofds6z8Xkc8DYEt
         YJNugpXMiCVfn0uVfvcj4WmovYwTLMpe5VursPCFnjOmQO7V19JYbW3zFWArKvlczhYT
         Q0XgttB1RPwQSUbfVZZCAS3lHNOhdfQE+Pm1MK2Q/QuJVEJs41hdxDyAX04fOUagZo9s
         Ep/JZiZ1i17tSj6PCpcuwbZ9IiESyk36d4ymu5xHO/hXLKoYvctEK7wJCfR/r2qmMtZd
         29/A==
X-Forwarded-Encrypted: i=1; AJvYcCVUEEyV9MDU5WHilpYuVtUzobxFXWWKpFHoXz6jf1TlKOn4NvTBEMqesTpJLNWDCgpimCfp3PSUYA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1QywxyKACeRE0tA3ghtnvbpGGhHUQ+CABcRlj8zOWPdtd958U
	rgk8C+m5iHP6xy9PuJE5DZO+31nuRzMlDaSzmpvX2dtITfpHDiJHU3JcWuyQDrB8h2DNnzddS/E
	deTEJ
X-Gm-Gg: ASbGncuL6TwtC2ZPRNmD66O+D2yGl6nePvffwYO3r3vZ96/ZA3I06Uw5ONRigeNLHpg
	VaHSlSJxqsUkwuBOPTSbfqJNVNA9sS0Nh0jovv+THwuuwhkUCFAf8dMtlCgHvQNMd7bsmM815oZ
	DeGiPmh7m7/1LyYl8XTXGhAViy201g4B/mRlfALOtsqdrTdqXl5LZKOAHSfl97MhPjROJyM8+K2
	Ob417QM2pW/fpO6n4RBSrXYW0bgURLcXUUtqVElMArxjH+y3I6wlQ6vrlhbi2BEkpWRu+P3d2v4
	J1eAAkQuycZEWTE0m1S7Z+GXaj+d2Q3xfJoHbR8Uhtm4mNVN1aBy3zjWAqCfUwEA1UiFcJgfnfN
	NCyV44x+6OyOgmtSXNjuBwgFp5BQ=
X-Google-Smtp-Source: AGHT+IEGkzA5H/8XCgBmKZzZLui8cTS/0lu1L381PDJX0bf2RM2IKP9iCXo6EURHpv4ew13E3k7NJA==
X-Received: by 2002:a05:600c:3502:b0:459:443e:b18a with SMTP id 5b1f17b1804b1-45a21859687mr19402065e9.14.1755263641313;
        Fri, 15 Aug 2025 06:14:01 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45a1b1d4212sm37507125e9.0.2025.08.15.06.14.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 06:14:00 -0700 (PDT)
Date: Fri, 15 Aug 2025 16:13:57 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Cristian Marussi <cristian.marussi@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	arm-scmi@vger.kernel.org, linux-pm@vger.kernel.org,
	sudeep.holla@arm.com, james.quinlan@broadcom.com,
	f.fainelli@gmail.com, vincent.guittot@linaro.org,
	etienne.carriere@st.com, peng.fan@oss.nxp.com, michal.simek@amd.com,
	quic_sibis@quicinc.com, d-gole@ti.com, souvik.chakravarty@arm.com
Subject: Re: [PATCH 3/8] firmware: arm_scmi: Refactor powercap domain layout
Message-ID: <aJ8ylY6jjS70z8lL@stanley.mountain>
References: <20250813114609.1305571-1-cristian.marussi@arm.com>
 <20250813114609.1305571-4-cristian.marussi@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250813114609.1305571-4-cristian.marussi@arm.com>

On Wed, Aug 13, 2025 at 12:46:04PM +0100, Cristian Marussi wrote:
> @@ -486,7 +514,7 @@ static int scmi_powercap_xfer_pai_get(const struct scmi_protocol_handle *ph,
>  }
>  
>  static int scmi_powercap_pai_get(const struct scmi_protocol_handle *ph,
> -				 u32 domain_id, u32 *pai)
> +				 u32 domain_id, u32 cpl_id, u32 *pai)
>  {
>  	struct scmi_powercap_info *dom;
>  	struct powercap_info *pi = ph->get_priv(ph);
> @@ -495,8 +523,11 @@ static int scmi_powercap_pai_get(const struct scmi_protocol_handle *ph,
>  		return -EINVAL;
>  
>  	dom = pi->powercaps + domain_id;
> -	if (dom->fc_info && dom->fc_info[POWERCAP_FC_PAI].get_addr) {
> -		*pai = ioread32(dom->fc_info[POWERCAP_FC_PAI].get_addr);
> +	if (cpl_id > dom->num_cpli)

This gets fixed later in the series but it should be >=.

regards,
dan carpenter

> +		return -EINVAL;
> +
> +	if (dom->cpli[cpl_id].fc_info && dom->cpli[cpl_id].fc_info[POWERCAP_FC_PAI].get_addr) {
> +		*pai = ioread32(dom->cpli[cpl_id].fc_info[POWERCAP_FC_PAI].get_addr);
>  		trace_scmi_fc_call(SCMI_PROTOCOL_POWERCAP, POWERCAP_PAI_GET,
>  				   domain_id, *pai, 0);
>  		return 0;


