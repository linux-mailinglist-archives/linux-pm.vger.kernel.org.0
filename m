Return-Path: <linux-pm+bounces-38651-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BDD02C86BEA
	for <lists+linux-pm@lfdr.de>; Tue, 25 Nov 2025 20:13:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 70EB34E56D6
	for <lists+linux-pm@lfdr.de>; Tue, 25 Nov 2025 19:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5312E333434;
	Tue, 25 Nov 2025 19:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="KDZFJSR6"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CFF5332EC4
	for <linux-pm@vger.kernel.org>; Tue, 25 Nov 2025 19:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764097997; cv=none; b=J1y/+jvNFO8hxaHmDiMxK0ImgRh52zB5HeDhsHAfXH6ckVO6Vkaf4GXOk/dKYMdF7QMhoGHV6VU3ZL0W54VsnkgDd/Fn0fL0ZTEHCzilnydAY28DOzqQOBcfQ1MQZA2bUBtmMQSmwT7lFgbPijZayCzYhIzp8Hj/Sn/IwNtHcJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764097997; c=relaxed/simple;
	bh=O6xQSEOSSLorS3JoyF4oWOfmqM+ZOwXB9/BrGMSCLEM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mGE58NqseK7c3yQDso7L84oYRtCdxcEyFhSG8vbQS5E2i0B0iD0ylazfoW3Tvho13BeYaOXC17F4QJW32tu70P9YLQXL9cvpFeUYHzGwZE2Nzv6AoGfmKOuB35oY+qBU78xohNyyZTBqa3j/8b3u8InDU64O+wMEJaCH5loSQgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=KDZFJSR6; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-297e239baecso808565ad.1
        for <linux-pm@vger.kernel.org>; Tue, 25 Nov 2025 11:13:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1764097994; x=1764702794; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=C02M4R8AXlaGJb+76yOGTDrtM9vCoimbBn8lp15HTo0=;
        b=KDZFJSR6Dxdqd0gU7qbGN3K4YS9koSqM58gmsXpRg9wM4RUfy+9IjlqUPU2ojyRl5E
         TRqvbH9lj6wx/NMsvNb1K4W8T0fcHopJmD7V5k1k/gdZZvsScocUubNfDVmF3ADWHiot
         y8BmytvCSD/2USNi+3wYzT9hE34QhjIiBMG0eIuU7Y2aqe4cziNCWigAmjBB1soRQiEq
         zeVBWKh4OZHQxIJk/Mx5bH+9F9DQp2wIJiNJTs1A13XHk0tvStoizNiCymS+8+S4TwKp
         XDWD6RuKsN/wSXyZvWMstEOJo+jYKjoZHccekdOLR2ku+e7QoGvjHP7tzUydjp3Ye7Rg
         e58Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764097994; x=1764702794;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C02M4R8AXlaGJb+76yOGTDrtM9vCoimbBn8lp15HTo0=;
        b=Zs8ZvOfqdtw5uqEbBDkHTlLd+Zgt9pq0Oygo7i05O2WcWuco5eSxGyQyTpmvmBO4RB
         0Hdj4G9a95f7vnXbSvFRlhtfFZbGBkD4NKUFRocp8azBnuSNcRsIrX6Gdj4U+sZBBK3x
         hB3GkwXVV4H7JfoYvMDPHhx9gh3YDkG7c7Ih3qOxwDpMgA1FDgQLALuHwLpdhIaj9q3h
         CWaIKLvqUVGRcAxmv6WSvCdqlBU6VZmFigGFtagkfumTPmsguwMaUiKxVorNdRVp4HuT
         U03GcGH8ie3y/ZeWQSwechK8X8QgxT7pNKXyIcUCHn40LCE0gL8cHrMdQKv3PX5O+1Wp
         B5VQ==
X-Forwarded-Encrypted: i=1; AJvYcCX6Ry6TfcAbMJLirbaU5m3kFAGKh4pWoxswW40X6tNDAIzvdgWBUh4tVcM1ZhL2NKN9Pr/6Q05sfw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzUUEf9S6Uq6quLqHk8XSzHQiEhUgi+DjgwZZBoZApOu5EDOp/i
	DhCEHSjxMW33M70A789aH/Vw9h1dph0DXdPm/XiCohofBwKvUPECQfZP8kA2y717VXo=
