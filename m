Return-Path: <linux-pm+bounces-43904-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sJRaHxE/rGmingEAu9opvQ
	(envelope-from <linux-pm+bounces-43904-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Sat, 07 Mar 2026 16:06:57 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F41E122C4E1
	for <lists+linux-pm@lfdr.de>; Sat, 07 Mar 2026 16:06:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 993903017268
	for <lists+linux-pm@lfdr.de>; Sat,  7 Mar 2026 15:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7E763A1E92;
	Sat,  7 Mar 2026 15:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JAjx6vgl"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8463F1A9F93;
	Sat,  7 Mar 2026 15:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772896014; cv=none; b=ZK4uCMLSc3Aou7vo9KsR5hspP8f/ydn2q6OuuZ5a56DFHKZh3mAlr2A3IT0Yk89152n4GImKpmK6PzFiFpQUDBN2Vs3OJxOCVTFwI4mNtOiRb40IIG671RdSMT2Zz1gT0Ex2zq3Cf88rDVZUcv2H3LdWmgcvJ54swJJnUdVtEWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772896014; c=relaxed/simple;
	bh=3RWqiR/mC38WLnP0x0wZe6B+f7mQm4ypzGLFZ6do8fQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OB1t/uzcsprmEJiR2XOdfwgBx2OERBRZ5PPHCAkkVXgMjZHLAPjGF7io8Z/0FnA0222ShtbeNdl4FRNYjXmPIRhZjNliosCSlp0XmoHRu2/0WXHKGQCrl+BptDhxzoru7BOm0h5CKP+67CYWoBbpf6zgv97v9LqBOLBkpwqoLAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JAjx6vgl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A64DC19422;
	Sat,  7 Mar 2026 15:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772896014;
	bh=3RWqiR/mC38WLnP0x0wZe6B+f7mQm4ypzGLFZ6do8fQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JAjx6vglkmhCf5wN1irFrsQ+0wiNNhSXdWbDWkbOfvkJ+jtPdSCKPL8YEfEraYyuz
	 UW9ZdBpuGnhWD/9ELVWiDqNEB69wPJ6XUxRqh9rCPBryuq853j1QqLxyoaWjt4r6c5
	 nJMJhNJMIzlBhLJk1crPiBtZ3qISUszdlFMgtRlD5e67tJKCoMvCWXcF0NqDy1ZYmr
	 e6rUSI/SHGBCCKcpmZCuIjdsCUo0OHtk+/ojsxpY9pfJmlNhEHsfNbsPXg+u7O/Uqd
	 OgwwqJXMSZ6NKl50OyC7GdjP0V/abWmHTblySZH0ayjvqBCSPy4rO+diY/1dOnp/Mc
	 8CcoQHB8HJRJw==
Date: Sat, 7 Mar 2026 16:06:51 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Alexey Charkov <alchark@flipper.net>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chris Morgan <macromorgan@hotmail.com>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Sebastian Reichel <sre@kernel.org>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Sebastian Reichel <sebastian.reichel@collabora.com>, 
	linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 01/11] dt-bindings: mfd: ti,bq25703a: Expand to
 include BQ25792
Message-ID: <20260307-elegant-cherubic-caracara-dc494d@quoll>
References: <20260306-bq25792-v2-0-6595249d6e6f@flipper.net>
 <20260306-bq25792-v2-1-6595249d6e6f@flipper.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260306-bq25792-v2-1-6595249d6e6f@flipper.net>
X-Rspamd-Queue-Id: F41E122C4E1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-43904-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,hotmail.com,gmail.com,vger.kernel.org,collabora.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.987];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krzk@kernel.org,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,qualcomm.com:email]
X-Rspamd-Action: no action

On Fri, Mar 06, 2026 at 06:33:01PM +0400, Alexey Charkov wrote:
> TI BQ25792 is similar in operation to BQ25703A, but has a different
> register layout and different current/voltage capabilities.
> 
> Expand the existing BQ25703A binding to include BQ25792, and move the
> voltage and current limits into per-variant conditional statements.
> 
> Signed-off-by: Alexey Charkov <alchark@flipper.net>
> ---
>  .../devicetree/bindings/mfd/ti,bq25703a.yaml       | 73 +++++++++++++++++++---
>  1 file changed, 63 insertions(+), 10 deletions(-)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof


