Return-Path: <linux-pm+bounces-38599-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A67B3C856A8
	for <lists+linux-pm@lfdr.de>; Tue, 25 Nov 2025 15:27:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4F7524E721B
	for <lists+linux-pm@lfdr.de>; Tue, 25 Nov 2025 14:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F03732571F;
	Tue, 25 Nov 2025 14:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k/MmHj3a"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B5CA325708
	for <linux-pm@vger.kernel.org>; Tue, 25 Nov 2025 14:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764080832; cv=none; b=rAbR6WObKw/BTDcEf7eMvgDItsoU9jOXg/LJfQo9i9V63cSI6MyPjkVX6BT4HMljSm4zfiCxSIVUTAuK8FEr/bIX0hFEvfCNA9QIbZ9SXZtpUlpJ216KHiJbLmUsuVEgil50dmycn7RrC1S6Q9EY+wCNONk44tgSZNA70HwOqIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764080832; c=relaxed/simple;
	bh=1JMJfkBBhG+t8MUgIM9PXhaMbkiYOvUOMsqXgqotGsQ=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SzZiaYy9Ys5hzHLCityRe/tbzQbvZBmFEpYnWwT51szFuSjPsbOYHw4cWWqkqI4qyGJe5+/YPC4Y9V9FSKkH8dC0JqVtvQ2hLF1d9yjKvGM9ttblKuSgEpqA/w0caehXIFuy74wPF2pNsSZ6mnZZEhIXVX6WFZIEmGozqPXLjFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k/MmHj3a; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-42b379cd896so3094204f8f.3
        for <linux-pm@vger.kernel.org>; Tue, 25 Nov 2025 06:27:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764080827; x=1764685627; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=U5j4evZ1IL3IsXZZO8TZcDakLErkiExtx5jEOZlyoZM=;
        b=k/MmHj3auNXzDIHHtLDQwmpuJ9j1JMk5hZwt2R7p4Tq5ealPrFdBQjehD84jS0ihYq
         FaFYVt0fcXI6UZ4Sry1fyUmXN5Y23G34yeX5B9D8uvnaGT48kGYiTDM/cVERPiRWCGOR
         k1oTVAILxpngqAKb45e4LxHXdXGpN82AlEA4lzSeCffkKBtOoaW6QDODsNpSdYWBlz07
         UQClmqnXwcuGB6DEaer9Ftuzwt92MbeY0wpKYEIeLG9sP9FgEZbaVn89AojyRQoSg9Qh
         ydTwBXejzTqey4emCv5YzfpLYJk5Y9R5ytDmqrJXuSn6/s5zaUxd25hSGVJdEfS5yX+j
         aR9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764080827; x=1764685627;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U5j4evZ1IL3IsXZZO8TZcDakLErkiExtx5jEOZlyoZM=;
        b=aHZZR7VcjJhPXsZellSANRbZeBIQ0brVhR6vaFxqq7b6VPjjw04eqWa3z2fmqHMa55
         2fRUfEdXIUwemWssVH5Os0ZDxYzP2Sv0sJRIgRt6xzpLgowhtgmsVBV8eRJ9HfGt37DS
         9uCGAizetTt1fnZBB2fs9ELttmXzj4ZCtlBXw/8LkDaDsUEjwrFFLYDUnz/IXo2CHY2R
         dRyXnF9o9Qcqa2wfnORnXXhD9yqIYz7O1ZbmVW7xpw7Qle5C9op66cBmyaltHUjYZTEG
         R3pwdQOJT2fP/FY0sHDn+w9M7HpeQskI0qmQZTrXClXrbpzrJhNmDmyQMxWdk1u6+8Lb
         hgoQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/tiGnb6QZrlqlvVZVAxlVntvGGa+dXU+rRscEUmyHb3zU4/YEF3+G87k9IqUNkRkuobL0ZVyzvw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwZxf9CR89bKxGrECJZFbBv+bMWmLa37uI7d+NAoJJxxRI3UXi3
	9djaAvgxWdNuyoWk8fpyCxT3H4Aey2ZeJVaC61ihL6DQWc6MTIZ9ILZMEyvH3A==
X-Gm-Gg: ASbGncs6rrLOWKVMMK2aI8ci9ms+OgINQ078VDAltT5nC2Y0/avSEjMRkqAKBJb9Vnl
	HZCdg3vZ1KNYRMVuCfQACre0fXuPfiufCMq/23IjEdGUQMMw2okobJLs/QES4z/+yndE+RcT15z
	iwbW9WDmNrJynBLewKOOgWya6PccAkII3HhcwUrhYEdTcdUuMjR0MEJI6V2wTVSVwHpsJfPg25W
	EHtWvQwpJlgnP6K3M6X6dBjYV32mCfZKDjezXnqy1FpohQmhxYIpRTX4AAlvP/mDgiLb9Uv8CCg
	/zyNOKjW1jS7nmlnWJPEjhcOC87uQ+DGOPjXG8nLFahAPMXcfEjn8ruABKr+rxuI3WrfZWxjAQ4
	79tgXBwUNDnxSx1FY5I1Fgx1br1MxdfwUv1c5xRsL84CFfkEuleufPAHtTUzIqZwqTH/MbPsG2u
	XSKuuS3N+YmXqJmB3MzxwKQoyN
