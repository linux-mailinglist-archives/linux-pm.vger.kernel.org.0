Return-Path: <linux-pm+bounces-41943-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cJHvNgK9gWm7JAMAu9opvQ
	(envelope-from <linux-pm+bounces-41943-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 03 Feb 2026 10:16:50 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 59C24D6AD0
	for <lists+linux-pm@lfdr.de>; Tue, 03 Feb 2026 10:16:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4CE3E304A079
	for <lists+linux-pm@lfdr.de>; Tue,  3 Feb 2026 09:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E11343939D9;
	Tue,  3 Feb 2026 09:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="ajqtjO7H"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D1D30CD95;
	Tue,  3 Feb 2026 09:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770110206; cv=none; b=LdToO+K39PPRj1mdGrqDit1l3sajDAvu0ioulpMppNVe0Da9gUi+DEv6GrGyoPSLkRREzhW/Cvd0joT+9CNkBI5ka2JEzlaJ3z4g0btmm17Dlo8jCFFufjZ8c0ZTgEURK38YgxYDL+1Q5bTE6g2MF2jSYA3ZJPem/MMCGQRBTR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770110206; c=relaxed/simple;
	bh=HVWf8Lp74xqZ9RWSAuIoA361Ukve830OlplLgBu+bmo=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=qvIj38auJuh3IQfXIKGQ5LUxPXOvzpVaZMwRkmcrzaTAjDMRv4pYPAlDfMxWS9WR5VUKT8eR06OS8sDYA5lG7ql8ks3TZefe73dv2URTJ7LUMGIT6YSyvh6tC31Bxp2Dnv4i9DcDRKOmekCNjNM6zvwkw5frTRAMMVmue8TtpMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=ajqtjO7H; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1770110193; x=1770714993; i=markus.elfring@web.de;
	bh=4+RDtAf2Dud34+X+ZZ2+nv5Js8na/Rk9KLVfttQkEsw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=ajqtjO7HU2xMYEIm7/edazzLdh7UdAzwSd4feGS/3pkgialvQfVVQI6gddO2b8fV
	 pE61ts429MqLmfAKA7Pw6k5mcs/Iwu617biDPrEOXks6iHM8exOhNFS/QhJe6XLbC
	 IhrpIcvF2hfiQiNq623G2Ip7T+o9wuQ8NfEeJYiwMjrEdGv+3D9tbAVo2ZivH1E8S
	 Jz1kCcoWOM/mO/9Gsz4McqxVI53hLOMv7UbE5iGSjcxvutjHCichbLxYzUPTE9xH6
	 AIJviEdIetHHsWq/aPK0KhNym5TVStTMbENKq6Gj4eiCopxh/kk+RWFkUA78ZxRXi
	 nSramUHZ07xVbq12/g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.207]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mq184-1vRZ4d2w3W-00eWl4; Tue, 03
 Feb 2026 10:16:33 +0100
Message-ID: <cf5945f4-83b5-4fee-8f37-bdc8048eacab@web.de>
Date: Tue, 3 Feb 2026 10:16:23 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Gui-Dong Han <hanguidong02@gmail.com>, linux-pm@vger.kernel.org,
 Danilo Krummrich <dakr@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown
 <lenb@kernel.org>, Pavel Machek <pavel@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Tony Lindgren <tony@atomide.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Jia-Ju Bai <baijiaju1990@gmail.com>
References: <20260203031943.1924-1-hanguidong02@gmail.com>
Subject: Re: [PATCH v2] PM: sleep: wakeirq: harden dev_pm_clear_wake_irq()
 against races
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20260203031943.1924-1-hanguidong02@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rwScoHb/755RruvzeeOozRD3o2kxoiDZZRuNFGdUQUU3Fr24TmU
 ZEHcar+/al7Kt8IKxURYevYdyssfQwXI9CKdPPJiLNc13A1T+r3e7BOQBfF5tmb3CSl+x5c
 tNrrSKCTLG4RMC66rv2IVxsRxPDKDlHn2mwyY0nS20vClKbtns/tgHR1OLW+vSG7HckrDsc
 DgMeBq4PlSXKRzN4CunwQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:V2BKQv9O9jU=;Q8/CYM7GyxHnnM5zlJ954n6kmMp
 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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[web.de,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[web.de:s=s29768273];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-41943-lists,linux-pm=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org,kernel.org,linuxfoundation.org,atomide.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Markus.Elfring@web.de,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[web.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_FROM(0.00)[web.de];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 59C24D6AD0
X-Rspamd-Action: no action

=E2=80=A6
> +++ b/drivers/base/power/wakeirq.c
> @@ -83,13 +83,16 @@ EXPORT_SYMBOL_GPL(dev_pm_set_wake_irq);
>   */
>  void dev_pm_clear_wake_irq(struct device *dev)
>  {
> -	struct wake_irq *wirq =3D dev->power.wakeirq;
> +	struct wake_irq *wirq;
>  	unsigned long flags;
> =20
> -	if (!wirq)
> +	spin_lock_irqsave(&dev->power.lock, flags);
> +	wirq =3D dev->power.wakeirq;
> +	if (!wirq) {
> +		spin_unlock_irqrestore(&dev->power.lock, flags);
>  		return;
> +	}
> =20
> -	spin_lock_irqsave(&dev->power.lock, flags);
>  	device_wakeup_detach_irq(dev);
>  	dev->power.wakeirq =3D NULL;
>  	spin_unlock_irqrestore(&dev->power.lock, flags);

Would it become feasible to apply a scoped_guard() call?
https://elixir.bootlin.com/linux/v6.19-rc5/source/include/linux/spinlock.h=
#L585

Regards,
Markus

