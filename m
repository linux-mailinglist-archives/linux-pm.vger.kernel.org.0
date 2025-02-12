Return-Path: <linux-pm+bounces-21917-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D62A2A31A7B
	for <lists+linux-pm@lfdr.de>; Wed, 12 Feb 2025 01:30:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CBE918872F9
	for <lists+linux-pm@lfdr.de>; Wed, 12 Feb 2025 00:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6B42A957;
	Wed, 12 Feb 2025 00:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KPn+OvsS"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14AA4566A;
	Wed, 12 Feb 2025 00:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739320205; cv=none; b=t2E2oJZqpEpiY2iCB6/6KFXf7Ze69+7b3v0tfbGTuSfm21jswBTHGSBCq0mnomrvGmbER/XK8XS/a1aQkZylYOZwpLyXVnWqMLP4HoGvMLiLbE0gGHiQ5js/CRjTs26Nxjlhu7Bp+2fVpO6TSnY9+oOcuzZgte0S/w7fGMqJ/U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739320205; c=relaxed/simple;
	bh=5n6CIWZ3CxVNLsrtCbvzjAs6RrZHUz2LGcyMe8T5d/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XVfjcAFc06Vw20teHxFLfnA/jBdVFqlnw9Zo/NVqKG+6gsUpe+C9oUafGJxoC7Ys/pYlkLdBrEwvO+g062CmzIJEKKx25aY2vGWKqAtlveac1N6KHqZF5PscXXSNGa801Te+mwJWW9NC9drkjKxUxb2PRAVYfsND38UjY3UF2c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KPn+OvsS; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7c05dc87ad9so308974185a.3;
        Tue, 11 Feb 2025 16:30:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739320203; x=1739925003; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PMXY+b7w1R2zK37gr/dvT3WG1zO8cthqCAH7UbMiDus=;
        b=KPn+OvsSifDS8CTHukmUfJFBfBh68xxSDhAmxOv7EEa0dcs1wstQo47ntMs5O4AFuF
         P+GragoyUIhYHaDGHoyBFYNEMDJAScES1tRoHxdVlx5e5v1g47AGJJXa38yGl7abXEzS
         qOG2IRfgnEwyUkJkfZVMlmzGkJa04dU6f9k+37dfYaS6eM9tYi/oEtFWZg6RUpmyH2BL
         ysSPDt/8V4/QabxfXp6beiPrwQ+hm141cqPK34Zxm9VWsYwlRYM+v9hDMBkTxF+K84EY
         tWTSzArXZx1FTBTogeSWX407RL6mxx9kT0xe82qXCWnap52MB6LvwrrN1nJGlGf5epyI
         2X1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739320203; x=1739925003;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PMXY+b7w1R2zK37gr/dvT3WG1zO8cthqCAH7UbMiDus=;
        b=qHLkMDLarPxaviyOdtHvfT4SDXXLD+oCYTOaFp6vIZDzCM34LOL0KXSINSype53eBm
         Kc0w0k4hG3BbA9zVkfcFHUfQhW17NJv7qzlEpNFSrddTG5QM/upCQHutp2mJIS7vImth
         TGtVDWzDknsQxtzg0wDNtXEMPXOEi76hXqEMw2goQvtyyGseCz81+JN4WU5RUJNMAsjh
         8nGNv/pOdnM6O9AYsuL2895MwuHNsYFbj8VKo7cdikuNswAb5tfGP87sScMB++6s1sJj
         ZWaVdLlFcjGQ7Q1+owmM/GWPQw++Qns566zG+xB52xQHfYbCo0D3BhvNcNKJ29QnDfY7
         Bnww==
X-Forwarded-Encrypted: i=1; AJvYcCWdL6oWwg6DvtiN1sh8p55E0as2Id0GUt26gBYO2rfUXjXnhiJ52SlNtgHyRnyrCV7sQbp5diLPH7st@vger.kernel.org, AJvYcCXZAXNb8BtYZ58MqADGGgE52JxkaRU83GvXtohScD8Q4/CAxSvP94yZb+XHuhGVv6u13VGZE7FhJfY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzxic8hGEXvawKZgycD8ADDR2Ngp6qKGpaqK39/kSJVn+s9H3JF
	oTkP63dYR2mvGDllqEyRWijHXkaD/CTZWVOphiP4ll6T8DZ8QtN4
