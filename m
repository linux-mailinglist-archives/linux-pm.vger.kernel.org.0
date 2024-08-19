Return-Path: <linux-pm+bounces-12443-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26A33956F30
	for <lists+linux-pm@lfdr.de>; Mon, 19 Aug 2024 17:48:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8620283759
	for <lists+linux-pm@lfdr.de>; Mon, 19 Aug 2024 15:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0613261FEB;
	Mon, 19 Aug 2024 15:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p7p+PPYI"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53D141C79;
	Mon, 19 Aug 2024 15:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724082508; cv=none; b=WY3TfsJQK0ljDAM8Ns8hi4TTAqkbC0d0r0+GX47YEFYvOHNdO/HXEyL+gFfsM0GFo/fRfxwTfSfyqLQznoZ//BL08RjtSNIeIY73Qg0pUI47+89aE/FNjcm9zL83dq4UUBX7j2e/6yYyulbf6Oj16kCeCL2k8usQWa+1dAtpZqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724082508; c=relaxed/simple;
	bh=ZexBRrXYqdegzaKuGie16KhsYastSeM2wRx5qQFg7Tg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kwRAuDVWUcVskkygGKs5lNgeUqXor3pjw4UZEn+7BO18NAwW+6AjCwklYpb44Qqua/7OwI3xQ+8TjwOwmytRo2UWFNVVdeuVvjffI+NGkXeC7HOOM5imIvma8zQIw7xbaplmqT4dvcDz4jeI9Gne9tEkp/etsCLCGFxpN1psCxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p7p+PPYI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CC5CC32782;
	Mon, 19 Aug 2024 15:48:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724082508;
	bh=ZexBRrXYqdegzaKuGie16KhsYastSeM2wRx5qQFg7Tg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p7p+PPYIU4/DIvdgqUXVipPPf77axfmTOC9kOf5Pwr5go7aZQFacmlfQVYmNNSC09
	 J8GPvf7vGz7E47Xsu/u1U8R7pIAvyfo7/H1xQD8DfKiZ2hHPLMmT/SxGPuZim4W39l
	 REkfs3sdS6D/Hc3hYi/YI0C3LfBJmblF5WW2BBNG6q2NkbfUl9qfcRwoLYYzzK9pte
	 7sauKAUMVHy1KmCtk202UaCXVCUHO9tsDpn5VstafvPJ4sVRPfmUyDHYXlh+c3URLW
	 w5Boqw0N6p0m0Y6Wm/fBCDxwKW1A5v3pn1VSFsKjlrz1b9xjNoXlbZ3531r/QG3JO+
	 zI6HieVuIeXqQ==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1sg4cM-000000001X3-0sb8;
	Mon, 19 Aug 2024 17:48:26 +0200
Date: Mon, 19 Aug 2024 17:48:26 +0200
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
Subject: Re: [PATCH 0/3] soc: qcom: pmic_glink: v6.11-rc bug fixes
Message-ID: <ZsNpSt3BtdFIT6ml@hovoldconsulting.com>
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

> In addition to the NULL pointer dereference, there is the -ECANCELED
> issue reported here:
> https://lore.kernel.org/all/Zqet8iInnDhnxkT9@hovoldconsulting.com/
> I have not yet been able to either reproduce this or convince myself
> that this is the same issue.

I can confirm that I still see the -ECANCELED issue with this series
applied:

[    8.979329] pmic_glink_altmode.pmic_glink_altmode pmic_glink.altmode.0: failed to send altmode request: 0x10 (-125)
[    9.004735] pmic_glink_altmode.pmic_glink_altmode pmic_glink.altmode.0: failed to request altmode notifications: -125

Johan

