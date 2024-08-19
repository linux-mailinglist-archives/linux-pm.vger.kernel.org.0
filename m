Return-Path: <linux-pm+bounces-12429-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13959956C2D
	for <lists+linux-pm@lfdr.de>; Mon, 19 Aug 2024 15:34:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38B451C22BC5
	for <lists+linux-pm@lfdr.de>; Mon, 19 Aug 2024 13:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC71916C44A;
	Mon, 19 Aug 2024 13:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UiwzHSHz"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1221816D4D8;
	Mon, 19 Aug 2024 13:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724074390; cv=none; b=IdKj8c7wDfHG7l6GjLRyBAiNTVAH6NjQ7HaI4TX9D726BhWJJPbU5bDKsmDRe9jMO7AJKg05qXoSl4/+qLACD1ofjrlVYgfKgPklW8PqbtdD5WKQUBKDVWftQwuxZklR8BJ/x84ezeqt4u1uADbzNVcDNMGUl8fJ7idgoR6z2/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724074390; c=relaxed/simple;
	bh=qvGX+ulqTOixz3MeyrqvHy7bTy1mID4m/xJTeYKQM4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NMSX7ZnpYmRqtZoEBu8cH0NETa+XAHnIXrwH/i29XuoDHPZWf8IHPjK28kLs2hcyzn6lUmCBZN+1UVcLwBOz/42DwJvhzJU7Jh/wnbVelYDhzOKw+OADMdGpIfQ60wxb/PYmq2pTckbLdo2HZgU6dyfDNh6q8m+zC23fiA6/eus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UiwzHSHz; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724074389; x=1755610389;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qvGX+ulqTOixz3MeyrqvHy7bTy1mID4m/xJTeYKQM4Y=;
  b=UiwzHSHz4CW77ANDe1tgw1H0fCGPcYhxE5ZtV4MWSlAy1IDO5xxKxvGA
   ke2++A/mLJYVm3OHL01ymz0K3Kz7cvrWtXVqs9KQduOnQWky7PJDUM5S7
   LmDw4fgkRsvy8OGOsdPq7H88ktkuk6WTE4z+0nRs8r76wCPXapJwqvLcL
   C5UVZPW4U3ro8DNxOWk2by4nwsnkkltFst8iTdCObfTZ+SSNYzU0ce2RX
   kH7aQFTpMkW4BOnGHI7xaa69Cap9Tok5SxEQaedJbcvkLd8+t0SR17MgR
   5JSsC3LnQRvckRSqu6tPDaVdnc/yDewez5QDQn2/3W5v9QMdYR5IBicYy
   w==;
X-CSE-ConnectionGUID: PJCn1mcTRmyzZBCDqdbvnQ==
X-CSE-MsgGUID: Weoy/X+YRMOTuhxuc+U+Ug==
X-IronPort-AV: E=McAfee;i="6700,10204,11169"; a="26189316"
X-IronPort-AV: E=Sophos;i="6.10,159,1719903600"; 
   d="scan'208";a="26189316"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2024 06:33:08 -0700
X-CSE-ConnectionGUID: jJnY3/6ZSo+akgu+1nAh/g==
X-CSE-MsgGUID: e5Hkpd3QTFCvB4f9CprT9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,159,1719903600"; 
   d="scan'208";a="60950908"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by orviesa007.jf.intel.com with SMTP; 19 Aug 2024 06:33:03 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 19 Aug 2024 16:33:02 +0300
Date: Mon, 19 Aug 2024 16:33:02 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Bjorn Andersson <quic_bjorande@quicinc.com>
Cc: Sebastian Reichel <sre@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Johan Hovold <johan+linaro@kernel.org>,
	Chris Lew <quic_clew@quicinc.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Stephen Boyd <swboyd@chromium.org>,
	Amit Pundir <amit.pundir@linaro.org>, linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 3/3] soc: qcom: pmic_glink: Actually communicate with
 remote goes down
Message-ID: <ZsNJju43JyChNoMd@kuha.fi.intel.com>
References: <20240818-pmic-glink-v6-11-races-v1-0-f87c577e0bc9@quicinc.com>
 <20240818-pmic-glink-v6-11-races-v1-3-f87c577e0bc9@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240818-pmic-glink-v6-11-races-v1-3-f87c577e0bc9@quicinc.com>

On Sun, Aug 18, 2024 at 04:17:39PM -0700, Bjorn Andersson wrote:
> When the pmic_glink state is UP and we either receive a protection-
> domain (PD) notifcation indicating that the PD is going down, or that
> the whole remoteproc is going down, it's expected that the pmic_glink
> client instances are notified that their function has gone DOWN.
> 
> This is not what the code does, which results in the client state either
> not updating, or being wrong in many cases. So let's fix the conditions.
> 
> Fixes: 58ef4ece1e41 ("soc: qcom: pmic_glink: Introduce base PMIC GLINK driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/soc/qcom/pmic_glink.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/qcom/pmic_glink.c b/drivers/soc/qcom/pmic_glink.c
> index e4747f1d3da5..cb202a37e8ab 100644
> --- a/drivers/soc/qcom/pmic_glink.c
> +++ b/drivers/soc/qcom/pmic_glink.c
> @@ -191,7 +191,7 @@ static void pmic_glink_state_notify_clients(struct pmic_glink *pg)
>  		if (pg->pdr_state == SERVREG_SERVICE_STATE_UP && pg->ept)
>  			new_state = SERVREG_SERVICE_STATE_UP;
>  	} else {
> -		if (pg->pdr_state == SERVREG_SERVICE_STATE_UP && pg->ept)
> +		if (pg->pdr_state == SERVREG_SERVICE_STATE_DOWN || !pg->ept)
>  			new_state = SERVREG_SERVICE_STATE_DOWN;
>  	}
>  
> 

-- 
heikki

