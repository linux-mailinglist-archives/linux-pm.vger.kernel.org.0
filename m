Return-Path: <linux-pm+bounces-43741-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oJwHL09TqmnhPQEAu9opvQ
	(envelope-from <linux-pm+bounces-43741-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 05:08:47 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 680AA21B61F
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 05:08:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 421803029A8B
	for <lists+linux-pm@lfdr.de>; Fri,  6 Mar 2026 04:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0D9D36CE0C;
	Fri,  6 Mar 2026 04:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tmxtOwOh"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8432369992;
	Fri,  6 Mar 2026 04:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772770124; cv=none; b=sisoCdxOtCL1ifnyGVFWmExGmevZ/y35B2x1Lq8l8odr1dCNul2ZQZP8NcyYz1xtXidVfQldDFyp+2gYx6gP/fTvSU0aQOrLx/i0WIj+5INJHwrnDx6UOPhWZ/+ACdluwG6f5Sq5iFf54Yq81W2CTeNxmyq0I8obL1G52i0wBKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772770124; c=relaxed/simple;
	bh=2PV8N8MDNTOIV9r2E8N///4zaacKBlEGosc7fKjx3Ks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s9johSnYA8dEtGmYUeApgoeeQp9dGus9/kuk9DA0q4PRp5jLFK0quefh84qtH7l7WPOCW3r2pCkm8l6X5IxnuV+7fqeM/+Ew5nfU434TrU6olMXfJMDOO8QCwx7nndGo+9IMbz2grgpqv1ZAVPGDvoAF4nSAUCIXgJ1u8RqHivk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tmxtOwOh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27164C4CEF7;
	Fri,  6 Mar 2026 04:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772770124;
	bh=2PV8N8MDNTOIV9r2E8N///4zaacKBlEGosc7fKjx3Ks=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tmxtOwOhkKzMEj+l4kjbSGSuOg7q9bHOnXBu+LsMBBRZo8TYzqttB3ZNEaxUX6m28
	 igTKTyxj3cQRvmuvLaRvYHJw+nt5jnTp7wXY0m0QnUm8yu091nD34pKpvnSAIgAccP
	 uGSdwoFTKF/uACYkjMzjVw6CB1kQiTp6zQpGjdX/pX/SAiO6clV+uztpVXo+ZntuvP
	 agHB0e4n7vRHhepIRQFJ6LpOgMB2Be8yKcppfPk6Jvp/CpYr9ZeC46kfu4CB73QFsA
	 XOow38xou8xbkFJRc/SM44AAtfsLR94yXX8ZlwSrgYBRZWXksYlLpcZSRrXYMwN8DN
	 J+X+j28Gsr7mQ==
Date: Thu, 5 Mar 2026 18:08:43 -1000
From: Tejun Heo <tj@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Tobias Schrammm <t.schramm@manjaro.org>,
	Sebastian Reichel <sre@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Krzysztof Kozlowski <krzk@kernel.org>, Lee Jones <lee@kernel.org>,
	Dzmitry Sankouski <dsankouski@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Benson Leung <bleung@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	driver-core@lists.linux.dev, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, chrome-platform@lists.linux.dev
Subject: Re: [PATCH v2 01/10] workqueue: devres: Add device-managed allocate
 workqueue
Message-ID: <aapTSyrkqqZ8j_XL@slm.duckdns.org>
References: <20260305-workqueue-devm-v2-0-66a38741c652@oss.qualcomm.com>
 <20260305-workqueue-devm-v2-1-66a38741c652@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260305-workqueue-devm-v2-1-66a38741c652@oss.qualcomm.com>
X-Rspamd-Queue-Id: 680AA21B61F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-43741-lists,linux-pm=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[linuxfoundation.org,kernel.org,lwn.net,gmail.com,manjaro.org,linux.intel.com,linaro.org,collabora.com,chromium.org,lists.linux.dev,vger.kernel.org,lists.infradead.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tj@kernel.org,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-pm];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On Thu, Mar 05, 2026 at 10:45:40PM +0100, Krzysztof Kozlowski wrote:
> Add a Resource-managed version of alloc_workqueue() to fix common
> problem of drivers mixing devm() calls with destroy_workqueue.  Such
> naive and discouraged driver approach leads to difficult to debug bugs
> when the driver:
> 
> 1. Allocates workqueue in standard way and destroys it in driver
>    remove() callback,
> 2. Sets work struct with devm_work_autocancel(),
> 3. Registers interrupt handler with devm_request_threaded_irq().
> 
> Which leads to following unbind/removal path:
> 
> 1. destroy_workqueue() via driver remove(),
>    Any interrupt coming now would still execute the interrupt handler,
>    which queues work on destroyed workqueue.
> 2. devm_irq_release(),
> 3. devm_work_drop() -> cancel_work_sync() on destroyed workqueue.
> 
> devm_alloc_workqueue() has two benefits:
> 1. Solves above problem of mix-and-match devres and non-devres code in
>    driver,
> 2. Simplify any sane drivers which were correctly using
>    alloc_workqueue() + devm_add_action_or_reset().
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Acked-by: Tejun Heo <tj@kernel.org>

Please let me know how you wanna route the patch.

Thanks.

-- 
tejun

