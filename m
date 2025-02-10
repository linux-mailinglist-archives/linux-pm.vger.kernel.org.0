Return-Path: <linux-pm+bounces-21705-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BBA38A2F13B
	for <lists+linux-pm@lfdr.de>; Mon, 10 Feb 2025 16:17:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AB4C163417
	for <lists+linux-pm@lfdr.de>; Mon, 10 Feb 2025 15:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E85E520485F;
	Mon, 10 Feb 2025 15:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=telus.net header.i=@telus.net header.b="UtrP3crX"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DFCC1F8BD6
	for <linux-pm@vger.kernel.org>; Mon, 10 Feb 2025 15:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739200641; cv=none; b=U1B9wbLIGUBccsu6EBKUui1B7TpV4IYrkKr9mbTQYfSYAowUFUO4RRdCQZlKksRdZL1QRfGD78hglMM8tTSGpPktHtFBu0kQItAyyTXxRYSrCBRe8wD7UzzxDr3nZQqNz6cEgX6uQ8c7k+VOaNKrj0xzL0Ci+FJwUpshiAdpgNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739200641; c=relaxed/simple;
	bh=kCma50QUsdC4Z+7PRdKTZKVylhcHRlHz8yASiH0tgBM=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZioX9BDXYmV/e4XDxqJnbeZYDoWATRq07/pIkHEAszttZwpmFjMXwHL3exJnRiD/cmZPRwmWrM5Trob2iTKuR6o8HJRkkw0QKtmyOvHx4sgeJ113cQZFnb/D9qJmVgO5l/EEQWeaP9E0UWieiMsEh/ttCofwXv3WqavWz+PmRk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telus.net; spf=pass smtp.mailfrom=telus.net; dkim=pass (2048-bit key) header.d=telus.net header.i=@telus.net header.b=UtrP3crX; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telus.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telus.net
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-21f49bd087cso57733235ad.0
        for <linux-pm@vger.kernel.org>; Mon, 10 Feb 2025 07:17:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=telus.net; s=google; t=1739200639; x=1739805439; darn=vger.kernel.org;
        h=thread-index:content-language:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=kCma50QUsdC4Z+7PRdKTZKVylhcHRlHz8yASiH0tgBM=;
        b=UtrP3crX8v8F0fOqA/1q8B4kZfTyg61yBWedjuUJc5nAMTvDRjXRV4o2vcAGQU+zhK
         Iirzbqa+NnkE5eUqAFrd4Wa+Vdt2QksO4q5nn6V81fkA5RIBuYXxAvDMewLhdTqVpa+N
         K3Nw53x4C03Tc1k1pLtVTJF8AqY8sJptcwQHMvMA5rPoOayu7Y/3kEajs/2XETHpfdnt
         kNfq/EVskdQKEvfbkVgh4lFfAWDjhBmjivwc52AWE08dVFNDyCYpMUtog+SyQ6d7YL8P
         Ryu3uKHjYoz5E3PocrEwZYig9YFk0DZttMKROPB6LwqKTqQqyA9qr5AoOwn98M4n1xTh
         BOGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739200639; x=1739805439;
        h=thread-index:content-language:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kCma50QUsdC4Z+7PRdKTZKVylhcHRlHz8yASiH0tgBM=;
        b=UVGjMVKgfz5iTlkM2pkGzdDJC9FBZpLctA1QwU6owYjEigNaX6IsaNRbOgGqHdV3KL
         SLRwG1hTEB/tz2zf+30z7BBRxxozrjkmffLXQFn5KmKSZoI1947cV3l6+tB5/G6haqft
         EUfQccGiYChxn2ySAOXVNbSldBHFuFULFgKNNdClub1JWwB07wkDaJWcrlrNKIec3sux
         47TaiiUeUS1feiRSxin7XIY3P5Ui87WGN/hQ7c50VuFLeoPA8LqclnRgpcYGlbx2qx61
         1XVkhHKBHSZ2jLGDma2oBV/RfHyJ6Ht0yZVjvMPqYXDHO/Izveb5WQD9A3mv6a2Ax28v
         c0kw==
