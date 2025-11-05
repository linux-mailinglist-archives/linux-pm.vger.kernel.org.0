Return-Path: <linux-pm+bounces-37402-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DBBDC343AA
	for <lists+linux-pm@lfdr.de>; Wed, 05 Nov 2025 08:31:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D88318C5885
	for <lists+linux-pm@lfdr.de>; Wed,  5 Nov 2025 07:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8030E2C375E;
	Wed,  5 Nov 2025 07:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="FNLlsFmo"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 403A825C80D
	for <linux-pm@vger.kernel.org>; Wed,  5 Nov 2025 07:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762327845; cv=none; b=Yi61Wi5acUZXkPKBDwJlUE6Xu2bi7wJsH1/r5shTibNl7XP28Vuj91uFaIRRvW8CIVxNzmRxMWJEsJMGiJSBLK9BhShEuAvmTrg87la3Az2CaE8dX2ZQHdqce/SFQo773Ftv2pD3LVtBzv+3I3S/yAJC7HSWV1UcDAIrIWAJnMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762327845; c=relaxed/simple;
	bh=E1dOHEET+fuMIcpW2X+DT//mWVo0l6r5A9sIRy7IIxY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f7Xr44d5Lp9H/LqP+RD01dfn43GQ5PPzALN/rMNtawksCQIRwLSRPJNawUUfgE1cI/i/Um9kstDapjcaEnMQoyXN0ZYytuo35OEW0Y8olj/fFyNfDJs3SPf3q/KAZ1vwDA6ERCsEKXDLUK1pa+l4ioFZDXyhlDe3h+6rF9PQA1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=FNLlsFmo; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-640f4b6836bso2095011a12.3
        for <linux-pm@vger.kernel.org>; Tue, 04 Nov 2025 23:30:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762327841; x=1762932641; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ux6+i1bmVIFWhQiGDp7l9kTwV5Ptw+dOTwT3koSlg34=;
        b=FNLlsFmomleac0MTdyvsazTsZeqkPpYGC5NOEbOajvZ7ZKLfLg/5N1+b6vVEQWIzbq
         wGg1Kkc9s4bklbMYsKHUbGIxXnil5iElofoxsxTmIoQgCXABt44xbKRRXE6VRzIxysn9
         GBZN5ini0+W6srpl4zj2Yf9kqlmvdP2s1E5dCu7i1SQ+QeBMEpahKs24U+HUrBnD1sXn
         tye+jr3Sb0II/9o9bf3naF7h6az2TA6cmxfc/HaL0gPlYCeSKu2eYN9k7AUL35pZIf1z
         Ll8NTyzSMPz75aC54jJyrby+5QvTb3sHMxD3FfDKMJ4+18u0o0GttQXc2b4p7QFy7Mim
         O+RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762327841; x=1762932641;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ux6+i1bmVIFWhQiGDp7l9kTwV5Ptw+dOTwT3koSlg34=;
        b=L3z/g7tXBUjLa1caL6V7moMM20ZDWZC6s/9QnTLDKX0vn+IkfzSLPgRl1wSwevd4df
         hWaMNPyNY+UtQb7+q4+HetZAxjazWymMZogC3PPvjHG9V5inYBKEEtWCoFsCsytAZZis
         y2C0qQiSbdSCUrrsmdT8H4zsJ+x8qBtDL4ikY7Pg54L9zHWErrimN2nhIrwcOgWn4++P
         YG5Q9AnQYhg5/fk8h7+uibDfg30pn1r3iDWyAxn+u+bIL6TAr7/mYkIIPa0viX1wc/Kh
         /Cz4SdP7zhQyM0PqKozX5nD8PPHfejW6Iz6aLF7mU+AYqb5h0wlL1K7RAKxn/JPbKwGN
         Wvcw==
X-Forwarded-Encrypted: i=1; AJvYcCX46U3eDzj3gJBUcDb7HfIpBMeM5MjbLIzE/OL/JX5/l+g0gBHOOyUewGumLaP2uoNGy6jzWsbnQA==@vger.kernel.org
X-Gm-Message-State: AOJu0YysJPXmXVYUeHsnv/IUkcMqdv7u/KDpwTihG/jAyLnYN3dHiqOI
	TQRfV1tX1nvlx9mXHKz5AKexZoZ90ojpY4LgSdj6GTBPQH72QOTaqwIVOp4Df+qjtMMaNjfbrzD
	KXHi/
