Return-Path: <linux-pm+bounces-37995-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C292C59E18
	for <lists+linux-pm@lfdr.de>; Thu, 13 Nov 2025 20:59:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6C17D354647
	for <lists+linux-pm@lfdr.de>; Thu, 13 Nov 2025 19:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DD0F31B10B;
	Thu, 13 Nov 2025 19:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="s8nBX6me"
X-Original-To: linux-pm@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C4E76026;
	Thu, 13 Nov 2025 19:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763063885; cv=none; b=EQbintq5nkfk/CugOqCfCV6plDws3ROye/Ebp7F/UXRlSLjRknPuYJj9wIG1d8puDD4ogWaMcOBiLA0SUfK/m8GrOe8b162abGLzWkr3GN6GYgH0FOEVjM24774tzc5TAKQwFbBsYmH/wgiG68z0V2uwOKMc2YahjEtfn0ZboE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763063885; c=relaxed/simple;
	bh=iBTFanEIxOT4IMFjt8xI4rzsbKY4Dm6/ucMLBZ2V4gc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V6uD83LAFoeD+1+MQ6C0YAZIyfCH1tlLiSs+0iyFqWGpxXiUjHifCCLSwfwpEbXm8fx8X/TFP2p8D0WgGUaIAshFV3SjGmtXqJ9MYh3s6Jcp7LIl5aPpBnjDS83s+8pyWiSR9lcAs1mbY3ku5RE6yjGAs2swlXAwxAreKIU85eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=s8nBX6me; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=UAioK4DG5C9zm1t6hyaDe3YJWZ5Zta/Pw1nq2GgNNgY=; b=s8nBX6meJGhwpK5oym8SCA1bBN
	z878G0qTQ9+6fUcBwxozuPeScqbLnkG7YsmhzqixQWUn5FI1u32s6nqnXYqlaBYeAqZxyPcIt69MB
	nlSjbE8HNu0b6W3d8PHadWuCK4lBcqX8C2/Z0kOWLUNFa6otjf2JnKpa67Stcf4MQu6L4ahKkPlOA
	T+ICIPJcO9SOPElSasN6sqmBjgPw8y/Nnwm22MZvaQMQKMKB2HaTMCYnDk4Q9z18T1+ttd43SBl3o
	5Qu/YqIlbSC77sUbZB+l0oB+WhFEzJ16i6qVoh0EsSFEWhfxQfBqYF7YuEzMmDyRg0IQ/jqfjCe++
	1w4Wf6rA==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJdSB-0000000B37a-2kPs;
	Thu, 13 Nov 2025 19:57:59 +0000
Message-ID: <2b5e182f-1933-41b1-803d-7084fbc4bbdc@infradead.org>
Date: Thu, 13 Nov 2025 11:57:58 -0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/13] Documentation: leds: document pattern behavior of
 Samsung S2M series PMIC RGB LEDs
To: Kaustabh Chakraborty <kauschluss@disroot.org>, Lee Jones
 <lee@kernel.org>, Pavel Machek <pavel@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, MyungJoo Ham <myungjoo.ham@samsung.com>,
 Chanwoo Choi <cw00.choi@samsung.com>, Sebastian Reichel <sre@kernel.org>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Jonathan Corbet <corbet@lwn.net>
Cc: linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-samsung-soc@vger.kernel.org, linux-rtc@vger.kernel.org,
 linux-doc@vger.kernel.org
References: <20251114-s2mu005-pmic-v1-0-9e3184d3a0c9@disroot.org>
 <20251114-s2mu005-pmic-v1-11-9e3184d3a0c9@disroot.org>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20251114-s2mu005-pmic-v1-11-9e3184d3a0c9@disroot.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/13/25 11:05 AM, Kaustabh Chakraborty wrote:
> Add documentation to describe how hardware patterns (as defined by the
> documentation of led-class-multicolor) are parsed and implemented by the
> Samsung S2M series PMIC RGB LED driver.
> 
> Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
> ---
>  Documentation/leds/index.rst        |  1 +
>  Documentation/leds/leds-s2m-rgb.rst | 60 +++++++++++++++++++++++++++++++++++++
>  2 files changed, 61 insertions(+)
> 

> diff --git a/Documentation/leds/leds-s2m-rgb.rst b/Documentation/leds/leds-s2m-rgb.rst
> new file mode 100644
> index 000000000000..cf91f0238093
> --- /dev/null
> +++ b/Documentation/leds/leds-s2m-rgb.rst
> @@ -0,0 +1,60 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +======================================
> +Samsung S2M Series PMIC RGB LED Driver
> +======================================
> +
> +Description
> +-----------
> +
> +The RGB LED on the S2M series PMIC hardware features a three-channel LED that is
> +grouped together as a single device. Furthermore, the it supports 8-bit

                                           drop the  ^^^

> +brightness control for each channel. This LED is typically used as a status
> +indicator in mobile devices. It also supports various parameters for hardware
> +patterns.

-- 
~Randy


