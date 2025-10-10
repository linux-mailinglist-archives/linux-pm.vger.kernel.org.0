Return-Path: <linux-pm+bounces-35924-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D34BBCE406
	for <lists+linux-pm@lfdr.de>; Fri, 10 Oct 2025 20:31:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2D88A4E7FBA
	for <lists+linux-pm@lfdr.de>; Fri, 10 Oct 2025 18:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD3F12FE044;
	Fri, 10 Oct 2025 18:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ORudNF6L"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F9432FD7B1;
	Fri, 10 Oct 2025 18:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760121109; cv=none; b=D3RcmBRRdGtDXVRCfFj2Y6KO/t43lBisEyfXinMeEmby4o/VQombilpdnJ2vvyzgy2NoGMuZHgdc409iWXzqXLM8qKrIa6OPu0QhiOHUllMENiUBjKgIxl2p/3IpZ/JIAk2uD/KzKIesbIT7IxWXAY9HpQMQP/CVMK8W4/Y3GT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760121109; c=relaxed/simple;
	bh=n1Ip3VvLU5moVpOWLPfYC3hSao+rKi7mKusI1LUk6Ms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZtgGBX1pHzLDloghbbczZ1OMlru8VCwvLA5wFEkW+Ztl9oEeYCaBVxMS4zOul+xsEYT16yZiq77w8E+H51GCjU8yj3SRAqnJbu3i6jkgG9bCE/NQdiLoAabYcHbZar/SlFWoTWpreM41vIuOFNxUPOR6Ods2DCdXwq5zyemrE4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ORudNF6L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB1ADC4CEF1;
	Fri, 10 Oct 2025 18:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760121109;
	bh=n1Ip3VvLU5moVpOWLPfYC3hSao+rKi7mKusI1LUk6Ms=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ORudNF6LNV+Tar7mZ6lqKmbbGNMrq5scimqHf/ViC3tsvfTkijYm5d68QLoFkCiT/
	 KEYBzgF0nl2pFBA7pb4ZvEjfjdlKQP21cpAjSgCN9E7uNDD7uzxAjMiRj234gGwo7E
	 KX9cNY2eG6C0T+jp0wCcs6DpiZ/v+wE1iygmctqGPUNexAFwGoQI6Ds8XXagqus1Dy
	 GsJJ6udXfxVS3faP9AlV/VU5GVrw7OqIxjynYh4pXBfQ5hUZDW7pyAoFKqNUa4bHKt
	 d64yv/t+qH7OnKXp7qrsYqU4qmjJt6HYR5BoYXejmyrwswehIHcpXIBMS/pILG0Hq6
	 yx5ZZsVxRw/Wg==
Date: Fri, 10 Oct 2025 13:31:47 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: =?iso-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	Peter Griffin <peter.griffin@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Will McVicker <willmcvicker@google.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, kernel-team@android.com,
	linux-samsung-soc@vger.kernel.org,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 01/10] dt-bindings: power: samsung: add google,gs101-pd
Message-ID: <176012110602.673033.1312725793762459039.robh@kernel.org>
References: <20251009-gs101-pd-v2-0-3f4a6db2af39@linaro.org>
 <20251009-gs101-pd-v2-1-3f4a6db2af39@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251009-gs101-pd-v2-1-3f4a6db2af39@linaro.org>


On Thu, 09 Oct 2025 16:25:03 +0100, André Draszik wrote:
> Add support for the Google gs101 version of the Exynos power domains. A
> new compatible is needed because register fields have changed.
> 
> Reviewed-by: Peter Griffin <peter.griffin@linaro.org>
> Signed-off-by: André Draszik <andre.draszik@linaro.org>
> ---
>  Documentation/devicetree/bindings/power/pd-samsung.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


