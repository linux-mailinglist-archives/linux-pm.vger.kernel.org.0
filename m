Return-Path: <linux-pm+bounces-15087-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14F1698EA31
	for <lists+linux-pm@lfdr.de>; Thu,  3 Oct 2024 09:14:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB27F1F2100F
	for <lists+linux-pm@lfdr.de>; Thu,  3 Oct 2024 07:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 762B780BFC;
	Thu,  3 Oct 2024 07:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VnRZwKqg"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F157484A22
	for <linux-pm@vger.kernel.org>; Thu,  3 Oct 2024 07:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727939656; cv=none; b=UYTUSuCZMhusY5dESIWS0lOvJpx3o4HZzvm62Fy6gdfU8rvyotkuPxnDPM7CbSkQX1BvjGI9ycbyojrp/PQFyIwIuVvIGLeS75vN8oL61TVidRVvNBi4d5dBqVklV6nWUNWklfPzK7tQ0w13iRmvU78JjDEM0m4TqSNYqWfWSBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727939656; c=relaxed/simple;
	bh=rnCYbVwISgvzQVboy21nf7Z1AYb6vbTzmAfkgBhkYAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JPiAf7mnCOF199RtYfsVomjiK6V/AcetEbeCm51kJdf+awkpyfNAPTCX95ZkoVEnTaMJGKap2+6Lvj+2GCAhvGiLXvzvQ84pzBCqKkYFtXWH6LQ/KRyRa4kkNhNDtlDTeUXRD16E5Wdsfnlq72e6S/rLYazi09cmucbGBLqyCho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VnRZwKqg; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-20b8be13cb1so5865405ad.1
        for <linux-pm@vger.kernel.org>; Thu, 03 Oct 2024 00:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727939654; x=1728544454; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0/Uq9tkcCY4Z9Y0M4J4n4ZTY4ZNPUaY8aYtXqjP/jKI=;
        b=VnRZwKqg+PIHfAql4DCT6/P7/taq98tr9YuhYDJey0U+JUUnz6nDkW/D/d3ZNSVCm5
         GnXwjYNooZSXeUf0lPa/kOcfT2uSYrvUG8O1AoV0tRlWtKl8LpUgx4q1EBQmCq3kxvt/
         sG4nuTxoIOrbtfrUNFbn20+6ePUTGCEweeoZFK0U9c98vXbHd9TjUAxgfgtFxoU2Xj+a
         RNZm8/nIlSMpBhBaY8MTwhzgSuhE7DSJ6zfG7c09WksyN9RCWz8o9DfDa84YYWtcNCD3
         cGvzlqkXYkBEQxxWCnbxP3qdxbdBF+TPLWmPm1xx6weQR0xr28aClfImbZA39ixfsHZp
         F0Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727939654; x=1728544454;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0/Uq9tkcCY4Z9Y0M4J4n4ZTY4ZNPUaY8aYtXqjP/jKI=;
        b=QSYSttp+e4F7eXzpN9Stxft0gKn/zY2BkrcGn6BOLBR111bRwm4qdhO3/I/NaobMS6
         KeohFUK2D5D5Qb5crO4QfDowCbEdqfScJePathJ2XO/novGSW28eertPWG/CWC4u8JNx
         kBZWtHwDdgoDb0DTucScXqlgxxl8mr3GFvAqAed7jNmMsXLTv0OhStuCFpZZq4lnP0GH
         424VEg/cfId2DCw7mrylTq4GQXcXv4yjKZ6+zjUITrxfQxR/qFEyE0s/5LuXQYONg2zV
         98xvnc3terNT7da9g4BLqxGxbHhWCAB4QIdVvb34jxhzj0SPcEmOxva61wxElZKzuSLX
         0aFg==
X-Forwarded-Encrypted: i=1; AJvYcCURky9R5+NQuT0Hiwatl1z39jGxwqKIGPWgr65AucnkB9kSZg4YpsdHZm+dbdMjF2HziYLn5jKi/Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YyloYGqw8+G0tJbQI/kWuLtq0ORrlVtAVvko9kEgt2f62qk8mmA
	ZjIQosO6PE1oc/3an51iMeqz4rO4RdTzrFA3CRgC8vG+PnX47jatekIQAQn2OEc=
X-Google-Smtp-Source: AGHT+IH5ip0y/7dbLpJy/zrNgjlhVxLD8xYzpS7Yi6sWbO5a8a6piAQZB8S2CXnGMq1Q1WPiBAhy/w==
X-Received: by 2002:a17:902:d491:b0:20b:4875:2c51 with SMTP id d9443c01a7336-20bc5a01e73mr79268295ad.27.1727939654336;
        Thu, 03 Oct 2024 00:14:14 -0700 (PDT)
Received: from localhost ([122.172.83.237])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e18f770b30sm2919794a91.15.2024.10.03.00.14.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 00:14:13 -0700 (PDT)
Date: Thu, 3 Oct 2024 12:44:11 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Dikshita Agarwal <quic_dikshita@quicinc.com>,
	Vedang Nagar <quic_vnagar@quicinc.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <quic_kdybcio@quicinc.com>,
	Nikunj Kela <nkela@quicinc.com>,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Mikko Perttunen <mperttunen@nvidia.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Stephan Gerhold <stephan@gerhold.net>,
	Ilia Lin <ilia.lin@kernel.org>,
	Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
	Vikash Garodia <quic_vgarodia@quicinc.com>,
	linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 03/11] OPP: Rework _set_required_devs() to manage a
 single device per call
Message-ID: <20241003071411.vvhqb6bxxnrbkaw7@vireshk-i7>
References: <20241002122232.194245-1-ulf.hansson@linaro.org>
 <20241002122232.194245-4-ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241002122232.194245-4-ulf.hansson@linaro.org>

On 02-10-24, 14:22, Ulf Hansson wrote:
>  /**
>   * struct opp_config_data - data for set config operations
>   * @opp_table: OPP table
>   * @flags: OPP config flags
> + * @index: The position in the array of required_devs
>   *
>   * This structure stores the OPP config information for each OPP table
>   * configuration by the callers.
> @@ -48,6 +49,7 @@ extern struct list_head opp_tables;
>  struct opp_config_data {
>  	struct opp_table *opp_table;
>  	unsigned int flags;
> +	unsigned int index;

Maybe name this required_dev_index as well ?

-- 
viresh

