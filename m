Return-Path: <linux-pm+bounces-15464-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1925D998CA2
	for <lists+linux-pm@lfdr.de>; Thu, 10 Oct 2024 18:02:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8216B33876
	for <lists+linux-pm@lfdr.de>; Thu, 10 Oct 2024 15:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 121511E6325;
	Thu, 10 Oct 2024 14:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="di3Ac3an"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79741E5739;
	Thu, 10 Oct 2024 14:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728572333; cv=none; b=TxgpbgEw2c6B2QM0K1xDkKvTAKOtRDSGMeqguZT60SeXzEXuohfhU35yVeKYU/67z2iJpQRtdP82ADk6rcpAud9ZBlE83bm56Hj4HC5t7RmJWA7n7j7vwJce41bjI5crvMOeUu5yRSE4UGW7oRZWbjoWyxW9+nns9bNMJuSGgVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728572333; c=relaxed/simple;
	bh=0ntxlVbL7AwlKUL+Ah0u2q6ZfGm76Q4wqlfGG851Afg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qk2Y/2S0mu69hFf8yQpadhi45Yk3PkPsNi8wp/IPwu5JaU7sRDLaAunYaUu/+gjrEoJ8+9YSSd65BLEsqIJ8ESOICuIMQ2vMlz3xRP9PiGCX2KDU4d+WTnCHwU7eXeoBLlmMNs7Er2I5bN36BHPBHOY7VAPmsNH+po+MinzZyF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=di3Ac3an; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D8A2C4CEC5;
	Thu, 10 Oct 2024 14:58:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728572332;
	bh=0ntxlVbL7AwlKUL+Ah0u2q6ZfGm76Q4wqlfGG851Afg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=di3Ac3anIL7IMAXyxyl1+2FJGlAa1zYsbQJ1X7DPOHs236t9FG/rwtSLe1Y+3ifBy
	 s9CHwWUSEU5X0gFs+9oF8wkZM91ykCPR0o2NmTieyIu29xHsanchEGTlkEImbmdJDr
	 jwoHblDYJOIcNkazjpSRYXRoA/Erh+WhFt9TsKNlH7GQJwEkfNqeE9+zTXu/+ctdLK
	 qa3wxvQyJs+UZOcIz0D8nXW4zIKPoE1p30PNX8PJqTzbHJjWjZlVS1EzdCVK/ElG2n
	 OH95QxslnjxNDFIg/dlzJUuKb2QQIGdGoClO1jlwZLVvjHOWGYQ4zxmYnac4aiyeFr
	 TUCdSyWJKct9A==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1syucz-00000000816-09kP;
	Thu, 10 Oct 2024 16:58:57 +0200
Date: Thu, 10 Oct 2024 16:58:57 +0200
From: Johan Hovold <johan@kernel.org>
To: Sibi Sankar <quic_sibis@quicinc.com>
Cc: sudeep.holla@arm.com, cristian.marussi@arm.com, ulf.hansson@linaro.org,
	jassisinghbrar@gmail.com, linux-kernel@vger.kernel.org,
	arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-arm-msm@vger.kernel.org, konradybcio@kernel.org,
	linux-pm@vger.kernel.org, tstrudel@google.com, rafael@kernel.org,
	Johan Hovold <johan+linaro@kernel.org>
Subject: Re: [PATCH V3 4/4] mailbox: qcom-cpucp: Mark the irq with
 IRQF_NO_SUSPEND flag
Message-ID: <ZwfrsVBSstffJWqp@hovoldconsulting.com>
References: <20241007060642.1978049-1-quic_sibis@quicinc.com>
 <20241007060642.1978049-5-quic_sibis@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241007060642.1978049-5-quic_sibis@quicinc.com>

On Mon, Oct 07, 2024 at 11:36:42AM +0530, Sibi Sankar wrote:
> The qcom-cpucp mailbox irq is expected to function during suspend-resume
> cycle particularly when the scmi cpufreq driver can query the current
> frequency using the get_level message after the cpus are brought up during
> resume. Hence mark the irq with IRQF_NO_SUSPEND flag to fix the do_xfer
> failures we see during resume.
> 
> Err Logs:
> arm-scmi firmware:scmi: timed out in resp(caller:do_xfer+0x164/0x568)
> cpufreq: cpufreq_online: ->get() failed
> 
> Reported-by: Johan Hovold <johan+linaro@kernel.org>
> Closes: https://lore.kernel.org/lkml/ZtgFj1y5ggipgEOS@hovoldconsulting.com/
> Fixes: 0e2a9a03106c ("mailbox: Add support for QTI CPUCP mailbox controller")
> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>

Seems to work as intended:

Tested-by: Johan Hovold <johan+linaro@kernel.org>

Johan

