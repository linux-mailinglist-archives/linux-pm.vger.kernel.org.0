Return-Path: <linux-pm+bounces-27338-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C47EABBB4B
	for <lists+linux-pm@lfdr.de>; Mon, 19 May 2025 12:40:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC9A4178313
	for <lists+linux-pm@lfdr.de>; Mon, 19 May 2025 10:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D733B26FA74;
	Mon, 19 May 2025 10:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kNqFJQy2"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1BB1E1A3B
	for <linux-pm@vger.kernel.org>; Mon, 19 May 2025 10:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747651217; cv=none; b=avf5KCwZ4+SuEUESSzbDK7wckY5FeIJizN2VJjLTT2csf+g5w/ziySfn+MSHb5Vmupm6U4Os81s+kW9dWrsAuKqlRbOFf7lhrBX9ywuRnJ/MUYlzBTALu2nYjY8sT+mK7ZABQkLwDPC6r7vj0NMaFjGrg+oD5fHx/RGmwDORRKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747651217; c=relaxed/simple;
	bh=/Vmq3QFqnBlwuwwR+4xyRvi/TqRMdnogscI2G00PWto=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k/bLm1hpoyfGEAyAn5CpPopQABan+BmFcxTjDmsH4tCVdSfVrXaScnLAc06BO7LtTSzxrniBCLcwG6kdBQ78UFZ59JRr2DE8nUWBObGK5HGWhDdFPtP9Ke9RkjRsB2tmlD0ZA7ZYYqotudDSbOi0+qd8PsGuA9uxhoZMupqfpZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kNqFJQy2; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-22e331215dbso38661125ad.1
        for <linux-pm@vger.kernel.org>; Mon, 19 May 2025 03:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1747651215; x=1748256015; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=i/aIx7AvdzS5nlXdZ8v4o/L4Qip57mcjCKYS6Puq9LQ=;
        b=kNqFJQy2TEm5Y4Gjl6B5LCjDKKjoYIwMG4kwifLNNegw+vAfKCl/G6Y0CNZdq5Vzgs
         NKjA9BkTm/JYrfewSN2YtEEQDfHgH9wU0O3DgOE/VTf4vpGZluS71v0Up3S43xY1Dw6I
         CiOEd2sBKm7iprYQP8xneVLewfdd+fZoqzxqgOvxGqgQTw198u8DnWACUWWQovrSnpPA
         mbBuy2H9c/JcVEuoTbDqcKGC7dgxQvoovE7qKpGN6cATZFveG3saN/w1Gnnp6CM5SNN8
         NFjIN2YmXpKtQHLTWK5/VdH+J4z2HujBC4nGLatM1b6PndOufWeT2kVG4VPic8nUKoak
         nOkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747651215; x=1748256015;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i/aIx7AvdzS5nlXdZ8v4o/L4Qip57mcjCKYS6Puq9LQ=;
        b=n1czFMyct5ABeCe2xW5o1zVibnMX+hVmPWRH5giQjE/4pp1QXGeRF7wynZ3CogfOIS
         CJx2URExM7T/PhJrSml7e7eWVPMY+Yr6lcm8yJfCOL3XKJLrjdpo6SH4DNYxXtfuJHPQ
         jZqEvS2TQLs0XNWXT7qLEuJTQph7D7cChI8u/jDpoC9+LnkiwJAF/KQ7nDBzIpY6+5RW
         d1NVAFaKVG89fcIyeR+l2QC7HWikVU1jMCSLh/m1OAQ8o/a0mJF+/S0vxKvUnempJ62C
         nQUUDZyWMfoz2zezJYNFgr8zFyyAe7673t+kaMLdrccpjR5jcbUikZjEvIG5J/wwFJbt
         29qQ==
X-Forwarded-Encrypted: i=1; AJvYcCWb1TUiV+CgEEthew3v19wIlsUQcaSGCzYFuMGNBEtqhwncbFhvn/v44l7D/NIZKJyLez1tfPVhZg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2ftzu+qbtcQ8hZkJ89Ltido7K3s3V5HNKv5inPl5CJ9rrqJKn
	vZ60Bhn4j2r/ebD3dV7AjRPrdNV6VBtfbTRGAXz4DoHFzSzZLD0cbnJjV43wa7WmJUs=
X-Gm-Gg: ASbGncvI3r/ppj5e2oINfo9lukbN86npPoWtW9Ls2KoN2gPv1ZvbG03B8wceC45Vzyf
	/WiqCecxMy4rFOJlB7K17xZQvlHAM97HIJAujFflMSqp8pM2ptXfrctmlpVoQSv8s2LhRNub0QP
	8OsQaeAX+vtvEp3386Bw/ydjYIUiZIq3cWVdzNIjrDuH3zRNHbkr3IZL7qoClr6Dif4rPhqmV6D
	ss5iyIS/pWfxt0TYUImkaf+XsIDCEptfyk/plVIxFw5YDT1lcFjhMKtROHvAEzlqf4Li4rk6Otu
	C76q9iaTAdst5Ikjc1j7pzv5AbfiLl9FYGw/Tdse4lqhKO20a2zX
X-Google-Smtp-Source: AGHT+IGV+/iosPw4tJfGLDNquYrwXS7YO+74bIwXmyBHISJk19CDoPFblHZ0P+89TKUcqBjFApznxA==
X-Received: by 2002:a17:902:c209:b0:231:bc7e:a54f with SMTP id d9443c01a7336-231bc7ea667mr160254935ad.26.1747651215411;
        Mon, 19 May 2025 03:40:15 -0700 (PDT)
Received: from localhost ([122.172.81.72])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-231d4e97fa6sm56235095ad.135.2025.05.19.03.40.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 03:40:14 -0700 (PDT)
Date: Mon, 19 May 2025 16:10:12 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Mike Tipton <quic_mdtipton@quicinc.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>,
	Cristian Marussi <cristian.marussi@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>, arm-scmi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, Peng Fan <peng.fan@oss.nxp.com>,
	Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH v4] cpufreq: scmi: Skip SCMI devices that aren't used by
 the CPUs
Message-ID: <20250519104012.acyfoffelestwgtt@vireshk-i7>
References: <20250515035312.3119884-1-quic_mdtipton@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250515035312.3119884-1-quic_mdtipton@quicinc.com>

On 14-05-25, 20:53, Mike Tipton wrote:
> Currently, all SCMI devices with performance domains attempt to register
> a cpufreq driver, even if their performance domains aren't used to
> control the CPUs. The cpufreq framework only supports registering a
> single driver, so only the first device will succeed. And if that device
> isn't used for the CPUs, then cpufreq will scale the wrong domains.
> 
> To avoid this, return early from scmi_cpufreq_probe() if the probing
> SCMI device isn't referenced by the CPU device phandles.
> 
> This keeps the existing assumption that all CPUs are controlled by a
> single SCMI device.
> 
> Signed-off-by: Mike Tipton <quic_mdtipton@quicinc.com>
> Reviewed-by: Peng Fan <peng.fan@nxp.com>
> Reviewed-by: Cristian Marussi <cristian.marussi@arm.com>
> Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
> Tested-by: Cristian Marussi <cristian.marussi@arm.com>

Applied. Thanks.

-- 
viresh

