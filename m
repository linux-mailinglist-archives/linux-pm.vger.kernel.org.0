Return-Path: <linux-pm+bounces-40254-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E69EECF6B12
	for <lists+linux-pm@lfdr.de>; Tue, 06 Jan 2026 05:51:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 611A8302F828
	for <lists+linux-pm@lfdr.de>; Tue,  6 Jan 2026 04:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5771129ACF7;
	Tue,  6 Jan 2026 04:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Lq+X02uY"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8EED2853E0
	for <linux-pm@vger.kernel.org>; Tue,  6 Jan 2026 04:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767675101; cv=none; b=RxVIfWuP5t9AbX3zV4tQ/PMmlinuHdXf5qO1+k1tmAoAmV4F2At8MeJ+hdeQ8FG1lbWiBUlI9e9KnMmoOTy/s8MpizO3F0gCGyfU/qbMrXSxr1xANzFaaAsI2iDXjNOOUKV1xoa4Qmlc1cDBswqgxUz9D58EQyA2aIYuOwBiA8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767675101; c=relaxed/simple;
	bh=UlmB8aofFX+aBjyxbkeG7dNTDd6mRcjsRhEhjAKR9SM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d4j7kaAwUmj6kHEGnnFo6oIxNc75O6Vl3nfYhX+5eneKhW+0HbCh3z9F+ZtdJt4egB1mMf4NTYRQAgb4N94M7CHD/QnJBE2X20c3Dvca6KV7kYea3jXUUY50ueAZt+w5xHRt5J99t2JJYJsFG/ZrtRYL/vjoPzc1NIz+P9J1oDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Lq+X02uY; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7f1243792f2so454824b3a.1
        for <linux-pm@vger.kernel.org>; Mon, 05 Jan 2026 20:51:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1767675099; x=1768279899; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SjphLqaIHXVtilGhXjAX8dxDJ/NLDN5LrccIsr/6nyw=;
        b=Lq+X02uYzFn6FAGUkqLI8GwH5VTXeYrE8XDpCczrr9bagYsBDaL/PFL7Wg+fNILeXG
         Va656oMfKWAGbhuL9K1TUqFLm6sb53ACnPPn9L+3sRCQnquVJH9DRULI6lb7aIr77Dqd
         aykgBoFGW6hcJfXVstPAzSj/S1qc/OZx2D20OEkOjMThzZ4/giPtNMCsKnPYjpHs8VyK
         o1kzHm4IKPpS3esXyca/UnfhR7qRIjghiHsBdtY5QmAPSizIKab2HiZ8OI6ulDQdo9sw
         Yj+2Hka2+soZ+cR8ExBmSYY8531+vEleP4yQm4L5rri6+O10jfYNFUUEFZt2arQFZMLM
         Ff6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767675099; x=1768279899;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SjphLqaIHXVtilGhXjAX8dxDJ/NLDN5LrccIsr/6nyw=;
        b=dlbUVClQIrLO0BBQMqvgoabvDY+uKIWTonoWC1Xbt7GGCVOHvyXapVGdmEMTP3I/DV
         DVid9dNydSn1wjm/BbhWPRZ4U+4IE6qjqD46JCQIwBfxL1P2ic/Un0jJ+r1zYIpecQA7
         9HebSF8H6Uoh4L3JnWNnD5WLGX5hV9q4DyOpr6SgM5X32JMnWcKpWuw1BmmrjNsUQea6
         StwtkLg8Tv3RiV0usLPVQN+DizCeze849p24aOu9eKRdil0gOUq/60T0TSj8PdgyWSQW
         ou7Z8VvfbhmB3gjQV8tKsQmZPBgPwJQS5bLljBzX5/DIKVJ0VEfmOUeHLP3c9ta7XNCf
         HQ0Q==
