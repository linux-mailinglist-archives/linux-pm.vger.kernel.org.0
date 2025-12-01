Return-Path: <linux-pm+bounces-39012-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D651AC98FAB
	for <lists+linux-pm@lfdr.de>; Mon, 01 Dec 2025 21:14:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 856493A3FA1
	for <lists+linux-pm@lfdr.de>; Mon,  1 Dec 2025 20:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E499260578;
	Mon,  1 Dec 2025 20:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IndXaRzx"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C6A248F6A;
	Mon,  1 Dec 2025 20:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764620082; cv=none; b=ashUvxqusP/WRE/1h9WV+iHcNp3TZXzwRFvPgqupEQMHB8b+hCXXUFicwifQmXhSCtQLUBiqZCNK51cC6B/IhW5SKJtQYhpY6OP+IPE6rrLn6gh/h/JBBWad3ufzmsI0/K5OxrrcQO3/95yJmCbPDzCaQ0GZONXhe6JQk/2UXnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764620082; c=relaxed/simple;
	bh=KdTQM2498wHob4LHPdfu7J0oIGz3l16QRf0Ft8fUkfk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hgD2WxP0n9k9HJ6uqgGjPQvFCHWsW44oy1OE+YLQ0Jwmz2vyrb2kS8D6NaNrGZGxiAwpUk9c+RcS0kjNjzshMUDIJcvFpWezLRCLD82jBILAEn0MCddCY9h6PbLbyu/HfjXN3U5YQGn/emWKgy1fuJQqGZMxZ35ZmPEq09IHSyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IndXaRzx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACDB6C4CEF1;
	Mon,  1 Dec 2025 20:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764620081;
	bh=KdTQM2498wHob4LHPdfu7J0oIGz3l16QRf0Ft8fUkfk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IndXaRzxvPhp5ZhUqhXn8DNLU02m9BsYeXhVml6j0shwKXGF5yHP+d5Owb8oapETz
	 C9seo/D1A87IhKS5ekXezPWlj83n9Q9uCNc1AKfp9QGuGolvDlwE0Aw5k49RjXtUO6
	 LeGceweGyj2p3ZQINGC4I6qDvn9CPv6SF65H5W3fTuw+d6aHPEFb9aUfSc/NSNcA0d
	 n2b35O1u6fwxTIsr2FP7+qlwQg/g+30urT9ncbGb3rhLDfPTECxkEJk/tNcJY0sPZI
	 dbyt4JgDevx/nGSTNB2CudZ5sSvEw7SMSd6HVF8xBzVl2riQHUgfPu6d4VEvNgCkBx
	 4vmfs+zMX2ZpQ==
Date: Mon, 1 Dec 2025 14:14:40 -0600
From: Rob Herring <robh@kernel.org>
To: Bjorn Andersson <andersson@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Johan Hovold <johan+linaro@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Taniya Das <quic_tdas@quicinc.com>,
	Imran Shaik <quic_imrashai@quicinc.com>,
	Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
	Jagadeesh Kona <quic_jkona@quicinc.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org,
	linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: Re: (subset) [PATCH 0/5] Define VDD_MXC for SC8280XP
Message-ID: <20251201201440.GA4041208-robh@kernel.org>
References: <20251104-topic-8280_mxc-v1-0-df545af0ef94@oss.qualcomm.com>
 <176418784438.1591314.8587929353938909456.b4-ty@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <176418784438.1591314.8587929353938909456.b4-ty@kernel.org>

On Wed, Nov 26, 2025 at 02:10:41PM -0600, Bjorn Andersson wrote:
> 
> On Tue, 04 Nov 2025 20:31:05 +0100, Konrad Dybcio wrote:
> > This has somehow been omitted, leading to potentially stale votes.
> > On the flip side, the domain will now be powered off, which will
> > uncover any omissions we've made in the DTs so far.
> > 
> > Reasonably tested on an x13s without pd_ignore_unused (camera still
> > works).
> > 
> > [...]
> 
> Applied, thanks!
> 
> [2/5] dt-bindings: remoteproc: qcom,sc8280xp-pas: Fix CDSP power desc
>       commit: ca079ec3ebed19a12c1bf080496dacbc6fdfbb39

This has was picked up, but the .dts change was not, so there's a bunch 
of new warnings. What's the plan? I know it's separate trees. Can you 
please take binding and .dts changes like these together if there aren't 
driver changes?

Rob

