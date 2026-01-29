Return-Path: <linux-pm+bounces-41731-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UDATNbvIe2n5IQIAu9opvQ
	(envelope-from <linux-pm+bounces-41731-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 29 Jan 2026 21:53:15 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 812A9B45CF
	for <lists+linux-pm@lfdr.de>; Thu, 29 Jan 2026 21:53:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2409E3018292
	for <lists+linux-pm@lfdr.de>; Thu, 29 Jan 2026 20:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8B4A359FA5;
	Thu, 29 Jan 2026 20:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dfJ3ePgm"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C06326D76;
	Thu, 29 Jan 2026 20:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769719947; cv=none; b=XEIVUmZL/loB7Xgop+bafGocOMCx++EVfs05cUcVyKeNBJiCVBiK889Jp+Vy5CEWoz5ndZHsldKojzxua9oMqPnnzFjgD6BMtzYnjfH57ocLXII7z6Aj2pd5NV1E4+eyJCdVvj9itmo3L09qlGjfnBIyghvYEs2MGOmBfAkYNgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769719947; c=relaxed/simple;
	bh=r4nJmTNffHsty58rfHmKHziy9ddqSa1HeYW12wQ/OBY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pjozznZ7s/MG2MBw0OHBGNcTuuoCAn747BABVW9MFKFwgAB5Vx2tuveHEHlW3cs3LilB1AX0rZ5bM3N+3X7WL7icUoJD6N6tlpZETvu4+TAEYJWy8UFSTRLdo4Ih+RWYr5434KcTRW7xWghWL+9YnqZb6xzoucDaQhPFSdlet0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dfJ3ePgm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96EB5C4CEF7;
	Thu, 29 Jan 2026 20:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769719947;
	bh=r4nJmTNffHsty58rfHmKHziy9ddqSa1HeYW12wQ/OBY=;
	h=From:To:Cc:Subject:Date:From;
	b=dfJ3ePgmgFmaFPwl8d8WRen7IWrfxx9ilFjYmRV38yg29OiufSNWgiEJFBGHyDCY9
	 jfLvgYBXH07dtmupheB5E/wfUB5kf4JdRczsHFCSZJ0c8MT51sw9jncBHvs0pph30N
	 6OsPno9x0Dhr5nvZzmS4ZUAD3CGDLkhzM0z8l2USjm04Uh+CIGoNqEuwp5GIc/OZSS
	 YpLPMT/lE6NmKFUTFnaVKjZ/H77UVuEbCRAE33TIrVR+8jR+nmZgpiZfmT/jJeh2zZ
	 wzwhGkKGK4joZCHa/lgbnaVMT8CyKITHhbIV2dMN06RYKtUmqx6QfMvYwKVwEcetz8
	 gPr0kl3FJqkSg==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Christian Loehle <christian.loehle@arm.com>,
 Doug Smythies <dsmythies@telus.net>
Subject:
 [PATCH v3 0/2] cpuidle: governors: teo: Wakeup events classification change
 and refinement
Date: Thu, 29 Jan 2026 21:46:34 +0100
Message-ID: <12846604.O9o76ZdvQC@rafael.j.wysocki>
Organization: Linux Kernel Development
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	CTE_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-41731-lists,linux-pm=lfdr.de];
	TO_DN_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-pm];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,rafael.j.wysocki:mid]
X-Rspamd-Queue-Id: 812A9B45CF
X-Rspamd-Action: no action

Hi All,

This is a new version of

https://lore.kernel.org/linux-pm/12831359.O9o76ZdvQC@rafael.j.wysocki/

updating the first patch.  The second one is unchanged.

Patch [1/2] changes the criteria used for classifying wakeup events as hits
or intercepts to (hopefully) make the classification work better, especially
for large state bins.

Patch [2/2] refines the idle state lookup based on intercepts to first
consider the state with the maximum intercepts metric, so that state is
always taken into consideration.

Please see the individual patch changelogs for details.

Thanks!




