Return-Path: <linux-pm+bounces-43059-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UKpNIfGSnGnRJQQAu9opvQ
	(envelope-from <linux-pm+bounces-43059-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 23 Feb 2026 18:48:33 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F2ACF17B0CD
	for <lists+linux-pm@lfdr.de>; Mon, 23 Feb 2026 18:48:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DA0713008A5A
	for <lists+linux-pm@lfdr.de>; Mon, 23 Feb 2026 17:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D63843382E4;
	Mon, 23 Feb 2026 17:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E9x7G4jR"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFFBE337BBF;
	Mon, 23 Feb 2026 17:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771868753; cv=none; b=DnbDwHBnUxnrd3/1F6MY6sqU3koneTnFGzQpeCKxSUpwqbMOdAwSpnbSKrMDzB4gS9tJoMbFsRsYbUZ3VARGbFdDYz6KwnD4kbchXTZfBQ5JeunWJTHsAoWW4/Zq/gUir8FCfgXmAcKvn02LHgemiwr/8y+O8I5cz3Zbo1naulA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771868753; c=relaxed/simple;
	bh=t1u9ZUKsO/VeLrH9SoqNc6k8gKeSI/ecTL9SL8oMUPs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i6vK6h4ttfAj3zShBzm1HHOEqb0DVewuwEg4304L0HA8uxVcPQep9S3tPbPcaogo3sQ9RdFJhe6nx+YF3Ku2gRF2tqhG0sXmWFJnorCJHuu0uMp96zsEmJxFUXz34p1ke93BDoB6h3mF2VICt5YN5GaMMA4FLXqggkzX4WT3IKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E9x7G4jR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19C81C116C6;
	Mon, 23 Feb 2026 17:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771868753;
	bh=t1u9ZUKsO/VeLrH9SoqNc6k8gKeSI/ecTL9SL8oMUPs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E9x7G4jRuexobYHdSyWkem67PHlAPwBTpSI5UtTM/BZ4fNKdkdEOldTIHECVHqjv9
	 YXYlwcNcc6ovFi/TzEcTprSls6K4ckP0MVAjtaS7lxc0+Wpcktlx2WV2e/NSWthqzF
	 3wmOsEPNH0cNp3/Bdrn/tKPtt7PSOd1FCXjIOI45nnZkC/ILoW+hTL6vgeVqy6pgvv
	 516Hw+wxmxVdK8gRBfN15/tzr5KeUG8BSOaUSCqYJvnNuGvQ1e7TTLgDjADyZTViUV
	 JGus0M8EDaDQ2f5YEYR2QUE5ALP1dguJfmkHknAe7GgEOH4BLTik+DyEYksD+A7iRT
	 gV/HiASnKPSOQ==
Date: Mon, 23 Feb 2026 11:45:52 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Thara Gopinath <thara.gopinath@gmail.com>,
	Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
	Zhang Rui <rui.zhang@intel.com>, linux-kernel@vger.kernel.org,
	Amit Kucheria <amitk@kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
	devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH] dt-bindings: thermal: qcom-tsens: Add Eliza SoC TSENS
Message-ID: <177186875170.4166014.1658011099228218847.robh@kernel.org>
References: <20260212161949.120898-2-krzysztof.kozlowski@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260212161949.120898-2-krzysztof.kozlowski@oss.qualcomm.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,vger.kernel.org,intel.com,arm.com,linaro.org];
	TAGGED_FROM(0.00)[bounces-43059-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[robh@kernel.org,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:email]
X-Rspamd-Queue-Id: F2ACF17B0CD
X-Rspamd-Action: no action


On Thu, 12 Feb 2026 17:19:50 +0100, Krzysztof Kozlowski wrote:
> Document the compatible for Qualcomm Eliza SoC TSENS module, fully
> compatible with TSENS v2 generation (e.g. SM8650).
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> 
> ---
> 
> Eliza SoC is being upstreamed and the compatible will be used in DTSI
> posted later/soon.
> 
> Some existing work:
> https://lore.kernel.org/r/20260119095907.172080-4-krzysztof.kozlowski@oss.qualcomm.com/
> https://lore.kernel.org/linux-arm-msm/?q=eliza
> ---
>  Documentation/devicetree/bindings/thermal/qcom-tsens.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


