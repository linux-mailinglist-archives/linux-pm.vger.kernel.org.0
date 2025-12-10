Return-Path: <linux-pm+bounces-39399-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A86DCB212B
	for <lists+linux-pm@lfdr.de>; Wed, 10 Dec 2025 07:30:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 49E74303EBB7
	for <lists+linux-pm@lfdr.de>; Wed, 10 Dec 2025 06:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47EB3223DD4;
	Wed, 10 Dec 2025 06:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QBFnEeAq"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19CF2AE78
	for <linux-pm@vger.kernel.org>; Wed, 10 Dec 2025 06:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765348228; cv=none; b=NzeQjRxjLUo4vt1tazjdLrRMt0PskHutIXh2fssOANd3QQgBG9EjntAZ6b089rvosZpNQX2vhavUQ3jTXrxhHhj3AlgwT7CAxGnEEk+QatiUsJiyJKaI5LWSccEgUjRUXZ5WXVHEXSBYoehu468FtPFOG3IUzRGmq+dEgeplEm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765348228; c=relaxed/simple;
	bh=OjBO8uYS+caWK2PhpOhVEk3v6aRLFdXrtDoP1MynssI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TepWc5emlyzoOe1YrwpKvyDLPIMKylzeaK8DIT180+nPRPTe4vjbSUz8clu7mGHUnO76j61JgfDlLgqBQ/zkM0rUGb77CFG1oVNXz8fPujvzk8sUigeihHeohFmBs1PoOiKXa8JQzFxTA1Eu5abzwfAsXklesxCgb5LGbE1mLKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QBFnEeAq; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7ade456b6abso5578482b3a.3
        for <linux-pm@vger.kernel.org>; Tue, 09 Dec 2025 22:30:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1765348226; x=1765953026; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bku0C59aMVyQUvdKG0bvojGNybjSZ9I395Pji5p8HxU=;
        b=QBFnEeAqEJ657WMlvQ+ONq64Som8AZzuW6ayYRMFLwXxPdep2qzh4eKVutXivgg63a
         2SG8RpOLSGdSYXOOdibvZyomI3OeeQ5SwySCcI6lw8dAqWxYMJqIjYRbLP2Pvxw63N96
         nP28GVHHVfVrNMgOlsZXx9GtWXR5Hy+HSJhra1Hfzv/J84N2+gbooYQ3HBYtF3aC9UgQ
         oT9d+c+Q2TrkpWyCOObDNe1T4baEXjaCGBlnQ+v9f79cbwDzgzXld5PoKy/rTeeSPHW/
         y9qfrgvdFo9JE8sJf8V6hZsoPdtOA6DEVhrTA0GkkAvys4vJkxkq+XAUvaZEH+ZSzGio
         XeVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765348226; x=1765953026;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bku0C59aMVyQUvdKG0bvojGNybjSZ9I395Pji5p8HxU=;
        b=umNJDoy/S4HnYpOT2ggJR5vcJvXkswGeLxsLevGcCeZ/AW9AbeF3KnhfzfEmLyYwsK
         9QJT4VThTsYKUO4jjl6sZUgURSmUn/hJPCZtw1U/y5QWRx7eb6imXv5BMWCYHzcDIsFl
         zyjMhhSn2iwX4PTFYuRIsvujuDVcSeJI+Xj2YEi0iUhhe2Yxe11tKY70rwcs1v1GMhZV
         K03+7Wau3MVZ4smOoWdgdhP4HOXgx/M5u0uAQz7mT6qdTjAViLTqF/MB72ljiRFsOchb
         IWRubuGmFlNAQWaROT+7XD6MC24qCvSy9t5cGx5DR9+Uw2pAKGZyNWcNN/S5+WHMD+GW
         sC8Q==
X-Forwarded-Encrypted: i=1; AJvYcCVo2biBKvZumfaiqynI3dzWJe/AMw0B0bJy1SHExQdhRdjQh7mRFrKTzslFiOvEkt+A5XSBCUTbEg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5wX7DyshGmYTk1ZrlhvDAIdFQhS4PtxaApODvoT7ESpo9Rlr8
	DJ7AUKBYGMrxiTQcwqzexvGq4Lq76DKp5fVJ1Hq0VUFsVZSGFu3DOOGiibbDO9WGsS0=
