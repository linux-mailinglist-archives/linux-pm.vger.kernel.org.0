Return-Path: <linux-pm+bounces-43341-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4BNkOdDLoWnbwQQAu9opvQ
	(envelope-from <linux-pm+bounces-43341-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 27 Feb 2026 17:52:32 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 399B31BB090
	for <lists+linux-pm@lfdr.de>; Fri, 27 Feb 2026 17:52:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 44C853180817
	for <lists+linux-pm@lfdr.de>; Fri, 27 Feb 2026 16:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B86E34E749;
	Fri, 27 Feb 2026 16:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SOBloC6T"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85A1347BA3
	for <linux-pm@vger.kernel.org>; Fri, 27 Feb 2026 16:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772210855; cv=pass; b=iX1EPPxA2Nyo8Uam21JV/zNz+bE49cVe0Yq/X+Ru5uTIGokxUqkq9jiYU1qP8l7jqcNguatDgywePkUudWexOS4eak1LxPdmg9ZwDCyGSgB4hl+fzJJdWb7BATsb4+l5OqRG1s9xaHklQJFvPSvDPQ2N0Oxatbxhu8flNK3IwGo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772210855; c=relaxed/simple;
	bh=ZWqPJD4dtCJD2sUc3tRg4PY4l8nI5GuVuIvnfZjfnEo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bSvOFhuxwW2H1cnAh5whO1APyk1f5LXTFlPX3oPiSW9h/N2rPxyGD6bSD9Ba5xj2Qh+kZSv2+yjtaQ7kuddvmciEqgKAfQ5/2kXFQ8I1mp8K4oWkmZdBn+djakNBpBDZe/MC6WGzwH1/vfIILUHsqAAR9ey4Mu7yUFHSHeX3AEQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SOBloC6T; arc=pass smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-65c5a778923so3664248a12.2
        for <linux-pm@vger.kernel.org>; Fri, 27 Feb 2026 08:47:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772210852; cv=none;
        d=google.com; s=arc-20240605;
        b=aAnjF2IIJ0sIRR6vg6Fg6AgcTdtFxZwEvev4FETSPzUBxoeOdvnFh5gmXOlmV8iBPB
         XgWeckoknj7eg6uUTZy9ecTvlXtBckPRXYvunjHZybvBemFf5YjYXWOLq13E7fLuP3Dq
         SWjK9Cq68nB4eaEnYOobqgsMNJ/N8llmQshZnRQe0Pao2ZQFlLcXgbH1U795AKcUV/ch
         uuk6xpJ4lHnstrrbOLydmppImHKnFMoP4hv/sgbqQn68vdWN5hWzLLOh05VSb/xr8AiS
         E/zy7iWtewVlKMcRPMOjbWnPNpzM9eBKqZq5VWMrKp4u53JpvPm35kgc80t+v79sNAr9
         atLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZWqPJD4dtCJD2sUc3tRg4PY4l8nI5GuVuIvnfZjfnEo=;
        fh=VcZlPfFreJjrjhCV6e/GncrkOnqFFuQESkq0dtGyuHY=;
        b=RaVR6vTtI1gVRwaTQATey7MgKfMr2ewarRweVKYmm6BImBsiYMKfNiX81X9pcWECgS
         UyGn3h7VRw3+KO8HjR5A1YVXGXwgNDZkdomILQH7wcpZB55L0hqPNTCYzbTBGYYy210q
         r6wWEy8OA9Cd7EhLazEuMlVBlvoMCkFpSh8OtHLnH4oWci8YX7gNZXUqE3GNNFZGOaDR
         OtBLYOsFQfNaG5o0J6yqGDf8Spcqz8cUcFSyGH9mjYgWY+/s2lpbG94RenKBdpRfpGYC
         FHXVHZsZNrbBet+2/w+aJx0ISy24dEYE6Ho0Pr29dW0QRfqq6d03Q7RZfA7XgwCM8jOa
         OBig==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1772210852; x=1772815652; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZWqPJD4dtCJD2sUc3tRg4PY4l8nI5GuVuIvnfZjfnEo=;
        b=SOBloC6ThKf32IB3RfiUQt7Q0R2p4oPO5JC7JtOdVcLkMWJaZQwhdsK4WOfORlrrCe
         Uxu/ueXyI4eMpoJ1nt4Sj+Lia9IG3Bmt0oDZY13Yfi/rl6gWeWU30o6p3ZmtTa0ZPwUM
         lU4DsZjrIFqB2EXmZTMXUPLaWRQdkpuR+mEouF31+pIpFPoM36FPeOkweGZI2F577177
         NvLBdm7NyuWxiQepoCF8LCPyb8rXQAEwbXzMRc+uxZdY3tMoum68kBkDRRLKM3or+TaY
         H54bYUIK2huuti5TMOG9xOs9a9hukZvVY+IX2PXnI3fEfhbE58hapo3x7Jn2+n+dQMN2
         vu+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772210852; x=1772815652;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZWqPJD4dtCJD2sUc3tRg4PY4l8nI5GuVuIvnfZjfnEo=;
        b=vYB5amse7OBEEAgvK0aO2cvqh+xWW1l05+ynCYNKqF0fs07bdotFi3/SKU/XCnBLni
         ndJz/RlfzBSoAjjusIeT13cnjh1Fe6CVVpkzowVszpgk2FtYU0att8LqtxuEaV+7uvGd
         dEHYVcLaexBE/4bFwncVUrWoZ9mCiIz0rXSnYgyo1X7W4jMGEmIpxA/Rm8KJrunfrf7Y
         HKiHi26Ti2vP26sin7rDwBo5NXclbFZ3zN9qs2v+QvJpJyGc5A0LJagL8gszLviBHZOJ
         mXj+ygt0saaFleLG91XKM/p6VjmrbaFMZoQK3hVk1upzjsVS4ZB9iZ8V8gKG7+btWn12
         ljnQ==
X-Forwarded-Encrypted: i=1; AJvYcCXe3UF3GzLEVARqxl9zGP031WhnoBhk0VLW8/0f6CZcLeYOTvHzC/77jTnDFqav+C1zRX/7he8oWw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1jVnJZu0/pldkrV1J3BWDQsg+mbKdsEihYjA+iX0/UDkkuTMX
	WsOb+I5qo2RJRTlz4xtT4mJeBxSv7aPo2c+3WWS3ea4FrTnMkre1u2mClH+nqMehJAWBbRvxwgA
	sMuCDA+RZlzISKeVYOUHWWsqHqJ950x5EK9xnPdfeFgrKr5gX9cqdNkYw/A==
X-Gm-Gg: ATEYQzyTCTQtE8UI47iNQP3gXLjw6RMrf1m81fF0JHCi/BU250Hku8g7INzmgf8XmGB
	Npw+6COEYXmfeckg5qlyWYQHFAapI+Ix4VTLodBoy65rp9GRYzpjJ2rWYM+QL4Py0lAjJmw8kpU
	CEtBhiq7dJHdiJTRNKOgMN4zg5sZYkRmIQ/MRDDoWgpCV48PxhacNW8rhIXC7PNhUxbYB9KJkbC
	/N9LHGm4bddDs6A84JpQNOhNGg8Ki5N4frzXw17DLsfxpsINtwvDFh8ZwI9jlgGN7HQh+Uw5tKB
	cWbHJRwvpLDtuDwJmXTd4Q==
X-Received: by 2002:a05:6402:1456:b0:658:b837:7953 with SMTP id
 4fb4d7f45d1cf-65fdd6ef9f8mr2486945a12.12.1772210852025; Fri, 27 Feb 2026
 08:47:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260227-max77759-fg-v2-0-e50be5f191f0@linaro.org> <20260227-max77759-fg-v2-7-e50be5f191f0@linaro.org>
In-Reply-To: <20260227-max77759-fg-v2-7-e50be5f191f0@linaro.org>
From: Peter Griffin <peter.griffin@linaro.org>
Date: Fri, 27 Feb 2026 16:47:19 +0000
X-Gm-Features: AaiRm537N-V30eF26zS-TiG5KL9R7J4CN3hLB0hASqzawD4ChaDSinIj6d4HiQM
Message-ID: <CADrjBPr2zOOCQtnMkwb1srq=SnpwcXcck0YTbmH3+3nbF4AXLQ@mail.gmail.com>
Subject: Re: [PATCH v2 07/11] power: supply: max17042: time to empty is
 meaningless when charging
To: =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Cc: Hans de Goede <hansg@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, 
	Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>, Purism Kernel Team <kernel@puri.sm>, 
	Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Tudor Ambarus <tudor.ambarus@linaro.org>, Juan Yescas <jyescas@google.com>, 
	Amit Sunil Dhamne <amitsd@google.com>, kernel-team@android.com, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43341-lists,linux-pm=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peter.griffin@linaro.org,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[linaro.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,linaro.org:dkim,mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 399B31BB090
X-Rspamd-Action: no action

On Fri, 27 Feb 2026 at 07:15, Andr=C3=A9 Draszik <andre.draszik@linaro.org>=
 wrote:
>
> When charging, the fuel gauge reports U16_MAX as time to empty.
> Ignoring this special case (as this driver currently does), causes the
> remaining time to be reported as ~102hours, which is incorrect.
>
> Update the code to not return anything in this case.
>
> Signed-off-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>
> ---

Reviewed-by: Peter Griffin <peter.griffin@linaro.org>