X-Gm-Gg: ASbGnculmbGqyvHTZrjCtXq1Q2a3W5wD0JNAEuzO2zuzwRKF9pUvmY3LW5AF2Vohxt8
	Xzz2xSppmvYdOCVu8A23Kkexei2gZJ5sVkKow62WouXEof9cMhA1AM/9ekSdTXRV2S/Ge39G8dl
	U3KKmHRPHzNsWxatj10YrJBOTaa2I+L7nWrpSQO7irFjjI68Eyjw/BLEqyaNtpq5pTGU995ZRoy
	xCW+Rsm7YzHwSFr6GtbWgDBBLDTaTAl77sWpYLz78Q2iFfRVXGfPejowuHvMx12uNcEByJoNDLn
	hgGTVpB1D9yNWhn8Wc3t2eKz0Z/iQiReCnt/Q3kAT7OS9c3T5U8+bbvUuT0cU3uoGEVcM0QGzkV
	hBrDsub+qmUOWGGauCAt9qCqb1jjt5xPXUZyYhU4sLK464pvtkd0PcQDlmQVNcuMRNLgi3tbMuM
	HZPE/jQ8Zv7RW84A==
X-Google-Smtp-Source: AGHT+IF4Z39tdBwbbzTMRpDJUt9P/ptkzqi1eF1iOdtCWCbeCbOmCHd88OE2YgBLVLBryIJTdoazkw==
X-Received: by 2002:a17:907:2d0e:b0:b6d:7742:c20c with SMTP id a640c23a62f3a-b72654e1f17mr170440066b.36.1762327841465;
        Tue, 04 Nov 2025 23:30:41 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b724034ade7sm414148866b.69.2025.11.04.23.30.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 23:30:41 -0800 (PST)
Date: Wed, 5 Nov 2025 08:30:38 +0100
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sherry Sun <sherry.sun@nxp.com>, "esben@geanix.com" <esben@geanix.com>,
	"senozhatsky@chromium.org" <senozhatsky@chromium.org>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	Greg KH <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	"ryotkkr98@gmail.com" <ryotkkr98@gmail.com>,
	"kkartik@nvidia.com" <kkartik@nvidia.com>,
	"fj6611ie@aa.jp.fujitsu.com" <fj6611ie@aa.jp.fujitsu.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-serial <linux-serial@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: Re: [BUG] Suspend failure with nbcon + pm_debug_messages (Linux
 6.18-rc4)
Message-ID: <aQr9Hgx-AAP9i1Td@pathway.suse.cz>
References: <DB9PR04MB8429E7DDF2D93C2695DE401D92C4A@DB9PR04MB8429.eurprd04.prod.outlook.com>
 <87tszamcaz.fsf@jogness.linutronix.de>
 <DB9PR04MB842977523C92FDE8AF4B714A92C4A@DB9PR04MB8429.eurprd04.prod.outlook.com>
 <87qzuem7bo.fsf@jogness.linutronix.de>
 <DB9PR04MB8429F50811DDC648DD8A7B8792C4A@DB9PR04MB8429.eurprd04.prod.outlook.com>
 <87bjlhz8pw.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87bjlhz8pw.fsf@jogness.linutronix.de>

On Wed 2025-11-05 00:25:55, John Ogness wrote:
> Hi Sherry,
> 
> On 2025-11-04, Sherry Sun <sherry.sun@nxp.com> wrote:
> >> Thanks for confirming the fix. I will make an official post on LKML
> >> with the patch today. Since the i.MX nbcon-driver is already
> >> mainline, I will CC stable. I will CC you as well.
> >
> > I'll keep an eye on any fixes you send later and verify them if
> > necessary. Hope this fix can be applied to the mainline and the stable
> > tree ASAP.
> 
> Even with this patch [1] I am able to reproduce the problem on one of my
> test boards. I am using the following extra boot arguments:
> 
> no_console_suspend loglevel=8 initcall_debug
> 
> And then:
> 
> # echo 1 > /sys/power/pm_debug_messages
> # echo mem > /sys/power/state
> 
> This generates a lot of output and leads to the same suspend
> failure. This may be due to the out-of-tree nbcon-8250 driver I am
> using, which introduces extra irq_work usage within the driver.

Great catch!

> Could you please try the above boot arguments with your i.MX board?
>
> I am wondering if blocking the queueing of irq_work during suspend
> should be generally implemented rather than just printk avoiding it. It
> also seems to only be a problem for ARM32 so perhaps it needs to be
> addressed at the architecture level.

IMHO, we could not _quietly_ block irq_work during the suspend a
generic way. We would need to warn about it so that the callers are
aware of it. Then the callers would need to explicitly block it
to avoid the warning.

I want to say that explicitly blocking the irq_work in printk() looks
like the right way to go. I think that it would be needed anyway.

Best Regards,
Petr

