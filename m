Return-Path: <linux-pm+bounces-41453-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eG2bHBsyd2mrdAEAu9opvQ
	(envelope-from <linux-pm+bounces-41453-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 26 Jan 2026 10:21:31 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B122E85F03
	for <lists+linux-pm@lfdr.de>; Mon, 26 Jan 2026 10:21:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7182A30036E3
	for <lists+linux-pm@lfdr.de>; Mon, 26 Jan 2026 09:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64471283FD6;
	Mon, 26 Jan 2026 09:21:27 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17DCE21D3F2
	for <linux-pm@vger.kernel.org>; Mon, 26 Jan 2026 09:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769419287; cv=none; b=XuRyKe4l1LKFxuTUSpt1tUnCxlLBlMsF29z19D/x402oKKpjIh0Bb5sN3mxEAusVZnCX+RZ5SX65GlH56I/dO1+FLyFpY4dXtbPRrxmaSh9EsTZf3Bc7QfZUVdywQYHtMXnqMa5Upe8jSQJQ19PIZf0Dg6G+sI6gCrYjuACkMek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769419287; c=relaxed/simple;
	bh=zuLTNu10t9Op8BVt2TUYGYUes51ASXSsTqsYh2FmfbA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=C+Q/rWbWmWHjSPwwDGlvfYKGhN40ILY05nzfYVRR+H+c18fOyyrrfhPfZjfWcwZ1quTOCEmHzn8zIw7VUKZyqoGzF2mISKBbmhG0cx3aJEVRcaACh9ZGmrckumogcWlZ+4Q3k3MtSy1EyZuqA2TovUEoKaPvV5bKxpmmDPQ7OMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[IPv6:::1])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <l.stach@pengutronix.de>)
	id 1vkImW-0000cv-MV; Mon, 26 Jan 2026 10:21:12 +0100
Message-ID: <255e1946a67efadf13f468fc24c907074037a45e.camel@pengutronix.de>
Subject: Re: [PATCH v3] pmdomain: imx: gpcv2: Fix the imx8mm gpu hang due to
 wrong adb400 reset
From: Lucas Stach <l.stach@pengutronix.de>
To: Fabio Estevam <festevam@gmail.com>, Jacky Bai <ping.bai@nxp.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team
 <kernel@pengutronix.de>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 linux-pm@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org
Date: Mon, 26 Jan 2026 10:21:11 +0100
In-Reply-To: <CAOMZO5Ag6jtVqeXW30QNy5+1ykmGTt4G8DxcsyOUMvNaeJf5Ug@mail.gmail.com>
References: <20260123-imx8mm_gpu_power_domain-v3-1-3752618050c9@nxp.com>
	 <CAOMZO5Ag6jtVqeXW30QNy5+1ykmGTt4G8DxcsyOUMvNaeJf5Ug@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pm@vger.kernel.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-41453-lists,linux-pm=lfdr.de];
	DMARC_NA(0.00)[pengutronix.de];
	FREEMAIL_TO(0.00)[gmail.com,nxp.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[l.stach@pengutronix.de,linux-pm@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: B122E85F03
X-Rspamd-Action: no action

Am Samstag, dem 24.01.2026 um 18:20 -0300 schrieb Fabio Estevam:
> On Thu, Jan 22, 2026 at 11:51=E2=80=AFPM Jacky Bai <ping.bai@nxp.com> wro=
te:
> >=20
> > On i.MX8MM, the GPUMIX, GPU2D, and GPU3D blocks share a common reset
> > domain. Due to this hardware limitation, powering off/on GPU2D or GPU3D
> > also triggers a reset of the GPUMIX domain, including its ADB400 port.
> > However, the ADB400 interface must always be placed into power=E2=80=91=
down mode
> > before being reset.
> >=20
> > Currently the GPUMIX and GPU2D/3D power domains rely on runtime PM to
> > handle dependency ordering. In some corner cases, the GPUMIX power off
> > sequence is skipped, leaving the ADB400 port active when GPU2D/3D reset=
.
> > This causes the GPUMIX ADB400 port to be reset while still active,
> > leading to unpredictable bus behavior and GPU hangs.
> >=20
> > To avoid this, refine the power=E2=80=91domain control logic so that th=
e GPUMIX
> > ADB400 port is explicitly powered down and powered up as part of the GP=
U
> > power domain on/off sequence. This ensures proper ordering and prevents
> > incorrect ADB400 reset.
> >=20
> > Suggested-by: Lucas Stach <l.stach@pengutronix.de>
> > Signed-off-by: Jacky Bai <ping.bai@nxp.com>
>=20
> Shouldn't this have a Fixes tag?

Yes, it needs to go into at least the active 6.12 LTS series, as the
patch changing the domain suspend ordering is in 6.10. Other than the
missing tags:

Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

Regards,
Lucas

