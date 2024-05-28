Return-Path: <linux-pm+bounces-8222-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8911B8D1457
	for <lists+linux-pm@lfdr.de>; Tue, 28 May 2024 08:22:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 443F32826CB
	for <lists+linux-pm@lfdr.de>; Tue, 28 May 2024 06:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 343514F5FD;
	Tue, 28 May 2024 06:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HyHcZ8A9"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF0ED51021
	for <linux-pm@vger.kernel.org>; Tue, 28 May 2024 06:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716877340; cv=none; b=EU0KKi8qxcX57GMz8L5oh4pl58l0h9P8NpOkguPwB5f7qbeTRlrF4/HLCLGTnxW3204ND958oHWNQAFnTs/C56Vv0iO2FjSQPTUPcasltvH01Ca4RFaCkP4F6Wx77bdEtvvz9VUOsDdaVZF3JnSBEHpGg00XAKN/8cnUZ8XVm44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716877340; c=relaxed/simple;
	bh=sSgwOYRHZt/YbcgLjLwtPsu63K7tgceDCycI1YiPeFA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BUnhT7HNf2n2oriJaLWYhasv4JbzWVIDOQYF6xQ1ohht1bhjE/2NTahARbW4UBKw/oKINdY9EyvPBNOuIcTmAiJWiSGOXx7nikvvCZvn9xkOdrw3ns6ciUXYBkXazwLzsVNr/TH4jbXnpf031Lo9sA26YMTZOKUchDGuk6ytFCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HyHcZ8A9; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6f850ff30c0so350920b3a.0
        for <linux-pm@vger.kernel.org>; Mon, 27 May 2024 23:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716877338; x=1717482138; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=M1CHUr7Pq8GWsvlpUiKUEvnvLu0gU/BSuoJzF8WPCMI=;
        b=HyHcZ8A9w5/AGKJXt1jMLx/6casaWPe08m2+6yPmHRiAmND4w7ZWKrfg7dO6xetrJS
         inEDHn5KE60ahLfd6lynICBTLpAGyyASxd6FrhD3KxR3ZR3rppIFR5pK2HA20BvnlpEr
         GZTOsrJMWIPjbxAaGiTqzjv4kPOPFsy3YueA7KZ0/Gr266qwWuOtGuCcRXCuNb9rkVvL
         4c+X8dh+n44Ww0BfV1xqTSD9F2fcuPG0DiUkFnfALf4OmHg+RBAhy4yMAhfJDKPpDHpz
         DpvIDcJI5aFbsUIrXestRykGRcJ/AKv56c4EPoyoqq0THGniy6CfXsYjK3wYdalPO7/1
         VdIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716877338; x=1717482138;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M1CHUr7Pq8GWsvlpUiKUEvnvLu0gU/BSuoJzF8WPCMI=;
        b=rwhnGWl/L6q/4CaaeLx57xSVnTaoXaQTOX4PtbE6KwxlnDtS7VCRNFJXw9F/nG3Ugw
         M9pcB/97DKZ1xRoOyVWI+ML84w4ZC+SnS4vc5YoMB+A6zs2HqRWhuzlvk7flxR7UTTnl
         UYnFf9DljcQZ3P4McyXmZBYUReCt0RUb36Z1/auIHwyBdJ0kDQ4NuflSPvOa+FfSt5Tq
         U15kndOBt0SeSH58nhc3BquOG3WFbf4jw9qEIGBsUZg/EVRMzIQJEtRiIHIO3Ipxmfx8
         UqvtZbGptVlQk70UOy/0gjrtAHQGBzwhzZy4retdAtDBPIpqGzQlLzS3dE+ZqIUEBheg
         LDiQ==
X-Forwarded-Encrypted: i=1; AJvYcCXtxb8W4oankpD/cMiBpokslNkwA6yyotpQNIdr+3BOvXrgkuIXRm/UHWNKncKCdN7coWly4icuiwTpUCRsaDuwzMRWG+HP62I=
X-Gm-Message-State: AOJu0YywKjGgaG4JuPrcuo7H23+n8rb/zl1aeqX1X+AaMiZx1/AkyFi3
	P+qfPUARpgHdAADNxHfjRfn01vXCxVbVBggkHLPmisWFFMzNIRxJ9eOKhJK6tbU=
X-Google-Smtp-Source: AGHT+IHnG/9iKdwGz8BZ4UVDyhrtXFgE7l0DRXdew9SAvtrL+y7nxrXtyvsiWGYHJk7XzGoau+hIHA==
X-Received: by 2002:a05:6a00:428e:b0:6f3:1be8:ab68 with SMTP id d2e1a72fcca58-6f8f43c183bmr11831391b3a.32.1716877337935;
        Mon, 27 May 2024 23:22:17 -0700 (PDT)
Received: from localhost ([122.172.82.13])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f8fbd3ef3esm5802550b3a.32.2024.05.27.23.22.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 23:22:17 -0700 (PDT)
Date: Tue, 28 May 2024 11:52:15 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Ilia Lin <ilia.lin@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
	linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 0/2] cpufreq: qcom-nvmem: fix memory leaks and add auto
 device node cleanup
Message-ID: <20240528062215.msu5u6zc2whpqqob@vireshk-i7>
References: <20240523-qcom-cpufreq-nvmem_memleak-v1-0-e57795c7afa7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240523-qcom-cpufreq-nvmem_memleak-v1-0-e57795c7afa7@gmail.com>

On 23-05-24, 23:24, Javier Carrasco wrote:
> There are a number of error paths in the probe function that do not call
> of_node_put() to decrement the np device node refcount, leading to
> memory leaks if those errors occur.
> 
> In order to ease backporting, the fix has been divided into two patches:
> the first one simply adds the missing calls to of_node_put(), and the
> second one adds the __free() macro to the existing device nodes to
> remove the need for of_node_put(), ensuring that the same bug will not
> arise in the future.
> 
> The issue was found by chance while analyzing the code, and I do not
> have the hardware to test it beyond compiling and static analysis tools.
> Although the issue is clear and the fix too, if someone wants to
> volunteer to test the series with real hardware, it would be great.
> 
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> ---
> Javier Carrasco (2):
>       cpufreq: qcom-nvmem: fix memory leaks in probe error paths
>       cpufreq: qcom-nvmem: eliminate uses of of_node_put()

Applied. Thanks.

-- 
viresh

