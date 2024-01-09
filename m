Return-Path: <linux-pm+bounces-2031-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 75EE9828EDF
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jan 2024 22:29:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11A581F256B0
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jan 2024 21:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A3613DB83;
	Tue,  9 Jan 2024 21:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CdHOT0zg"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF16C3DB80;
	Tue,  9 Jan 2024 21:29:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 905CDC433F1;
	Tue,  9 Jan 2024 21:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704835761;
	bh=9VsUoW598xw6fupZ36RRsd9fB0KHWo4eiYcpmwuqSGU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CdHOT0zgBHqGJu+UOXmWkoqPQVSp54+HDPQdSwz3RECWi8vd38AhYm+0spQKwb6pf
	 fJjpJvvrPAlmit4XC736TU+0Dn/QchjDk6J4CEib+kyT3zrVypVooOKjqzjJrN5myQ
	 /H0923gGHRHIuIDVznQ/4R4eIkBzzjm8DVy2gjuRdUQ4J9aAl3F3pP1y18ZdvMcaiK
	 3TJi7PrlGqC7s+las+M0ZyIHntGJ7r5mCWCyVfNfL8kOosWLVEy7pUAqVoq7zkhqa0
	 CO8ZaWfGB5sE56t+qoh14O8ZxibOelSULreV94IEtXp8tlUQEc4xSAbMQyQSrx+Vuu
	 o2FkVp6uxc8rg==
Received: (nullmailer pid 3250977 invoked by uid 1000);
	Tue, 09 Jan 2024 21:29:19 -0000
Date: Tue, 9 Jan 2024 15:29:19 -0600
From: Rob Herring <robh@kernel.org>
To: Fabio Estevam <festevam@gmail.com>
Cc: robh+dt@kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, Fabio Estevam <festevam@denx.de>, daniel.lezcano@linaro.org, conor+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Subject: Re: [PATCH v4] dt-bindings: thermal: qoriq-thermal: Adjust
 fsl,tmu-range min/maxItems
Message-ID: <170483575880.3250905.813888197504018809.robh@kernel.org>
References: <20240104124952.1975160-1-festevam@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240104124952.1975160-1-festevam@gmail.com>


On Thu, 04 Jan 2024 09:49:52 -0300, Fabio Estevam wrote:
> From: Fabio Estevam <festevam@denx.de>
> 
> The number of fsl,tmu-range entries vary among the several NXP SoCs.
> 
> - lx2160a has two fsl,tmu-range entries  (fsl,qoriq-tmu compatible)
> - imx8mq has four fsl,tmu-range entries. (fsl,imx8mq-tmu compatible)
> - imx93 has seven fsl,tmu-range entries. (fsl,qoriq-tmu compatible)
> 
> Change minItems and maxItems accordingly.
> 
> This fixes the following schema warning:
> 
> imx93-11x11-evk.dtb: tmu@44482000: fsl,tmu-range: 'oneOf' conditional failed, one must be fixed:
>         [2147483866, 2147483881, 2147483906, 2147483946, 2147484006, 2147484071, 2147484086] is too long
> 
> Signed-off-by: Fabio Estevam <festevam@denx.de>
> ---
> Changes since v3:
> - Rebased against next-20240104.
> - Do as suggested by Rob:
> "So short term, I'd just leave things such that they don't warn or just
> drop the conditional."
> 
>  Documentation/devicetree/bindings/thermal/qoriq-thermal.yaml | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>


