Return-Path: <linux-pm+bounces-42147-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2Bc4N+eNhGl43QMAu9opvQ
	(envelope-from <linux-pm+bounces-42147-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 05 Feb 2026 13:32:39 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CD62F28B4
	for <lists+linux-pm@lfdr.de>; Thu, 05 Feb 2026 13:32:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E33D9300AB29
	for <lists+linux-pm@lfdr.de>; Thu,  5 Feb 2026 12:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFF323ACEEF;
	Thu,  5 Feb 2026 12:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="agkYbu+s"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A80335505F;
	Thu,  5 Feb 2026 12:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770294497; cv=none; b=c5FKDrKtgrbyYlCwlen+Igjbe1d4SnHH30PYacz1Q8CU93MJzHhHyfDF6vCN6xa+59TWePsc+G9dYrgk3eyWAGTOt7qLqtQRIkp8Dc1FDqYyYR6CW1mrLhsR4R4MANnWHLedrWx1cdbRCJcEw8V99AxUvw/UljcwMBQP7lbao5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770294497; c=relaxed/simple;
	bh=xo4YYHqXm9wbcjSNzlMe9/RyPh0dV7EmHJEqyMVOXc0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KUWl8ZrziiQbyMBrRgmr0QfCG2pX0+Snp6zXBiTBJAUbQYNUl3UYke9tCULW3NXVJuCd1gz5lIrSp/mZY1byIB/SrJHiSF2pTTu9bb+a5fGxmkBU2SxuDnLdaod+SzyWYRdpZQwQMmOuo1Fx5LRBFvPohzkqqPWHJH4tjYrPloA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=agkYbu+s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 879E5C4CEF7;
	Thu,  5 Feb 2026 12:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770294497;
	bh=xo4YYHqXm9wbcjSNzlMe9/RyPh0dV7EmHJEqyMVOXc0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=agkYbu+sh5d4t7KEGFrJIzuZ1hn9y0kbRQ6sdsmtTI6MOrWFl33a/5Nt+y/n/a6aO
	 f8xO4omNUF40uPF9GHahgnXgp0mpvDPGPX07U/w2UeYiM8Ka69i6/v9RbbAp4MCw9c
	 GQ/w+MTjVur80zBVh4DYInmabOOP8m8kAjDa4HadMj3QxCMPE17/CXfw+Lu1d0Iiz0
	 XAQFUjvCGtU1GGglCvKH1Bz47aVHi5RSnvt36z+wBR+lD3PtF160dpnPzA7EqduqAb
	 MXv5uYQgiN+7E8ys5F1ZDcF5gioMSW9xncw/9QzIgFumhc7hWwJbvLs5IbBRjwOkqY
	 1CqPOJKGB7uUg==
Date: Thu, 5 Feb 2026 13:28:14 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
Cc: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>, Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Mike Tipton <mike.tipton@oss.qualcomm.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: interconnect: qcom,qcs8300-rpmh: add
 clocks property to enable QoS
Message-ID: <20260205-honored-artichoke-labradoodle-558ece@quoll>
References: <20260127090116.1438780-1-odelu.kukatla@oss.qualcomm.com>
 <20260127090116.1438780-2-odelu.kukatla@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260127090116.1438780-2-odelu.kukatla@oss.qualcomm.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42147-lists,linux-pm=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krzk@kernel.org,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:email]
X-Rspamd-Queue-Id: 8CD62F28B4
X-Rspamd-Action: no action

On Tue, Jan 27, 2026 at 02:31:14PM +0530, Odelu Kukatla wrote:
> Some QCS8300 interconnect nodes have QoS registers located inside
> a block whose interface is clock-gated. For those nodes, driver
> must enable the corresponding clock(s) before accessing the
> registers. Add the 'clocks' property so the driver can obtain
> and enable the required clock(s).
>=20
> Only interconnects that have clock=E2=80=91gated QoS register interface
> use this property; it is not applicable to all interconnect nodes.
>=20
> Signed-off-by: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
> ---
>  .../interconnect/qcom,qcs8300-rpmh.yaml       | 63 +++++++++++++++++++
>  1 file changed, 63 insertions(+)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof


