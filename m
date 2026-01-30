Return-Path: <linux-pm+bounces-41806-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id /tx2MaQvfWnKQgIAu9opvQ
	(envelope-from <linux-pm+bounces-41806-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 30 Jan 2026 23:24:36 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6682EBF16D
	for <lists+linux-pm@lfdr.de>; Fri, 30 Jan 2026 23:24:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 56D383004618
	for <lists+linux-pm@lfdr.de>; Fri, 30 Jan 2026 22:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C34E3876A5;
	Fri, 30 Jan 2026 22:24:32 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534EE3074BA;
	Fri, 30 Jan 2026 22:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769811872; cv=none; b=timY6ezIb3AJ8IhwzCA+DTTAes0yhbsQZJbx1hyK2XLNUeV0ba5iLQHBuRsVJ8iTacy+uob/8KveQoetW9AHybw6dzft5y3rHYpl2YModAeFkHqDLV8xvqY3yYRuKAN1/r14nFS5Vll7a8bZbf89S+GrtU0Vf7Wr+v/1WFcFMJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769811872; c=relaxed/simple;
	bh=NavC2bb9AEBm27HWFCCpX0NYxKn+Bm1XTB0FfrsTJ+k=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=TyctlbVXZanxlETZPH6hXl6ZxutRMOYVJaf2Z9hRZw/BMgjSKx6XmdKmR4Xnl+GTKaZ4MgZ+gyuQoCaYnvJSMDRXhYEhJDFo+uQn1Gy8McZG0DbiIH+/MraZOQyaMATIaVTfF5LOb7anZN3S5euEs3WrYfjBDCmMZNyI176e3H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5924C16AAE;
	Fri, 30 Jan 2026 22:24:31 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id B89A9180595; Fri, 30 Jan 2026 23:24:27 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Sebastian Reichel <sre@kernel.org>, Nikita Travkin <nikita@trvn.ru>, 
 Waqar Hameed <waqar.hameed@axis.com>
Cc: kernel@axis.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <e2a4cd2fcd42b6cd97d856c17c097289a2aed393.1769163273.git.waqar.hameed@axis.com>
References: <e2a4cd2fcd42b6cd97d856c17c097289a2aed393.1769163273.git.waqar.hameed@axis.com>
Subject: Re: [PATCH] power: supply: pm8916_lbc: Fix use-after-free for
 extcon in IRQ handler
Message-Id: <176981186774.331784.1512073948945933608.b4-ty@collabora.com>
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
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[collabora.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_RCPT(0.00)[linux-pm];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-1.000];
	R_DKIM_NA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[sebastian.reichel@collabora.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-41806-lists,linux-pm=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: 6682EBF16D
X-Rspamd-Action: no action


On Fri, 23 Jan 2026 11:24:20 +0100, Waqar Hameed wrote:
> Using the `devm_` variant for requesting IRQ _before_ the `devm_`
> variant for allocating/registering the `extcon` handle, means that the
> `extcon` handle will be deallocated/unregistered _before_ the interrupt
> handler (since `devm_` naturally deallocates in reverse allocation
> order). This means that during removal, there is a race condition where
> an interrupt can fire just _after_ the `extcon` handle has been
> freed, *but* just _before_ the corresponding unregistration of the IRQ
> handler has run.
> 
> [...]

Applied, thanks!

[1/1] power: supply: pm8916_lbc: Fix use-after-free for extcon in IRQ handler
      commit: 23067259919663580c6f81801847cfc7bd54fd1f

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


