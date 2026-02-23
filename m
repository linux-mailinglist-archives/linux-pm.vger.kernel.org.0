Return-Path: <linux-pm+bounces-43074-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KDuhIx3PnGllKQQAu9opvQ
	(envelope-from <linux-pm+bounces-43074-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 23 Feb 2026 23:05:17 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 052AF17DF75
	for <lists+linux-pm@lfdr.de>; Mon, 23 Feb 2026 23:05:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6CC9730C30F8
	for <lists+linux-pm@lfdr.de>; Mon, 23 Feb 2026 22:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCAD037B3F0;
	Mon, 23 Feb 2026 22:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QvHbEZ/z"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B77637AA94
	for <linux-pm@vger.kernel.org>; Mon, 23 Feb 2026 22:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771884103; cv=none; b=L0NpC81v7jTl9CuZK5rAHD2UW53LSHqrYBEzP0S6OTdLJ532qi8jvNZFVzzutSUOrMGFhM9yzah+6+ZZ7HH6t6bO2vu/TybSlUAtbB5w+rCQqxq48auie3UCewOq/TOmCiWmQKaJMUvUD0oqMCLL53geGl9alA69Ox4gwMFPLOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771884103; c=relaxed/simple;
	bh=KUvMCXecxl1oTGRP8RuaVCGSIIYXm2h5FZ/R4PUy4Tg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JCHxLFTH7Tw+dajtP3g+FOqWJTORmh8zgFVpkpfD9VEP+SwUZ9rMRLe5EGGHnPHix0aEc79a37eGmsOwkK1SjcfRCwpJFUOrEQ5wMSwJL3I7/YO81FTpd7SXhruKvboMkIg51gSD3DgN/xb6/f3gQzfll3j6e4r1H0xS+FcByFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QvHbEZ/z; arc=none smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-12732e6a123so841277c88.1
        for <linux-pm@vger.kernel.org>; Mon, 23 Feb 2026 14:01:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771884102; x=1772488902; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vwmeVddzSBrk6onBg3XthXPBezPsVZCBdsI2Jvj2LQw=;
        b=QvHbEZ/zBwB13I1oFN0JKZF4+aL98Vk/gQFKF2IlM4SA3XRYV0AFs1Kjojh0PeVMu4
         cz3CIcmfZOVs+gbbDlmSlM7WZRTj4E5hSSZidqpghyMyxel5WXw53ZzEFMv+56k2lz5J
         rrUM1BkggQOdS+UyyHscjQbejOR1PwXA/fDUO4BS+W6cpUT+JIWTiRi+IOx/a24mJJUs
         bMWG64y8UL6YeleC+WO3CwWUH1JhQlPVe6d/MknRQAzelYq3ltUPGHp8bgo+dYKO31Jq
         lWtJv+bUdT7g/CMcCmRoFolI705er4sebiEpIoMFHcNnBeq6Qjqjv0lDlNw/E3KywWSZ
         COuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771884102; x=1772488902;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vwmeVddzSBrk6onBg3XthXPBezPsVZCBdsI2Jvj2LQw=;
        b=gzp5NbJyAFjwnDH2trJ0ddgsAEs56pvKlyERo6Wt2tmhRttxa7H2yvl7Rgr4+/PE20
         ZX3DuqnVxLdsNzTNeqGs1uSoG85t2xoTHty8cBM1a+Cs/6edok0yRF6d8fqLehxKw5su
         npq/VuGQ5AwWDuwXo+mEQV6vQA7sgC+jnSexLmHEyE4R8nO2ZNx65idbm1Cym0SqQ3zC
         nnX1xHvaJmcLiH5pdnW3kcPFdF1Ic2rfKXGzgs6NqDykskmy01WHgOfLJRd4Nb3DDS36
         U2QmiSuAIWcGVyAS5wVJVkb8Q1+a87WPwJvv4JvHbTfrEmkNsvC5oCS3myNivoQTUgsg
         dkmg==
X-Forwarded-Encrypted: i=1; AJvYcCXvSijCkULK9NnN3x9aXlsHZCF0gIjIu64/h6SyDov3ZQy3Wm4bqybwVKoHDB3uF2K1TSNgU/nXMw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6v/fq/k3lpyNmH9/KqaDH2pRXBU7OVHIevJKYkmplUkDs2taG
	e8mHFzv8A54izuHAaBS78ZKnmSFS1SqvOtN7Lvjf1F4pKZG6A3tR+Fnk
X-Gm-Gg: AZuq6aI3DX3hRws8HZfem4OQ7YnUiTR83KBkgw4NgwbUcLNnkfWG3m2Ba8Bd0AQfhGI
	qhwHawv06HqFn3UJyf82TgjdUpyNolq2iLbSV4aJD3k7RzdY59z+FzhvIQaf2rSHK/F2b7qwmTY
	BGXWQVVqnJliCiRs+m6But4Ht69/vJE11RAdioz294AC90N4WxKxAVNII+zGtmepPaYTvC77g+G
	hIZ3N8K2FFOCf8cc2lUJ/0Yx3+4eGEIqMwEaf6tAK/QKWtNrjwJsGPrkWHVaMOhYFyf8zJ112z9
	Zaw/wK4y3ds+wN8eLfPd+m4Z94vJQyJZtDEYY4UBPzRRFUFqlNVoCEMwDhRHgzZZBgiCOxTKgow
	HFfAYrI4JKQKcG8JTbF4ETctcJHAyDurR5aaRElekicDlahNuffcyMGH/LgVDOUwHZ/dyy7r/0d
	4rAmAJnVJj3dk5tdC337Lqq1v1df7u9YcyHXS+DUIOGLQPZzrW6MAadmRyHbbchVI6
X-Received: by 2002:a05:7022:2521:b0:11b:9386:a3c8 with SMTP id a92af1059eb24-1276ad8bb87mr4839876c88.41.1771884101638;
        Mon, 23 Feb 2026 14:01:41 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:1b48:5d6e:ab6e:5287])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1276af2edd7sm9460001c88.8.2026.02.23.14.01.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 14:01:41 -0800 (PST)