X-Gm-Gg: ASbGncuVP7YU5vyo9FbvxcDs2ZLxz1VZmL0UaRsfoXZm2m3cdy0mPnPlasXDO9Xv5LW
	B9Nt55O20Coaknd4a5K5fjPPNclPy43SedaFN3V9CVaqnvhOwNDUr6QBeMQ2jUX0oPQ1mJortwz
	NVJ3/0QITYqE1/R6pPdEHoCUPHzmaMbpYs44jJ7mzzPPnSC8Ea2ZdKivTfjk5g+cQDwWJm/VofZ
	3ghOKntli0zE7e24PFxsZo/liqVW79dZk5i/sE/+XaNcXh9JJ6Rm2ATyG70SlFxP/3iBhw1xIL+
	bl6+dWDKPdx2eNczU3SeVQdbIh/4bMOFRPmwznT0XgNqeMupHZB4n0G2DxbjqF+cp9WxYpmrz0D
	JRY0z2CBdWvSe2/MOgmoylnrC45vzV5Qmrvhx/hRyeQG4ZWAd2Jgn8heQu29+4DwnoPBSiywKbJ
	3+bCZpBK5Q
X-Google-Smtp-Source: AGHT+IHP+k2R3EGO8iDfp3QWHD4eBn1iOwj1nBs9x0FoztVw6VI+8cqb7hGb/P+tf7nDKCbWTeZr+g==
X-Received: by 2002:a17:90b:1dcb:b0:341:1a50:2ea9 with SMTP id 98e67ed59e1d1-347298c120fmr19107932a91.16.1764097993444;
        Tue, 25 Nov 2025 11:13:13 -0800 (PST)
Received: from localhost ([71.212.208.158])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3476a56b53asm178611a91.7.2025.11.25.11.13.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 11:13:12 -0800 (PST)
From: Kevin Hilman <khilman@baylibre.com>
To: Herve Codina <herve.codina@bootlin.com>
Cc: Rob Herring <robh@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, devicetree@vger.kernel.org,
 linux-pm@vger.kernel.org, arm-scmi@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] of: Add of_parse_map_iter() helper for nexus node
 map iteration
In-Reply-To: <20251125085521.451ea208@bootlin.com>
References: <20251119-topic-lpm-of-map-iterator-v6-18-v1-1-1f0075d771a3@baylibre.com>
 <CAL_Jsq+2sFzQb8j5bBWbwgyYn5apLTfWOTZW3+9n74uVyph16A@mail.gmail.com>
 <7hjyzedgoc.fsf@baylibre.com> <20251125085521.451ea208@bootlin.com>
Date: Tue, 25 Nov 2025 11:13:12 -0800
Message-ID: <7h8qfuc4dz.fsf@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Herve Codina <herve.codina@bootlin.com> writes:

> Hi Kevin,
>
> On Mon, 24 Nov 2025 17:50:11 -0800
> Kevin Hilman <khilman@baylibre.com> wrote:
>
>> >
>> > There's also this in flight for interrupt-map:
>> >
>> > https://lore.kernel.org/all/20251027123601.77216-2-herve.codina@bootlin.com/
>> >
>> > There's probably enough quirks with interrupt-map that we can't use
>> > the same code. Though it may boil down to handling #address-cells and
>> > how the parent is looked up.  
>> 
>> Hmm, I wasn't aware of this, thanks for point it out.  It looks very
>> similar to what i need, except for it's hard-coding the properties as
>> "#interrupt-*".
>> 
>> Seems like this should be generalized to handle the generic nexus-node
>> map. But it also seems to rely on an existing function
>> of_irq_parse_imap_parent() which is also specific to interrupt maps.
>> 
>> That being said, I'm not sure if interrupt-maps are really special, or
>> if they are just a specific case of the nexus node map.  This drivers/of
>> code is breaking my brain, so it's more likely that I simply don't
>> understand enough of it to know how to do this correctly.
>> 
>
> The main difference between interrupt-map [1] and the other nexus node maps
> is that in interrupt-map a child unit address is involved and translated to
> the parent unit address of the matched interrupt-map item.
>
> This child unit address is simply not present in other nexus node maps [2].

Ah, I see.  Thanks for the explanation.  Indeed, that makes it hard to
have common parsing code. :(

Kevin

