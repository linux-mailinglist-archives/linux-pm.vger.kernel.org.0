Return-Path: <linux-pm+bounces-26255-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15989A9D299
	for <lists+linux-pm@lfdr.de>; Fri, 25 Apr 2025 22:01:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65B0516EAC2
	for <lists+linux-pm@lfdr.de>; Fri, 25 Apr 2025 20:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0179B21ADC6;
	Fri, 25 Apr 2025 20:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HAMR8O0x"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C976720F09A;
	Fri, 25 Apr 2025 20:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745611304; cv=none; b=ewFk5/aMxGIVq0IfkBbQbwgeIjcAMLSgS+ACJ5ZkW+ayMlEcTOjf8sYhKE53sO5VWRcfvLKpya0l4W9ZP/hX+vLTFS0qkTZW5HVA8/qwAgz23pVJFQUJi7majITUn8kbaT3SFSAGDNz+RgYwqimVP8akBfEZnxmx0N7g36cna3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745611304; c=relaxed/simple;
	bh=CWqSbvP1vf5fJCq2fhgrtKNZ8y989GEEweum4GdrVKY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WUocDhhpryVXpHrOLizVrofm+etlMo/nQQhWjuwBmgKYnNshDqySz2JUDMWhLwyAAB/GeHSH7WCMcwXdgF+Fx0fwK6V+xyF/vb0mgZV/GDnIMh3u4Uhdl5mnaGOUfZqEL/uNoJXMOdPtGAP6VdW8nklpDLDS8F5hqIvb7OLR1cU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HAMR8O0x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17E43C4CEE4;
	Fri, 25 Apr 2025 20:01:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745611304;
	bh=CWqSbvP1vf5fJCq2fhgrtKNZ8y989GEEweum4GdrVKY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HAMR8O0xrVbupS8hLjfFN9xyhZgLd/Utq6N4B81O0miq6yDPUHZZ3WKJLJVyW4bGe
	 NeFhNd2aWKiu51u4E5wBGK+Hv3nP2vPdi5BAjl4fSdOzDNPIj+0kpSkeiLqNaxKQ1+
	 ecupFY8zEPk/AonsQEqoGMmY9ZvV9FquTy23KmWEqIU7zimSS8EG/rs4gM8hwJmR4n
	 1KhBLrIxHMl7HA3CONYnc1O1IPuLO03djvzGp4KO18jBLPyVZQ+JolfzSNwx/AexKu
	 jesHDXjs/NdfhIcnTLUkmskeCJ13+if+XTk2UHQ31huDRpmXOxGvpEUZS50Na1YOd6
	 3qXgvm2aDhYJA==
Date: Fri, 25 Apr 2025 15:01:42 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Aaron Kling <webgeek1234@gmail.com>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-pm@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: power: supply: bq24190: Add BQ24193
 compatible
Message-ID: <174561130148.2899068.1124212461285963962.robh@kernel.org>
References: <20250421-bq24193-v1-0-f125ef396d24@gmail.com>
 <20250421-bq24193-v1-1-f125ef396d24@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250421-bq24193-v1-1-f125ef396d24@gmail.com>


On Mon, 21 Apr 2025 23:27:33 -0500, Aaron Kling wrote:
> The BQ24193 is most similar to the BQ24192. This is used in many Nvidia
> Tegra devices such as the SHIELD Portable.
> 
> Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
> ---
>  Documentation/devicetree/bindings/power/supply/bq24190.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