Date: Mon, 23 Feb 2026 14:01:37 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Luca Leonardo Scorcia <l.scorcia@gmail.com>
Cc: linux-mediatek@lists.infradead.org, Fabien Parent <parent.f@gmail.com>, 
	Val Packett <val@packett.cool>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Sen Chu <sen.chu@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
	Macpaul Lin <macpaul.lin@mediatek.com>, Lee Jones <lee@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Eddie Huang <eddie.huang@mediatek.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Julien Massot <julien.massot@collabora.com>, 
	Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>, Gary Bisson <bisson.gary@gmail.com>, 
	Chen Zhong <chen.zhong@mediatek.com>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rtc@vger.kernel.org
Subject: Re: [PATCH 3/9] dt-bindings: input: mtk-pmic-keys: add MT6392
 binding definition
Message-ID: <aZzOHVh10zr9hiWs@google.com>
References: <cover.1771865014.git.l.scorcia@gmail.com>
 <056cbc09fcbb4a2845cece69209a2a564d993ac5.1771865015.git.l.scorcia@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <056cbc09fcbb4a2845cece69209a2a564d993ac5.1771865015.git.l.scorcia@gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43074-lists,linux-pm=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[lists.infradead.org,gmail.com,packett.cool,kernel.org,mediatek.com,collabora.com,bootlin.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[27];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitrytorokhov@gmail.com,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[packett.cool:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 052AF17DF75
X-Rspamd-Action: no action

On Mon, Feb 23, 2026 at 05:12:42PM +0000, Luca Leonardo Scorcia wrote:
> From: Fabien Parent <parent.f@gmail.com>
> 
> Add the binding documentation of the mtk-pmic-keys for the MT6392 PMICs.
> 
> Signed-off-by: Fabien Parent <parent.f@gmail.com>
> Signed-off-by: Val Packett <val@packett.cool>
> Signed-off-by: Luca Leonardo Scorcia <l.scorcia@gmail.com>

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Please merge with the rest of the series.

> ---
>  Documentation/devicetree/bindings/input/mediatek,pmic-keys.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/input/mediatek,pmic-keys.yaml b/Documentation/devicetree/bindings/input/mediatek,pmic-keys.yaml
> index b95435bd6a9b..2d3c4161a7f8 100644
> --- a/Documentation/devicetree/bindings/input/mediatek,pmic-keys.yaml
> +++ b/Documentation/devicetree/bindings/input/mediatek,pmic-keys.yaml
> @@ -30,6 +30,7 @@ properties:
>        - mediatek,mt6357-keys
>        - mediatek,mt6358-keys
>        - mediatek,mt6359-keys
> +      - mediatek,mt6392-keys
>        - mediatek,mt6397-keys
>  
>    power-off-time-sec: true

Thanks.

-- 
Dmitry

