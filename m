Return-Path: <linux-pm+bounces-16453-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FDBB9B0411
	for <lists+linux-pm@lfdr.de>; Fri, 25 Oct 2024 15:32:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C18081C22237
	for <lists+linux-pm@lfdr.de>; Fri, 25 Oct 2024 13:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6C821632CC;
	Fri, 25 Oct 2024 13:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cqy6OX6/"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846BD212178;
	Fri, 25 Oct 2024 13:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729863156; cv=none; b=Pc4VlCWZOtgFUeRRKJ3sTHsa6oM2+cM5wiTV46lwtB6j4u6JuHExw2U5/kAVkznEcV31Auk11BGDdihKfREUwyQl8tuYBEb0V/4Fa4CyxPNcWAZiS4wC3P61qn7sclokL41lluUJsier5+FNPZ0X7mxrrn8nKweqEFCwqMtU5D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729863156; c=relaxed/simple;
	bh=v+TIq5Hs+T34ql7qTS7QA5QIGOI10d3BPzw3MOJHPjA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MGGXg1Ew/nq8Ht1yh4iOW84oKbCfWCV83YbrOkNS+K2VszLmMzZOiFBVf6zi0/79AMd2Wn0kOjD0L7WpWzccYyLlPTEj1W4pUfeiXI/gRR3CCt0mA0l6xPWTH3wAAKp3WsVK8rA9LndtZXybUi7NY+Zr7vwTTIAdlpsl932rOiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cqy6OX6/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E79C7C4CEC3;
	Fri, 25 Oct 2024 13:32:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729863156;
	bh=v+TIq5Hs+T34ql7qTS7QA5QIGOI10d3BPzw3MOJHPjA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Cqy6OX6/+cX8BA9XID33+3sylxcFaV2QoZm5JbvALDgiV4XUTZPYfMG1T91X0RQ5J
	 oiOzw9IqVK5+cBnKGQeaYPk3y1e3UwC/NvHWB1QE9RVyudiAx7cKOagK9vCHSmyKTb
	 bVbPx9bk1GAIdkBxRslXYId2Kj1IkJa+0bCQA3Qfg7Qjp0IXCOcjXbcg92AoIU1aWx
	 36Z1ooxrMn3JOdKXi/yAmr6TtYBqEzSiFUguzMb7nRDC4ziIB+ND0VAoHwQmKMjXBN
	 +h6VNQK5QGP/3c937xAvKywC9Ezpo4QN05XTPOMTwJvn4mj0mioQ02RRb6TJYLctQF
	 Qz3reD95Wv4wQ==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1t4KQv-000000003F4-2HzN;
	Fri, 25 Oct 2024 15:32:54 +0200
Date: Fri, 25 Oct 2024 15:32:53 +0200
From: Johan Hovold <johan@kernel.org>
To: Cristian Marussi <cristian.marussi@arm.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Sibi Sankar <quic_sibis@quicinc.com>, sudeep.holla@arm.com,
	ulf.hansson@linaro.org, jassisinghbrar@gmail.com,
	linux-kernel@vger.kernel.org, arm-scmi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	konradybcio@kernel.org, linux-pm@vger.kernel.org,
	tstrudel@google.com, rafael@kernel.org
Subject: Re: [PATCH V3 0/4] firmware: arm_scmi: Misc Fixes
Message-ID: <ZxueBWB9nJ9Mt7bW@hovoldconsulting.com>
References: <20241007060642.1978049-1-quic_sibis@quicinc.com>
 <ZwfsmqInJlqkQD_3@hovoldconsulting.com>
 <ae5eaef9-301f-7d3f-c973-faa22ae780ee@quicinc.com>
 <ZxkjqEmkBAsC6UkL@hovoldconsulting.com>
 <c8e7420b-a7b4-89cd-1b6e-c1f6693c062d@quicinc.com>
 <ik4dyfbphm7lkeipm2dbr7cmdfxewxd4jtuz2jfnscfwcyo2r4@lrin5hnsqvyd>
 <83b635a7-fc69-7522-d985-810262500cb3@quicinc.com>
 <CAA8EJppx1OmYnfSsMDebRRTbNb3dfAE_MM55T1SpLccP=s_K1A@mail.gmail.com>
 <Zxty8VaMPrU3fJAN@pluto>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zxty8VaMPrU3fJAN@pluto>

On Fri, Oct 25, 2024 at 11:29:05AM +0100, Cristian Marussi wrote:

> > > >>> [    8.098452] arm-scmi arm-scmi.0.auto: Failed to add opps_by_lvl at 3417600 for NCC - ret:-16
> > > >>> [    8.109647] arm-scmi arm-scmi.0.auto: Failed to add opps_by_lvl at 3417600 for NCC - ret:-16
> > > >>> [    8.128970] arm-scmi arm-scmi.0.auto: Failed to add opps_by_lvl at 3417600 for NCC - ret:-16
> > > >>> [    8.142455] arm-scmi arm-scmi.0.auto: Failed to add opps_by_lvl at 3417600 for NCC - ret:-16

> I think dev_info could be an option from the SCMI perspective (as per my
> other mail), the important thing in these regards is to NOT go
> completely silent against fw anomalies...to avoid the the risk of being
> silently ignored .... I'll see what Sudeep thinks about...

I agree.

But could the error handling be improved to look less scary for an end
user by saying something about duplicate entries being ignored instead
perhaps?

Printing something at info level and with a FW_BUG ("[Firmware Bug]: ")
prefix as was done here:

	https://lore.kernel.org/all/20230414084619.31524-1-johan+linaro@kernel.org/

should make it clear that this is not something for end users to worry
(too much) about.

Johan

