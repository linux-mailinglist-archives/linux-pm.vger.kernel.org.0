Return-Path: <linux-pm+bounces-9862-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA9DD91420D
	for <lists+linux-pm@lfdr.de>; Mon, 24 Jun 2024 07:35:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EB0B1F248FD
	for <lists+linux-pm@lfdr.de>; Mon, 24 Jun 2024 05:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F0D118042;
	Mon, 24 Jun 2024 05:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o+QOUivS"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5081F17BCE
	for <linux-pm@vger.kernel.org>; Mon, 24 Jun 2024 05:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719207296; cv=none; b=AmCMJXfIpKdy3NPkRPpGeOzc8xvioIewPy6le5bKiuUscGAz/ioJ5/z8LTpUNo+HRSSyXSLChKPZA8Ld6WM9ed71UKWfqV32tUVI911Nh5b+6o0uJvstL4dcFsJZ1MFgxGNqofSNu4OxD76oFeO//XOP5pnaDgu8HD+3oL9OHHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719207296; c=relaxed/simple;
	bh=c4qhto/s0OdNLY9J1rt4EUXvriPgx343wWEsZ88Bdyw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d73y48Xj+ArcrQ9Gs6lNFdnY0kwb2rsnsHQW+mdcvnN9wUhElmuxRPAdR4XBTy1edhEZDcNp25o2dWT7cplUG9IwptVpqv396VyVnlz/l+1qvqCxd69By/ITeUUnOS0zwpuoRvfPgOeIpG9s6c0qmz5VEVtwXyrRttWIQXDum6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=o+QOUivS; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2ebe40673d8so44389561fa.3
        for <linux-pm@vger.kernel.org>; Sun, 23 Jun 2024 22:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719207292; x=1719812092; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=597F8StL/WJzwtlklD4026dqqrH/+l0r6AFwKiLnjjc=;
        b=o+QOUivSovUIGb7fo1QSx0Io02uZeKqaheBUN9cK1HMKvg0E5hol95jvY6Sy6t49Ul
         XbYdn0yNpTUYaoBZAurOEPwtdUrRfHguxwZRz904ZQ4gowqlKuLd3CSa+IqLIMf1wDng
         GL/QKAaC3tMR0sWX3btOrnnJXXrjq61WCTe/G8wCd1x0+MVtZ2v/jXXB1BN4u7zEfX75
         GGFCGN9ep7MPkGNx0wAjdmLRZexN0oTy8Uj1dQiYAJiSSxc3HkCvA3aBsP11z74WCjA9
         3HIoHZopc5zI9n39jfpF3ozGhD3USB/Qt8FRFUyfeC7iysGoOMyeBHhzp6uT30OlHepO
         KJ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719207292; x=1719812092;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=597F8StL/WJzwtlklD4026dqqrH/+l0r6AFwKiLnjjc=;
        b=fn3f6W0dkQ4R4gm25EHfjZRuXNAkZFuTMLdvAOFSHjnCTPx1mFrl/pXD9FW5BD4TSu
         bml0sCxwfF5NgRPdSJn6/bvRfglC1gKoHzA9DAf+eVFSwbmGfQkyaYatcSzzEu9YjWYt
         /wNIPfReoPA3vso7juEbMpqCTedsus/+Q7w52DxIEK207ZTeH1m9/4lqCoGQVBkr3E5s
         aRdWoC6G3+4jd67SBJ/kdvqWRHjAmr2/4XWb9ns/BqEZVU8ikUu/yETdh9pD/8JighIJ
         OQHgsJupzgbNe0KFBe9/3q9bEPT5wbbvSqK+QvsrzCKLRpt4lQDSIhjec0dkbrrP4WYw
         Q12A==
X-Forwarded-Encrypted: i=1; AJvYcCVq+GBW4YoOhyaAKtLavfWxsJ4aKWI3CdWVT4Bs/dFKoDsBT5o0pm8ZuccT5tBk0b/kRoBD1S3vWvleooUd3/j7J8aXamb2pTM=
X-Gm-Message-State: AOJu0YyX3WE6DAfQKnhT1rfSKjaURLZYDyjrjyezdF597CgcTRUOe61s
	pEv/19bG273R2PX55KI6XOOvr3aPDIIA0F7f9t6pwPoPu8cqbgZWQYsZwxOsESQ=
X-Google-Smtp-Source: AGHT+IFGlNTPxkgHedK9wRG18wo6RMMt1Fe9/ddWFIoExxdLbUMR1WIHZQpU0EdbscRjwTfmjY17zQ==
X-Received: by 2002:a2e:87d9:0:b0:2ec:5467:dcb6 with SMTP id 38308e7fff4ca-2ec5b39c57bmr20962951fa.52.1719207292470;
        Sun, 23 Jun 2024 22:34:52 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ec4d60133csm9066621fa.15.2024.06.23.22.34.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jun 2024 22:34:52 -0700 (PDT)
Date: Mon, 24 Jun 2024 08:34:50 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Varadarajan Narayanan <quic_varada@quicinc.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	angelogioacchino.delregno@collabora.com, andersson@kernel.org, konrad.dybcio@linaro.org, 
	mturquette@baylibre.com, sboyd@kernel.org, ulf.hansson@linaro.org, quic_sibis@quicinc.com, 
	abel.vesa@linaro.org, otto.pflueger@abscue.de, quic_rohiagar@quicinc.com, 
	luca@z3ntu.xyz, quic_ipkumar@quicinc.com, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 3/7] pmdomain: qcom: rpmpd: Add IPQ9574 power domains
Message-ID: <f4w5hvhgyniecab2rhy4s5nd7ktraf2jk2ebnp6najqq25tsuy@3lqd6p4hsmij>
References: <20240624050254.2942959-1-quic_varada@quicinc.com>
 <20240624050254.2942959-4-quic_varada@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240624050254.2942959-4-quic_varada@quicinc.com>

On Mon, Jun 24, 2024 at 10:32:50AM GMT, Varadarajan Narayanan wrote:
> Add the APC power domain definitions used in IPQ9574.
> 
> Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>

Given that Praveenkumar was the original author, why isn't that
reflected using the From: header?

Please review your process and keep the original authorship properly
attributed.

> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---
> v2: Fix Signed-off-by order
> ---
>  drivers/pmdomain/qcom/rpmpd.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 


-- 
With best wishes
Dmitry

