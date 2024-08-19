Return-Path: <linux-pm+bounces-12442-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73B02956EC9
	for <lists+linux-pm@lfdr.de>; Mon, 19 Aug 2024 17:33:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A58111C2217A
	for <lists+linux-pm@lfdr.de>; Mon, 19 Aug 2024 15:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D64E749641;
	Mon, 19 Aug 2024 15:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QpmrZFYZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA99335BA;
	Mon, 19 Aug 2024 15:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724081614; cv=none; b=NrtKjZ5gpDJRTr8YHehP23kMCslT7UzGRlVB7GubtHISRtXvmBwpDeQIZHoVMCO+eGNUvrOU5nC/a2JLGRGDPkOp7jLM7ls3x/ckvWLJJccemZWLXrnriJGzd6dpmaE+SueBPpUHwWciyrIdYqCVD3UVadzL6wUUFNHM1G+oshA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724081614; c=relaxed/simple;
	bh=cMUdGB7tTtNDo93qWtc+UFfdY81Of1coL0EqxlGVWmI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OAuUDOUYo5sHgHjbE3xx8T09ooJNVP0KOLYRHHncJyD1OFowwiQtSPlXCsmLm+fb4KCgi5EPZKW+KlTGNT9zY+Vws8OvW6Tuqozc9rENKqwc58pyoprYfOMQCpNj1F1Csc18cTXJd52AlsC3ELXksakec9bgPWInpv0ZhAWXkx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QpmrZFYZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22CFFC32782;
	Mon, 19 Aug 2024 15:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724081614;
	bh=cMUdGB7tTtNDo93qWtc+UFfdY81Of1coL0EqxlGVWmI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QpmrZFYZP+4w3HDN0UGAY9Q3HR92FMyOpwOqfsqssIhkxsgBqNcvw9rPSzPk+XDks
	 S9vilmTvMhb33rfERHYMpv7dPDmW0jI3sAwCOkpJe8gOJqVvl3o4+w7xCQ7Gw8iU6V
	 CGpvdEkKrRYcGbRs39+AZINCMR0PpFZN55dlWQJED/LGDUhvDnGLeQYFA3d8mLIw+A
	 NFP54/au1DqcsCSeiuNxZ+w6dadiD6/zcEPJ5gdcf3RqWCsWG23A6flmsG/f0pU8Ro
	 DhJ10PTbBlZTxDv3kUJxfdouUF8AQVeQuHVExFp35uN8lFKfcdc8ESzy76H8wFCe14
	 V5tCk4a5P+SZw==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1sg4Nv-000000000S8-2kpy;
	Mon, 19 Aug 2024 17:33:31 +0200
Date: Mon, 19 Aug 2024 17:33:31 +0200
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
Message-ID: <ZsNly-WqnuzBMOwL@hovoldconsulting.com>
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

> @@ -68,6 +68,9 @@ struct pmic_glink_ucsi {
>  
>  	struct work_struct notify_work;
>  	struct work_struct register_work;
> +	spinlock_t state_lock;

You also never initialise this lock...

Lockdep would have let you know with a big splat.

Johan

