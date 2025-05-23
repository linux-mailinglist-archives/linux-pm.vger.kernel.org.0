Return-Path: <linux-pm+bounces-27566-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C38BAC243A
	for <lists+linux-pm@lfdr.de>; Fri, 23 May 2025 15:41:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFAE01BA4422
	for <lists+linux-pm@lfdr.de>; Fri, 23 May 2025 13:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B49252951B7;
	Fri, 23 May 2025 13:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pbzUhY/k"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C92C5294A0B
	for <linux-pm@vger.kernel.org>; Fri, 23 May 2025 13:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748007650; cv=none; b=iSmWwlLw815kYMU6m3XtDw8G7hHjME4pNUjapvz3ZrLIw4hQB8Elw7MqAQeK0ZoeIBEgakBNgwzDhEgsTLSB7upF7jrZNhgDO0seEL9MMrxu0nlI93BngyBizK6TOTiitejW9mnrLPnVk9CKzpuRkJ46f5osYVMLW+XICpE3Ht8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748007650; c=relaxed/simple;
	bh=nIpXaKo7UoYnucf3GuIfuZxsHV/DZVUWbfnVOjaAP7s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YhOgHnTtFk7DXZ2rYfmw2hSvtOxwOrzwHmqC7f3bbLJYvVqKUhc9/5Gs4w/1ZQ0P/0PRZPH7VGIdovREvfhyN8P3U0BzEKiFfde12/rqmmXBmzzLoioZ/a4Dib74oFqnOofIfxfiaxmrEmlWyIH+qwH6BD4hSzSR0xz7Eu8xb3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pbzUhY/k; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-551f00720deso5800985e87.0
        for <linux-pm@vger.kernel.org>; Fri, 23 May 2025 06:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1748007647; x=1748612447; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bRfyxZvH5+TpkOAftwgj9mo3UBVnLXBhqh8LLeaEC0o=;
        b=pbzUhY/kYRwEbbmAU2uxDtfT3SxQlZ8CYpJ0LU2P4+6dV+AUAjCVBOlWb2ONZoBopf
         TEhUQtkm0QixzG/L73rwY7sWHnb2tiUY9SUCXiw54ek6A2ZzfD1vAK6kae0nVZnAZXFR
         kCJZfTDR5bdQHNBtt08HsDIESR4nHeAE37VKZ/WDvljFp3O1hCDWgxYSOzComsBakjhN
         vFOmXvRX7UQO2TCfnxyPIhIsTrjAUin+IzBVt1kBXGXknVqzD9xq/FBcyOQ3CV0rXec4
         KkO0GQsV8jSLCj8xZOJMXFWTUP9HvdasV4tM2PdVdeQPKaja4LLKOw0wfFethws15q1d
         7TYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748007647; x=1748612447;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bRfyxZvH5+TpkOAftwgj9mo3UBVnLXBhqh8LLeaEC0o=;
        b=E+lR0WIAcyK5Ssknp61gTjaXiEeJwKnp0itB6wIZwrRFfRK5m4SiLyxxYbmPY7W6ie
         sJhPNDJFZ5bsDSuAMiT7y2mG/Kaho7VPgLyGak/85YYJNQF5a6xOubUXedflTQTctWS5
         OJ1V7f1d4/QZAV1qSeruc2Z4NuKKS/br1XvkQJEwMkC62XksEzgMB3fSROfrDFyE+HvX
         +eDGMhuZfXIhObmf2+0SozSL5F5QT0hw5sHFyXD7qA9t3TPFxzNHc7vLV5nq1Jg95ls8
         cax9bVyH5yjLT2c3mJ6fHpiBQbf3ciyZaaswD5MIownkdD7IP3LtKgvJlTWbXYU8v4sV
         21yQ==
X-Forwarded-Encrypted: i=1; AJvYcCWq4Ms11yQqW4w1dMQHvMdh6Sfb21l2wWVax/HGnfpOEXyZhz76xs8ZVeSJVD4un2/txDz2jQ1iOw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzrQIUmX4gdlLxy44ZxumxE7dzifx81unFhcA8tVGjeli/63ngy
	xo7bLErsOjmZSxCMXqrhA86Ie4+76xEpPci/9x5roCnd93Gi0n3H/FebhTTYV+Su2Fw=
