Return-Path: <linux-pm+bounces-20743-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4012A178F8
	for <lists+linux-pm@lfdr.de>; Tue, 21 Jan 2025 09:02:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB0561888104
	for <lists+linux-pm@lfdr.de>; Tue, 21 Jan 2025 08:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AE6D19F131;
	Tue, 21 Jan 2025 08:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GgxjAwBY"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21D1145A18;
	Tue, 21 Jan 2025 08:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737446547; cv=none; b=q51i8skzChkPlL37oLl95GTBmei4qEqRESIvH+ZSe+mLkhpsmRzVtPRyEu6qcwtbcJ3jRSjKXoJy/wuJ3jF7Nbf2vghPHt3aZzNvnrGP9ZXlsS3BmwHluTgwwLq5se3+xzC2Le4hGvSWAEHHC3zcdXXmE7b9MtWU8m55+CT07lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737446547; c=relaxed/simple;
	bh=CxY3/wyeX6n2/22iDBxPz6jy7l55K+eh5I4tb5XZWMw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l+tgihuR8rutC3DzMa5bVUmW+tAyV6cPKDy3lhnSUKCjtADv+OI1p9tRDbv48CjiX3IgC95nJZeTN6h8l44apapIhskuP7M6m6a2zXrdH/K3/dyScbQVcRoaN9we8FsV2F3eo8FcO0uqAkFuQyTVfXyBycCEaS/xTnra/ohDN/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GgxjAwBY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69457C4CEDF;
	Tue, 21 Jan 2025 08:02:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737446546;
	bh=CxY3/wyeX6n2/22iDBxPz6jy7l55K+eh5I4tb5XZWMw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GgxjAwBYHJFoxx9+ryaP2BIRL3EgTEG8NjpXq36QrIFsVD9PopIErdonLQK63d/02
	 dEQYVklmiGBSWrW++TrfN/c13vrxOpWL3dim1VsrzeX2u9PVFNfPjbNgR2ay/2lF0B
	 mpbcbR17ayslhyfreW/p6wwkPok+E5QxQmQ7vyuTanE59DcQo3VJPBrmll5tXd0u2w
	 lTflR1aj73vdlqL7/z+AFoKV+FyOMzFUr8ZiN1Xg4pX7QTQctN6j4ARM9VTliRkRHn
	 5HwVBa68Jp8/8omiQgEz+8+Vo0IYk9iXDtnjIZSNikWqN/3ZJ9iMhHKs6RiFtm2o3j
	 1Lmm4CL4tdoJw==
Date: Tue, 21 Jan 2025 09:02:22 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Rob Herring <robh+dt@kernel.org>, 
	"James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>, "Martin K . Petersen" <martin.petersen@oracle.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Heiko Stuebner <heiko@sntech.de>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Alim Akhtar <alim.akhtar@samsung.com>, Avri Altman <avri.altman@wdc.com>, 
	Bart Van Assche <bvanassche@acm.org>, YiFeng Zhao <zyf@rock-chips.com>, Liang Chen <cl@rock-chips.com>, 
	linux-scsi@vger.kernel.org, linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-pm@vger.kernel.org
Subject: Re: [PATCH v6 1/7] dt-bindings: ufs: Document Rockchip UFS host
 controller
Message-ID: <20250121-organic-exotic-honeybee-e90be3@krzk-bin>
References: <1737428427-32393-1-git-send-email-shawn.lin@rock-chips.com>
 <1737428427-32393-2-git-send-email-shawn.lin@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1737428427-32393-2-git-send-email-shawn.lin@rock-chips.com>

On Tue, Jan 21, 2025 at 11:00:21AM +0800, Shawn Lin wrote:
> Document Rockchip UFS host controller for RK3576 SoC.
> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Just because I gave review, does not mean you can send untested patches!

Best regards,
Krzysztof


