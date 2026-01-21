Return-Path: <linux-pm+bounces-41221-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UIrWEm2ucGkgZAAAu9opvQ
	(envelope-from <linux-pm+bounces-41221-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 21 Jan 2026 11:46:05 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A0E1D55714
	for <lists+linux-pm@lfdr.de>; Wed, 21 Jan 2026 11:46:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 62FB690998C
	for <lists+linux-pm@lfdr.de>; Wed, 21 Jan 2026 10:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F0EA47AF74;
	Wed, 21 Jan 2026 10:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="RNmK0BFK"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83987322B68
	for <linux-pm@vger.kernel.org>; Wed, 21 Jan 2026 10:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768990607; cv=none; b=sKyLVld7+yK/CIbdNC/HIm2iFLpX+6rAOPLQ9BSy1kBSzD8m/dkImSvLw9niHwamitCpCc+AG881nb4DdjMtYhiFw3QERaIR72PsjxefhhtdnThyH2fNmc7J8gwvyJJfMbTpr5Vc+9hYntQJgOYV0mTynXuUExytuJFnX9Ph7Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768990607; c=relaxed/simple;
	bh=BqJB0ky6a5o2Ecu+3eubhea+J8ftyleZiqpIAurBAes=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dU5AnSe635hzMbholI31UUhj/VxTPEaCUVFpGUVdXxNpzTIPWDOVA4yXk6er3vMLikPm0JL6EpZMbAyu4I/f5wriB+8YRdp/zi2vp1HDIVjqM9tgwCgpzwyiyBgLHzItW47FdazDeMeDVkw/PT5hOdCHwMDXticmgetQwGY06dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=RNmK0BFK; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id B638D4E421C8;
	Wed, 21 Jan 2026 10:16:41 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 6BF7B6070A;
	Wed, 21 Jan 2026 10:16:41 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 833AF119B111C;
	Wed, 21 Jan 2026 11:16:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1768990600; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=uNOQ9N5B9qlztbYZFFk35qcWieqUQXY/SvMqhArSNVg=;
	b=RNmK0BFKvkB8IF5ORRR6qJWC0XvUCd5IlBVPRrQ/iiq4Dj8rj3tn2hhx8PxXmcDpjqcAMP
	vweEPJJvrehHNpkxvoTg5lRK9Ej8Uuh43cjRZEp31yZ7FfatQ0kExVBuRRosErznkBdUpj
	kOwqcoWN2/h/05AnmoU0OHgfo3GvVZ0svy7RPaRkwYfiYi3rjl0vJwwNc+cEF0YBmhBBCC
	Ms/XMqza/DsYPaKaaB2nOz3st4T8ChMYSMI/PCsdB0wAoQnGVwwWueqn4tj0R3S4aspGLq
	4W/+GQRLvdI2oS44/Ic0kTPLoVwb4oIqvgTDKudnEBpu93C2y4wdfPfoRZT1cQ==
Message-ID: <43461785-37a6-4228-abec-2364cae190ea@bootlin.com>
Date: Wed, 21 Jan 2026 11:16:38 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] cpupower: make systemd unit installation optional
To: linux-pm@vger.kernel.org
Cc: thomas.petazzoni@bootlin.com, shuah@kernel.org, trenn@suse.com,
 jwyatt@redhat.com, jkacur@redhat.com
References: <20260113132753.1730020-1-joaomarcos.costa@bootlin.com>
 <20260113132753.1730020-2-joaomarcos.costa@bootlin.com>
Content-Language: en-US, fr
From: Joao Marcos Costa <joaomarcos.costa@bootlin.com>
Organization: Bootlin
In-Reply-To: <20260113132753.1730020-2-joaomarcos.costa@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-41221-lists,linux-pm=lfdr.de];
	DKIM_TRACE(0.00)[bootlin.com:+];
	DMARC_POLICY_ALLOW(0.00)[bootlin.com,reject];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joaomarcos.costa@bootlin.com,linux-pm@vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,bootlin.com:email,bootlin.com:dkim,bootlin.com:mid]
X-Rspamd-Queue-Id: A0E1D55714
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

I hope this emails finds you well!

On 1/13/26 14:27, João Marcos Costa wrote:
> cpupower currently installs a cpupower.service unit file into unitdir
> unconditionally, regardless of whether systemd is used by the host.
> 
> Improve the installation procedure by making this systemd step optional:
> a 'SYSTEMD' build parameter that defaults to 'true' and can be set to
> 'false' to disable the installation of systemd's unit file.
> 
> Since 'SYSTEMD' defaults to true, the current behavior is kept as the
> default.
> 
> Signed-off-by: João Marcos Costa <joaomarcos.costa@bootlin.com>
(...)

Gentle ping on this patch in case it slipped through, and any feedback 
would be appreciated. Thanks!

-- 
Best regards,
João Marcos Costa

