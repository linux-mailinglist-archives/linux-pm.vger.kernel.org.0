Return-Path: <linux-pm+bounces-42462-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UC+CJpFai2ljUAAAu9opvQ
	(envelope-from <linux-pm+bounces-42462-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 10 Feb 2026 17:19:29 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A359F11D0B0
	for <lists+linux-pm@lfdr.de>; Tue, 10 Feb 2026 17:19:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 028F330055C2
	for <lists+linux-pm@lfdr.de>; Tue, 10 Feb 2026 16:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A114B387575;
	Tue, 10 Feb 2026 16:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PDKg51Nq"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 729F32E7BCC;
	Tue, 10 Feb 2026 16:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770740362; cv=none; b=JxM2xERBxLxLBa7lTpir4Y3Z0101slz1Gn5ZE74rD7tGjG0pRDmsiKX+SDU7RMi/zshKshEmpCuowKv9nB7BzZAMN8835ahpsZv1zUNwNcZWI6zb84N7RcKVrg++Q28ipHmcace7R1pEMco7pNyOlDsgfTfnswQFhNMEb29Dij8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770740362; c=relaxed/simple;
	bh=ZJqOCWTAIrRuyAoY45qHcqTE8451yB5SKL/tec9M0p0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=WrDPP/Gh1UO+Ptz7nGs7LEEbyBEdersy9N0csDCHWeDYBkUh+4dTIuIYpcT+ji9nTlDTE5j8SOuwvrPuuaxoJ5VBNtU+eEXXq+163jcsH2qdHRM43dB7v/Y9Hi6+9xo6EX7PbVFx40UXC+7ZZYUoJKlVeOs0QC8sTkFMWAxm96I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PDKg51Nq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A22C5C116C6;
	Tue, 10 Feb 2026 16:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770740362;
	bh=ZJqOCWTAIrRuyAoY45qHcqTE8451yB5SKL/tec9M0p0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=PDKg51NqNRpnHna5J8H7l2Z7tf3hV15X62gj355S1cPdzhUbCiUzgeiNxctSsuuRR
	 wmSuAX/kHbEdbwLx7OYeSGrLt9QrVelVytwH1aes4yLPxiGUAhmM/fNgKPulVR4Nwr
	 x5+9kTeJn7lZ1CkJHa5TnR+Xa5cX2qbhZO673DcPT1GSgsSqH7d9RsqQbsKuGQ6bEg
	 wa32/VXpIdCucOLuJYbrtqH+wtaBqydJH/GKyh/2/FdnBGNhVbIXbO6sHnnzcot3rW
	 XtzNpRGmurIaCD2K0T8b9ojBJjD/VdYhsl09WqKsZR/zg+o0upVRkVjaMEsPxJSFTp
	 fuuRGtzAVlYTw==
From: Mark Brown <broonie@kernel.org>
To: linux-mediatek@lists.infradead.org, Adam Ford <aford173@gmail.com>
Cc: angelogioacchino.delregno@collabora.com, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
 Ulf Hansson <ulf.hansson@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>, 
 Laura Nao <laura.nao@collabora.com>, 
 =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>, 
 linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
In-Reply-To: <20260210053708.17239-1-aford173@gmail.com>
References: <20260210053708.17239-1-aford173@gmail.com>
Subject: Re: (subset) [PATCH 1/5] pmdomain: mediatek: Fix power domain
 count
Message-Id: <177074035936.275824.8148864726689689381.b4-ty@kernel.org>
Date: Tue, 10 Feb 2026 16:19:19 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-47773
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-42462-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[lists.infradead.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[broonie@kernel.org,linux-pm@vger.kernel.org];
	FREEMAIL_CC(0.00)[collabora.com,baylibre.com,kernel.org,gmail.com,linaro.org,vger.kernel.org,lists.infradead.org];
	TAGGED_RCPT(0.00)[linux-pm];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A359F11D0B0
X-Rspamd-Action: no action

On Mon, 09 Feb 2026 23:37:01 -0600, Adam Ford wrote:
> The wrong value of the number of domains is wrong which leads to
> failures when trying to enumerate nested power domains.
> 
>  PM: genpd_xlate_onecell: invalid domain index 0
>  PM: genpd_xlate_onecell: invalid domain index 1
>  PM: genpd_xlate_onecell: invalid domain index 3
>  PM: genpd_xlate_onecell: invalid domain index 4
>  PM: genpd_xlate_onecell: invalid domain index 5
>  PM: genpd_xlate_onecell: invalid domain index 13
>  PM: genpd_xlate_onecell: invalid domain index 14
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[4/5] regulator: mt6363: Fix interrmittent timeout
      commit: 1a4b0c999101b2532723f9bd9818b70ffa7580f4

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark


