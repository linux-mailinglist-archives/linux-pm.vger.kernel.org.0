Return-Path: <linux-pm+bounces-43722-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id LRFnB8cfqmn0LgEAu9opvQ
	(envelope-from <linux-pm+bounces-43722-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 01:28:55 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 64A7C219C82
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 01:28:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9D6FF3025F58
	for <lists+linux-pm@lfdr.de>; Fri,  6 Mar 2026 00:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45E2A2BEC34;
	Fri,  6 Mar 2026 00:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k1fWMiSV"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 193A629A309;
	Fri,  6 Mar 2026 00:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772756931; cv=none; b=g0UGfPdbWredwRxEmKkS8Af52Sa7NFIFGiyL4rMTxCIoPSKsd8BBk1Jo6F4JYi95SIMi4d4wMtRDE5hsaWDmRuNFRp0BGlq9HVfydobuyFp73yqy2R8IxhB7lJObEs0ofaz1aAys0HQxcRi6+RNlWxhWrcHno7H8fBcIZRhCxKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772756931; c=relaxed/simple;
	bh=EXIStN1B/izsA6vGyFCAGh+w3xMM+thmSuO0J4C0Xvo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s5+yWMgA6v8sSqlkGkM2+u0n47cYSy4oQp7Ju8Z/7BwDBl7u0bJV1GL6vLc3pUdDiSfWo9ILuggZauXl2lv7XoruczEIdq39RlXijP24rRcALwJ50sBd4N4E31vDUpzzw20dLB58OYMYjZfaVH/x1gdOYEJuEwQSo/pQ4E21UR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k1fWMiSV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6E4EC116C6;
	Fri,  6 Mar 2026 00:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772756930;
	bh=EXIStN1B/izsA6vGyFCAGh+w3xMM+thmSuO0J4C0Xvo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k1fWMiSVv9ZBMUvKy4qYRdIOqJzOmk3HXhNYLX4RKFCXSipyjH8GD9CkxuqVaOYd3
	 t0ehgvplc3/7pGkWH/WKQVUtxj5l+8MkWdS8AnScmPCNhTJb8Lnrw2pa8IV8TVjKXM
	 WdN19c/dGxbKjTwtmtLdNOmaSa9igq5318juqOVuFvEfQ9lUa/pyx11nHRO3m90EpW
	 zFbvnnIAj8jJpkRDYodTJwgJrzcMzIqixXoUVCRSGBeASZqqAquFt8cjnndVjNEYIt
	 NTkA+HFiCEKxhzxqbX2bC+I/kSZisc0mD+NlPJEI6P1cGjKrE5vb4KgJUNcy3K2CvR
	 F2V0H94O8MlZQ==
Date: Thu, 5 Mar 2026 18:28:49 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Luca Leonardo Scorcia <l.scorcia@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, Chen Zhong <chen.zhong@mediatek.com>,
	Macpaul Lin <macpaul.lin@mediatek.com>, linux-pm@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Lee Jones <lee@kernel.org>, linux-kernel@vger.kernel.org,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>,
	devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
	Julien Massot <julien.massot@collabora.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Fabien Parent <parent.f@gmail.com>, linux-input@vger.kernel.org,
	linux-rtc@vger.kernel.org,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Val Packett <val@packett.cool>, Sen Chu <sen.chu@mediatek.com>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Gary Bisson <bisson.gary@gmail.com>,
	Eddie Huang <eddie.huang@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>
Subject: Re: [PATCH 2/9] dt-bindings: regulator: add support for MT6392
Message-ID: <177275692938.853845.10496663055638089922.robh@kernel.org>
References: <cover.1771865014.git.l.scorcia@gmail.com>
 <b7664f4d9a7b038b0603b6bba79cfab4e18cbdd6.1771865015.git.l.scorcia@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b7664f4d9a7b038b0603b6bba79cfab4e18cbdd6.1771865015.git.l.scorcia@gmail.com>
X-Rspamd-Queue-Id: 64A7C219C82
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43722-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[27];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,mediatek.com,vger.kernel.org,gmail.com,collabora.com,lists.infradead.org,bootlin.com,packett.cool];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[robh@kernel.org,linux-pm@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action


On Mon, 23 Feb 2026 17:12:41 +0000, Luca Leonardo Scorcia wrote:
> From: Fabien Parent <parent.f@gmail.com>
> 
> Add binding documentation of the regulator for MT6392 SoCs.
> 
> Signed-off-by: Fabien Parent <parent.f@gmail.com>
> Signed-off-by: Val Packett <val@packett.cool>
> Signed-off-by: Luca Leonardo Scorcia <l.scorcia@gmail.com>
> ---
>  Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


