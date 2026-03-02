Return-Path: <linux-pm+bounces-43386-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GE0ZBPpApWk+7AUAu9opvQ
	(envelope-from <linux-pm+bounces-43386-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 02 Mar 2026 08:49:14 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C93611D4246
	for <lists+linux-pm@lfdr.de>; Mon, 02 Mar 2026 08:49:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 387D73013DEC
	for <lists+linux-pm@lfdr.de>; Mon,  2 Mar 2026 07:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90B1532720C;
	Mon,  2 Mar 2026 07:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lj4zFjuZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B58D387341
	for <linux-pm@vger.kernel.org>; Mon,  2 Mar 2026 07:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772437744; cv=pass; b=BOEOhoKlBNzCH0BiuuO2dZsFGhhaZE1qoX/qVbJbDNgAgJOurKP6w8UiO3HoE8CHlQxXtiVthbF1xy25uGdk9eq3mEtUZdw+WTvnQfThyMA7mJ/iJs0Q3gsnN0ATwz+3JmVZKQkLahktWBpjsKvBjwoba/HGMdq0oTgdbctSbgw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772437744; c=relaxed/simple;
	bh=zfzcHPT+JwZC39dyL/viiO7eTWwNwkDHvlPh65vmq9A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KL1vhJrJIWbByuIm+koBSEYRuX/HcwPs+E3UlWGBC/gTCj8QjBtClJRNjoTSlxISXy0coniULbLcjXy2MZlFksoc+J55wa35ggLkB/eNm5ufIG5RwJ80SzJyJLHtbNRH2zJrQ7RODXHmzMKKEjZcedKsktqeLKGgjRXAxljqa88=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lj4zFjuZ; arc=pass smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-439b78b638eso580246f8f.2
        for <linux-pm@vger.kernel.org>; Sun, 01 Mar 2026 23:49:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772437742; cv=none;
        d=google.com; s=arc-20240605;
        b=IzeSjoPIGYdFJhjxgU6jgVeomphFEQHNjnWqzlGICpENm/ewJULyY0+ynXTT8/oFQz
         d2Xo/uYDrDAQGd+J/mpnRKZ0sHLbQGJx0maPx0rCR7Pui7d+WlyWHO9FqEqrlqcx8cWe
         oue9KjtmEz1ireEXv5uE+f6EG1oSqHNTRHHdykU1a8Vfis2Otl52LEwI7HEwLNvnI6yV
         rnYzRpPgl4rm72DixN/ukTb8YzQtayBz2BC3RtwY30IlwyJChP8PzS7aAYJGvIXGgCn1
         pgB8vyU+ZYsBv31xupPWpaCbNCr01AIpT3hKFUorURV7yjQkQEdTckNzkJVTHtEu5rNW
         SkdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=I/oJfr9Pu+urtc/j7fGTmlq8z2GFyLhYZEAdkieiuKI=;
        fh=SMS360qugUf2VKofv/qVToWd/ZFkY+o2fuyu4mcoOP0=;
        b=YNum7avMEzDj7dVdsPbNDIoq6sDIWeFBGMsXQvDVNJFFRYOZbdJbYD87zYGnBiXexo
         j7glYyR65k6ECDnggjtGqhdjXhTw+UStb0mZtTfhi+MNY/FVXoBc9oTXPgelWOK6vyXN
         +ST4VNuE2WAMJUjmxd7MSajPm9519sKVcSlrL71STtRlN5P2X+WNia408QfWKRi3Ptmv
         2oyf01SYHRldoJT6JqR/PcplwRV6uDirkOxl61tXitsMz+bzwAmZY94C7HJ91J91ziEL
         nBtiepd2u3tnf3bJiY3H/u7aAxP5Zku/HVd/VXJKTUKq42N2euNJMu5hmrcarC9O/5aM
         TpoA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772437742; x=1773042542; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I/oJfr9Pu+urtc/j7fGTmlq8z2GFyLhYZEAdkieiuKI=;
        b=Lj4zFjuZadj9QskrFn52BHDgAfizPkiUjiNzjaoYXJsWQ5AQD3oZp8RO7CRoRE/9Gy
         31S7g3QOkVGCW3gzx/aPGO3s/xgHV5Jie0oqXS2bjmoxyLHU8cklJ8cXhn7fKHSvIQxC
         JAplpB1fAkJQdyCI1FzMtM216q2nzfGRr/dLb0B3c9GU4da061WnizIgTJk3QEJMu9NU
         6gOD1doj3ReX2rE+JPctlU/pWQN7jM7V5W9qoTPVUmUTPDxGLYf1nOBkve9CqzxI9YO+
         /ZQyAC0YFLMINZNlmzrlYX1HLvHd5DSbFZbtiIBGVMUa86A+piyMuiuoIOOsnyexwHJM
         wg1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772437742; x=1773042542;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=I/oJfr9Pu+urtc/j7fGTmlq8z2GFyLhYZEAdkieiuKI=;
        b=t9TLeFhBIWllAvc1xxCfsVLl/OM0ee79XO/zy7CrSu+kUkeJKjgk0Grin/8Cw097t3
         AjRuQp4Frii/krxVvgfxvTasBZnmGY9QXyj7lKexNV63QB4iHSxE5odynyO6yAjGzSrb
         ak4v1CnxgXJu3Mnx9UXek+EW5WdohdMkPwX8rqw0Vzapf9BPUr6S2aOU9/dLq5oCuvTl
         zm/IzRXTIoOdsvqX1pRaPRTywI4hdVsNnMERatd1Csaahw1TnrrDOYAOmkpkrG8HBEL7
         DD1n13EOKTfD8RphXqAe+JVqAbjqjGmFdq6NTKZwS2UdBEmq5SEkj/BXyrQjIeg68jsc
         qSIg==
X-Gm-Message-State: AOJu0YzX20CZo3N7vvPVF7BDDsGvo1QisPRtVpKp+iLyzAXBR5Jl54X0
	GksLQ4YpnjXGk8h18yulkQo2wUDHbHCWoPiziZOngpXG0ggSWTr4e+40Es9b7cAlvR9BYywX+3R
	dRsA7YsjMIioORZdkDoS9F8iOaGuaCZE=
X-Gm-Gg: ATEYQzwkBTs3eWV446TsNpEQ6xwQeAkB1KEKe1kJ5pHeztEJImOgYlqasdaXvV8jutX
	TYZytfpWZR71JPLGffeX5q8raJ0DYisNF+MbJwuxlonwJZRzS7BopGbbFp24pRIRRqMlO8tKCSy
	cj88PUK4Fl0WIVqyCq3wk+2jLOoQYbALjap5mJdgr0fLE05pG0ckn7AwCd+dQzPtFp3PeMKyAll
	Y7RvDwutjY+Q5wOj+g4EsDBaluUdYqK5tD/VF83jbRAHa/rlFfvn31bQahYz5uIJMGFBCTqGtLq
	VAQJZcQJSE6k1jTGQb4=
X-Received: by 2002:a05:6000:220f:b0:439:b7c9:2efd with SMTP id
 ffacd0b85a97d-439b7c930a7mr3857211f8f.37.1772437741562; Sun, 01 Mar 2026
 23:49:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260126185423.77786-1-clamor95@gmail.com>
In-Reply-To: <20260126185423.77786-1-clamor95@gmail.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Mon, 2 Mar 2026 09:48:49 +0200
X-Gm-Features: AaiRm514PkOkLCVQwvZakcRSu5Q1HkrbS3OBb9ig7BeBPfYn1x_O-WPzyMmvm0c
Message-ID: <CAPVz0n32qtkKs1i3E3smAT5LZq7EMWDbe7rjdUNSc7QUE4FmBg@mail.gmail.com>
Subject: Re: [PATCH v1 0/1] devfreq: tegra30-devfreq: add support for Tegra114
To: Dmitry Osipenko <digetx@gmail.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, 
	Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, 
	Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Mikko Perttunen <mperttunen@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>, 
	Thierry Reding <treding@nvidia.com>
Cc: linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43386-lists,linux-pm=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[gmail.com,samsung.com,nvidia.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[clamor95@gmail.com,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pm];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C93611D4246
X-Rspamd-Action: no action

=D0=BF=D0=BD, 26 =D1=81=D1=96=D1=87. 2026=E2=80=AF=D1=80. =D0=BE 20:54 Svya=
toslav Ryhel <clamor95@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> Lets add Tegra114 support to activity monitor device as a preparation to
> upcoming EMC controller support.
>
> Part of previous patchset: https://lore.kernel.org/lkml/20251125120559.15=
8860-1-clamor95@gmail.com/
>
> Svyatoslav Ryhel (1):
>   devfreq: tegra30-devfreq: add support for Tegra114
>
>  drivers/devfreq/tegra30-devfreq.c | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)
>

Hello there!

May this patch be picked if everyone is fine with it?

Best regards,
Svyatoslav R.

> --
> 2.51.0
>

