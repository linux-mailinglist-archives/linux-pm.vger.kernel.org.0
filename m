Return-Path: <linux-pm+bounces-35656-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C599DBB23C8
	for <lists+linux-pm@lfdr.de>; Thu, 02 Oct 2025 03:15:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6344319E00CD
	for <lists+linux-pm@lfdr.de>; Thu,  2 Oct 2025 01:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5AD85464D;
	Thu,  2 Oct 2025 01:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ojSiId7B"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A10D5224F6;
	Thu,  2 Oct 2025 01:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759367738; cv=none; b=A6XdMEdUl7YY5TOJ/z8ZK29t5LVleDjQsdOYnP7WirRjfwQyRWz8OK5zUoTYTcy/ZXwqBWlOzsjsmEQjK+wcEqwJ+YsICOeGxWnKPWPPetekX9ZE0mUMfK4DC2516CGk1luGxy/U8R7yQ4rj1FvoWTVg2jPb1DMPK6zkSrNBzBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759367738; c=relaxed/simple;
	bh=ybWFhd4Bl669wN6zdk9DEt87ykdf3WJUYTYkdhjzDkI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jf8cjtpGr7dBQXRfXDF3XMyut4s8qLe+tgr7oEAnNaGK59eYfjIjGOqkokCmS0oXX6JYxdMGDqCDLsE0BQDBmKzf5n9OXmblqlRUXtwPeMAAYCba+aGKYk50ep+x5fghFB7tKHiH60G7CH6IXjuKTY9wgloLlXPPNoIhozW5WD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ojSiId7B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2B43C4CEF1;
	Thu,  2 Oct 2025 01:15:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759367738;
	bh=ybWFhd4Bl669wN6zdk9DEt87ykdf3WJUYTYkdhjzDkI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ojSiId7BoaS8UNz6oiQJrQVUImuzaY/mzCOniA7rvODFJU4GAwUFv3dAgCJ9KmWI9
	 1rb7vwOLVXCWEKDPZVA/QFcQ8hNXvZwihE9EUDqzN0i0LGKz3mZuFkIl+BeojgiBCU
	 6foF4q0z6vt1vPHkePosD2qlYpq2eRtrg4Yc8uAvb+RdqD/+Kaq6mAQj3hAwsvJkjt
	 3azSV6vbvVsz+lvu0jLtVusygK4HGehccP5CclvEsKavXAfPgmSPpGgH6h/OOEfeBH
	 Uz3jG6rmCjTj3suHzJb09+WYEWjJH3rEfjUL2aKnnt+rELnYhKCKu0hL7aghTc4jW8
	 qhgxpAinpzLCQ==
Date: Wed, 1 Oct 2025 20:15:36 -0500
From: Rob Herring <robh@kernel.org>
To: Luo Jie <quic_luoj@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Varadarajan Narayanan <quic_varada@quicinc.com>,
	Georgi Djakov <djakov@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Anusha Rao <quic_anusha@quicinc.com>,
	Manikanta Mylavarapu <quic_mmanikan@quicinc.com>,
	Devi Priya <quic_devipriy@quicinc.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Richard Cochran <richardcochran@gmail.com>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, linux-arm-msm@vger.kernel.org,
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	quic_kkumarcs@quicinc.com, quic_linchen@quicinc.com,
	quic_leiwei@quicinc.com, quic_pavir@quicinc.com,
	quic_suruchia@quicinc.com
Subject: Re: [PATCH v6 02/10] dt-bindings: clock: Add "interconnect-cells"
 property in IPQ9574 example
Message-ID: <20251002011536.GA2828951-robh@kernel.org>
References: <20250925-qcom_ipq5424_nsscc-v6-0-7fad69b14358@quicinc.com>
 <20250925-qcom_ipq5424_nsscc-v6-2-7fad69b14358@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250925-qcom_ipq5424_nsscc-v6-2-7fad69b14358@quicinc.com>

On Thu, Sep 25, 2025 at 10:05:36PM +0800, Luo Jie wrote:
> The Networking Subsystem (NSS) clock controller acts as both a clock
> provider and an interconnect provider. The #interconnect-cells property
> is needed in the Device Tree Source (DTS) to ensure that client drivers
> such as the PPE driver can correctly acquire ICC clocks from the NSS ICC
> provider.
> 
> Add the #interconnect-cells property to the IPQ9574 Device Tree binding
> example to complete it.

The subject is wrong as it #interconnect-cells, not interconnect-cells.

> 
> Fixes: 28300ecedce4 ("dt-bindings: clock: Add ipq9574 NSSCC clock and reset definitions")
> Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
> ---
>  Documentation/devicetree/bindings/clock/qcom,ipq9574-nsscc.yaml | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Rob Herring (Arm) <robh@kernel.org>

