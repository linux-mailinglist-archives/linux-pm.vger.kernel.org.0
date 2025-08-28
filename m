Return-Path: <linux-pm+bounces-33212-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 666C5B39339
	for <lists+linux-pm@lfdr.de>; Thu, 28 Aug 2025 07:46:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A4531C2381E
	for <lists+linux-pm@lfdr.de>; Thu, 28 Aug 2025 05:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 687912777F7;
	Thu, 28 Aug 2025 05:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mKpWF2Co"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFCDC27702E
	for <linux-pm@vger.kernel.org>; Thu, 28 Aug 2025 05:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756359985; cv=none; b=YwJTizvYUuSUOBAcKfgmmZ7fzgxKNm9wjxsba0DBO6h3AdNmoO2AmmKCjc1hpzKnzEUdMKgJSRCbtVSQMmMe2Z7JJsmh8V2X71eE0d4xZpf4meuczW9jNmm8b9u7hdEEfrFgdZZwMQFD96C88jzlz93/DvbSwpCrWLHgB/J4Ecc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756359985; c=relaxed/simple;
	bh=i6L+f3exnFOVhxuWsM4teMlEODpI+rzw0Jw85ZTvtIA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BX3LqLHj4liJ07Fx5PXl/PNymYzr/hHLKPygBW3aKZCFd4kdUfwjdhPwgfCTL9JthoJoGqXQf9IMdrTyc3tJG8NVid0FkJsJro3YMxNUd/GDLzvNGVul5X7qOq5HcEMyP9dPmbD5rhht0x7VPhEdDptq8PaUbPvxCr4fIYb7oVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mKpWF2Co; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-771e1e64fbbso709092b3a.3
        for <linux-pm@vger.kernel.org>; Wed, 27 Aug 2025 22:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756359983; x=1756964783; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JrIDBpuM+wIKseLTnowhk8eTE9B0XZjCQe+CxB8rd+o=;
        b=mKpWF2CoXnkI2N9uVobkgXcLZ6ic154Z3QmfTByv7XWYpphf6fVaSoIlTjyWJVZS9T
         VfCCCDuxpjVU9r6AiUEKvC3qmwYxLQg1hKNzvx1OoKxyaCAsUklTw+aPZYI9KFk9/zun
         XbGgPwWHYBAdlcD09D+l6HTZfzQuhQQPCLznywGU1Rj4KtTqC2heKld0oL0zz9RYm6lY
         ENAIqTmOZfljEin2ZnqgJtF8/L7pWtp9wHpEmjj4bAyj+EMRSRTKbRsVS1gS8gVZ/D/S
         NX/W0JCbdayE8hiLSNv9zXDnM5+M1SbKb6s7F94EvUTFv+MY8qVJoGndBnl8mKSD6FkF
         HHmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756359983; x=1756964783;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JrIDBpuM+wIKseLTnowhk8eTE9B0XZjCQe+CxB8rd+o=;
        b=tnBo4hdTcvngDhbu0TuX1kh3Uxqx6NkYoC9pa3CNSqeFmKd5OYcnJuf5jn4+id1Krz
         EUF6W4xWJ6bnLrLEZ2NTBx0PAvha/F45SqHRKjt4LPg30Eg5ac4QyV+wmlFGdokmk2rp
         Rd5JVZin0WNSbXV7ovlF6kG6clZPhiMw64euN3vlWZmt79ts9xVDGgGwKcXOI90v1NdU
         wFMID3svpdKW6h3TAF+VBgD7V7u7oNEWBbCwK/FMperj9RaV+2SoV+FSVv4mWiFEjgaH
         RJJK2Ms8xcL7xRRORZRvezXlXA4m+2GpUhgKLKBp+0JBW50D3ssl8YfDtNbp1k06IiyS
         a+IQ==
X-Forwarded-Encrypted: i=1; AJvYcCUMirUr5zMSHNS0hwui1yXMLx55G99vvNHQP3ehEKOAngNQstoymPzo23hapEjT2CCBa4cCW3aqXA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxTZ2kAgX4e3z1kM8qXiB55HkIUZgTT8Ct8WPnxkpULuaF94ZY6
	NgQxc84uROAkHk8AhCQUqr6JuCTNi1phD15yJiZgNRzgcesmrYwKyrXfkzdC6uhMoF+hifMT/+Q
	jQRou
X-Gm-Gg: ASbGncuIzjmPZPvmd8OGyoruJezL6makwzJQvkIELGKIc/ODwwu+dGBsm8muPP4PCIx
	OOAlnR/1J77O5OEtSe/I/YC5/A+8ko7Vc8T9o62MP0wvQ6ncyI8eep14Tqg5RfXc/mnnKW/5YQ2
	GNN1Mgv7gBrrcvwcXJOC2JJUKc0n76r/NnOqyzGa1GzL4nIJFKprez1YrK1PsLCXAJn7gY8PjWp
	I3NjizO7QxozCWYJvRRf5EMMhQ3j8XGFZJVlkKzthDp6h9EOGA/YETX1Cfg+f30ILbw7lvS+4wq
	xYNdgGWGLPoMVBovUm6ANCg1Wr4gu/ouCY4SJYrpRa5+U0rfa1ZhRh7jw0KkJgBsfsVRO6vM2Q4
	tgldi9eFmwuiF4z4ToB79EAxO
X-Google-Smtp-Source: AGHT+IFfuu4OZWLK4Ect5V8qcKWdtQ9AvKTAwNSmE5IY/JmFZqua6II8FJDl1UVaUxNnVGH1wfuJAA==
X-Received: by 2002:a05:6a20:2448:b0:240:2421:b912 with SMTP id adf61e73a8af0-24340d17030mr33915391637.37.1756359982962;
        Wed, 27 Aug 2025 22:46:22 -0700 (PDT)
Received: from localhost ([122.172.87.165])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4c1b2f5a3csm8873232a12.4.2025.08.27.22.46.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 22:46:22 -0700 (PDT)
Date: Thu, 28 Aug 2025 11:16:20 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH 1/1] dt-bindings: cpufreq-dt: Remove redundant
 cpufreq-dt.txt
Message-ID: <20250828054620.u6gbjevidlnv32cl@vireshk-i7>
References: <20250827204401.87942-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250827204401.87942-1-Frank.Li@nxp.com>

On 27-08-25, 16:44, Frank Li wrote:
> The information is already documented in
> Documentation/devicetree/bindings/arm/cpus.yaml.
> Documentation/devicetree/bindings/opp/opp-v1.yaml

Even then, we can document what driver expects. So duplication isn't
an issue I think.

But this file is outdated and hasn't received an update in years.

> Remove the redundant file.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  .../bindings/cpufreq/cpufreq-dt.txt           | 61 -------------------
>  1 file changed, 61 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/cpufreq/cpufreq-dt.txt

Merged with this commit log instead.

commit b238cd833e3d62a76c53d540ed663b314ad179f0 (HEAD -> opp/linux-next)
Author: Frank Li <Frank.Li@nxp.com>
Date:   Wed Aug 27 16:44:01 2025 -0400

    dt-bindings: Remove outdated cpufreq-dt.txt

    The information present in this file is outdated and doesn't serve any
    purpose with the current design of the driver.

    Remove the outdated file.

    Signed-off-by: Frank Li <Frank.Li@nxp.com>
    [ Viresh: Rewrite commit log ]
    Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

