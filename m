Return-Path: <linux-pm+bounces-24372-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 433E7A6B9F2
	for <lists+linux-pm@lfdr.de>; Fri, 21 Mar 2025 12:33:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDADF3AFF76
	for <lists+linux-pm@lfdr.de>; Fri, 21 Mar 2025 11:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC11322370A;
	Fri, 21 Mar 2025 11:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EHKWPx6z"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC174155753;
	Fri, 21 Mar 2025 11:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742556773; cv=none; b=g7g0OJ8byt8OuV22+x5VZJh3ORi2P+F/wMJCUTYwtAH7VPJoBGKzw53/dmcT6YfNH0PZVTeVce1i4qy5KAjoIvFOO+i5o1npW1ISHQKDdqsvCCGukld0/+PntJANhgtw1TSOgEbLQnJtiP/Pv5PGTAYVl3NAprL4cTncxnnt230=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742556773; c=relaxed/simple;
	bh=thGuF3rwJihqxHfpwT/xQ7dl/3hvnzuOYMlnV7gGVm4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ZyBVJ/T2AG2Hv1qdmD1zVZbe8nLViMoJXofoW2Wj5wE66T2FvWrH1B8Oyb9GUfwuxJS84BAnmOWnXio9/63T4sehbvGJ9xzgHxj9syjKrsktfmSL/eaugaMtnPUHJwXbhUshFWPAo3UatB8XPAzG8JxdjOPnPmeA2eGcW6bICjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EHKWPx6z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 692A2C4CEE3;
	Fri, 21 Mar 2025 11:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742556773;
	bh=thGuF3rwJihqxHfpwT/xQ7dl/3hvnzuOYMlnV7gGVm4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=EHKWPx6zc8CSmKQULK8B1xcUHLeIU3jzwt9B86AqSqGwDSaNGNYuTJwoMBFt8d77y
	 CEK2dD4XyFGfYsyeQ7eI9atqpYJcguBOt5N3ZuwS+pidqFAf6ETDZQ417AS8aoy+T4
	 IDsdLzSPybMTmdK7dC5fKtz38H77DfvZL0Pp6KHJAdJ0IYaiTKcvrvRyqSIdorsYIO
	 x4aFXb0HOsA5g329+WgsmXTqR1+AxIlDfOqWK2lU8b0adcjWJksC51AExTMHWa/tJX
	 b7C2HeRJv2cFlQC/u8uY2DOVB2pC5dLSccOhP1MOQrxOr9gNCfzwKhZIZffV7kTJf5
	 j1xNMkBYooUqw==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
 conor+dt@kernel.org, claudiu.beznea@tuxon.dev, sre@kernel.org, 
 nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, 
 p.zabel@pengutronix.de, Ryan.Wanner@microchip.com
Cc: linux@armlinux.org.uk, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rtc@vger.kernel.org
In-Reply-To: <92543fcff4ab35e770b01d4c15d45cc5d55833f4.1740671156.git.Ryan.Wanner@microchip.com>
References: <cover.1740671156.git.Ryan.Wanner@microchip.com>
 <92543fcff4ab35e770b01d4c15d45cc5d55833f4.1740671156.git.Ryan.Wanner@microchip.com>
Subject: Re: (subset) [PATCH v3 02/21] dt-bindings: mfd: syscon: add
 microchip,sama7d65-sfrbu
Message-Id: <174255677015.2092266.3581610195037077485.b4-ty@kernel.org>
Date: Fri, 21 Mar 2025 11:32:50 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev-510f9

On Thu, 27 Feb 2025 08:51:49 -0700, Ryan.Wanner@microchip.com wrote:
> Add SAMA7D65 SFRBU compatible string to DT bindings documentation
> 
> 

Applied, thanks!

[02/21] dt-bindings: mfd: syscon: add microchip,sama7d65-sfrbu
        commit: 7e3ff6785039796728a515ea6e07378823e71be1

--
Lee Jones [李琼斯]


