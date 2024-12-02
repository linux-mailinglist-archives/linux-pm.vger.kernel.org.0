Return-Path: <linux-pm+bounces-18319-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B70DE9DFB91
	for <lists+linux-pm@lfdr.de>; Mon,  2 Dec 2024 09:01:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D810281BFB
	for <lists+linux-pm@lfdr.de>; Mon,  2 Dec 2024 08:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71B871F9406;
	Mon,  2 Dec 2024 08:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aiY8l3p7"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C80FF9E6;
	Mon,  2 Dec 2024 08:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733126459; cv=none; b=UvSOm9trZJG0mggzvHL523OYSGTN3ERITrZHJKgEiaW50brf4cCCQWxRyiaZUftAp4enUB9oPqCKGivrhnoqQdpNFduYSqbOILjt7XudVhP23J36kgUBx10nM1u4A5StWAyWGoJEZ5upsnl4yNI0D+lVB+GPOVY47P+XGb5iAD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733126459; c=relaxed/simple;
	bh=cKBxlD9oIvW3qwky/x/hjrqOR1DuqNbxWT7KDNIlPqM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qj7FO3SJvTecTZyMB/zTbIlN9j1heSKZFPxA4zDoVKV0MOAVOgvZRyIroSXAVyEMXMH44ASiadAf04tmsvj2A1aT8LpUf0WkPYQIpcd2uUu1O7HRhoEHecRY05MN/g9ac37+LY3wjYn4wBf5DL57oVSrrFA6TST3JQti30fI+Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aiY8l3p7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1EE0C4CED2;
	Mon,  2 Dec 2024 08:00:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733126458;
	bh=cKBxlD9oIvW3qwky/x/hjrqOR1DuqNbxWT7KDNIlPqM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aiY8l3p7SZwggHaDbYmUcdWfR2qpRzyaCyA2smpmjaSJOaJzSbz52hFbcDkUJLPRr
	 jRVOif4iR8t7lwZyFUhY2wEK78dx5LfjR/rktxJYWzcFQBFNRXnYZllTIBgdCisXNp
	 sBufH6nBla0vn/kL3m2C7El9KqxCWyXYCFT0n97nXS4QEyj2jqETc8fZiGJHreLKHB
	 W/V2aU6CPj6QFXEc+2KOdF4lV6C4MuI1Qx9921BN63gp01hA/ZhWAFzrXOZqkwWicW
	 xtlGcqfCqohFw1sy69tGNuJcmzSCvBhZ7HiCEzthaAqrcMSdJ8a9BTIbsrsaduF261
	 LlM20nHY4faPg==
Date: Mon, 2 Dec 2024 09:00:55 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Konrad Dybcio <konradybcio@kernel.org>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Ulf Hansson <ulf.hansson@linaro.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Marijn Suijten <marijn.suijten@somainline.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>, 
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH 1/2] dt-bindings: power: domain-idle-state: Allow
 idle-state-name
Message-ID: <ci253udczwm4ovo2prpbyuqd5d2x73t52auf7adyhlyzvuzkaf@v4krfcgcvrpu>
References: <20241130-topic-idle_state_name-v1-0-d0ff67b0c8e9@oss.qualcomm.com>
 <20241130-topic-idle_state_name-v1-1-d0ff67b0c8e9@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241130-topic-idle_state_name-v1-1-d0ff67b0c8e9@oss.qualcomm.com>

On Sat, Nov 30, 2024 at 05:39:36PM +0100, Konrad Dybcio wrote:
> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> 
> Allow specifying a name for idle states, similar to CPU idle states
> in cpu/idle-states.yaml
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> ---
>  Documentation/devicetree/bindings/power/domain-idle-state.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/power/domain-idle-state.yaml b/Documentation/devicetree/bindings/power/domain-idle-state.yaml
> index ec1f6f669e50b2e7b0756cb6a737c685ad81045b..4dd4f59bbbec3058cf20f064aeec4c9602a99eb7 100644
> --- a/Documentation/devicetree/bindings/power/domain-idle-state.yaml
> +++ b/Documentation/devicetree/bindings/power/domain-idle-state.yaml
> @@ -54,6 +54,11 @@ patternProperties:
>            (i.e. idle states node with entry-method property is set to "psci")
>            must specify this property.
>  
> +      idle-state-name:
> +        $ref: /schemas/types.yaml#/definitions/string
> +        description:
> +          A string used as a descriptive name for the idle state.

For user-visible strings we have 'label' property, but I see cpu idle
states already use this one, so I guess it is fine.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


