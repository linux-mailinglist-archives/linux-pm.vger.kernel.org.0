Return-Path: <linux-pm+bounces-32765-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B27B9B2EDAA
	for <lists+linux-pm@lfdr.de>; Thu, 21 Aug 2025 07:45:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 971D35E5C40
	for <lists+linux-pm@lfdr.de>; Thu, 21 Aug 2025 05:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 195B43B7A8;
	Thu, 21 Aug 2025 05:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PsZSD2pf"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E072033A;
	Thu, 21 Aug 2025 05:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755755137; cv=none; b=aJ08hFdMRFb5LGjibeL4v2q+tWA6qHfW3+Gh3aM2sJgJwLVtUi38bjJBy3ZCYGsLe5RVXpOCHBJd9looLQ8pjxoOb2ofmYMc92cq4zXuZRGzG4kddJjcyzZUv6qP4I1fzvWOhZa9VEC/ai6I6QEbmIif9gR93BLAnDOiimlLCos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755755137; c=relaxed/simple;
	bh=A316l42WClYdU7b9+fU3F/BhCFakyHSSAEZ/6IkkBrc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uYUimhYwaRqR/HvtfclzC78mDGJ03EGZdeFiAwOiQqzMLjLwhzyga1xHCGdzeBvKx4S2N8q5YZ7DTApN/43q6tOrRZGkxlbiHOyz0xhmU0PxODVw/HIupLoOHkadufr/LBvDhvzgBU6JsfBsTGAM6zccAfVQ++1L66Ys5pHIr08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PsZSD2pf; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-55ce521f77bso606086e87.1;
        Wed, 20 Aug 2025 22:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755755132; x=1756359932; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QAEY05ivGvZt2ms8BZqpnAsoFvUaGMN1AinnVH4LWCc=;
        b=PsZSD2pfgdD6HSRdsjggLJIn9O9cSgs4VrVkGYUsgiKNJ7/U26p/0BryR4x72ZGwy5
         dzHzPC6GDQwsfGvJtd8V7F1CMHwi4fZpKSSp6ffSmtHM1syY4ddLWPwAsoUAqckJoLER
         rq9c9KvjjrqdHLIkj9sIK8GJnjGfxG4MBkSVTPce3lgkunnTLkzEQqrL9AQfwwaq0lOf
         EXPd1Wvh+Fo4FRlnUrRfwz5vZBwwJ3hxzJ5LQllLPS6ZBHBxTFpoNNVVoOUlxtSnaM1y
         tRZvgUJr8GvxahyyK5BZrIky68H/XrrxFLI4zh39Pg1dtMwHxbYN1qKJmHCB3EchQYKL
         EP0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755755132; x=1756359932;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QAEY05ivGvZt2ms8BZqpnAsoFvUaGMN1AinnVH4LWCc=;
        b=koZX7XiSzcZTWVZ9rsSkol8N0ul69Uf5um45r1oSX3b6ixMU8SnO15YId0xkEYvUkA
         PvQqdsR5LwASwWv7tKQ5fqZcbsoWvcHKlFS5ymjfEcB8JYTaJZyRopLSQOT/3VGBBJnA
         bKjFs5o2VLFv6X9ohL69miGcDasCQm7a5t6+osq+JsMShnsBffG6EAf15PHIWxEAKs75
         +Dm2z0YLaZKi94ogemc/6S68qZ3NPWT5FDBwbvP8v3t4uBu+JMleehqWQokXJ1Kbh4IX
         +XVkd/Z2Se1c4g1PxT+Bcf8CCTQMWVuLnnBTMR9Gntn5L08PeWMSBbcp5BwXAwrDJ4br
         qjSQ==
