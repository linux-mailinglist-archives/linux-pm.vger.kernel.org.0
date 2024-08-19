Return-Path: <linux-pm+bounces-12441-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76023956E34
	for <lists+linux-pm@lfdr.de>; Mon, 19 Aug 2024 17:07:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 322D32816E9
	for <lists+linux-pm@lfdr.de>; Mon, 19 Aug 2024 15:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11939176AA3;
	Mon, 19 Aug 2024 15:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A+NvMM/j"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2AA617622F;
	Mon, 19 Aug 2024 15:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724080022; cv=none; b=nalaRMSVDuxynqTawCojSJWQa+Wt9aSoZm/2Z0qC5GIFADQLmR4bCvgDXnm75XXcE4BEWnI/FW9g6ffnEVmR737lYOokip9tDNWG16MMMf0/xp5+6hvlfOTvHUn91hQm28u1fIr9D4EXeRlED+U27ga1ygbCSmZ1vsK+ib1P+Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724080022; c=relaxed/simple;
	bh=GYtDHER4l36QRbGSz9n1fTQl4KIxcIyyj6NCZNhyrxg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pxOKAUnO0eAE4rWtlvlqNY3U1q+wvmBqTmPr7S++gKZcrT+71+6ZKKohHkyHL4hdzp0QkOilriI6e1PE/2QGDGzU+NrsRP0rkpoOuGNS88z7B/d0yYLd20GVahqS9pNj/3nEvxknco8TO//ba4RNMXKFfJPMczgzLtuzmCII+Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A+NvMM/j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41078C32782;
	Mon, 19 Aug 2024 15:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724080021;
	bh=GYtDHER4l36QRbGSz9n1fTQl4KIxcIyyj6NCZNhyrxg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A+NvMM/j9AVWIdfl4DKGnMElXWkpNPiFw43YwYnU0q3FYA70zKlbSe23ahceuKf2z
	 Y6DzmQMxoUsh9ICWPAl0oHAbrOwicDumKDX1O/9h95qs5aWycObt57qRrpDUWz9zG8
	 /vR6JDNIcCECfynJNfD0++4FF1FJ079FQX9UWD36qzhDnwI+VSZSUVwksxdfSUGrtG
	 Ot6jgqF/6cDf5LvCigzB71UokFA9lPsWSpqIrxHdobmWU5h6ZnsVD4JB8gsqoFUlYQ
	 wHn6uueqdNrKPA7Mnl338xLhDmmkWnUdirpuUnCeqQ4O8M6ZVutRAAXzl1vIIbP63k
	 6I8VRQDxUx9QQ==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1sg3yE-000000007do-14Mo;
	Mon, 19 Aug 2024 17:06:58 +0200
Date: Mon, 19 Aug 2024 17:06:58 +0200
From: Johan Hovold <johan@kernel.org>
To: Bjorn Andersson <quic_bjorande@quicinc.com>
Cc: Sebastian Reichel <sre@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
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
Message-ID: <ZsNfkuiRK9VqBSLT@hovoldconsulting.com>
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
> initialization")' 

This commit does not exist, but I think you really meant to refer to

	9329933699b3 ("soc: qcom: pmic_glink: Make client-lock non-sleeping")

and possibly also

	635ce0db8956 ("soc: qcom: pmic_glink: don't traverse clients list without a lock")

here.

> moved the pmic_glink client list under a spinlock, as
> it is accessed by the rpmsg/glink callback, which in turn is invoked
> from IRQ context.
> 
> This means that ucsi_unregister() is now called from IRQ context, which
> isn't feasible as it's expecting a sleepable context.

But this is not correct as you say above that the callback has always
been made in IRQ context. Then this bug has been there since the
introduction of the UCSI driver by commit

	62b5412b1f4a ("usb: typec: ucsi: add PMIC Glink UCSI driver")

> An effort is under
> way to get GLINK to invoke its callbacks in a sleepable context, but
> until then lets schedule the unregistration.
> 
> A side effect of this is that ucsi_unregister() can now happen
> after the remote processor, and thereby the communication link with it, is
> gone. pmic_glink_send() is amended with a check to avoid the resulting
> NULL pointer dereference, but it becomes expecting to see a failing send

Perhaps you can rephrase this bit ("becomes expecting to see").

> upon shutting down the remote processor (e.g. during a restart following
> a firmware crash):
> 
>   ucsi_glink.pmic_glink_ucsi pmic_glink.ucsi.0: failed to send UCSI write request: -5
> 
> Fixes: caa855189104 ("soc: qcom: pmic_glink: Fix race during initialization")

So this should be

Fixes: 62b5412b1f4a ("usb: typec: ucsi: add PMIC Glink UCSI driver")

> Cc: stable@vger.kernel.org
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
 
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

Should these be int to match the notify callback (and enum
servreg_service_state)?

>  	u8 read_buf[UCSI_BUF_SIZE];
>  };
> @@ -244,8 +247,22 @@ static void pmic_glink_ucsi_notify(struct work_struct *work)
>  static void pmic_glink_ucsi_register(struct work_struct *work)
>  {
>  	struct pmic_glink_ucsi *ucsi = container_of(work, struct pmic_glink_ucsi, register_work);
> +	unsigned long flags;
> +	unsigned int new_state;

Then int here too.

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

Do you risk a double deregistration (and UAF/double free) here?

> +	}
>  
> -	ucsi_register(ucsi->ucsi);
> +	ucsi->pdr_state = new_state;
>  }

Johan

