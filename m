Return-Path: <linux-pm+bounces-24748-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A3BBA79F9A
	for <lists+linux-pm@lfdr.de>; Thu,  3 Apr 2025 11:10:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7988E188D083
	for <lists+linux-pm@lfdr.de>; Thu,  3 Apr 2025 09:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDCD324A058;
	Thu,  3 Apr 2025 09:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fp65+uOF"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB106248864
	for <linux-pm@vger.kernel.org>; Thu,  3 Apr 2025 09:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743671021; cv=none; b=eoY110f+cTNSrOOKxsXFi80Yxi8K2hOLD5nO2D5X0MzMEf9Ouq7w7zOcGjY9UrB5HEMfHb0hHQ77runcsTPIL2wYKjw+IqNIkX9M5A81Vbs0zlDQoicOjct7P+Ooxej7qS1zD4CxRP+XFOMHs6jRgNwNa8ZhFhnuJt1GaU4RL5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743671021; c=relaxed/simple;
	bh=V7ZGOwuXQ0pcRqAldH/+ETedOGLTXRvg2tS03VFoYl8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oE5Hh90hOIswW7MbuS4MTfb0ITG9tX5rv8mQbx3d6jgQ+WtGUwRn9W98oGQMvP5aM8E5ekzEBWKwRjR9vJ6OfjjVyDKmHHX1+14frWxNVPrVhpb7MPGx8ftdGyxkL8XDdbL5avdqDWGVzGa7w1vEXGah0TWn4TQ71uhQrUJ9F6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fp65+uOF; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43cf628cb14so12383115e9.1
        for <linux-pm@vger.kernel.org>; Thu, 03 Apr 2025 02:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1743671018; x=1744275818; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=V7ZGOwuXQ0pcRqAldH/+ETedOGLTXRvg2tS03VFoYl8=;
        b=fp65+uOFT3jV1rTXprfMnQ8fkjS9JHtc6KXkQfx979FtY1MfCH1l62LYXThJrhlyJd
         M9JgR2ctYQEeh7JdNh5vvEPcIEgxqIwHcASLOy2A64Y+epsGB+Ciw/f6R1rz2xwpdTzn
         VtU/8soP9xq85TOa66ro5al1rh3gwyPQ7v/hVVhVM4eUKuyELscrtLHIRBGWuPJqqdQq
         qJXHcZVWQMElgeNYDSBlFsjgxYGtYQf5yanmN/KBQjHuF17sRgZzqNaZ31d0rPWVMXwY
         9zlKLocfN01DkiKAeiAiuyzaXQ5GQtYxqwotWdxhpTbiwr70lt8Un1zgpMjjipWzPmmh
         9AQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743671018; x=1744275818;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V7ZGOwuXQ0pcRqAldH/+ETedOGLTXRvg2tS03VFoYl8=;
        b=tXBfKCDahWdgWcsHJAUpZzEYvq2wclnRPOq3CB/IQMc/m/bPnBuvcfydZz1KCftSqc
         9hmx78qb5PX2GNnVT58qnJOI9X5VJ8BdHmHQ1wMWdwOdaEu6wfbcwb58DFZOG30hU8RG
         zi4NQro/IikCawIEZe81VjVGgebvfuTvWNuxPLDaOCySisEaoNDlDlSf5urTfuijZIda
         d4oAStK2Yq/h1VfI0ULLbpOAg1uu75qY87ibrbGwlU8gazxZe5lRWUqxtnXK/LsZZkFh
         FkQOOqeI1oBdxbW6Kc/wFdnb9B50Jt9Cxyt4CHiJzyzAYhxuxjeR+4HMXSjDDdnc1vUv
         QuvQ==
X-Forwarded-Encrypted: i=1; AJvYcCV2l3PlV9tRi7qZaG6r3Yl2gVqehVICYgYFSTgLfXqEmkGLd311QhPNyDulbNS4CZmlY8Pu5unUrw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzGarUQTO4KMKM7b1y5egcrVryilZJ+GCUJbLcX7aHHpYFL+mtQ
	pmXBU2peGYSbQBTdmvayAa7lcqCb400E2rTazQh/tqJCIx44E3bywJCoWl9KBc8=
