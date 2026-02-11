Return-Path: <linux-pm+bounces-42486-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UJmZO3kljGnjiAAAu9opvQ
	(envelope-from <linux-pm+bounces-42486-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 11 Feb 2026 07:45:14 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A2FB121AD3
	for <lists+linux-pm@lfdr.de>; Wed, 11 Feb 2026 07:45:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6A93830616D7
	for <lists+linux-pm@lfdr.de>; Wed, 11 Feb 2026 06:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E4783446C2;
	Wed, 11 Feb 2026 06:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ToKM3CgU"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A40A33FE1F;
	Wed, 11 Feb 2026 06:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770792285; cv=none; b=A2CFXt7PcZ2PQPZL9p4eVMaiduLZageExcPAQupuN9SY/pjI4NufG7DqkLVKTY9GXYJU1QkozEXXQ9BxTTD945muXKV6nppfIAwUgHzYWaDbX4jn3SEU0qLUeYVJ3IJycMEu4r3L8QxgYlaDIHG/Sb9Rnl5xWnmho63TtnB/duI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770792285; c=relaxed/simple;
	bh=3djo9Qmfdzan0IAZWyZvmp4FhZLmI6JZf/+TmkMe4TA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tLzJrwxgg+L7KpNKCrtn5U4/9iaQK157Mc+EfeKjYe3tWWKctIjr/qx+L/2SjWvbd3pTbLsaNG2n2xhDZEh7f+brCMj+cEo6RUzyGYg0zG/IlbDyn/WD9hy9/LIA7Mk++cgzxoKM+ykjZqJf6rRe4d6rnT8a4gC4X0NFLlcpibw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ToKM3CgU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4664CC4CEF7;
	Wed, 11 Feb 2026 06:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770792284;
	bh=3djo9Qmfdzan0IAZWyZvmp4FhZLmI6JZf/+TmkMe4TA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ToKM3CgUkHshGA3xcxhM/66ew0qrGe4H3qOB9WekDJ4y7SJuvcBktw++4nP3P+aws
	 StbeYHFcqLPQ0Pdy+KF0hD108LIOR5NQwnYu4U4hNQKA/zOieh4FoXhTTM/s/MmJao
	 rqNf5pUjnrv3T91T374YI99hgaJQMg3lau2WwYKJp1a/4uhifpeclHJfpRlh+Cb8nf
	 Oy4Q5oMqPMQ5GhRYo5L9XGH9JWGkSe24Ahh6kfwXA2oZ+7h8GXHW/YcpB8qeRCPn9l
	 TN2JeMNfMR8woGb8Sf2FsrrSYMiZGiFDT8Iq0RGRz/EDa16Q+RrsKWEdRfLrinZnvr
	 AFm+WQBjPwPbA==
Date: Wed, 11 Feb 2026 07:44:42 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Richard Acayan <mailingradian@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Amit Kucheria <amitk@kernel.org>, Thara Gopinath <thara.gopinath@gmail.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
	Stephen Boyd <sboyd@kernel.org>, Dmitry Baryshkov <lumag@kernel.org>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: mfd: qcom,spmi-pmic: Allow PMIC4
 thermal monitor on pm660
Message-ID: <20260211-enthusiastic-military-caracara-af0b65@quoll>
References: <20260210021819.12673-1-mailingradian@gmail.com>
 <20260210021819.12673-2-mailingradian@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260210021819.12673-2-mailingradian@gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42486-lists,linux-pm=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[18];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:email]
X-Rspamd-Queue-Id: 8A2FB121AD3
X-Rspamd-Action: no action

On Mon, Feb 09, 2026 at 09:18:17PM -0500, Richard Acayan wrote:
> While newer PMICs are compatible with PMIC5 drivers, the PM8998 and
> PM660 are both PMIC4. The PM8998 is allowed to use the PMIC4 thermal
> monitor. Allow it for PM660 as well.
> 
> Signed-off-by: Richard Acayan <mailingradian@gmail.com>
> ---
>  Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof


