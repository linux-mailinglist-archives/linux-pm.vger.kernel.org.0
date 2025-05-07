Return-Path: <linux-pm+bounces-26806-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2FEDAAE07C
	for <lists+linux-pm@lfdr.de>; Wed,  7 May 2025 15:18:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 253353AF94B
	for <lists+linux-pm@lfdr.de>; Wed,  7 May 2025 13:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD508288C20;
	Wed,  7 May 2025 13:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sOQUj9rH"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB325288C18
	for <linux-pm@vger.kernel.org>; Wed,  7 May 2025 13:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746623921; cv=none; b=UDIBqnPmtp0kTkq5guG18usjabavNMbCNfJflAe66Q/Zh631cV6wI8VJdJlKoLYaIbtd51iO0IY3rbRHzr4h24gU1pOemCLoe8vTsAYO1bGY62nXSMl3Nahkkx8/E9Htfx/vMJJx9Z+QGAgTkDZsUqUNNSpTFCfJLlbcM560rcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746623921; c=relaxed/simple;
	bh=vANADi+020FCH5I2njw3FMWd3fKb5Ttxnfby5ZW9V8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BVR0CJMfeN/7tU/GYkuaagi1U5ha163hPx6UysdbNVoFA+ckB3MoKFH+UXuFbVwwjEl0cZKUlG6bXa/cVJExbUnU/8kFWKfpEHJh4nLfEOkMIf9uquDgH5Lvb/Ed25UD1oJwzOUcLfYio6y/R+GjNwlcMDQCxJGgDgLmTzQw1bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sOQUj9rH; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43cf3192f3bso66656735e9.1
        for <linux-pm@vger.kernel.org>; Wed, 07 May 2025 06:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1746623918; x=1747228718; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mMwJyAtJK/aLIyT6CLn61d8dMsByyOcrMzhv12s06BY=;
        b=sOQUj9rH/JgpwIXZKDU0vxXibY7ngcB5Zhta1Ld9Tw0B+eqV//1Tfnvu1x229JHoyd
         C1FCWmHeVXCv1W4HuqLOUbbI6UeHytrLg8zOd6GYrckEooLWXGPHG8pDCqn9Hfvz9CXz
         um+kfAPh7+R+ve7rLwQlpaUInSmHus7lOeE2GONq/k+45lrjIcmGdsUoU6mY3HZeQIpz
         58J9aIpYZVs7sdLhnwIxCEoKXQukEsn5/U2ZE/ERjC2K5z3F5HXOuWjL5SW4fhYuLQwz
         0qdyaQfhWPwe0wqOAuumot/HrDgedba6t5rd3+AeMW0eh9uLFqEPaTkuTavgfXDBcP4X
         t8Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746623918; x=1747228718;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mMwJyAtJK/aLIyT6CLn61d8dMsByyOcrMzhv12s06BY=;
        b=VeZd0trz61Z5BU+fUdz+sMbdIaOjqQq3E5VM1jmxGtO4qIBPceCcvCLCUJhqLSZrV9
         VFZZ6W2qN2gt9DIGeMW5bQq8I4GsOY0NgL8gVPN4eceE5WpWvJ+Aqv1ea7r6clZw87rs
         gHdbyfbguTVd9f4HXlwJz6EdewwPtQLHD4n2lvsuF3+OyCVdl5zm3KjHIXwApf0T5ikN
         Hwh+d+krsq1yG1rKPGQ4TB3MRx7/VGlvJUBvUtBVoqFbFXPOA+ZsqkMXuwga6olKBmfn
         LKJW9iJhW4Y5R5RqbZPdOAPqg13nSWetOtPAD4nM+Ax/hhnJtO2ZGDn5QLr3boM+uoHh
         LsHg==
X-Forwarded-Encrypted: i=1; AJvYcCWSHTW3JSlCKe8ZFqS4V92DY/AEJRghABjzYdS3+zoOpalAbwcqul56JzSwbrm+MBCEz5mQicSkjA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxupdCgTpJauk91OeP/wHSN7VC99Iyyx2LmQlmd2Wc4uZ5MDFXr
	HONcmWLV2sJEVdARYY2bZD4NolbPWeZd/9FYqrQVHElFl3BEsd7Swe1au+35yX4=
X-Gm-Gg: ASbGncvbWFzt8QMnUGtOoZ0P9IVEpwlz2EeHQG60emcxyoTx6jPCpRtq+/a3iMGzHG6
	KIG2777kLTDVnPe+auf/I5jWIqVKUPx2o5U+73fSbsKolma6FLaQ3g25LAcsiXsiU/xsVlf0dmS
	barO3hUnhQbujZDmMxHJsa+KKJ8GS3NmJG9onv22wbYHlWAZlQ81Ic6apJwawaLa1ro3SRNK0yC
	nDwbeMQZ+UrsxhmM5DJ/Fg2eehVPhu+Kmy4wL446mOTj9iqMilBx0JaBIFxonwxEB5xi2K105af
	FPjZVfC6C+sLm9DT6cMSrtXsVbKCMCCLzSeG5n4fFhM+AQ==
X-Google-Smtp-Source: AGHT+IH3Qorr4/m1vHEg7Ot9UQ5uCqOCNeK+Gmt1pu97YiZ6JvL10Fw4EinSPUDzBFREtrSqd0/vwg==
X-Received: by 2002:a05:600c:6085:b0:439:643a:c8d5 with SMTP id 5b1f17b1804b1-441d448ca1bmr37445495e9.0.1746623918101;
        Wed, 07 May 2025 06:18:38 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-442cd380ca4sm629535e9.36.2025.05.07.06.18.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 06:18:37 -0700 (PDT)
Date: Wed, 7 May 2025 16:18:34 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Cristian Marussi <cristian.marussi@arm.com>
Cc: Mike Tipton <quic_mdtipton@quicinc.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>, arm-scmi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, Peng Fan <peng.fan@oss.nxp.com>,
	Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH v3] cpufreq: scmi: Skip SCMI devices that aren't used by
 the CPUs
Message-ID: <aBtdqvyT4Ded8Lht@stanley.mountain>
References: <20250428144728.871404-1-quic_mdtipton@quicinc.com>
 <aBtLMYqcnwacGJuy@pluto>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aBtLMYqcnwacGJuy@pluto>

On Wed, May 07, 2025 at 12:59:45PM +0100, Cristian Marussi wrote:
> > +static bool scmi_dev_used_by_cpus(struct device *scmi_dev)
> > +{
> > +	struct device_node *scmi_np = dev_of_node(scmi_dev);
> > +	struct device_node *np;
> > +	struct device *cpu_dev;
> > +	int cpu, idx;
> > +
> > +	if (!scmi_np)
> > +		return false;
> > +
> > +	for_each_possible_cpu(cpu) {
> > +		cpu_dev = get_cpu_device(cpu);
> > +		if (!cpu_dev)
> > +			continue;
> > +
> > +		np = dev_of_node(cpu_dev);
> > +
> > +		if (of_parse_phandle(np, "clocks", 0) == scmi_np)
> 
> Shouldn't this, on Success, be released by an of_node_put() (or, BETTER,
> by some OF-related cleanup.h magic...)
> 

The cleanup.h magic is __free(of_node_put) but dev_of_node() doesn't
take a reference so I don't think it's required.

regards,
dan carpenter

> > +			return true;
> > +
> > +		idx = of_property_match_string(np, "power-domain-names", "perf");
> > +
> > +		if (of_parse_phandle(np, "power-domains", idx) == scmi_np)
> 
> Same.
> 
> > +			return true;
> > +	}
> > +
> > +	return false;
> > +}


