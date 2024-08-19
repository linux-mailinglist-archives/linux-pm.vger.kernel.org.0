Return-Path: <linux-pm+bounces-12427-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D094956C19
	for <lists+linux-pm@lfdr.de>; Mon, 19 Aug 2024 15:32:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 511D51C225A1
	for <lists+linux-pm@lfdr.de>; Mon, 19 Aug 2024 13:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30F8916C846;
	Mon, 19 Aug 2024 13:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e6C9r52j"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A7BF16C6B0;
	Mon, 19 Aug 2024 13:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724074084; cv=none; b=TAxcbImtI6xzKJ33suUq9TVqLK8CWx0UBvz5GMuuzIgnpMYzsByn6np9Grav3TuGvyv6MZ08qT7APGUIQc2ytrjiBT0xGNJZKsolqSHz1pouoQmzLGcvVoWYsg5K8/75CNns1iyytKffdyiRF52zIh7l9BowKYWmuvxEgx4I86I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724074084; c=relaxed/simple;
	bh=zk60qwCpwoyAMlYOMZRUAKQf+lxHInyJ2uctVdPTy30=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EQorvR5DTdypl9NWNLDO5PGPJt3eNrTeFpNcO6CBClkCvQXsJGHQWqCE47BMTlq6MsPDIf6HHb35f/0GGRp6LHiXeNCHkUnUaAIW+sBCheTrhQs0MyAgmuF3NPivWO3HYbfSEonf3+6IutaDsAMlHYah8fcBjMeX5zVFMP3lQYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e6C9r52j; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724074082; x=1755610082;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zk60qwCpwoyAMlYOMZRUAKQf+lxHInyJ2uctVdPTy30=;
  b=e6C9r52jyvLncuvRfn+jc0vbNm9Fg9lyoQJk/T6goN2/7VsGa2XY0I+F
   /BmzRrLSIMXHExmrshvoOLO6v0qrVYWjVbIs8q4A9jJzSPQr0IaDCMvDj
   BLaXLSUa4tl9L/AZfzNQeZuQWIhH6MQaU0jJl/NMmJgYAjD937QiUEfAm
   7DIQVYbnGwdOpP0WVgCvzA0THALr7APhm6o4UH081R2OHcrB3LJ8UjJVu
   ccNJjf2+1D1dOpgiXMcpx3cHlaieYnStR1AokRUBJIcSd0Q8A7gcP5isg
   KRdjSvfql5hPan1UBEqXn/0Zw4SUilhcS17cXscnfq/gjPG/nY6RKNjyC
   A==;
X-CSE-ConnectionGUID: bEo6rmKFQbKfXQoyL4jgjw==
X-CSE-MsgGUID: y8nWWc47SZiHsvEeggDarg==
X-IronPort-AV: E=McAfee;i="6700,10204,11169"; a="21866901"
X-IronPort-AV: E=Sophos;i="6.10,159,1719903600"; 
   d="scan'208";a="21866901"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2024 06:28:02 -0700
X-CSE-ConnectionGUID: vZM+LOvuQ0WfPr3xuIGxkQ==
X-CSE-MsgGUID: fDw++BBnTASU66FSB+U9wg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,159,1719903600"; 
   d="scan'208";a="60072748"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmviesa007.fm.intel.com with SMTP; 19 Aug 2024 06:27:57 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 19 Aug 2024 16:27:56 +0300
Date: Mon, 19 Aug 2024 16:27:56 +0300
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
Subject: Re: [PATCH 2/3] usb: typec: ucsi: Move unregister out of atomic
 section
Message-ID: <ZsNIXHRvCvWCNk3O@kuha.fi.intel.com>
References: <20240818-pmic-glink-v6-11-races-v1-0-f87c577e0bc9@quicinc.com>
 <20240818-pmic-glink-v6-11-races-v1-2-f87c577e0bc9@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240818-pmic-glink-v6-11-races-v1-2-f87c577e0bc9@quicinc.com>

