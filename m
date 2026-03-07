Return-Path: <linux-pm+bounces-43897-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eJIwJHMkrGlHlwEAu9opvQ
	(envelope-from <linux-pm+bounces-43897-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Sat, 07 Mar 2026 14:13:23 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 36E6322BDEE
	for <lists+linux-pm@lfdr.de>; Sat, 07 Mar 2026 14:13:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8EE80303CA69
	for <lists+linux-pm@lfdr.de>; Sat,  7 Mar 2026 13:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 998333A1A5C;
	Sat,  7 Mar 2026 13:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NJ5dp/pr"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24A083A1A34
	for <linux-pm@vger.kernel.org>; Sat,  7 Mar 2026 13:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772889134; cv=pass; b=GDBg2Q4NLSqtB8yx5l4D0Nuu0KHZaMsFGVtP5uGfumeoikHOJqU4Ro0y0cdUJl4UooIKtIRLCJMuhMYfN16x6P19T2tpOUAkzVdwIr4hzPITdUUg7h78fsdzTm3h9d4HdNwODQVb8Op9rOHKNBmNbTzS61+FjO+7+D9gNLGGe3E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772889134; c=relaxed/simple;
	bh=VIWFI1y5VRLZ373RQL/JnbZVRkgBAGhKPHT1hx5Q3QU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WbmKCDv8qYZAhOp6DHYeJpP+RwiuvuRuLxVOTkYq2T1mXZfui4VFi0ChAzBk2KEtqRLhh4kV6rwyN7ZxTxpbR0kynyTAHDGD8mPNgEAkfXt+l3cIxkjUZgFfR7dTskK2yupP1fXPdDclL03vFniNMRkBJZQ7cFtKHx0SQFqQ+Aw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NJ5dp/pr; arc=pass smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-439b9cf8cb5so5846258f8f.0
        for <linux-pm@vger.kernel.org>; Sat, 07 Mar 2026 05:12:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772889130; cv=none;
        d=google.com; s=arc-20240605;
        b=jLhO/8/JBABj7Z8ZUs3crh/9NM+a1IrAIqgRCuvHCreDVBqHTvKQqPsy3dPXa1BSKU
         4ImCcv/3WqMASq97XonA6DavNdzEMTavMjI1x1P/El9r+cy95tBL08Zw6AZGoluS8PM2
         Arx287nuP7dpSehs1nN2zRJOsNJd4hbCfbqOaIisZ/ucRLXXd2QCnyqNHxIEFWnSaATX
         HZ2EoUjTqq+iXW0ovqNYwjDYjVhASNAp7fwxUeRCRj4gzf/zNu25NiMD8u2du+E/FK25
         jSNglh97FBFpxNrmNkSzk5ikip8UtZzB4dlwKqDZ7Bd9DqfiQ3m5WgnvxqE8OkdNK8w+
         xgfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jwpJkt0avwp9jkgkDYYA37vOWQ50nBFUmOdRhI9vm4g=;
        fh=Y0K8XAIRJGwlNucRtbuT22GUi1db018udb0mPZVxfUM=;
        b=LL6x6bmr40Sz4TqfJSL3RC4q520cb98hh062tDzWtMaim+ZSZhnkjUnDYhisgjhRVd
         0q23vichSv5HYm4rn3l/hrpfZc2tdQOAoWQop7y0THcI8TPBLuENIeb22T4cm+S2eY/G
         9jfotS5hRBammVXEsZh12oQ5mkRz2QaRpS26KY3BPav1TROP4RkKFTDU1yzcSAzhFddZ
         RdCJKXvFsCLev8bfDz5OixVWRSsuX9Ejz7a2S8JGd0wT5IYyHF3SewEnHJE3jLuKk6TL
         OahIAJoYrrpyP2/Ag0aTfL5dH0ytXV6O4hjBoPxmHljKh5wWCBpwVGGJAthVnLDEMsEI
         z1oA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772889130; x=1773493930; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jwpJkt0avwp9jkgkDYYA37vOWQ50nBFUmOdRhI9vm4g=;
        b=NJ5dp/pr8J6GiCRh5o4uhYUrKCGUSZQzU6KQ2fdqE51GxWIADL5d2+iq1PlF4m3iFx
         xPLpX1/++m89Atunk0PZpshSbhUiP7NHGZ3H45uM19lskys4UdlgmxKPvRAIIaZU3i2A
         PM77oNh4Hf28RXz/B9v40eZDsJA1W5vaSuyj1mriAhSpwLvpbnsfrMnZKUVsiXyQ55YI
         YDOLeQNc7p4bA+nZi+TihsGKxuSX3tXrkua8sFEQBpbmDnKjtjYoHi9VTN9QRdngOezK
         9UL/Ndn/QhsCtmsFzhCVKhckESk6MprtmVFXgUyqMqIrmnvb/VHmIMssb/++L0iLcCZx
         Vu7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772889130; x=1773493930;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jwpJkt0avwp9jkgkDYYA37vOWQ50nBFUmOdRhI9vm4g=;
        b=V00M5Sw5NdlXZNDbUZxqGWEY+HqDY7c7oYJDBln0vP4mSfIlPcYqNc1qyZNNiNf5YQ
         2Lbyn4HYbXoNN2SWZuiiGU+imr2HLNsWk4ZuFaIoPzm78+LpNDoBpz4QIfDbq01aUaj8
         3Fb+hmU77sFdlCBriunQMJPiQ5fIt/QTz+7wHIXtGDeC50wwCfnITkeujkzZJkRJfbhY
         K72BrtyOea1hahpAuAIlCrYtVhaip04GROhB/0LKhgGBDXY1C6hM4VhGIV25UiN8BnpK
         SOk4X/lFDfRdktNoHPdlutB94B9cVnvQeH/m1OHDEPbs8O8hZ0RMZ+B9jcuh8gulqbt3
         fKOA==
X-Forwarded-Encrypted: i=1; AJvYcCWyLls21V8amu2BaLaP5aiXnM/R9nWoLiqy4mkgrOpDfwvZvCmkf1F/X2LFduj1BgnFoV1zpmfMyA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwIF9Paep7YeWsGOvsw7wNw5YNw0GevMTXN63I4jrZxlfLw554K
	KXb7rVrgpJONeNttwead0a3PT+IBqgEpTt+NzeTd8G8rbLkjeB3EXOQijG+2ljmiAGKqT5RxWyB
	cpIvJAJW2GXm3oJ0EFixWCDsdses2vuQ=
X-Gm-Gg: ATEYQzzmZONh8q8Swsw4eelJYfxPaZdbQjenkKTgVIhE7ps5tuNYjk+XDjOyXAFG4nj
	oGosO0mW1B7rAjHADpDKinNM31N/p6gXpsvi5yKnBEYVdgRPQw3M8IQgT+cEmT0f8mBjBAFHHyI
	3CTfu8ubt7O0o28IiQAW8O+guxNahe6OuCLYKTTPMc2/tRELK6z65EbyhEhJTADRjzHz06zp2i4
	y4p9ObTVtYRqZLE+5xwEntfllhTfz/gNCHbUcms38+jduuN23Umwc1YPJN17cCBvi3cNogVrdig
	zn3eQAPe
X-Received: by 2002:a05:6000:258a:b0:439:cbb7:3c19 with SMTP id
 ffacd0b85a97d-439da880b24mr9456804f8f.27.1772889130119; Sat, 07 Mar 2026
 05:12:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260306133351.31589-1-clamor95@gmail.com> <20260306133351.31589-4-clamor95@gmail.com>
 <20260307-azure-quokka-of-abracadabra-cebde4@quoll>
In-Reply-To: <20260307-azure-quokka-of-abracadabra-cebde4@quoll>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Sat, 7 Mar 2026 15:11:58 +0200
X-Gm-Features: AaiRm52JT8p_3rf_HqGYMWaWzNT7LpzzUhIeETfJmIKaZ646udUvob7af9WUE-w
Message-ID: <CAPVz0n3Qj78B9Ga=p5wixu5umY+uVP=Fs7K3nwix1NT2eNgtrg@mail.gmail.com>
Subject: Re: [PATCH v3 3/6] dt-bindings: gpio: trivial-gpio: remove max77620 compatible
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
	Chanwoo Choi <cw00.choi@samsung.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-rtc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 36E6322BDEE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43897-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2600:3c0a:e001:db::12fc:5321:from];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,intel.com,arm.com,samsung.com,bootlin.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.975];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[clamor95@gmail.com,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[100.90.174.1:received];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Action: no action

=D1=81=D0=B1, 7 =D0=B1=D0=B5=D1=80. 2026=E2=80=AF=D1=80. =D0=BE 14:43 Krzys=
ztof Kozlowski <krzk@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Fri, Mar 06, 2026 at 03:33:48PM +0200, Svyatoslav Ryhel wrote:
> > Binding for MAX77620 GPIO function is covered by the MAX77620 schema. G=
PIO
> > controller function in MAX77620 has no dedicated node and is folded int=
o
> > the parent node itself.
> >
> > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > ---
> >  Documentation/devicetree/bindings/gpio/trivial-gpio.yaml | 2 --
> >  1 file changed, 2 deletions(-)
>
> This should be squashed with the converting patch for this compatible.
>

Acknowledged. Thank you.

> Best regards,
> Krzysztof
>

