Return-Path: <linux-pm+bounces-42892-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iGBTMmlnl2nfxwIAu9opvQ
	(envelope-from <linux-pm+bounces-42892-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 19 Feb 2026 20:41:29 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EC9D162151
	for <lists+linux-pm@lfdr.de>; Thu, 19 Feb 2026 20:41:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B73B5301452B
	for <lists+linux-pm@lfdr.de>; Thu, 19 Feb 2026 19:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64EE23093BB;
	Thu, 19 Feb 2026 19:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mkl2KvYU"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411622E0B71;
	Thu, 19 Feb 2026 19:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771530084; cv=none; b=hHWYRvDHQdSaAwj6xAoV2u7ENtQ369z71C0MzzHfSo+enJrIIRwc7I5LYRKismmDmChQ5NlNGR0TsnPqcgLSQ0AjQDBDYnJrr4I5MTt71O51jlmMih7opjxVrnnJ7C4cHzp29q/QqY5oF55/iFx1O7PNczQjiHk25OWv/Wp3e8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771530084; c=relaxed/simple;
	bh=X/YpBpZHELPnaJx/3vhuFsswpFYW6glhYMozRGxU4LA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kPDbMhDiWeSaAwI/lT/JFPkOBZnylqO/BgEqp6q5xC25iEo40L1pCoHRJ2o/WSfg+pkjrMvBSj6RHlyUkWqsuL7tP0xFaA0Kx+aOulrq7HE7MMSgLOYR0CnDvTL0dnIudcNGrsw83TQVIjK8aHtBaYQunnv8DPQd7v0CqDSg4IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mkl2KvYU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2130C4CEF7;
	Thu, 19 Feb 2026 19:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771530083;
	bh=X/YpBpZHELPnaJx/3vhuFsswpFYW6glhYMozRGxU4LA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Mkl2KvYUp1F20IHclNSctcmg7lauq73IyKRQVwNswPbGoI6InqBDg3hg3+ZZjrC5+
	 5xmyGuTkpEHJV0pwMOSQD/AGbI7y/Gfu2tlqomWKRqJxzs0k7iyB5FgUZmbvEJN1Jr
	 143Utb+tQnNMyiVaUvN5yMocMVNw6pxSL0gpl782Qnl4kmKLvcRuzlSKeI/6HvCO0O
	 cEdBu7hbLoRa5DdaMkj5qAYzVx+cSc6FNnedSBfqttW3KBbws4+0p75nGaviS2XlKy
	 /DcvgKUxO7GDfsM+RyLVLnUcTPCg3V0w1icecFDyLIzQuKI5jIz6oCCYC+oui9lbvo
	 ctR3U1d0NfrUQ==
Date: Thu, 19 Feb 2026 11:41:20 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Yury Norov <ynorov@nvidia.com>
Cc: linux-kernel@vger.kernel.org, "Christophe Leroy (CS GROUP)"
 <chleroy@kernel.org>, "David S. Miller" <davem@davemloft.net>, "Peter
 Zijlstra (Intel)" <peterz@infradead.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Alexander Shishkin
 <alexander.shishkin@linux.intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Andrew Morton <akpm@linux-foundation.org>, Antoine Tenart
 <atenart@kernel.org>, Christian Brauner <brauner@kernel.org>, Daniel
 Lezcano <daniel.lezcano@linaro.org>, Eric Dumazet <edumazet@google.com>,
 Geetha sowjanya <gakula@marvell.com>, Ingo Molnar <mingo@kernel.org>, James
 Clark <james.clark@linaro.org>, Jerin Jacob <jerinj@marvell.com>, Linu
 Cherian <lcherian@marvell.com>, Lukasz Luba <lukasz.luba@arm.com>, Madhavan
 Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Mike Leach <mike.leach@linaro.org>, Moritz Fischer <mdf@kernel.org>,
 Nicholas Piggin <npiggin@gmail.com>, Paolo Abeni <pabeni@redhat.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, Simon Horman
 <horms@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Subbaraya Sundeep
 <sbhatta@marvell.com>, Sunil Goutham <sgoutham@marvell.com>, Suzuki K
 Poulose <suzuki.poulose@arm.com>, Tom Rix <trix@redhat.com>, Xu Yilun
 <yilun.xu@intel.com>, Yajun Deng <yajun.deng@linux.dev>, Yury Norov
 <yury.norov@gmail.com>, Zhang Rui <rui.zhang@intel.com>, hariprasad
 <hkelam@marvell.com>, coresight@lists.linaro.org,
 linux-arm-kernel@lists.infradead.org, linux-fpga@vger.kernel.org,
 linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 netdev@vger.kernel.org
Subject: Re: [PATCH 00/12] cleanup bitmaps printing in sysfs
Message-ID: <20260219114120.0f4408f7@kernel.org>
In-Reply-To: <20260219181407.290201-1-ynorov@nvidia.com>
References: <20260219181407.290201-1-ynorov@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-42892-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,davemloft.net,infradead.org,linux.intel.com,lunn.ch,linux-foundation.org,linaro.org,google.com,marvell.com,arm.com,linux.ibm.com,ellerman.id.au,gmail.com,redhat.com,rasmusvillemoes.dk,fomichev.me,intel.com,linux.dev,lists.linaro.org,lists.infradead.org,lists.ozlabs.org];
	RCPT_COUNT_TWELVE(0.00)[43];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm,netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7EC9D162151
X-Rspamd-Action: no action

On Thu, 19 Feb 2026 13:13:52 -0500 Yury Norov wrote:
>  .../marvell/octeontx2/af/rvu_debugfs.c        | 28 +++----------
>  drivers/net/ethernet/meta/fbnic/fbnic_tlv.c   |  6 +--
>  drivers/s390/net/qeth_core_main.c             |  6 +--
>  net/core/net-sysfs.c                          |  2 +-

Please split these changes out and submit them to the correct subsystem
after the merge window. Then push patch 12 during the next merge window.

