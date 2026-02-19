Return-Path: <linux-pm+bounces-42874-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qHEyEyhIl2m2wQIAu9opvQ
	(envelope-from <linux-pm+bounces-42874-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 19 Feb 2026 18:28:08 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 86E121612DC
	for <lists+linux-pm@lfdr.de>; Thu, 19 Feb 2026 18:28:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D123A3009F8F
	for <lists+linux-pm@lfdr.de>; Thu, 19 Feb 2026 17:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBFC034D922;
	Thu, 19 Feb 2026 17:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sWP2wz4R"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D0834CFA7
	for <linux-pm@vger.kernel.org>; Thu, 19 Feb 2026 17:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771521959; cv=none; b=apYGzdWIFTSJHwoKvlmtEf7zuI5/87ZIikpFHBrFVYjHAppe3ohGTQdMAAFQjTWF/e+M1MCh3LP01fLQ7VsV9G+/Kh4sNpPbROKUDi1oTnEi8s5ADNmn9ZYTqsRbZ28QPO/emYcLReKz6Dq89JSipao/jBf8UX9pMrscUsPQO2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771521959; c=relaxed/simple;
	bh=1P8PwGfb5h7hj2VZPAAbEP4H1XWS9+Ms9BQHAnV5Lhw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CAIxnmuIlTfGrw8QZfrTbTyoXqi+InHX+s093avD7RenOf5QFAJKI1lnREDSgKTkcc3xkDTqUMSHHdjpEInhKqRLtLv+QnYzu5BJxh6SCSWHvcpf4QQQvUABu04ZYM4VbhTM8ufhKSeznz/jImVyXMtqzQL9N3Y3xdGF+bR98NI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sWP2wz4R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AA7EC19421
	for <linux-pm@vger.kernel.org>; Thu, 19 Feb 2026 17:25:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771521959;
	bh=1P8PwGfb5h7hj2VZPAAbEP4H1XWS9+Ms9BQHAnV5Lhw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=sWP2wz4RqK/1XmfqCZNASJ3SAxfwGa9b/0nfiSxeFoYBA/gs6x8kSm0IdxM1OZ5cP
	 Ed0q6Srrja4xb5UBkDI4Q2/0aOb4z5eGZyCSdniUVSo0+hmongH72oqX5kbwn5DB1k
	 /HBQVYeg34x/iisEr2KSlQuxrNYB1FUYOssZtcMF/pj47gdklq08i1GNwggiErMUrW
	 fitkHPfJLNTIVH0LkFZvSfRcvy9Lbr9yJdJAEhfa/ghWcAU6R1cV6OK1HTZJJ6PgxM
	 r/eG3Nk4q3wTyN9lxWMn8nuphTDHGkg8AQ4LIinrc/Z50JyKvTyGjbL/dOgP+VmEN5
	 jbS3PsbY1b9vQ==
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-64ad79dfb7cso1192053d50.2
        for <linux-pm@vger.kernel.org>; Thu, 19 Feb 2026 09:25:59 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWIex8oAS8H5mXUKcAwPP5QhrqHl8664+ZbD+ZM3ASeocBUw4GDgLpzj/osJLkhfLAoDOZzM/2N4A==@vger.kernel.org
X-Gm-Message-State: AOJu0YxEWhFumteNUhsLcARHNEb5FTMQ/TWqoXtoarDDkay+96mo1N1f
	bPPcU5S/3rolC1xTEGsYQy6CFnrO19d/V9IjSG5PT+os4SYtpkGH64SaD2EM952F82ohnyA3NSd
	7WVR6gXSceKvlYwZagu9ykKZeqrmhT9o=
X-Received: by 2002:a05:690e:400c:b0:63f:b4ee:7920 with SMTP id
 956f58d0204a3-64c555625bamr4336403d50.11.1771521958771; Thu, 19 Feb 2026
 09:25:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aZYoL2MnTYU5FuQh@google.com>
In-Reply-To: <aZYoL2MnTYU5FuQh@google.com>
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 19 Feb 2026 18:25:47 +0100
X-Gmail-Original-Message-ID: <CAD++jL=W1x-G_MXgPJjZYM9urPw2Ened3V5iDjE_37Pf_Vm+Eg@mail.gmail.com>
X-Gm-Features: AaiRm53uUla9mvbg13XMqYY2zr1YkWise_42zqTNmAeOUmENb_AjXw5eGIN5YkA
Message-ID: <CAD++jL=W1x-G_MXgPJjZYM9urPw2Ened3V5iDjE_37Pf_Vm+Eg@mail.gmail.com>
Subject: Re: [PATCH] power: supply: sbs-manager: normalize return value of gpio_get
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Sebastian Reichel <sre@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, Xichao Zhao <zhao.xichao@vivo.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-42874-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linusw@kernel.org,linux-pm@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[linux-pm];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 86E121612DC
X-Rspamd-Action: no action

On Wed, Feb 18, 2026 at 9:59=E2=80=AFPM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:

> The GPIO get callback is expected to return 0 or 1 (or a negative error
> code). Ensure that the value returned by sbsm_gpio_get_value() is
> normalized to the [0, 1] range.
>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij

