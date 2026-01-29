Return-Path: <linux-pm+bounces-41670-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MBamIuMRe2nqAwIAu9opvQ
	(envelope-from <linux-pm+bounces-41670-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 29 Jan 2026 08:53:07 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C6E4AD077
	for <lists+linux-pm@lfdr.de>; Thu, 29 Jan 2026 08:53:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CCAB330058DD
	for <lists+linux-pm@lfdr.de>; Thu, 29 Jan 2026 07:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26AEB37B417;
	Thu, 29 Jan 2026 07:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hITg21l2"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29CA137AA92
	for <linux-pm@vger.kernel.org>; Thu, 29 Jan 2026 07:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769673183; cv=none; b=ZIG3BcX0X2wl+btTIe0Qspk501ufEvbfoJITGhrUQf+CMV2RX/dX1Rettf+OsB0FzjFwKOOYj+DCKoJXEbn/0+rWUxaMytDjpyrc40/rIFNnry8OLU9ph6oRoKh9TbHm0BAQBzETtJwjnSwtAj/5jz39fHXhORevh30xOhwQS0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769673183; c=relaxed/simple;
	bh=TreBPbYcd+qcEfeyzd9gSmsPnjmGM3aP8CkrKuGABXo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LSTG6GTgnnAvfqOrtwAmk8kMZZfPXg4TGfSohV44pQXYbDUY4Eg5LaTxEQdcdV5zdfbCjEU3zHBViauiTG1ogNAEp4rJc+ioxxhocrK4gVQbX5qC+eXGAvbKy2/aPcCS8Pa8oqD2q8U3OOiLjcuo3AFBqwIbWIij6z9aOjgKnfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hITg21l2; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-47ff94b46afso5361045e9.1
        for <linux-pm@vger.kernel.org>; Wed, 28 Jan 2026 23:53:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1769673179; x=1770277979; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TreBPbYcd+qcEfeyzd9gSmsPnjmGM3aP8CkrKuGABXo=;
        b=hITg21l2RRszOmIciwQjy2uAj0jupjwwklVg+fvb3B7bBd58xF/oWBM4QRvWZu07N1
         L+xjAlc0SoxWIv1dued1hCfn/9RgC+RpO4ggr1yTuUTuyr2kpZfARFF8G/yzbVd5jLLQ
         FXpRGxp4RyEBMdc7yC2y2KkTYGY5WQS0wfM4ED5hBEEadYh2sfp1x3qvSSxFIxlomM7D
         cOiIQgw3/PrqNclCYEkuypajUxcanDP+vk/HS90xsH62ESbSNXExOtwjBJwAzMNn7O2R
         AmOdAgmjWUY6ojcn5HQU3jY9WJPERuJmrA2so7Ip8zNhSwbMB+W6PWD5ltFG48CZKSKx
         odiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769673179; x=1770277979;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TreBPbYcd+qcEfeyzd9gSmsPnjmGM3aP8CkrKuGABXo=;
        b=lHhPgxOsjswAv9xnocQbcThvBp9s1d1Z//v8a5kiAwTG2BSl8d5fNUaJfHzcq+yuaN
         A3sKzYHrXU8HrEESmN5Erw1+WmM2p913/kJ8Rn9l0IViBFGBOUHJZ0D7kXeG19sGxnOI
         db0WETXpNX2KfUZTnjkXJKKWI8NaPjy6pL32rCM8p1KMfBD+I89MD4/El68eF4Qh3bJQ
         Nk6eCjWdeU14IsB3SWCHPFhnxKAFzSYOyZhG/xpjAkRyTzqedydbxnAFv0Z7PjaHuCKM
         UPYlwYkOuGziFj9eK/mAY5ehYzfKtcAbVVw7sJ6EjKdFdkYi1p1ww6eLsYt+jKsM0XHO
         uEmg==
X-Forwarded-Encrypted: i=1; AJvYcCU7uE0e08R/lOM7F2Ix4P6Vr5uXpf2LI62QQDO027KgLJvlBlEVksnjdXYGl55YER2D12EiIaP+qw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx86kdY0Wh3UyH3oY6yRvQKsfFy+/Y7drvsC2fls1KW6lcosAOE
	wXjbRaPI6W7w95LIw+e80mWZ7Y5JowBrRfBOsQcKbhEICYjoeADSArMllNEzmWEhgXE=
X-Gm-Gg: AZuq6aK/opKOa1YIGqgLsJyw8GwCo53yXX3iv2pBCgehG+MUYdkHAAPG7tGphAGqevr
	j2JLeJzg+/tKrE/Ze5j6EMekB+JleVSc3Pei/IEvk4b3p4jxyMzxNp+auB663L/ubtiM1jOyXm8
	g7kJbvwxfvcLT3xJLRk7SBWQSzUaBh12fdjs7t9EpCd68OkaTmjFTM/ESzL6JnaVfwnhrDb9DVE
	2qkdEisV194P+MQ23W3UZ6u+SMf+8dl6fW952kmzSXvCaXCazHUwVFAmCsxViwNkahn44yC+cRT
	5dw+jDoyrTgVr2fnyRDkQB/Yy4GMTL1B0KFI3RMy/OxAMevlBu82cUm4sfidf5YehxPsW59KbkP
	eQOa7qrx29a7v2X7VPfM2PfkJMs+nxUkfIQZ5rm78vIge/RkdFpjlZgOnTHEuIZ18MHY8n5EZt4
	2crvmdyeNbjsI3LNogrw==
X-Received: by 2002:a05:600c:450c:b0:47d:6c36:a125 with SMTP id 5b1f17b1804b1-480829beec9mr29095775e9.17.1769673178631;
        Wed, 28 Jan 2026 23:52:58 -0800 (PST)
Received: from draszik.lan ([212.129.82.147])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-481a5d31756sm4253955e9.2.2026.01.28.23.52.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 23:52:58 -0800 (PST)
Message-ID: <3471955c681a8f9fb0ddf2dd421e1b4552dfbea5.camel@linaro.org>
Subject: Re: [PATCH v4 10/10] pmdomain: samsung: implement domain-supply
 regulator
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>, Alim Akhtar
 <alim.akhtar@samsung.com>,  Rob Herring <robh@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,  Ulf
 Hansson <ulf.hansson@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark
 Brown <broonie@kernel.org>
Cc: Peter Griffin <peter.griffin@linaro.org>, Tudor Ambarus	
 <tudor.ambarus@linaro.org>, Juan Yescas <jyescas@google.com>, Will McVicker
	 <willmcvicker@google.com>, kernel-team@android.com, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org
Date: Thu, 29 Jan 2026 07:53:10 +0000
In-Reply-To: <20260128-gs101-pd-v4-10-cbe7bd5a4060@linaro.org>
References: <20260128-gs101-pd-v4-0-cbe7bd5a4060@linaro.org>
	 <20260128-gs101-pd-v4-10-cbe7bd5a4060@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-2+build3 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-41670-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,samsung.com,linaro.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linaro.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andre.draszik@linaro.org,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linaro.org:email,linaro.org:dkim,linaro.org:mid]
X-Rspamd-Queue-Id: 2C6E4AD077
X-Rspamd-Action: no action

On Wed, 2026-01-28 at 16:10 +0000, Andr=C3=A9 Draszik wrote:
> Some power domains on Exynos are fed by a regulator rail and therefore
> regulator control needs be implemented for Exynos power domains.
>=20
> On Google gs101, HSI0 (USB) is one example of such a power domain.
>=20
> While at it, add a to_exynos_pd() to avoid direct use of
> container_of() in various additional places, and update existing code
> to use it.
>=20
> Signed-off-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>
> ---
> =C2=A0drivers/pmdomain/samsung/exynos-pm-domains.c | 53 +++++++++++++++++=
++++++++---
> =C2=A01 file changed, 48 insertions(+), 5 deletions(-)

Looks like I forgot to include the binding patch for this, will
do a v5 shortly.

Cheers,
Andre'

