Return-Path: <linux-pm+bounces-43060-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WA8xDYuUnGnRJQQAu9opvQ
	(envelope-from <linux-pm+bounces-43060-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 23 Feb 2026 18:55:23 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EE2117B288
	for <lists+linux-pm@lfdr.de>; Mon, 23 Feb 2026 18:55:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 93B63304A2EF
	for <lists+linux-pm@lfdr.de>; Mon, 23 Feb 2026 17:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 901A133A6F0;
	Mon, 23 Feb 2026 17:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dH3ig7Dc"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B76333970F
	for <linux-pm@vger.kernel.org>; Mon, 23 Feb 2026 17:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771869315; cv=none; b=Fwj5x4hkjNYmrNJ6fYuDz0CG+kBg2gbVtk7ey1pzNzIX9wz5ujGkdvbdW13LdY8DS/obpZHD9M4b/ugMwzrlDjfcXaRS2NiHuR7MHapAAUyTlQdiZA5M+zFhZsua8Wp47OfoLYzq1z5CoTgG5JEdgdTjcwIvYVmAP990UQrOaOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771869315; c=relaxed/simple;
	bh=JF1KZ8us1B4UC6UAm56h5UA3Lh/N4+4s3jylcnX4xUQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PlImLXUn9Q+dFKurL4Ql64JIwy8EMSkYTqRw+xU4Gp3r83MHOLhBRqfO96wihHvGjoP/Xl41dERSd/HabW63dLtY0Z02FoN+SUeOe3zQbpVumvb5YtuFQmqgqnrsPp3KkNk+UwFWzqC4VrUyEZ5r9tStjKms4ACouhuPM2vcblk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dH3ig7Dc; arc=none smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-12776bebe9fso93339c88.1
        for <linux-pm@vger.kernel.org>; Mon, 23 Feb 2026 09:55:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771869312; x=1772474112; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8S3D2amG83bMjq3rYrixdtz5QNwrXVFuIOF99KB48r8=;
        b=dH3ig7DcgoD2/IW68Ckw0bdharNJTHMFc8etCmoR7iPRba+y5eJ54Y/r9E7U/Iuhod
         Ldi7g3QsXsNHLG/DmGqqjxwdZ9JL40yDti4z6Nc2tM7xmz8HnDo6RWArOd3yX0fz5Hsd
         xjDXOs8dtiFrX/7NHm3illACfYNA9365Qet69FJ5E8x8HVGAevDgBcbxjwiG6JJX4GQG
         4q9ElXskCyiGdnCjF7jYImsZyd3+vA8sSie3IHYr6H/nv5Y76UwBX0a3MPhNq+4AHVa9
         UutxyWd5vr9DxURjxnQDQsygsoC8EgZzOM1gJb5Q6yFuWuPmSh0yJT4oiF2hOGJkAQDZ
         X9kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771869312; x=1772474112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8S3D2amG83bMjq3rYrixdtz5QNwrXVFuIOF99KB48r8=;
        b=jyacfeSZrSM6Xgt0DMEOENhpuK6UHISJCg4uukz0aX49bCJLvvaJih90oZcIkKujir
         //u++PeLByhHqalWq3C9f4ghbJoXHsuamVMaINFdz7mwlPwY1t/GnV/CjQf3fHOMRPkz
         vmoL2N+2MFMR/HNMH4aJ74fopQ9lhFBpW8m0lLGXHnOO2hWDllKlZwraR27I2eeA4Zsa
         NVMY+nd7j8UwXFg2zT7mkB5jANFXRwpXhz2gAAsqUL0ocam5wQq1norGQhOTwjUCKpxm
         KsN39Ic7w+j0Zs3IdGZPjTXzPC9FPwKAA56te8mpMKn4f+yrjk9Yi/XZBdj71mWbg8Oy
         6aBA==
X-Forwarded-Encrypted: i=1; AJvYcCV2wU8gAxZGXmBIPoZRdRid7j1t7YqG+T92wH7qhZF8ssbcMYeC11vOCIrQobEOFQ22TOZUB7vKkQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz50R11IR3kCDvZDilw0oeKitPR44s/JpCv/9G+ld+ZpXdusuGU
	CQJWVCMPwfNG/iY8xwFpg6KvMbmAwjMspWTQlgynIyAJMG4NiW8gk8YU
X-Gm-Gg: AZuq6aJAZwHPjZ4omTdbbn8EyAVbYDQEMZvX8VxlKx9DIs2UdDjAxf+HZX5cbIJ+Zk1
	aGJyiQQJAejmRPR5NseRcJ81ok6r6Kf+zG2ARpeH346K6OMW8kCH+7SzFT7VJT0Nvgsu4/9Nj0j
	xsnW2zHc3CWfKmV73jObGd8C6pn/hX+LwEq1iscqLRmr47F+LGqz6Qwnxm5Z8Xgf8JFuOlD7YWp
	BnYMkUHmWPbohD3BfzUCx4YnCZwn1Baao1Rt4Hlc4I87qZIQnKRLhRaE9BAtWEGSq0d9llmaME7
	FxHKZcuNKxtm5pCz4ELsAyM/ciTGoGwFBmYePWv9vvRhFrp3mkT3nv+sYjjyhfHJL8/VMM3YcUM
	hW/6SdvFU0susIFuOYdOuOLd/GFylJy61HussteL7yABFG+F6DCtgFX61ucQh6RQ5MyaCwa/npR
	PovFVV8VlovyMLVntzVSp7McI19GZ7kpECbnSkM0TGPB+vu18vefKlLBOHz1v2wkBhTdfI7gfYh
	I4=
X-Received: by 2002:a05:7022:2214:b0:11b:9386:a3bf with SMTP id a92af1059eb24-1276ad61a70mr4534016c88.42.1771869312175;
        Mon, 23 Feb 2026 09:55:12 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:1b48:5d6e:ab6e:5287])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1276af7ad65sm7334624c88.11.2026.02.23.09.55.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 09:55:11 -0800 (PST)
