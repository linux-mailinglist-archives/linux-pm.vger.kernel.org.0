Return-Path: <linux-pm+bounces-43795-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sGJhO2OwqmnZVQEAu9opvQ
	(envelope-from <linux-pm+bounces-43795-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 11:45:55 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9277421F16D
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 11:45:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 03B2430DDBDE
	for <lists+linux-pm@lfdr.de>; Fri,  6 Mar 2026 10:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8147C37C0E5;
	Fri,  6 Mar 2026 10:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="lkmJ02CS"
X-Original-To: linux-pm@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF3E35B12B;
	Fri,  6 Mar 2026 10:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772793828; cv=none; b=i1KSXyG83uzUxFrIUwDzvyIdvZ/56DVekEjXLrpXlXXRFHRCakEPsW5Cv7xgJxTZUiViqX7rl9yV3Xu8rFJjP1hBZW1Rma7bURWBkMWAbvYsPJhXMxgGwCT19ui1g/XmSGE2+K9pd89xaHnvOlzPrP1ycH8Dp4tGK2GPMeZdivo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772793828; c=relaxed/simple;
	bh=eGd6oj6eBIJhCQ4hhxjgQ1C4d87ZI9NBj93FtlNey1M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SyX+LyRtaiTlmYnPK4GSmXoOsfmK/j1RqnFCMuxk/h90Pt9ytvhoFl1BJDNffigHwI0whT7zy59AYJquTORk3+iozvhcXkKvUycMWBgOMgh0vxByIGzWoY36icUW95IMF55pT4aroAk/GXD+zNgDBNlmIXw1AB5+Vo26ehU50Mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=lkmJ02CS; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=++ucNMjBOa630Tlk3DsPoQqLDeAf1p8NVy9HyGd5DO0=; b=lkmJ02CSN+PDutmGJj0dHUPOy2
	uZQU5+5epoMNlbbufR1KtbjJCNQ4NnefOwfhM4UK4hnIs0Wwe2nLUcl+uXrPXNH4hRokv7XTt+fMd
	JJGT+Wp70sUys55MRh1dkB8BnYFdcLOaYKywgsZ+sMokbx8abw0K+13FAyuL/FUt7yzaXGXOCPgbj
	YHakj/kgeZUxITPjAx0W1TVGVBYVeT4HXbg0ApWCIDylR6ukHe0E2krwmXI0UPVRv86nlgy+ftO6l
	IcN0c/9uJtWsWKTk6b2GwV/cCCBSzHV2Wn7dcpZM1HuguiC36IkKBnjQf6sPmsk0WvBhnh9RAz3NC
	BF8r/TgQ==;
From: Heiko Stuebner <heiko@sntech.de>
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Shawn Lin <shawn.lin@rock-chips.com>
Cc: linux-pm@vger.kernel.org, linux-rockchip@lists.infradead.org,
 devicetree@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH 0/3] Add shaping support for Rockchip platforms
Date: Fri, 06 Mar 2026 11:43:13 +0100
Message-ID: <4490342.ejJDZkT8p0@phil>
In-Reply-To: <1772782832-216867-1-git-send-email-shawn.lin@rock-chips.com>
References: <1772782832-216867-1-git-send-email-shawn.lin@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Rspamd-Queue-Id: 9277421F16D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[sntech.de,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[sntech.de:s=gloria202408];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-43795-lists,linux-pm=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[heiko@sntech.de,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[sntech.de:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[27f06088:email,sntech.de:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hi Shawn,

Am Freitag, 6. M=C3=A4rz 2026, 08:40:29 Mitteleurop=C3=A4ische Normalzeit s=
chrieb Shawn Lin:
> pm_shaping is introduced for some platforms to throttle the outstanding
> burst requests of each IP to prevent bus monopolization. It should be
> saved and restored along with the on/off of pmdomain, the same as pm_qos.
> This patchset adds support for it.

Can we get some more descriptive naming for the feature please?
In the commit messages, dt-binding and also node-names in the soc dtsi.
Because anyone glancing at either the binding or dtsi will not understand
what this is, and would even need to consult the git history for any
explanation.

The full interconnect is not part of the TRM I have, but the bits and
pieces in other parts of the TRM speak of traffic-shaping.

So for the node I'd go for:
	shaping_vepu1: traffic-shaping@27f06088

and in the binding something like:
	rockchip,pm-traffic-shaping =3D <....>

I think the whole pm_qos thing is an oversight of the past, because:

=2D properties should use dashes "-" not underscores
=2D the property name is Rockchip specific, so should likely get a prefix


Heiko




