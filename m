Return-Path: <linux-pm+bounces-31584-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B192B15AAB
	for <lists+linux-pm@lfdr.de>; Wed, 30 Jul 2025 10:33:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 571F03A8FCB
	for <lists+linux-pm@lfdr.de>; Wed, 30 Jul 2025 08:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DF58290BD5;
	Wed, 30 Jul 2025 08:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AJIXC2ee"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BEF0268C40
	for <linux-pm@vger.kernel.org>; Wed, 30 Jul 2025 08:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753864137; cv=none; b=KhXSpamZyV9WB820J3WbRUM+2Fb77IpsyAWl/4TYI9a0b0Cct+kWyGSTlHfsHW33/9ZkhtpzEULfE2ncyyOt+VpjreXZLpJv6TNTmr4SutprLTVkKj6oNfkK9VvtWKs5exmcZHeJwCphzB1n5rhxsLr7A7gm8UhngJFZHjlp85s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753864137; c=relaxed/simple;
	bh=1r0lsiP6NFGnYsSI+kcsYV+APIoQCHOYgWvbuEVB5cA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VX8eldiz83zvq/vSTlqmVSiTRcUeYShkwsoZsTByeNSlWAE05v3LVDlMZ65t3RVdMSSEY//shmcyjnOZeAqBOQ3xQR6ZneaTjulmgSCaEb5jLIytu1MhcD6G5O2TNaeU7I6D68MY/FdFsK9VzO8Ww2kPHUCe4PQH4oAta3IB+eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AJIXC2ee; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-74b56b1d301so4375696b3a.1
        for <linux-pm@vger.kernel.org>; Wed, 30 Jul 2025 01:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753864136; x=1754468936; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YerKRYt4LpxD7mnuz6omSbAb88Gr2Tk54H8CGOtbvNE=;
        b=AJIXC2ee0SLyJg4Q7rmt/K04rQ/yuITaF6KL8bseDIpuRbI2W0d/3ixxVAOHw8xEdW
         YWBMFkxY87FCAzPgaGwOZjnPZVlnQ74f7sY1k4vs4IJs9xTYHwwAdSIQNW8ZDofma8vk
         vYQlSo10TV+y0NGravTM/AaBE01YQliLDXahIrVn9dhrgeBF+HXmNokTJmDeg6HulHDI
         0Ni1OfVCFC7S990O7phwaibR6bI5zurNwL17z7NJXZ7AtMI7rSmVlxfWunhS+rqTLMDU
         qRviaKbc6rJ72M6nF4fY0vp6zp+HYVHj9bliUBTKu/Jd5+FZgVp8bnMqhM5267E+EQA7
         isuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753864136; x=1754468936;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YerKRYt4LpxD7mnuz6omSbAb88Gr2Tk54H8CGOtbvNE=;
        b=lG9qngs1Aah9ZgLuY+FueE9eTOgvVgVGQw/EJbNri31qvZKrSBObJuMZoMdu5nEgao
         HLCtFj+cqR0xpMm+TaKvoPWxQI2E2ADbfKW8xenZfVujyk0friQEfv39+w78/D3a0QyF
         lISo4tSHa3N1RXizZ0cF0i1VeLMn5i6t+ZgwnRdPnyYd4BuZ3rO62L4s8DZa+CXwoYKz
         fjZP+Y07XLZqpktwpV3P3WT8aqt/hYRtltpJriFyf50N4CjsvEUdSdOX4mtkXxGp05zK
         M8J6ti0HBon+PFVBRdV06ywLAQCoLmq7L5jYWj2jKVu1RLD30BhqOQHEDMxtDby0D1gT
         3HPQ==
X-Forwarded-Encrypted: i=1; AJvYcCUCsQE+tr7Da/YnmXDm5f9v3wrB40uFSjK/LPdzf4UO6l2oiepDK/Hzpd1KIG/VwjQIwVZSM69Efg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyemwjyYqJTNRYe0FkxBTlrgT6hQtKeY6t6tXcSa/CNOUatiOpb
	dKzfHQv5mr0GybXzR2FY9y19U6YeI5AdIfY/CMgtefwEI3s37rJQZgoHX4EsgZoAFMA=
X-Gm-Gg: ASbGnctw2t09MbNrrLnxd92M5XsGYaFn9dEApcahGSs/LXzV3zDN00D03qKdIJpODtv
	Vddwye38UIAa++B5Tj8Qf4uzjs/2Xyzzs4cDXc+CHrSQsf0156aQ6OqnB8ta3tBFGSXTzTn3Vcd
	RVA5W48Ximc5G+3qahVjHmvy+FiTCnS6XoE3c3d5vqPe/DfxnzyIELqI7wGVj1a2PSajqrdS4Jz
	SnYVd5aHsMYz3MLzeNlx0ca5En+UtCXlEo4pmBP4jlXxbV1uNbgGSSbza5drvr2998PldNYRXkM
	BiDnR0l6cnekAPzsm+zy9W12UK80XQWnm46CrsiTWYUlMoc+Vlld7e7IjtH0slfgpwQLHUBGT+9
	7JhDeEBVLp84AKDsiBB66fUY=
X-Google-Smtp-Source: AGHT+IH0CJhtgQb6pIChZ+X8XZwoN1ESWodJscR6CHa9EpEX0lyC2wpKatW0FkXPKTJsPAVRZjuF7A==
X-Received: by 2002:a05:6a20:9389:b0:232:87d1:fac8 with SMTP id adf61e73a8af0-23dc0eba14bmr4486339637.40.1753864135839;
        Wed, 30 Jul 2025 01:28:55 -0700 (PDT)
Received: from localhost ([122.172.85.40])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76b8d37eee6sm282359b3a.60.2025.07.30.01.28.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 01:28:55 -0700 (PDT)
Date: Wed, 30 Jul 2025 13:58:52 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Varadarajan Narayanan <quic_varada@quicinc.com>
Cc: andersson@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	konradybcio@kernel.org, rafael@kernel.org, ilia.lin@kernel.org,
	djakov@kernel.org, quic_srichara@quicinc.com,
	quic_mdalam@quicinc.com, linux-arm-msm@vger.kernel.org,
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v4 3/4] cpufreq: qcom-nvmem: Enable cpufreq for ipq5424
Message-ID: <20250730082852.oxy3tjjtdrykrzne@vireshk-i7>
References: <20250730081316.547796-1-quic_varada@quicinc.com>
 <20250730081316.547796-4-quic_varada@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250730081316.547796-4-quic_varada@quicinc.com>

On 30-07-25, 13:43, Varadarajan Narayanan wrote:
> From: Md Sadre Alam <quic_mdalam@quicinc.com>
> 
> IPQ5424 have different OPPs available for the CPU based on
> SoC variant. This can be determined through use of an eFuse
> register present in the silicon.
> 
> Added support for ipq5424 on nvmem driver which helps to
> determine OPPs at runtime based on the eFuse register which
> has the CPU frequency limits. opp-supported-hw dt binding
> can be used to indicate the available OPPs for each limit.
> 
> nvmem driver also creates the "cpufreq-dt" platform_device after
> passing the version matching data to the OPP framework so that the
> cpufreq-dt handles the actual cpufreq implementation.
> 
> Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> [ Changed '!=' based check to '==' based check ]
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---
> v2: Add Reviewed-by: Konrad
>     Change speed bin check to == instead of !=
> --
>  drivers/cpufreq/cpufreq-dt-platdev.c | 1 +
>  drivers/cpufreq/qcom-cpufreq-nvmem.c | 5 +++++
>  2 files changed, 6 insertions(+)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Lemme know if you want me to pick this one.

-- 
viresh