X-Gm-Gg: ASbGncuRFCLlTf8G3PrupqPxzHeDxOhomRGnmrqYSlq48DbBzsRWLT828FizgFoQKo0
	2nhYy6w4OfYIRpeKExQAkJf5irj0NxFeD3dtbCLKKxPsp37pvGa+uMvV9o68YgSjRd2JhUqeBoh
	jGvR6//VLPgZKPwdXvSGiSqNmd+3lMu3YYWKAMe2uzKA4OPxJQ+pvYZ2AJSR7wF9oii/nNEJfAd
	4TTJ9qYFsqPN5ItkUmXQSjLheNyuyRmRtCkR7ZPvOj7RmlHN7L3BiBoU4RSOVpdk/Y1yedmkb/Y
	eQKc9+1TkjA7QHmaVCPgt8HzyoAry4vYEANZRP4SVM0QCVzKDnwkamzNVGx/PiQtXDKCmXIVtLp
	bHGDieHNrkYKqt/0FGuUoCZFLzC7aiEE6Fh5d7rnnb9rcmKf4lqoLl+by+2+/XK/uGc8heyI4hG
	TqtbrFIYXC08M=
X-Google-Smtp-Source: AGHT+IHnGEp86jFRkH5rOtu4eme6ej2y3wjRg0Ss5Xh1/I/PpPdnoJUppTb/16j23tWEKKa7hkYHpA==
X-Received: by 2002:a05:6a00:2e0d:b0:7e8:4471:8e1 with SMTP id d2e1a72fcca58-7f22f904308mr1219092b3a.66.1765348225735;
        Tue, 09 Dec 2025 22:30:25 -0800 (PST)
Received: from localhost ([122.172.86.94])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bf686b3e683sm16560376a12.8.2025.12.09.22.30.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Dec 2025 22:30:25 -0800 (PST)
Date: Wed, 10 Dec 2025 12:00:22 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, 
	Pavel Pisa <pisa@fel.cvut.cz>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, 
	Krzysztof Kozlowski <krzk@kernel.org>, "Rob Herring (Arm)" <robh@kernel.org>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] cpufreq: dt-platdev: Fix creating device on OPPv1
 platforms
Message-ID: <rcnqsevjxtyfu56pcw5wfjh7wvg4q32xu2xkol7tfvaozewrxz@3qn5qbjc5mpd>
References: <20251210051718.132795-2-krzysztof.kozlowski@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251210051718.132795-2-krzysztof.kozlowski@oss.qualcomm.com>

On 10-12-25, 06:17, Krzysztof Kozlowski wrote:
> Commit 6ea891a6dd37 ("cpufreq: dt-platdev: Simplify with
> of_machine_get_match_data()") broke several platforms which did not have
> OPPv2 proprety, because it incorrectly checked for device match data
> after first matching from "allowlist".  Almost all of "allowlist" match
> entries do not have match data and it is expected to create platform
> device for them with empty data.
> 
> Fix this by first checking if platform is on the allowlist with
> of_machine_device_match() and only then taking the match data.  This
> duplicates the number of checks (we match against the allowlist twice),
> but makes the code here much smaller.
> 
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Closes: https://lore.kernel.org/all/CAMuHMdVJD4+J9QpUUs-sX0feKfuPD72CO0dcqN7shvF_UYpZ3Q@mail.gmail.com/
> Reported-by: Pavel Pisa <pisa@fel.cvut.cz>
> Closes: https://lore.kernel.org/all/6hnk7llbwdezh74h74fhvofbx4t4jihel5kvr6qwx2xuxxbjys@rmwbd7lkhrdz/
> Fixes: 6ea891a6dd37 ("cpufreq: dt-platdev: Simplify with of_machine_get_match_data()")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> ---
>  drivers/cpufreq/cpufreq-dt-platdev.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
> index a1d11ecd1ac8..b06a43143d23 100644
> --- a/drivers/cpufreq/cpufreq-dt-platdev.c
> +++ b/drivers/cpufreq/cpufreq-dt-platdev.c
> @@ -219,11 +219,12 @@ static bool __init cpu0_node_has_opp_v2_prop(void)
>  
>  static int __init cpufreq_dt_platdev_init(void)
>  {
> -	const void *data;
> +	const void *data = NULL;
>  
> -	data = of_machine_get_match_data(allowlist);
> -	if (data)
> +	if (of_machine_device_match(allowlist)) {
> +		data = of_machine_get_match_data(allowlist);
>  		goto create_pdev;
> +	}
>  
>  	if (cpu0_node_has_opp_v2_prop() && !of_machine_device_match(blocklist))
>  		goto create_pdev;

Pavel, please give this a try as well.

Since the original patch went via your tree, take this one too please:

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

