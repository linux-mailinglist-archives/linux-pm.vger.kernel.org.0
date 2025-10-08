Return-Path: <linux-pm+bounces-35815-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63D76BC52E9
	for <lists+linux-pm@lfdr.de>; Wed, 08 Oct 2025 15:24:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 290CC19E198D
	for <lists+linux-pm@lfdr.de>; Wed,  8 Oct 2025 13:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4527284B2F;
	Wed,  8 Oct 2025 13:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nha433Rr"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B92284687;
	Wed,  8 Oct 2025 13:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759929882; cv=none; b=mDdGdctvU2E/p57jeKUET9ng7HEtFK+8EHaa4M+a0GcgsnTPk07JkPaWIZgNMA7eZqMdC1qnNAIDMFxj8JoBhEDiYVScVgfSrebu0p9kS3fw0o4UDPzQpFVi3fQdsJBfYtmigZkyQGD5x5YcqfCFGepbZbQz4nRRBM0MO12KbMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759929882; c=relaxed/simple;
	bh=OEKwf/lJbfWfeTbtO3uye9fKkC4WSWmsENdmeL4Y6Jo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lRYFC41TUPCj5MoqncoUJm4tinbRmzhRgJCjVRkUe8GfM3kSzh3wNl6IxHAIs91JufOxPDsFAgXFz3ISHfXL39s3UiAgllQAsNvTQ7ldliisWS77eqv0bNE0mJSvWNiSSzSwYrhufNjblYY7y447UCpmK00c83/6w5Sbs83Hhlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nha433Rr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF175C4CEF4;
	Wed,  8 Oct 2025 13:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759929882;
	bh=OEKwf/lJbfWfeTbtO3uye9fKkC4WSWmsENdmeL4Y6Jo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nha433Rrur5rkFpNoJDDGt3hljCGxefWJjlQ59/V7PVnknhbCUIekG16k2ME9sX2R
	 ETQ8dgqFgiB3ij8VO16cK0P503S6iYx/myJZvJBvrkzqWXyYX7wMUvv7iwknyyjjTv
	 4gYIZSll3jQdwQmbybSRY0wq8kpYJmzf6kLfoBU2w5qFyuTaoiaxLzTtSR0hKducOq
	 02jnsRN8ESTLGYk6D0pTss2I5qy2WcHppaLREmuDM+mSkSEY0i1iXNIi7AprcrETQO
	 cjHL5+isxIA2Vwf5Bho3h2eXfeLetaphlIzQoVnrrmfiKhjeT+GUM03eGIo9owraLQ
	 XzkcULFqXCojA==
Date: Wed, 8 Oct 2025 08:24:40 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-kernel@vger.kernel.org,
	Konrad Dybcio <konradybcio@kernel.org>,
	Georgi Djakov <djakov@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	devicetree@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	Mike Tipton <mike.tipton@oss.qualcomm.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: interconnect: add reg and clocks
 properties to enable QoS on sa8775p
Message-ID: <175992988039.3401317.7332721222365860442.robh@kernel.org>
References: <20251001073344.6599-1-odelu.kukatla@oss.qualcomm.com>
 <20251001073344.6599-2-odelu.kukatla@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251001073344.6599-2-odelu.kukatla@oss.qualcomm.com>


On Wed, 01 Oct 2025 13:03:42 +0530, Odelu Kukatla wrote:
> Add 'reg' and 'clocks' properties to enable QoS configuration. These
> properties enable access to QoS registers and necessary clocks for
> configuration.
> 
> QoS configuration is essential for ensuring that latency sensitive
> components such as CPUs and multimedia engines receive prioritized
> access to memory and interconnect resources. This helps to manage
> bandwidth and latency across subsystems, improving system responsiveness
> and performance in concurrent workloads.
> 
> Both 'reg' and 'clocks' properties are optional. If either is missing,
> QoS configuration will be skipped. This behavior is controlled by the
> 'qos_requires_clocks' flag in the driver, which ensures that QoS
> configuration is bypassed when required clocks are not defined.
> 
> Signed-off-by: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
> ---
>  .../interconnect/qcom,sa8775p-rpmh.yaml       | 50 ++++++++++++++++++-
>  1 file changed, 49 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


