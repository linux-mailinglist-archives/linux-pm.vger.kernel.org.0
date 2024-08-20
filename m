Return-Path: <linux-pm+bounces-12520-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 80F67957E90
	for <lists+linux-pm@lfdr.de>; Tue, 20 Aug 2024 08:43:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 374A91F25013
	for <lists+linux-pm@lfdr.de>; Tue, 20 Aug 2024 06:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4A2818E36C;
	Tue, 20 Aug 2024 06:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GfGfqWTx"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE8118E367;
	Tue, 20 Aug 2024 06:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724136186; cv=none; b=ix8r7w77T9Hy8Y4kf33WjFVlEcysFsTZosO8K2Jo1tVlYfNDBWfjF/4kLuFazgx7F7hdHmkggjqUSrb3ImuQYcqI9g6Z+M5t78vxINFeGcKG03rjpdTZ+YszLyJ/RhDFyU1iZOo3o7AlUpG0VePzAZN5XOXWC0sUQVv7CdEsums=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724136186; c=relaxed/simple;
	bh=w6EyYXc3Ndy/Jh0CvsxJfvu+nAOW2WtZ+hmTnufK72I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pzMDgPuEDG5FKzMim+j5TPMcODDwi2n3n2Jc302XrMbQRc82ac7U6cjBLMShJjVW0EyH8OCOiTqIPb/2qN9R+LqfF8gPoYi3XbY4QwiGfP74szktxHPzhYyMvPqCPBMq9LG8hPJX74khxhFatvuvYihY/ECRUa6FY4WUgoTadVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GfGfqWTx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24E43C4AF09;
	Tue, 20 Aug 2024 06:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724136186;
	bh=w6EyYXc3Ndy/Jh0CvsxJfvu+nAOW2WtZ+hmTnufK72I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GfGfqWTxv6nVsr6Z26gFvWerB7LKCwvv/HP778VS0+1IR2OM4V4rAqOz17kgy1XfK
	 kS18eVUt6gQwF6xoJK0q2H01eKDyspu4U4eJ1bbV6bOeBPgW2EVsK+bWXAvO8rNYVE
	 Cq+drnxMqt4p55HMQGR1c2209bemomaQ/+Hfmm2OATt+TTy5mnwlvu4sQ9bMe4llUk
	 UEQM25FaRkAsRONsloJszOK49wHp6fznTKyI/UQTWbO5sY5hehkTtXEWbywUCos+6O
	 V23hrmYldcdq0Tgd/2QyFw8Eh+Fd80KSJzaiRPvtjnFgWRiglWlQ3wX+2sH/iVlB0O
	 ONLVL38Ol/5xA==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1sgIa7-000000002N9-38hD;
	Tue, 20 Aug 2024 08:43:04 +0200
Date: Tue, 20 Aug 2024 08:43:03 +0200
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
Subject: Re: [PATCH v2 2/3] usb: typec: ucsi: Move unregister out of atomic
 section
Message-ID: <ZsQ696Jq5aO8IMKG@hovoldconsulting.com>
References: <20240819-pmic-glink-v6-11-races-v2-0-88fe3ab1f0e2@quicinc.com>
 <20240819-pmic-glink-v6-11-races-v2-2-88fe3ab1f0e2@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240819-pmic-glink-v6-11-races-v2-2-88fe3ab1f0e2@quicinc.com>

On Mon, Aug 19, 2024 at 01:07:46PM -0700, Bjorn Andersson wrote:
> Commit '635ce0db8956 ("soc: qcom: pmic_glink: don't traverse clients

Looks like you copied the wrong SHA again. This should be

	9329933699b3 ("soc: qcom: pmic_glink: Make client-lock non-sleeping")

as we discussed.

> list without a lock")' moved the pmic_glink client list under a
> spinlock, as it is accessed by the rpmsg/glink callback, which in turn
> is invoked from IRQ context.
> 
> This means that ucsi_unregister() is now called from IRQ context, which

And this should be "atomic context" as pdr notifications are done from
a worker thread.

> isn't feasible as it's expecting a sleepable context. An effort is under
> way to get GLINK to invoke its callbacks in a sleepable context, but
> until then lets schedule the unregistration.
> 
> A side effect of this is that ucsi_unregister() can now happen
> after the remote processor, and thereby the communication link with it, is
> gone. pmic_glink_send() is amended with a check to avoid the resulting NULL
> pointer dereference.
> This does however result in the user being informed about this error by
> the following entry in the kernel log:
> 
>   ucsi_glink.pmic_glink_ucsi pmic_glink.ucsi.0: failed to send UCSI write request: -5
> 
> Fixes: 635ce0db8956 ("soc: qcom: pmic_glink: don't traverse clients list without a lock")

Fixes: 9329933699b3 ("soc: qcom: pmic_glink: Make client-lock non-sleeping")

> Cc: stable@vger.kernel.org
> Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Tested-by: Amit Pundir <amit.pundir@linaro.org>
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>

> @@ -269,11 +284,12 @@ static void pmic_glink_ucsi_callback(const void *data, size_t len, void *priv)
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
> +	ucsi->pd_running = state == SERVREG_SERVICE_STATE_UP;

Add parentheses for readability?

> +	spin_unlock_irqrestore(&ucsi->state_lock, flags);
> +	schedule_work(&ucsi->register_work);
>  }
>  
>  static void pmic_glink_ucsi_destroy(void *data)
> @@ -320,6 +336,7 @@ static int pmic_glink_ucsi_probe(struct auxiliary_device *adev,
>  	INIT_WORK(&ucsi->register_work, pmic_glink_ucsi_register);
>  	init_completion(&ucsi->read_ack);
>  	init_completion(&ucsi->write_ack);
> +	spin_lock_init(&ucsi->state_lock);
>  	mutex_init(&ucsi->lock);
>  
>  	ucsi->ucsi = ucsi_create(dev, &pmic_glink_ucsi_ops);

Looks good otherwise:

Reviewed-by: Johan Hovold <johan+linaro@kernel.org>

Johan

