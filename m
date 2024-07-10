Return-Path: <linux-pm+bounces-10937-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0105792D569
	for <lists+linux-pm@lfdr.de>; Wed, 10 Jul 2024 17:54:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1B0A283886
	for <lists+linux-pm@lfdr.de>; Wed, 10 Jul 2024 15:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64A03194A62;
	Wed, 10 Jul 2024 15:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mIP5lwrV"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC7E194135;
	Wed, 10 Jul 2024 15:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720626876; cv=none; b=DHSmxVGTf0Dj0jTxIabZnB4GU6GmJOBfO2WgqpvDAbpePEpUhiiNxtcBue1yXWRoRLUxw3I9GnFSXj97FSie0wa9SEAZ8embOsKrigWOxS3wJZjQ3o80jVqty6vebZzhI9LptaO6AYSQwrsofpfh/RHPFZ3/VSH080xTXRF49vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720626876; c=relaxed/simple;
	bh=Xhl6yW2VQ6hvwt67WTdZt+JNLP73wtB47sYfqu1Fp0I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uvpQDby+ERuweCJuVUmLP9OBPNt2/SaIIjH4vNAM/Cu8o1RSftsGNu6PN09Adiy9uK7Z6I3Ynr1U+F0zbkAXOCXKA1HwO4GszaiulqLzHflwNi3n+lbPgz35JGrik20SAV6ixUkNnzC4HKcQhAetnfpE4pDVpRz/awydQbF9edc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mIP5lwrV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22C5FC4AF09;
	Wed, 10 Jul 2024 15:54:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720626875;
	bh=Xhl6yW2VQ6hvwt67WTdZt+JNLP73wtB47sYfqu1Fp0I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mIP5lwrV5IIPUUZbRfbxZfu4lA2AyMqAVBxwrpi/aJO2nku5AP94HWCbGzSPj4SMi
	 SZhIqk4vlW3Vb2P0k3lCVR9ZaL2MKIQsY3z9zGyYjgXmeHDFBobmK+CJQx3UXi2MN5
	 tEeLJpklUkpvHJDCFQK1Obg+0vjuXhvvOT09r3rR8riNOUde/+EhU0sya8KriXdpQp
	 AjB4Z3JfXYhe9mfKDhM6bqdl96usoLjV7m2Ix7kbt8tgv9iZ7wJz1gmxJV6JR/Fxpd
	 cjwS33cyc4xIfKYGq7vDVB+/2b31zz9ftlLVr/8QeFiqllfCK+t6fmgm2mMwzjyvqN
	 o6YPgbSZM+9jg==
Date: Wed, 10 Jul 2024 09:54:24 -0600
From: Rob Herring <robh@kernel.org>
To: Adam Skladowski <a39.skl@gmail.com>
Cc: phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
	Georgi Djakov <djakov@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Vladimir Lypak <vladimir.lypak@gmail.com>,
	Rajendra Nayak <quic_rjendra@quicinc.com>,
	Rohit Agarwal <quic_rohiagar@quicinc.com>,
	Danila Tikhonov <danila@jiaxyga.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Stephan Gerhold <stephan.gerhold@kernkonzept.com>,
	Andrew Halaney <ahalaney@redhat.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Barnabas Czeman <barnabas.czeman@mainlining.org>,
	linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Abel Vesa <abel.vesa@linaro.org>
Subject: Re: [PATCH v3 1/9] dt-bindings: interconnect: qcom: Add Qualcomm
 MSM8976 NoC
Message-ID: <20240710155424.GA3133981-robh@kernel.org>
References: <20240709102728.15349-1-a39.skl@gmail.com>
 <20240709102728.15349-2-a39.skl@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240709102728.15349-2-a39.skl@gmail.com>

On Tue, Jul 09, 2024 at 12:22:46PM +0200, Adam Skladowski wrote:
> Add bindings for Qualcomm MSM8976 Network-On-Chip interconnect devices.
> 
> Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
> ---
>  .../bindings/interconnect/qcom,msm8939.yaml   | 15 ++-
>  .../dt-bindings/interconnect/qcom,msm8976.h   | 97 +++++++++++++++++++
>  2 files changed, 107 insertions(+), 5 deletions(-)
>  create mode 100644 include/dt-bindings/interconnect/qcom,msm8976.h

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

