Return-Path: <linux-pm+bounces-40522-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A8490D07CB5
	for <lists+linux-pm@lfdr.de>; Fri, 09 Jan 2026 09:25:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1518D305A74E
	for <lists+linux-pm@lfdr.de>; Fri,  9 Jan 2026 08:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3178E3233F4;
	Fri,  9 Jan 2026 08:23:37 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA821322B75;
	Fri,  9 Jan 2026 08:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767947016; cv=none; b=HTDr6fdUFEiAEMT4Zt9pBpWOnhcf40IQftCE1NRXk2R8tLj7ced8+qHCg8C09WMpGl8e5QbCWEDtZUwN1dz7Q1xKrZ41/O05/5/tvdB4CDZZvCFwT24kXz+hvQyje8PpJci6rm6MsEyZLoempBLu5Pu7lUAnTB3aaeI/R93inf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767947016; c=relaxed/simple;
	bh=ZiDRq5wUhOmOi5ZkDhAaOUyBKA0KQ1YqovDOZBvrhqw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O2RI3zL+Z9pX3DxroLwi3cS2/utLB2XLuBIaYy7TLeO2T+2o4lFI+FcGWqi4lp4Wxt2SinekWpxkjThm9s8oepFeSRIM6Qhy2VTyYvFZxGRnMVcH2/FIv4EiG1vj1m7P4gcB8tOh2H1s1sLkmgjyKLbCAvwHDep9oobyFfvMHiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A29F0C4CEF1;
	Fri,  9 Jan 2026 08:23:35 +0000 (UTC)
Date: Fri, 9 Jan 2026 09:23:33 +0100
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: airlied@gmail.com, simona@ffwll.ch, maarten.lankhorst@linux.intel.com, 
	mripard@kernel.org, tzimmermann@suse.de, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, dmitry.torokhov@gmail.com, sre@kernel.org, 
	gregkh@linuxfoundation.org, jirislaby@kernel.org, lgirdwood@gmail.com, broonie@kernel.org, 
	jserv@ccns.ncku.edu.tw, eleanor15x@gmail.com, dri-devel@lists.freedesktop.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-serial@vger.kernel.org, linux-sound@vger.kernel.org
Subject: Re: [PATCH v2 3/6] dt-bindings: input:
 google,goldfish-events-keypad: Convert to DT schema
Message-ID: <20260109-remarkable-crane-of-exercise-6bc17f@quoll>
References: <20260108080836.3777829-1-visitorckw@gmail.com>
 <20260108080836.3777829-4-visitorckw@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260108080836.3777829-4-visitorckw@gmail.com>

On Thu, Jan 08, 2026 at 08:08:33AM +0000, Kuan-Wei Chiu wrote:
> +
> +examples:
> +  - |
> +    keypad@9040000 {
> +        compatible = "google,goldfish-events-keypad";
> +        reg = <0x9040000 0x1000>;
> +        interrupts = <0x5>;

Same comment as before. It applies everywhere, btw.

> +    };
> -- 
> 2.52.0.457.g6b5491de43-goog
> 

