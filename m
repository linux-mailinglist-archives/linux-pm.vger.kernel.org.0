Return-Path: <linux-pm+bounces-43469-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KP6DLSUlpmlrLAAAu9opvQ
	(envelope-from <linux-pm+bounces-43469-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 03 Mar 2026 01:02:45 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E03F1E6F0B
	for <lists+linux-pm@lfdr.de>; Tue, 03 Mar 2026 01:02:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 473D63078FCD
	for <lists+linux-pm@lfdr.de>; Tue,  3 Mar 2026 00:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D40B7201278;
	Tue,  3 Mar 2026 00:01:16 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B932C1990A7;
	Tue,  3 Mar 2026 00:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772496076; cv=none; b=TWLS+X3hLQk/gAhpvxxX+uqN7IzPpg7c2LvkbTox67CJc4twYFQ8onU+rnL14QzA+h/SI2BZ3fEilD7429hVYv+4umkBNCm2uQFf1lp1AXxtv6z7JoS4VJu0yLu6GYFRoq7tQTM3j/Q6gklo87ku4ikoGcRr8+mxl3AVnCqxLC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772496076; c=relaxed/simple;
	bh=E0gUIopwmjIcVlVXfwbzb5eafZc6arvmdsswbAk/5m0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Hkp3M16ObVN732PxCXol9izaqUr0AidDWPEyWyGk7Yr9KHvcYOtjKTiG0KfN9CD/538loyD+OH+GzlugVyCe2VdJOLp8HPmzfCMfoiJ4kuJSBtKgWd/4SxnCDV6A/hRc08lat+0EW620XCk92ec0mDhnYAmwZ6mm3EKrrKDsLv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 487BDC2BC86;
	Tue,  3 Mar 2026 00:01:16 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id 5C60A180D08; Tue, 03 Mar 2026 01:01:14 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Sebastian Reichel <sre@kernel.org>, Hans de Goede <hansg@kernel.org>, 
 Chen-Yu Tsai <wens@kernel.org>, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: stable@vger.kernel.org
In-Reply-To: <20260220174938.672883-5-krzysztof.kozlowski@oss.qualcomm.com>
References: <20260220174938.672883-5-krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: [PATCH 1/4] power: supply: axp288_charger: Do not cancel work
 before initializing it
Message-Id: <177249607436.615407.12534696673275075213.b4-ty@collabora.com>
Date: Tue, 03 Mar 2026 01:01:14 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Rspamd-Queue-Id: 6E03F1E6F0B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[collabora.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43469-lists,linux-pm=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.929];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,collabora.com:mid,collabora.com:email]
X-Rspamd-Action: no action


On Fri, 20 Feb 2026 18:49:39 +0100, Krzysztof Kozlowski wrote:
> Driver registered devm handler to cancel_work_sync() before even the
> work was initialized, thus leading to possible warning from
> kernel/workqueue.c on (!work->func) check, if the error path was hit
> before the initialization happened.
> 
> Use devm_work_autocancel() on each work item independently, which
> handles the initialization and handler to cancel work.
> 
> [...]

Applied, thanks!

[1/4] power: supply: axp288_charger: Do not cancel work before initializing it
      commit: 3e2143c88b5c1e50439239693ba9994cc82d86c3
[2/4] power: supply: axp288_charger: Simplify returns of dev_err_probe()
      commit: c53266766ba5fb52f32f1766a71e0f96c5e51892
[3/4] power: supply: bq24190: Avoid rescheduling after cancelling work
      commit: ba4300a96fb2be99dd29939fd2ca84d67260deaa
[4/4] power: supply: twl4030_madc: Drop unused header includes
      commit: f14f741f9059a8d5492969e480453640cb5dbc85

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


