Return-Path: <linux-pm+bounces-12537-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11C33957FE7
	for <lists+linux-pm@lfdr.de>; Tue, 20 Aug 2024 09:36:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBEFF1F216B7
	for <lists+linux-pm@lfdr.de>; Tue, 20 Aug 2024 07:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54A36189B96;
	Tue, 20 Aug 2024 07:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NLG8ZfDT"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 225381667ED;
	Tue, 20 Aug 2024 07:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724139318; cv=none; b=nc+4wyUzSsWJygVwJis4XPpNBemqnaZOXyk9K70TlLS8VKfYDs01E2S2OhZryPGn739Bi2yderjQW8AMuG/y17J7IH+tRTuoPJVK5xRh2s/COgNcgMjiEPlq8XwgKS7altt2dM4T9bmzleg45UCNrb4NKu/rMQD0ghsv5J/+CS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724139318; c=relaxed/simple;
	bh=VlFp3AV+5ntIAXoC1p5XsTcSavlW4JGSdKmcfmgxiA4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I9jagB0+xeQvqzb1gaLpofObqSMjYRtDd/g4e9LDI4tqp7wCoHL/HjJtRHY9m+75VdCGc0DXhhyoBRMWKwfxwafGd+pDX/7bu65e4N1mEI98mSk7wqwwN3yVBW++A8I4DppCfalXPqHTcIAAF9Tc8R8/WmhMi6Y+xPgnkgDi3B8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NLG8ZfDT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E21F6C4AF09;
	Tue, 20 Aug 2024 07:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724139317;
	bh=VlFp3AV+5ntIAXoC1p5XsTcSavlW4JGSdKmcfmgxiA4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NLG8ZfDTt9MYyQTQ3bqC7GyppuVm23T4iHs6c/gwcMpKcxOdemVUGu26+W6mDF2bu
	 E3siv6F9F1jTR7H9av0b7G5EfNueVKZWMuaCcz6FCAHjw3FqsfXGgO7DWu5jhfq+u3
	 QIg4uoHC+L2wt4Pn7hPMg2qNw1vlE/qoeQk6oB6+M2RVEi2+EcO6OmMu33EcJXzUP1
	 w4MuSHe84DnLpkoj2GMck3hWYZ7SQ2DGnSN8XG+iNfhHHylRfiKHBY+C2E8su092iT
	 Cl70P842YearIv8oL1wKXb9zIOLSyY5/uraFBRFaZSz4A9Lm9FwrkC/rrwvzNfkstT
	 w46TW2PzUzDxg==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1sgJOe-000000005rZ-1Thw;
	Tue, 20 Aug 2024 09:35:16 +0200
Date: Tue, 20 Aug 2024 09:35:16 +0200
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
Message-ID: <ZsRHNIMy7KbCaE7x@hovoldconsulting.com>
References: <20240819-pmic-glink-v6-11-races-v2-0-88fe3ab1f0e2@quicinc.com>
 <20240819-pmic-glink-v6-11-races-v2-3-88fe3ab1f0e2@quicinc.com>
 <ZsRAnWgsoSHmrFE5@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZsRAnWgsoSHmrFE5@hovoldconsulting.com>

On Tue, Aug 20, 2024 at 09:07:10AM +0200, Johan Hovold wrote:
> On Mon, Aug 19, 2024 at 01:07:47PM -0700, Bjorn Andersson wrote:
> > When the pmic_glink state is UP and we either receive a protection-
> > domain (PD) notification indicating that the PD is going down, or that
> > the whole remoteproc is going down, it's expected that the pmic_glink
> > client instances are notified that their function has gone DOWN.
> > 
> > This is not what the code does, which results in the client state either
> > not updating, or being wrong in many cases. So let's fix the conditions.

And I believe you meant

	s/with/when/

in the patch Subject.

Johan

