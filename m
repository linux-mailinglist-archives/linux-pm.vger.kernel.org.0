Return-Path: <linux-pm+bounces-312-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A2867FAC49
	for <lists+linux-pm@lfdr.de>; Mon, 27 Nov 2023 22:09:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAAA31C20DB0
	for <lists+linux-pm@lfdr.de>; Mon, 27 Nov 2023 21:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12D773FB04;
	Mon, 27 Nov 2023 21:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hipEVxjp"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47881D59
	for <linux-pm@vger.kernel.org>; Mon, 27 Nov 2023 13:09:18 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id e9e14a558f8ab-35cd93add9fso1618265ab.0
        for <linux-pm@vger.kernel.org>; Mon, 27 Nov 2023 13:09:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1701119357; x=1701724157; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KSTA5AxGidSyTaTLg4RSb2BlNCyrBOixWgjNXj4yZ5I=;
        b=hipEVxjpW8Zu4xcO9ZQhNa7vPJQI6D/hEAcqCnkJEf2W3jm/I7CRSHFXvKtiulIrmX
         oNEVVA9nvFaLVh+Yb4NlI9XxnFUxDG5eEfYAVntuwbhURlTEC7+5H0WaSIoARmvN00iA
         k899Ft6gnyocbIX6c1mboD7E/T2/tG5gGEATc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701119357; x=1701724157;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KSTA5AxGidSyTaTLg4RSb2BlNCyrBOixWgjNXj4yZ5I=;
        b=TsV3WZUn5hx7/MI+f7QXKeuSn8COKDtE7nOIaflgZl3NdwnMVR78P+GNhgI6Ur3rdh
         TG+gus2fNj16W9yvj5vmvqLFiUpyHoF4CP/ZlgfEdJ/6f6cPCXvgtji8jeB+FwGxdQp2
         8qOJi15q5g1F5GyRBv8mKbNiuXAiuebKKoAQND1nDYQF09HfGL9yuGteIAbgI096Yp/+
         IkaIthwgcK78IhKDfK2wGBP3EoB1vJIzI6gUHsy7ZohrL8FEidGkjcSs+3B5FgRwoxl7
         4CVVfGX/odKQ4rffrUxQuFOLleQvVcbbHJrrgmRxYiVkHf2Yc4bJVqxszPNU7evaS7fp
         CHcw==
X-Gm-Message-State: AOJu0Ywr/ooBBe8o+24LNBYxwQvdPiIoYXPEBQOPdhuE9ULRd+JIFNqK
	A6vRXDTuIZx0VpkJOKTpISY86w==
X-Google-Smtp-Source: AGHT+IEDfv//1mMXVgo9PqXe+/pr1A5gpV6QqcsMlT5ROeF3Ctnhg1wy+WAJgRG0QNmfDlm+EQnbgg==
X-Received: by 2002:a05:6602:2e0f:b0:792:6068:dcc8 with SMTP id o15-20020a0566022e0f00b007926068dcc8mr16208973iow.2.1701119357620;
        Mon, 27 Nov 2023 13:09:17 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id b20-20020a05663801b400b00463f8b3e34asm2613346jaq.23.2023.11.27.13.09.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Nov 2023 13:09:17 -0800 (PST)
Message-ID: <42bcba90-f32a-4b99-a68d-b4e8e37c202c@linuxfoundation.org>
Date: Mon, 27 Nov 2023 14:09:16 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tools cpupower bench: Override CFLAGS assignments
Content-Language: en-US
To: Stanley Chan <schan@cloudflare.com>, linux-pm@vger.kernel.org
Cc: kernel-team <kernel-team@cloudflare.com>,
 Thomas Renninger <trenn@suse.com>, Shuah Khan <shuah@kernel.org>,
 linux-kernel@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20231124185042.315148-1-schan@cloudflare.com>
 <CX79UGJ80EBU.34DF47O8X8C7V@cloudflare.com>
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <CX79UGJ80EBU.34DF47O8X8C7V@cloudflare.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/24/23 11:59, Stanley Chan wrote:
> Apologies, this is my first patch so I'm still learning.
> Meant to add
> 
> Fixes: dbc4ca339c8d ("tools cpupower: Override CFLAGS assignments")
> 


Thank you for the fix. Please send me v2 with this fixes tag.

thanks,
-- Shuah



