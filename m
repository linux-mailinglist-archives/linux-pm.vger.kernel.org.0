Return-Path: <linux-pm+bounces-24677-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05D3CA77442
	for <lists+linux-pm@lfdr.de>; Tue,  1 Apr 2025 08:09:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F0A73A85EF
	for <lists+linux-pm@lfdr.de>; Tue,  1 Apr 2025 06:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E7501DD0D4;
	Tue,  1 Apr 2025 06:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AnmnMngH"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327A01D54FE;
	Tue,  1 Apr 2025 06:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743487744; cv=none; b=RB8qq6s6HyNvKswYpOLj8nRrt1PzByRmsnbEjgXFonwDHz44ySknB+EQCQRKUs9ovJ23+FEx33wev37ji5PRZgJ8PmVwXvoM8uETvXAWvaRw/EVPnDylVlvWLIgI/PK8Z068yUNH3fLBI6UBMYiPZ1Oy16KYE7HOmXD1mWH8MoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743487744; c=relaxed/simple;
	bh=oFLcVum17dsPPO7U3U7d+AI2nZ0+RN/f/ABuNueQsNI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=syVaNg71DGXqOfKhBm9CY5CapnH+BoWFr4jCdewkMKjrwStjYFiB831gIQZoBkszenzLbPzuKEdZ3Wt09LD40caGswgmMb73GRnyy3oIIbAzzzAtdCuTGHWPNHIDdCcLkkQoYtKGznCzSFXs5gEBgPhEtlbVli4wkLQgf02pDZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AnmnMngH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD63DC4CEEA;
	Tue,  1 Apr 2025 06:09:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743487743;
	bh=oFLcVum17dsPPO7U3U7d+AI2nZ0+RN/f/ABuNueQsNI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AnmnMngHBIzuTa08FKkl3KSGYM+3GAQiembj4xfO4XVGWhA9jZp/o1lEt2+FkxC5G
	 dd0zvPn+RYTkVD4dx0T+1N6c13ExftFcO9X0pK/4206oShWeMpyoVgJIeUGp2rDv+e
	 +418XNfX3IFhJQhNjTGFK5is0qr9H0D1IlrFma/S9XLTp5wncLQoyFn5/9MM1Fwg6M
	 qCEzyQRCbbQIyHKJmD3smHXtdyVs4DaTIanExLs+I4TZU5D9iTDRmdICJ5Q+reVlxY
	 y5fV/RWg1oAEC5xUPYu6A35Sf4ILCSmBO5ZKEe8FL1pssS4/f/tqm74LU7pBYRdFN3
	 PaHmyoj/TY4/A==
Date: Tue, 1 Apr 2025 08:09:00 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Sebastian Reichel <sre@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/2] dt-bindings: power: supply: Document Maxim
 MAX8971 charger
Message-ID: <20250401-precious-rampant-prawn-9fa642@krzk-bin>
References: <20250320072947.8174-1-clamor95@gmail.com>
 <20250320072947.8174-2-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250320072947.8174-2-clamor95@gmail.com>

On Thu, Mar 20, 2025 at 09:29:46AM +0200, Svyatoslav Ryhel wrote:
> Add bindings for Maxim MAX8971 charger.
> 
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  .../bindings/power/supply/maxim,max8971.yaml  | 68 +++++++++++++++++++
>  1 file changed, 68 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/maxim,max8971.yaml

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


