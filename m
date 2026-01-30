Return-Path: <linux-pm+bounces-41808-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uDLAE6kvfWnKQgIAu9opvQ
	(envelope-from <linux-pm+bounces-41808-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 30 Jan 2026 23:24:41 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CDD4BF19E
	for <lists+linux-pm@lfdr.de>; Fri, 30 Jan 2026 23:24:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7441A301BA67
	for <lists+linux-pm@lfdr.de>; Fri, 30 Jan 2026 22:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C83138885E;
	Fri, 30 Jan 2026 22:24:32 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56FD53859C0;
	Fri, 30 Jan 2026 22:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769811872; cv=none; b=MaWiV50djhaxxfToi8nMe4hurdEeBLzAqmZ1DUfdlq7ERo2Del0QH88TPkl4dZzFbFAsjJ/ouOo3MfNbvFK/5vTAXwIQ7vEp07V03eQGltTWgtO0BnYC3CZTPV6hivoAOlMsoMpuyQ55rBtR66vV9KWVmQ3K1usQV31y8SJCgZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769811872; c=relaxed/simple;
	bh=sGECo6MXaIdtjWqh9SaFDp75VmBvPj+LEJ+7DWp6AZ4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=F3FPUQtK17oRDhXDAIc8M0rltZzIQxj0T4eO6jOAwEov+RyRrZvm2/uREQGxU3C6K0iyMQXRI1jccMIRApbMNxgXjQKKf2fqOKUcbwt5KLGVf1uaJCDmgwlc/8sOnm4j9vxsX5jxESmHS6AgLk+t3ICyZ6HrUcjO+ZhGMSLuCEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7915C4AF09;
	Fri, 30 Jan 2026 22:24:31 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id B57D7180523; Fri, 30 Jan 2026 23:24:27 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Francesco Dolcini <francesco@dolcini.it>, 
 Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Emanuele Ghidoli <ghidoliemanuele@gmail.com>
Cc: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, 
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20260130071208.1184239-1-ghidoliemanuele@gmail.com>
References: <20260130071208.1184239-1-ghidoliemanuele@gmail.com>
Subject: Re: [PATCH v1] power: reset: tdx-ec-poweroff: fix restart
Message-Id: <176981186772.331784.8124433525678638333.b4-ty@collabora.com>
Date: Fri, 30 Jan 2026 23:24:27 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[collabora.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-41808-lists,linux-pm=lfdr.de];
	FREEMAIL_TO(0.00)[dolcini.it,kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sebastian.reichel@collabora.com,linux-pm@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 2CDD4BF19E
X-Rspamd-Action: no action


On Fri, 30 Jan 2026 08:11:35 +0100, Emanuele Ghidoli wrote:
> During testing, restart occasionally failed on Toradex modules.
> 
> The issue was traced to an interaction between the EC-based reset/poweroff
> handler and the PSCI restart handler. While the embedded controller is
> resetting or powering off the module, the PSCI code may still be invoked,
> triggering an I2C transaction to the PMIC. This can leave the PMIC I2C
> in a frozen state.
> 
> [...]

Applied, thanks!

[1/1] power: reset: tdx-ec-poweroff: fix restart
      commit: 562357a6310f79e45844c3e980d410a1e8e02ce6

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


