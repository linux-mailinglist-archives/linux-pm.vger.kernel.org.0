Return-Path: <linux-pm+bounces-19728-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AB949FB92A
	for <lists+linux-pm@lfdr.de>; Tue, 24 Dec 2024 05:20:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77FA77A1D69
	for <lists+linux-pm@lfdr.de>; Tue, 24 Dec 2024 04:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F18D12C499;
	Tue, 24 Dec 2024 04:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ztU8famT"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A884437A
	for <linux-pm@vger.kernel.org>; Tue, 24 Dec 2024 04:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735013994; cv=none; b=KHzl1J2Or48WSlZpBBFj/Nh1hKfxXoDPum2Aom6xU6YO3TQkrZ7PGK1zxfTcB8Gtk9gIIytyyPqUTR3hiUxKjpZd5iXjMdf5LVzx0RolOG4mnH35x84J4jWRn9g+bVW8kF8Z1z+bJy4qUBPcT3p+m+jc595C1cQrL12RqGHLPW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735013994; c=relaxed/simple;
	bh=/quy8tTr2h42T3RwdmQuWgwqykGwFTSxMQBBGKlyrWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J8qSWrF6CgZ9tRDUP0fnseWMl2A2vpUJnoUxVKQT+zeN1w9OuFDeH+8wVp6Kh4HhGIbloAvwiXnwr1yuG8SP7g6Esg393TQsSQRtua3Qzk5wmsHtvD9mVrmabTXMUJI8Wk5C6bq+i50w5K5oMHGNML9tThSA75dNAW1Y8n7Bd7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ztU8famT; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-216395e151bso33506935ad.0
        for <linux-pm@vger.kernel.org>; Mon, 23 Dec 2024 20:19:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1735013992; x=1735618792; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jOI9pQuxkF5ADCxpeB0oRXSyPI8jyNgvjWCCXMA1spI=;
        b=ztU8famTlTsklTKI9bhEjiW2zjwr97G8uXS4Bm2SLBX6cYJmOeKmsLhuxyqUdOwKQn
         OQvE4J6wKRaqivykQ13LcCav0qnAro+NbLsxjG8wJzdX8XuOBphlDjm25IXM5btHHVuG
         o5/K5YoTTpvJzYlwKMNwhFhg5SddJLGTzmQk0VemZeFTrIL0VZGcGyjG6T4cGYsvHyCJ
         ZnezbahE9LcKKGqXS2s9jZWU5FSLDHo35LtzS86TKPdwuq8Qd9BvatnEWOIAKLXR49pg
         oE3J3q6zmtYfwIa/qi+1+g+ET1U6pJB+DisPoPnrBX6qGw55BZ0X2CAUUcxIwNu/U0Zk
         jHJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735013992; x=1735618792;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jOI9pQuxkF5ADCxpeB0oRXSyPI8jyNgvjWCCXMA1spI=;
        b=cQ/oS85ZIeHRkp//nyX5r7LaZd52AySEvDDsRqtre5Xz+Q4o2rrI+PHxqgHNN/3Qhl
         H7rSznQxCx9wi7vq2jTRF6in6RSuBmLoEJko7XWea6+3aMs0kGaZcO+NO0ezAsxK203Z
         xdoHPfm39DF5hEo/iWBPw17AnGOVsoO45fA5TbRuU9DRONokFix8UsZ1Z4y0YCQSfvn7
         8/OShA7/D76rS7+Cs+ew4Is0OT7gJuJKGHtM/Ucyd+VgxOQ/kCslH6EvqkTaBWsnEX7A
         ikTNccj3XejcI1q32dZDh9iiQsNxb/uiFhHUjchGV/J+hZ2n06o9TOv1fQv0/xcreYoc
         9D2g==
X-Forwarded-Encrypted: i=1; AJvYcCXOTebdGsgE7a2tBX0hgr77DeJ/2uYi5eb2rqAVlWJej4Cv4uunOS3OB0Jjfm0ALSq9467/BGFs1w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3Zub8nHYLqf1BQUCiqLm7/90ZIoKGxB/RdcVuj5TqNa+CIoHf
	p4+6rSYT/mb3UZdJfa6JNaPl2ZXDO1fu08FNlaGw6MbcGs6OFowpLsgQDeYMu/AISnuheWX1+KK
	Q
