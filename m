Return-Path: <linux-pm+bounces-41807-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oDshHKgvfWnKQgIAu9opvQ
	(envelope-from <linux-pm+bounces-41807-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 30 Jan 2026 23:24:40 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 07639BF194
	for <lists+linux-pm@lfdr.de>; Fri, 30 Jan 2026 23:24:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C294F3019390
	for <lists+linux-pm@lfdr.de>; Fri, 30 Jan 2026 22:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77910388852;
	Fri, 30 Jan 2026 22:24:32 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5587837AA64;
	Fri, 30 Jan 2026 22:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769811872; cv=none; b=K7e+nVIaCsZlPbNoXtBl4SHzIH2rvS6ZODHkrTXTgow9ADAqc8zbXeA3K9qLVjtUzrimIYn1SlLWeHI9q6i9l3JIUchN/ncrzionUKBrqL43LOfFgG6P/ebDHtglMdy0M5bR26xBlv8wfCNMfNx8wXUN0MW+b7je7IVcmIf4/Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769811872; c=relaxed/simple;
	bh=gcswa17x7vAac8H8ISWVP/qXvu8V+YccoFtXeiHYCMg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=cm4ni9w0WBycRAc9+Y3A3ty4bI6TCrWrgrUnNe39WAVGQnaMFqDJNqKKi+1GWrnOVoRNmNJdnT8mkpACxW1dpoNIdax/O8VRCncv+sZagLmMhE1kh90z9d7mehpeCLOUgnNF7syOKrwBrtOSarJDo8Ak1/Y92Mm63wW5BO0hgZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C294EC4CEF7;
	Fri, 30 Jan 2026 22:24:31 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id CC3181805A0; Fri, 30 Jan 2026 23:24:27 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: airlied@gmail.com, simona@ffwll.ch, maarten.lankhorst@linux.intel.com, 
 mripard@kernel.org, tzimmermann@suse.de, robh@kernel.org, 
 krzk+dt@kernel.org, conor+dt@kernel.org, dmitry.torokhov@gmail.com, 
 sre@kernel.org, gregkh@linuxfoundation.org, jirislaby@kernel.org, 
 lgirdwood@gmail.com, broonie@kernel.org, 
 Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: jserv@ccns.ncku.edu.tw, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-input@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-serial@vger.kernel.org, linux-sound@vger.kernel.org, 
 Yu-Chun Lin <eleanor.lin@realtek.com>
In-Reply-To: <20260113092602.3197681-1-visitorckw@gmail.com>
References: <20260113092602.3197681-1-visitorckw@gmail.com>
Subject: Re: (subset) [PATCH v4 0/6] dt-bindings: goldfish: Convert to DT
 schema
Message-Id: <176981186782.331784.16669920696929509019.b4-ty@collabora.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[collabora.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-41807-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,ffwll.ch,linux.intel.com,kernel.org,suse.de,linuxfoundation.org];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sebastian.reichel@collabora.com,linux-pm@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[24];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 07639BF194
X-Rspamd-Action: no action


On Tue, 13 Jan 2026 09:25:56 +0000, Kuan-Wei Chiu wrote:
> Convert the Android Goldfish emulator platform bindings from text
> format to DT schema.
> 
> Most of these bindings are currently located in
> Documentation/devicetree/bindings/goldfish/. Move them to the
> appropriate subsystem directories (serial, input, power, sound, misc)
> to align with the kernel directory structure.
> 
> [...]

Applied, thanks!

[4/6] dt-bindings: power: supply: google,goldfish-battery: Convert to DT schema
      commit: 4c3f02f843999a590f4481791f59a2f9a7f34fe4

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


