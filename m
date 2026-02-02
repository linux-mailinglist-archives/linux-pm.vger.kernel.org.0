Return-Path: <linux-pm+bounces-41922-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CEXTNK8HgWkCDwMAu9opvQ
	(envelope-from <linux-pm+bounces-41922-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 02 Feb 2026 21:23:11 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DB14D10A0
	for <lists+linux-pm@lfdr.de>; Mon, 02 Feb 2026 21:23:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 80213304AC01
	for <lists+linux-pm@lfdr.de>; Mon,  2 Feb 2026 20:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 297DE2D0C72;
	Mon,  2 Feb 2026 20:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GQhA/mXw"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0489A2C3252
	for <linux-pm@vger.kernel.org>; Mon,  2 Feb 2026 20:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770063735; cv=none; b=Nuc6AMKigpEzugNorg4hMygMycqG/iTsLduoLeYxkPIViUEcFYC1/0blmvrpA71xl8LzT/OUttb2VA4DFF4+L28BGqGrmA6zu08nCMAC2URBAkUZFhpI8JdAbAVOgVSPDycvjkCow4ANWZykWwFJeRLgzwgIdXw8DkjixcsBiQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770063735; c=relaxed/simple;
	bh=fKRg9HhluO+QR8NQzfS3o8ufmBdfDqbXNt0o04+xN0Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FeeY+yQYquvTpi8sG0xch84Ymlf4bzIScBOB8XoomLyC+GXTjb7bqTYCt/6Oqfq4+MllzitDecatEwcqYDnRinlOcUzn7V0lwMTIjbfBbvmXy7OXHjSwNgGRihRs4MA3d8fJwrtPGRIT/ZNdqDZDwwtMxan6oWtMSLYsGWtbZJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GQhA/mXw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B66A8C2BCB1
	for <linux-pm@vger.kernel.org>; Mon,  2 Feb 2026 20:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770063734;
	bh=fKRg9HhluO+QR8NQzfS3o8ufmBdfDqbXNt0o04+xN0Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=GQhA/mXw3ghhWMW3OD4fwE2RRwmcqwqcHNb2Aj9N15ryKxmTA4/MXhiB70K1zFYe9
	 ubl8XgIuG/I3RmLrJJCFpmV5hxUKkrR2IOXtvPbon3lYDKRmbDtfSRAaZnd1eMxbXn
	 WgQi5K/AvUjcJdgwNWYOfe/5HvCt+1jHLAjAvZqqAKqPoV4qtFMgcKDb9wpSg4nJae
	 H3eaztRWbBrwPSMTV/gpdoDOwyUJiZOO05YC0fUhPlthAux7ORKLT3PI5j574dVlqX
	 a5jSUlg646oWI1XPbHhmpqXQ1znrWi7huvnQ1+aQNtAGAkFjl3D+yN1XqDmpaqduOX
	 nt06PBmcGyJdQ==
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7d1959ba05cso2112821a34.2
        for <linux-pm@vger.kernel.org>; Mon, 02 Feb 2026 12:22:14 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX2MESqZ1mNAzu8c1B00ZIewDh4hY/FP1KJtg43NTz2WKzzTyVzjkW+8GcqoqKlNneUiyBUHJwmng==@vger.kernel.org
X-Gm-Message-State: AOJu0YzqmDweQt0omFxiAdGxGi3LvW662UGee4yKm2hFop0ys/0c9mhX
	DKYZl1Xvp75IxuW2X7VcZuju/6I0Hp/LPn96bsXuV1esK+Sq2FJlas/UtUyW8sYxc7olzH9VPRP
	bSgEDsK+TyO7wy793SGW6hry9BIBUnDs=
X-Received: by 2002:a05:6820:151a:b0:663:327:ece4 with SMTP id
 006d021491bc7-6630f3c044emr5330068eaf.79.1770063733654; Mon, 02 Feb 2026
 12:22:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260130-thermal-lmh-oneshot-v1-1-9b132204ef1b@kernel.org>
 <md3ohsrso7hldhhlqwsky4rc7yf4uvpugyctvpge3emfc5xgsl@flei5hr3fxw5>
 <aX4amIuUFUtv7M2J@sirena.co.uk> <o5i2yrwpjxugzsyec7gkkxaclptshcn2swjwzeb2pxhqngj5y5@4ceaeiddvdyq>
In-Reply-To: <o5i2yrwpjxugzsyec7gkkxaclptshcn2swjwzeb2pxhqngj5y5@4ceaeiddvdyq>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 2 Feb 2026 21:22:02 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gyMuH5sNOMzSQ-=FWmc3T+RNUiSZGoLrDuX+haHo4bvw@mail.gmail.com>
X-Gm-Features: AZwV_Qi1HZYNZVuWYkYOUET8DBZxnz2lsmKkwviyx6V0qoXnpuxKD08SlYhRZi4
Message-ID: <CAJZ5v0gyMuH5sNOMzSQ-=FWmc3T+RNUiSZGoLrDuX+haHo4bvw@mail.gmail.com>
Subject: Re: [PATCH] thermal/drivers/qcom/lmh: Remove spurious IRQF_ONESHOT
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, Mark Brown <broonie@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Amit Kucheria <amitk@kernel.org>, Thara Gopinath <thara.gopinath@gmail.com>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, linux-arm-msm@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Aishwarya TCV <Aiswarya.TCV@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,intel.com,arm.com,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-41922-lists,linux-pm=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-pm@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8DB14D10A0
X-Rspamd-Action: no action

On Sat, Jan 31, 2026 at 6:16=E2=80=AFPM Dmitry Baryshkov
<dmitry.baryshkov@oss.qualcomm.com> wrote:
>
> On Sat, Jan 31, 2026 at 03:07:04PM +0000, Mark Brown wrote:
> > On Sat, Jan 31, 2026 at 08:59:03AM +0200, Dmitry Baryshkov wrote:
> > > On Fri, Jan 30, 2026 at 04:54:45PM +0000, Mark Brown wrote:
> >
> > > > This warning is there because IRQF_ONESHOT is only meaningful when =
there is
> > > > a threaded interrupt handler and this driver does not register one.=
 Just
> > > > remove IRQF_ONESHOT, it wasn't doing anything.
> >
> > > I think it might be not that easy. The IRQ is level-triggered, with t=
he
> > > IRQ source (if I'm not mistaken) cointinuing to be high level while C=
PU
> > > is overheated. By removing this IRQF_ONESHOT we might get an IRQ stor=
m.
> >
> > See the commit log for aef30c8d569c ("genirq: Warn about using
> > IRQF_ONESHOT without a threaded handler"), and note that a oneshot
> > interrupt will be unmasked if the main handler directly handles it and
> > returns IRQ_HANDLED instead of waking the thread with IRQ_WAKE_THREAD.
> > The handler in this driver unconditionally returns IRQ_HANDLED.
>
> And looking how it all works, it looks like qcom-cpufreq-hw disables the
> IRQ generated by the LMH driver, which in turn disables the LMH IRQ.
>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

I've applied the patch as 6.20/7.0 material, thanks!

