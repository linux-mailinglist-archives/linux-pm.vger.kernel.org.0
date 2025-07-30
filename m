Return-Path: <linux-pm+bounces-31590-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7810DB15B34
	for <lists+linux-pm@lfdr.de>; Wed, 30 Jul 2025 11:05:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4235954602F
	for <lists+linux-pm@lfdr.de>; Wed, 30 Jul 2025 09:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02F1B269AFB;
	Wed, 30 Jul 2025 09:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b="qn6IzzQn"
X-Original-To: linux-pm@vger.kernel.org
Received: from mg.richtek.com (mg.richtek.com [220.130.44.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1AD224FA;
	Wed, 30 Jul 2025 09:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.130.44.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753866347; cv=none; b=DZ41MJNpTm/X1ObkyJfRMe1z+Ft/bwj7Pk5qVnMXayIIzZdcbLHzs9k+/jmclFAR7oR7Kx5jS4gxaClBzvq9b5MsRm96wPYeYEfn5azu+IBITMvxjmgS0ECq5sv3wp3lysAn7QF4k/CXyocB8nWTJnKukS7QYu0iRnDSv2gdhGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753866347; c=relaxed/simple;
	bh=naaVdgtZ0z1BxKrq93z+pHLnaK251hNNYsq6gYM2fmw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tseoBFZEjKn/WOjRtaR2hWr8NDlvFE5L5IZW1PU8arhUxQmjNAxZ18Rxs4k+sCjrz292E3EUma8HHuZLUJpgHX/l3+T/OlzTn+ZRkx8mXELdfHB7qM1Ge0ygr1LJvG7zCgJEekkp4SVVsVMrsYm1oni61FJHsu9VWGGOPajJGeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=richtek.com; spf=pass smtp.mailfrom=richtek.com; dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b=qn6IzzQn; arc=none smtp.client-ip=220.130.44.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=richtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=richtek.com
X-MailGates: (SIP:2,PASS,NONE)(compute_score:DELIVER,40,3)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=richtek.com;
	s=richtek; t=1753866336;
	bh=DWDhG8YufmpT/BziEi411fDq4qj6Nf47AAmyugYtyxI=; l=2163;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=qn6IzzQnDoNUJa6uTz0yNjWywt0XnerBP6nVfreZigGtZhl6ONyiXgiXZm8oNzZJv
	 fddb8pog+pyQoYMW3f5E3Oh7Jw5JnaX9I1ZBL9RvXPgCSQ4+ZVwMH8riuCuNCnedkX
	 i/CHiMQKZnxFpJxe/yBfe9Li7SOVS09bgamva4NikRf5LUKQWeCiZdbdmNWAOb80fe
	 eKBRNpK7aHNoWseBoHry6NX3OnSlvGojf4ij1nVa2UkO3vmfsUqg7brdHiW58/BL4a
	 kr88b4yBCfdeaRDAYlsnO4JOjMX1cGtnaRaCenrJ4hwgpWR3lSDt1zX7rZucYCqyej
	 xgTTzkIqxFpog==
Received: from 192.168.10.47
	by mg.richtek.com with MailGates ESMTPS Server V6.0(244603:0:AUTH_RELAY)
	(envelope-from <cy_huang@richtek.com>)
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256/256); Wed, 30 Jul 2025 17:05:21 +0800 (CST)
Received: from ex4.rt.l (192.168.10.47) by ex4.rt.l (192.168.10.47) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 30 Jul
 2025 17:05:21 +0800
Received: from git-send.richtek.com (192.168.10.154) by ex4.rt.l
 (192.168.10.45) with Microsoft SMTP Server id 15.2.1544.11 via Frontend
 Transport; Wed, 30 Jul 2025 17:05:21 +0800
From: <cy_huang@richtek.com>
To: <krzk@kernel.org>
CC: <conor+dt@kernel.org>, <cy_huang@richtek.com>,
	<devicetree@vger.kernel.org>, <krzk+dt@kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
	<robh@kernel.org>, <sre@kernel.org>
Subject: Re: [PATCH 1/3] dt-bindings: power: supply: Add Richtek RT9756 smart cap divider charger
Date: Wed, 30 Jul 2025 17:06:05 +0800
Message-ID: <20250730090605.2824394-1-cy_huang@richtek.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250730-giga-cricket-of-development-f886fb@kuoka>
References: <cover.1753759794.git.cy_huang@richtek.com> <3fa997b42b4aec43fc182a043cf521f7e3e7fcb3.1753759794.git.cy_huang@richtek.com> <3603a744-e898-49ef-968a-2388e14cae54@kernel.org> <aIl+VKFURqFfXKz3@git-send.richtek.com> <20250730-sassy-competent-mule-d94f1a@kuoka> <20250730-giga-cricket-of-development-f886fb@kuoka>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

> On Wed, Jul 30, 2025 at 09:39:38AM +0200, Krzysztof Kozlowski wrote:
> > On Wed, Jul 30, 2025 at 10:07:16AM +0800, ChiYuan Huang wrote:
> > > On Tue, Jul 29, 2025 at 05:40:32PM +0200, Krzysztof Kozlowski wrote:
> > > > On 29/07/2025 06:21, cy_huang@richtek.com wrote:
> > > > > +
> > > > > +  shunt-resistor-micro-ohms:
> > > > > +    description: Battery current sense resistor mounted.
> > > > > +    default: 2000
> > > > > +
> > > > > +required:
> > > > > +  - compatible
> > > > > +  - reg
> > > > > +  - wakeup-source
> > > > 
> > > > Why do you require this? I cannot find any use of it, so maybe I missed
> > > > some change in Linux code (and that's second question like that for
> > > > Richtek, so refer to your other patchsets for contexr).
> > > > 
> > > 
> > > This will mark the interrupt as wakeup capable.
> > > https://elixir.bootlin.com/linux/v6.16/source/drivers/i2c/i2c-core-of.c#L57
> > > https://elixir.bootlin.com/linux/v6.16/source/drivers/i2c/i2c-core-base.c#L547
> > 
> > OK, but this does not explain why this is required. Why it is impossible
> > to make board which uses this PMIC and wires the interrupt in a way it
> > is not waking up the system?
> > 
> > To my limited knowledge this should be possible, but what do I know
> > about hardware...
> 
> Another question is still valid, although you provided more context - if
> the device is ALWAYS waking up, this is implied by compatible and you do
> not need this property at all.
> 
> That would be the first usage of I2C client wakeup flag in drivers, but
> maybe that is how it should be done? You can consult I2C folks on IRC.

Yap, like as your saying. If not declared 'wakeup-source', it only means
if the system supports sleep state, this interrupt won't on-time notify any
event. Actually, not affect its normal functionality.

If your question is should the property 'wakeup-source' be declared as
required, then the answer should be 'No'.

When system supports suspend, to declare this property is just a suggestion.

In next revision, I'll remove 'wakeup-source' from the required property list.

All questions are clarified.

Thx.



