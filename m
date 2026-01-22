Return-Path: <linux-pm+bounces-41285-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wMACMTnocWkONAAAu9opvQ
	(envelope-from <linux-pm+bounces-41285-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 22 Jan 2026 10:04:57 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 32062642F3
	for <lists+linux-pm@lfdr.de>; Thu, 22 Jan 2026 10:04:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 122317615FD
	for <lists+linux-pm@lfdr.de>; Thu, 22 Jan 2026 08:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DA7634F489;
	Thu, 22 Jan 2026 08:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mld9DEyN"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB21313550
	for <linux-pm@vger.kernel.org>; Thu, 22 Jan 2026 08:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769072254; cv=pass; b=qLUnrKS30na0HlndHZcbDC5W3SdaqLKyKamAw9NqcUtb666/JLPSNDS9U0952Op8+pJRv07C0KezlJy7Eef1oROquVZJLNvblp0AJUmf37vAnCJS2YpeZtogw0iZtd/Oz2SAqOZd6IWlXNBAkfcFr+kwTxFvscJVTi7J3LAfX38=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769072254; c=relaxed/simple;
	bh=3J6gYorDtO7mNp6Qmg57Ase80b6wKmggy4kn3B0XUVM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FvbMxF7IZLGBiXRVCIduzCMjzkw/6MHvFAYfL2eE6INM1JMe6WCgY/xAqMQvi2IOnHwbi1tEXdJ6rUMLFcWB1zWBAjOEQcb/Ijk05m+0WCSkPwyosSXU0IZJEVACNi5KS+U+Vdd1hZt/hblzddR27ndxU4L40remO1Ngq8J4JmA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mld9DEyN; arc=pass smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-1233b172f02so1097287c88.0
        for <linux-pm@vger.kernel.org>; Thu, 22 Jan 2026 00:57:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769072251; cv=none;
        d=google.com; s=arc-20240605;
        b=Vo7gnn1FVdEV3HWaAUegwxoz1Yx3mKwF79wnUJ/qDG8lPQvwYLMpFgxBClzegXE6cO
         fX3EhtTwdvMfGZui95J1JTMX9VOD23geWPhlZK2dSjPO6rJXTUm6UkfzevbRrL2p+uYN
         2bpAoN5wS0lbX3zWIEMMNBsTvAg3b6VHeROLEZvCvyQEsL/XPPfOAbwGNGQ+MwplMcGw
         TbCgXbdUMCi7c5Yjp1XWWkT/sUmfoOrAVqWyGpABGgMU1yug9LY3RaIDRPMc147StoDi
         jhgWPqWvMyZeiJwlMVpak4bGPfMzI+CAVv0jwC8Coo31gLpkGs7k0Lfg+fxLFMPl4nJ2
         j/jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3J6gYorDtO7mNp6Qmg57Ase80b6wKmggy4kn3B0XUVM=;
        fh=B8xsql7sauzEvYxg2LEE6s+N1772W2OIy7kuzC95y+A=;
        b=Z9IFNOPZeCxmtTrbDsNU7Yhbz9iDaH8fA+q0VLx7W4K9X83SvQkElTxO3JlntwxpYF
         bd1Yf/DzE3VsXJPl5WyZE7JbftHF1h2saoL1tiqnKGSexi/MnK9caIbUltOnXlfcb37r
         A89yBEPeYHj/H76oA/48Tkx0eotW4F3P4d8crJmN8Vh+DL4Z2oR2ZsizjGaiKakP4Q+c
         vAkiipd/731zMJVHodQCq8z4gz1LbNkctBxbYgCgo/s4oggbS6VhGAb/umvhCsMuLKb1
         qPO6awVz9N5SDZ79W85xiQ0I1d8TLqrREQclSs/xVLlySwhhk402/Z3mZYIj9M+Y2pUY
         y3Iw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769072251; x=1769677051; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3J6gYorDtO7mNp6Qmg57Ase80b6wKmggy4kn3B0XUVM=;
        b=mld9DEyNrR3wMJ9O7cIiMykatxx9De1bP9atRA/FqT5FyP2uZj6SJPxcZFj139K9wB
         dVZjPSZDRXC13jXda/PChEf0Tv9DVSaKiz+x8H5TE5WgxRBVxp/VVgOkL5acpTqZ7cwY
         dtX9fVxG8p65lfHDFh7LueqonYvg2P2BMTKauqv2CT5pES+kUjHhR6jsX+GyR7Dmvkgg
         u8OlO7No4074NtDivk9EYs5N+X8Dl1Opx3LreoF7MtXa+s4kg22UZoc/5ekczlE+c4wk
         e327J1ZjXk9zxLH+YmTN+03JYTj322eJelfoHeAkaxCY6TA+Qf5rTMQreOR5wWymbDX1
         YfnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769072251; x=1769677051;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3J6gYorDtO7mNp6Qmg57Ase80b6wKmggy4kn3B0XUVM=;
        b=i1gjkkTjwnGNrY2O7V7r77wS6HhHrLPBupTN4BtBn6ei6OAuzkl0IHQfsFlRyAdQAU
         J/WIptQlndsbxbrzzZfBG996WdcOoZwgciFByCqQMwLvaZrgCC3xw5SxzDUym5Lz+V/B
         Ul+F+XXAjz9wlFc+vcEWb6+tUK6Dp8s2Gqi+GL3iD1xExemEST8jLl73/CAqE+qLWbxG
         vWlFcJ4PuO7akoALVkM1IIBJo5YNV2Hx6u4DNVTyaVAJEO/LhXN92IHKkVdBCEbfoF8+
         ff5Zs9a3ol7NZrCBwoFo1gejeMq3EcaRIFVyaMpWMwz6RVcwNex4kiPl4PMkpvyYDAYp
         /9AQ==
X-Forwarded-Encrypted: i=1; AJvYcCW5QI8IG3uRypiD2mluPuVPtBEwlTyvWXYcNR8RbStQ9Z1p7Koh7gIOj684QcZ8ZV9ep1sBKMEgQw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyX1Ozer58RYvihAuWFutUcQHdvWGftGrfVoudpwiVxoeO5EQyW
	xiOzineC18ZsiSBgjK5Mv0MMQiMfKyqffeBg08K+1QeW7TuqEmObt56QKOqLWjNHgM8/1ZvqmLf
	4hv8RSlddDDE7Yu57NI93wPIC6darUgn1xR5Ynxzc8civ
X-Gm-Gg: AZuq6aKTcA4x2RD0ceF8o6lSCdyL7iyAD6Cd8XQ49FImc9ZchDaHZgEME6g1ljXvAvB
	Jh1BMRPkSfeSmrFpmhssCCRxLPl6cTBbklhZw3eYXAV10n+ZOqFJz90eug3QHMRISJcipY6/eh/
	ydXc8oqWLeMe63uvUOF8eJ2XTTQzNRmVmX0YbvcbyOmr/21pOQsF8+TDYz9X8hn154pNrSN/7yu
	ytwLLrxoP3SU5mb9GZO5lTkbT9iZplfuCZtPGgSOPM38rvKFy/ManWDkMsglYMrYIxHuYAvkTsf
	UI1KkNBFDCo93lOx5GqUR3d4OKSHicUwTD3tVYKmir+rl2SX2k6606oe2PE5g45k4YTCLh49M89
	WTyATwQbWJw==
X-Received: by 2002:a05:7022:f86:b0:123:3364:2ca8 with SMTP id
 a92af1059eb24-1246aac4ac7mr5540316c88.39.1769072250797; Thu, 22 Jan 2026
 00:57:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260120-imx8mm_gpu_power_domain-v2-1-be10fd018108@nxp.com>
In-Reply-To: <20260120-imx8mm_gpu_power_domain-v2-1-be10fd018108@nxp.com>
From: Daniel Baluta <daniel.baluta@gmail.com>
Date: Thu, 22 Jan 2026 11:00:08 +0200
X-Gm-Features: AZwV_QizKXTxpcD509WTM7FJXkGnjUZe72Tjh_1y1VK3GaZGPTzVAx6Yhm6EfFE
Message-ID: <CAEnQRZDo3Y+m3+Pdq3QTaPi0M71NGAc40NxCw0c-GUuAQ5ZRhQ@mail.gmail.com>
Subject: Re: [PATCH v2] pmdomain: imx: gpcv2: Fix the imx8mm gpu hang due to
 wrong adb400 reset
To: Jacky Bai <ping.bai@nxp.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Lucas Stach <l.stach@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-pm@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-41285-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_CC(0.00)[linaro.org,kernel.org,pengutronix.de,gmail.com,vger.kernel.org,lists.linux.dev,lists.infradead.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danielbaluta@gmail.com,linux-pm@vger.kernel.org];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,mail.gmail.com:mid,dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns,pengutronix.de:email]
X-Rspamd-Queue-Id: 32062642F3
X-Rspamd-Action: no action

