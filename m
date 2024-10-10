Return-Path: <linux-pm+bounces-15463-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2CBA998AC3
	for <lists+linux-pm@lfdr.de>; Thu, 10 Oct 2024 17:01:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 874941F2747F
	for <lists+linux-pm@lfdr.de>; Thu, 10 Oct 2024 15:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23C041CF28E;
	Thu, 10 Oct 2024 14:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tvL4wljr"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5ED81CEAD8;
	Thu, 10 Oct 2024 14:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728572144; cv=none; b=FKTiuUzIdyIyfYxtH7HP9r0n8D8Ne+09XMXk+7V6VrmZgfMBFcuKOuJofVNd2dGvnJuBZGeYJl5ygHeFo4m4E8UycQWVEaT5m0fBEuazY26bXkPJI0SqEDlBzv4ShDCYStUrnnPDMtRwoM08b9Jbxg7Ke6V0SkgZAGCtBr0tQAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728572144; c=relaxed/simple;
	bh=w5s9c0gsUyZAb1duuICYtgix8lgm5eDU7I4/CwJW6Kc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pbYnTdyV41+g+IaLfwtSSZs9sjIkgBV048SAtNCEcLlnsL0+GUXIJE+gZCwvX1DklIlxRlYQuclhFOFxxT/900pMf1pAs//euU1zlYTHAzUOwNJQoc6bVEp3oOt3jwkMizZFC2gF5F4RakSdluU30JWA6Y2zEXmiDWXOs6g2HIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tvL4wljr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6876DC4CEC5;
	Thu, 10 Oct 2024 14:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728572143;
	bh=w5s9c0gsUyZAb1duuICYtgix8lgm5eDU7I4/CwJW6Kc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tvL4wljrUPmcLEINB9jWM9y3BseA1V5ZXHgtB69KejDi2iJg+PscHYMxEUjmE3p54
	 jSKKIQISe+YUh8Cm+isA+mVA9GsZaJbNTc4QuxEwdcRs9s2rPrxT4I1O8JPGqEmUTb
	 0gMk5Yk0Ah6UquDUsxZIapMSWe8cRDVlC9a2XSNbWKmhNL1+yIKG/jQY9j84e8JIJL
	 5d6lX6appzVPcDKIrTHzSZTNcX+Peb1CCUGgoSN9thX+nzNpNp3x0mlquCE+Q1EqnS
	 zRI6CgCQK1mlC3KftfmnmI04vpcmm/OQgQ3JHvlxQCRGIP/zrp9cj6iuML0VM1HeSN
	 +GghxeTXPDLew==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1syuZw-000000007yi-1IRM;
	Thu, 10 Oct 2024 16:55:48 +0200
Date: Thu, 10 Oct 2024 16:55:48 +0200
From: Johan Hovold <johan@kernel.org>
To: Sibi Sankar <quic_sibis@quicinc.com>
Cc: sudeep.holla@arm.com, cristian.marussi@arm.com, ulf.hansson@linaro.org,
	jassisinghbrar@gmail.com, linux-kernel@vger.kernel.org,
	arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-arm-msm@vger.kernel.org, konradybcio@kernel.org,
	linux-pm@vger.kernel.org, tstrudel@google.com, rafael@kernel.org,
	Johan Hovold <johan+linaro@kernel.org>
Subject: Re: [PATCH V3 1/4] firmware: arm_scmi: Ensure that the message-id
 supports fastchannel
Message-ID: <Zwfq9KYi04QkZBp1@hovoldconsulting.com>
References: <20241007060642.1978049-1-quic_sibis@quicinc.com>
 <20241007060642.1978049-2-quic_sibis@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241007060642.1978049-2-quic_sibis@quicinc.com>

On Mon, Oct 07, 2024 at 11:36:39AM +0530, Sibi Sankar wrote:
> Currently the perf and powercap protocol relies on the protocol domain
> attributes, which just ensures that one fastchannel per domain, before
> instantiating fastchannels for all possible message-ids. Fix this by
> ensuring that each message-id supports fastchannel before initialization.

Perhaps you could include the error message I reported here so that
anyone searching for that error will find this fix more easily.

> Reported-by: Johan Hovold <johan+linaro@kernel.org>
> Closes: https://lore.kernel.org/lkml/ZoQjAWse2YxwyRJv@hovoldconsulting.com/
> Fixes: 6f9ea4dabd2d ("firmware: arm_scmi: Generalize the fast channel support")
> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>

Do we want this to be backported as well so that you should add a
CC-stable tag?

Either way, this does seem to address the FC errors I reported:

Tested-by: Johan Hovold <johan+linaro@kernel.org>

Johan

