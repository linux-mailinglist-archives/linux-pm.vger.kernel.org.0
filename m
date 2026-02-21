Return-Path: <linux-pm+bounces-42962-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qPlLEj49mWn+RwMAu9opvQ
	(envelope-from <linux-pm+bounces-42962-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Sat, 21 Feb 2026 06:06:06 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DD9316C24A
	for <lists+linux-pm@lfdr.de>; Sat, 21 Feb 2026 06:06:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4D3CD3037164
	for <lists+linux-pm@lfdr.de>; Sat, 21 Feb 2026 05:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CB763346A5;
	Sat, 21 Feb 2026 05:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HqNlXVcO"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A5417BCA
	for <linux-pm@vger.kernel.org>; Sat, 21 Feb 2026 05:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771650363; cv=none; b=TEBdWBTJpVsJwIFfUDe3BwyiV6jDY/OksaHFB+BxKRk5rsdF72S8AzEHkb5zlRmAqwBIO4JDBwxTTbkXQR5ffbhmcA0cf31cglkuBZEHWEW8B2QR+LhLkd+7Q3LZiWUx3B9dqNqz+a0Qlfh8ypxtr/WIa+KMNW/8Qgf6+EPxLrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771650363; c=relaxed/simple;
	bh=CgpXa30rV7bbhp6oVHWrrq4qO3E2hsaZPSYf0NAhynI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CstxD3w5/xvyHN8EXS5Xlq1xXAKeIAGOgRd6AMYzN2f+KRFdwKlkzzEWjbMiUqtSb7JGSfNEIMe2XssybKAmMqelxTz3X+PekglA+wdO2XjDWzTPKsAfr7sX+K53pAQjkV2/m2GYVbgNd6jIyPtuw12IWKIplO53BBkSPqAljIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HqNlXVcO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A0E7C4AF0B
	for <linux-pm@vger.kernel.org>; Sat, 21 Feb 2026 05:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771650363;
	bh=CgpXa30rV7bbhp6oVHWrrq4qO3E2hsaZPSYf0NAhynI=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
	b=HqNlXVcO0tqqoAL3a1CXClMlyTMVFeo/HbeB/T+Y0kuIoGDruyIvcY+YzPrlHiSzC
	 88Kyrx93Is+AWwnjdB5t2/1h9gU5xVNzF+fKtMEIMOody338zA59b4KrCBZBryBXOq
	 XtZlQmhHxQW1iGU/y4V+29QX154H7+DtS5HszA56DUM+ij9RGXf7Fl+yIfCY7wQqp3
	 51O5jq48LuQqf468Vjhltvx+ucx+19PdLiGu1qpxfGzL1v9/xH54oVUy6qpqcy1wAK
	 F8Y9s6JXvauLw9OmI3+suzaH3ykoPY0OY3fUYPTMonBgk1QYDukJ9odZvPdo16CO1e
	 nV93jZUn843zA==
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-38708180241so22008081fa.1
        for <linux-pm@vger.kernel.org>; Fri, 20 Feb 2026 21:06:03 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUW2eUbTvy5/7m35RvpWbeLJ1ZHLzxuB3h1OFwGYF731mWfcgqwnIiDWeuNHLYilkL1E3C5xYG6Mg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwPlfcRpHSKilrSJAsIg7mQDRZN2Eiwp3lIgR5bOfJ3RrE1z4cO
	LU5H1Fe03i4WGDh4G5cjR9BokK3MPA+WBdyPuEuQ5henbe+0BZoYK+HahqoVu5ndIXEs6URkoLc
	Av4uX3Tgwnal674icXYYR2LdxFiXlYUA=
X-Received: by 2002:a05:651c:987:b0:387:197d:2067 with SMTP id
 38308e7fff4ca-389a5de07b2mr6463451fa.28.1771650361485; Fri, 20 Feb 2026
 21:06:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260220174938.672883-5-krzysztof.kozlowski@oss.qualcomm.com> <20260220174938.672883-6-krzysztof.kozlowski@oss.qualcomm.com>
In-Reply-To: <20260220174938.672883-6-krzysztof.kozlowski@oss.qualcomm.com>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Sat, 21 Feb 2026 13:05:49 +0800
X-Gmail-Original-Message-ID: <CAGb2v66_QYMKVD=uZa5rAzd2GoRXovXpMpaPXRQmnwFGJMtowA@mail.gmail.com>
X-Gm-Features: AaiRm52nmrMc1fR_zFt5u_cs3Vt49aySbZq1WGzkhLMfbdFUJ-LvR7JLDtQy2uY
Message-ID: <CAGb2v66_QYMKVD=uZa5rAzd2GoRXovXpMpaPXRQmnwFGJMtowA@mail.gmail.com>
Subject: Re: [PATCH 2/4] power: supply: axp288_charger: Simplify returns of dev_err_probe()
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: Sebastian Reichel <sre@kernel.org>, Hans de Goede <hansg@kernel.org>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42962-lists,linux-pm=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,qualcomm.com:email];
	RCPT_COUNT_FIVE(0.00)[5];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wens@kernel.org,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	HAS_REPLYTO(0.00)[wens@kernel.org]
X-Rspamd-Queue-Id: 9DD9316C24A
X-Rspamd-Action: no action

On Sat, Feb 21, 2026 at 1:49=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@oss.qualcomm.com> wrote:
>
> One of benefits of dev_err_probe() is that it returns the error value
> greatly simplifying the error paths (e.g. three lines -> one line).
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Reviewed-by: Chen-Yu Tsai <wens@kernel.org>

