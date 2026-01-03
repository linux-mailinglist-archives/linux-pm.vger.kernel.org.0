Return-Path: <linux-pm+bounces-40163-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 17C17CF0674
	for <lists+linux-pm@lfdr.de>; Sat, 03 Jan 2026 22:34:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 13D893008F7B
	for <lists+linux-pm@lfdr.de>; Sat,  3 Jan 2026 21:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEC142C11C9;
	Sat,  3 Jan 2026 21:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i8rZeMKy"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A161F2C0F79
	for <linux-pm@vger.kernel.org>; Sat,  3 Jan 2026 21:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767476056; cv=none; b=uGHgxSrrKZFBg+BJXFgxKeTbvBdovp8/e9j39/pu4U61thP5cQ5AZvNHp0onapc9scQ+XepaiwP6914N5a+wF936CeJxrpot4KxPd+8M/MIOOwbaUr7HqoTi0vNhFaAynS32K3KQbEsVWSe6iMGXvBY6G2aOzvdQ65Voccfh0Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767476056; c=relaxed/simple;
	bh=JPYk164Z8xTYCkIPE7ec1GtqvSbqO5PfE/MD0jRZkuQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R/2m60gL7ZTKpy5+pMNfyZeGjgC+fsfuMSvD7XQ+G4fY4Q6JwyIANG88oa7+6KF9/NCJIMmNpftbxNxZ/yfOvoVqKZF1mlrre13T3mi3OXhYxDe3UadFIBAaqKMA7L1kxik6xZAhhls0dFRKx2q0peZOklISZPxNzr2rzcTnSIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i8rZeMKy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4983CC2BCAF
	for <linux-pm@vger.kernel.org>; Sat,  3 Jan 2026 21:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767476056;
	bh=JPYk164Z8xTYCkIPE7ec1GtqvSbqO5PfE/MD0jRZkuQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=i8rZeMKyzhTW375pf+XWtWkAsG6bpLAwpOsCAMaJg/nOex0uUdY02UXgIlGbBSGGL
	 I/9HmON1oi+q3tXb61n8M/iVk147R7zXyUNQj/oe9Q2Kkcm5fHtCFpB1IyXzD/Foue
	 +XfDXDv4t5gt/PDiGWqJOvYIyYHKHisC8KhbSFvtpIdDYAVnwAP2RMapyMKmVMim2l
	 sEqHuav7hoKbzJbBfeg/YOILGTEYRlM7nThbhtAfl7qSwPf+rcFwSsLGAsvR5dhIG4
	 9x3eAthdKC2XQ782s2+SDeeqBVT4siFQiKo17QF3UKZ3nycDCXnJkRtWQsHvOBEwzl
	 rv6nJpJhNpyPQ==
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-3ff4acb6eebso609945fac.0
        for <linux-pm@vger.kernel.org>; Sat, 03 Jan 2026 13:34:16 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUTr0OljB0ponyT8MpiJJxM7/kpgqJkyxYPFRd4YLP1ICmmGZSamcO3EiZJRKWog+MlYuhGBt3VUA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzBjT4mbUa8K8NPzhZ1hRfm0RyO+vC7REWBIguxWy/UJc1W3BRJ
	XXsKeXlmFw0mWcVbmG8ACuHx4waIiCX7Tbb1sYr3a/6ROO/eQjYIp4d6qseYzfJYOFMpRYdGGRE
	jArkQNriEorU6IpVwWuwH7bmGT/xT4xI=
X-Google-Smtp-Source: AGHT+IGhVvbS4q+8d/tDS+BHcZa7HipC00zuIMcfaaNoUIqBNGinKiP0phhj1o8Y+qvtUkHUeLXM2QKoUUijcmew3Vo=
X-Received: by 2002:a4a:e70f:0:b0:659:9a49:9074 with SMTP id
 006d021491bc7-65d0eaddc1bmr16318808eaf.63.1767476055210; Sat, 03 Jan 2026
 13:34:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6245770.lOV4Wx5bFT@rafael.j.wysocki> <3608967.QJadu78ljV@rafael.j.wysocki>
 <20260102155337.2bab8b90@kernel.org>
In-Reply-To: <20260102155337.2bab8b90@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Sat, 3 Jan 2026 22:34:04 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jbM7AcrVHG6NQMSEgpWxXsFRZ4bPE2uOZ3zb0_H1sO+A@mail.gmail.com>
X-Gm-Features: AQt7F2rr0NWNOuHAP1BHmAvG8kmRrldNByMYlP6leifCjmy3lcs8hQYMdL7gI_k
Message-ID: <CAJZ5v0jbM7AcrVHG6NQMSEgpWxXsFRZ4bPE2uOZ3zb0_H1sO+A@mail.gmail.com>
Subject: Re: [PATCH v1 10/23] net: ethernet: ti: am65-cpsw: Discard
 pm_runtime_put() return value
To: Jakub Kicinski <kuba@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Brian Norris <briannorris@chromium.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Siddharth Vadapalli <s-vadapalli@ti.com>, 
	Roger Quadros <rogerq@kernel.org>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 3, 2026 at 12:53=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Mon, 22 Dec 2025 21:11:42 +0100 Rafael J. Wysocki wrote:
> > This patch is part of a series, but it doesn't depend on anything else
> > in that series.  The last patch in the series depends on it.
>
> Would you mind reposting patches 10, 11, 12 of the series as a single
> set? If we get CCed only on a subset of the series PW assumes the rest
> got eaten by email goblins and our CI doesn't process any of them.

Done:

https://lore.kernel.org/linux-pm/5973090.DvuYhMxLoT@rafael.j.wysocki/

and I've fixed the last patch while doing it.

Thanks!

