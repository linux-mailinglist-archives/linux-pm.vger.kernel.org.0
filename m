Return-Path: <linux-pm+bounces-27381-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99117ABCA45
	for <lists+linux-pm@lfdr.de>; Mon, 19 May 2025 23:49:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9380F1B68035
	for <lists+linux-pm@lfdr.de>; Mon, 19 May 2025 21:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 445214B1E73;
	Mon, 19 May 2025 21:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R/ishHMh"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053F71D61AA;
	Mon, 19 May 2025 21:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747691214; cv=none; b=SiVf5YpGEKVgBwTSc0hAdZhM7pHk5vSPURJDFXdCgmRR4TFU3QoluBsNS4fhAFAcAqwF9FHYZitcQ/UXJLwMSgY1eOOhaQcS+M3XGuRtKwfyYNr8qoD1KzOPmoXbp53Gr981G6REtf0mqGWb1rMqUFk0NGdPM2zdyb5I7iurKPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747691214; c=relaxed/simple;
	bh=ZkQPFGCfN/ytLLMuoMd9ferJS5QDlazCEthjWxV02ag=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sKO5CSVYvb64Q0wXUZBmiI/ZVY8+/6ebXEKmK2eznxpIEZUDdV61klCG6g72K/M+n3rrrsyd+FwIjTHxNpJWkmNbbyJSGbC3fNqmng5N+6o4lTZ7hiDBBNh/bAaJZcvB6t6v4BAhyvCWn+TK1/BS3oAGmXxHJs+Mspjzncf/TWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R/ishHMh; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3a35919fa8bso1851847f8f.0;
        Mon, 19 May 2025 14:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747691210; x=1748296010; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gmYkai44PKYL/6IygmKZDMZnIvRanA9GMqnax9LQufs=;
        b=R/ishHMhzhJkHwK/PTstOdAOXZayc42dQqmn4+Sdzjo+EjoB+YMnCLE8RnbGb4jGmm
         LlAyOtuKeCrE0Rmqsp6GmSCBzhugZIe7MPqAO56CbkoK4BHYXGSy9wkEtiVRnJ0SSiEE
         A26Xc5tHK/9eUKo/2Tl5/n7o7o8MBYntjyIcOoh6lAU5SOruRLVJLnEYTsivlT0KELNI
         AWPt83IC7nLz0E3EyerUdczBXbRKoFprG72l7ORpLqkNbsOoDmjvViAZunF8CUALh6QX
         f+33CkPOkN1AYj4w/Cy79YM1r1coFRBpehvb31oYtK44LEdEJwpKv5PFx0y3SuBtpWQ7
         qAUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747691210; x=1748296010;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gmYkai44PKYL/6IygmKZDMZnIvRanA9GMqnax9LQufs=;
        b=Dn+HQ7MjUcENxadcp8egnddBtYUIIx9DP6ndv2K+NGM04CNNSMxCPFPqBVp6XsXtOi
         R9V9xmQ30R4jEq31EOC3J2Q1UYhoK8BwawUj9tFJepubW9uIjPePGhUhBoPLexmbuNHu
         cpePPhH1j1xqFViAbNbb7uhJwS9yfX3ZBbqQZ17cPR+5R82GWvMf0OyLEDSUMqwjAzg1
         y08O0O0ciXb6C/0zphaA1lNk/32Z/QwCLOX1wbV6gV5DgvvkLxSfXhBIciddL5mdD+0X
         J059i89ZetklitLIECMtELHXXcqryWDGWpQIzkN1iofIM0YbMDgycRoFnp4BopgTKGLH
         Q2NQ==
X-Forwarded-Encrypted: i=1; AJvYcCU9sAAt/k1s6zm6MMuzfw726Mhla8mz8o+WfnvEwAFClDOwc0FF64CUN6V/A7rFN1M7BOdc3bHgkF8=@vger.kernel.org, AJvYcCUXpOEwK/QYR4iCOe4bztf2GzKZq8h6VJcHZnTbhE3VZkMOT+ilhIEFhvSznxajeRJobHF6BepNN5lRrGw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhlOJP5sneu1UsoqS9JgBfX0B6EFf29n2YG1sPtVU4Gwq4Zxsf
	bHdb2F1iVro0aDB9Xo/dV/kbnf1uEzn6Htx5JK0wj7cBUc26o6CXCktS
X-Gm-Gg: ASbGncvG1mHCnnj3yvQRtVz48J62w18/oWJLOTgit+kN5qUtRmuXw+ERR0kxVLdhD8I
	r7B5Exn2FwNynwvPTRjKuKvPdD8Mnj/1LcC70I0Evgu6Idpcva7v6JmHwTYTiDOERKAh3Fqxbyj
	cUMtXMb/NE2VR1suKgp90bYwATzr6VsMSWdumGYdciJPtyOT6o8KDYCBpWyoiaEU9hMkykaegeb
	zt9V91F/ACwLrDFU5zvgAaqrwlwUSzELl750gzZhuoOSrC4kpDoo78jlZkqFQ/4+wadwJATPayr
	b97oggH49e8UxncG3K+MCUJyZ+9palSqJB0OPJ90hkSXZ5XHmUT5NBhR0leKWfxX1AYpZxC/GSj
	JmNI4FuyLFW+NOw==
X-Google-Smtp-Source: AGHT+IEK2QOoJgfuFsxY1nWaqjk+wOUVezaxUh7UVvak1VzaWuH6MGuGhsZJfCS0udCyeNBHKN6yeg==
X-Received: by 2002:a05:6000:1862:b0:391:2e6a:30fe with SMTP id ffacd0b85a97d-3a35ffd2829mr12015008f8f.39.1747691210063;
        Mon, 19 May 2025 14:46:50 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a360b0b766sm13783592f8f.56.2025.05.19.14.46.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 14:46:49 -0700 (PDT)
Date: Mon, 19 May 2025 22:46:48 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Bowen Yu <yubowen8@huawei.com>
Cc: <rafael@kernel.org>, <viresh.kumar@linaro.org>,
 <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linuxarm@huawei.com>, <zhanjie9@hisilicon.com>,
 <jonathan.cameron@huawei.com>, <lihuisong@huawei.com>,
 <zhenglifeng1@huawei.com>, <cenxinghai@h-partners.com>
Subject: Re: [PATCH] cpufreq: Update sscanf() to kstrtouint()
Message-ID: <20250519224648.41f2460d@pumpkin>
In-Reply-To: <20250519070938.931396-1-yubowen8@huawei.com>
References: <20250519070938.931396-1-yubowen8@huawei.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 19 May 2025 15:09:38 +0800
Bowen Yu <yubowen8@huawei.com> wrote:

> In store_scaling_setspeed(), sscanf is still used to read to sysfs.
> Newer kstrtox provide more features including overflow protection,
> better errorhandling and allows for other systems of numeration. It
> is therefore better to update sscanf() to kstrtouint().

This is a UAPI change.
Since the value is a frequency there could easily be scripts
that append Hz to the value.
You're making them fail.

	David

> 
> Signed-off-by: Bowen Yu <yubowen8@huawei.com>
> ---
>  drivers/cpufreq/cpufreq.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index be727da0be4d..0c842edd1a76 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -920,9 +920,9 @@ static ssize_t store_scaling_setspeed(struct cpufreq_policy *policy,
>  	if (!policy->governor || !policy->governor->store_setspeed)
>  		return -EINVAL;
>  
> -	ret = sscanf(buf, "%u", &freq);
> -	if (ret != 1)
> -		return -EINVAL;
> +	ret = kstrtouint(buf, 0, &freq);
> +	if (ret)
> +		return ret;
>  
>  	policy->governor->store_setspeed(policy, freq);
>  