Date: Mon, 23 Feb 2026 09:55:08 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Luca Leonardo Scorcia <l.scorcia@gmail.com>
Cc: linux-mediatek@lists.infradead.org, Val Packett <val@packett.cool>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Sen Chu <sen.chu@mediatek.com>, 
	Sean Wang <sean.wang@mediatek.com>, Macpaul Lin <macpaul.lin@mediatek.com>, 
	Lee Jones <lee@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Eddie Huang <eddie.huang@mediatek.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Gary Bisson <bisson.gary@gmail.com>, 
	Julien Massot <julien.massot@collabora.com>, Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>, 
	Fabien Parent <parent.f@gmail.com>, Chen Zhong <chen.zhong@mediatek.com>, 
	linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rtc@vger.kernel.org
Subject: Re: [PATCH 7/9] input: keyboard: mtk-pmic-keys: add MT6392 support
Message-ID: <aZyUXip4zgeDUdVQ@google.com>
References: <cover.1771865014.git.l.scorcia@gmail.com>
 <2c96591313084d240ac94b9d42d91d984fa9bce7.1771865015.git.l.scorcia@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c96591313084d240ac94b9d42d91d984fa9bce7.1771865015.git.l.scorcia@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-43060-lists,linux-pm=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[lists.infradead.org,packett.cool,kernel.org,mediatek.com,gmail.com,collabora.com,bootlin.com,vger.kernel.org];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9EE2117B288
X-Rspamd-Action: no action

On Mon, Feb 23, 2026 at 05:12:46PM +0000, Luca Leonardo Scorcia wrote:
> From: Val Packett <val@packett.cool>
> 
> Add support for the MT6392 PMIC to the keys driver.
> 
> Signed-off-by: Val Packett <val@packett.cool>
> Signed-off-by: Luca Leonardo Scorcia <l.scorcia@gmail.com>

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Please feel free to merge with the rest of the series.

Thanks.

-- 
Dmitry

