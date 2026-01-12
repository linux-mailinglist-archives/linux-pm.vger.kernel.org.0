Return-Path: <linux-pm+bounces-40622-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DF281D104BE
	for <lists+linux-pm@lfdr.de>; Mon, 12 Jan 2026 02:56:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4E6AC3026529
	for <lists+linux-pm@lfdr.de>; Mon, 12 Jan 2026 01:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B69CB23E350;
	Mon, 12 Jan 2026 01:56:06 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D3F523BD1D;
	Mon, 12 Jan 2026 01:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768182966; cv=none; b=IfbR0X2CVku87WmaCY0VJR5s8PmkKVLTUuAgUkk5oNG8vYSLcfy7mthOfUKnivu6BQn2AZimj8+s2rhcSQPkXP1NoYVfElUwA5ecnAX9VRLMn4dlUGDwx02LU+ZUj49eawpkRXx6zl9JrJh0VBadDxHgPGBiO2jRdwHRycXZ0IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768182966; c=relaxed/simple;
	bh=rJ40Onk2WfUIDqCrJg2CPci+mjzX7eyFpqmDoDAOQcg=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=UMgB+GnpNo8cZivB01RcxopTVgm3GcThi8H9kD8Mfto/avr5nF+utiEXJgG5WWST8u0C+oF+liJCPNo5AHueXwK52XNxQ540au76ICFwg9ZqYvKoQrhU3xHIzVWOlJ/6AK0MKV331ihHv5yLRDzjP9S0G1SU/xyWuBshwgryqwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 324F1C4AF0C;
	Mon, 12 Jan 2026 01:56:06 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id 1DC23180616; Mon, 12 Jan 2026 02:56:04 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
In-Reply-To: <20251126171859.72465-2-krzysztof.kozlowski@oss.qualcomm.com>
References: <20251126171859.72465-2-krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: [PATCH] power: supply: sysfs: Constify pointer passed to
 dev_attr_psp()
Message-Id: <176818296411.643060.2005068815402392167.b4-ty@collabora.com>
Date: Mon, 12 Jan 2026 02:56:04 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Wed, 26 Nov 2025 18:19:00 +0100, Krzysztof Kozlowski wrote:
> Memory pointer by pointer passed to dev_attr_psp() is not modified, so
> with help of container_of_const() (preferred than container_of()) can be
> made pointer to const for code safety.
> 
> 

Applied, thanks!

[1/1] power: supply: sysfs: Constify pointer passed to dev_attr_psp()
      commit: 2c7e46e1318d4fbf514f454d5a746a1b76d06ebe

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