On Thu, Jan 22, 2026 at 7:54=E2=80=AFAM Jacky Bai <ping.bai@nxp.com> wrote:
>
> On i.MX8MM, the GPUMIX, GPU2D, and GPU3D blocks share a common reset
> domain. Due to this hardware limitation, powering off/on GPU2D or GPU3D
> also triggers a reset of the GPUMIX domain, including its ADB400 port.
> However, The ADB400 interface must always be placed into power=E2=80=91do=
wn
> before being reset.
>
> Currently the GPUMIX and GPU2D/3D power domains rely on runtime PM to
> handle dependency ordering. In some corner cases, the GPUMIX power=E2=80=
=91off
> sequence is skipped, leaving the ADB400 port active when GPU2D/3D resets.
> This causes the GPUMIX ADB400 port to be reset while still active,
> leading to unpredictable bus behavior and GPU hangs.
>
> To avoid this, refine the power=E2=80=91domain control logic so that the =
GPUMIX
> ADB400 port is explicitly powered down and powered up as part of the GPU
> power=E2=80=91domain on/off sequence. This ensures proper ordering and pr=
events
> incorrect ADB400 resets.
>
> Suggested by: Lucas Stach <l.stach@pengutronix.de>

Correct tag here is:

Suggested-by: Lucas Stach <l.stach@pengutronix.de>

Also, no need for a new line between tags.
>
> Signed-off-by: Jacky Bai <ping.bai@nxp.com>

