Return-Path: <linux-pm+bounces-29704-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65EEBAEC03E
	for <lists+linux-pm@lfdr.de>; Fri, 27 Jun 2025 21:41:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E85EB16BAF6
	for <lists+linux-pm@lfdr.de>; Fri, 27 Jun 2025 19:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D10B212B1E;
	Fri, 27 Jun 2025 19:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XGoRR75N"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA5F20B80B;
	Fri, 27 Jun 2025 19:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751053258; cv=none; b=joquvW2L29WIllFYF2gR5FDpz2CzIqvCV9vPIfNitCFa/8M5f0lI3LaJ2+A8ARomRVQqjfi1N31+533ABB02r8dCskFCYlPpQQdxrEoAFBya+QM40r3fgThiEbxxdABfrHBhPj5GV82B7/bjctqSCRqz67rV4GEQkhN3Cm/5jq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751053258; c=relaxed/simple;
	bh=6MkKhuTr/kzO2bvG/B9XyStdoHcYnsGwWcEHmKxSoeU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sik7FRI/SzJ9R+TKOKhlfZDPt4YSO2cvdQ3kn2elZFGz7+Yi96E3gJycW7UUrbkPk1aiBCwWGY2Qf9YyXe1L1330npI8dvi59UySEYgHsW6a3sbiUh9mId7MJkyhnoOtVS0aKQ8sZug/FmBKOeXBYNbfl2Ma22j9tunEZX9hAN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XGoRR75N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA796C4CEE3;
	Fri, 27 Jun 2025 19:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751053258;
	bh=6MkKhuTr/kzO2bvG/B9XyStdoHcYnsGwWcEHmKxSoeU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XGoRR75NS9RuP6hhgBtMryU4oxmAfnWwpHznQWDniDus/HDNxdTTU3mSUHzS2z+Wm
	 1nfMONZLmeiC4AmA+2brm+MKcNacPxxslUvnBK22GLhrDC3vI2io22zSRog5JCvS22
	 L2YWxhpUeuneypndf2P80Qfq7LSKgiUTlK1mbGGqg7GECu8aoVOMCSeGv8PSYdQu4N
	 Yjf/LCLnUUdENrI6yog82SP22gTdCR+UvZSvq+b5HcUfDypUOzBJgfFGkMQyuL0JOm
	 cMc90lZLVsNLyYj9w7XEbyxmK9yJyHILh1Bf6gkGpg8DJqHRrw2xyKqndSstsnYRIB
	 u7nmTIpNaKqsA==
Date: Fri, 27 Jun 2025 14:40:57 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Casey Connolly <casey.connolly@linaro.org>
Cc: Kees Cook <kees@kernel.org>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	linux-hardening@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	linux-pm@vger.kernel.org, Sebastian Reichel <sre@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	devicetree@vger.kernel.org, Konrad Dybcio <konradybcio@kernel.org>,
	linux-kernel@vger.kernel.org,
	Bjorn Andersson <andersson@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 01/11] dt-bindings: power: supply: qcom,pmi89980-charger:
 add pm8150b and 7250b
Message-ID: <175105325638.4057812.1772308849088053765.robh@kernel.org>
References: <20250619-smb2-smb5-support-v1-0-ac5dec51b6e1@linaro.org>
 <20250619-smb2-smb5-support-v1-1-ac5dec51b6e1@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250619-smb2-smb5-support-v1-1-ac5dec51b6e1@linaro.org>


On Thu, 19 Jun 2025 16:55:09 +0200, Casey Connolly wrote:
> Add compatible strings for these two PMICs which use the SMB5 generation
> of charger.
> 
> Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
> ---
>  .../devicetree/bindings/power/supply/qcom,pmi8998-charger.yaml          | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


