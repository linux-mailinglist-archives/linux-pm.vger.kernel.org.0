Return-Path: <linux-pm+bounces-40010-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9384BCE6619
	for <lists+linux-pm@lfdr.de>; Mon, 29 Dec 2025 11:36:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E99093005B95
	for <lists+linux-pm@lfdr.de>; Mon, 29 Dec 2025 10:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79B792E54D3;
	Mon, 29 Dec 2025 10:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GbpCokER"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C7D719D065;
	Mon, 29 Dec 2025 10:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767004566; cv=none; b=lcjmL24faMWviBPc4LYN1kSJJ7UxnBKq1mLzbpKjYuG+vFc1ImbKnPXgq5tbFPQH7M+k386WcveTJT9JFMAx9QdhsBuJxcX3MSoxQyiSmrBjbtZd1wLfYBQEyMvxZAYBKrymVWlcPzFaT6avXLyTepSMIr/A4e6EPxyOqzNs2xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767004566; c=relaxed/simple;
	bh=yZNxUCUJShV6REW3N8Idxm9481H2ppYxU+/xwJm0adw=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=Y2tg1gE1wPgRM7Y7KKjIepV7WQWSQndaFTWt6x5baJYN9psbZhudlNXuec/4wmgXZED/B4WOr+a6k9qnyx5ysuA017wQvyMmpyiwBUD6aBenihYARK/Wt3WnftA7W11uO8VKIcnTd+6B4p500fKoEyVsrIQUD3ym6zxo+59/wFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GbpCokER; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6135C4CEF7;
	Mon, 29 Dec 2025 10:36:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767004565;
	bh=yZNxUCUJShV6REW3N8Idxm9481H2ppYxU+/xwJm0adw=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=GbpCokERt90OP+pTJF8ktJi6oaRKGNbTSNvA1gO1U761B2iEc+TRVrbBFypQMNKlA
	 d2O4NmGhBBKON8Bh84R+9JRn6kpU0s3XEpcfMtSmkIqZHCSnTJDDIfYRFPZI2XWAkS
	 2kG1OLxYGrJMIlhDYi9m0JCRsmFIBuh54T/hCfgC7guLIvuBFrBkjX+SkEnJdtaQCR
	 DI+tq3AqTOWC+1IeDWjoT6I3ddC1iqk/2jTlh2Z5yxw9j9FQot+/76fFYtsPQfwZH4
	 yoq4aSgoSHw0CaE3xUQn2b66nUuTLTkQf9pvpTsnCCUCeW+WvM0fZ6Jjh2++cP8yaK
	 jOmfQZ9hPcWJw==
Date: Mon, 29 Dec 2025 04:36:04 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, sre@kernel.org, 
 bsp-development.geo@leica-geosystems.com, linux-pm@vger.kernel.org, 
 krzk+dt@kernel.org, linux-kernel@vger.kernel.org
To: LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
In-Reply-To: <20251229085636.4082852-2-Qing-wu.Li@leica-geosystems.com.cn>
References: <20251229085636.4082852-1-Qing-wu.Li@leica-geosystems.com.cn>
 <20251229085636.4082852-2-Qing-wu.Li@leica-geosystems.com.cn>
Message-Id: <176700456483.502292.1935553390982118898.robh@kernel.org>
Subject: Re: [PATCH V1 2/3] dt-bindings: power: sbs-battery: add polling
 interval property


On Mon, 29 Dec 2025 08:56:35 +0000, LI Qingwu wrote:
> Add the optional sbs,monitoring-interval-ms property for SBS-compliant
> batteries to configure a periodic polling interval on systems without
> interrupt support. The driver periodically checks the battery status and
> notifies userspace of changes when this property is set, and ignores it
> when a GPIO interrupt is available.
> 
> The property defaults to 0 to preserve existing behaviour.
> 
> Signed-off-by: LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
> ---
>  .../bindings/power/supply/sbs,sbs-battery.yaml           | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/power/supply/sbs,sbs-battery.yaml: properties:sbs,monitoring-interval-ms: '$ref' should not be valid under {'const': '$ref'}
	hint: Standard unit suffix properties don't need a type $ref
	from schema $id: http://devicetree.org/meta-schemas/core.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.kernel.org/project/devicetree/patch/20251229085636.4082852-2-Qing-wu.Li@leica-geosystems.com.cn

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


