Return-Path: <linux-pm+bounces-40600-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C7F91D0D866
	for <lists+linux-pm@lfdr.de>; Sat, 10 Jan 2026 16:15:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B5DEE3082989
	for <lists+linux-pm@lfdr.de>; Sat, 10 Jan 2026 15:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C50334845F;
	Sat, 10 Jan 2026 15:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="UR3LYot3"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A71348884
	for <linux-pm@vger.kernel.org>; Sat, 10 Jan 2026 15:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768057793; cv=none; b=C2q9C19ohN8yEEETQ0yt7tJMKiIdMVq6H81fCfhySxzgEXNg+Tkb/8n/sLcm1nLfsNYvw8BHFdE8ZS5d5Y1RBnRpL+WEQ9f1K+R73lumIV44xirvOe4IRuXHZTE3niwzXrhhb70nYqfyaTzEFc6ZjJskeZ1o0mHuUs5B1HoyIto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768057793; c=relaxed/simple;
	bh=veOrw/m8cCXNOzS0YhBEMZHiqb+wrCM+D/j1ZadzRgQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WTdrJuknZSwZiS8vKuMiRTYVYrCbfsD0mE5/SEKs9iLUEtkIW/Jawd+iSs2I9V06nXIalau+PEp90+Ymo2+esT4kwhx5uFMfRUEvr2TZxWS/m0R0HL9M7uENBco/MnwqbUn/vPux0z8XdDj19hqyWdoVZrHLTo95jh81wPbGBcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=UR3LYot3; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-43284ed32a0so2589646f8f.3
        for <linux-pm@vger.kernel.org>; Sat, 10 Jan 2026 07:09:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1768057784; x=1768662584; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZYFiIfX0/KjQWE2M1MYc+2i7VSmAxQXe92tai7T06wg=;
        b=UR3LYot3X99B0iocnSlHLBo6xcEdvqWff5fJcdU9Exm6L/VyIsE1xVQ3sVYgXj7q3/
         AJgsd1EMgirOEF5wAn7H3E2taaHVG0xxbScSmK/eNkl7JVSrD9tlrn9K3U+JEY1JherW
         Qz8doesvUqWD5kfvD+tIrJouA/o6VYr3xVkPxj51Z9B+MKoAfeYgqiPVYyYZKZrNhk/F
         P9bB6TJNL306n/2z4mmOJ83Oy5KeskaYSjMWq2a8PkNrM/SO+irij/BR+IX+izMpqtjd
         cF/nBHWOZQPzwd+sng08PL/DHPEqiDOLBhZ8Qyrf6Ffy1AiCqVfxLza0Qx4ukc3S/Gwv
         Y6Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768057784; x=1768662584;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZYFiIfX0/KjQWE2M1MYc+2i7VSmAxQXe92tai7T06wg=;
        b=X0jaNSruwr0tKkbffQWUcUgWn/Y6kBeTgxsH1XdAhlwU67V1fQAVNb7EWPVdprzonU
         xgFWK8nPNVbsPRrTmv0QnyY5kbaHYyNveb6uuFEXRkouZcyxGDUQkfdyS8eSi8yFO9il
         Niw+emqPcfkPAAotYBdPpA0O3oiRt1P1FB6xTK0ASb/gxLdJzLlX/0V1rBYPX3sWy2xp
         P6tSUMTZCVOSkzj8z5jmT4u/wBI6pzMfPN/qlRCfvO1xSVP4iGX6zlbJXmF+zAEW6iJ6
         iYC6vi1SRAEUntUGBOLkU51dOMf9YW/AT/l05LcUkraJIdJSb23UdLfq27yaRuJ+ULZ2
         Bjzw==
X-Forwarded-Encrypted: i=1; AJvYcCU+0dlXjR6qd6utdyYyqItB6qmpCcloe/5bF9tDgLcvEw5cTPOy4gX4nBcS9mzVQuBuTz3vWV1ZEQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywrg7DHzG6Y8/DnM+2doW6MfGqMIvIH4PKtaA5NGAEDFmC8efbH
	sQ6YHsrXEO9M2B4QorhHsTx5gi4Dmhz0kwa7+oakUYzXlXJTQwSiP77MKTvviMby8dk=
X-Gm-Gg: AY/fxX5nB89q/kRF2bRsyxgZqi62ZXnzahtI86G9dv5LC43y1SzcVIcmOAE1yLFJe74
	M44RMuOZH9jNlxTTS03VWGymDv66MqZDY0uL1m/mZOTqyoU+iX57STZ4vba+pNgOED9eaMGqt40
	jkFEwA8INu3hT1v8X4wwBCTnI+z5ns0WdwU31UMYjim/ZaLoZdlh81ZPODnKh2Ilbt0ZNiTLDCQ
	ZvMjU6Smvz8u0+dUCp4jSZiER6xCOdQ951gAgCv8Z2HOd0JdTJXshkXd6D0eEI5kPF2sa8vVdz7
	jrDyeIFQHeRk/bYj6nRXIixHr4RcWFH3DsLfh0TScoXnvfR6ny6rqPRy2OaSWbHTFYeccL7yNKA
	Uar71XxJMGl2eyjdoX8ntSOfxk2h/UbrB4FmxP2E/IXYOqOcO9xzaIZdCdjMb3Tz8FZET47uU1b
	kVWuiEGBiIqLAEtNQPfLbkPNT1g/pH
X-Google-Smtp-Source: AGHT+IHwvRNK+qwBLjP9mJj148RzU5png6+Rsy9u3J7EYhE07UUYa3vVSxYXarlT5BZGC6AC5xVP2w==
X-Received: by 2002:a05:6000:40da:b0:430:f23f:4bc5 with SMTP id ffacd0b85a97d-432c3760d02mr14529601f8f.45.1768057784134;
        Sat, 10 Jan 2026 07:09:44 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.31])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd0e199bsm28208208f8f.16.2026.01.10.07.09.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Jan 2026 07:09:43 -0800 (PST)
Message-ID: <6c2612f9-97de-49e4-a7c2-eacea2d33f51@tuxon.dev>
Date: Sat, 10 Jan 2026 17:09:40 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/12] ARM: at91: Simplify with scoped for each OF
 child loop
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
 Miguel Ojeda <ojeda@kernel.org>, Rob Herring <robh@kernel.org>,
 Saravana Kannan <saravanak@google.com>, Nathan Chancellor
 <nathan@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Russell King <linux@armlinux.org.uk>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Krzysztof Kozlowski <krzk@kernel.org>, Alim Akhtar
 <alim.akhtar@samsung.com>, Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 Nipun Gupta <nipun.gupta@amd.com>, Nikhil Agarwal <nikhil.agarwal@amd.com>,
 Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Vinod Koul <vkoul@kernel.org>,
 Sylwester Nawrocki <s.nawrocki@samsung.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 llvm@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-clk@vger.kernel.org, imx@lists.linux.dev, dmaengine@vger.kernel.org,
 linux-media@vger.kernel.org, linux-pm@vger.kernel.org,
 Jonathan Cameron <jonathan.cameron@huawei.com>
References: <20260109-of-for-each-compatible-scoped-v3-0-c22fa2c0749a@oss.qualcomm.com>
 <20260109-of-for-each-compatible-scoped-v3-2-c22fa2c0749a@oss.qualcomm.com>
Content-Language: en-US
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20260109-of-for-each-compatible-scoped-v3-2-c22fa2c0749a@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 1/9/26 18:57, Krzysztof Kozlowski wrote:
> Use scoped for-each loop when iterating over device nodes to make code a
> bit simpler.
> 
> Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Reviewed-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>