X-Forwarded-Encrypted: i=1; AJvYcCXntdSdEXjTxGfwtdVBLFuGEC25LSYt5qZo2ZkjV0vXvciFwhgs0wHdFiAEn+rwX6Xlg14ytA67Gg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxMoUDIfrnXCV5g8vTjRi4TjQjp/YqcZ+SR8m3ZJIo76IaVEEsE
	A7hLXHtvbMz4UeICT4C22Hljhzy1J7Jvcg613KJDsj6HhQi11A26ydY0KbkPnxw=
X-Gm-Gg: ASbGncvID7YY3OZRPtS5fgJc0r+acSiwTepHoIZAVuzH8Ta/AmOA1QtD5HSQh3dYZ3Y
	ZJ3RJBqJM0DBffkDzNKPQcdjgcWv2D0O0iQxO77MkwLMOrOB9CJsvHnitzJHZpo455QYQ4mNmQt
	JEouvQ3awoPiFjlb6b26OxTnOSXYwPQovO+e1+Am1LXmd3ShoQYTB7XzX4A4Zw49OErzD82VwY6
	y394BuQdnKpHC8r2iFDIrweAph7nRT9MUmSwlD2WxFm++mNW62rhcIg+imiW9HblCo7FljaycH3
	WFWtvhcJ+ZtcZhqFdXRr6jycx9cduXy2qfEE1C5zKc/KuD3eg8NQOist
X-Google-Smtp-Source: AGHT+IGM38SlV4apgcWTD0J0vajemft61BNy0oB1qbcT4m94yhT137ZWkkqA/se21tSBV5kyQFSIZA==
X-Received: by 2002:a05:6a21:9211:b0:1e8:a374:ced7 with SMTP id adf61e73a8af0-1ee03a5b269mr25573812637.23.1739200639608;
        Mon, 10 Feb 2025 07:17:19 -0800 (PST)
Received: from DougS18 (s66-183-142-209.bc.hsia.telus.net. [66.183.142.209])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ad51aecf47asm6624275a12.31.2025.02.10.07.17.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Feb 2025 07:17:19 -0800 (PST)
From: "Doug Smythies" <dsmythies@telus.net>
To: "'Artem Bityutskiy'" <artem.bityutskiy@linux.intel.com>
Cc: "'LKML'" <linux-kernel@vger.kernel.org>,
	"'Daniel Lezcano'" <daniel.lezcano@linaro.org>,
	"'Christian Loehle'" <christian.loehle@arm.com>,
	"'Aboorva Devarajan'" <aboorvad@linux.ibm.com>,
	"'Linux PM'" <linux-pm@vger.kernel.org>,
	"'Rafael J. Wysocki'" <rjw@rjwysocki.net>,
	"Doug Smythies" <dsmythies@telus.net>
References: <12630185.O9o76ZdvQC@rjwysocki.net>	 <009d01db79b9$aecd1c70$0c675550$@telus.net> <38fadf14318be8f3c622719cc526f7586657e0e2.camel@linux.intel.com>
In-Reply-To: <38fadf14318be8f3c622719cc526f7586657e0e2.camel@linux.intel.com>
Subject: RE: [RFT][PATCH v1] cpuidle: teo: Avoid selecting deepest idle state over-eagerly
Date: Mon, 10 Feb 2025 07:17:20 -0800
Message-ID: <000d01db7bce$e145f7a0$a3d1e6e0$@telus.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQLC2T+pvcOY0U2G0e8FLXneTSytVAF1rbSKAhISofqxVan3AA==

Hi Artem,

On 2025.02.09 01:15 : Artem Bityutskiy wrote:
> On Fri, 2025-02-07 at 15:40 -0800, Doug Smythies wrote:
>> I have only just started testing the recent idle governor changes,
>> and have not gotten very far yet.
>
> Hi Dough,
>
> there is the menu governor patch too. While it helps the server, I did not test
> it on a client system. May be you would to check it too? Subject is:
>
> [RFT][PATCH v1 0/5] cpuidle: menu: Avoid discarding useful information when processing recent idle intervals

Yes, I have included that patch set in my kernel 6.14-rc1 plus patches under test.
Other than the idle data, I don't have any other data to present yet as I have been
acquiring baseline data.



