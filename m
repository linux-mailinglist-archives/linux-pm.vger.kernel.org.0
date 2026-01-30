Return-Path: <linux-pm+bounces-41810-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +AalJMYvfWnTQgIAu9opvQ
	(envelope-from <linux-pm+bounces-41810-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 30 Jan 2026 23:25:10 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 704B7BF1D7
	for <lists+linux-pm@lfdr.de>; Fri, 30 Jan 2026 23:25:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 225A43018404
	for <lists+linux-pm@lfdr.de>; Fri, 30 Jan 2026 22:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06276389DFA;
	Fri, 30 Jan 2026 22:24:34 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE3CB389DE9;
	Fri, 30 Jan 2026 22:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769811873; cv=none; b=WY31p3L/nlrwebHs/g8WFPUQeHjVzvTGKl5XVtpnldEZ6Jv7JcsNQ1mnB0JfnzZ+jPtpArNRgu68dsIefzD/DEjaA1H93SNSHRDriVlkLzwnXz99oOI3hDX78D5oNvhNK0P9bwVgOAwYkTOS2tKDqxZa8btHGClDg2mknhS/VhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769811873; c=relaxed/simple;
	bh=KXLPZDFw8ClfGR6yvhfI7UCYDHsgAOLDlb+0biunI7M=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Xkw5TFy9tA61ctId4rGSKEZHKIhfz1eMsVKfmbsIBEwzS0plS7ovSW5schYIOT0ISx13S2wieUvfInhjR9EBV5EntDIjq82EDNYItjUqXB6Gcl2+FmiN6ylAKNAFWAyxId+lxgGNrvLNYLOWY/ES9/vCYI6ess9tZOOUdU5RGx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80F6CC16AAE;
	Fri, 30 Jan 2026 22:24:33 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id BB302180596; Fri, 30 Jan 2026 23:24:27 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Sebastian Reichel <sre@kernel.org>, 
 Waqar Hameed <waqar.hameed@axis.com>
Cc: kernel@axis.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <cover.1769158280.git.waqar.hameed@axis.com>
References: <cover.1769158280.git.waqar.hameed@axis.com>
Subject: Re: [PATCH v2 0/2] power: supply: wm97xx: Use devm-variants in
 probe
Message-Id: <176981186775.331784.16421404001791768718.b4-ty@collabora.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[collabora.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_RCPT(0.00)[linux-pm];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-1.000];
	R_DKIM_NA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[sebastian.reichel@collabora.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-41810-lists,linux-pm=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: 704B7BF1D7
X-Rspamd-Action: no action


On Fri, 23 Jan 2026 09:55:42 +0100, Waqar Hameed wrote:
> This patch series contains some clean-ups that makes life a little
> easier. It was originally triggered by a NULL pointer fix in this driver
> that has already been applied from the previous version [1]. Therefore
> note that this series is based on `for-next` branch in Sebastian
> Reichel's tree [2].
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git/commit/?h=for-next&id=39fe0eac6d755ef215026518985fcf8de9360e9e
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git/?h=for-next
> 
> [...]

Applied, thanks!

[1/2] power: supply: wm97xx: Use devm_kcalloc()
      commit: 72db889394d89ffde61e7438f0cdfc0135c9da48
[2/2] power: supply: wm97xx: Use devm_power_supply_register()
      commit: 3db37475d78ed0c2857f289a535dd44b045a904a

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


