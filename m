Return-Path: <linux-pm+bounces-35189-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F050FB93353
	for <lists+linux-pm@lfdr.de>; Mon, 22 Sep 2025 22:22:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BE58A4E26A4
	for <lists+linux-pm@lfdr.de>; Mon, 22 Sep 2025 20:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA1872F0C78;
	Mon, 22 Sep 2025 20:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iMeWhZ//"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4CA2E2DC1;
	Mon, 22 Sep 2025 20:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758572548; cv=none; b=FXOs72YCP/L1h8Cy4y5uM9RoQrh/Rp91n7eOrN6H2x+ct1HqEX3i/lkeH1AQKgQp8p/IhcyxTHT3uha/aEg2xa+HzIL03HvG+NPj0u8LPB3AoLefMB4sq9iuesSSLdDwyyuWqRKa0SATlLYhpN/UN7VGKAtJFlFMIUcb3L2kaRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758572548; c=relaxed/simple;
	bh=QFCnLH0QSBllhhPkO/Euf4JjftyjoIQgHonjoMISULY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ohbVnsdLz27YR48qp82+AbYbDMQnCYsoH6MATvnn1dT5P0MbTWxPoae3xhUCSQiWfPIxZZgb6ZHMzYHQk0oIib/R4AJSZXfyvidnzp7mq51FoXXx5VGaoXVWMHjYcOfZjvpBHN03SrW0Xj+oa4T/HuK7ALq/86dmoZuDUqoRA+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iMeWhZ//; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0797BC4CEF0;
	Mon, 22 Sep 2025 20:22:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758572548;
	bh=QFCnLH0QSBllhhPkO/Euf4JjftyjoIQgHonjoMISULY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iMeWhZ//daiwUNkvKmTcBSCGoGPZr0fAdTE5i1Th7PygrLIBryuzucXSnmAzox9bo
	 +pJTxQwLP/9XY1PVOzibojpEw0XWfnlgSh9czmSwqIovYYK3B2E/JUhjSw+4Pn7kxZ
	 K8srHtkOFzrmIAQHpnI1jc2WmElfo62Tf10vqt1PB1kOmBrScz2WxPil7j9VUsRC3b
	 DBnAPzrMbsavRrycEQUv7gWGHoXBOFOb06+XdUOEW1Eu6e1hR4DOkzuWoGDIBfFrCi
	 A0yP2uekGhf/U38PbLz1zP5IzA9mZKOWLG82fA45CC6UMqXFYSXLe2YRQxihoK8dHg
	 SdDe/m5njECyw==
Date: Mon, 22 Sep 2025 15:22:27 -0500
From: Rob Herring <robh@kernel.org>
To: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
Cc: amitk@kernel.org, thara.gopinath@gmail.com, rafael@kernel.org,
	daniel.lezcano@linaro.org, rui.zhang@intel.com, lukasz.luba@arm.com,
	krzk+dt@kernel.org, conor+dt@kernel.org, linux-pm@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: thermal: qcom-tsens: document the glymur
 Temperature Sensor
Message-ID: <20250922202227.GA1268708-robh@kernel.org>
References: <20250920113052.151370-1-pankaj.patil@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250920113052.151370-1-pankaj.patil@oss.qualcomm.com>

On Sat, Sep 20, 2025 at 05:00:52PM +0530, Pankaj Patil wrote:
> From: Manaf Meethalavalappu Pallikunhi <quic_manafm@quicinc.com>
> 
> Document the Temperature Sensor (TSENS) on the glymur Platform.
> 
> Signed-off-by: Manaf Meethalavalappu Pallikunhi <quic_manafm@quicinc.com>
> Signed-off-by: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
> ---
>  Documentation/devicetree/bindings/thermal/qcom-tsens.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
> index f65dc829574c..bfbacba1dc55 100644
> --- a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
> +++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
> @@ -50,6 +50,7 @@ properties:
>          items:
>            - enum:
>                - qcom,milos-tsens
> +              - qcom,glymur-tsens

Alphabetical order

>                - qcom,msm8953-tsens
>                - qcom,msm8996-tsens
>                - qcom,msm8998-tsens
> -- 
> 2.34.1
> 

