Return-Path: <linux-pm+bounces-12436-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7642B956CB4
	for <lists+linux-pm@lfdr.de>; Mon, 19 Aug 2024 16:08:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7583B25546
	for <lists+linux-pm@lfdr.de>; Mon, 19 Aug 2024 14:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4966216D31A;
	Mon, 19 Aug 2024 14:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eGaLxQRU"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF7E16CD02;
	Mon, 19 Aug 2024 14:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724076466; cv=none; b=NiG16Pp60Ab7ginboEco4p5DT+hfvk9WjqBTkLrgIJvFk/JNmuNXgL90SRE3ZTrRNNTGTcW7bQQTnkFphICR7GZxaTUkH3FZDlp/YpRDqP+7v68bhbx4Jos6QKKnoVeyhT5nhpQa+ZzSN/HqVrWnP8eVZ9uNVpvqTCoP3TUdT1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724076466; c=relaxed/simple;
	bh=ISi78XNIMPVWDNGliDOOqlz+F6un0Fa04UJbTOxjiEg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CvhhMO7J34F0/O4WSSEo9yWKsiODzkV8NhdZK5p26eF6qK44ILbqDQVAup/GCW947dUNDvKKlzIAz81CzraDJMQ8ZrLBC7cMIoBafH8q4/JOl3eLUflkaxR6YqMIr6Kn6kXKBLNS2papyopx2jhcf6E9s4fi+9zj/QqrC16Qqno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eGaLxQRU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7021EC32782;
	Mon, 19 Aug 2024 14:07:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724076465;
	bh=ISi78XNIMPVWDNGliDOOqlz+F6un0Fa04UJbTOxjiEg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eGaLxQRU7fzLOB5R0JryMchI8iXukUXTmUpiDd7PtmJlycUdPNFWtFHaTWy6JnjcQ
	 QHcl0X5oQG9wgkFONU/ubTN5FZp2kZaE9p6eeP6l1y5a62vsW5Y4CFAKqDM85IQ2rb
	 rJSujDq1nH2b/5BI+wmkTjWGcQQ6e1YIGbvWsXfg=
Date: Mon, 19 Aug 2024 16:07:41 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Bjorn Andersson <quic_bjorande@quicinc.com>
Cc: Sebastian Reichel <sre@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Johan Hovold <johan+linaro@kernel.org>,
	Chris Lew <quic_clew@quicinc.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Stephen Boyd <swboyd@chromium.org>,
	Amit Pundir <amit.pundir@linaro.org>, linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org, Johan Hovold <johan@kernel.org>,
	stable@vger.kernel.org
Subject: Re: [PATCH 0/3] soc: qcom: pmic_glink: v6.11-rc bug fixes
Message-ID: <2024081914-exploit-yonder-4d51@gregkh>
References: <20240818-pmic-glink-v6-11-races-v1-0-f87c577e0bc9@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240818-pmic-glink-v6-11-races-v1-0-f87c577e0bc9@quicinc.com>

On Sun, Aug 18, 2024 at 04:17:36PM -0700, Bjorn Andersson wrote:
> Amit and Johan both reported a NULL pointer dereference in the
> pmic_glink client code during initialization, and Stephen Boyd pointed
> out the problem (race condition).
> 
> While investigating, and writing the fix, I noticed that
> ucsi_unregister() is called in atomic context but tries to sleep, and I
> also noticed that the condition for when to inform the pmic_glink client
> drivers when the remote has gone down is just wrong.
> 
> So, let's fix all three.
> 
> As mentioned in the commit message for the UCSI fix, I have a series in
> the works that makes the GLINK callback happen in a sleepable context,
> which would remove the need for the clients list to be protected by a
> spinlock, and removing the work scheduling. This is however not -rc
> material...
> 
> In addition to the NULL pointer dereference, there is the -ECANCELED
> issue reported here:
> https://lore.kernel.org/all/Zqet8iInnDhnxkT9@hovoldconsulting.com/
> I have not yet been able to either reproduce this or convince myself
> that this is the same issue.
> 
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>

What tree are these to go through?  I can take them through mine, but if
someone else wants to, feel free to route them some other way.

thanks,

greg k-h

