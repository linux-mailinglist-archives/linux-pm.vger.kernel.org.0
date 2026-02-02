Return-Path: <linux-pm+bounces-41906-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mKQvEYuTgGmk/gIAu9opvQ
	(envelope-from <linux-pm+bounces-41906-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 02 Feb 2026 13:07:39 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F9E1CC2AD
	for <lists+linux-pm@lfdr.de>; Mon, 02 Feb 2026 13:07:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 350763019902
	for <lists+linux-pm@lfdr.de>; Mon,  2 Feb 2026 12:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A786D364EA9;
	Mon,  2 Feb 2026 12:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Lb/Jd4bP"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B172D8387;
	Mon,  2 Feb 2026 12:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770033729; cv=none; b=ERRib4eXGLp7RzQPi1P8VbjvYIApliV4tZJ3jk8IHQUsfFlaHT2X/jcp1MU3AqerJX6bCGrsDTBshSmIBLM8RCqQ09ATZtNUpiDxNPPtp4qxqK84MBqhbElwonSibxFzmYOif1q7U3C67am26sGE2imZ93R6kKA9Q3teT9NkbIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770033729; c=relaxed/simple;
	bh=P4Io04UTfWHKaU8dn372SXp/ADnhIotls8qbAU8ww58=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tEyzMcRVRtNSAwWoV9bvT67wTqowRXfAJWmrp21DtbFCc83sOqDKVhcnj0eBvuUtGYYP7jIU/Jz52enh0HKHEOXuk5cr4X62YKYrGU2l4Fz+WnV9hlLXWqg9SWghtY9KgmolmB66drzr47hEu1qW8YYilvVY0J5x/QsLk4z2eXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Lb/Jd4bP; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1770033726;
	bh=P4Io04UTfWHKaU8dn372SXp/ADnhIotls8qbAU8ww58=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Lb/Jd4bPneXXo7vP7EXdIy8TlmmoLMvxODxJQdtAIUr57Tpc1ISnxSTmFGNic0HrZ
	 Qzr0238dUk6clzG2Y2jZEhw75Kt/MrkxiebU/LZFeBQtc7thu6F7yWkLjSRptl+IH1
	 63nKVpZir8/aw8X8aveHklPTb6A4lOA998p0giYszrAIzF5rZY1Qh+oUcZPD9CSjSS
	 vsW7yx9EVTDNMLGBevwcHc0/jk+XWYY/M+tdzxT8sjgvoRxR29zalBeHGOEIT9YKf4
	 c5aT4DS/QU9EdricmqvPFJ+hHSiQdTFgrI09/5OecJWKBZFTjAD0y6SnUOZsL0uiKG
	 K3D/RlTtPVO7g==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 8DC8C17E1149;
	Mon,  2 Feb 2026 13:02:05 +0100 (CET)
Message-ID: <a6d810fd-111d-4121-bec1-3c3f9ca53e68@collabora.com>
Date: Mon, 2 Feb 2026 13:02:04 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] pmdomain: mediatek: Add power domain driver for
 MT8189 SoC
To: "irving.ch.lin" <irving-ch.lin@mediatek.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 Matthias Brugger <matthias.bgg@gmail.com>
Cc: Matthias Brugger <mbrugger@suse.com>, devicetree@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org,
 Project_Global_Chrome_Upstream_Group@mediatek.com,
 Qiqi Wang <qiqi.wang@mediatek.com>, sirius.wang@mediatek.com,
 vince-wl.liu@mediatek.com, jh.hsu@mediatek.com
References: <20260202064820.347550-1-irving-ch.lin@mediatek.com>
 <20260202064820.347550-4-irving-ch.lin@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20260202064820.347550-4-irving-ch.lin@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[collabora.com,none];
	R_DKIM_ALLOW(-0.20)[collabora.com:s=mail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-41906-lists,linux-pm=lfdr.de];
	FREEMAIL_TO(0.00)[mediatek.com,kernel.org,linaro.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[angelogioacchino.delregno@collabora.com,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[collabora.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,collabora.com:email,collabora.com:dkim,collabora.com:mid,mediatek.com:email]
X-Rspamd-Queue-Id: 7F9E1CC2AD
X-Rspamd-Action: no action

Il 02/02/26 07:48, irving.ch.lin ha scritto:
> From: Irving-CH Lin <irving-ch.lin@mediatek.com>
> 
> Introduce a new power domain (pmd) driver for the MediaTek mt8189 SoC.
> This driver ports and refines the power domain framework, dividing
> hardware blocks (CPU, GPU, peripherals, etc.) into independent power
> domains for precise and energy-efficient power management.
> 
> Signed-off-by: Irving-CH Lin <irving-ch.lin@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


