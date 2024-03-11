Return-Path: <linux-pm+bounces-4816-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B03FC877A73
	for <lists+linux-pm@lfdr.de>; Mon, 11 Mar 2024 05:50:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27C641F22146
	for <lists+linux-pm@lfdr.de>; Mon, 11 Mar 2024 04:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6FA379C2;
	Mon, 11 Mar 2024 04:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EUuReWxJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5456A7490
	for <linux-pm@vger.kernel.org>; Mon, 11 Mar 2024 04:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710132650; cv=none; b=B9IOw5OAdWA8CLGN56fhAAPlDZBqVRglcxV2E539Yk/pb+MkTXb3KqkK65TB21ckSW7+ikj/Y0AjOUv0g4Bakh01kwKEBlD/kp+HDPYCvePN/cZVjnQAF9jvW/TeHBfi5QoJjrSkLdhd/JLgV5PkIfWYXwaIIDMmmm/tHs6MkCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710132650; c=relaxed/simple;
	bh=x/uzfXxOzbqKSd67PBuy83Et2SEuvF/AVOWHtH5UYWU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uFnftvlwRbBudEvxveX0kQpPUZVuG4BMkr4azlnTvhVJr2PqcWAf8Knm/ulJgNCpAnYn4JqNrGb3jezTQcr7ZvZ6wFn4h4SJ64mIcULYI/UvvF90+HYFaCDRK+c/QD3FVhO4doRpKF3RUI7FsD2apKtVLuaxyvkSy4+FEhqodPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EUuReWxJ; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1dc1ff3ba1aso28874315ad.3
        for <linux-pm@vger.kernel.org>; Sun, 10 Mar 2024 21:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710132648; x=1710737448; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q1/vyyb7UixM+MEvW9AsLcC8YOFSA6iDMoo7vUn6seo=;
        b=EUuReWxJKlbMsZrvH43PpeDcO3bhy7s4tyvJ1bivV+M8Cj0WyvkkacvlLhP9ml4Yk2
         QP5aSbivsMM90HwvGbYKTPF/1d5MAplBP8KL525TeV3e29gq80a2HEcWmyPc2p5elrl6
         3nXBAjDXio424qm5+Yl58A5ut7Br66syHBNNqGiJHqCUJD1ZwcpTnJbrAfBQGEwM1nIG
         QD7kQeXpP9LzlfM0G7TPe4I6V1KhYwVCafpaRJnZx4rzgZB7UH9q2kIT4/+FmxV74IVD
         T/CMQZrWc33k3peybKymV2oaT4dRmxuXKNCfV8THXSv8a2C22LMSBr0QvVgQ3afBZahZ
         ySgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710132648; x=1710737448;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q1/vyyb7UixM+MEvW9AsLcC8YOFSA6iDMoo7vUn6seo=;
        b=cpaFCEqfgRmz3q80QUIgxabzGFGtB7GAk9ewcHg/jkUSSJKtuOrzbgc5001j3U7cXb
         nudEhYfrQfAIojGv+gtdZuF6AQOSlDXQ8c2Fr0CVhmchd7NqYX8whBb4eyzQstg8bLw5
         DtBxeek+oFPVuD8AeClBCBkf9Qy6Klk5W8XS4JnEjZYDBFHL0Z9ZNWonY4cEJsaUuMbg
         Y1FLuqvzBg2jCNCdmmGQUvbop8Vtf+MzBl5N/aDYxv0Z2hrdwBfdsaIB3Z4xpzTbnD1f
         DRouhCPk1ur+l6/tQcsTqS/0lpdjM4WOxlBYu6Awy1iHj4+OoRpAhHRsQW9kh4tXk5eh
         Ga4A==
X-Forwarded-Encrypted: i=1; AJvYcCXxezsL9I+/iUVjqKWiWJ83cdt898RlcoQQYQ/IYMm6R7Zq3cSSlvKiCgNV83jpqHoCJbJhAB6GOF53o8zFDOWJ39TDCa5lFp4=
X-Gm-Message-State: AOJu0Yz42K/PDX0AafLAvhUIY6qifNn7d9UugQ595ykWurtxO+ImMq8G
	YeNYh3y29y+cp2gD0KDT0to+ceVLhT50uMkhyPN9EkcqqKspdylbLV/yO564+30=
X-Google-Smtp-Source: AGHT+IFaFumoYymXG0elFv9QWhPYx1mJ45zKOvRlcg+v0XYxM1IGW4kDZhWUjELeGZppoh4j4XYmZg==
X-Received: by 2002:a17:902:ef8d:b0:1dd:6296:1709 with SMTP id iz13-20020a170902ef8d00b001dd62961709mr4639033plb.63.1710132648326;
        Sun, 10 Mar 2024 21:50:48 -0700 (PDT)
Received: from localhost ([122.172.85.206])
        by smtp.gmail.com with ESMTPSA id d4-20020a170903230400b001d8be6d1ec4sm3591966plh.39.2024.03.10.21.50.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Mar 2024 21:50:47 -0700 (PDT)
Date: Mon, 11 Mar 2024 10:20:44 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Sibi Sankar <quic_sibis@quicinc.com>
Cc: dietmar.eggemann@arm.com, rafael@kernel.org, xuwei5@hisilicon.com,
	zhanjie9@hisilicon.com, sudeep.holla@arm.com,
	cristian.marussi@arm.com, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, quic_rgottimu@quicinc.com,
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH V2] cpufreq: Fix per-policy boost behavior on SoCs using
 cpufreq_boost_set_sw
Message-ID: <20240311045044.7vvzbsx5nqs5a2lr@vireshk-i7>
References: <20240308103630.383371-1-quic_sibis@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240308103630.383371-1-quic_sibis@quicinc.com>

On 08-03-24, 16:06, Sibi Sankar wrote:
> +		/* Let the per-policy boost flag mirror the cpufreq_driver boost during init */
> +		if (cpufreq_driver->boost_enabled)
> +			policy->boost_enabled = policy_has_boost_freq(policy) ? true : false;

Can be written as:

policy->boost_enabled = cpufreq_boost_enabled() && policy_has_boost_freq(policy);

Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

