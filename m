Return-Path: <linux-pm+bounces-12535-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07E7E957FA6
	for <lists+linux-pm@lfdr.de>; Tue, 20 Aug 2024 09:31:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AE871C22CDC
	for <lists+linux-pm@lfdr.de>; Tue, 20 Aug 2024 07:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E76C12FB34;
	Tue, 20 Aug 2024 07:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YIKbNpsK"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 225CF3FB9F;
	Tue, 20 Aug 2024 07:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724139097; cv=none; b=CAs7ooFbnKRZB9mcZH+0KszSbmUAmwoF7HudJ9MP8yF5FlGgkCR3qPfNvNZZJUyAvkGSmZnl82wSgY2AqxkCcizfQG9GgUVoUTMYKaxgYtcT0yxKIzUCoent9abBOXDzg11kCofEGbioF4+C7jqTdqTQof6pu4p8MeFtY95YCD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724139097; c=relaxed/simple;
	bh=lnVex45HkIbSrdva5jTznQrLVTO/IJ9b3LjfB4dv2tY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FjjPj+qtGpe7maIw+AKIpGASQ/dkPNWwhEEnxAa3tri2a/K8g4UII0mSrofdl1ux640DTvXSoh3I1mFcyEOjr+0zCT3sQizUwAZ0AgPK9RVs0//XzVFsxNxJiOO5Fm5NexDCRJRek9VRR1qDwm818SYetixWDPE8D00FqxfqYRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YIKbNpsK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9F39C4AF09;
	Tue, 20 Aug 2024 07:31:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724139096;
	bh=lnVex45HkIbSrdva5jTznQrLVTO/IJ9b3LjfB4dv2tY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YIKbNpsKqef0mmWZHrPR6/ZB8Lp0kbqpqBvjxDYuT8iReRhu1cXIUT53QPKlzUqqJ
	 mU6l+Y8lgvXwWgkeeVbiaLY4mdn6StAqucalxjVgu5janM8gCmcAl1mBoVpMrucU45
	 DvyHIcPJfzsV9NpaGlOh+fCYWQHrSDLTNEgjG3/0yoPi+2uAOCFPJughZ0VfbdYRaT
	 lvJT5BteKypflqJWrDO4eM7bsKUcn0zJ0CNVb7QY43kfb0iCbOBTmn9ViL6W6hmbbW
	 pqFmxGq4pfdA28JBFoY3vigUjsqxf/1YuyzblUNjtJC2I/ye+66n8+FEsC0rLwjc5j
	 0XibAonJ3IJsQ==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1sgJL5-000000005jS-0IhH;
	Tue, 20 Aug 2024 09:31:35 +0200
Date: Tue, 20 Aug 2024 09:31:35 +0200
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
Message-ID: <ZsRGV4hplvidpYji@hovoldconsulting.com>
References: <20240818-pmic-glink-v6-11-races-v1-0-f87c577e0bc9@quicinc.com>
 <ZsNpSt3BtdFIT6ml@hovoldconsulting.com>
 <ZsN4dcErSt3nioWn@hu-bjorande-lv.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZsN4dcErSt3nioWn@hu-bjorande-lv.qualcomm.com>

On Mon, Aug 19, 2024 at 09:53:09AM -0700, Bjorn Andersson wrote:
> On Mon, Aug 19, 2024 at 05:48:26PM +0200, Johan Hovold wrote:

> > I can confirm that I still see the -ECANCELED issue with this series
> > applied:
> > 
> > [    8.979329] pmic_glink_altmode.pmic_glink_altmode pmic_glink.altmode.0: failed to send altmode request: 0x10 (-125)
> > [    9.004735] pmic_glink_altmode.pmic_glink_altmode pmic_glink.altmode.0: failed to request altmode notifications: -125
> 
> Could you confirm that you're seeing a call to
> qcom_glink_handle_intent_req_ack() with granted == 0, leading to the
> transfer failing.

It appears so:

[    9.539415]  30000000.remoteproc:glink-edge: qcom_glink_handle_intent_req_ack - cid = 9, granted = 0
[    9.561750] qcom_battmgr.pmic_glink_power_supply pmic_glink.power-supply.0: failed to request power notifications

[    9.448945]  30000000.remoteproc:glink-edge: qcom_glink_handle_intent_req_ack - cid = 9, granted = 0
[    9.461267] pmic_glink_altmode.pmic_glink_altmode pmic_glink.altmode.0: failed to send altmode request: 0x10 (-125)
[    9.469241] qcom,apr 30000000.remoteproc:glink-edge.adsp_apps.-1.-1: Adding APR/GPR dev: gprsvc:service:2:1
[    9.478968] pmic_glink_altmode.pmic_glink_altmode pmic_glink.altmode.0: failed to request altmode notifications: -125

> It would also be nice, just for completeness sake to rule out that you
> do not get a call to qcom_glink_intent_req_abort() here.

And I'm not seeing this function being called.

Johan

