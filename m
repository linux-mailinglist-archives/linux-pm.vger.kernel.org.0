Return-Path: <linux-pm+bounces-31640-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42F37B168C7
	for <lists+linux-pm@lfdr.de>; Thu, 31 Jul 2025 00:02:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78235581171
	for <lists+linux-pm@lfdr.de>; Wed, 30 Jul 2025 22:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2726219A91;
	Wed, 30 Jul 2025 22:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lZC8/ua1"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE3119E7D0;
	Wed, 30 Jul 2025 22:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753912918; cv=none; b=gnvRX4gsNw/uaxkvCQPh2DG5iT9N9+WAGC6nRx90q2M4mc/8XMBakOGqmiFH0QIl/NTT69nKM4SL2f/dNC33RfDU0tvvZ8nRCEJkEBtZa3E1GFmD8AnLY6Fv0ZZfwJmAmZDy3tiAfdts/WiJbpUCoH2oLjCHeTKZ0lsMLJtY6Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753912918; c=relaxed/simple;
	bh=dBWKuAZUqucrtubWvOuTWbSHSMH3WMeAyjJSnKZN5Yk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hQN0Ekh8fhGyaiJfGeBVH7Qyaym2ann7Iz/78x23pGXLDBQRPJUQqzVR4j/cpfYkkA6+51ATw0l/9hpq6hkNGiYjpUd7L+AMw6j8zN1aKBxH8DYXZujaMSuRnZQcoinR3sJtqgH5ZWIA9HHfVMXkWvExwk50lAvo0H5oxdP4eU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lZC8/ua1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF87CC4CEE3;
	Wed, 30 Jul 2025 22:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753912918;
	bh=dBWKuAZUqucrtubWvOuTWbSHSMH3WMeAyjJSnKZN5Yk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lZC8/ua1UbMdOJ/AbpPEroHggBmGKKwhKuA7dZUFjHJ3vJBuRUcTzDiSbLEQT9XjG
	 Z8e8N/vL0MT8+gBYdFE4kGcovUG9h4des+uS8jB5UXYwFeDjizzWlvBZFdDPCc0PSO
	 6KK/OZfiY0fEzXdp5K+2XYDlN7tJ/evus8vt3HZUWyLTq/kGedewOdSVoGehtjLA+5
	 w7IMI0ZoPD5VsaALfm7oCdOZO+oxc8mE+0+1WqsxoxRih3yOzuN1mYmKstPoUgNZJ1
	 Zu7GjCPG0rpn5/t/vCj4ArDfDvBkn1hN7evgdHmOxShtbpWask2gRFdSln1p96WPgz
	 vzY2Yq6dcBLJg==
Date: Wed, 30 Jul 2025 17:01:57 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Konrad Dybcio <konradybcio@kernel.org>
Cc: Andy Gross <andy.gross@linaro.org>, Jonathan Marek <jonathan@marek.ca>,
	Dmitry Baryshkov <lumag@kernel.org>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	Vinod Koul <vkoul@kernel.org>, cros-qcom-dts-watchers@chromium.org,
	Taniya Das <quic_tdas@quicinc.com>,
	Johan Hovold <johan+linaro@kernel.org>,
	Ajit Pandey <quic_ajipan@quicinc.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-clk@vger.kernel.org,
	Akhil P Oommen <akhilpo@oss.qualcomm.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	linux-kernel@vger.kernel.org,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Douglas Anderson <dianders@chromium.org>,
	Jagadeesh Kona <quic_jkona@quicinc.com>,
	Luca Weiss <luca.weiss@fairphone.com>,
	Imran Shaik <quic_imrashai@quicinc.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-pm@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>,
	Richard Acayan <mailingradian@gmail.com>,
	devicetree@vger.kernel.org,
	Taniya Das <taniya.das@oss.qualcomm.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH RFC 01/24] dt-bindings: power: qcom,rpmpd: Add
 SC8280XP_MXC_AO
Message-ID: <175391291654.1775434.8170537276604254922.robh@kernel.org>
References: <20250728-topic-gpucc_power_plumbing-v1-0-09c2480fe3e6@oss.qualcomm.com>
 <20250728-topic-gpucc_power_plumbing-v1-1-09c2480fe3e6@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250728-topic-gpucc_power_plumbing-v1-1-09c2480fe3e6@oss.qualcomm.com>


On Mon, 28 Jul 2025 18:16:01 +0200, Konrad Dybcio wrote:
> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> 
> Not sure how useful it's gonna be in practice, but the definition is
> missing (unlike the previously-unused SC8280XP_MXC-non-_AO), so add it
> to allow the driver to create the corresponding pmdomain.
> 
> Fixes: dbfb5f94e084 ("dt-bindings: power: rpmpd: Add sc8280xp RPMh power-domains")
> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> ---
>  include/dt-bindings/power/qcom-rpmpd.h | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


