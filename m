Return-Path: <linux-pm+bounces-12518-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0330D957E5E
	for <lists+linux-pm@lfdr.de>; Tue, 20 Aug 2024 08:39:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 993641F21E87
	for <lists+linux-pm@lfdr.de>; Tue, 20 Aug 2024 06:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 856B21E7A3D;
	Tue, 20 Aug 2024 06:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V86hWq6S"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C69B1E7A2F;
	Tue, 20 Aug 2024 06:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724135681; cv=none; b=o3+pFwjLu0XWJPRgceENIEYNBLrBOoKAQsIRN9a2N1Fx4C5aqlSh7M2mWHSG2Fvr2x/nGnXtIqbP2rqB9GfUQdLA8EsTvb+gEJ6o5XDNwYxPEof0xJQBIrfCVFFV41Xs7sHlRz1BUblb2SICm3Snqp33YppI+KEi7EDMq3rmJnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724135681; c=relaxed/simple;
	bh=VYm9fAL+Q+/V8SYgqp/PLQTB8NVxzo9tKEdJNZio6Sw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OMtoo31i8SKt6fw77bwqarrfaLXBTLBRMmCQ+PcjpkFg0YNez+IC+enh8oEMW+8XHWyqvAphB2OEe9ct7M1ndtVH5AfHKoD8xTO3d4cMPJ0Hg35FXmUhI0p165l1QOKO3ClTh1KRqfeCx7MHM89//WC79TFYPboKxXPS6pnPui0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V86hWq6S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5D66C4AF09;
	Tue, 20 Aug 2024 06:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724135680;
	bh=VYm9fAL+Q+/V8SYgqp/PLQTB8NVxzo9tKEdJNZio6Sw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V86hWq6SYbgFePOxGJc1NOOq+AOy+A7HPeQRr2JIaHo817TJAFqli3mIFEAFeGnLb
	 KvNe2iOK6gZGR6td9Rzrkj9fSVlUAp7QdNT7CvMTRgmVXnBl2EtUCRAu6aF4TTKT6G
	 6/rkLuxhdaI5oEoShiY3XBHkOHbdUy+JYAlTyvf8DuTAic79TvP7hR1agTfmf4KQAq
	 Ij8FJnm/OqIeAgzyfBwgFhRTXF56ChXd/8xAAaxH5ELvGVEzSdph64gnXu8YPHDzom
	 p9sGmyqvaOynyPDTqpM4DxUZhlCOH2fWy+21abTy+NH/BFHI7Cc2bl8i+mrCyPJdb/
	 FKPwfvFc+7t5g==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1sgIRy-000000002Fl-19mi;
	Tue, 20 Aug 2024 08:34:38 +0200
Date: Tue, 20 Aug 2024 08:34:38 +0200
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
Message-ID: <ZsQ4_viDxMVu3Mho@hovoldconsulting.com>
References: <20240818-pmic-glink-v6-11-races-v1-0-f87c577e0bc9@quicinc.com>
 <20240818-pmic-glink-v6-11-races-v1-2-f87c577e0bc9@quicinc.com>
 <ZsNfkuiRK9VqBSLT@hovoldconsulting.com>
 <ZsN2qR3tuXylb2qK@hu-bjorande-lv.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZsN2qR3tuXylb2qK@hu-bjorande-lv.qualcomm.com>

On Mon, Aug 19, 2024 at 09:45:29AM -0700, Bjorn Andersson wrote:
> On Mon, Aug 19, 2024 at 05:06:58PM +0200, Johan Hovold wrote:
> > On Sun, Aug 18, 2024 at 04:17:38PM -0700, Bjorn Andersson wrote:
> > > Commit 'caa855189104 ("soc: qcom: pmic_glink: Fix race during
> > > initialization")' 
> > 
> > This commit does not exist, but I think you really meant to refer to
> > 
> > 	9329933699b3 ("soc: qcom: pmic_glink: Make client-lock non-sleeping")
> > 
> > and possibly also
> > 
> > 	635ce0db8956 ("soc: qcom: pmic_glink: don't traverse clients list without a lock")
> > 
> > here.
> > 
> 
> Yeah, I copy-pasted the wrong SHA1. Prior to commit 9329933699b3 ("soc:
> qcom: pmic_glink: Make client-lock non-sleeping") the PDR notification
> happened from a worker with only mutexes held.
> 
> > > moved the pmic_glink client list under a spinlock, as
> > > it is accessed by the rpmsg/glink callback, which in turn is invoked
> > > from IRQ context.
> > > 
> > > This means that ucsi_unregister() is now called from IRQ context, which
                                                           ^^^^^^^^^^^

> > > isn't feasible as it's expecting a sleepable context.
> > 
> > But this is not correct as you say above that the callback has always
> > been made in IRQ context. Then this bug has been there since the
> > introduction of the UCSI driver by commit
> > 
> 
> No, I'm stating that commit 9329933699b3 ("soc: qcom: pmic_glink: Make
> client-lock non-sleeping") was needed because the client list is
> traversed under the separate glink callback, which has always been made
> in IRQ context.

Ok, got it. But then you meant "atomic context", not "IRQ context", in
the paragraph above.

Johan