X-Gm-Gg: ASbGncsbCBRO3l1G/EK0QESwmQ7yhZAKXYxhHbrx4qHlsBY3URFGEytbjgHmuSpDPFY
	QAf/pGAGJtwrqQvSXov5AFuSrRdyv2QxMyDNXo0p2Tx/Jy24ic05J1qzvRnB9JXD3GCEWIgtiG/
	91xq5hwSk3MCyJLUjkePND0fvigBt/0AXYdaRTUKsEDQeNtRO6fHUfv7i34KQMduqnM6W+6DSHD
	tjTN3Zo9HZJBQ6nKXBBM53fcJdplOC3tRNbo4STKMhI41E2YwJkfiraD1A=
X-Google-Smtp-Source: AGHT+IF/A54go9F4QTm02Cgzh0BpPrFD77aKAPA/1tGBhsVFnFJs6RELYVBExn0EXuJAO7qMB5zf7Q==
X-Received: by 2002:a17:902:da8a:b0:216:11cf:790 with SMTP id d9443c01a7336-219da5f0a54mr282804935ad.16.1735013992173;
        Mon, 23 Dec 2024 20:19:52 -0800 (PST)
Received: from localhost ([122.172.84.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc9f72b8sm81176685ad.191.2024.12.23.20.19.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Dec 2024 20:19:51 -0800 (PST)
Date: Tue, 24 Dec 2024 09:49:49 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Ethan Carter Edwards <ethan@ethancedwards.com>
Cc: "rafael@kernel.org" <rafael@kernel.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cpufreq: sparc: change kzalloc to kcalloc
Message-ID: <20241224041949.ewmo3f5beyuoilsv@vireshk-i7>
References: <e3fXwH1TSclUunsB_ocTKA411JNgc8KozFJo9rGansdyTkxV-f6sj-TrJWBKXNs-DdlQTF-YEWRl_UcFQ_kQUCCEMsUUgnYQjiFrvWMrtYs=@ethancedwards.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e3fXwH1TSclUunsB_ocTKA411JNgc8KozFJo9rGansdyTkxV-f6sj-TrJWBKXNs-DdlQTF-YEWRl_UcFQ_kQUCCEMsUUgnYQjiFrvWMrtYs=@ethancedwards.com>

On 23-12-24, 14:41, Ethan Carter Edwards wrote:
> Refactor to use kcalloc instead of kzalloc when multiplying
> allocation size by count. This refactor prevents unintentional
> memory overflows. Discovered by checkpatch.pl.
> 
> Signed-off-by: Ethan Carter Edwards <ethan@ethancedwards.com>
> ---
>  drivers/cpufreq/sparc-us2e-cpufreq.c | 2 +-
>  drivers/cpufreq/sparc-us3-cpufreq.c  | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/sparc-us2e-cpufreq.c b/drivers/cpufreq/sparc-us2e-cpufreq.c
> index 8a0cd5312a59..15899dd77c08 100644
> --- a/drivers/cpufreq/sparc-us2e-cpufreq.c
> +++ b/drivers/cpufreq/sparc-us2e-cpufreq.c
> @@ -323,7 +323,7 @@ static int __init us2e_freq_init(void)
>  	impl  = ((ver >> 32) & 0xffff);
>  
>  	if (manuf == 0x17 && impl == 0x13) {
> -		us2e_freq_table = kzalloc(NR_CPUS * sizeof(*us2e_freq_table),
> +		us2e_freq_table = kcalloc(NR_CPUS, sizeof(*us2e_freq_table),
>  					 GFP_KERNEL);
>  		if (!us2e_freq_table)
>  			return -ENOMEM;
> diff --git a/drivers/cpufreq/sparc-us3-cpufreq.c b/drivers/cpufreq/sparc-us3-cpufreq.c
> index b50f9d13e6d2..de50a2f3b124 100644
> --- a/drivers/cpufreq/sparc-us3-cpufreq.c
> +++ b/drivers/cpufreq/sparc-us3-cpufreq.c
> @@ -171,7 +171,7 @@ static int __init us3_freq_init(void)
>  	    impl == CHEETAH_PLUS_IMPL ||
>  	    impl == JAGUAR_IMPL ||
>  	    impl == PANTHER_IMPL)) {
> -		us3_freq_table = kzalloc(NR_CPUS * sizeof(*us3_freq_table),
> +		us3_freq_table = kcalloc(NR_CPUS, sizeof(*us3_freq_table),
>  					GFP_KERNEL);
>  		if (!us3_freq_table)
>  			return -ENOMEM;

Applied. Thanks.

Though I failed to apply it directly using git/b4 for some reason, had
to manually make the updates and commit.

-- 
viresh

