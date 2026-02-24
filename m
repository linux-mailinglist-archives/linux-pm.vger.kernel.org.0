Return-Path: <linux-pm+bounces-43107-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MAzuOaZTnWk2OgQAu9opvQ
	(envelope-from <linux-pm+bounces-43107-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 24 Feb 2026 08:30:46 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D1F61830B9
	for <lists+linux-pm@lfdr.de>; Tue, 24 Feb 2026 08:30:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1B1AA304138D
	for <lists+linux-pm@lfdr.de>; Tue, 24 Feb 2026 07:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EBD03644AD;
	Tue, 24 Feb 2026 07:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y/1scBmv"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00B630AAB8;
	Tue, 24 Feb 2026 07:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771918153; cv=none; b=OnF6LKDodSSlgf48kAD0PNXmMLWA7lcQhOb4UQ9Oa5V0L2J7fhFAQvWIfkhAe5N65W+saHJhhj2WrIEyOTOzloKeUktH0QuzKNo0p2q7TlbwW4xD+QLdTlglLhrD7tVoTkTO4nAswBVRpDq+Mx0sNKhkyrl1ChzSl61VAbjqpcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771918153; c=relaxed/simple;
	bh=PdqC61t4BXjxWMoyeJSIccI4XzpPecu3tbCxsbfzHms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X8oJ4nRqzDRG/Vr+M43cSxWjLEPFn8I8e1yjtZNc3e73xrhQzGaze5IGVVI0S9Cev+TfBrY3lywzZ0XZBfwkY2KpyDpbzC7FZ2IpbVCc/oNOr0xqQCEzoLBOw3JzSuNgg2kKpK4NtmJ9s9gJ5CIG2Nrpr2XgMzvvb9D1YiljVq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y/1scBmv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E52B1C116D0;
	Tue, 24 Feb 2026 07:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771918152;
	bh=PdqC61t4BXjxWMoyeJSIccI4XzpPecu3tbCxsbfzHms=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y/1scBmvtFUQYn59I7lozRgzHZ7a54YW5GYZHN5oLogwNH/sGNS1sB0L0Ihve/Lpq
	 GwtToGHErBAujlgGvrdUZye+2Obju4rMsJVnQ7m3IhZiQ/dE6irptnxujYZJ35nEDq
	 dobhwFK+PoFH1NZ6tnXVlbHJx7XTY/ZK9dFm/cUbGHmBFuw94SC6On+OlbKNEoxxC/
	 T593J5mWy51xPZYDAoEH4R8TlVb50zL4mPg+ehSZ3XE8LampjVIkIhOcu9dQOYVV/C
	 9QaQOiQAUdMdctqZhJr3OJAY6ftp0tmXbgIQt+81jJBStOC6OkggoqUlWHSifIBE28
	 SJ+wp+ECndPYA==
Date: Tue, 24 Feb 2026 08:29:09 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Abel Vesa <abel.vesa@oss.qualcomm.com>
Cc: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Sibi Sankar <sibi.sankar@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: interconnect: OSM L3: Add Eliza OSM L3
 compatible
Message-ID: <20260224-hilarious-tasteful-narwhal-c492a5@quoll>
References: <20260223-eliza-bindings-interconnect-epss-l3-v1-1-fa83970d60ae@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260223-eliza-bindings-interconnect-epss-l3-v1-1-fa83970d60ae@oss.qualcomm.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43107-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krzk@kernel.org,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:email]
X-Rspamd-Queue-Id: 8D1F61830B9
X-Rspamd-Action: no action

On Mon, Feb 23, 2026 at 10:49:04AM +0200, Abel Vesa wrote:
> Eliza, similarly to SDM845, uses OSM hardware for L3 scaling.
> Document it.
> 
> Signed-off-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
> ---
>  Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml b/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml
> index 4b9b98fbe8f2..6182599eb3c1 100644
> --- a/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml
> +++ b/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml
> @@ -28,6 +28,7 @@ properties:
>            - const: qcom,osm-l3
>        - items:
>            - enum:
> +              - qcom,eliza-epss-l3

I see EPSS, not OSM here. This is also list without SDM845, so I don't
understand explanation in commit msg at all.

>                - qcom,sa8775p-epss-l3
>                - qcom,sc7280-epss-l3
>                - qcom,sc8280xp-epss-l3

Best regards,
Krzysztof


