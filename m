Return-Path: <linux-pm+bounces-18908-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BAAA29EB1F2
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2024 14:32:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 948BC188977B
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2024 13:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66F211A9B21;
	Tue, 10 Dec 2024 13:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="awaWyo2x"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE80E19DF4B
	for <linux-pm@vger.kernel.org>; Tue, 10 Dec 2024 13:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733837529; cv=none; b=SC7Kbu7eQ0YpS6OEd2u/Q5pgjGHJE4sLHnInwsbGgszXcRv/gMRS1cdbpbl+VMkoJXfnbbVsW/OLtAS9Io1WqGTXTTluWSGHskZM55XBu2Kn0KbvMFesyGiV7tFknbltSCyhNuKeC9mmiaXfVfVwB7/rC09l4QKf6fA8IlUfaic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733837529; c=relaxed/simple;
	bh=tpxahU2EMEbtUoO2KLIKrt6Ras5uDKSg0IgF0I2BlhE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=saB+id6iPM85OjklcH2bFh0hIl7pP639fM6ECSVGgUUg4D20nt3MeMulfmAUK4oVWjQfK2njGmv21lSH0/TTEJ7ugb06bUpiPdFXNhzlXUR/GO6fzhovgRxuqFQz9X3U5sPbX9VwGyYwKx+k5Ksg2xuij8Z85oAhAtAo/hIi9tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=awaWyo2x; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3862d16b4f5so2447065f8f.0
        for <linux-pm@vger.kernel.org>; Tue, 10 Dec 2024 05:32:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1733837526; x=1734442326; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+XYf7bwDLYGGQXHqNGMCMwv3MtNzDyFAtjldQ9r+Oyc=;
        b=awaWyo2xbVyYEpv+QlX+DXPRI7qQMD7eUaMgvrLxPl0wtdjx1EjN+JI1akv76LeUai
         VjRgYBH/EFKEdXcTdlJmYrmQE83yNngSJPP1DhAiujCsL7cMwgnunH9OZS/GzNsVOXFl
         NG5gslJxUBOl+79OSmRORxRysIQDzC4RZ2fLcp7zUwxGQztjT3OmxgBq2x5Ss/+bnNMF
         b24H92tIp2l8dlbQg+nQZwpZgIDRoJW7BEf94cBJgMt450g3Tw0IWeXYx6698RJIhZPj
         kLrPe8ODq6H5srHAsKzxPeqmT8Jjf1yE1Yn770/An9C5ULqFLBZv1sB4O2+53B9/SAJU
         yscA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733837526; x=1734442326;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+XYf7bwDLYGGQXHqNGMCMwv3MtNzDyFAtjldQ9r+Oyc=;
        b=oi8D6Ync/V1aAQaSM8qWDXj+XCZrq1APGe9mKlHfXxGIszvMOIfo8/e0yexvfXrKx4
         3Du06JZ/yM3NtJrc3JEBt5DOksxuCoRZlTf7kpJHiopRd4PsL/ML3GBd08+1aEaXEIrX
         6qnu5YjfUlaf0QKPvvNFSB0pVTjCayD63oZAl6LNMWc3FDx/Z9Y4l9naYHaGFEr6r4cL
         ElWJ6aqNsFiAdq+uShT2aA0/haVpKhO/D+yu874tsYCD03uajSPWlAETs9UkxAqQQMoj
         I3ASsVKvosXj5upWo3DwZ7pDm6pmVAAXRmq4k/vItxocntJvuWwkBCvImP+bHdxX3pMp
         KbVw==
X-Forwarded-Encrypted: i=1; AJvYcCWw444H6jsWxGzUiN9Ppq3NphQWfh9HmbieMh+kA3ZrBN9eAEYs6ros+yn9aMXiex4kLRqEbFDY9Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyilq+LSKZ6/lTKmiYwoPwLNVUTHT6lfwSTgd7y1D4m418f8jvI
	flr2yMjFECCF/Hs9cLpYH7VhOglaLbfHZfrmHNob0QdOPrv/6SB9urX4g2eJou0=
X-Gm-Gg: ASbGncusgGmvtI9YoKHjRlcDq5RdbOqghAzKCZ43lqA1ftipVIq9Y5W7y3HHXTUCBcI
	0EscLbGRZm7UNf4csvo/1nkFDpxWA9aHAWf+wG6cUuu5gtV/oEn2W+IYZTnuWiZDpFFs8xKfWBw
	eORAOpuTcvqXxZ83CclVVKgyp1M3SZng7fl/KsXLgX5ljOzfG/X9KRXo8M3atc6CuDHwKCsCyNs
	+ZABAdl9JN17ZTOIeoZKvufaq0ArBnuQ7HL3dt+Ux3xkgQgvYoBPg==
X-Google-Smtp-Source: AGHT+IF2eLcwq8DKDelHta8/7SVIEYxjxekiDTZf2TdmNWcwDe+jbysbuh2/9Uh+e7rg5d2e9vNgiA==
X-Received: by 2002:a5d:598d:0:b0:385:e90a:b7de with SMTP id ffacd0b85a97d-386469a0e74mr2361037f8f.5.1733837526062;
        Tue, 10 Dec 2024 05:32:06 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:4c2b:c454:658c:f771])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-386367f7c71sm10212405f8f.41.2024.12.10.05.32.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 05:32:05 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Janaki Ramaiah Thota <quic_janathot@quicinc.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	quic_mohamull@quicinc.com,
	quic_hbandi@quicinc.com,
	quic_anubhavg@quicinc.com,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-bluetooth@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: Re: (subset) [PATCH v5 0/4] Enable Bluetooth on qcs6490-rb3gen2 board
Date: Tue, 10 Dec 2024 14:32:03 +0100
Message-ID: <173383751206.65568.8559892224432754385.b4-ty@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241209103455.9675-1-quic_janathot@quicinc.com>
References: <20241209103455.9675-1-quic_janathot@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Mon, 09 Dec 2024 16:04:51 +0530, Janaki Ramaiah Thota wrote:
> - Patch 1/4 Add description of the PMU of the WCN6750 module.
> - Patch 2/4 add and enable BT node for qcs6490-rb3gen board.
> - Patch 3/4 use the power sequencer for wcn6750.
> - Patch 4/4 add support for the WCN6750 PMU.
> 
> ----
> Changes from v4:
> * Added reviewed tag by Krzysztof in p1
> * Updated the p2 commit message with sw_ctrl and wifi-enable are
>   handled in wifi FW.
> * Added blank line between the nodes in p2
> * Placed the structures in proper order in p4
> * Link to v4: https://lore.kernel.org/all/20241204131706.20791-1-quic_janathot@quicinc.com/
> 
> [...]

Applied, thanks!

[4/4] power: sequencing: qcom-wcn: add support for the WCN6750 PMU
      commit: 93e3c990fcd90e578fd23b572a6c89020c7a453e

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

