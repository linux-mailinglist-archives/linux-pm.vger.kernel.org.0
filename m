Return-Path: <linux-pm+bounces-32127-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EE2FB1FFC9
	for <lists+linux-pm@lfdr.de>; Mon, 11 Aug 2025 09:02:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0517B7AA4D2
	for <lists+linux-pm@lfdr.de>; Mon, 11 Aug 2025 07:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E365527F724;
	Mon, 11 Aug 2025 07:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SZQz9W81"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 537AA1DC9A3
	for <linux-pm@vger.kernel.org>; Mon, 11 Aug 2025 07:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754895718; cv=none; b=cVyp3RLIM2aQ5wVBmHw7+9sS7pDScVXn33Ib0oPwsnEYqpmuYJlbVMuJffJsKqrzKLO7b9RFT9+6r7ijktslQSIbEg20Ksf8wZEvScRp1fPk2lewrKhGkqWn6Q/z+rjRiESy7PxvOc59HGrE7zqgbHa2z4cxq717HCqaMVwffCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754895718; c=relaxed/simple;
	bh=i5i+o2f+rrl/OAOkHKuvWRjEKuAxEakK5GVIkg3Co6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jzgg3rYLmSdJM1lnTW6hLWYCDXNJ09p80r3hEETLyMpk0gLaQTIBZTI+OywwvROgPKxSVAYS9vUuLLGB90eyU9Lr4yack2PP3YxyPAPL1OuCIplLNP2/KtgPzTRiEOa9Y5DPyyHcrK2lkE7w9weBf4C7lGOqT3ELDrnIsI9b6fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SZQz9W81; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-23c8f179e1bso50829775ad.1
        for <linux-pm@vger.kernel.org>; Mon, 11 Aug 2025 00:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754895717; x=1755500517; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VHEw2IHzxA4wFPAA7C102H9OqGdRlerd4Wo31dulLWQ=;
        b=SZQz9W81/mXFsNxJ/m3ywX8jkIBpAonPnoei/q2JpUG5H5shjzuloeEut9f5VOTkSZ
         8HtUlOLiknpX9bxHSZM4vD61gZ+mrCfdAzka1joWQg0DaZ2Y2DJyoRjzzR1YiSlFnf8c
         FFPfVHfyjSWC1TWZbhntRW3MvERT286sVK5rNpwSF4qtlaYsVrFE063JIXP5ioKYeInm
         VvQjWFa8QcGP8pAWKtsn05XqknTOF/UIhkhqsDfxA7JGhgoCWzAJBvXbWmRhX46dR9BD
         FntrFGOsuiSC3CCgKdZxmM+cud8WuLuzGF/7dqphZQnTAQtyR1nOz7Cnrtsbe8IHdPCE
         G6Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754895717; x=1755500517;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VHEw2IHzxA4wFPAA7C102H9OqGdRlerd4Wo31dulLWQ=;
        b=lXgMr74z9hdC9TL7FR6POuLMZWEd2FnCjofgN+Ws3OBsHOibjl/4fKhLu1Yzutrxi0
         L0CJlhflrKGY/aYnAyrrz4IOHiFedEB3yFQ1xoyCylGsbpTgQKk2QuJ7Mbq7W79znyxx
         I4GHhmpohTUwxIGcs8KrIR7Cnx5gUsU8eWkg/MTmikkqwUn+MPKz9Uza4UCxKCy3mpjw
         k9DSHsOJo7v2YMlyVDJ1uLMSuYkkX8MHR8+HkVldY3zXe0My7r54d2PXekq+xvQkm/t1
         5eddEg5lney1nRrtKDr7hVYGu9PEOcEKt5Hs820t4OdSxWm0YCg9fxbwALHsKZABzIfr
         nlIA==
X-Forwarded-Encrypted: i=1; AJvYcCXhHFETlzjobDq84u9gZQ3d67BIeljEtiwl7RsBOKPrK/B7gZsyYqUC2yegb+XfzAfV1lwB470CGA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxPp714eRMcL+EJDrM9CzYhX9jPYy6AmIfXub1aJk6Bk8jYE0Zm
	cB+AtmM5pIrnNU6ZxQ4JyQuprStF2lLfQjRF0TRpKWlcM2cZ7MYqimNV7H3t2jhGWy4=
X-Gm-Gg: ASbGncsv36jcbWzVU6RRUYi+Se7FzclTtIkWXigSPTcyUJmC0APTBprVS8W9OgccO9Z
	Z8Fqe10tRYC6Rp8RyC9aoZEQD2x4yf9jiQ1q5AJu13reDG+hNTxwmGY9kU3E/gs881WqvYYpOgn
	7PArE/AOlPdviT7/DqPaeau3+tK4cieDpzarQqSc+Gwn0gvlU3ds34asMkxO8vhOIBrfU8oIjJ6
	lG14NpHAFvFWNzDyhw/Pkox8sZhLg5r72035Ert9bG/Y28P3Z8cWS3RYW609LYzXlgJu/Idmawg
	ea1lCaT9z+VC41A8jXz7HE0XDMjeiCKeVPWuaUi6LNou9jXeW4qtvvsXJrPaZzr9kvBMAt4Hqk/
	7TWlKZ3VfyaLuxFbX3cp/4zzr6sBNfkj8Huw=
X-Google-Smtp-Source: AGHT+IGfBYscmszLcQ4WIVww+p90HeYYLjnd7VEGcPNozcJMTJpfpN4Si84n434k13+c6xYJKAYYSQ==
X-Received: by 2002:a17:902:fc4e:b0:240:469d:beb0 with SMTP id d9443c01a7336-242c21fc427mr199498845ad.31.1754895716651;
        Mon, 11 Aug 2025 00:01:56 -0700 (PDT)
Received: from localhost ([122.172.87.165])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e899aaecsm265961735ad.119.2025.08.11.00.01.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 00:01:55 -0700 (PDT)
Date: Mon, 11 Aug 2025 12:31:53 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Varadarajan Narayanan <quic_varada@quicinc.com>
Cc: andersson@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	konradybcio@kernel.org, rafael@kernel.org, ilia.lin@kernel.org,
	djakov@kernel.org, linux-arm-msm@vger.kernel.org,
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	Md Sadre Alam <quic_mdalam@quicinc.com>,
	Sricharan Ramabadhran <quic_srichara@quicinc.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v6 3/4] cpufreq: qcom-nvmem: Enable cpufreq for ipq5424
Message-ID: <20250811070153.5rjj2cudgs7rwiwc@vireshk-i7>
References: <20250806112807.2726890-1-quic_varada@quicinc.com>
 <20250806112807.2726890-4-quic_varada@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250806112807.2726890-4-quic_varada@quicinc.com>

On 06-08-25, 16:58, Varadarajan Narayanan wrote:
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
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> [ Changed '!=' based check to '==' based check ]
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---
> v5: Add 'Acked-by: Viresh Kumar'
> ---
>  drivers/cpufreq/cpufreq-dt-platdev.c | 1 +
>  drivers/cpufreq/qcom-cpufreq-nvmem.c | 5 +++++
>  2 files changed, 6 insertions(+)

Applied. Thanks.

-- 
viresh

