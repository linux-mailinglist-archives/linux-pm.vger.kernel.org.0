Return-Path: <linux-pm+bounces-42418-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oLvVMl76imlBPAAAu9opvQ
	(envelope-from <linux-pm+bounces-42418-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 10 Feb 2026 10:29:02 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CDA9118E11
	for <lists+linux-pm@lfdr.de>; Tue, 10 Feb 2026 10:29:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 10640303AF27
	for <lists+linux-pm@lfdr.de>; Tue, 10 Feb 2026 09:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7027F340DA5;
	Tue, 10 Feb 2026 09:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YGBJT/Pa"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D1D4340A62;
	Tue, 10 Feb 2026 09:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770715740; cv=none; b=pDGEEYwfwo3a/VgEDFtX+qjsIfWT9rb8BNDPFe2eei8R2BVtgLILW5QPss9kT5qaX1C6Q3lzDumJy1OkeEErracgTnMEXVDnLEG9dcwBs2wcBJfh+pCdkv/2n5lONcwBI6PYMvaIreyng6f3ZF4zog+mZo2igdl2/eqH4t1MdJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770715740; c=relaxed/simple;
	bh=8hC2JU7EQQsw93ovqufBkmsny73TdehiI+uHk7YImNs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OrlX/FZFMnSV/yJNZHP1CIRvCb1oxhelzcW0nKGgTyM0OP1TOoNwJupuKF/XX3TzByHKDqDcArr/gJYiOCY/y09fsAeKLp4r0ZQYXFcaV0y6IWA5bU8iiRwkw36k/OzNn8e6oTw2REIWAPBo1nNsXY8oal3mpTF+Qm/Mx5xqxVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YGBJT/Pa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0800DC116C6;
	Tue, 10 Feb 2026 09:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770715739;
	bh=8hC2JU7EQQsw93ovqufBkmsny73TdehiI+uHk7YImNs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YGBJT/PagjwqHkEI9PV/azeXxoXIEs/h6U5UFgCK6sSSOYTC3+tfqeZtXTpX4k6bu
	 2ky9HhJCRY5pfVRydV7ImVcPZwbAt6LMP9SCSdN9Hwevn3/ihWJqf0I2bjgIpzNpCe
	 fK+gmCxCCjFZ/9ZY9pj702kmzbJJb93agef564stCW8xlMwfJ8RGZPTJ36vv4F7Pxr
	 kOsTbiJJGh4LAH1yP6tCCz2L2k0/vXExR3gSNoBtbkb8Zicg22oy83RKG8hTS1zcVK
	 J5qIMEpP62yk0/Kd6V9fpCGnfcHz6JZIST/YEEGjZCO9qY+666QS2Q6sLy88b4qvuN
	 5NHNYPC2n0PVg==
Date: Tue, 10 Feb 2026 10:28:57 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Richard Acayan <mailingradian@gmail.com>
Cc: Amit Kucheria <amitk@kernel.org>, 
	Thara Gopinath <thara.gopinath@gmail.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: thermal: tsens: add SDM670 compatible
Message-ID: <20260210-outgoing-bald-bullmastiff-a81dfb@quoll>
References: <20260210021607.12576-1-mailingradian@gmail.com>
 <20260210021607.12576-2-mailingradian@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260210021607.12576-2-mailingradian@gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42418-lists,linux-pm=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krzk@kernel.org,linux-pm@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,linaro.org,intel.com,arm.com,vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:email]
X-Rspamd-Queue-Id: 4CDA9118E11
X-Rspamd-Action: no action

On Mon, Feb 09, 2026 at 09:16:06PM -0500, Richard Acayan wrote:
> Add the compatible for the thermal sensors on the SDM670.
> 
> Signed-off-by: Richard Acayan <mailingradian@gmail.com>
> ---
>  Documentation/devicetree/bindings/thermal/qcom-tsens.yaml | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof


