Return-Path: <linux-pm+bounces-39645-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E21ACC6CD8
	for <lists+linux-pm@lfdr.de>; Wed, 17 Dec 2025 10:31:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AB988300E009
	for <lists+linux-pm@lfdr.de>; Wed, 17 Dec 2025 09:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29092337B8B;
	Wed, 17 Dec 2025 09:31:34 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from silergymicro.com (unknown [218.94.11.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D36D12BEFFB;
	Wed, 17 Dec 2025 09:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.94.11.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765963894; cv=none; b=Whq3ieLwbDcVwBdJsHzC2R5B47mlHE3GihAB0SU5pUCkZkwOI1csKAJ2/rJDn+BCJoYPtKlPoGAwXanOdNYfddQBxM/b5SIhnGPDSPr7pXSO6JoX5RvIdLocv9k1YCo28iU8h8Fdx20my6v3VMjsWsNLlSjgTghdqeIzHj0LWZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765963894; c=relaxed/simple;
	bh=CnlrdsMy+lcyn/m7HVPqbnmkIZ2+U9SUMA6k2VxpBpE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aBlbmLRykzWMremyz5SkBKJgBGFozs/EQOJi6eRLATdQht1Gtci8lBTxB8zAovU2ay8u6foKrHJRegA5zu7ucvlB6tHlOC9zDFGLcWHBluFpUhxKSQOf266XLG78BlclES5wpeXo7qzCF87EQAfQTZVOxbhk34b8vkNDYcEro64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=silergymicro.com; spf=none smtp.mailfrom=silergymicro.com; arc=none smtp.client-ip=218.94.11.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=silergymicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=silergymicro.com
Received: from getian-VirtualBox.. (unknown [10.2.25.100])
 by mail.silergymicro.com (Postfix) with ESMTPA id 80562182DA808;
 Wed, 17 Dec 2025 17:31:21 +0800 (CST)
From: "tian.ge" <tian.ge@silergymicro.com>
To: krzk@kernel.org
Cc: krzk+dt@kernel.org, robh@kernel.org, conor+dt@kernel.org, sre@kernel.org, 
 devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, lei.zhang@silergycorp.com,
 frank.fan@silergymicro.com
Subject: Re: [PATCH] dt-bindings: power: supply: Add Silergy SY6974B charger
Date: Wed, 17 Dec 2025 17:30:58 +0800
Message-Id: <20251217093058.183290-1-tian.ge@silergymicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <43033462-bdea-48b2-9108-acc29b60e82e@kernel.org>
References: <43033462-bdea-48b2-9108-acc29b60e82e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TraceID: 17659638827mT5C
Content-Type: text/plain; charset="utf-8"

On Tue, 16 Dec 2025 06:33:25 +0100, Krzysztof Kozlowski<krzk@kernel.org> wrote:

> On 16/12/2025 03:18, tian.ge wrote:
> > Add bindings for the Silergy SY6974B I2C controlled charger.
> 
> Why? Where is any user of this?
> 
> Plus this was not tested, so I finish review here. You did not follow
> basic DT binding rules, please read first writing-bindings doc or my
> DTS101 talk.
> 
> Best regards,
> Krzysztof

Hi Krzysztof,

Thanks for your feedback, and thanks to the bot for the dt-bindings-check report!

Apologies for the issues in my initial submission:
1. I didn't run `make dt_binding_check` for the DT binding (unaware of this mandatory step);
2. The driver and DT binding were sent as separate patches with different recipients, making the driver invisible to DT maintainers.

Clarification: The SY6974B driver patch is already submitted (Message-Id: 20251216021408.654926-1-tian.ge@silergymicro.com). It’s the direct user of this DT binding.

I’ve now fixed all issues:
1. Updated DT binding: Replaced all 'sy,' prefixes with 'silergy,' (passes `make dt_binding_check` and `yamllint`);
2. Synced driver: Parses 'silergy,xxx' properties (consistent with binding, compiles cleanly).

I’ll resubmit a unified v2 series (cover letter + DT binding + driver) to all relevant maintainers (DT + power supply) to resolve the association issue.

Thanks,
Tian
 This email contains information from Silergy Corp. that may be confidential or privileged. Such information is solely for the intended recipient(s).Any review, retransmission, dissemination, disclosure or other use of this information by persons or entities other than intended recipient(s) is strictly prohibited. If you have received this email in error, please notify the sender immediately and delete this email together with any correspondences. 

