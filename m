Return-Path: <linux-pm+bounces-39183-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 42857CA2B80
	for <lists+linux-pm@lfdr.de>; Thu, 04 Dec 2025 08:59:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EEBCE30184F6
	for <lists+linux-pm@lfdr.de>; Thu,  4 Dec 2025 07:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FF033009D8;
	Thu,  4 Dec 2025 07:59:06 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1972D257459;
	Thu,  4 Dec 2025 07:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764835146; cv=none; b=FS8V4UNHOUdsX8pKk/gXLwHQnTGcFjf7MqcJy9RQ6Zdtam6Y2Hdtkn7i/V7VRfTmc2bjmupvA0ompz8CVONk96hhOKAwI32BjLtmBZ9n/hzbJ7jZWSNYTy2KiRXzYTGjDZViSBBK8aN8iEM17pQWkyRS23gHC/1lipwigwQ0bXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764835146; c=relaxed/simple;
	bh=PwP9q77C0RU/RPhuS+VEGzPyV+u3bnIXv43yTFp2pDg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tT0J7zw/I/JqkYN2zf0knnmnEtUMw25Llz4O3XvMk/133dj1AFTw7fq3LjpEgO3nmenAwidTVx+A5g15fZiS4deYRnjrsxIuZe/nJi5+BLxemC8tHy6Aji+t7Bd0tT6/AS+jtFFAJQPE6jg1dspdBBPMEDt9PhqMkLjiEDV/Q8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3BFCC113D0;
	Thu,  4 Dec 2025 07:59:04 +0000 (UTC)
Date: Thu, 4 Dec 2025 08:59:03 +0100
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	Georgi Djakov <djakov@kernel.org>, Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH] dt-bindings: interconnect: qcom,sa8775p-rpmh: Fix
 incorrectly added reg and clocks
Message-ID: <20251204-fierce-cuttlefish-of-election-c00c01@quoll>
References: <20251129094612.16838-2-krzysztof.kozlowski@oss.qualcomm.com>
 <176441533579.3692893.7120523585287384087.robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <176441533579.3692893.7120523585287384087.robh@kernel.org>

On Sat, Nov 29, 2025 at 05:22:15AM -0600, Rob Herring (Arm) wrote:
> 
> On Sat, 29 Nov 2025 10:46:13 +0100, Krzysztof Kozlowski wrote:
> > Commit 8a55fbe4c94d ("dt-bindings: interconnect: add reg and clocks
> > properties to enable QoS on sa8775p") claims that all interconnects have
> > clocks and MMIO address space, but that is just not true.  Only few
> > have.  Bindings should restrict properties and should not allow
> > specifying non-existing hardware description, so fix missing constraints
> > for 'reg' and 'clocks'.
> > 
> > Fixes: 8a55fbe4c94d ("dt-bindings: interconnect: add reg and clocks properties to enable QoS on sa8775p")
> > Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> > ---
> >  .../interconnect/qcom,sa8775p-rpmh.yaml       | 31 +++++++++++++++++++
> >  1 file changed, 31 insertions(+)
> > 
> 
> My bot found errors running 'make dt_binding_check' on your patch:
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> Documentation/devicetree/bindings/thermal/thermal-sensor.example.dtb: /example-0/soc/thermal-sensor@c263000: failed to match any schema with compatible: ['qcom,sdm845-tsens', 'qcom,tsens-v2']
> Documentation/devicetree/bindings/thermal/thermal-sensor.example.dtb: /example-0/soc/thermal-sensor@c263000: failed to match any schema with compatible: ['qcom,sdm845-tsens', 'qcom,tsens-v2']
> Documentation/devicetree/bindings/thermal/thermal-sensor.example.dtb: /example-0/soc/thermal-sensor@c265000: failed to match any schema with compatible: ['qcom,sdm845-tsens', 'qcom,tsens-v2']
> Documentation/devicetree/bindings/thermal/thermal-sensor.example.dtb: /example-0/soc/thermal-sensor@c265000: failed to match any schema with compatible: ['qcom,sdm845-tsens', 'qcom,tsens-v2']
> 

These are bot hiccups due to broken way of applying of Qualcomm tsens
patch. False positives.

Best regards,
Krzysztof


