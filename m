Return-Path: <linux-pm+bounces-41413-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iLIYAr03dWkqCQEAu9opvQ
	(envelope-from <linux-pm+bounces-41413-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Sat, 24 Jan 2026 22:21:01 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 649667F076
	for <lists+linux-pm@lfdr.de>; Sat, 24 Jan 2026 22:21:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2371E300C58B
	for <lists+linux-pm@lfdr.de>; Sat, 24 Jan 2026 21:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BF51221DB9;
	Sat, 24 Jan 2026 21:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VkXAD7c9"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2504510F1
	for <linux-pm@vger.kernel.org>; Sat, 24 Jan 2026 21:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769289657; cv=pass; b=Lpx/0m1Sw45JwNZGNB/2cr127yEljupj8ynUq1/EDQqNjmmbcXdg2ciQQG54ylzG35Qw6an49OMtK5XLuQ64FCFTiUSoj1UI0M3pHBpVOC0u01YeTGuyS3Nm8HgWNB2jWUQ7UfNQ27kowj01iZlYNxn1oTB1jt4JNSi73t/4sUo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769289657; c=relaxed/simple;
	bh=eUW+Nn1xQDwW+fDL2+2weYSRCbL1Ugg4lN7x4qKedq0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n/m+cocNmwJTdpxB7rGN9O8kA6Uq8zHlwG/KglkklR1MVDjkkzfzsTWwGlY+b1g4U7shG848nQ+cA7H9g/Te5Bgq/6ZdjFIr/f41KgOrL20cC2+ic4RuyZ+cJ5NMmGFucB0bOi/eA05XviwvPR+eRpi12M5WGnpzigzvENSdaAI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VkXAD7c9; arc=pass smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-385d75e1a79so22594741fa.2
        for <linux-pm@vger.kernel.org>; Sat, 24 Jan 2026 13:20:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769289654; cv=none;
        d=google.com; s=arc-20240605;
        b=J3gUDEGVpf8x4zkmMX0wi3XUdgLd6I8mnEER06EL+vMnQz0QSQGGQ1/jssIr8Lcg3r
         9fRbyLlt/jTjVgMI4OTuCrq6hukYPVqoI1l8Yvu6UBNGdhnTNJvTE+HnQGZlSZI6XOcS
         vr3oZ6tGT1twGFG3evN4S66blWTv2+WQ3uWIlM9wdreTcKAlJ6+eCyj3oPbk8HT4OHT4
         Uaobknh4djyKBeS65WHJs5V4cxRo5sCKUV7CVcsQqopTxo997w73q2ettJMQje+c/Q21
         O/aBilmAtSuvkyjLqdO9fGbg/MylEM6O8UIOGiHz8oSRdXBDzVljFX4nrFfV14242VUU
         bCUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eUW+Nn1xQDwW+fDL2+2weYSRCbL1Ugg4lN7x4qKedq0=;
        fh=2z9h+cQUp717JkrbEx1vkQOL3qeJTDMy81zBBdWx7fU=;
        b=PUvmlKpPNz0wFHtdT9BXzCyABNTkczTBn9yiFPQXVLo7h9adIhDSS7p+Yn884qMRww
         jfibAhkmKmxAkxEZNkNVYBEuMx6fZyIa4rsUW3i5DZvYxD1TPumv+jJon4EMaWzeUMqp
         6yeEfPYavYzaUstQgEH8pRztXBmmb/n2YgwNO8KPWBA3LHT1JLlInW4mX8lmLDwU07Wx
         XHF+5DnfrjYyCCBeC9i8XsevDkKl3z1qqlI6I9lIHffDCPIl4ntuyiWu/dSoNketi6dT
         xAP/VnDMV6I8OX5WuoeYVZ7HwrvwgWAPK2xNCy5ofNjQCGrU6wvZpJwKpxOAOvfCI/91
         Z+FQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769289654; x=1769894454; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eUW+Nn1xQDwW+fDL2+2weYSRCbL1Ugg4lN7x4qKedq0=;
        b=VkXAD7c9WaQrGIGDTD56RlZKGR5RX/IoMJ3u1OT+kNGWRTuhkHfoVBYQuNRlhmOwmH
         FBYt0YhU9GVYMDVBfe59XWQvhlieZyg39t+zChFMPkue0U8KSIu0XFroqMPygGOWwrZl
         P2xBrRFbB2thceRV4xGFjx30bkZjni2O+3tqx7+HhFuxrWwfBr/d8WmDaZwNnRE+1dXl
         gS3Lp8xcurgETBRfroUYKJ5q2dtpKko/7VXMiQxXGx69FLkE6Y0UPtVBMyarxCz6ri3J
         AnWkj7eECsv1UaAJkc+rbkLni8Lm4pWi2lDIzUZlRDtsGolUjZ5EJLOyMUH22BE7Bw37
         MJog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769289654; x=1769894454;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eUW+Nn1xQDwW+fDL2+2weYSRCbL1Ugg4lN7x4qKedq0=;
        b=bBMF97ovj/JmiopZ4LJn1HsUlX7hwZIYcu/t3CD5ZIJ0dkFeoioaBjl7nbC+H+C0aJ
         P6/Q2rcoOFdNi/uoFVfM62dU+pVw+j4fsyO7imdsVsmeU2C6icPGB0hkwlob31lkIgj2
         uencSG1v+DOmIQ4Ufy1gVRPWGHfzYvRtWBC/I3iEGr4SBg1El6etH20IP6bWoq0ZWjA3
         /y/bSnPSbZDKbdb1nE0iHQszxtSpmNSsXcl6ST9UXSDQXN6ZC8oyvMeC7MemnqU+X4KX
         NFzEI7aHgNEvV+giCwUdBY82pGSLj3K4WUChSMwZuXUMGVCcyZNLaDjG60G6ePODL+oI
         DkwQ==
X-Forwarded-Encrypted: i=1; AJvYcCUKT9k7TB89PKDcUh+MDXK4SMvX+gtuI67cfdwRl6yuUPBykiJhfonlrDnxQzdXmTi5turgT3XQJA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwQIIKBQAXomP1IkM0JDHg6IgHkknuBI1ofs2kkvns7mn/oB7yk
	VvfIFZIr9pGfZuLUeQX11OKZCP210QqPvvPTcfHcIYWsFLlwqi48lB2kjLaZKfdO4WCCWMY6Hwy
	sk7ToDFdZYyyFVvY4JVYeRbsBU9dteuQ=
X-Gm-Gg: AZuq6aL0RVWmf5r0vMCrerQBoaJjQohCuyzdx/hIc1ixwvq9qs2aZrjZAJzcO7E3QCB
	itDoYdC4EnA69a0tylqZ/DQ85OBbQuw2iK2V52AfxERrwesaAu4FsCblJNGvg7qjZtFXKWfedrB
	eSWE4y0gatWFelC3mrBBwrdk8PNtapNARKzGGgLxANANFkVowaTtoO9c/LDAe5+fq05+skkGTQB
	KusCD/2URIKsnAj1G6LLvpEVzWoirgY4l31+0WejISEV4e8QANcdEr++/2wCUHrmWM52MMeJXC9
	DU+LMk4sGH4qK2IQFxOBNqqYzBUMNRockE+3
X-Received: by 2002:a05:651c:31dc:b0:383:18fb:fdf0 with SMTP id
 38308e7fff4ca-385fa18a1a7mr202501fa.22.1769289654024; Sat, 24 Jan 2026
 13:20:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260123-imx8mm_gpu_power_domain-v3-1-3752618050c9@nxp.com>
In-Reply-To: <20260123-imx8mm_gpu_power_domain-v3-1-3752618050c9@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 24 Jan 2026 18:20:42 -0300
X-Gm-Features: AZwV_QjYUVpRsQS5aWPwAi-rYkpNXVxY9EFDkrf6zt0nUDYNEKpxxlUFDNbm7q8
Message-ID: <CAOMZO5Ag6jtVqeXW30QNy5+1ykmGTt4G8DxcsyOUMvNaeJf5Ug@mail.gmail.com>
Subject: Re: [PATCH v3] pmdomain: imx: gpcv2: Fix the imx8mm gpu hang due to
 wrong adb400 reset
To: Jacky Bai <ping.bai@nxp.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Lucas Stach <l.stach@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org, 
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-41413-lists,linux-pm=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[festevam@gmail.com,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,pengutronix.de:email]
X-Rspamd-Queue-Id: 649667F076
X-Rspamd-Action: no action

On Thu, Jan 22, 2026 at 11:51=E2=80=AFPM Jacky Bai <ping.bai@nxp.com> wrote=
:
>
> On i.MX8MM, the GPUMIX, GPU2D, and GPU3D blocks share a common reset
> domain. Due to this hardware limitation, powering off/on GPU2D or GPU3D
> also triggers a reset of the GPUMIX domain, including its ADB400 port.
> However, the ADB400 interface must always be placed into power=E2=80=91do=
wn mode
> before being reset.
>
> Currently the GPUMIX and GPU2D/3D power domains rely on runtime PM to
> handle dependency ordering. In some corner cases, the GPUMIX power off
> sequence is skipped, leaving the ADB400 port active when GPU2D/3D reset.
> This causes the GPUMIX ADB400 port to be reset while still active,
> leading to unpredictable bus behavior and GPU hangs.
>
> To avoid this, refine the power=E2=80=91domain control logic so that the =
GPUMIX
> ADB400 port is explicitly powered down and powered up as part of the GPU
> power domain on/off sequence. This ensures proper ordering and prevents
> incorrect ADB400 reset.
>
> Suggested-by: Lucas Stach <l.stach@pengutronix.de>
> Signed-off-by: Jacky Bai <ping.bai@nxp.com>

Shouldn't this have a Fixes tag?

