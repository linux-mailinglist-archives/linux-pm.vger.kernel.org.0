Return-Path: <linux-pm+bounces-34346-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1D56B512DB
	for <lists+linux-pm@lfdr.de>; Wed, 10 Sep 2025 11:41:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D54C168000
	for <lists+linux-pm@lfdr.de>; Wed, 10 Sep 2025 09:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB42D314A8A;
	Wed, 10 Sep 2025 09:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LJA+xMuv"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C333148C6
	for <linux-pm@vger.kernel.org>; Wed, 10 Sep 2025 09:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757497278; cv=none; b=f2wEz+65bONXoZ8WZgk+8SesK00KLiaEHLNWF0bIDvM3jnpeSN+29J2FJAAIi2gv3Kt13QhGJqANE6vt6f8RlkA6WxLcRJOPDjzsr988MMCXexz7VZ3pJfgbdtfIE5GuJqr9bd0+hjNoMl8GkU6io7UtgYIDLhlxf6bQjeQrYKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757497278; c=relaxed/simple;
	bh=sZUp8SW9Tfp1f74Att6rsJtcQTfdahYzip3ExVh1YXk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=g95F15PMwz8ORrZkyasbKDeiHNmjwxhdflVc/sCr1TVh+OQaKRKZvS6AEl73cHbgEN4ig5Ybr3WoRot/XHFJ+MB8axce0VIDJF5oy7s1B2ysAUKfYmeBPbI+rXgH3yrEbRNLql+3AL941ex+7HBNaKXGKwHewxjZAJt5iFySkDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LJA+xMuv; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6285612382aso464601a12.2
        for <linux-pm@vger.kernel.org>; Wed, 10 Sep 2025 02:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757497275; x=1758102075; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KL8PU3/bJen0cT+fcrsTVjVS+BhRynUifUy443nwXXY=;
        b=LJA+xMuvKObaPLe3mrGZWMvVCZfz4x8rghuOC1rVlUQpC2NJ9vmaCy56Xtdl+lIDn+
         dvRXrtgkh0LcwHiaHMkMdaB0rCt/ola1QZI55JNp+y+1ghfVqs/TsXe2+Yzgkug/fGn/
         rzl+GdWncyNg+x6PvHsQf4E3fKHo6jNUEw5evraMO6EL3tJf/3VywI6CGCTXa9vM23bk
         0efiWPGUE/kx/4GDteT5iiuqtMTUJP3xE1jVeaTy7AQgxgbICUEkjtGIJ5FgcZYDGtNt
         RHdW5nV/TJ8wtwR5c3jzy1YYRxPDQBi+jrqCz/Dbz3MpPAO9i4q4/tM3Px7r20GGB3xF
         L04Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757497275; x=1758102075;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KL8PU3/bJen0cT+fcrsTVjVS+BhRynUifUy443nwXXY=;
        b=YJ//W20wVTsMXQZqyTU5S1Y8U4zsoKBy29/rGR/pHpVENcrHDwPyws48p8cAHf7n5v
         UJk/Pdp1iBdPGX/SD7Ls+KGd3K87MTLuLSaLNskbPDV0NX9qk1h2erj2KbXdYWKO6iar
         YRo3KVhrX81az+XVkKFAII+v4kniI7a/zcFrez7ud2u/TLlmCSjiWs9xd1RWDlsYYVmC
         FPvwEjCYctjm/mQnf3K9UfYXyBz0S4BBA8xGciYCTr7I2741w2n/FA+B+xqaTdWmBT5I
         Tcv1ankJ3UUdjRgjEa1nCOJZXIwIGgE48Me+283LP3cpZ6CArq2oJYp85PmVEoVQuD1l
         y4XA==
X-Forwarded-Encrypted: i=1; AJvYcCVqexlRQFjZMHvO5sweOm/W2AkoXhTAsJCYv/nQFvpvNzzjgre2Tc1x+JsaSiRMLseX4AC5CA30UA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxLveea46RlY5VRm5Eq7r7oJoP4ovIfAnR8R9bQvHLGnEWTt7cG
	eBVico0PdDeKl/lb4D8NjYkntPLy5Kbpi0VXk4Q14g9cmPtbTXi1ABDwUGza68PrcqQ=
X-Gm-Gg: ASbGncs7mw8o0/23BDI46PcoBtgVnD6BOIQviRsc5AK6Zm4deEV7mZX699W000r4z2O
	EKxfy9ia+moFFKB/aXJKJoUQ0LJdzksIJJ0LeCuK54Cik+b1pYCJM9Ehz1rqVSYSA2MwHJZeHD8
	gW6iSsBCqV0ph1YXeH0I2JSm4EBWTE3q2h8LwOMHQXcyPjTX82m2oIWONut5vtY7hz+pC3aiJrG
	7R0RCMdnpjkcB32fypG7RPPmo4UQGATqkGXkp4Owni1XKf9w75RAq6VD1an4c0GMqLSQFOFuRJe
	tY3fjyeCu7ccSewAKduL1P684kfyKCdzuOma8AQcG6Fq5X1UHZq6gy5IodgumFRCpTbly2ZTwHX
	cN3ELqjb3Tm3WkmjnxNrchYvClXtHO1zpMZdwj6V9SDKQMOSQBw==
X-Google-Smtp-Source: AGHT+IFluU1es+hUKEAAQ6k+MN426rP6ABJMO4pvWzDg2AWSxzJmSyi0YpWdow2bVsSEtKWjT6rzNw==
X-Received: by 2002:a05:6402:2345:b0:628:3c12:8732 with SMTP id 4fb4d7f45d1cf-6283c1294c9mr5368678a12.8.1757497275239;
        Wed, 10 Sep 2025 02:41:15 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62c01bdb7e9sm3021590a12.48.2025.09.10.02.41.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 02:41:14 -0700 (PDT)
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
In-Reply-To: <20250906-t210-actmon-v3-3-1403365d571e@gmail.com>
References: <20250906-t210-actmon-v3-0-1403365d571e@gmail.com>
 <20250906-t210-actmon-v3-3-1403365d571e@gmail.com>
Subject: Re: (subset) [PATCH v3 3/9] dt-bindings: memory: tegra210: Add
 memory client IDs
Message-Id: <175749727366.29308.15174837806848682381.b4-ty@linaro.org>
Date: Wed, 10 Sep 2025 11:41:13 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Sat, 06 Sep 2025 15:16:53 -0500, Aaron Kling wrote:
> Each memory client has unique hardware ID, add these IDs.
> 
> 

Applied, thanks!

[3/9] dt-bindings: memory: tegra210: Add memory client IDs
      https://git.kernel.org/krzk/linux-mem-ctrl/c/5f5598d945e2a69f764aa5c2074dad73e23bcfcb

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


