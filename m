Return-Path: <linux-pm+bounces-16108-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A36819A6C5E
	for <lists+linux-pm@lfdr.de>; Mon, 21 Oct 2024 16:40:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64E5E2820FD
	for <lists+linux-pm@lfdr.de>; Mon, 21 Oct 2024 14:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACF6C1FA24B;
	Mon, 21 Oct 2024 14:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RjcJR89Q"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6D41FA245;
	Mon, 21 Oct 2024 14:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729521601; cv=none; b=HROehtWyhhGtg/Bx8mKnaw6RPwbRNMNx9cz5FxY0CwhbpDqdAN5mEniAE3AF06Mrb+QQsZt8IJICgcoh+Z3v0riLaRUEcndbryyT/9OBNK/F+sIV2ytswRGHhDEp2NwfkKkHo/Pv4pfPj7miomYycPuBK1vD2Gb4/Bq4e4ombqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729521601; c=relaxed/simple;
	bh=srAtMSjBSzwRyI4CrAwKM3mPjctYEK/k/pj45vbucFA=;
	h=Date:From:Subject:To:Cc:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gy+y3AfsvpRCCbIVVWnQn708A6Ke7sPv6W8JsBx86q4XZ2SOHolxdfPKOOGi1fEBWhP/JjBeIjGiFCXnIjPJrViVA3Pb0pHi/kDwTsrkAytBLEvb+Xy3zzeDtigYAk3yzQoefMh4Ubp5hvI8nMn55bVuzK7ZCCBgmjMxi4bmaek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RjcJR89Q; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-539e1543ab8so7600761e87.2;
        Mon, 21 Oct 2024 07:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729521597; x=1730126397; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:cc:to:subject:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jdnEF4MP3z9LmQ+YWnGEuDQLrVcu+Y+YkXjsN21Vacw=;
        b=RjcJR89Qq25H/b8mLDVQfFr31mMLZoxjVRrjC8bD0lXhCZT6DIOGTQQfqUAd11JvWq
         U2U3RWSM43DiZBkm8v3wCFG31HI/IR1JRbDc7lkIz6nYrfZ8OnMS/mz7sipUlPkF0nFx
         7Qq3QSl2/dCOmSPbxqpwKp23PRUzN8w2QFiVbaIJ860CEcmVLmp2wpTVO+5wUWKGGXLu
         FE+m5lSjqGnUrLASTbUBMXCSi6f9czAxczSHF+e0IW48HcCtz4nsb7fYzDSjjr9GbOV7
         IF54utK/Z0rdDQ0dZtlQ4b85MjUCmvpq9rpBE357lVHjo2yB/zlBwg5ZjwAoRiE7629S
         +CIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729521597; x=1730126397;
        h=mime-version:references:in-reply-to:message-id:cc:to:subject:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jdnEF4MP3z9LmQ+YWnGEuDQLrVcu+Y+YkXjsN21Vacw=;
        b=J9jMytF8QCbcdGe2Ve2wT+jRrtnCluZJ/+UepIZAuSskBi1QCxfS7Pg3G35UIvmdRy
         qo6Qze5+xwv9/V5cFA9T22c1p3+unggxmA15kt8tuyWyPR65bQl9ho70GbKmCtBz7om7
         3ygD57TcRJBhtAZHFDcacjsjoysyqMxqRnY1CaJq5gtQ2LJeewdSFy0aF6+FKPfksYNm
         CWFqSgyjROxNRaR3zP+55+z2nTAv6p8gxy3wGn2PXAZciRei9HL7k7R3Daec3gQP+vzl
         Gq4+u4WvA7Tsqdfrat9Csc4fqBfSXERmVVuEgjq6vGBvKmcjmwaCBZsbA/LBUP+fiR2p
         ZfSA==