X-Gm-Gg: ASbGncvpKZ2n4glcrM8rkxX/fiLQgjk8jN808YQZ7/nz6VmOgbnpDFE6u1wKO5lMY2Q
	9hlOUPSvQABr1FU9ns90/jBlYeaccm5Ue/qULQcKAsJpCzZTzyVHrlUTtkmWdB1+6KARoKYbGaf
	s/aQC9zinVDHxeh/YygOmGFA/8CtoitzERKyVbUIlwF9lCjX3SBmijs1mexZcR7IPXpwCT0lVv0
	j6BkWy8Ii6e1yZ4Pz48Lx9RCC3ImzH7aZ9Mx329hC8PCcZ9bxXf8vY5kJx02KDwV/jceP8f/Fyy
	WWdYSmtb6ppJbIPawm9i7gkKpT3vP6NndMmO20aodm67rzkEWw==
X-Google-Smtp-Source: AGHT+IF1Z0N/QR0bqygtyF1b7lJRQ+31HK0rLhXx57VHXUlp5Pl0d/+tHSmMb5mQV4oCrGHlzNUhKA==
X-Received: by 2002:a05:600c:83c3:b0:43c:ed33:a500 with SMTP id 5b1f17b1804b1-43ec630446dmr10583585e9.10.1743671018265;
        Thu, 03 Apr 2025 02:03:38 -0700 (PDT)
Received: from [10.1.1.109] ([80.111.64.44])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ec16602bbsm15576925e9.9.2025.04.03.02.03.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Apr 2025 02:03:37 -0700 (PDT)
Message-ID: <d9a0547a9b042e5824009e73f43b808e149d5d9f.camel@linaro.org>
Subject: Re: [PATCH] power: reset: reboot-mode: better compatibility with DT
 (replace ' ,/')
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: Sebastian Reichel <sre@kernel.org>
Cc: Peter Griffin <peter.griffin@linaro.org>, Tudor Ambarus	
 <tudor.ambarus@linaro.org>, Will McVicker <willmcvicker@google.com>, 
	kernel-team@android.com, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Thu, 03 Apr 2025 10:03:36 +0100
In-Reply-To: <20250307-reboot-mode-chars-v1-1-d83ff95da524@linaro.org>
References: <20250307-reboot-mode-chars-v1-1-d83ff95da524@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2-1 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

On Fri, 2025-03-07 at 07:50 +0000, Andr=C3=A9 Draszik wrote:
> This driver's purpose is to parse boot modes described in DT, via key
> (node name) / value pairs, and to match them to a reboot mode requested
> by the kernel. Unfortunately, DT node names can not contain certain
> characters, like space ' ' or comma ',' or slash '/', while the
> requested reboot mode may.
>=20
> This is a problem because it makes it impossible to match reboot modes
> containing any of those characters.
>=20
> For example, this makes it impossible to communicate DM verity errors
> to the boot loader - DM verity errors trigger a reboot with mode
> "dm-verity device corrupted" in drivers/md/dm-verity-target.c and
> devices typically have to take action in that case [1]. Changing this
> string itself is not feasible, see e.g. discussion in [2], but would
> also just cover this one case.
>=20
> Another example is Android, which may use comma in the reboot mode
> string, e.g. as "shutdown,thermal" in [3].
>=20
> The kernel also shouldn't prescribe what characters are allowed inside
> the boot mode string for a user to set. It hasn't done this so far, and
> introducing such a restriction would be an interface break and
> arbitrarily enforce a random new policy.
>=20
> Therefore, update this driver to do another round of string matching,
> after replacing the common characters mentioned above with dash '-', if
> a match hasn't been found without doing said replacement.
> This now allows us to have DT entries of e.g.:
>=20
> =C2=A0=C2=A0=C2=A0 mode-dm-verity-device-corrupted =3D <...>
>=20
> and so on.

Another friendly ping. Any thoughts on this?

Cheers,
Andre'


