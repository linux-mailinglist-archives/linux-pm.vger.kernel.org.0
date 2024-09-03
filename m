Return-Path: <linux-pm+bounces-13382-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ED89B96950B
	for <lists+linux-pm@lfdr.de>; Tue,  3 Sep 2024 09:17:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FA0B1F26C27
	for <lists+linux-pm@lfdr.de>; Tue,  3 Sep 2024 07:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6BE820125E;
	Tue,  3 Sep 2024 07:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XYFDx0/4"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56631200117
	for <linux-pm@vger.kernel.org>; Tue,  3 Sep 2024 07:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725347803; cv=none; b=NuLyuz+AZGRXDD1aAmH6XChNPjKhMwWfl/g95PjQ2NYiia1z6ZIy4ftPNhmK2hhfNeT443Pr9TaEIhJQXwH76Oi71Swr27TFb3IWBdDIHgtdKMwEtIvPjDeUwR5LW5eWylPHoAGQj7a9wfnAmhBPpn5vf0Gb/Rv5Eg/afbIl4Xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725347803; c=relaxed/simple;
	bh=XPc03TPxe+aS99ztj6CnYNIx+j8e7eadXTmBFgCdhds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LE2nJRVKmvsZzZWNeCVPmaV31H8OL8qOlxtxKaxUO26KssVaF/z6VqfDdbBQf+1Aw+J8CP6NW+kWFQF2v3cF7lhCKOk3zKXGgQpLSXWJk/rMHtPsMMuIIELuYEDHYBhkZPWJ+M6GvHcESsizKPqrFrX8zBlKwYU3eKl50+X5QA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XYFDx0/4; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-70f60d73436so2796431a34.1
        for <linux-pm@vger.kernel.org>; Tue, 03 Sep 2024 00:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725347801; x=1725952601; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aQ4bLgs07bsTPwzBfSyYXOvsNNczM2ILvCZW4w+soYc=;
        b=XYFDx0/4QyrFO6DNDaz+8eOBILUl+ZFM8jGf9AJ2jBo7oFxa8OCoaH/dCAvH+leDSs
         sI+IVnz3la5WTSD8Ok+kXUTHN0g2LGo6XeyWO3PDvZ88PqL9JZ1WYIDREw9u/OqMV4yB
         wwp2kRqjos3GCOvZPUMwRHKX6TXp6PAcwYcyCFbUqWHSYnyeR5YjvxHEgK1zDfp+bIif
         Ed/ukHfDYqxlN42kqLpCXyqTmsbjGNgR9pgkdm+IFxk8VfIPMXu/G0eEwNsmDbvG+Vf8
         s/gDzNGq35RF3NDqOrmG4a9QjJbGdUcR1HMAcpRPUZw9Kf8foJG8eqgCW5pwzbqmLre3
         oUTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725347801; x=1725952601;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aQ4bLgs07bsTPwzBfSyYXOvsNNczM2ILvCZW4w+soYc=;
        b=swxvoisJJpg/lA+XBoFqydlzN0HYaPJF+tpEYo9Glf7yNoFR7SrVC97IJLj6Z55Y+x
         aoTr+DAmGASMBPbFLqZ8RAnIcVUnVu8c2W0vPikOaE9lF+Zi9kngxOdtHCaJMElzF2rx
         N/P4+K7KHCCzJZsL/S6Clpplgerj9UnlQn1xtf55sVx2/xshhKosmC6lJ/Qo4S3O5P0E
         g+k6AgSTzaniCLbNRTdlngjM/wTS7Y11FzdJVxccl7CaUn/qMX7FwvHJLD3G3xo9DsHV
         nrlXXoKlTCVsySXKyVlx8xHxe7EFGYnGVZBze5zjYh8/jFXVBQyyUhwnwHozSHuIFU9K
         TdoA==
X-Forwarded-Encrypted: i=1; AJvYcCWvcpmtoi5A9oad1uS04lxUzNmdNE+d9GdpbVla2fg0v9hac7K+Qw2v4dEbFjTS8Zz+TziDgw1Xqw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyIMFHkrRmkl1eE74xeMNLpZjhUsqL+SofUoYJ/JBSeXdwLSXAW
	uZXGAeBxrj0jkfD9i/90k1zlxFg4fl3fB4/WDljVF2VxOPSoS/qf0/wgfz6PPEE=
X-Google-Smtp-Source: AGHT+IEC58MuNIquLIcWVm0whkiY0HuInC/fEkWr2i5Fh8QAJ6xmQS3CNoAXQXJeOXOdS/G3LwmrNA==
X-Received: by 2002:a05:6358:720d:b0:1b5:a060:678b with SMTP id e5c5f4694b2df-1b603bedfacmr2000488955d.3.1725347801338;
        Tue, 03 Sep 2024 00:16:41 -0700 (PDT)
Received: from localhost ([122.172.83.237])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-715e569f485sm7855572b3a.129.2024.09.03.00.16.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 00:16:40 -0700 (PDT)
Date: Tue, 3 Sep 2024 12:46:38 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Dikshita Agarwal <quic_dikshita@quicinc.com>,
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
Subject: Re: [PATCH 2/2] OPP/pmdomain: Fix the assignment of the required-devs
Message-ID: <20240903071638.bedt3gllqdacf43a@vireshk-i7>
References: <20240902224815.78220-1-ulf.hansson@linaro.org>
 <20240902224815.78220-3-ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240902224815.78220-3-ulf.hansson@linaro.org>

On 03-09-24, 00:48, Ulf Hansson wrote:
> To fix this problem, let's instead start by letting the OPP core find the
> device node for the required OPP table and then let genpd search for a
> corresponding OPP table, allowing us the find the correct required-dev to
> assign for it.

Why was doing this necessary ?

-- 
viresh

