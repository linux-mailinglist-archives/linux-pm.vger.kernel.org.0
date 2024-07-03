Return-Path: <linux-pm+bounces-10518-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B3C3E925736
	for <lists+linux-pm@lfdr.de>; Wed,  3 Jul 2024 11:50:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F1E0B20C8C
	for <lists+linux-pm@lfdr.de>; Wed,  3 Jul 2024 09:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2629613DDA1;
	Wed,  3 Jul 2024 09:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="d9xTeair"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52FB91386B3
	for <linux-pm@vger.kernel.org>; Wed,  3 Jul 2024 09:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720000194; cv=none; b=elBk30ZyrWJo7/bTGZx6guM9ShqFPZaE2n3l961TVJocEqirWXKB9pPumGRNWI9dtoZqWBcZn4HJo2VervqvMw4t6NZheNLQSL2gEpfwlzb1vCzCaLB3UF7YcVlRA8fOtI7qzUr2REbKFJH6J0RI141QniG4KPWrYP9uUprIoPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720000194; c=relaxed/simple;
	bh=QUOLnPFtJDFSuHEZTFhVRAjTxQEHSssUg19e7LLr5V4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DfDzZyrGsd9UxGPoNjPh0WwpuZvHmcdRKSMG+GRG/pTozcnksY+jDdw1QWv4dtVhiWPZjaSbBOD+yTRdiU62dSnAj8RG0nBJ2DInkGDWhJVG4yAdRTclylviYe7eiTavul6pnuctq0PoAoTbv6sKS2rJc6yzdYOEn4C7N95nESg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=d9xTeair; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-425624255f3so2788005e9.0
        for <linux-pm@vger.kernel.org>; Wed, 03 Jul 2024 02:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1720000191; x=1720604991; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Edw5qbMAyqVNkWr8RSWsj4OW1R6VLb7jwGt0ceVltaw=;
        b=d9xTeairRYpLaeM8EpMzYBPCUpgJR7MQxQZfbehbCq8CMG+BR7cWv3GfQyGOjwdNmG
         50KOMawskfKeOVQt01w9S23XFeBvO8b8OQrOOpRMmxOXeO3FwlH7iJ1cUNLxUnhemVlR
         KWmPX1XwHvMfkl6+lRFONiIotw72AhRhYKeW6s9ezzWAMbb3noyUzjiYCvPkvIikzcPg
         BJfppmMmsJ3SmWKT3+UzDMuG57T7A3RSVSeNvlg9L6BJ3VpT9Hn8WUIQxaXI/WGvGwsg
         lnW2C/0DNTI7NBFsgRNL2f0hv+sY4WhRTQRQHouIssTqxUo6FyXysz9S8NEQW72MNWL0
         wAZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720000191; x=1720604991;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Edw5qbMAyqVNkWr8RSWsj4OW1R6VLb7jwGt0ceVltaw=;
        b=RZ6eKbObm5rJd5i/k3LMlGom2d7bBU2JUjX4mpO9J7umnBsLOzhjKHu3AMQP/f+vwF
         cBi4nZ6agmOzbNXtcj2hAADibmfZUfM2Lo5pfWD3QiW5YBwP7SQ+cZZeI81eHdUOHK+9
         jbreT7xks/1BxGp4U/WwFT4ElrXiErNh8fGwbvj7CUOobBOvlk6cth1bVp/W3/7wTDEk
         MIWr43fmao8XUrpsfZDuW30Ns8BdNVliO5dlBud45fgLHzClLsWN5Y9W2T2mE0XSXyiA
         sBS9mK2mWBqm0x0yZGB5KnU6/0votH+MTPub5LhohDQUpBy0YMXKimESPiyhcu0Vea01
         YV4A==
X-Forwarded-Encrypted: i=1; AJvYcCVM0NOQwe53hpMFbp3wsINMsOYw+qUW3jXZ037J/OaNCcEk0DL/m98A4ZmsYB9wUacFM8eux3duKkwQDYS1aXmnc5t+E0/RlwA=
X-Gm-Message-State: AOJu0YxMv3lsrkL4XaS3dtQt88WJbkXRpgfx4Tle6fvxs4YPI2etWKj4
	d8+99GtN1YAXbSuieZPYzC0K7lhSr0AeOFAYe04cHSwGjbuvi5eTwIPVGeiF+hs=
X-Google-Smtp-Source: AGHT+IGEJoRd02YkvdFcD0T0IWoJrf1fg0Chu8G+6OVBzdYMXF6dRfo05cg9mU86Y4gTUSc1gLox1w==
X-Received: by 2002:a05:600c:198c:b0:424:aa5a:280e with SMTP id 5b1f17b1804b1-426408eb077mr9849255e9.8.1720000190522;
        Wed, 03 Jul 2024 02:49:50 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:c37f:195e:538f:bf06])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4257d9c7f18sm145535565e9.40.2024.07.03.02.49.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 02:49:50 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Bartosz Golaszewski <brgl@bgdev.pl>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH] power: sequencing: simplify returning pointer without cleanup
Date: Wed,  3 Jul 2024 11:49:48 +0200
Message-ID: <172000018612.10613.7054190475432581578.b4-ty@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240703083038.95777-1-krzysztof.kozlowski@linaro.org>
References: <20240703083038.95777-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Wed, 03 Jul 2024 10:30:38 +0200, Krzysztof Kozlowski wrote:
> Use 'return_ptr' helper for returning a pointer without cleanup for
> shorter code.
> 
> 

Applied, thanks!

[1/1] power: sequencing: simplify returning pointer without cleanup
      commit: eba6d0f88ba2c4e9175aae8556125a05980ff8f5

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

