Return-Path: <linux-pm+bounces-43048-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MNyeCbV2nGmwHwQAu9opvQ
	(envelope-from <linux-pm+bounces-43048-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 23 Feb 2026 16:48:05 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9019D17903E
	for <lists+linux-pm@lfdr.de>; Mon, 23 Feb 2026 16:48:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5AF3030D3E85
	for <lists+linux-pm@lfdr.de>; Mon, 23 Feb 2026 15:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B06B12F1FEF;
	Mon, 23 Feb 2026 15:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T4XEVoLj"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE652EBBA4;
	Mon, 23 Feb 2026 15:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771861331; cv=none; b=W1pgNbitVY1QsiSC7DftZ1PNxJhKBtVkDsVGv7oEjCfiRCeW6nnTsWVmihNbm9QkQ3hSp8IKumVexhytFEM32S34qtfPWosZj1vgVULmNOU/1vl7hKWXq0vd29RXFr+AqxdHtuV8uxtuUGEuJF5zHeN2siuTcKY2hRYr/NaDaFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771861331; c=relaxed/simple;
	bh=yurSs7VYMIRx+Jmbg9pFFMOien12/FbdH7HI65YtUAA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dwNxj0HbIxQ/a1J++I2/OkuxKBJL4TRT96sqBz1XoqIZT3MQr7yo/cU5IEr/ychoM3WRjVv8Wh7NXZL65+288bb+LWrw+Ptqg0hJM2BrXu7wqCYyxzCplisiT3kJsPloaUA8NR1ofgQjgIq+pncmtvj1WhzbpVe8i+4M60Zsm9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T4XEVoLj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13CECC116C6;
	Mon, 23 Feb 2026 15:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771861331;
	bh=yurSs7VYMIRx+Jmbg9pFFMOien12/FbdH7HI65YtUAA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T4XEVoLjwgsQ7ovKA7xtbUTIVcHWVCyV6pn7LOJ292tti18smMR8wnG77SxgalbDg
	 RfgNRI6zvKs/8cXZyOMCiLBb0YqaZH9xuRDx2MY4NeupnNbZFjJqhMaJ8YeAvg7B5v
	 VBYPz9rOAI/WFv0qLsSJzaRmANj4Tm0r0GykuOYk2PjjD3h+49jCkt2p5FSw0rNbk5
	 z3KuS76ScNLrjShfi32YBoHfRV9eG09CMT3drMUaizPybn/yJnzaV8C4ege2Vjb7v4
	 wPmK9fQ3opNtBptr+RX6VE2r07joRxsro9c4TFt4tqOEhoN/+cg4n1U/D5sWlOyEsE
	 hV1PcbRbJs2aw==
Date: Mon, 23 Feb 2026 05:42:10 -1000
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
	Tzung-Bi Shih <tzungbi@kernel.org>, driver-core@lists.linux.dev,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, chrome-platform@lists.linux.dev
Subject: Re: [PATCH 1/9] workqueue: devres: Add device-managed allocate
 workqueue
Message-ID: <aZx1UpYSNmapYBpU@slm.duckdns.org>
References: <20260223-workqueue-devm-v1-0-10b3a6087586@oss.qualcomm.com>
 <20260223-workqueue-devm-v1-1-10b3a6087586@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260223-workqueue-devm-v1-1-10b3a6087586@oss.qualcomm.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-43048-lists,linux-pm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 9019D17903E
X-Rspamd-Action: no action

Hello,

On Mon, Feb 23, 2026 at 08:27:29AM +0100, Krzysztof Kozlowski wrote:
> @@ -568,19 +588,31 @@ alloc_workqueue_lockdep_map(const char *fmt, unsigned int flags, int max_active,
>   */
>  #define alloc_ordered_workqueue(fmt, flags, args...)			\
>  	alloc_workqueue(fmt, WQ_UNBOUND | __WQ_ORDERED | (flags), 1, ##args)
> +#define devm_alloc_ordered_workqueue(dev, fmt, flags, args...)		\
> +	devm_alloc_workqueue(dev, fmt, WQ_UNBOUND | __WQ_ORDERED | (flags), 1, ##args)

Let's just add devm_alloc_workqueue() and devm_alloc_ordered_workqueue() and
skip the legacy wrappers.

Thanks.

-- 
tejun