X-Forwarded-Encrypted: i=1; AJvYcCVmyOt5b483oZ7k3s9CFpeagNdsaWZo5aUWdqFnxU4JbmrmwzWDi6p9gkV5bXVuXYNKr9VWu0bZWw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxBuW0w54M4De/bPaCTnF01DZBrZn8gVMBHlO15pT/Fe5/ZsA2o
	J6r8Q/wvoBqffaAfNwKjGqJYWUwdg/MPMrMPd7l2Ijpm2qlPGZ3+3JhyjXn6sQ==
X-Gm-Gg: ASbGncsob7Rc8lwq6Xx8lIIhXo3hP5z8MxqkVzEt/VTM3WlahNLbYoJHEEbzjH1zioS
	By6s3m2wCDXg1MMNWhiPIhi1YYNg5fdIF7W7S4KMVLPlDMo9PihrD0ouAbhJ/oNT6yYRoA+fzji
	HDyoPtNYk3BGd/We6UoYlCvZx1swbcECAMag1j91FoCdVtNKLkvEyYMMxpNKrYBXGG96/+BKBFQ
	uadxkvYddj0RFtDqdJfcP2NnjG1FHjXmcijNfsUAN2tUZwna9LD0ab/xnT/yNPQ3G8DRS8hurj8
	BuC2fWvGVxX85kZ14IpNeWFld9f/6dWmT66pZ14k/K/jRf3GKthnCe3PfsLBnJeGhVKp2rSP3jS
	hUSZae2SeP8PAoUOiE3reDUukspGNHY28KaATg/1MSuKSfFynIVybvsjoWhSi4Cd4Kxq4fVYaSm
	zNzyk=
X-Google-Smtp-Source: AGHT+IHmsM/wEA8KgNudS4wI/a62xtamEiy+/oq0md9WP707N+2fwb6jNmp23bUjVNmllVWpb7nkTQ==
X-Received: by 2002:a05:6512:6303:b0:55b:746a:d164 with SMTP id 2adb3069b0e04-55e0d566570mr378424e87.35.1755755132127;
        Wed, 20 Aug 2025 22:45:32 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55cef369a73sm2895897e87.65.2025.08.20.22.45.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Aug 2025 22:45:31 -0700 (PDT)
Message-ID: <ca0845d5-baf7-41ab-8f4b-ff2ae731c1f1@gmail.com>
Date: Thu, 21 Aug 2025 08:45:30 +0300
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] mfd: bd71828, bd71815 prepare for power-supply
 support
To: Andreas Kemnade <andreas@kemnade.info>, Lee Jones <lee@kernel.org>,
 Sebastian Reichel <sre@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 Krzysztof Kozlowski <krzk@kernel.org>
References: <20250820-bd71828-charger-v2-0-32fc96027e92@kemnade.info>
 <20250820-bd71828-charger-v2-1-32fc96027e92@kemnade.info>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20250820-bd71828-charger-v2-1-32fc96027e92@kemnade.info>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20/08/2025 23:21, Andreas Kemnade wrote:
> From: Matti Vaittinen <mazziesaccount@gmail.com>
> 
> Add core support for ROHM BD718(15/28/78) PMIC's charger blocks.
> 
> Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>

It's a bit strange to ack something that I've originally written - but 
this looks Ok to me ^_^; This commit does actually do a bit more than 
commit message says. It renames some IRQ entries, and also fixes one of 
those:

  	DEFINE_RES_IRQ_NAMED(BD71815_INT_VSYS_MON_RES, "bd71815-vsys-mon-res"),
-	DEFINE_RES_IRQ_NAMED(BD71815_INT_VSYS_MON_RES, "bd71815-vsys-mon-det"),
+	DEFINE_RES_IRQ_NAMED(BD71815_INT_VSYS_MON_DET, "bd71815-vsys-mon-det")

(there was two 'BD71815_INT_VSYS_MON_RES')

but I don't really care because these IRQs have been unused before this 
series. If someone else cares, and if you need to modify this - feel 
free to either use the co-developed-by tag or just introduce this as 
your own commit - (you're the one doing this work now and I am fine with 
it). It's just super cool that my work with this has not been 100% futile ;)

Yours,
	-- Matti

