Return-Path: <linux-pm+bounces-28223-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BE28AD12D0
	for <lists+linux-pm@lfdr.de>; Sun,  8 Jun 2025 16:59:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EFE33AA9C9
	for <lists+linux-pm@lfdr.de>; Sun,  8 Jun 2025 14:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C596824DFF3;
	Sun,  8 Jun 2025 14:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PMQPpSJM"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B16C4C9D;
	Sun,  8 Jun 2025 14:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749394755; cv=none; b=Ngl8zHrHqfITHoNEqc5k4GM2/LpGaj8IZ0npBMVajyJwFbZi9pCqJwCkDqiopT9Kwe3asobIL10cjmz6rHmFXqpKIxHZ/lxWsq1SG2EN7KJVq9qxK8dlvhEKLhtLuHeTwyfKq/lNb+bM9sVZFygbNqf7d/x82tJ9xmT0itEujC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749394755; c=relaxed/simple;
	bh=gNF/RaJVaYvORkPF6w1ZLwDR3LA+a8fXJKHWHaulAS8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qdYwssru3aW4yRmxnHQ+/50OP9mfIhmVAnMjlXSDsKI5hZbQeWf7U04V6Mvo9Pf4P6Kswh4V9afT4FwyYK15Ed9us+rp/SKsfRlJhTzqNimrKCLb1Dg+dCyVq94Elqnv7hRSLD26NWPJEZj4XvEkexYLCH4zTABPcdqhDZtacGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PMQPpSJM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E9E2C4CEF0;
	Sun,  8 Jun 2025 14:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749394755;
	bh=gNF/RaJVaYvORkPF6w1ZLwDR3LA+a8fXJKHWHaulAS8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=PMQPpSJMSN67czQ6HDNgjAK+Ut0QXxCwY1M23gSkoLZohCga4jmL9eNLfg86K6DJL
	 ZAoe1R+rPAzPHGdsjiMF6+jFJf3iWNJW0qfT9sbiX9voW1LNztw5f1WD3/W3gQSGgQ
	 xhhYV7GmmmZwbcbmnjRbKakkH4US/sMO1cJs60AsyJ5Ot3+yZ0qxKU5TOuBM4U437z
	 986CsteO8PaGt6v+bQ69NOHqXt0pvRy9feVDFLKCGsAel2yE6Sdpd0crQ3PxcyAsaF
	 9o/FbJHa2t5oBGR22g7xIimaYhuk+9UEf2yTQA1U8/JBybpIy8CACGQp8ZRQO4pSGl
	 WirQiwBZj4bkQ==
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-2e8f84653c3so853578fac.0;
        Sun, 08 Jun 2025 07:59:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXbDmFfRRUvWC9p9a36A3lnIGRXWddg7vxS27ePYwTTvBK/DUWFa0T09ViMc+H25KoY+6o7+R3bZPR9VEU=@vger.kernel.org
X-Gm-Message-State: AOJu0YylwwlNwQC4DQ1I9lpXmv7dGWg1bCQAhEsJKHH1k1dTDMusaMtW
	dGg+POhpjaSSEEA4u3QHRSpIU5K2IDPPCW8C4mAJmMzwuA3NVzr3DPiqLfCIf1c9xMVO3mPWGyA
	RqMG5+/g3p51/krKCwLmUr2RqjtQKWL4=
X-Google-Smtp-Source: AGHT+IGpPn1bmUDo+AGgxhfZj/CBbaw+BZtx1b1k9i/Faq1zzmB1KRCxBPtGzGeod9MrhZMQblAPXc6VqyCtYqRo5rA=
X-Received: by 2002:a05:6870:f627:b0:2b8:2f9c:d513 with SMTP id
 586e51a60fabf-2ea00c3a117mr5429453fac.19.1749394754478; Sun, 08 Jun 2025
 07:59:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250323143111.79886-1-kendra.j.moore3443@gmail.com>
In-Reply-To: <20250323143111.79886-1-kendra.j.moore3443@gmail.com>
From: Len Brown <lenb@kernel.org>
Date: Sun, 8 Jun 2025 10:59:03 -0400
X-Gmail-Original-Message-ID: <CAJvTdKnE2nBOQpWRiQ98nk1hd4w44-sxsCJNsBTRJOwKHPU_Ww@mail.gmail.com>
X-Gm-Features: AX0GCFtthARVuyELlXEKJj6tqiJSEZSMLfpfdFlLOEzI8DOT3Uf_l4NCv_DajZc
Message-ID: <CAJvTdKnE2nBOQpWRiQ98nk1hd4w44-sxsCJNsBTRJOwKHPU_Ww@mail.gmail.com>
Subject: Re: [PATCH] Replace strncpy with strscpy to ensure null-termination
To: kendrajmoore <kendra.j.moore3443@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 23, 2025 at 10:31=E2=80=AFAM kendrajmoore
<kendra.j.moore3443@gmail.com> wrote:

> --- a/tools/power/x86/turbostat/turbostat.c

> +               strscpy(pcounter->name, name, ARRAY_SIZE(pcounter->name))=
;

Nope --  strscpy() is kernel specific, not available to user space utilitie=
s.

Len Brown, Intel Open Source Technology Center