On Sun, Aug 18, 2024 at 04:17:38PM -0700, Bjorn Andersson wrote:
> Commit 'caa855189104 ("soc: qcom: pmic_glink: Fix race during
> initialization")' moved the pmic_glink client list under a spinlock, as
> it is accessed by the rpmsg/glink callback, which in turn is invoked
> from IRQ context.
> 
> This means that ucsi_unregister() is now called from IRQ context, which
> isn't feasible as it's expecting a sleepable context. An effort is under
> way to get GLINK to invoke its callbacks in a sleepable context, but
> until then lets schedule the unregistration.
> 
> A side effect of this is that ucsi_unregister() can now happen
> after the remote processor, and thereby the communication link with it, is
> gone. pmic_glink_send() is amended with a check to avoid the resulting
> NULL pointer dereference, but it becomes expecting to see a failing send
> upon shutting down the remote processor (e.g. during a restart following
> a firmware crash):
> 
>   ucsi_glink.pmic_glink_ucsi pmic_glink.ucsi.0: failed to send UCSI write request: -5
> 
> Fixes: caa855189104 ("soc: qcom: pmic_glink: Fix race during initialization")
> Cc: stable@vger.kernel.org
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/soc/qcom/pmic_glink.c       | 10 +++++++++-
>  drivers/usb/typec/ucsi/ucsi_glink.c | 28 +++++++++++++++++++++++-----
>  2 files changed, 32 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/soc/qcom/pmic_glink.c b/drivers/soc/qcom/pmic_glink.c
> index 58ec91767d79..e4747f1d3da5 100644
> --- a/drivers/soc/qcom/pmic_glink.c
> +++ b/drivers/soc/qcom/pmic_glink.c
> @@ -112,8 +112,16 @@ EXPORT_SYMBOL_GPL(pmic_glink_register_client);
>  int pmic_glink_send(struct pmic_glink_client *client, void *data, size_t len)
>  {
>  	struct pmic_glink *pg = client->pg;
> +	int ret;
>  
> -	return rpmsg_send(pg->ept, data, len);
> +	mutex_lock(&pg->state_lock);
> +	if (!pg->ept)
> +		ret = -ECONNRESET;
> +	else
> +		ret = rpmsg_send(pg->ept, data, len);
> +	mutex_unlock(&pg->state_lock);
> +
> +	return ret;
>  }
>  EXPORT_SYMBOL_GPL(pmic_glink_send);
>  
> diff --git a/drivers/usb/typec/ucsi/ucsi_glink.c b/drivers/usb/typec/ucsi/ucsi_glink.c
> index ac53a81c2a81..a33056eec83d 100644
> --- a/drivers/usb/typec/ucsi/ucsi_glink.c
> +++ b/drivers/usb/typec/ucsi/ucsi_glink.c
> @@ -68,6 +68,9 @@ struct pmic_glink_ucsi {
>  
>  	struct work_struct notify_work;
>  	struct work_struct register_work;
> +	spinlock_t state_lock;
> +	unsigned int pdr_state;
> +	unsigned int new_pdr_state;
>  
>  	u8 read_buf[UCSI_BUF_SIZE];
>  };
> @@ -244,8 +247,22 @@ static void pmic_glink_ucsi_notify(struct work_struct *work)
>  static void pmic_glink_ucsi_register(struct work_struct *work)
>  {
>  	struct pmic_glink_ucsi *ucsi = container_of(work, struct pmic_glink_ucsi, register_work);
> +	unsigned long flags;
> +	unsigned int new_state;
> +
> +	spin_lock_irqsave(&ucsi->state_lock, flags);
> +	new_state = ucsi->new_pdr_state;
> +	spin_unlock_irqrestore(&ucsi->state_lock, flags);
> +
> +	if (ucsi->pdr_state != SERVREG_SERVICE_STATE_UP) {
> +		if (new_state == SERVREG_SERVICE_STATE_UP)
> +			ucsi_register(ucsi->ucsi);
> +	} else {
> +		if (new_state == SERVREG_SERVICE_STATE_DOWN)
> +			ucsi_unregister(ucsi->ucsi);
> +	}
>  
> -	ucsi_register(ucsi->ucsi);
> +	ucsi->pdr_state = new_state;
>  }
>  
>  static void pmic_glink_ucsi_callback(const void *data, size_t len, void *priv)
> @@ -269,11 +286,12 @@ static void pmic_glink_ucsi_callback(const void *data, size_t len, void *priv)
>  static void pmic_glink_ucsi_pdr_notify(void *priv, int state)
>  {
>  	struct pmic_glink_ucsi *ucsi = priv;
> +	unsigned long flags;
>  
> -	if (state == SERVREG_SERVICE_STATE_UP)
> -		schedule_work(&ucsi->register_work);
> -	else if (state == SERVREG_SERVICE_STATE_DOWN)
> -		ucsi_unregister(ucsi->ucsi);
> +	spin_lock_irqsave(&ucsi->state_lock, flags);
> +	ucsi->new_pdr_state = state;
> +	spin_unlock_irqrestore(&ucsi->state_lock, flags);
> +	schedule_work(&ucsi->register_work);
>  }
>  
>  static void pmic_glink_ucsi_destroy(void *data)
> 
> -- 
> 2.34.1

-- 
heikki

