Return-Path: <linux-pm+bounces-27360-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13A48ABC43B
	for <lists+linux-pm@lfdr.de>; Mon, 19 May 2025 18:18:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F284E3BD7A0
	for <lists+linux-pm@lfdr.de>; Mon, 19 May 2025 16:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9058286D77;
	Mon, 19 May 2025 16:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NuNCk8Ut"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03562853EA
	for <linux-pm@vger.kernel.org>; Mon, 19 May 2025 16:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747671419; cv=none; b=AcffjyeyELJix/du8IKDfj9lSYT+9+gfLPPcVpmf4ERSVExSm3kfB8FSoZuRgdv+KWbAPOny1wf3oizAFLF/WCbBHY1NTs32GZS6+5FQP2TURijMuP/ILOme3GZljCYCf93/oNLHQpVEpnPJvwNjnyzuT1z96Au7fB7vK6oAmvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747671419; c=relaxed/simple;
	bh=6y5PZ4QFULPYq/QswZTiV7sH1aYiVPHL+DEDTZs0PpY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=DCzV2aEQ7Z+Cvq6H7jf/KwCk19P4JodU6hEpUlRpTMdcYKduIUXBui7DjQQRoE2JuFfLlJX2ZzFkMK4ZmtG4b1gy1R/gFKIxZ8ebI/q4W3B7YErrXdOdVEr8KglyP5xpTPVP0I+O28GQFTdVMNLg27atFFLT7PRdyuhAkU9Mu10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NuNCk8Ut; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43cfe63c592so50445055e9.2
        for <linux-pm@vger.kernel.org>; Mon, 19 May 2025 09:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1747671416; x=1748276216; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qbRq/IqSwZ8N/cKfIIl6SwnJgAlK1OFrVnQY7MK26Lg=;
        b=NuNCk8UtVp5BvFTvE9cwLcwCGCDEAc66Uw3ocjV5UT6A+NG89fHAWWrexrhxQ5xxBf
         EPyRCvhlyO+KaeN7j7YPg03DkKPzY+WX+PIJaU584T2cjHVLjn+et73jqIZItt+F+6j2
         z7sI55a3pQNAOfHVZGTZLYE/s+Gey1Wd1c4VyQgT4Rf/d8wtZwOBkZ6e5dl0wK8FM0pW
         VAXadVE1vNsfXy3dkDNxX8lKrHRI1QchogFTi7jkqTjy6IXxBYsy1EvGBUuXFM65GApH
         MGy8lQelKSswr7PJ/PnXqDS5JtjlLx99iPmTc1iWnGmjbsiMHpnhADS2DYruYxQ9EFws
         LvrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747671416; x=1748276216;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qbRq/IqSwZ8N/cKfIIl6SwnJgAlK1OFrVnQY7MK26Lg=;
        b=XucrTlRUQYI1PCcie+92vdqj58g8MtDtkkP51ARV/HL9jriGpxs2WTI+UXaFwWrjy8
         5rmLNZq5OkNZ9HXWSoLSUziiha8umK8SXnBC9+A9t2bXSVHYBE9b/dOwAa16nhLn8J8p
         V2hieWGD3nxkrA980YI5i/OL1U7o5mzNTglRoj/I3bKrn9ToGu0vN/Wcul29hWRbH5WW
         2cxacETDXgKKJq7I8QJAgN++WuCtwcWlKU1WtGHjlbWbZlGW7l3L6riC6BNj5Zss3tPG
         DVzCKN6138vI6Krkr6YLfeKh2ia12KnRxnPBvUG6/8e/hJ161J2vSRGUtXWDkvE5X/jc
         imEg==
X-Forwarded-Encrypted: i=1; AJvYcCXyUiZqsdGu2e77VsA4VeeRNCcDxS+ezGINL805BV+xJaQwcgNbrFBUM+Tyr1NO/MgkASt4T6DS8g==@vger.kernel.org
X-Gm-Message-State: AOJu0YwRGt9PbEZe4oKFnRfBhUTSyZhEgIvo5deL+Chqi8DHBjC8cIFH
	AU7+6WcRuF9KJoFlgY1z+bjpUTmh8vX1dXUbSqF6XUjY3ubH8mdA5/T9+8wRt9GMgmU=
X-Gm-Gg: ASbGnctQ3L22SsNVlyrtqirzlyulCBmUN5ZXs8yHHAdPJb7X9H79wjGFR8xTh2DLE2r
	J+BwVVWrNlQOVyhDBthVe19TIFfXoF6TLIXVbjxfPOUv6rl5uq9xj68CeqL3PJ32XEST1HGQD4f
	uSFfdS3lm3v6cTR970vvXWKKjOUH5so1oSyVIXTLhWtMcYj+53wTuzej+IRn+oBwoZOiXuNIVeR
	yiuwhZvJzAHFIyqslJdBAZ94Y/yH5BXrvaoyIYKbeekOXULiWnYmwg+E0Ej+G+oPDQW/3cvtnKP
	WVLsFfNJofMrtiegnEa0xEHHDpSMhArMvJM9wb9kf0dIAPFznDL25ycRt3lAFOSkqvpXZzTmbc8
	YNw3cl07q1Vju+w==
X-Google-Smtp-Source: AGHT+IGESgtH2Ti9kUKi9EEM5pD2kJzzzhq7d3TT8vNc8zbGwIiJoy3yiTUgXnBwaMkM7GjijoPgTA==
X-Received: by 2002:a05:600c:154a:b0:43c:fcbc:9680 with SMTP id 5b1f17b1804b1-442fd664848mr98779135e9.25.1747671416164;
        Mon, 19 May 2025 09:16:56 -0700 (PDT)
Received: from mai.linaro.org (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442fd516a51sm144640015e9.24.2025.05.19.09.16.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 09:16:55 -0700 (PDT)
Date: Mon, 19 May 2025 18:16:53 +0200
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: rafael@kernel.org
Cc: krzysztof.kozlowski@linaro.org, luca.ceresoli@bootlin.com,
	kike.correo99.f@gmail.com, angelogioacchino.delregno@collabora.com,
	arnd@arndb.de, ansuelsmth@gmail.com, srichara@quicinc.com,
	george.moussalem@outlook.com, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [GIT PULL] thermal drivers changes for v6.16-rc1
Message-ID: <aCtZdbNA5UwE4j4b@mai.linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi Rafael,

Please consider pulling the following changes since commit
82f2b0b97b36ee3fcddf0f0780a9a0825d52fec3:

  Linux 6.15-rc6 (2025-05-11 14:54:11 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git tags/thermal-v6.16-rc1

for you to fetch changes up to e23cba0ab49a9cf95e9bc3a86cfbf336b0e285f6:

  thermal/drivers/airoha: Fix spelling mistake (2025-05-16 12:50:01 +0200)

----------------------------------------------------------------
- Make the Hisilicon driver to compile by default when ARCH_HISI is
  set (Krzysztof Kozlowski)

- Cleanup printk format with use of %pC instead of %pCn in the bcm2835
  driver (Luca Ceresoli)

- Fix variable naming coding style in the AmLogic driver (Enrique
  Isidoro Vazquez Ramos)

- Fix missing debugfs entry removal on failure by using the devm_
  variant in the LVTS driver (AngeloGioacchino Del Regno)

- Remove the unused lvts_debugfs_exit() function as the devm variant
  introduced before takes care of removing the debugfs entry in the
  LVTS driver (Arnd Bergmann)

- Add the Airoha EN7581 thermal sensor support along with its DT
  bindings (Christian Marangi)

- Add ipq5018 compatible string DT binding, cleanup and add its suppot
  in the QCom Tsens driver driver (Sricharan Ramabadhran and George
  Moussalem)

- Fix comments typos in the Airoha driver (Christian Marangi)

----------------------------------------------------------------
AngeloGioacchino Del Regno (1):
      thermal/drivers/mediatek/lvts: Fix debugfs unregister on failure

Arnd Bergmann (1):
      thermal/drivers/mediatek/lvts: Remove unused lvts_debugfs_exit

Christian Marangi (3):
      dt-bindings: thermal: Add support for Airoha EN7581 thermal sensor  
      thermal/drivers: Add support for Airoha EN7581 thermal sensor
      thermal/drivers/airoha: Fix spelling mistake

Enrique Isidoro Vazquez Ramos (1):
      thermal/drivers/amlogic: Rename Uptat to uptat to follow kernel coding style

George Moussalem (2):
      thermal/drivers/qcom/tsens: Update conditions to strictly evaluate for IP v2+
      thermal/drivers/qcom/tsens: Add support for tsens v1 without RPM

Krzysztof Kozlowski (1):
      thermal/drivers/hisi: Do not enable by default during compile testing

Luca Ceresoli (2):
      thermal/drivers/bcm2835: Use %pC instead of %pCn
      vsprintf: remove redundant and unused %pCn format specifier

Sricharan Ramabadhran (2):
      dt-bindings: thermal: qcom-tsens: Add ipq5018 compatible
      thermal/drivers/qcom/tsens: Add support for IPQ5018 tsens

-- 

 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

