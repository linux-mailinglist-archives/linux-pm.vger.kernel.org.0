Return-Path: <linux-pm+bounces-10692-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39C409287FB
	for <lists+linux-pm@lfdr.de>; Fri,  5 Jul 2024 13:31:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFD241F24A52
	for <lists+linux-pm@lfdr.de>; Fri,  5 Jul 2024 11:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADA7514A092;
	Fri,  5 Jul 2024 11:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aO1LUb3p"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78AD21494C9
	for <linux-pm@vger.kernel.org>; Fri,  5 Jul 2024 11:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720179082; cv=none; b=mOsOkwwbywbbgSjbj/Ub4Zu4KLAFvEnfIy3bcY8NmXpNhqLXvNikguy2OmHXAp6tunLKfDqY0mvU0yRy4xcp47LZLlVng6HNcYTp6oXwBbx/Mo0JToULseEOpr3cBoNs+iyDw9odfeHNF7FoSw8CPGM+407z8nEenh4C4DPOEZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720179082; c=relaxed/simple;
	bh=hPHreMrDt1doXkKIFfOnokfWoTTGR/eEdk8FJb3tsIk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XOhaFZVYpOs74YbKE3uv5IQMBlQVvKlMhifpBjr0CehbvJE53zZ++7oTO0Aaf1EMSGEYXT16NFh0Qw24VFVZzTG9YAUQo7/KAkTbVqrKAyw0Zs07XlJL4dYcl0cZzc+qYTB4svsv4vKwZOz7bQ3g64ewQ/KZ9NI6axlke/wgIbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aO1LUb3p; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-52e94eaf5efso1637538e87.2
        for <linux-pm@vger.kernel.org>; Fri, 05 Jul 2024 04:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720179078; x=1720783878; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=peeNZCDuyoda2DYpfs5bkgO4H7nlJlel4Yeo4yaX2aw=;
        b=aO1LUb3pdRnseVxQg2tcjLyD8kGPA76n2adwf9WQtS0FasZ9lPfLi2kE2953XpwoEr
         PcUyvOu09kuXefCjSzSwUTr1qLxHOxJ+C8tAWblLomlZW8ouTxGeWEtz6Gk2loWpfQLZ
         eSeMdzxBD4joNhBLflWHOMtlhcWeBacwotzDYuMS/+jt0q5dZRpQcYBmJrIKdTwnbIrN
         aXwEBf87IJiFGeJ+tISv3ev+rcqeLosp6gQtVJ/bGwyeS6pPCqVrXG3u1IWjbCgnGmt4
         MtFG27pu5tb4UJd9BKV89yR9SvlllWDVS+v4uPQB6lRa3W4BkVpYxMmWUEj7eT/0fyFs
         yuDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720179078; x=1720783878;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=peeNZCDuyoda2DYpfs5bkgO4H7nlJlel4Yeo4yaX2aw=;
        b=GiiIJOjSpmXDbEgJxUUWxwP4VBC/bgm6kAjmkj9OxbaLSKkTvAIUhtPxUUGqd+p2Db
         WMcorTptiR9b7qxqEgVjrIOnE3uU+gq6FHMVfWRToFeIYa18AKmWy3lV0XcerYOLeMHR
         cQpyabW+V+vI4Xk+o6jcH8aO88zv4JjcXKU2HmoiorcA2Agn53Zz85so6cwhZL5HF3AE
         XJNQ8nwJClvscQqeh5QgoLMaudK4vj3SByafVCh/93/eQ28Nwh6NVttvEokrTCp5Zd2I
         BZtekrdb1Cn//IZxFbzo6JMfh8LaWfteiaJUm3rCDlsIUnD4+kQscm5jNblp5DPu+AMk
         kLkQ==
X-Forwarded-Encrypted: i=1; AJvYcCVrWEh3PbiHPQ/xSGqnnX/M3Ojo1dVFqh6Ky0mFdVmwicpgg3N9KdAKxsZ3sfv7IYjHgiDtFpikpT6VtgGljfkQmsFE5ne4gtE=
X-Gm-Message-State: AOJu0YxaaJmNlAlgs0wAjw1Gia6z/XPKSeBMpSx0vpowHhqPNsaofkIg
	SziA3QIrVuwsl68966TP7XfZBV3OgXg5p8k+p74IS56zAw0rHPAxhOXoXLY08sU=
X-Google-Smtp-Source: AGHT+IG87fGjXF+TaN2rAGmYDwXmCBV4e70dP7HYgoU/5vS+jGGZ87IXfHT7BTxzfN8kyxOo+KkYcg==
X-Received: by 2002:a05:6512:3ca8:b0:52c:8abe:51fb with SMTP id 2adb3069b0e04-52ea061f4e1mr4207586e87.10.1720179078543;
        Fri, 05 Jul 2024 04:31:18 -0700 (PDT)
Received: from krzk-bin.. ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4264a2fc942sm58090725e9.42.2024.07.05.04.31.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 04:31:17 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Sebastian Reichel <sre@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/2] power: supply: twl4030_charger: correct comparision with old current
Date: Fri,  5 Jul 2024 13:31:13 +0200
Message-ID: <20240705113113.42851-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240705113113.42851-1-krzysztof.kozlowski@linaro.org>
References: <20240705113113.42851-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Driver reads existing current value from two 8-bit registers, but then
compares only one of them with the new 16-bit value.  clang W=1 is also
not happy:

  twl4030_charger.c:243:16: error: variable 'cur_reg' set but not used [-Werror,-Wunused-but-set-variable]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/power/supply/twl4030_charger.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/twl4030_charger.c b/drivers/power/supply/twl4030_charger.c
index 7b9b0b3e164e..f3f1a0862e93 100644
--- a/drivers/power/supply/twl4030_charger.c
+++ b/drivers/power/supply/twl4030_charger.c
@@ -363,7 +363,7 @@ static int twl4030_charger_update_current(struct twl4030_bci *bci)
 	if (status < 0)
 		return status;
 	cur_reg |= oldreg << 8;
-	if (reg != oldreg) {
+	if (reg != cur_reg) {
 		/* disable write protection for one write access for
 		 * BCIIREF */
 		status = twl_i2c_write_u8(TWL_MODULE_MAIN_CHARGE, 0xE7,
-- 
2.43.0


