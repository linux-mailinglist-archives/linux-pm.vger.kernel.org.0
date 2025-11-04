Return-Path: <linux-pm+bounces-37365-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D5565C3164F
	for <lists+linux-pm@lfdr.de>; Tue, 04 Nov 2025 15:06:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E486E189988B
	for <lists+linux-pm@lfdr.de>; Tue,  4 Nov 2025 14:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15C9C32B989;
	Tue,  4 Nov 2025 14:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hLf0Vjvn"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D672532AAC3;
	Tue,  4 Nov 2025 14:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762265042; cv=none; b=PqbTej/ONtFESrkIUXOwQVmH+fbZIoMZj0l54p2BmU+GOKbRZo4EYozkxX4fqBPtaLCb97kLKeymfhuymagBVAFpRgvSSqhihTp08AOeCxAfP5BDuLdsTV1PPxgAhyPLRObvpqUByETaWDccmPjCDN+uEDRPGtVhvUfj8QamuLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762265042; c=relaxed/simple;
	bh=PLgn57zEwgHEIBzbw8uwLpryBbI82qdfuHqoYYL6TBE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rCS07LbCZg9OecxOaukCN9j3ChAneOHIMt44Lmh17tJ1AEgyosIaNumS4OXDkpP/KmhhdC4SDbRHD4+7qzNAulIyUHTNDjcvF1GF1OzQj5YC812UiT//JhA70UjTmCA/QRjOXAx7TK5kJzsD55veXr9HVe1uBnyuXHyygnJXuCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hLf0Vjvn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD922C116B1;
	Tue,  4 Nov 2025 14:04:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762265041;
	bh=PLgn57zEwgHEIBzbw8uwLpryBbI82qdfuHqoYYL6TBE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hLf0Vjvna0PLyCsTb08l03l2o2Lp96BmB0KXTDfFW9QyYUUl+7TBLw95DYncgaf+y
	 ckO47xGvTkzu6DfgNs7oT9Pifr8PGoVtAuucG8Xu9TxknEFUYMYhuJ1+cBYBrRqm2j
	 yy/0mEgSM0VYeZnV0UG/nD07lv10sxU1TOYC5sFdZ7wBwzkQbSMY5oYPveuE/hq+71
	 a1UUxORqWJefahxD+b4xW+/CaHRV7UmlNHHsc9zjPP0BjMS78TgFLNeNMD9DuwN4Au
	 2QTMQ+fRkVI2YwSIJgZf0umb4U4wP1WCIezL5aupwV6e/+omenNF5zILaf2QLANCo5
	 nJJOYcdheUP0w==
Date: Tue, 4 Nov 2025 15:03:58 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, sre@kernel.org, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 1/5] dt-bindings: power: reset: qcom-pon: Document
 qcom,warm-reset
Message-ID: <20251104-spiritual-jade-marmoset-0fa0dc@kuoka>
References: <20251103182006.1158383-1-loic.poulain@oss.qualcomm.com>
 <20251103182006.1158383-2-loic.poulain@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251103182006.1158383-2-loic.poulain@oss.qualcomm.com>

On Mon, Nov 03, 2025 at 07:20:02PM +0100, Loic Poulain wrote:
> This property can be used as a fallback mechanism when a warm reset
> cannot be achieved through the standard firmware interface (SCPI).
> 
> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> ---
>  .../devicetree/bindings/power/reset/qcom,pon.yaml          | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml b/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml
> index 979a377cb4ff..ad8691c87f4f 100644
> --- a/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml
> +++ b/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml
> @@ -38,6 +38,13 @@ properties:
>      minItems: 1
>      maxItems: 2
>  
> +  qcom,warm-reset:
> +    description: |

Do not need '|' unless you need to preserve formatting.

> +      The PON (Power-On) peripheral provides support for warm reset, which can
> +      be used as a fallback mechanism when a warm reset cannot be achieved
> +      through the standard firmware interface.

You described the desired Linux feature or behavior, not the actual
hardware. The bindings are about the latter, so instead you need to
rephrase the property and its description to match actual hardware
capabilities/features/configuration etc.

Best regards,
Krzysztof


