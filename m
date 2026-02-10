Return-Path: <linux-pm+bounces-42459-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cC40D5tYi2ljUAAAu9opvQ
	(envelope-from <linux-pm+bounces-42459-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 10 Feb 2026 17:11:07 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0779511CEFB
	for <lists+linux-pm@lfdr.de>; Tue, 10 Feb 2026 17:11:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D008630055F6
	for <lists+linux-pm@lfdr.de>; Tue, 10 Feb 2026 16:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AC6E3876CE;
	Tue, 10 Feb 2026 16:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Optq0Ucr"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFED52750FB;
	Tue, 10 Feb 2026 16:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770739857; cv=none; b=onmmOV1XgViTpTB+68PcUchZ5Lbc5Ito7BmpUBrHtuOhZUw1CVPosw26Of+/LAlA33vi4imUzpmecGtZeYDMTaKHHUSKDrc5PO2cEHoO6O/qHKAEI172q9KeM1SwTa4K1/3RvRo9URQypQj7HEa/vc0lyR9lUgKZMIKFYvTNeVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770739857; c=relaxed/simple;
	bh=lLVDD99fYBVm2CdLzN2zj/HZbrLO0z3wX6Z5az0oTNk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=D/w/RKLr3/sSAlHyH/BOKw9jGAh1xozbq4Sj4OJN24cHgv++fjVye+jxl39qjeQeON4Qrs0OE4+BpdQGcYFlaptLRPQvwe5QsFCViCqf8G4tLLgZPJYtKXYDnlB4oRpM7tLkFrwhXVAr73SkS51VlHQjVQATZvYwGa/YV76KC94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Optq0Ucr; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1770739854;
	bh=lLVDD99fYBVm2CdLzN2zj/HZbrLO0z3wX6Z5az0oTNk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Optq0UcrlWtJQoGV5TU1aPGXWMxciVd3yJJkWNEa2bsRMWsKuy8W78gGRRLF4teCR
	 Q+pHjGV3xH4zYuSzAIfryAVNEGS3mb8tdsnj05HHae8WxCkCoYSh+lJNQNjjvbAp5g
	 zGG/tvVB//HewOto7KknXDt4dpeAu2iPADwm9Vp32UJqpxOsU0rhhJObNTZs3/q2tF
	 sCMw1dqm6GzpJZlNwO0EvQeJTWTsAih8PPZg/fm0jgnthFOQSgHkaAGTd4hvGgHXmC
	 rSGf747THQxMwGzHA/UaSEXlTUyffdrzcX0KwYmdvX3C7pm+hFUZTuOUoTzDVkQgij
	 pkT6RRU4DxoBA==
Received: from laura.lan (unknown [IPv6:2001:b07:646b:e2:7872:ec71:6d40:b8ea])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laura.nao)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 4503317E0E90;
	Tue, 10 Feb 2026 17:10:53 +0100 (CET)
From: Laura Nao <laura.nao@collabora.com>
To: aford173@gmail.com
Cc: angelogioacchino.delregno@collabora.com,
	broonie@kernel.org,
	laura.nao@collabora.com,
	lgirdwood@gmail.com,
	linux-arm-kernel@lists.infradead.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-pm@vger.kernel.org,
	matthias.bgg@gmail.com,
	mturquette@baylibre.com,
	nfraprado@collabora.com,
	sboyd@kernel.org,
	ulf.hansson@linaro.org
Subject: Re: [PATCH 2/5] clk: mediatek: Fix MT8196 topckgen2 orphan clocks
Date: Tue, 10 Feb 2026 17:10:49 +0100
Message-Id: <20260210161049.42621-1-laura.nao@collabora.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260210053708.17239-2-aford173@gmail.com>
References: <20260210053708.17239-2-aford173@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[collabora.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[collabora.com:s=mail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[collabora.com,kernel.org,gmail.com,lists.infradead.org,vger.kernel.org,baylibre.com,linaro.org];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42459-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[laura.nao@collabora.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[collabora.com:+];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[collabora.com:mid,collabora.com:dkim,collabora.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0779511CEFB
X-Rspamd-Action: no action

Hi,

On 2/10/26 06:37, Adam Ford wrote:
> There are a few clocks with names spelled incorrecly, so when a child tries
> to associate itself to a parent, there isn't a parent.  Fixing the names
> restores the proper parent-child relations of these clocks and eliminates
> the orphaned clocks.
>
> Fixes: b093e0f17099 ("clk: mediatek: Add MT8196 topckgen2 clock support")
> Signed-off-by: Adam Ford <aford173@gmail.com>

I intended to drop the ck_ prefix from the clock names in the original 
driver submission, but it appears I missed some of them.

Reviewed-by: Laura Nao <laura.nao@collabora.com>

Thanks!

Laura