X-Forwarded-Encrypted: i=1; AJvYcCWn8jx8pZM0mjVgvsBK+pV5Ydpm+147zCNRShtM0HghFR7im3APhYGmiQxqFeamF+MJd6nRdQzmTg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyMqECYL4GXEcMAlQ9aOmHGfu99YRyVfqd8B4p7Lr61Mx1SW8aQ
	ph2MQFERaKRo5cqxQLYfaZsQOPCyE2Hxq9AycNPoeOsjjPX7sqL68A77VstspoG1LIY=
X-Gm-Gg: AY/fxX7sFtUiIXhZcCKYdPUe0AH/1ZRrDKfG7cDq+Ifxmfpm1oxN4YVaU9cF9ONqrX6
	qqqd1SZ/Yob2Kr7MsEJVncPoNKGrjYbKvQPsySYqZI4DaETxeBmIEREIjFOPu2eM4jNhT0wPGh6
	5r6W0DbehFSZGIGdboSeevTBF6zhvphBRbsPl9u+Icsa439Noznm9Ak2vVdlAScGlyrmJWy72e+
	2YiyH65PQ4OP/D2p0vEZOmCWJPh5kuoyx/OTW/3MWAGC61He+ZrbIY6D6fuyDPzf35KhGznVqtI
	3LX+ZsdLffMoDOHsEYR49fPwP8w8dt0/CHzcza72O99xuQoeFtDWY7DZLmOegyFR+p8sEwENc+a
	QvMO5a79Uv6G6p5zk1xsc4zas6aIWlzcULQ5yd0wyNASsu1NfYl3O/HoxFWStlQIZ5rwK0bGMb9
	7u/enl48nqQZjnHDG6QQiExg==
X-Google-Smtp-Source: AGHT+IGPOMmk4ggw5KdOaZITHTcrBWtSYR9foQUpiyM6fqhTRbsCSNMCtOzpDSehnY+CUrQG9BI5yg==
X-Received: by 2002:a05:6a00:4ac9:b0:7b8:10b9:9bec with SMTP id d2e1a72fcca58-8187ded5625mr1459726b3a.19.1767675098909;
        Mon, 05 Jan 2026 20:51:38 -0800 (PST)
Received: from localhost ([122.172.80.63])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-819c52fd904sm707094b3a.33.2026.01.05.20.51.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 20:51:38 -0800 (PST)
Date: Tue, 6 Jan 2026 10:21:35 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Haotian Zhang <vulab@iscas.ac.cn>
Cc: andreas@kemnade.info, khilman@kernel.org, rafael@kernel.org, 
	linux-omap@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] cpufreq: OMAP: Fix resource leak in probe error path
 and remove
Message-ID: <5t3aovkbk4oziiddabpvlmdksllwi55uqycnktweu56fj7ts7f@eszra6duc6ya>
References: <20251215030327.1771-1-vulab@iscas.ac.cn>
 <20260105131253.2692-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260105131253.2692-1-vulab@iscas.ac.cn>

On 05-01-26, 21:12, Haotian Zhang wrote:
> The current omap_cpufreq_probe() uses regulator_get() to obtain the MPU
> regulator but does not release it in omap_cpufreq_remove() or when
> cpufreq_register_driver() fails.
> 
> Add the missing regulator_put() in the remove function and in the
> error handling path of the probe function to prevent resource leaks.
> Also ensure the mpu_reg pointer is set to NULL after release to avoid
> dangling pointers.
> 
> Fixes: 53dfe8a884e6 ("cpufreq: OMAP: scale voltage along with frequency")
> Suggested-by: Andreas Kemnade <andreas@kemnade.info>
> Signed-off-by: Haotian Zhang <vulab@iscas.ac.cn>
> 
> ---
> Changes in v2:
>  - Revert to using regulator_get() instead of devm_regulator_get()
>    to ensure immediate release of unusable regulators and
>    safer handling of the global mpu_reg variable.
>  - Add explicit regulator_put() in omap_cpufreq_remove().
>  - Add error handling for cpufreq_register_driver() in probe.
> ---
>  drivers/cpufreq/omap-cpufreq.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)

I have left some feedback on the previous version. Lets continue the discussion
there.

-- 
viresh

