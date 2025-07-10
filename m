Return-Path: <linux-pm+bounces-30646-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D6A21B00F17
	for <lists+linux-pm@lfdr.de>; Fri, 11 Jul 2025 00:54:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6C085A7E96
	for <lists+linux-pm@lfdr.de>; Thu, 10 Jul 2025 22:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEF4D29AB16;
	Thu, 10 Jul 2025 22:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fDAIM/Mi"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9C92397A4;
	Thu, 10 Jul 2025 22:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752188053; cv=none; b=dcFtLewLbHQRuah9/feBn0pK1vmT4QtkKeVZqUUbG4NSY3XjrGR40P+sx8nK2OmSWdcsPCtKzCoWWsUF40shXvnaH6JLg7Qu7Tx83DvsWnloNLMRLptoVvq3UTc0tZFuYS3JJk1YCakO9XR7hgyQ/kZmyYnnZsNW9wTPIum3MGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752188053; c=relaxed/simple;
	bh=C7sffkGR58/skNSnCNft/CdSrVspgq92A+XoY08I7pw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fJuWs9XFzkIZd4pN792Y+QgWyVkOuuuogp1lIZUAY6/bioEEdjPQX0GAI0kAhZaDFAOQfbgTOcQboGklw9+JPQHQQQNZFL/ilsIZvoQia5UqKvehAhpeEVnPZUtQ7vk+Yu0nzYyaARvca0CwzzuZNmDAt87GRyimeyirNQbxV+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fDAIM/Mi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2437C4CEE3;
	Thu, 10 Jul 2025 22:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752188053;
	bh=C7sffkGR58/skNSnCNft/CdSrVspgq92A+XoY08I7pw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fDAIM/Mi+/m+JpTdV/OxxbHepVbjHZLt3Whl3McL7s9TFF1pDcA38Va/dah89aGws
	 TYq9f0nd2OrOBVJrgoDj+aYmAamLCfAobDzl4z68SrCYH9YQ0XqklhxA4oqJUMBnf+
	 VNAg0oGNk2zSR7G3NV+5Rgmr1rzj2DWuqFvSCVm1bFwl1ekuW/vbOhgELK4jWPySIw
	 RJJEOPN6jTNAWAceKWQnYM9uB1Mk3v6dLz9KfMMAQsAgUnKFbK2UUP0avIv2mJ4ig2
	 ilq/2ANmEKeHVYoHYqfzbubLA5zRDtv0ow6YQ7YTpgYziaY65zhqLs+6gfwUzNEEe1
	 7NlLf9rVs1WjA==
Date: Thu, 10 Jul 2025 17:54:12 -0500
From: Rob Herring <robh@kernel.org>
To: Luo Jie <quic_luoj@quicinc.com>
Cc: Georgi Djakov <djakov@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Anusha Rao <quic_anusha@quicinc.com>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Richard Cochran <richardcochran@gmail.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	quic_kkumarcs@quicinc.com, quic_linchen@quicinc.com,
	quic_leiwei@quicinc.com, quic_pavir@quicinc.com,
	quic_suruchia@quicinc.com
Subject: Re: [PATCH v3 05/10] dt-bindings: clock: ipq9574: Rename NSS CC
 source clocks to drop rate
Message-ID: <20250710225412.GA25762-robh@kernel.org>
References: <20250710-qcom_ipq5424_nsscc-v3-0-f149dc461212@quicinc.com>
 <20250710-qcom_ipq5424_nsscc-v3-5-f149dc461212@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250710-qcom_ipq5424_nsscc-v3-5-f149dc461212@quicinc.com>

On Thu, Jul 10, 2025 at 08:28:13PM +0800, Luo Jie wrote:
> Drop the clock rate suffix from the NSS Clock Controller clock names for
> PPE and NSS clocks. A generic name allows for easier extension of support
> to additional SoCs that utilize same hardware design.

This is an ABI change. You must state that here and provide a reason the 
change is okay (assuming it is). Otherwise, you are stuck with the name 
even if not optimal.

> 
> Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
> ---
>  .../devicetree/bindings/clock/qcom,ipq9574-nsscc.yaml        | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/clock/qcom,ipq9574-nsscc.yaml b/Documentation/devicetree/bindings/clock/qcom,ipq9574-nsscc.yaml
> index 17252b6ea3be..b9ca69172adc 100644
> --- a/Documentation/devicetree/bindings/clock/qcom,ipq9574-nsscc.yaml
> +++ b/Documentation/devicetree/bindings/clock/qcom,ipq9574-nsscc.yaml
> @@ -25,8 +25,8 @@ properties:
>    clocks:
>      items:
>        - description: Board XO source
> -      - description: CMN_PLL NSS 1200MHz (Bias PLL cc) clock source
> -      - description: CMN_PLL PPE 353MHz (Bias PLL ubi nc) clock source
> +      - description: CMN_PLL NSS (Bias PLL cc) clock source
> +      - description: CMN_PLL PPE (Bias PLL ubi nc) clock source
>        - description: GCC GPLL0 OUT AUX clock source
>        - description: Uniphy0 NSS Rx clock source
>        - description: Uniphy0 NSS Tx clock source
> @@ -42,8 +42,8 @@ properties:
>    clock-names:
>      items:
>        - const: xo
> -      - const: nss_1200
> -      - const: ppe_353
> +      - const: nss
> +      - const: ppe
>        - const: gpll0_out
>        - const: uniphy0_rx
>        - const: uniphy0_tx
> @@ -82,8 +82,8 @@ examples:
>                 <&uniphy 5>,
>                 <&gcc GCC_NSSCC_CLK>;
>        clock-names = "xo",
> -                    "nss_1200",
> -                    "ppe_353",
> +                    "nss",
> +                    "ppe",
>                      "gpll0_out",
>                      "uniphy0_rx",
>                      "uniphy0_tx",
> 
> -- 
> 2.34.1
> 

