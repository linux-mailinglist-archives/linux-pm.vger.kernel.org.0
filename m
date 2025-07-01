Return-Path: <linux-pm+bounces-29898-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77EF8AEF71A
	for <lists+linux-pm@lfdr.de>; Tue,  1 Jul 2025 13:49:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 159EE1BC6B6A
	for <lists+linux-pm@lfdr.de>; Tue,  1 Jul 2025 11:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B57DA274B28;
	Tue,  1 Jul 2025 11:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HX5ihn36"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC73E2749CA
	for <linux-pm@vger.kernel.org>; Tue,  1 Jul 2025 11:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751370478; cv=none; b=hByeGE6LUcET8VU+TCuYmD27U24O/PzZjWZUpYUHgkY8WLj0znUCr2WtDnQ3pJZlSUwBwV4jAzAnKj99ogoBEL8ISLQvC5PAysnJTUBRwYgWRGPup9XHZNQDrWBwtriUNS8yUR6DX8BbijNfpC18cWb9IQWS++Bx+DjwlfjhbTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751370478; c=relaxed/simple;
	bh=dJ8EsJdalLFjFwUQ3vvaJretZ0FF7C0LZXGbOwfHU6U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=od44JCH1765cyPxfoBAAB0C3rY50gFCsPD8eOKUpRSGOIH/LBUq7dLGfFRzAOMhb/eawb82L5+aER7HC4LwSD1Y6+8GT3y9oKmgnYerrdr8aXctvCoGnmgbIFB00CU0gA6Ypg7eGxS8Zc8EvRkrlmw0GYzuRQ4XG+hItmEL9RXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HX5ihn36; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-553dceb345eso3764737e87.1
        for <linux-pm@vger.kernel.org>; Tue, 01 Jul 2025 04:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1751370475; x=1751975275; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=79lLQOvWjPgr3ms40rqLbg+1wi6d2CJf/NthKCtHiEc=;
        b=HX5ihn364HYe4waWW194HK5vnXDLyAFYXEdt1VLExN1TGEockwn2tWBJAm4j5sytVY
         knEl9reJOywq5pp8rlB0aEAeOaPPyM6u/mOro1LYBfpi1oZJptGtJpfmQMu7TqxElSco
         ExnHtl8lJQV5hYE9uB0hcu7MCLtMfLHT+6hJa520Q9tqbYGHP/F8XkMAt/uYRpZnYYtN
         CshTgLyuRBuvIkkEay3czqP3bbEFLJF4gNoEHaXxj19N2WoiagbYL8MmnCVj0/s1uYdM
         eR98afQODJdtrxJLMpj/XM+nIUzPXt9fFzcCONRXuQ1bZ0o/q883Kg8yp4otcz+WrRXB
         aUiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751370475; x=1751975275;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=79lLQOvWjPgr3ms40rqLbg+1wi6d2CJf/NthKCtHiEc=;
        b=GigvLiJv0QgH7sZ3mbCVdmB60TakAD/9XPlgqA9+FJm1e12gk2erj6kYCwfYgvBWKo
         b2u/TbA0+h0TP147kxiRbftkUoHOy4K6FANF49F/DXfSkel6pDUXuRcda/YUCfuTTOiC
         6zrpg4PPr24ZiE2yDmEO8+49ObmKkLiC7Lpfzd5ZvXvBqGfzoI8vwLQzGen1yR50001Y
         wYWCaS8AXw8Wt9fzS3Cv6wUs28rAZEF70a4W5sqaODARjzAhCZi5+QRFUoEj1OfDED6X
         pdlJpHBlEOiQ2zeBPjEl9G73xXlY4GsiO94RqdZcmZK08IClQ++fJsbocFEFvolntMRn
         xtJg==
X-Forwarded-Encrypted: i=1; AJvYcCUeu3FuK5Dv52lFawlZswWq6NAdQfejNRBCBkkW2DeGOvInIdXGJmk7lmnw5LUFIIJDpMQp+OzgXQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwNH/Ylj470nh5bXdHvZ9/yXAU9Y2HlynyW1iuUfdtzpiIQBQPb
	WDpL5TWf79fAF8hegVpwWllGV1n0xwMlmo/kO+0ehnsqWVXAKQykujz4vl06d3eHNOk=
X-Gm-Gg: ASbGncuWGD38R5+6/Bc1wU60eG7HR88KtvQax6KBTISNOzMaqvBitpb3YGci70rlFG6
	m+jhGYxDHB8u/sB2QlaU//9uThquWVxSB6n0XQqHy8rlIMGydBnIbTUAidlGCLAHAYBwrhyn/vY
	vjcZ7JHMxYjPTxTZZ45L/llYNzUQFDwwrXEr4EmtAsdQmqxxpOv/QWhRi4bbpm6OuhvnbaRngSr
	jEFlal1iXZ2Hmvsh925wu8e4iSBvtEiz8H/bop8yBZaduXR19FCgnS2e9fXAQ38aAYV/8cvfk8X
	Wx8KL0Fa4xPC6F6gJnDiuXG+dOndjC6LAKxH67nF9CBfcE2cipevp6r9YoQjIYDT88QWQtuaKXo
	pG4b/qsf1JYzDqoduPprj8bfmJLHIq4AKTUNE
X-Google-Smtp-Source: AGHT+IH4G62NAIzkTDdd4Bnq5FbST4e5sFqlJvIjwn56lcRCHhQ1EM+lmASjybjZreaBKv2h5BjCKA==
X-Received: by 2002:a05:6512:3501:b0:553:296b:a62 with SMTP id 2adb3069b0e04-5550b7e761dmr5493897e87.12.1751370474952;
        Tue, 01 Jul 2025 04:47:54 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5550b2f162dsm1800592e87.248.2025.07.01.04.47.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 04:47:54 -0700 (PDT)
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
	Hiago De Franco <hiago.franco@toradex.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 08/24] pmdomain: core: Prepare to add the common ->sync_state() support
Date: Tue,  1 Jul 2025 13:47:10 +0200
Message-ID: <20250701114733.636510-9-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250701114733.636510-1-ulf.hansson@linaro.org>
References: <20250701114733.636510-1-ulf.hansson@linaro.org>
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
Tested-by: Hiago De Franco <hiago.franco@toradex.com> # Colibri iMX8X
Tested-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com> # TI AM62A,Xilinx ZynqMP ZCU106
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


