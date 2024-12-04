Return-Path: <linux-pm+bounces-18516-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 691C09E33CE
	for <lists+linux-pm@lfdr.de>; Wed,  4 Dec 2024 08:04:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DBC32846D2
	for <lists+linux-pm@lfdr.de>; Wed,  4 Dec 2024 07:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04BFE188737;
	Wed,  4 Dec 2024 07:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gaTkN8LS"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31FB31E522;
	Wed,  4 Dec 2024 07:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733295885; cv=none; b=gTmAMSZ2M+SlYUnZAYv8EyJc5YYz9azFKCUABa5W9K5mDva5iyRM7srYEZhjmL3unizNHG599JD0Z6+56WotxOn9CwyIRF7GftPBNBAXjGfYueoRAn2VEQGlkHbK5dUStwGQ6x6YyXFNUVeocT2KWOFJFUAASEZTqItgfLZR3gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733295885; c=relaxed/simple;
	bh=y1zcHNuFMtOK1xVot3c066LSvj2hzh3Xina5bH0XTI4=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OKHJFcIB0fGwzxbc6N5qpgOe04YcxS94wfnCO29l4pYd7rbtwQUDs+F7X9jqoL0JWfRJjyzQ+3f6nJGIeVtisLSs5Fy3L7l4itr8VJ3BgCrGMqzjymqKX8T2E3qlr0XdKbwwhpyVFpDGGbeBHgRr4+NVLGjL7UMQ6uewHAUtHkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gaTkN8LS; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-434a736518eso78364765e9.1;
        Tue, 03 Dec 2024 23:04:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733295882; x=1733900682; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=jwyiS6gRtCqYWJ7fdo4umY0N/8KDpHNznz4qNJQIKfo=;
        b=gaTkN8LSc2y9tvL+xHSF7ysMTQl0QPSMgRGlPXCkc9LcLAJBvdHqcjXpLbibDOZZFj
         FSR8D9f1g6+iT4dxbH3c4OPTLAgUTiJuf9hdEMV6itDiQ4wR1JksL7UTWNIMq6SDPF3D
         4wdsMnSKd2AR1RglmX3DfQC8zAbBrQzt50skFYKpKskQ9fRQfrfWRHMTkFcqorisvkJ7
         qbEd9VpXJfEcxqnfAg4t78vvjSBOwEtNs2j7f+vF61jTLxVBI14Urb88BpCWSFkKqwXe
         ajhHr8/1B541kkKL9nqk8WbVe2+8BbNgJdZLHYgjlCqiYrd3Tf/1TXekcLQSqrYsT7SO
         FL4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733295882; x=1733900682;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jwyiS6gRtCqYWJ7fdo4umY0N/8KDpHNznz4qNJQIKfo=;
        b=G+DdHQeQ8Toponm5Qs3shiAHfBYnxOVHCPZSxAp60D5/700v77wSqh2hozfRdk7I5g
         YocSNqF2lASTmBZN3uBf3gAsMhjwbZoFKJENAJFsq+El0BlNl4gtRHtCdajvr3WZNpw1
         WS7wKBerNtv0pliyty894Jk2c1oTOjvJWfCe0MQlBdAVQMWb0cYLXxKbYRjVAcESPEfU
         Q2BEBxWqVJRChowz/hHVMGzEDreP5ChhotGlOi5GQ/6tbDE6NibZhj6HdmeKAVGPtGUN
         Dg3RvuANazihDQseWN7sWAS73asnVvgHi02n79SG2zbmPC7sw/UTc+MF4cTWCcz1MsX9
         sXxQ==
X-Forwarded-Encrypted: i=1; AJvYcCU18WFqxgnAyz6fdnQ+pK3PF0UKLfij+BqlVxw6rQXE43mKB4U7qG/qkjmXcJ3JlzdxTLGodj4ujnCO+07e@vger.kernel.org, AJvYcCVN6p4GEFVpQduvS3mPZvSqQmjqvrsH7B0gldHWrLs64HKyXas9Z/l69PDTIVFVW250MI0XhnrCCXFu@vger.kernel.org, AJvYcCX8oDOC32rbEN0rcgSdi3JgheKq+oiKefsdcX/Y6RTTRhtJIJSHD/BfK2rg3kZbiDLi+WaQmI+gwMk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxBWHcJET3rwtgSzwZ2Lo7K307lMgZ2z5KjjcVn2WlFdv9nvMd
	Zu0F0opVyITZS7LwID+/GEzg3v+D2OYEBIxFiwNYwt0MwvV3cPNr
