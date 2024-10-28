Return-Path: <linux-pm+bounces-16602-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B3479B36D1
	for <lists+linux-pm@lfdr.de>; Mon, 28 Oct 2024 17:40:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9284F1F22079
	for <lists+linux-pm@lfdr.de>; Mon, 28 Oct 2024 16:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 760181DEFE0;
	Mon, 28 Oct 2024 16:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=epochal.quest header.i=@epochal.quest header.b="NqgPwI8S"
X-Original-To: linux-pm@vger.kernel.org
Received: from thales.epochal.quest (thales.epochal.quest [51.222.15.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A23DB18B48C;
	Mon, 28 Oct 2024 16:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.222.15.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730133625; cv=none; b=UgsW0lfivLKfjlfEORx62N3lCKLheQVIUDXleTFRn9q8bl5vPOxBC61z5cfulaczXQVRYhoIn52XYmOjTS8QycuxSV7qFJ3NzseT6PW+X7ZkEDcznoPdJnYJSx/NCf2e0QvHNFUW+uRspUwYuF4TOiSQK2mHvw6sYAnO+GosuSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730133625; c=relaxed/simple;
	bh=kUEYbE6hXz/vHFt3YZ/89fRX5hOEaE51SuiUkxDzgpU=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=QTgYW5wKbHHQlnwDy5jL7Mmmxk5w5BzkF1BEYF9pOoy4+mjsJBvuVvGvERtawiw2Q0nS6643jRIF1bCQmlUM9mWSvEb49PZXiaha+5Wy1zfSPDtA8X8WtfnkGJYy4bEePmVQdQZgkf1VvOzaaX18EmkSupjxBtnFsf1Wf0TvC6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=epochal.quest; spf=pass smtp.mailfrom=epochal.quest; dkim=pass (2048-bit key) header.d=epochal.quest header.i=@epochal.quest header.b=NqgPwI8S; arc=none smtp.client-ip=51.222.15.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=epochal.quest
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=epochal.quest
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=epochal.quest;
	s=default; t=1730133622;
	bh=kUEYbE6hXz/vHFt3YZ/89fRX5hOEaE51SuiUkxDzgpU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NqgPwI8SWqQsmYbYtgFKykLcMxXKveA8fZ0lao9DCK4PCwOKJ2velptL71QECqePl
	 rnPPrmBq5vhBJHFWAkHjHgOjvV+Tdxx1/frpgF3xxOIdmt48PDbZopZfGmHnMNt1HX
	 PyBcVA3pwdn+86ChDkVznRmnBTpEK+UDiaL0dhOY6Vro28ihTcoGKewP+FaEUvmZLM
	 hS78aI46rAJAbpUFz7e2akQkorx6P76z0gbpO3+XhgTkGcCv32gz++bgOL81fGO9yc
	 0FC2lSTNFAv02g3oeI3Zg0esVml/e/H1bFXi3StthXPWEeeK4s06+vcLvh2FlOdugl
	 0TAQ5euobPX7w==
X-Virus-Scanned: by epochal.quest
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 28 Oct 2024 13:40:18 -0300
From: Cody Eksal <masterr3c0rd@epochal.quest>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Samuel Holland <samuel@sholland.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski@linaro.org>, devicetree@vger.kernel.org, Viresh Kumar
 <vireshk@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Thierry
 Reding <treding@nvidia.com>, Nishanth Menon <nm@ti.com>, Chen-Yu Tsai
 <wens@csie.org>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Yangtao Li <frank@allwinnertech.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Maxime Ripard <mripard@kernel.org>,
 Stephen Boyd <sboyd@kernel.org>, Vinod Koul <vkoul@kernel.org>,
 linux-pm@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Conor Dooley <conor+dt@kernel.org>, Florian Fainelli
 <florian.fainelli@broadcom.com>, linux-phy@lists.infradead.org,
 linux-usb@vger.kernel.org, Kishon Vijay Abraham I <kishon@kernel.org>, Andre
 Przywara <andre.przywara@arm.com>, linux-sunxi@lists.linux.dev, Yangtao Li
 <tiny.windzz@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Jernej
 Skrabec <jernej.skrabec@gmail.com>, Parthiban <parthiban@linumiz.com>
Subject: Re: [PATCH 03/13] dt-bindings: phy: sun50i-a64: add a100 compatible
In-Reply-To: <173006348387.87150.15151805812797724971.robh@kernel.org>
References: <20241024170540.2721307-1-masterr3c0rd@epochal.quest>
 <20241024170540.2721307-4-masterr3c0rd@epochal.quest>
 <173006348387.87150.15151805812797724971.robh@kernel.org>
Message-ID: <242e94322071be17480b001de0d1347b@epochal.quest>
X-Sender: masterr3c0rd@epochal.quest
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit

On 2024/10/27 6:11 pm, Rob Herring (Arm) wrote:
> On Thu, 24 Oct 2024 14:05:21 -0300, Cody Eksal wrote:
>> The USB PHY found in the A100 is similar to that found in the A64,
>> although it requires some quirks to be enabled. Add a compatible for 
>> the
>> A100's variant.
>> 
>> Signed-off-by: Cody Eksal <masterr3c0rd@epochal.quest>
>> ---
>>  .../devicetree/bindings/phy/allwinner,sun50i-a64-usb-phy.yaml    | 1 
>> +
>>  1 file changed, 1 insertion(+)
>> 
> 
> Acked-by: Rob Herring (Arm) <robh@kernel.org>
A quick note that I'm updating this patch in V2 to allow for falling 
back to the D1 compatible.

Thanks!
- Cody

