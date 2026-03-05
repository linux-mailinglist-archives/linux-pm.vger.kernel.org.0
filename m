Return-Path: <linux-pm+bounces-43664-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4IuML7VNqWk14AAAu9opvQ
	(envelope-from <linux-pm+bounces-43664-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 05 Mar 2026 10:32:37 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 25DBF20E796
	for <lists+linux-pm@lfdr.de>; Thu, 05 Mar 2026 10:32:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 71D6F302EE94
	for <lists+linux-pm@lfdr.de>; Thu,  5 Mar 2026 09:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9C383793A2;
	Thu,  5 Mar 2026 09:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="lRcnDvSw"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BADCB3793A8;
	Thu,  5 Mar 2026 09:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772702931; cv=none; b=pUlKmN07DSE2EYt1OK7WmSDJuxh07Mcoa5LxenK6KY/+3Y63+QXDkMh/xA5nYpkNNppOpkV38Jeab1ZUy+UObYVNVBm0eKveiiQvYkx1MZBh48YqTbxUxLzg1WN2ktRdCevftBD5POAVzHBQwFw+tHItQy8xL+KFnIXTkZfDx4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772702931; c=relaxed/simple;
	bh=POsufyN7QZ3+z4EbVF66dVrX27WEbk5OK1EwP6/UA+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OlnMdpgk6z7L+EBqoiJYq0FaN4CUAzhGB3soQ4BUo/mW+fFL7yCw1o0H37x9BvhiqcvZ9b1cdheaAPoEkbCwHvtqP06uh2ycx13g7jie5np66v9YoHcIGA1yi3ryR0qwI79AWZlLPvc1irnN9uSflHUk0RTLNrcdy1uSWaQHalw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=lRcnDvSw; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 6720C24165;
	Thu,  5 Mar 2026 10:28:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1772702924;
	bh=ETIvqL9lvf0sw7oQcZ6n+kIIlGROd+juMlH/vMKkU3E=; h=From:To:Subject;
	b=lRcnDvSwPeltFghfnuL2un/gCumEOzScg/vZNmVraL8ygGuCjHheZ/KL7GAB/wpKq
	 7PsU+phXNYin88kUTgmsKf45xDu/rZQthoVoZFzqSFGwYl7z9PBj84kgBy9JgZgcFC
	 IbFats33QhC5siQDk5o1kl7/h4o8XiuWbxRuYvejk079uY5wMHL9UR+h1qclnzEX88
	 BVkaFLHlQQjzWHVWlL6nSMy7mP7AEQOnqmpJzH9s8oG6v6BcznOmQvN1jrVLGnN7NR
	 G9D3CBkbuSAhTJZ9xN6KJFFHG0k4sYPqEIPLCbQxDihO9myNizeSeBPDzsI6aZg0PA
	 k9Ldc0ZVAzIsA==
Date: Thu, 5 Mar 2026 10:28:39 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: ming.qian@oss.nxp.com, fra.schnyder@gmail.com
Cc: linux-media@vger.kernel.org, mchehab@kernel.org,
	hverkuil-cisco@xs4all.nl, nicolas@ndufresne.ca,
	benjamin.gaignard@collabora.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, p.zabel@pengutronix.de,
	sebastian.fricke@collabora.com, shawnguo@kernel.org,
	ulf.hansson@linaro.org, s.hauer@pengutronix.de,
	kernel@pengutronix.de, festevam@gmail.com, m.felsch@pengutronix.de,
	linux-imx@nxp.com, l.stach@pengutronix.de, Frank.li@nxp.com,
	peng.fan@nxp.com, eagle.zhou@nxp.com, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] media: verisilicon: Fix kernel panic due to __initconst
 misuse
Message-ID: <20260305092839.GA24515@francesco-nb>
References: <20260305080354.639-1-ming.qian@oss.nxp.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260305080354.639-1-ming.qian@oss.nxp.com>
X-Rspamd-Queue-Id: 25DBF20E796
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[dolcini.it,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[dolcini.it:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43664-lists,linux-pm=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,xs4all.nl,ndufresne.ca,collabora.com,pengutronix.de,linaro.org,gmail.com,nxp.com,lists.linux.dev,lists.infradead.org];
	FREEMAIL_TO(0.00)[oss.nxp.com,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[28];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[francesco@dolcini.it,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[dolcini.it:+];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Thu, Mar 05, 2026 at 04:03:52PM +0800, ming.qian@oss.nxp.com wrote:
> From: Ming Qian <ming.qian@oss.nxp.com>
> 
> Fix a kernel panic when probing the driver as a module:
> 
>   Unable to handle kernel paging request at virtual address
>   ffffd9c18eb05000
>   of_find_matching_node_and_match+0x5c/0x1a0
>   hantro_probe+0x2f4/0x7d0 [hantro_vpu]
> 
> The imx8mq_vpu_shared_resources array is referenced by variant
> structures through their shared_devices field. When built as a
> module, __initconst causes this data to be freed after module
> init, but it's later accessed during probe, causing a page fault.
> 
> Use __initconst_or_module to keep the data available when built
> as a module while still allowing it to be freed when built-in.
> 
> Fixes: e0203ddf9af7 ("media: verisilicon: Avoid G2 bus error while decoding H.264 and HEVC")
> Signed-off-by: Ming Qian <ming.qian@oss.nxp.com>

In addition to what Marco asked ...

Reported-by: Franz Schnyder <fra.schnyder@gmail.com>
Closes: https://lore.kernel.org/all/n3qmcb62tepxltoskpf7ws6yiirc2so62ia23b42rj3wlmpl67@rvkbuirx7kkp/



Francesco