X-Gm-Gg: ASbGncv9lXavJkmWp/GR8YpsLoIQWb3tb/ZSrF7Yh6jDbO72LCACdDWp8AwAe88ttGj
	0hzafDranIwPskc/+dkF/VCPeYNPg4O/426YIIReuDFniVoVg4BetzVzXhbrBvOB7ofTqcagLkY
	DIZIgF8TG9Jfq0R4s3GcSQ4O+pwcRNIr0QoZpHoxWiSqUTT7jsyr5Xwu7NuQM2Y7Dxb0IxBE+wn
	rrI34HgmzV1ATh4SV1fe1n23Jk2Yr9WS8AbqeWoRnKE1viYcS63ey8U8j0uiuqo5OgzyLM95BHt
	0wYGBQ==
X-Google-Smtp-Source: AGHT+IE5566rseFLsNSfCM+v5uvPvaWhpfPmfuWheegU9cdIQXdrXYkEn7yLdEjSKRuHjO1bEUnuGQ==
X-Received: by 2002:a05:600c:45c6:b0:434:a5c2:53c1 with SMTP id 5b1f17b1804b1-434d0a0da50mr41789005e9.23.1733295882059;
        Tue, 03 Dec 2024 23:04:42 -0800 (PST)
Received: from Ansuel-XPS. (93-34-91-161.ip49.fastwebnet.it. [93.34.91.161])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434d5288264sm13406365e9.19.2024.12.03.23.04.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 23:04:41 -0800 (PST)
Message-ID: <674fff09.050a0220.293594.24be@mx.google.com>
X-Google-Original-Message-ID: <Z0__BmSNRWVkrEVJ@Ansuel-XPS.>
Date: Wed, 4 Dec 2024 08:04:38 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	upstream@airoha.com
Subject: Re: [PATCH v5 2/2] cpufreq: airoha: Add EN7581 CPUFreq SMCCC driver
References: <20241203163158.580-1-ansuelsmth@gmail.com>
 <20241203163158.580-2-ansuelsmth@gmail.com>
 <20241204053211.6gdogcpi4g3eavw5@vireshk-i7>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241204053211.6gdogcpi4g3eavw5@vireshk-i7>

On Wed, Dec 04, 2024 at 11:02:11AM +0530, Viresh Kumar wrote:
> On 03-12-24, 17:31, Christian Marangi wrote:
> > diff --git a/drivers/cpufreq/airoha-cpufreq.c b/drivers/cpufreq/airoha-cpufreq.c
> > +struct airoha_cpufreq_priv {
> > +	struct clk_hw hw;
> > +	struct generic_pm_domain pd;
> > +
> > +	int opp_token;
> > +	struct dev_pm_domain_list *pd_list;
> > +	struct platform_device *cpufreq_dt;
> > +};
> > +
> > +static long airoha_cpufreq_clk_round(struct clk_hw *hw, unsigned long rate,
> > +				     unsigned long *parent_rate)
> > +{
> > +	return rate;
> > +}
> > +
> > +static unsigned long airoha_cpufreq_clk_get(struct clk_hw *hw,
> > +					    unsigned long parent_rate)
> > +{
> > +	const struct arm_smccc_1_2_regs args = {
> > +		.a0 = AIROHA_SIP_AVS_HANDLE,
> > +		.a1 = AIROHA_AVS_OP_GET_FREQ,
> > +	};
> > +	struct arm_smccc_1_2_regs res;
> > +
> > +	arm_smccc_1_2_smc(&args, &res);
> > +
> > +	/* SMCCC returns freq in MHz */
> > +	return (int)(res.a0 * 1000 * 1000);
> 
> Why casting to "int" when we can return ulong ?
>

Leftover from old. Yes will drop. Coincidentally arm_smccc_1_2_regs
entry are already ulong.

> > +}
> > +
> > +/* Airoha CPU clk SMCC is always enabled */
> > +static int airoha_cpufreq_clk_is_enabled(struct clk_hw *hw)
> > +{
> > +	return true;
> > +}
> > +
> > +static const struct clk_ops airoha_cpufreq_clk_ops = {
> > +	.recalc_rate = airoha_cpufreq_clk_get,
> > +	.is_enabled = airoha_cpufreq_clk_is_enabled,
> > +	.round_rate = airoha_cpufreq_clk_round,
> > +};
> > +
> > +static const char * const airoha_cpufreq_clk_names[] = { "cpu", NULL };
> > +
> > +/* NOP function to disable OPP from setting clock */
> > +static int airoha_cpufreq_config_clks_nop(struct device *dev,
> > +					  struct opp_table *opp_table,
> > +					  struct dev_pm_opp *opp,
> > +					  void *data, bool scaling_down)
> > +{
> > +	return 0;
> > +}
> 
> I wonder whats better here. Provide this helper or provide a dummy clk-set-rate
> at the provider itself ?
>

The idea I prefer this is to save a few CPU cycle and also to prevent
bad usage of the CLK if anyone starts to use it. Returning 0 from a set_rate
would provide bad information. Or your idea was to declare a set_rate
and always return an error like -EINVAL? 

-- 
	Ansuel