X-Google-Smtp-Source: AGHT+IHvuQUfPvDdiGxUCavncDHFdm/57aDV7lAJuFupVjzIP2m2WqLeNn06EjGTaov/1bccbWvrAA==
X-Received: by 2002:a5d:5888:0:b0:42b:3b55:8908 with SMTP id ffacd0b85a97d-42cc1d22c70mr15977277f8f.51.1764080826902;
        Tue, 25 Nov 2025 06:27:06 -0800 (PST)
Received: from Ansuel-XPS. (93-34-90-37.ip49.fastwebnet.it. [93.34.90.37])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7fa7affsm34792088f8f.23.2025.11.25.06.27.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 06:27:06 -0800 (PST)
Message-ID: <6925bcba.df0a0220.925a7.ca27@mx.google.com>
X-Google-Original-Message-ID: <aSW8tm7Z0P6sKLHU@Ansuel-XPS.>
Date: Tue, 25 Nov 2025 15:27:02 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: david laight <david.laight@runbox.com>
Cc: rafael@kernel.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: thermal/drivers/airoha: Fix low trip temperature setting
References: <20251122220747.70c51d9d@pumpkin>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251122220747.70c51d9d@pumpkin>

On Sat, Nov 22, 2025 at 10:07:47PM +0000, david laight wrote:
> There is a 'cut&paste' error in the code that sets the 'low' limit.
> The clamp() calls contains 'high' instead of 'low'.
> 
> While FEILD_MAX() ought to be (and probably is) a compile-time constant.
> it isn't constant enough for the range check I'm adding to clamp_t().
> Additionally (and probably accidentally) it has a 64bit unsigned type
> which propagates through RAW_TO_TEMP() causing a 'signedness error'.
> Hit it at the root cause with an (int) cast of FIELD_MAX().
> (Alternatively arrange for RAW_TO_TEMP() to always return a signed value.)
>

Sorry but I'm not very convinced by this section.

clamp_t in theory cast everything to the requested type. FIELD_MAX will
correctly result in the max value for the register and then RAW_TO_TEMP
should convert the value to a temp and be an int.

If it wasn't the case it should have been a BUILD_BUG error.

Am I missing something?

> Fixes: 42de37f40e1b ("thermal/drivers: Add support for Airoha EN7581 thermal sensor")
> 
> Signed-off by: David Laight <david.laight.linux@gmail.com>
> 
> ---
> This is a diff because I've not even contemplated committing the nearly 500
> files I changed.
> 
> diff --git a/drivers/thermal/airoha_thermal.c b/drivers/thermal/airoha_thermal.c
> index b9fd6bfc88e5..75afc94fea5f 100644
> --- a/drivers/thermal/airoha_thermal.c
> +++ b/drivers/thermal/airoha_thermal.c
> @@ -261,8 +261,8 @@ static int airoha_thermal_set_trips(struct thermal_zone_device *tz, int low,
>  
>  	if (high != INT_MAX) {
>  		/* Validate high and clamp it a supported value */
> -		high = clamp_t(int, high, RAW_TO_TEMP(priv, 0),
> -			       RAW_TO_TEMP(priv, FIELD_MAX(EN7581_DOUT_TADC_MASK)));
> +		high = clamp(high, RAW_TO_TEMP(priv, 0),
> +			       RAW_TO_TEMP(priv, (int)FIELD_MAX(EN7581_DOUT_TADC_MASK)));
>  
>  		/* We offset the high temp of 1°C to trigger correct event */
>  		writel(TEMP_TO_RAW(priv, high) >> 4,
> @@ -273,8 +273,8 @@ static int airoha_thermal_set_trips(struct thermal_zone_device *tz, int low,
>  
>  	if (low != -INT_MAX) {
>  		/* Validate low and clamp it to a supported value */
> -		low = clamp_t(int, high, RAW_TO_TEMP(priv, 0),
> -			      RAW_TO_TEMP(priv, FIELD_MAX(EN7581_DOUT_TADC_MASK)));
> +		low = clamp(low, RAW_TO_TEMP(priv, 0),
> +			      RAW_TO_TEMP(priv, (int)FIELD_MAX(EN7581_DOUT_TADC_MASK)));
>  
>  		/* We offset the low temp of 1°C to trigger correct event */
>  		writel(TEMP_TO_RAW(priv, low) >> 4,
> 

-- 
	Ansuel

