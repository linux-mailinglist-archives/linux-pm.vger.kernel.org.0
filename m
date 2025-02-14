Return-Path: <linux-pm+bounces-22052-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79D80A353C0
	for <lists+linux-pm@lfdr.de>; Fri, 14 Feb 2025 02:36:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B9C1169BEE
	for <lists+linux-pm@lfdr.de>; Fri, 14 Feb 2025 01:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF782524B0;
	Fri, 14 Feb 2025 01:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="ccLFeh7L"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA654173;
	Fri, 14 Feb 2025 01:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739496991; cv=none; b=QINGLLDmPJh0B96oW+mC86sje7/2RXltKnI34IF4+CwVRlF92xnnfxB/4qobApaIA/Bb3GqGJijqiaQJFd6bjfY/BGDVDMNbusFPt5NYv3j6voB2bW1tEceFymSr7bdvvvFRNb7F0PVjhD5D0TPEz3f1u3HlBiuK7X8XpvghpLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739496991; c=relaxed/simple;
	bh=o4bCKfWHjGwTBjdm2IcIyjlNuZqJCh4Fg1xp5lK96No=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aDfxCKsRHjf+UAGYvvXpMSKrOXBpd8JdGhIMonDfMMOM8IfywaDcQqJueKRqihkpfPwcUzpWxYkkiNONJV8hRIZAvUvKMd/ev+aQdaaeVgXevuSmk+CWEmmKvIOwH6KcH2jO2xGF4a6OTDYOOTqZuNNbBKguGuXfHpUScJxCnno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=ccLFeh7L; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4YvF502m61z9tH1;
	Fri, 14 Feb 2025 02:36:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1739496980;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ldK3UvbGMu2MUQaQQRCOl6NMvB8rJRV43cYaNNdAQbo=;
	b=ccLFeh7LUto3VY2gB0P6DD0ojsKHHMtF3lCvAS7iPn/7gOQ3OKBcU3nQIWdV2/Gey0YciN
	pJxaQIuIqMBiYvOMHaDwswDxXTwKOnNiuJU/QBgZIcIywBZRaajkOuWNjzsvTf8r4qy1HJ
	/9hWQRs2FlkyCoFSCi3mhEyiBN6yS1q2eIfCVCDnINyNpT0rw4KWRMUTZzSTO531C/Uuwd
	86Abk+BYemZKSYTHG+yYpt2gdEW4P6EoVmfdpslOjvuj8UuEYcDDP23HGK9w2XQSYxc8Qo
	oLovtPtbC311k2BHk0a4x9iwkK7jxEEaupq8q11YSUNMVeHOKSrO/llR6F7fJQ==
Date: Fri, 14 Feb 2025 02:36:17 +0100
From: aruhier@mailbox.org
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Sebastian Reichel <sre@kernel.org>, linux-arm-msm@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] power: supply: qcom_battmgr: abs() on POWER_NOW
 property
Message-ID: <ioiy4ixlvx5gxl3f4pqshwxz35ktrqghju2circpnd3qicgemc@oohazfsfvuag>
References: <20250213-patch-qcomm-bat-uint-power-v1-1-16e7e2a77a02@mailbox.org>
 <yfbgbdugk4xdjpemozdzcuxczx4xd5aphykuksf3lhn22dsgkf@fcfgddu6gpyt>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yfbgbdugk4xdjpemozdzcuxczx4xd5aphykuksf3lhn22dsgkf@fcfgddu6gpyt>
X-MBO-RS-ID: 692bc13f94b72a787be
X-MBO-RS-META: gujha31ai1kqxnn8gwzehyctez8tfapr

On Fri, Feb 14, 2025 at 12:24:18AM +0200, Dmitry Baryshkov wrote:
> On Thu, Feb 13, 2025 at 05:51:38PM +0100, Anthony Ruhier via B4 Relay wrote:
> > From: Anthony Ruhier <aruhier@mailbox.org>
> >
> > The value for the POWER_NOW property is by default negative when the
> > battery is discharging, positive when charging.
> >
> > However on x1e laptops it breaks several userland tools that give a
> > prediction of the battery run time (such as the acpi command, powertop
> > or the waybar battery module), as these tools do not expect a negative
> > value for /sys/class/power_supply/qcom-battmgr-bat/power_now. They
> > estimate the battery run time by dividing the value of energy_full by
> > power_now. The battery percentage is calculated by dividing energy_full
> > by energy_now, therefore it is not impacted.
> >
> > While having a negative number during discharge makes sense, it is not
> > standard with how other battery drivers expose it. Instead, it seems
> > standard to have a positive value for power_now, and rely on the status
> > file instead to know if the battery is charging or discharging. It is
> > what other x86 laptops do.
>
> Documentation/ABI does not define ABI for the power_now. However for
> current_now it clearly defines that it can be positive or negative.
>
> >
> > Without the patch:
> >     $ acpi
> >     Battery 0: Discharging, 98%, discharging at zero rate - will never fully discharge.
> >
> > With the patch:
> >     $ acpi
> >     Battery 0: Discharging, 97%, 10:18:27 remaining
> >
> > ---
> > Signed-off-by: Anthony Ruhier <aruhier@mailbox.org>
> > ---
> >  drivers/power/supply/qcom_battmgr.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
>
> --
> With best wishes
> Dmitry

I see. But as it breaks existing tools when power_now is negative, should we
change the behavior of these tools or adapt the driver?

As it does not seem common that power_now and current_now are negative in
other drivers, tools using these values rely on the status anyway. I'm
wondering if it provides anything to keep this behavior.

--
Regards,
Anthony Ruhier

