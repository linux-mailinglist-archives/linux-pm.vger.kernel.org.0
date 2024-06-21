Return-Path: <linux-pm+bounces-9741-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 236CC911E43
	for <lists+linux-pm@lfdr.de>; Fri, 21 Jun 2024 10:14:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9AD2CB238D9
	for <lists+linux-pm@lfdr.de>; Fri, 21 Jun 2024 08:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC32D16D4FF;
	Fri, 21 Jun 2024 08:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PVH1xdJr"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF7D16C856;
	Fri, 21 Jun 2024 08:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718957257; cv=none; b=XaA8NV3PfgGOayuh36ceRd77TY/vX+1jTNRIzr3+kMVfStf++PmDWqRMOyu3cPW4R4He67mepzV5t7L2Rnr+hjm7jO/b/kkImWHDHSo4ye/gqxwIF4+AsaXfKv8mRaiXqPcwaDx+fPqHTc3ocNzMTQxpCz7xr70VGBUndVyL0VE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718957257; c=relaxed/simple;
	bh=xNcqs2Y76K4Q1p9L2Y19Xfyw5HF8nT2HEwfkidcfghg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tk0fprZZG7ZZ7/a+IrpvG/udO7RMY4WlwXFtr2dKShXdrt+Qz8RLIXhSCwMUSqBVubINJdt2t+UGhMwrCSpLmRUQlr8bmhcIpeC8cuXaevQJhLhqoPlOZN0A9+8wHUC7+KshBQ2lJYMAgjhhFYFXMTib6WIw5eunW8+YM7lDQx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PVH1xdJr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 204AEC4AF07;
	Fri, 21 Jun 2024 08:07:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718957257;
	bh=xNcqs2Y76K4Q1p9L2Y19Xfyw5HF8nT2HEwfkidcfghg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PVH1xdJr78NhR6TKmXvVuXQyeXXW99m4IHD9RAZ3FcQLzPNWQgQ43Tk4ykl8M7r3/
	 OZs23/wD590EuDa2KtjG9Dozp1mgzrz7hxMDgsiC2zF4iGfM8wu9T7xL0n6MeLxXuI
	 TvmXNcgJSoaodv47CfaiGeZv4Lcd6neTsDSyYRjo8MdwaJrjOPjMPQYXK4zbn5kqmT
	 nf7jBRmeqHB/4UjN0t2+V6wkU4Z25QvDfj/Rrj/S+ERQfGbOlF5+57yq4RZU7gctx0
	 q5n8imJS4r+4d6cHxCYzV+51Q0Ch0wyFf1LLPhDwMPOgnTtShMTn2Kgfu7xF74W4CH
	 s98WW+0brnYlA==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1sKZJ8-000000002vW-4ACc;
	Fri, 21 Jun 2024 10:07:43 +0200
Date: Fri, 21 Jun 2024 10:07:42 +0200
From: Johan Hovold <johan@kernel.org>
To: Abel Vesa <abel.vesa@linaro.org>
Cc: Sebastian Reichel <sre@kernel.org>, linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] power: supply: qcom_battmgr: Enable battery support on
 x1e80100
Message-ID: <ZnU0zuivuoE7-zot@hovoldconsulting.com>
References: <20240621-x1e80100-power-supply-qcom-battmgr-v1-1-40cb89a0c144@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240621-x1e80100-power-supply-qcom-battmgr-v1-1-40cb89a0c144@linaro.org>

On Fri, Jun 21, 2024 at 10:16:35AM +0300, Abel Vesa wrote:
> The x1e80100, being a compute platform, provides functionality for the
> exact same power supplies as sc8280xp. Add the compatible and assign
> the sc8280xp match data.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>

I'm running with the battery disconnected but the reported values look
correct:

Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
Tested-by: Johan Hovold <johan+linaro@kernel.org>

Johan

