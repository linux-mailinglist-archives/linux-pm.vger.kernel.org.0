Return-Path: <linux-pm+bounces-10016-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11E10917847
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2024 07:47:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40C15B22CDD
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2024 05:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5406146585;
	Wed, 26 Jun 2024 05:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OyzDk1UP"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D848565E
	for <linux-pm@vger.kernel.org>; Wed, 26 Jun 2024 05:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719380829; cv=none; b=MogVKO7e7Z5PAsQLWrFcCbPs+ynBdQfRT97Uad1PFokZbB19rYqe1DPR3t5sOSXeXmXkc2b6ABrWscNuAfDQaBl53DavZArVvTkxCkf19f0BV7kv/Fy57bVg3j7z0ZgEbO/XkkuR2nsraKYSaufgny2LQ0q4pUslJ8mGcoWTudc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719380829; c=relaxed/simple;
	bh=GjLOELpmiccVwzecOSbZTD5nzCHnm/PYCJ7Fl8I+nec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DdKKVo+7AI52EAyAqor0wdhOAr2NXL+1ndl8vNSsmglZ7jyQmF34gYCzixjGrGDmH8/tlwKYxZDxgicpDrFywK1J8SgUtVKqUrw9d1omeLlOrVNp0jHnbGBKBAqJ+IBloPXdcXKqTF4DSdbpbKXXXfhrA+HwoByS1jFGP2OkLts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OyzDk1UP; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1fa55dbf2e7so20597295ad.2
        for <linux-pm@vger.kernel.org>; Tue, 25 Jun 2024 22:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719380827; x=1719985627; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VGbCOLfGf5G5R0Gqywufybmht3aiBsjc/asVfFAxRO4=;
        b=OyzDk1UPlNCBw+iRpBbRFLlAxbi1BPu2+DXkD14HFdNQiNSvc11+b7oEXdxEjEdinH
         o5kVnSsvL5seo3yiDHrMLFanIGCRCXP/AkJwfsJUiFDzFeNZBopmeznf2+Rz6LkCsVaS
         UIkwWozNyuGtXxCqoV2J1FMb9Y04j5B7pKLl0Wd8qKd8WheCv0ocZCdFg7k7AF9wTygm
         qM5m7VqEsxGkr+Q5+C/2aMvSGDYTl1nlEMjgrtsXR6n6gYZO5U/jQVmQudFYTzlbRoRp
         ybMOtUVgEwubsb0uvi0AvSvVnkW7kywQpHS+PfheKzgRGQIrEgmF0G4rVG52YMdzUReu
         lo6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719380827; x=1719985627;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VGbCOLfGf5G5R0Gqywufybmht3aiBsjc/asVfFAxRO4=;
        b=AVW7kpfuFdOYI3QJUc4M/+fIVv3NNdX5Em7A5GDtlwcoYz/x8ZLJUQ/2Hsr6d5tjG2
         NIftCYkN1X6ZpW6KbzHr2uH+mqqBI5UI2heaJlbEwwYf4Jwp5bz/IDkvnAqsT2IdeGeW
         1mU1ZaAKc6bj4GZYq0PPnPPQ/9ZdFkj97MaGlnQJqAPs2Yq2w8C8QhD25kgHwHzruBr2
         I+S1lhhZq0X351RIRV6ZOTBiBbk3CPzgjMnH5rXj1Iapuwl1YJeRxipRWvKB6nncT80k
         vfZM42thJEoQeoeByDHHkWK+iuxfhcS0BpUMk62u2gj0V5oWulgbGKAuJ0c2V1aqRRjl
         H2Zg==
X-Forwarded-Encrypted: i=1; AJvYcCWOYyk/5bpq24xjkJ5qFiDSmCKZgl+5I4svd4j93UGejd/5TMnPO6uBM7J/tkVFxw0W28V/ZdXzrFkCOEzGAXMJ3fwCQW7BXCI=
X-Gm-Message-State: AOJu0Yz/rTfA/4B3qPet+w8Z4hdaaTnnVSjwN0yC9OkIFvmNWtvmMAou
	UKlw91pL4enEnMOs4E/y8ephbcwBXemtE5JjGcGEfPyZRzaimvtL5b3WjiGOR20=
X-Google-Smtp-Source: AGHT+IHV/WWx7Uys+drZxQOvOENlnOZrmogqtv7AVUv7W0awSUJ64Zoku+40EReCsGFNpHg1KY9HYQ==
X-Received: by 2002:a17:90a:6007:b0:2c8:5de8:c85f with SMTP id 98e67ed59e1d1-2c85de8c954mr8129754a91.8.1719380827440;
        Tue, 25 Jun 2024 22:47:07 -0700 (PDT)
Received: from localhost ([122.172.82.13])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c8d807ed63sm687018a91.46.2024.06.25.22.47.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 22:47:06 -0700 (PDT)
Date: Wed, 26 Jun 2024 11:17:04 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Nikunj Kela <nkela@quicinc.com>,
	Prasad Sodagudi <psodagud@quicinc.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>, linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/7] OPP: Drop a redundant in-parameter to
 _set_opp_level()
Message-ID: <20240626054704.u23vx7wlldkdrlkn@vireshk-i7>
References: <20240619140849.368580-1-ulf.hansson@linaro.org>
 <20240619140849.368580-3-ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240619140849.368580-3-ulf.hansson@linaro.org>

On 19-06-24, 16:08, Ulf Hansson wrote:
> The in-parameter "opp_table" isn't needed by _set_opp_level(). Let's
> therefore drop it.
> 
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/opp/core.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)

Applied. Thanks.

-- 
viresh