X-Forwarded-Encrypted: i=1; AJvYcCVaIFVEwoYZoXXen0wght53QD2msBsv3xfV+ZX1xrovqrAXf3k8tBdv+rSqZxzTezXeYbbDUz4FyAuzu41C@vger.kernel.org, AJvYcCWdlqZgcCx9TR2mO7Aslu73MPD9qMjNmpu26PiI3qI9U6zvrARd7/a0M2lxnAdjF9DwDv/Aa/+zZKI=@vger.kernel.org, AJvYcCWp5po+8cowy9NcrBiV7pQZst9oEVrqbXTxBMDgB3EmkJIdg9ZsF+pD5wIpV9uNWeyen49BWlgGv8SMeD8=@vger.kernel.org, AJvYcCXT8OANiJRp8O8z7j3Ag1kdoqXOyafpr8E5aozNZitL3IFt6aCx+oJ43Y9oIVvkwEz7UwZHdZL3/jGi@vger.kernel.org
X-Gm-Message-State: AOJu0YxVciVV3QUp64WIv04fim4Nih7OVlHgLoRFmoMTw7UgeG1VEZLS
	BEzvTPmvjllBt2SLPOnZZFnZKn8wsXJkoVUI6N5she/pOAW539gu
X-Google-Smtp-Source: AGHT+IFL60DydO7Av+sfeNcrf7sWojkZTRh14YqR9IlCxxqK5nbQT1J0lusnZXVd2ELtK5zqE3wQSQ==
X-Received: by 2002:a05:6512:e9a:b0:535:6951:9e1c with SMTP id 2adb3069b0e04-53a15444616mr8301354e87.15.1729521596991;
        Mon, 21 Oct 2024 07:39:56 -0700 (PDT)
Received: from [10.50.4.74] ([95.183.227.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a912f67e6sm209033166b.82.2024.10.21.07.39.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 07:39:56 -0700 (PDT)
Date: Mon, 21 Oct 2024 17:39:48 +0300
From: Yassine Oudjana <yassine.oudjana@gmail.com>
Subject: Re: [PATCH 4/6] mfd: mt6397: Add initial support for MT6328
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Sen Chu <sen.chu@mediatek.com>, Sean Wang
	<sean.wang@mediatek.com>, Macpaul Lin <macpaul.lin@mediatek.com>, Lee Jones
	<lee@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, Liam Girdwood
	<lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, jason-ch chen
	<Jason-ch.Chen@mediatek.com>, Chen Zhong <chen.zhong@mediatek.com>, Flora Fu
	<flora.fu@mediatek.com>, Alexandre Mergnat <amergnat@baylibre.com>,
	Yassine Oudjana <y.oudjana@protonmail.com>, linux-input@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Message-Id: <CENPLS.CE17IF58CL3J@gmail.com>
In-Reply-To: <9fbe6e8e-623a-4c8c-b6ea-c3aea8a5a56d@collabora.com>
References: <20241018081050.23592-1-y.oudjana@protonmail.com>
	<20241018081050.23592-5-y.oudjana@protonmail.com>
	<9fbe6e8e-623a-4c8c-b6ea-c3aea8a5a56d@collabora.com>
X-Mailer: geary/46.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed


On Mon, Oct 21 2024 at 15:24:54 +02:00:00, AngeloGioacchino Del Regno 
<angelogioacchino.delregno@collabora.com> wrote:
> Il 18/10/24 10:10, Yassine Oudjana ha scritto:
>> From: Yassine Oudjana <y.oudjana@protonmail.com>
>> 
>> The MT6328 PMIC is commonly used with the MT6735 SoC. Add initial
>> support for this PMIC.
>> 
>> Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
> 
> You're sending this from another email... and you have to add or 
> change the signoff
> to the other email....

I was using that email for a while to send patches but then I started 
having issues with it so I switched to the current email. Since I 
already had the old email in a few places in MAINTAINERS and I was 
always signing off with it I kept doing so while sending with the new 
email. I had this conversation with another maintainer when I first 
switched and they suggested that I add the From tag with the same email 
as the signoff, and I've been doing that ever since and it has been 
fine.




