Return-Path: <linux-pm+bounces-20283-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BEEF5A0A7FF
	for <lists+linux-pm@lfdr.de>; Sun, 12 Jan 2025 10:32:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5C2A1887F66
	for <lists+linux-pm@lfdr.de>; Sun, 12 Jan 2025 09:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96EA118A950;
	Sun, 12 Jan 2025 09:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kz6NQmgC"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 626161CA81;
	Sun, 12 Jan 2025 09:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736674318; cv=none; b=s+oqFcOGvacSbwmuFxwEJY6NaEgBekfq3nsOJG2G1xdl0qBoOAproHwobliAl84AkX3LUZvXop//V6NfyPVnCXL0cMIu9KX2xaosiM46Tpq/eZemxeLMdTAUZ5sIi/vmi7qlt7MIlURwWiBHIp5N6m4NVLmLcSdb2UFQKndvFSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736674318; c=relaxed/simple;
	bh=AjigO0agJ3UHJw0Zlp986qjRtlPhraW94JcbdG07BBk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FuUHrILtOQCISjtV6AHmbq58Cyp3iHgVBOGsMsNK7FWo3TdfxILlFiX4+f/N2H9ciY9ZsthJ7l0df5Q5TzzbY1rdZ3Zv10Y2ct4mss7nbCRnCANlrm4YZvAR1x/no736SXH2tImyizk2lC9OdxPymjViSZ7i94EFhcrl//VRkaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kz6NQmgC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 114E8C4CEDF;
	Sun, 12 Jan 2025 09:31:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736674317;
	bh=AjigO0agJ3UHJw0Zlp986qjRtlPhraW94JcbdG07BBk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kz6NQmgCGeP60DLjdCrCrQxYOc83Ko6OTMuVbV1whuxJB/yOPS9HY3R4peT2uNnl+
	 TFeA6weJYEhqdgL0C/26cfI8OuNv98pnJefwDBGoC7QeackmKzCIfQMrfBq5MRbf/l
	 v8eJ1/s3yVOwqv6pIG/uDrILYHkyfbejp/MCYOYFcPn6nBOk8YT4y7250iR6Ftm+If
	 POMoc+FfB8S/RCXsO02i7EI648OP+ebnZuVcQqwJmgzLHyJ8ngjtvQ0y8GKYSEhhGk
	 QMQxKozaWBIaDs0Iwxa1i9SROIIBq041O7N4rEWRUC7cp4TOCRWa1QVSe8crufPZL2
	 VShZIogfBhiiQ==
Date: Sun, 12 Jan 2025 10:31:54 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
Cc: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Odelu Kukatla <quic_okukatla@quicinc.com>, Mike Tipton <mdptipton@quicinc.com>, 
	Vivek Aknurwar <viveka@quicinc.com>, Sibi Sankar <quic_sibis@quicinc.com>, 
	linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V7 3/5] dt-bindings: interconnect: Add EPSS L3 compatible
 for SA8775P
Message-ID: <273w3qr5wix4srdum5qmrqdzzaw3uprqhhfmmgrwycrb6wlyqf@txuxzzyjyhfk>
References: <20250111161429.51-1-quic_rlaggysh@quicinc.com>
 <20250111161429.51-4-quic_rlaggysh@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250111161429.51-4-quic_rlaggysh@quicinc.com>

On Sat, Jan 11, 2025 at 04:14:27PM +0000, Raviteja Laggyshetty wrote:
> Add Epoch Subsystem (EPSS) L3 interconnect provider binding on
> SA8775P SoCs.

1. And why is this not compatible with sm8250? There was lengthy
discussion and no outcome of it managed to get to commit msg. Really, so
we are going to repeat everything again and you will not get any acks.

You have entire commit msg to explain things but instead you repeat what
the patch does. We can read the diff for that.

2. Binding *ALWAYS* comes before the user.

> 
> Signed-off-by: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
> ---
>  Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml b/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml
> index 21dae0b92819..94f7f283787a 100644
> --- a/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml
> +++ b/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml
> @@ -33,6 +33,7 @@ properties:
>                - qcom,sm6375-cpucp-l3
>                - qcom,sm8250-epss-l3
>                - qcom,sm8350-epss-l3
> +              - qcom,sa8775p-epss-l3
>            - const: qcom,epss-l3

Your driver suggests this is not really true - it is not compatible with
qcom,epss-l3. Maybe it is, maybe not, no clue, commit explains nothing.

Best regards,
Krzysztof


