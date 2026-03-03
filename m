Return-Path: <linux-pm+bounces-43531-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IBIgJv5np2mghAAAu9opvQ
	(envelope-from <linux-pm+bounces-43531-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 04 Mar 2026 00:00:14 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C02C81F83B2
	for <lists+linux-pm@lfdr.de>; Wed, 04 Mar 2026 00:00:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AE1CA30416F8
	for <lists+linux-pm@lfdr.de>; Tue,  3 Mar 2026 23:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0835438C433;
	Tue,  3 Mar 2026 23:00:09 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2460351C3A;
	Tue,  3 Mar 2026 23:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772578808; cv=none; b=jSKXqCSryMk3J48TfNKmXmGqzZySoawO15WEqbiOmSuW6rWq8EoBS1N8CDv7BVywIBp+umW3Xyyqk4x/vBpu/51FsjJYXSNCGA9cSiwznCzEBZEDT0uvqGWPiTXlMfJu2GQgpDtqjNnM+XVRypD4CrFH/k1whukQPXfx0nNXTwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772578808; c=relaxed/simple;
	bh=o22TXmcqQuQF5iyQXMGXcG45k3u1ANWh9bPqAF68sbg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=MsSyNIJGffb/uG2M3bI45eYIJxLWjQbLJY9YBL3MWt39lZ68KVwhKbQLr9lXUJELe1++nysUDukW2ijlHhagl76U1i7W8Og5P8CIKd4rPHDcUAffxl4uVikklc+04SZ5rkP/Q2V/dC2uEqBr0o//LRmq3+RjbJqonG2+1Y0AxV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6032FC2BCAF;
	Tue,  3 Mar 2026 23:00:08 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id 38699180D07; Wed, 04 Mar 2026 00:00:06 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Santosh Shilimkar <ssantosh@kernel.org>, 
 Sebastian Reichel <sre@kernel.org>, Andrew Davis <afd@ti.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
In-Reply-To: <20260303175959.75647-1-afd@ti.com>
References: <20260303175959.75647-1-afd@ti.com>
Subject: Re: [PATCH v2] power: reset: keystone: Use
 register_sys_off_handler(SYS_OFF_MODE_RESTART)
Message-Id: <177257880621.673153.6832215237201765827.b4-ty@collabora.com>
Date: Wed, 04 Mar 2026 00:00:06 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Rspamd-Queue-Id: C02C81F83B2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[collabora.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_RCPT(0.00)[linux-pm];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-0.994];
	R_DKIM_NA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[sebastian.reichel@collabora.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-43531-lists,linux-pm=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[]
X-Rspamd-Action: no action


On Tue, 03 Mar 2026 11:59:59 -0600, Andrew Davis wrote:
> Function register_restart_handler() is deprecated. Using this new API
> removes our need to keep and manage a struct notifier_block.
> 
> 

Applied, thanks!

[1/1] power: reset: keystone: Use register_sys_off_handler(SYS_OFF_MODE_RESTART)
      commit: c2bfe2edf741b6ae03acda7ab795974cf53d342c

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


