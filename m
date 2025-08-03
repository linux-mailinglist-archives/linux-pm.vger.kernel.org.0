Return-Path: <linux-pm+bounces-31784-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BAF4B1951D
	for <lists+linux-pm@lfdr.de>; Sun,  3 Aug 2025 22:18:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18CE53B036F
	for <lists+linux-pm@lfdr.de>; Sun,  3 Aug 2025 20:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF69A1A5B96;
	Sun,  3 Aug 2025 20:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R+hlY2g/"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18837EEA6
	for <linux-pm@vger.kernel.org>; Sun,  3 Aug 2025 20:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754252319; cv=none; b=EcquI3qfVhc5xRy1OwQ8HH/Yz1p7ZkmlJF6/FWQN+gQ8KeOURqMUIspaK15ejrBLGDkfy/ArCnZI+Tc88KtbEzyy7NuILgawFuTEHqQsndALC4gqvw4f47riBl4X+YRzIZnavShahkj8g2MQ28yUqNCxJBJoehSdR3eq/ign/54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754252319; c=relaxed/simple;
	bh=QOEAcBtrfRafs6vp8nz/RiTdmOyjjy8Y25VFwosOnMQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=mcrO2Dsgry4Q65c1y4YLkcnFiFNJNMpyzCH/aPm2iISMKwEhAlMC5/XViVOLE7+8ZcrgeNssuie2cPPhNZEjwqtMjzjlnLPbayG46Me4R2FrDHeJLrG1IObwMQpoXB8F0mz/cKAdYC7gXBWVZfzGIyWVZxZfmwok57pGqk1xe0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=R+hlY2g/; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3b780bdda21so2367984f8f.3
        for <linux-pm@vger.kernel.org>; Sun, 03 Aug 2025 13:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754252315; x=1754857115; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=p8Ldfg1yXLqsI7Y/fnoVgRN/Mv2JPH1VgUlBd91onxw=;
        b=R+hlY2g/ithzvgG3Rxx6UAjgb9oHGHElHqqC5MsdAxEQFEwImms+rk/BctSLRVYwq/
         WFHSzD/J0bu99+gZTNiQD1+SonBxhOeVDESRzzBRndT8ZGqWC368zhvVYvMDIPapGnwz
         ShPoms0VH9N/iISG9kRG8wMJApaWQ3/TsolhFcGX4rR+CbvJxIW/FBrIQqFhjKbXILn/
         8Wb0DNyAvfQshcKRTl3gqQ6OmCIk5jbspa2U1Nv7x1svfk9yJeJg/1VjcwceAaN+NExV
         rqBqzwL4UFSWSc1GC2WLrTvh9UqtoBUXfFHqrSjRyLtERr2xUv3mevoj5INLD/fHNw5m
         mTvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754252315; x=1754857115;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p8Ldfg1yXLqsI7Y/fnoVgRN/Mv2JPH1VgUlBd91onxw=;
        b=F0ATQcMe5KJKnGD5u8zsIr41gKte7Pua+6vgRY1yFJjc9W4QNAFG3dX2wcVG8uT+2w
         e0blZqRBfDGuIYbcdsmY3EK6U+432a/rA65xjX3bMrMZngPx7VrOMry9lwQavWAQc6+w
         LyqiSKxuWGzpcgAKEWWC6qt5tZjK75K4uvC/YQVIELTZtLUMwmbeSCljY55K9i/h4Glf
         JA2PEs1g97x2+raXqMtRupN4aVMcKJ+LIFtzVkfUg7Rm977U3bmnBrHCgEEfCTjkZ/D5
         NaRznj+qhWqfdLIlObXYxLx9DQz86Id03TvviJ+kAvTfpavihWBzAywWuStpLmQoZ10P
         8QRA==
X-Forwarded-Encrypted: i=1; AJvYcCXfiMa4DRqedceA+fPWVmNqbqWGsbeF6I8YyBeYHxeHp6SorlDi/2rmOhcSx3ePBSCbr2VnrLQGsQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwUjkt4eCHDV04GXVtgJ2C84BH5YT1q/vgW1r+EOPMcIHa8GuQG
	2MD769sML7PED3kMiX71Bu9OkXeivBbZWR6O9I7sd/ZBZH8u/zCCE/rdLZetN3nfr2UOH2DQh3v
	9fPBX
X-Gm-Gg: ASbGncuXqZFEtk6vZkLLG0rXmpvyXqAlIrRRlpIT9utJ+BxaWdE8InbjhhNtrkT2nVn
	XNHq1I7EdiehGBep7QgSqwH/VSJTABTi4AUm5CbsLrS6+MZU38v0eMffFKwjGQUNhNi9oD8LYd4
	+DoOrjHMiQY0YEfke+oiMGCpe9iVH0kAD58I6GHlAkLhr3F98Gxv+S8an7I9nAyTcrpNJ8fDBBy
	3LOQAi5OqX932t8P9iQkWTxO5X6aklT2y+bbARbFuiZ1IeJXfKSnQHVoFAq1AMPgqY9gm/6L3V7
	MFnYK0iLu1Rr6JX8RB1DrxPn2LHOIPwN6qQR0+lIWcRlP43McXwLF4n0zz3i3fKeYD+8BNiETb4
	bDH1styzY6wsmOO1za7KeXxjyAEiYwuGUhrjANusL3Yp45/A+XkItxdVvskXcpSsmKJTjfbHT
X-Google-Smtp-Source: AGHT+IGFg+rnxQh2u3+Vzhcj0IZEkOuK4dCfFbAIDdxhxDUaszYW/W/XYYmlQA7wcv+sOSdGnIulEQ==
X-Received: by 2002:a05:6000:2882:b0:3b7:73b5:e96d with SMTP id ffacd0b85a97d-3b8d9470335mr4542960f8f.15.1754252315166;
        Sun, 03 Aug 2025 13:18:35 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-458953f886dsm191586805e9.30.2025.08.03.13.18.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Aug 2025 13:18:34 -0700 (PDT)
Message-ID: <a61eb3d7-b06a-43ae-b373-d35db316d61c@linaro.org>
Date: Sun, 3 Aug 2025 22:18:33 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Possible bug]: thermal and an scaling governor issues
To: Marcos Dione <mdione@grulic.org.ar>, linux-pm@vger.kernel.org
References: <aI8oab68UiW1KNQN@ioniq>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <aI8oab68UiW1KNQN@ioniq>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 03/08/2025 11:14, Marcos Dione wrote:
> On Sun, Aug 03, 2025 at 10:55:45AM +0200, Marcos Dione wrote:
>>      Before anything, please CC: me, as I'm not subscribed to the list.
> 
>      This is no longer the case, I'm subscribed now.
> 
> 
>      Another data point: CPU freq goes back to normal, when my
> compilation stops (last night before 2AM), but goes back down when I
> launch it again this morning (at around 10:30):
> 
> https://i.imgur.com/l0yZYCQ.png

IIUC, it is a laptop.

There can be a couple of things. The difficult part is the firmware can 
do actions under the hood, the userspace may change the governors 
depending on the temperature and the kernel can do something else.

I suggest to investigate first the temperature sensor for the skin (or 
case) and the battery. What are their temperature when you compile ?

Given the policy on laptops is to protect the user first if the 
skin/case temp is above 43°C, then an action is done and that can result 
on limiting the processors.



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