X-Gm-Gg: ASbGncuEaP2hiLtnKSOfnCmWmbxn2QFMkk+pMMmsycNg/Kufj/95ScRACZg/QTZmpRu
	4av6uteMvzW00b45WlFVGuBbOIvOrVGECvcQPUzMdVcncRzzeCAMZO/C1XD89gWInDo/DP0bpNi
	QaQPnNJRD0IS5BgPylLo7FE9IjrbQ2PD53/FpVHvciN2Zg31YJ8h9JRD341KpYpIV1s+z5teoTw
	AhvlvEmh3pI7vVtTM8nK8Pc7Nfbnyx0+P4ZGjNaICK0N2Fmv6US7i5FrljXXkAlGec=
X-Google-Smtp-Source: AGHT+IEycbQbC8PQDQpHssIWlJbqaUfQDH5H7e9AlKziotBrsNh5hQbOfp7wttz1fsHAHfvTcMGspQ==
X-Received: by 2002:a05:622a:1b91:b0:471:ae33:b362 with SMTP id d75a77b69052e-471afed77b9mr13923621cf.40.1739320202786;
        Tue, 11 Feb 2025 16:30:02 -0800 (PST)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-47153bec10esm67114951cf.74.2025.02.11.16.30.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 16:30:01 -0800 (PST)
Date: Wed, 12 Feb 2025 08:29:54 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Alexander Sverdlin <alexander.sverdlin@gmail.com>, 
	Inochi Amaoto <inochiama@gmail.com>, Yixun Lan <dlan@gentoo.org>
Cc: soc@lists.linux.dev, Chen Wang <unicorn_wang@outlook.com>, 
	Inochi Amaoto <inochiama@outlook.com>, Lee Jones <lee@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, devicetree@vger.kernel.org, Haylen Chu <heylenay@outlook.com>, 
	linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 00/10] arm64 support for Milk-V Duo Module 01 EVB
Message-ID: <prrsy34bv6xskxu7afgmpdwc7lefdh7l2gtm2ejzcwk74zh6lr@23x3llxy662z>
References: <20250209220646.1090868-1-alexander.sverdlin@gmail.com>
 <eoeyutuu4mrpsu7snkk5ll6kmm4344qsgbnncss6gerlcvvea7@usuf5v7w5ffp>
 <77c0db160bcaa7c2a68c04a0d33a561b2834f764.camel@gmail.com>
 <ccadcdf720d6b1055165f1404fafca9b1c6c54f7.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ccadcdf720d6b1055165f1404fafca9b1c6c54f7.camel@gmail.com>

On Tue, Feb 11, 2025 at 08:37:01PM +0100, Alexander Sverdlin wrote:
> Hi Inochi!
> 
> On Mon, 2025-02-10 at 21:55 +0100, Alexander Sverdlin wrote:
> > > > It would probably make sense that the whole series would go into SOC tree,
> > > > even though technically nothing prevents the reboot/reset driver to come
> > > > in PM/reset tree. If everything would come together, `reboot` command would
> > > > work out of the box.
> > > > 
> > > > [1] https://milkv.io/docs/duo/getting-started/duo-module-01
> > > > [2] https://github.com/milkv-duo/duo-buildroot-sdk-v2/releases/
> > > > [3] https://github.com/sophgo/sophgo-doc/releases/download/sg2000-trm-v1.01/sg2000_trm_en.pdf
> > > > 
> > > 
> > > This reboot implentment across the RTC and 8051 domain, which is
> > > still a big problem to be upstreamed. This should be designed 
> > 
> > Now I've got it. The problem is not in the reboot procedure, but
> > rather how to model this thing in the DT, because of all these
> > unrelated functions brought into two HW address spaces...
> > 
> > > carefully and needs further discussion. Adding these two syscon
> > > compatiable may be not a good idea and cause some problem. I invite
> > > Yixun to this talk and he may give some useful suggestions.
> > > 
> > > At last, I prefer this goes to an separate patch series, and
> > > implement with rtc device.
> 
> Thanks for your hints!
> I've completely missed the RTC driver in progress [1].
> I will provide a patch registering the reboot handler on top of the driver
> as soon as it's accepted.
> 
> [1] https://patchwork.ozlabs.org/project/rtc-linux/patch/20240428060848.706573-3-qiujingbao.dlmu@gmail.com/
> 

As far as I know the RTC patch is no longer maintained. Maybe you can
pick it up?
The patch states can be found on:
https://github.com/sophgo/linux/wiki

Regards,
Inochi

