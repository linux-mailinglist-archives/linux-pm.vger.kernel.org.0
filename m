Return-Path: <linux-pm+bounces-32526-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B33BB29EDD
	for <lists+linux-pm@lfdr.de>; Mon, 18 Aug 2025 12:09:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 702262A1DD8
	for <lists+linux-pm@lfdr.de>; Mon, 18 Aug 2025 10:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B8BD310772;
	Mon, 18 Aug 2025 10:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hCPaAp1Z"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 835E7310768;
	Mon, 18 Aug 2025 10:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755511760; cv=none; b=SrEWEpGyeZ/3SMN5tPPhQBi0SUQuY2G7G7q89xER26gQ/jI0ViHb5VTBl/aeY/8BWAYrGooBm0GUX7C7M8PQ+yVS0YU35batNxarhUkgA/UtuhRkZihoImW24gWca3tdh1XXYchLKnwUEpzCaeLE7NUuvELmQ2zjULsltplmVv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755511760; c=relaxed/simple;
	bh=YTYTunFUE60jN+Q1wTGeRv0B7ez8k59yq7g+XQCx3Zc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aBsdiP3AuVpQASdSfRkxrhEHJsA8CKLr60tpeCvk0rt0bZeGTzyrMA7fErKW95skDtotIzmmgvSlCh9/1UGyZYH/ghxsMHG5mwU+FNxLxesUvKGvDC3usGQth5YG5jsGyF7dfK2NlS32Z0bJAaPjjAoL0TS53uuBL0rf83yOvdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hCPaAp1Z; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-55ce510b4ceso4532423e87.1;
        Mon, 18 Aug 2025 03:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755511755; x=1756116555; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FBdYlT7O+hJ5Ch3mWP5IIcE7+XCmcmEMEIQ8cDdUvbM=;
        b=hCPaAp1Zm2bhW9z3D848uyFER96S/8614TsR1JXHhmJvgJNZtXJFjbMGmVy+vFNnlM
         UYvbuZiUeAkA/0WxBmU5BNSbEZoHLTWQ3mYX8vxtBUotlOmP+mihPO6ruBjCbwzKENVp
         8gB8HktCNqsWqnVEY7VaSKlSX4TKBk0eP/dZPTkgkR2puemLVYow2UqwVibm5Di+kq2t
         xOOarerMgDCCSts9tmG3WgwVExgBH5WJO+2XqlRe0tivt4bWyt4EnxnxUrtG2tCXlimX
         jksHazRdw3I/YbMNH6UeApKG8s88hRAY0JoviGiLtYDMGSCAopTbeDqxF3Lz6Ij9IioP
         hYBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755511755; x=1756116555;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FBdYlT7O+hJ5Ch3mWP5IIcE7+XCmcmEMEIQ8cDdUvbM=;
        b=kzzxjVFky3efsH+BKP2VSEr6MH1UjMaVP549x8ikBbSaH2UD6phwhNpgyldEUevSg/
         PkcQwx+COHyFuweGc2ihRcvV2U69VPOO+xTHsDAPh4qfoSU/RSMFz6J497c0M6qP0uhd
         glF1i90yr0mF/0VqU7lKRZh6PAuESLyEbwikHfirLedNHEmAduFZqRAfRGBrzs7AFnrR
         7D7OimnRi+XUHILxE2q3BbBjnGNXEjZJcmLSsqQbVNqhQRPvkpfUElO666P/Maj2dLmJ
         LDNKC+DbGMfzI6M/w07CIgyuQAQXQ4fRgfKxX30BYrMHVdU+XU4vD7AraHll1Xz/KJ8I
         VJJA==
X-Forwarded-Encrypted: i=1; AJvYcCUiWXbUXqxMLsTChJf0MbWBSpuYzzzU/94VgIUdmeiok5PRjUyFGCXI0OdeFiUfAaCUD9Z1bBw2UvkVeXM=@vger.kernel.org, AJvYcCXk3KhqMQn8l4b1Hrj0codgIgPKB5/is2mEGrspxb9nliZM5m+KVRCfjsD7Qsq9exjAPAkQyCdAtHI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmHakmx59sNam/Lk5p5JZkyjjLy5mo4ohrKZQNuZE4VSirIxvX
	C1inu8jhYvwT7LV831atUrhdDo7PT1zaZvfWiWk6j94jAGJU0fjn6/NZoLYMlw==
X-Gm-Gg: ASbGncuY95DBZuUirFlGsooi156ReBpvRe2N+BXWlOvuynPbPnC/rQBB19CmHlkphYe
	V51v7po/8X1aI4yMWgmEmuQu/wiif3tujBKqfmnoDvMAHdVWnucoFvWQiiBka19Ai5eFgQH+HUk
	bTK7SsGSoseY3NKCtSDaPVH5SsRGFczxdjKZakONvZ2qsohk1PZH8dBvJqu65pZWsiUbFJAYtWc
	LZz3AIwhe9WOTXA4QTG0UtUsgjUwypkp6letzv8EnbsVHbxHzAGZYramHdxv4xdf6G6gLXAP02a
	Wok2BHyg0L2O51Ajqjzy0IxZN6gYV8hnCmEi+A4VVhMlJ04RCWIhEtNlD7MNtPORMkgeJf51Yp2
	4BxcjI6lC6OgavdCCE1E2Sf0pq76P35A0kr0sD5luLACqGiyn7XIGXKvi4ZWIRi3/8VavhLjNPn
	aypS2uSi1fMnBP1Q==
X-Google-Smtp-Source: AGHT+IFinQuHZszSZxKOZIdPFJsBcuYolBD7tuJvb50efI6zUzShZoUUTTKiSFdOsuH6T6noy7UP9Q==
X-Received: by 2002:a05:6512:244c:b0:55c:e6a6:e694 with SMTP id 2adb3069b0e04-55cf2ce5481mr1552335e87.54.1755511754417;
        Mon, 18 Aug 2025 03:09:14 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55cef368d34sm1593570e87.58.2025.08.18.03.09.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Aug 2025 03:09:13 -0700 (PDT)
Message-ID: <53198209-ff95-407d-89e9-11cc34b04b4e@gmail.com>
Date: Mon, 18 Aug 2025 13:09:12 +0300
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] power: supply: Add bd718(15/28/78) charger driver
To: Andreas Kemnade <andreas@kemnade.info>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Lee Jones <lee@kernel.org>,
 Sebastian Reichel <sre@kernel.org>, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org
References: <20250816-bd71828-charger-v1-0-71b11bde5c73@kemnade.info>
 <20250816-bd71828-charger-v1-2-71b11bde5c73@kemnade.info>
 <bf82cd81-bcc7-4929-aa84-b749533d5b95@kernel.org>
 <20250817101121.19a86716@akair>
 <bbd17f22-8834-42d8-a109-971bdd2e0fa1@kernel.org>
 <e8955365-73c0-4c7a-a579-0ee6940340b2@gmail.com>
 <20250818103600.0c3a015d@akair>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20250818103600.0c3a015d@akair>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18/08/2025 11:36, Andreas Kemnade wrote:
> Hi Matti,
> 
> Am Mon, 18 Aug 2025 09:34:02 +0300
> schrieb Matti Vaittinen <mazziesaccount@gmail.com>:
> 
>> On 17/08/2025 11:13, Krzysztof Kozlowski wrote:
>>> On 17/08/2025 10:11, Andreas Kemnade wrote:
>>>> Am Sun, 17 Aug 2025 07:58:35 +0200
>>>> schrieb Krzysztof Kozlowski <krzk@kernel.org>:
>>>>   
>>>>> On 16/08/2025 21:19, Andreas Kemnade wrote:

> Newest rebase I have is for 6.15. Yes, capacity calculation is hard.

Just a thing to note. I've drafted some support for another variant, on 
top of the v6.6. Just pushed the latest version of that to:

https://github.com/M-Vaittinen/linux/tree/bd72720-on-6.6-rohmpower

It may have something useful for you (or then it doesn't). Following 
could perhaps be checked:

8c00ee888283 ("regulator: bd71828: Use platform device id")
0ba48e3a48d4 ("mfd: bd71828: Add IPRE register")
f6caf815fc2f ("power: supply: bd71828: Support setting trickle charge 
current")
56197c1819e5 ("dt-bindings: Add trickle-charge upper limit")
af7500d7f278 ("mfd: bd71828: Definition for fast charge term current 
register")
98401932fb75 ("mfd: bd71815: Add EXTMOS_EN mask")
e508c94159d8 ("mfd: bd71828: Add charge profile control masks")

e751bf502e29 ("power: supply: bd71828: Support setting charging profiles")
AND
b84792488191 ("power: supply: bd71827-power: Fix pre- and trickle charge 
currents")

2f952952cecd ("power: supply: bd71827-charger: Fix print")


These hopefully are already done:
c4fe777755ef ("power: supply: bd71828: Fix Rsense resistor value")
34d9261706b2 ("dt-bindings: mfd: bd71828: Fix sense resistor values")


Rest may be just noise related to this new IC.

Yours,
	-- Matti


