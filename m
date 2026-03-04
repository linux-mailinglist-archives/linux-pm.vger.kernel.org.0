Return-Path: <linux-pm+bounces-43544-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CJWQNlXup2mWlwAAu9opvQ
	(envelope-from <linux-pm+bounces-43544-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 04 Mar 2026 09:33:25 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 96C131FCAA4
	for <lists+linux-pm@lfdr.de>; Wed, 04 Mar 2026 09:33:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 687B1301413E
	for <lists+linux-pm@lfdr.de>; Wed,  4 Mar 2026 08:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95283391833;
	Wed,  4 Mar 2026 08:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GNLdJVuG"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7076639150A;
	Wed,  4 Mar 2026 08:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772613198; cv=none; b=JSzIc1KBmnGCV5Um4Ke8oM0q2dYCE9ySqV5NYeiP9aDYv+D8c3IPZegwH9hEFEDBnxJVNXfp7hGJwlhnOJJr60RqUWguaUgfAgPHZe+/wYbAKlRb9ZFGDqbRJv/pF9WwjZGm49ou/RnknmJwGH8X0/3/I2egwLXCjZr7TkAg40c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772613198; c=relaxed/simple;
	bh=8DYzQRKsMra55l5GwvXKMq4BaXEbDFqKZmM5iSmxJUY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qjLtFOWT7mc4lYBlD+28nn1NW9AhEoKt1cZN3esq+H5xZul++BeQE5lyMB9YrtdZR+vI53RyvAVFqmYKq8kYhG9sB6zGmGrg5OyT1O+KQ/FJx+2eKGw+cpwjUXh0Vy7rwGOpd5Z7PksOtqxDu+XtINROeeTAU4Z+rHc28rTJpwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GNLdJVuG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93EFFC19423;
	Wed,  4 Mar 2026 08:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772613198;
	bh=8DYzQRKsMra55l5GwvXKMq4BaXEbDFqKZmM5iSmxJUY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GNLdJVuGVzGaCRM8Uw8dbzpFxRc7ef3myQXuNB7bBQANHzESlyO5AJwrd4S8e62tg
	 e+/c4YbGrGXzMYfP9Zy3ZnLaKXHIPKfJwITZGq9ejckkHr8ubjUPxBqReIKsS4ssVt
	 bToPDg59+c08EsnmD+MWIFG4Z+mCfOMPiN/u+xGNKLLo1L/e5QgTH73rFWMh/dEGpI
	 6Mms07s3A1oBy27ufJ53ZxRCkCinSV7LeP21JbhLmd6lNES57phc0BpGWOd+ZCIfIn
	 ohD46HMkweN9IH3HMtK8IFAEozFZrIvp+Oz4EVSiDrAq4Vche3MsS07vJTfnIGqf7C
	 ZdVpCr9GL9y/A==
Date: Wed, 4 Mar 2026 09:33:15 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Alexey Charkov <alchark@flipper.net>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chris Morgan <macromorgan@hotmail.com>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Sebastian Reichel <sre@kernel.org>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Sebastian Reichel <sebastian.reichel@collabora.com>, 
	linux-pm@vger.kernel.org
Subject: Re: [PATCH 01/11] dt-bindings: mfd: ti,bq25703a: Expand to include
 BQ25792
Message-ID: <20260304-fantastic-butterfly-of-abracadabra-8fb2c4@quoll>
References: <20260303-bq25792-v1-0-e6e5e0033458@flipper.net>
 <20260303-bq25792-v1-1-e6e5e0033458@flipper.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260303-bq25792-v1-1-e6e5e0033458@flipper.net>
X-Rspamd-Queue-Id: 96C131FCAA4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-43544-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,hotmail.com,gmail.com,vger.kernel.org,collabora.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krzk@kernel.org,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Tue, Mar 03, 2026 at 07:32:46PM +0400, Alexey Charkov wrote:
>            enable-gpios:
>              description:
>                The BQ25703 may require both a register write and a GPIO
> @@ -74,6 +65,60 @@ properties:
>            - regulator-min-microvolt
>            - regulator-max-microvolt
>  
> +  allOf:

Heh, why bothering to test your code before sending...

Best regards,
Krzysztof


