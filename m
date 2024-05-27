Return-Path: <linux-pm+bounces-8140-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD5618CFBA7
	for <lists+linux-pm@lfdr.de>; Mon, 27 May 2024 10:38:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7799C282370
	for <lists+linux-pm@lfdr.de>; Mon, 27 May 2024 08:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 172B96A347;
	Mon, 27 May 2024 08:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ygOrnlg/"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E81D06A008
	for <linux-pm@vger.kernel.org>; Mon, 27 May 2024 08:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716799087; cv=none; b=pNA8YBrHCrITSAfvcU6LzgBHEHyG5pf5qFlo9hXRV5a619G2b6d8CnHwysr3A/xa5szZpRnvqyNE3un3+S7y+uKHItxdcpV/4J5Td1eg6t5wKH/OUGAAeY6/fGP4BrZMxqiBzfwalcXWzIaQmq4FcXk1TDxnDZcVwwd8NeyAdx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716799087; c=relaxed/simple;
	bh=7yJQzgp3LG9+SqLWr6zTQsXw6qv741M/Rp6MjNbH1tc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NSZLAz/7f77XpR5ikJ1nHssfJldOdMVqJjwHHsEUVipS56PPCccQ9Mgk8q7MZvPZctVG2/rAejO9IFc7MXKKt/VZCXtUxDr1VWrd3qRdyiFgk3p3e3hCUELHZUuloprsll956qQJvfRqZrk+wS19NdBELIw1EZIXBklgqUogpwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ygOrnlg/; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5766cd9ca1bso9929384a12.0
        for <linux-pm@vger.kernel.org>; Mon, 27 May 2024 01:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1716799083; x=1717403883; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7yJQzgp3LG9+SqLWr6zTQsXw6qv741M/Rp6MjNbH1tc=;
        b=ygOrnlg/T+50NS9L89ky3Bw5jBJqx77BBWHt98h4qwwkEpr8fwK+hQqoIKEVnkDZ+b
         hnp2lnCeu8M67lv6XxKfnjPewWRjvLruDfYOPOvK7bbBkt9bKocWfTXpxdXFBvvU0EAt
         1rRUicVXicHzf4CFc430InIrq/FUhyNRFChARQLcEMxuU9eGgydRhj9CLriz0JOGXzv9
         xFUlesZmvkSPxZD2AO4V3sWc+W/hBcQtBt9739YDQqW0tCVY+1qazgAxsrSON7XMbXnb
         xztBVavKgfSdnanPSsMh3yDzraNsxOTGjStY/MeMFWIFU6bGl6YFcOAnRWnMqigGUhU2
         99mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716799083; x=1717403883;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7yJQzgp3LG9+SqLWr6zTQsXw6qv741M/Rp6MjNbH1tc=;
        b=xJbHEEkCEWzbH4kj6gWG2Ud9T9o/zJ7kIIXO/NN84UyjUzx5gl2eLGe2q57EvT8kvn
         sdPG6BN924U6+D8Lpp7YHF1elcdnl7C9HnrbS9PD/32Dlng6AsidBpQ4rj3644QyaUZx
         luz0oqPffc/ObWrVm6AMZpBf37yFDgvT4ss5vsH/Bib2XjEesqOqwpAQZXCmSDnSnB3Q
         kI+d/0FvYGobmt1k5ODAnrzX6LyOkkUjXcYl2euw86GGnJSDxKfkoo+hxf+E0KVV3zJc
         IVCQ/UOFxpjo6iHz6imvqTLVMU1QFv22gZeXTF4g5rThc4S7XGIz6wHd0UV0NV2KpqMs
         4gTg==
X-Forwarded-Encrypted: i=1; AJvYcCUSVyEWArlV/caTcSs2ECy/LWkL3cB4OLWFFAgnXDHe3sYmJ8xsQ2vUW4TTekzrEynWJa9jPuQ3ThbQhaFGBWM5WzVDr69v/cY=
X-Gm-Message-State: AOJu0Yx7Hb59rcGiAOHLGK72QVg8iZHCJr4imWOBq0k3d49yTry6SydA
	FnhiHTJa76sUqp2xPkNrBmKIMs+jj0i4e3NVB/9QXeKDpCUAqa/8V6NLGCNH0hE=
X-Google-Smtp-Source: AGHT+IH/iXqC+L+EflTfnXDHtTdQkCcD9jw5SHF9Siu1D6pQ5lqCI6PA/ta8ZY/9nEeZbep4X6uIoQ==
X-Received: by 2002:a50:cb8c:0:b0:579:c4cd:735d with SMTP id 4fb4d7f45d1cf-579c4cd75d9mr2691205a12.11.1716799083189;
        Mon, 27 May 2024 01:38:03 -0700 (PDT)
Received: from [192.168.1.70] ([84.102.31.61])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5785233bb04sm5483333a12.12.2024.05.27.01.38.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 May 2024 01:38:02 -0700 (PDT)
Message-ID: <455d12a8-fefe-4593-97a9-4cbdc81b61a7@baylibre.com>
Date: Mon, 27 May 2024 10:38:00 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/6] Mediatek thermal sensor driver support for MT8186
 and MT8188
To: "Russell King (Oracle)" <linux@armlinux.org.uk>,
 Nicolas Pitre <npitre@baylibre.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org
References: <20240524-mtk-thermal-mt818x-dtsi-v5-0-56f8579820e7@baylibre.com>
 <238nnn48-0o7r-22q2-2rpo-s3n7n62pn2q4@onlyvoer.pbz>
 <ZlDMNkdE2jmFgD8B@shell.armlinux.org.uk>
Content-Language: en-US
From: Julien Panis <jpanis@baylibre.com>
In-Reply-To: <ZlDMNkdE2jmFgD8B@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/24/24 19:19, Russell King (Oracle) wrote:
> On Fri, May 24, 2024 at 01:04:38PM -0400, Nicolas Pitre wrote:
>> On Fri, 24 May 2024, Julien Panis wrote:
>>
>>> [RFC] When PATCH 1/6 and 2/6 are squashed, checkpatch raises this WARNING:
>>> "DT binding docs and includes should be a separate patch." That's why I
>>> split them in this v5. The problem is that the driver can't be compiled
>>> any more at PATCH 1/6. It needs PATCH 2/6 to be compiled. Should the
>>> checkpatch warning be ignored here ? Should I finally squash PATCH 1/6
>>> and PATCH 2/6 ?
>> IMHO it might be preferable to preserve successful compilation across
>> bisection than to appeal to checkpatch in this case.
> Or, patch 1 adds the new definitions, subsequent patches convert the
> users, and the last patch removes the old, now unused, definitions.
>

Thanks for this suggestion. I'll do something like that in next version.

