Return-Path: <linux-pm+bounces-12529-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7988F957F02
	for <lists+linux-pm@lfdr.de>; Tue, 20 Aug 2024 09:07:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C8BA1F23D97
	for <lists+linux-pm@lfdr.de>; Tue, 20 Aug 2024 07:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6F8A16C437;
	Tue, 20 Aug 2024 07:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qYMm+1BR"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F9FE4084E;
	Tue, 20 Aug 2024 07:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724137632; cv=none; b=OxIj1oSCgejvw6TDQZnritcNyez8xaJvYzPujCdKqmwEL7tlcwzv6jGuxyatCelQEXfGaqqqJa4NjUL5J+ZoxkeG/bs1tlkBLupJo5j/sIJMpP5jOc6iGdpWq162g6nWJqcC7EsoSUkTt82JcEsRz0ya8KZr+yLX+eWh3pmAo4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724137632; c=relaxed/simple;
	bh=Vh6MSMRStnW33q5+dD+Us/r1QXXTp4gSRyZS7k149cY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pem/ESC78y4YXh0OVByHp8GCSXI8iG5Do/7+dZwnMKI3y3zAgyRx1+gqiJccCHC40c4blcrOUNdvD0Uqk5/ID+x8BRsswtlnHNS0a1vJ1vsqEgTorUYJGCuZeBDH+UdVTWSklZL3IytBNRq7LhjqoDTgkxNU4ZBJSmlkKEdBhZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qYMm+1BR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7C13C4AF10;
	Tue, 20 Aug 2024 07:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724137632;
	bh=Vh6MSMRStnW33q5+dD+Us/r1QXXTp4gSRyZS7k149cY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qYMm+1BREzRTVXtFN3XKXPxAN7VMeYrYc5xpmGBl8X2sK0zrMmER8Pq60YpDRzfGr
	 Isk7MujL2y125VuDHL+yuJ00ztDg+Ry/zGf+F5U49lMH5zRgATfD1WEfydJATk+K7b
	 tm4Kd+bHtAtV2RpU0TEo4xhMo4kvLBTSTMKC3sC62zQIBmPZpisewfZ+NLYWyL0Gpi
	 GUSbcvoz1x1t+spqKidtx0+cNkRFXnlCc5l2tLAklbmAAiAbEwHGgk1N4CH3/Jujs8
	 SwYgVyuK5SrIeGYG7G6SIAbSm9BroZ9WbzrLO1rWVMwKVhPXjxxKIOtjLbtm9ve2XV
	 vcu0rVjQfGCTA==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1sgIxR-000000002iP-2RXK;
	Tue, 20 Aug 2024 09:07:10 +0200
Date: Tue, 20 Aug 2024 09:07:09 +0200
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
Subject: Re: [PATCH v2 3/3] soc: qcom: pmic_glink: Actually communicate with
 remote goes down
Message-ID: <ZsRAnWgsoSHmrFE5@hovoldconsulting.com>
References: <20240819-pmic-glink-v6-11-races-v2-0-88fe3ab1f0e2@quicinc.com>
 <20240819-pmic-glink-v6-11-races-v2-3-88fe3ab1f0e2@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240819-pmic-glink-v6-11-races-v2-3-88fe3ab1f0e2@quicinc.com>

On Mon, Aug 19, 2024 at 01:07:47PM -0700, Bjorn Andersson wrote:
> When the pmic_glink state is UP and we either receive a protection-
> domain (PD) notification indicating that the PD is going down, or that
> the whole remoteproc is going down, it's expected that the pmic_glink
> client instances are notified that their function has gone DOWN.
> 
> This is not what the code does, which results in the client state either
> not updating, or being wrong in many cases. So let's fix the conditions.

> @@ -191,7 +191,7 @@ static void pmic_glink_state_notify_clients(struct pmic_glink *pg)
>  		if (pg->pdr_state == SERVREG_SERVICE_STATE_UP && pg->ept)
>  			new_state = SERVREG_SERVICE_STATE_UP;
>  	} else {
> -		if (pg->pdr_state == SERVREG_SERVICE_STATE_UP && pg->ept)
> +		if (pg->pdr_state == SERVREG_SERVICE_STATE_DOWN || !pg->ept)
>  			new_state = SERVREG_SERVICE_STATE_DOWN;
>  	}

I guess you could drop the outer conditional

	if (pg->client_state != SERVREG_SERVICE_STATE_UP) {

	} else {

	}

here to make this a bit more readable, but that's for a separate patch.

Reviewed-by: Johan Hovold <johan+linaro@kernel.org>

Johan

