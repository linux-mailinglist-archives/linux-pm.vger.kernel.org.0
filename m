Return-Path: <linux-pm+bounces-19913-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50F579FFCC4
	for <lists+linux-pm@lfdr.de>; Thu,  2 Jan 2025 18:33:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27B3A16285D
	for <lists+linux-pm@lfdr.de>; Thu,  2 Jan 2025 17:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E03111420A8;
	Thu,  2 Jan 2025 17:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZQ2I1Rc4"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1264610D;
	Thu,  2 Jan 2025 17:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735839216; cv=none; b=CErwscqSJYZPb9INn9crSeFKt1s03fbF3/+wq/hODDzybyd4omvB9e2D7T2uiND9Ru1E1PzW/9N1TWbdMMpsBH1uutRoEJVN0Cj1pSY7eQ9nCfeHl4Qff3tOORLVpfJ2xQAZeZzu/FFR5v2Ja/Qca/RyukLiNM3sxSYg+Ew9Sx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735839216; c=relaxed/simple;
	bh=g/WWTgiawR9PJ4oGPUfsf/LvEFCMknOwNLRmuuyae2k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MyuFT+xJ30gM/V06JxtDLNWZ4e53i8be3w6gwTF88eNECHNxWV4Yw0I8SJ63eedUKnmly+BB2DVmgDaeW2Ac70CfKOgJZ19yKobHw0FBLMjlUSWRa9/I7LINXoGSf38wf54vk5oVMCjsYG+GISeV7rHktDjFrw94bFMgfJVyt1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZQ2I1Rc4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDC64C4CED0;
	Thu,  2 Jan 2025 17:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735839216;
	bh=g/WWTgiawR9PJ4oGPUfsf/LvEFCMknOwNLRmuuyae2k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZQ2I1Rc41hpmNvoN8irGwheT1lNzZ+FS5XiApubOClqpcN/p+WPWjnBrkEOecyb24
	 fVHee+tqcepgI3wcCAnEGpwtgH9NNGO7DLj3mJMEyuX8A4KR+U17Gi+Ac2LEZVTLB9
	 geOTCPjabNPQdkIJqOcT24MwO214UfU+DAzw8PwGS6632Qdsadt0CfDAtRi6zxNCcZ
	 vDP1z8QoMP6hr/lu0B9L5dwTZefPhnBKDhCQgOYhoJkQXPmRK5g/7s12zEhbaaZ4e2
	 dddpOu4K9IRv48hmIrCEqMCyxn++EF2NoD4g76GJ4NWaEt/l7FE0MEZScMRkT7HrS0
	 kxUxqJ6zJ0twg==
Date: Thu, 2 Jan 2025 11:33:34 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc: Fabio Estevam <festevam@denx.de>, kernel@pengutronix.de,
	Lukasz Luba <lukasz.luba@arm.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>, linux-pm@vger.kernel.org,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	chrome-platform@lists.linux.dev,
	Guenter Roeck <groeck@chromium.org>,
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
	Benson Leung <bleung@chromium.org>,
	linux-security-module@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>, devicetree@vger.kernel.org,
	Serge Hallyn <serge@hallyn.com>, Zhang Rui <rui.zhang@intel.com>,
	Mark Brown <broonie@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/11] dt-bindings: thermal: give OS some leeway in
 absence of critical-action
Message-ID: <173583921303.72780.9548337351300599303.robh@kernel.org>
References: <20241219-hw_protection-reboot-v1-0-263a0c1df802@pengutronix.de>
 <20241219-hw_protection-reboot-v1-9-263a0c1df802@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241219-hw_protection-reboot-v1-9-263a0c1df802@pengutronix.de>


On Thu, 19 Dec 2024 08:31:30 +0100, Ahmad Fatoum wrote:
> An operating system may allow its user to configure the action to be
> undertaken on critical overtemperature events.
> 
> However, the bindings currently mandate an absence of the critical-action
> property to be equal to critical-action = "shutdown", which would mean
> any differing user configuration would violate the bindings.
> 
> Resolve this by documenting the absence of the property to mean that the
> OS gets to decide.
> 
> Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
> ---
>  Documentation/devicetree/bindings/thermal/thermal-zones.yaml | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


