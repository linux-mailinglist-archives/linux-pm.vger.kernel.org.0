Return-Path: <linux-pm+bounces-43460-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eGurG4YdpmmeKQAAu9opvQ
	(envelope-from <linux-pm+bounces-43460-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 03 Mar 2026 00:30:14 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D1DC1E6ABD
	for <lists+linux-pm@lfdr.de>; Tue, 03 Mar 2026 00:30:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D8F1B310563D
	for <lists+linux-pm@lfdr.de>; Mon,  2 Mar 2026 23:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 881A331E824;
	Mon,  2 Mar 2026 23:07:23 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D6DE282F26;
	Mon,  2 Mar 2026 23:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772492843; cv=none; b=qeVxthwsHSSDX8JoqZF1Jv1ci44s3eX9lC1YFCIufTrpexSgKO1JLcXQFmXyC/6h0IB8LX52K+kE7uEe01HrxpDRE89eP387UHGRP8NrW35obUmmi+xrufGTMUca18V95tNTVO1binHlYT9jzQFmY04fU5M4K/54Qq8+W2JtGfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772492843; c=relaxed/simple;
	bh=ycFyZ+2OPtSQUMGDkeK2X/Als0EVkUTb0DooUFNPgAw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=AmaH2cpt2WBTeU3/AVySx/ovHU6MJquT0bnTZ0aRrEJY0O1v4eaJ4o5pVfgjydI1WzpfvM21bSqFiXatUjMwpoIRAfqE8Kfr++M7FwinRIcY4Qu3bfXGnG5mYiOh0CVyJX+9xdRfJEvElT206FPXSmrG2nQbzIF451Un6ceYAJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2153C2BC86;
	Mon,  2 Mar 2026 23:07:22 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id E2DAE181258; Tue, 03 Mar 2026 00:07:20 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Sebastian Reichel <sre@kernel.org>, 
 Bartosz Golaszewski <bgolasze@quicinc.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-pm@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>, 
 Bartosz Golaszewski <brgl@kernel.org>, 
 Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
In-Reply-To: <20260224-next-15nov_expose_sysfs-v24-0-4ee5b49d5a06@oss.qualcomm.com>
References: <20260224-next-15nov_expose_sysfs-v24-0-4ee5b49d5a06@oss.qualcomm.com>
Subject: Re: [PATCH v24 0/2] reboot-mode: Expose sysfs for registered
 reboot modes
Message-Id: <177249284091.588775.5455809709989492686.b4-ty@collabora.com>
Date: Tue, 03 Mar 2026 00:07:20 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Rspamd-Queue-Id: 3D1DC1E6ABD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[collabora.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43460-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sebastian.reichel@collabora.com,linux-pm@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.921];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[collabora.com:mid,collabora.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action


On Tue, 24 Feb 2026 12:12:25 +0530, Shivendra Pratap wrote:
> The reboot-mode framework provides infrastructure for drivers that want
> to implement a userspace reboot command interface. However, there is
> currently no standardized way for userspace to discover the list of
> supported commands at runtime. This series introduces a sysfs interface
> in the reboot-mode framework to expose the list of supported reboot-mode
> commands to userspace. This will enable userspace tools to query
> available reboot modes using the sysfs interface.
> 
> [...]

Applied, thanks!

[1/2] Documentation: ABI: Add sysfs-class-reboot-mode-reboot_modes
      commit: d6c612a2131a41fc5c68ee75e56308313523a668
[2/2] power: reset: reboot-mode: Expose sysfs for registered reboot_modes
      commit: ee5fe3b1c5dd22e575e4bacf79e0d6f2b11137e1

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


