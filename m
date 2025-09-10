Return-Path: <linux-pm+bounces-34347-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CAF19B512E1
	for <lists+linux-pm@lfdr.de>; Wed, 10 Sep 2025 11:42:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1D1E4E5124
	for <lists+linux-pm@lfdr.de>; Wed, 10 Sep 2025 09:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40C51315766;
	Wed, 10 Sep 2025 09:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ecgLE8LF"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0729314A7B
	for <linux-pm@vger.kernel.org>; Wed, 10 Sep 2025 09:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757497281; cv=none; b=tFH1kBag3i+uAQGGL5xXzQLdtFq5yxKBMpo7Ex9bswkovk4bi6FmJz1SCm5oDRRH06uPx1Yi9pNzJb5x2T4xuzcAo6J4BUyyGQoxMZXZV5pv5edJYtiy9xoVt35ghE0OLcrB8L2yy84HNKWgbxewKVW6RimQ3aUjR9yyXJIdI5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757497281; c=relaxed/simple;
	bh=e/kiWQIK0YAP/k8eC5ojOTLdahChMbymRDPSoa+l+lw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=J4ZuP9MfJEq8VZE9F9oFWBjwZaZWhWWaCKUAst4dLxuhpy1MqrXD7rxco7EisVLDkwvrW7ZqsM5U2CLS9p2PY3Hu47sZfoIjDvqPjoNbNm4J3VBSC/netg1Z4ofheRS+F26wZ0t6BNBWbTZWHkay9vrmgxEi3yd789cpTXTZhCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ecgLE8LF; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b0419ea61caso79586966b.0
        for <linux-pm@vger.kernel.org>; Wed, 10 Sep 2025 02:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757497277; x=1758102077; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+pt4wmXkU07xSJDhWQaMnUt+2pOc32GfIf3u3taNxfY=;
        b=ecgLE8LFVWZBvs43abCu5vIIy0CbrhXheFdt52h0+Z6X/3lfa5hpqWOzeuygD2hHiU
         iuMxo/9s+UR11GqZCpLe5lAdEzq+hDrgOcxJAj+Eh5Ar9UU2TtLgzbvK3ghwk6I3lDe3
         01slapou73yz5DESjE9Uh33Fa1qaEXTZt0kUjwR0iVdEFcWoSQlLf9A+O/4OkxRGI4JG
         DY7vAn7NrVeiNtarquuHfUcjGQQwxoxbaFBLvpIWtMXJveENLaQih1nEJQkW4MnszP4u
         cBTdGclpg/qTSJOBMQsJ+Xum6msqlKgDJm7zAo/5ASpi0ezOEb9cHOC33absZfwG0vJ7
         x5XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757497277; x=1758102077;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+pt4wmXkU07xSJDhWQaMnUt+2pOc32GfIf3u3taNxfY=;
        b=vMGdwKAhHi72Ia16aBb6JuyiwPCxgXCM+GOMdyTzVy/mVccYIZtptfMPtfDbD3u4fo
         0Ub98tzDjzUV0Lmkgnwu1ya8ftuX1vG2eb6ET6Ujn+ZB6Dcb2koPThSDSrb4AQ9q4ggG
         qemySeIhgU6Z6BxVTL0Bd4S14U8pe4BltZAU0r5Z8TvDvQjvN270S46AbBUo1A1wW8AW
         X6pHYopy1u5VYS2orsw7OqCGXWyTCC7N0pLwlYlhFuteVWretIbO4G3U36Re4eujXMco
         tCLHXF9wqCu4jRiremLK+dkFd1lmRCPDjgfPF2ddJUPQijEC5I+UMN6uc+XrmRHJ1HBs
         IKig==
X-Forwarded-Encrypted: i=1; AJvYcCX5LiicI1YcGiesaNec0gSOrmG/wkS4XK7xADOVxYKNQHo/rVMJMaVBgTKoSSbMfKagZwxllLnyjg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyCUn29gmzlKYyEzFRFx2MdP+RXQ1rgJ0R4T4Z1Q/ESiSKRHpZB
	Z4t2bix9NCcIIckY0nTW0LzNI+sNDuvmiJRRmXDOhu1jDHhr1xxvsevtJ79W0pXIWuSBWg0wfgd
	lqKMe
X-Gm-Gg: ASbGncs3hAEaz7aSj9WOgTepNcVOsbi45+lsMsH+TUvDCIpcAQcMl9Icl55/M+3XOG5
	+nt+CepVAeaYuxdrduCLl2B0vOrXnCIM2i1d9/lefCbzIDeiBYxSLPZkvL+0al65kmqYu3Rormx
	wjo6kUCd9ZUUtzRsboIdmlsRgRpHnAIkvl56JXJuxmsQJq9Qv5qb4Qx70v3W1sDvMBnpXpx2W77
	MlEAe0zaOccxe+PUYIztsxa1XQG0usXF7jQtYfv46XV5P0zl8dy0kFjTuBDFp+zKT0BAdJpC1SU
	ZEDjqT3GYXnIwmLwMdPbXjRZWJ7nN2WKaqS+062TwmrLSc65fRTVxcbpASgiGdjspjnEikO8CUj
	QBbHZl5SxaIxppNYgXf9KYgtx/aJ2aGtOCS8RaD0=
X-Google-Smtp-Source: AGHT+IGveog/Q2RUQ1K2kmwHRA0crLrj7yzg10nc1PBAbCu+y27ReaxfY24xmgNZqJ6GerxKvTkBkQ==
X-Received: by 2002:a17:907:7fa3:b0:afe:7575:df0e with SMTP id a640c23a62f3a-b04b1737c20mr799525566b.11.1757497276998;
        Wed, 10 Sep 2025 02:41:16 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62c01bdb7e9sm3021590a12.48.2025.09.10.02.41.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 02:41:16 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 MyungJoo Ham <myungjoo.ham@samsung.com>, 
 Kyungmin Park <kyungmin.park@samsung.com>, 
 Chanwoo Choi <cw00.choi@samsung.com>, Dmitry Osipenko <digetx@gmail.com>, 
 Aaron Kling <webgeek1234@gmail.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org
In-Reply-To: <20250906-t210-actmon-v3-4-1403365d571e@gmail.com>
References: <20250906-t210-actmon-v3-0-1403365d571e@gmail.com>
 <20250906-t210-actmon-v3-4-1403365d571e@gmail.com>
Subject: Re: (subset) [PATCH v3 4/9] memory: tegra210: Use bindings for
 client ids
Message-Id: <175749727534.29308.15110527994326578124.b4-ty@linaro.org>
Date: Wed, 10 Sep 2025 11:41:15 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Sat, 06 Sep 2025 15:16:54 -0500, Aaron Kling wrote:
> Since the related binding is being added, use that for the client ids
> instead of hardcoded magic numbers.
> 
> 

Applied, thanks!

[4/9] memory: tegra210: Use bindings for client ids
      https://git.kernel.org/krzk/linux-mem-ctrl/c/3804cef4c59742cf695e7b41a9aabe8d5bb25ca2

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


