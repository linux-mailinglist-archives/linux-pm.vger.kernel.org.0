Return-Path: <linux-pm+bounces-7987-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67AAB8C99E2
	for <lists+linux-pm@lfdr.de>; Mon, 20 May 2024 10:35:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9826E1C2081F
	for <lists+linux-pm@lfdr.de>; Mon, 20 May 2024 08:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDF9F1BDC3;
	Mon, 20 May 2024 08:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v2Hig+8O"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C36410A24
	for <linux-pm@vger.kernel.org>; Mon, 20 May 2024 08:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716194126; cv=none; b=S40zWvr7IC+LXjS386TxMSI7v0aUj8YJD6NfVv9D+dVXjarqT6wNPD3b+guGNcEG1aFKVpRL+aqolO+nrwG4aMO4w5szzoOVPKrpQzVQkOsyhAWnbCHe0D9wfE35tpKZ1Cu8I0bD8iUgJE/3t83i7Jx8QxTCw1BaFPyquXeJTBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716194126; c=relaxed/simple;
	bh=pGR1qWiXTUPecq4OqlA1IrsQxJzyWJZMvAO0kM1kkyw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YkASB0M6+Bnu3vn6Di0PMt42DknDjBFe3HSQZnHGxE5lQM2pXcSCzuRj/dLqTKqciAAwmJ0lXaXuJ5SiDjFlp7Dzr6jfHdmi8xQdjh9VhC+3PtaYwwUNGaYZCmvwrVAyyYyUAlFpo2Wh49Jj7SWOEGv5zoSHsJ++XSakSgI6Kgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=v2Hig+8O; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1ee0132a6f3so68241125ad.0
        for <linux-pm@vger.kernel.org>; Mon, 20 May 2024 01:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716194125; x=1716798925; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UIsBb+eRFu3c1CtI64mjHrwU2c/P6ra4rdQLN4GGHw4=;
        b=v2Hig+8Oka3aTkFb8CQk+n7ZPFyUzqPxAcAT4qppXy97L0MC36LLM43wVreQkNKIF3
         3+6STW1i2j5D6cOjObZ8MJ7DF8S06TNBGyEL6D6Mw7arjeJQGITTLdNtyBj9TG498QVl
         iZ4iWiNda7MCeRo4RsDNfaOxJmKlaD/LbIR3MMjUyAcwu/idP7Zuu+MPm/VUT2pfwsn+
         A9FRPsn3FlZYaeXNMiGvyo9RTL94BiQeMm44hdrKUBiaDpmS6WZVodb4NEL5wTZ4c/1x
         Nk1NMeuUFr3Ixgq57WAH8ocEUpveULOgUUi1EDtu2YIDNyU4JjKKoCW71tCyNsyTwYAZ
         dUmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716194125; x=1716798925;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UIsBb+eRFu3c1CtI64mjHrwU2c/P6ra4rdQLN4GGHw4=;
        b=CkKj1wffQ2bqtzcR5HcJAOPaveby8tGzNmqoPoaTaa/SgxN0NbFFzvJKUBqLOSfbbU
         crU1/QJJMvn//Fe1ielFn5+Tlw877Gl39JvscJGxUP9UrJXz+QMm1eK2bkHxEi95gepQ
         fUlJP0RhMGLXoeH6mwK3Q5FQRqRg0mCmiZocY/ycMHDk4GgdNMahfHMlVNIN6zghYFGZ
         VKMmDGTtVFb94qRzGM6XS3kBrRZK+CQd+bDZUS8NuH7/thTN9YXAr+buNy3n87wa7pam
         +jFAajB2L/dqWv2Vrp/Q93OAFqWPGvwuJ+5Y7RcLtQcKr/WUO8lN/Djs8Kw6w2TTVYUS
         rk+A==
X-Forwarded-Encrypted: i=1; AJvYcCUXzEiJrU4WPIWsfjT/QPmIF7BOvb0eUJpCMo6Jsu78PhPjXPalZ7DThmLDvqdxm8Px9oIoz63eMFPbii7Dg/0v8TPBIfYVY+o=
X-Gm-Message-State: AOJu0Yw9VjSY9CvHEu9Qs9XMkVQKeiAiNmxu2s2nVrzDTtuo1nevjHtR
	YuRzmzpAX7W1jfZuTUJvOlcKh2N4ZVnl2VmcjnBIpCRF/hZ7nYnT75gnXfbcjio=
X-Google-Smtp-Source: AGHT+IH7PSENgMsGNo62ZNvTY9oX8UT5YKyk73G2Rc3ZZ7+HceUfg79PFOiwl3cTGJZToyA+m90evw==
X-Received: by 2002:a05:6a20:c89c:b0:1af:fff4:6000 with SMTP id adf61e73a8af0-1affff460acmr23706598637.20.1716194124766;
        Mon, 20 May 2024 01:35:24 -0700 (PDT)
Received: from localhost ([122.172.82.13])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0c13692asm198417105ad.252.2024.05.20.01.35.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 01:35:24 -0700 (PDT)
Date: Mon, 20 May 2024 14:05:22 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Andre Przywara <andre.przywara@arm.com>
Cc: Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Yangtao Li <tiny.windzz@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] cpufreq: sun50i: replace of_node_put() with
 automatic cleanup handler
Message-ID: <20240520083522.vvga3aqjg4w3adkj@vireshk-i7>
References: <20240503-sun50i-cpufreq-nvmem-cleanup-v1-0-0a2352cac46b@gmail.com>
 <20240503-sun50i-cpufreq-nvmem-cleanup-v1-2-0a2352cac46b@gmail.com>
 <20240510184213.68f92cab@donnerap.manchester.arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240510184213.68f92cab@donnerap.manchester.arm.com>

On 10-05-24, 18:42, Andre Przywara wrote:
> On Fri, 03 May 2024 19:52:33 +0200
> Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:
> > Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> 
> Reviewed-by: Andre Przywara <andre.przywara@arm.com>
> 
> I haven't tested the error paths yet, but it certainly boots fine on an
> OrangePi Zero3.
> 
> > ---
> >  drivers/cpufreq/sun50i-cpufreq-nvmem.c | 25 ++++++++-----------------
> >  1 file changed, 8 insertions(+), 17 deletions(-)
> > 
> > diff --git a/drivers/cpufreq/sun50i-cpufreq-nvmem.c b/drivers/cpufreq/sun50i-cpufreq-nvmem.c
> > index ef83e4bf2639..eb47c193269c 100644
> > --- a/drivers/cpufreq/sun50i-cpufreq-nvmem.c
> > +++ b/drivers/cpufreq/sun50i-cpufreq-nvmem.c
> > @@ -131,14 +131,14 @@ static const struct of_device_id cpu_opp_match_list[] = {
> >  static bool dt_has_supported_hw(void)
> >  {
> >  	bool has_opp_supported_hw = false;
> > -	struct device_node *np;
> >  	struct device *cpu_dev;
> >  
> >  	cpu_dev = get_cpu_device(0);
> >  	if (!cpu_dev)
> >  		return false;
> >  
> > -	np = dev_pm_opp_of_get_opp_desc_node(cpu_dev);
> > +	struct device_node *np __free(device_node) =
> > +		dev_pm_opp_of_get_opp_desc_node(cpu_dev);

Won't that result in build warning, mixed code and definitions now ?


-- 
viresh