X-Gm-Gg: ASbGncvZt+Ip+Kbc7v/2oWcJq0lM4uxp/CfcYw1KTYqHQjLRR93ND5EGDU02lXywfkC
	yB55tPv7mkEzBS2wQe+RSBCBvKyHSMfX7JN1lSW3lhyIK3oqHrnzBvcPwD8bQHETaQ58wM/YurG
	PkmUAHzq/PZDPOZJidkpqSkg6PYSWjK+We8FdB+8Gvp7epamBRirn1RvQr3RCB1x8oZGbzR6hYL
	6MVwYE+oY+7Tfnutbu6bSpCy9S7/EaCDor7+QtKeHr04SWdAwCA1LYAbenWJ9JvNYF34NsG87cg
	XLabqsBto6CSlKjmfdf7HZ+pY3N1lN2jBEsojiVlpKNU/AX+N5YM8ZWTMoGbvfoY0BkVYuxuwuu
	7U1SzBzlAuPxQusdDhyAtUtJhXQ==
X-Google-Smtp-Source: AGHT+IEQ3+x5BM2uDN34zUdzxKW6ya4/VolG4ReWBxvxjZOXbRaDh6MY+jvSlnL1g35O0Meqr3/ZCA==
X-Received: by 2002:a05:6512:22c4:b0:551:fd90:e4a9 with SMTP id 2adb3069b0e04-551fd90e544mr4364920e87.44.1748007647110;
        Fri, 23 May 2025 06:40:47 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-551fc0d473bsm1950609e87.244.2025.05.23.06.40.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 May 2025 06:40:46 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Saravana Kannan <saravanak@google.com>,
	Stephen Boyd <sboyd@kernel.org>,
	linux-pm@vger.kernel.org
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Michael Grzeschik <m.grzeschik@pengutronix.de>,
	Bjorn Andersson <andersson@kernel.org>,
	Abel Vesa <abel.vesa@linaro.org>,
	Peng Fan <peng.fan@oss.nxp.com>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Johan Hovold <johan@kernel.org>,
	Maulik Shah <maulik.shah@oss.qualcomm.com>,
	Michal Simek <michal.simek@amd.com>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 05/21] pmdomain: core: Prepare to add the common ->sync_state() support
Date: Fri, 23 May 2025 15:40:02 +0200
Message-ID: <20250523134025.75130-6-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250523134025.75130-1-ulf.hansson@linaro.org>
References: <20250523134025.75130-1-ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Before we can implement the common ->sync_state() support in genpd, we need
to allow a few specific genpd providers to opt out from the new behaviour.

Let's introduce GENPD_FLAG_NO_SYNC_STATE as a new genpd config option, to
allow providers to opt out.

Suggested-by: Saravana Kannan <saravanak@google.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 include/linux/pm_domain.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index 3578196e6626..9329554b9c4a 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -104,6 +104,11 @@ struct dev_pm_domain_list {
  * GENPD_FLAG_DEV_NAME_FW:	Instructs genpd to generate an unique device name
  *				using ida. It is used by genpd providers which
  *				get their genpd-names directly from FW.
+ *
+ * GENPD_FLAG_NO_SYNC_STATE:	The ->sync_state() support is implemented in a
+ *				genpd provider specific way, likely through a
+ *				parent device node. This flag makes genpd to
+ *				skip its internal support for this.
  */
 #define GENPD_FLAG_PM_CLK	 (1U << 0)
 #define GENPD_FLAG_IRQ_SAFE	 (1U << 1)
@@ -114,6 +119,7 @@ struct dev_pm_domain_list {
 #define GENPD_FLAG_MIN_RESIDENCY (1U << 6)
 #define GENPD_FLAG_OPP_TABLE_FW	 (1U << 7)
 #define GENPD_FLAG_DEV_NAME_FW	 (1U << 8)
+#define GENPD_FLAG_NO_SYNC_STATE (1U << 9)
 
 enum gpd_status {
 	GENPD_STATE_ON = 0,	/* PM domain is on */
-- 
2.43.0


