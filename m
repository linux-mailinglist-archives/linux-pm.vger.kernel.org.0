Return-Path: <linux-pm+bounces-12521-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E04F8957EB1
	for <lists+linux-pm@lfdr.de>; Tue, 20 Aug 2024 08:53:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D7A01F24ED6
	for <lists+linux-pm@lfdr.de>; Tue, 20 Aug 2024 06:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 554163F9C5;
	Tue, 20 Aug 2024 06:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hhZzymRT"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1372718E36D;
	Tue, 20 Aug 2024 06:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724136833; cv=none; b=YSG3v/oa8jW+Uf7c4Wsj0+wvrvSA9ueyqb+QsiyR+BGYvz/uudbTDPOz+hOZCmjBY+J8b9tOs/oYwlbaD8J0+d+cpdAkLBVxQfbv/7Rxb3odQe6gb6E6ZENlkyJdg1alC1RZBpxzTCcTcDprd4jVJjj95qiFPRQpYbKNn2J1FTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724136833; c=relaxed/simple;
	bh=x/QLEd4EJGxD7KAIK7G6x29L4+g4QBuvv0SgFktpjQI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bvKze281Ebt29KSzbzcrgOPxTf02QD5AZk/iWhlcBIvyiX2r/qdMU+O2NE8uFfOk/mlE/TsZpcUbkFCM1Rx+W85c9V1FXY5tsawBXRgcnqlu1z43bTY4MCRKx9ph8m7/RrMGHPObO4jIG3RaDq/IjD/zsk7Zn2Sawtf9aGZViWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hhZzymRT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94064C4AF09;
	Tue, 20 Aug 2024 06:53:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724136832;
	bh=x/QLEd4EJGxD7KAIK7G6x29L4+g4QBuvv0SgFktpjQI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hhZzymRT8fi7SIrI2uhE6+JyoSLWNAnzfbIcCjUqimFY0YvBUNJTS0vNL3zsBLMAm
	 UBJo4i9QofUqMS326HAUSEoexl7hnhJm8U6U0yi4A8QP9pMn1LgyrQgNw6JIEJEpUZ
	 1Vqiv4uRfcAwAyIF2xbAxrG9nAamXzE74+rTXwAXaIEWRMyurW2deQWwoyk005OXPZ
	 hV1JMQp9xqMjc91pN2nZ4WjCe7JTwzh7gsgnG3G5Yx+CmkpqE8d8tJCznTxTsXG/sh
	 LYDknKcQlHzxPbfKBMnR0abXWzVRFtFgzMCxy+JUxtNbq/LWDI7TMUIbkEIcxGM7ga
	 tkOXbYl8qYwdg==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1sgIkY-000000002Wr-07ht;
	Tue, 20 Aug 2024 08:53:50 +0200
Date: Tue, 20 Aug 2024 08:53:50 +0200
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
Subject: Re: [PATCH v2 1/3] soc: qcom: pmic_glink: Fix race during
 initialization
Message-ID: <ZsQ9fhX98yfVXAxi@hovoldconsulting.com>
References: <20240819-pmic-glink-v6-11-races-v2-0-88fe3ab1f0e2@quicinc.com>
 <20240819-pmic-glink-v6-11-races-v2-1-88fe3ab1f0e2@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240819-pmic-glink-v6-11-races-v2-1-88fe3ab1f0e2@quicinc.com>

On Mon, Aug 19, 2024 at 01:07:45PM -0700, Bjorn Andersson wrote:
> As pointed out by Stephen Boyd it is possible that during initialization
> of the pmic_glink child drivers, the protection-domain notifiers fires,
> and the associated work is scheduled, before the client registration
> returns and as a result the local "client" pointer has been initialized.
> 
> The outcome of this is a NULL pointer dereference as the "client"
> pointer is blindly dereferenced.
> 
> Timeline provided by Stephen:
>  CPU0                               CPU1
>  ----                               ----
>  ucsi->client = NULL;
>  devm_pmic_glink_register_client()
>   client->pdr_notify(client->priv, pg->client_state)
>    pmic_glink_ucsi_pdr_notify()
>     schedule_work(&ucsi->register_work)
>     <schedule away>
>                                     pmic_glink_ucsi_register()
>                                      ucsi_register()
>                                       pmic_glink_ucsi_read_version()
>                                        pmic_glink_ucsi_read()
>                                         pmic_glink_ucsi_read()
>                                          pmic_glink_send(ucsi->client)
>                                          <client is NULL BAD>
>  ucsi->client = client // Too late!
> 
> This code is identical across the altmode, battery manager and usci
> child drivers.
> 
> Resolve this by splitting the allocation of the "client" object and the
> registration thereof into two operations.
> 
> This only happens if the protection domain registry is populated at the
> time of registration, which by the introduction of commit '1ebcde047c54
> ("soc: qcom: add pd-mapper implementation")' became much more likely.
> 
> Reported-by: Amit Pundir <amit.pundir@linaro.org>
> Closes: https://lore.kernel.org/all/CAMi1Hd2_a7TjA7J9ShrAbNOd_CoZ3D87twmO5t+nZxC9sX18tA@mail.gmail.com/
> Reported-by: Johan Hovold <johan@kernel.org>
> Closes: https://lore.kernel.org/all/ZqiyLvP0gkBnuekL@hovoldconsulting.com/
> Reported-by: Stephen Boyd <swboyd@chromium.org>
> Closes: https://lore.kernel.org/all/CAE-0n52JgfCBWiFQyQWPji8cq_rCsviBpW-m72YitgNfdaEhQg@mail.gmail.com/
> Fixes: 58ef4ece1e41 ("soc: qcom: pmic_glink: Introduce base PMIC GLINK driver")
> Cc: stable@vger.kernel.org
> Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
> Tested-by: Amit Pundir <amit.pundir@linaro.org>
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>

> diff --git a/drivers/soc/qcom/pmic_glink.c b/drivers/soc/qcom/pmic_glink.c
> index 9ebc0ba35947..58ec91767d79 100644
> --- a/drivers/soc/qcom/pmic_glink.c
> +++ b/drivers/soc/qcom/pmic_glink.c
> @@ -66,15 +66,14 @@ static void _devm_pmic_glink_release_client(struct device *dev, void *res)
>  	spin_unlock_irqrestore(&pg->client_lock, flags);
>  }
>  
> -struct pmic_glink_client *devm_pmic_glink_register_client(struct device *dev,
> -							  unsigned int id,
> -							  void (*cb)(const void *, size_t, void *),
> -							  void (*pdr)(void *, int),
> -							  void *priv)
> +struct pmic_glink_client *devm_pmic_glink_new_client(struct device *dev,

Please consider renaming this one

	devm_pmic_glink_alloc_client()

(or devm_pmic_glink_client_alloc()) which is more conventional for
kernel code than using "new".

> +						     unsigned int id,
> +						     void (*cb)(const void *, size_t, void *),
> +						     void (*pdr)(void *, int),
> +						     void *priv)
>  {
>  	struct pmic_glink_client *client;
>  	struct pmic_glink *pg = dev_get_drvdata(dev->parent);
> -	unsigned long flags;
>  
>  	client = devres_alloc(_devm_pmic_glink_release_client, sizeof(*client), GFP_KERNEL);
>  	if (!client)

Looks good otherwise:

Reviewed-by: Johan Hovold <johan+linaro@kernel.org>

Johan

