Return-Path: <linux-pm+bounces-41343-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uGC9LmvScmnKpgAAu9opvQ
	(envelope-from <linux-pm+bounces-41343-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 23 Jan 2026 02:44:11 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6981B6F420
	for <lists+linux-pm@lfdr.de>; Fri, 23 Jan 2026 02:44:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5487F301301C
	for <lists+linux-pm@lfdr.de>; Fri, 23 Jan 2026 01:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 623B237E2E9;
	Fri, 23 Jan 2026 01:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ev7ziae6"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1FF53033E2;
	Fri, 23 Jan 2026 01:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769132645; cv=none; b=SV6sQ5OQp/mFO6A9EOTkz1Ob90whaeb+abLOpqBgfSiLGhudpXkF3DTcWqFn8Rhm5c95XOf3VQpmNhM4STKYcKj8mvM8xcBFDvsADW86ht6d+o5J6ql2QIQfuIEwuMhmdCFzb6Pc8soPtD+MumJI4a7Jp9NArhLycQ9fUW0pbTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769132645; c=relaxed/simple;
	bh=5hbyjhex9kITqfDLBxrxOd0hxO79EBXto59nVbh5+k0=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=lfGavWoFc7REA/sNV+em+4cpaWm0pi3/yiuBKHV8mXt8oKH7kJhQtcFVLkyytvlNdT9XvJ/21XcG+67Ogxh2gYFytEcriJMPpTCC2yfiQIKg0dYCmra3bbbrbVAlb7OLNP7ofdjvt4OIUQNm56v6QLvhj44hBvepJBS2pcDciQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ev7ziae6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB159C116C6;
	Fri, 23 Jan 2026 01:44:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769132644;
	bh=5hbyjhex9kITqfDLBxrxOd0hxO79EBXto59nVbh5+k0=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=ev7ziae6QynBpEoXuTw+tKhHXcIE6jAWIJ8Qr4jlrhkDwCxQ23DuGDiS8KR5RkSBO
	 XJJKpRuEQMSyjtyKqowRIVTALbgQikLe5jDmniZRcVpmFPaW3AcmIyqXFk4IfLj6Sj
	 d6njx51cvVSdwerUkssiTHBc178UZXFXkMNbtl+QFgQTAlNrfDESTq4wVDotoeMcEb
	 bRjoVzHnuNazboD8Eux2r9CZ7wFAKlyfBZECNF9YwGmZt9Ho1RYi3tHx6Gp9VVm7Fm
	 vMgE+1xnKi7d0Z/CrKlixDgaoCxuRtSxaREDd+af4Ps1QYHHJG/+Il6LKx/Ms0pCCS
	 R2oB6e7BPXgNA==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260113110012.36984-2-angelogioacchino.delregno@collabora.com>
References: <20260113110012.36984-1-angelogioacchino.delregno@collabora.com> <20260113110012.36984-2-angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH 1/5] dt-bindings: clock: mediatek,mt7622-pciesys: Remove syscon compatible
From: Stephen Boyd <sboyd@kernel.org>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, mturquette@baylibre.com, matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com, ulf.hansson@linaro.org, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, kernel@collabora.com
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, linux-mediatek@lists.infradead.org
Date: Thu, 22 Jan 2026 18:44:00 -0700
Message-ID: <176913264088.4027.8181442365263055794@lazor>
User-Agent: alot/0.11
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-41343-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.993];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sboyd@kernel.org,linux-pm@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,baylibre.com,gmail.com,collabora.com,linaro.org,vger.kernel.org,lists.infradead.org];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,collabora.com:email]
X-Rspamd-Queue-Id: 6981B6F420
X-Rspamd-Action: no action

Quoting AngeloGioacchino Del Regno (2026-01-13 04:00:08)
> The PCIESYS register space contains a pure clock controller, which
> has no system controller register, so this definitely doesn't need
> any "syscon" compatible.
>=20
> As a side note, luckily no devicetree ever added the syscon string
> to PCIESYS clock controller node compatibles, so this also resolves
> a dtbs_check warning for mt7622.
>=20
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>
> ---

Applied to clk-next

