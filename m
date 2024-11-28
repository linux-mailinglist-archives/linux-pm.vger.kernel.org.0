Return-Path: <linux-pm+bounces-18203-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17C189DB563
	for <lists+linux-pm@lfdr.de>; Thu, 28 Nov 2024 11:09:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AE15169B83
	for <lists+linux-pm@lfdr.de>; Thu, 28 Nov 2024 10:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F39F919CC1F;
	Thu, 28 Nov 2024 10:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j92sl5vV"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00789198E65
	for <linux-pm@vger.kernel.org>; Thu, 28 Nov 2024 10:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732788489; cv=none; b=MzKZxYeAdXyxSlWFZm+BJe8VJ0+//rrmxwC57v78MPxzIE3v56KyaSlS6gtb0dXMAmWiWIF7tapdd8I/r+ZptEaiyxZDc8Hzg4I98ommvd9tvZYPoHSISc36BAUmfzNlY2/nl1rseDSTlh97fKs0ARD9Vo5PDty/jYx2oio9NAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732788489; c=relaxed/simple;
	bh=fjFeAp69aLVIO0wVDu1fSigcq07/jvZB32BC0bGkMvs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fQhEocA7XwIq4SJGws0lI+aBKy3EqFgYEenLZ/yKJs9UNtRUQDyWuSK+9KgotImFzC2IPFK07nfxsxG4/HjJPNvFRnxHPbOnApKBN3OEVP0TgMQwmtWRm4O/Ps6AR3yVenW84veF8HqF4rnPRPbO3b6iO6zqfSDhgCKDkg8v2uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=j92sl5vV; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4349e4e252dso5848835e9.0
        for <linux-pm@vger.kernel.org>; Thu, 28 Nov 2024 02:08:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732788486; x=1733393286; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iggMaxkg31CKVpLPkkOxhbJoBiBiL5s2N972k7ZCQI4=;
        b=j92sl5vVUimukSw1QubNYbCZvMGTIY4LWNLUNCOzWEdbV7gfskMXhblVNe9pLcCBfW
         cGsxwoJlGTU0rCsv5Ewv6Nk1CA7AXCJuquwy0L+zXbg7556gfxB3JAGYva3J5wPu5AlJ
         VeBdOoYHAseIvVMenVnwKFeipif98f4FG25nbzsmOxa/+zfRu5oqtyoiMaTQte/5ZqDr
         ebJh8oJUsnMqERrP9V51sW4HO9dcD0acWHiJLUtMIDLwKVo/eEWpGATlM5xA4xbi2sAK
         se04EBbyy361JEVwdLcZAIJoCMyddC9VbiJjFmR+xZFZwkC8PHHq1e7dRz2QYxTT/qK1
         ANuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732788486; x=1733393286;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iggMaxkg31CKVpLPkkOxhbJoBiBiL5s2N972k7ZCQI4=;
        b=vR1oO9sAKatOk7C/xgDnertNbN/TOg769YObgbGLDD1yg0YfVP3JLtk+eSBLBo2MZO
         9rZZp05RfXU0Wf1LsrHHyhEPz7Y91l0ZB3wCUXIK0O4SvE350/VhHFLu2uxJgpdW3rJ7
         dSrmDpY2ofPmUvkBoaMw6StbC/mz/+6e6pI8xpDmN/5/YMiBgpaU8KMZmmxqj+fQoh25
         t/JvxsVi6M+HrlOjxdrKq1xYwfNWRPwjL2g5GF7Qm2AkpmcwOpZg8TICzZJA5vO8LIiC
         D+soF6k+g3edRTVResour2jHNlMq0qMdlCc4g0xbRSPb9SlNOpzWmFpmho5T9UhwCdDD
         A0dg==
X-Forwarded-Encrypted: i=1; AJvYcCX+fo2eFbGoZqZlGsY3xG7wKwmlILUrxc3hYPUBPRM9AyYzkiHjgS7WatKmDC0brOywe4lrJR7J7w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4ocwW+xXvn1PuwGoSxMyDP2XyD0T34PO7DO4j1ce/89WgO5uR
	jyMrSpR8mg10/eHGuRW2FzLPEepG9n9BI3SrUE2AAGs1JfOPWMa6WHtJ4huoUjnWoZOUKIDK4Jp
	hc9Y=
X-Gm-Gg: ASbGncuuexw0oo0xdEaT8flRRHkhcb5uMrwJ1FkX3fNELnU2CIAzwSjrgAl7g33SOEH
	Ug+Q/oS0I4I7SxaMBUviTMsfofVlMvarMRGnfjQHjks49M5lQxqqN3sW1rUaRQmTduuLL7OD+XW
	168CXGOqjZ8ptaHtZ0QWYZbSuCoqL//0aQ9/xskZBtz65BiBtJVdskH9lYNH45HQZl2kuHmE/DB
	Dxn+m7y+pvyoa2zbFygcVV3ZahuBO+pDmMc030zorWo2GdizYMEBdGZe9al4mmqJAmNAFg=
X-Google-Smtp-Source: AGHT+IGaqYh8++Hs6ZMvLsZPzHjx6kgI3M+4wz3NwntUkP7YRJTycBwd8eIIy4xr6ey+r2gsvtkDlw==
X-Received: by 2002:a5d:47cb:0:b0:382:4f68:1f63 with SMTP id ffacd0b85a97d-385c6eb8478mr5927836f8f.7.1732788486135;
        Thu, 28 Nov 2024 02:08:06 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385ccd3a56fsm1230335f8f.62.2024.11.28.02.08.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2024 02:08:05 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Thu, 28 Nov 2024 11:07:55 +0100
Subject: [PATCH 2/2] OPP: fix dev_pm_opp_find_bw_*() when bandwidth table
 not initialized
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241128-topic-opp-fix-assert-index-check-v1-2-cb8bd4c0370e@linaro.org>
References: <20241128-topic-opp-fix-assert-index-check-v1-0-cb8bd4c0370e@linaro.org>
In-Reply-To: <20241128-topic-opp-fix-assert-index-check-v1-0-cb8bd4c0370e@linaro.org>
To: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, 
 Stephen Boyd <sboyd@kernel.org>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2342;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=fjFeAp69aLVIO0wVDu1fSigcq07/jvZB32BC0bGkMvs=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBnSEED/2LJf28HBreeTTOlbg+rQiIjd/Q48swiFGuU
 tqXpo2mJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZ0hBAwAKCRB33NvayMhJ0XX5D/
 0X2mKVJUyXV4sucB08Yf+hxIUO2CRlJIeObmNE7+D8kbo4fDy4mQ08P56avV9l15wjEgfbIZam1+lP
 Kz7qZ36ilO2TbfmlSFSva5DbzrDoy8u4LaJRNVLKhmCPfgoKStlEq1nVuJMsx32OZZT02sGRDmj9g6
 dBkNPRhJDJbtLN2XzmkmWOuyfvi/T8lYgrPmf6XFeVXIJtzL7DHsuvVoKdGJoSj/BIdtgymziQ7V09
 YjPEKmmQdwIyWSKlvnxB32CnrjeU0qsQjJuZB2LxMIK5NSMrMTcFLTUk4MnneTPVRd2N+ZUvvia6nW
 36ZeCYcgJV7VQMX9MaZVZw/JUQdAeuB52RsqCfb+ERpWUo8F2eMGiFzIku+Bshb3nrGuZ2POzD7XcT
 uGtSuFDHRnr23qZGflU54cL6jCyO3EMVWJwjUFGvu5XfDvTmK4LlG0RvguCBEbtEkTQe44t/Ngj4bj
 IRuFWolX26V/JIODIC1rwYCVu5lJjiQWkaYIkSDDy3c70JnVliaiVjvWi5ik6Jl63NYPsvKZqBd9HB
 zn5pVyHMCEmjjO2RpIpxzM6YKpoSXhkr5KcXVad0lMP4MtSLkzJLkzW2SApZTkJihJ0g7+lxlyC0Iu
 eELwG94TDDxCA+P20EbTGHeYErXVoVdLoi/H1XK6feGT8hSjbLtf+KQJ60rg==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

If a driver calls dev_pm_opp_find_bw_ceil/floor() the retrieve bandwidth
from the OPP table but the bandwidth table was not created because the
interconnect properties were missing in the OPP consumer node, the
kernel will crash with:
Unable to handle kernel NULL pointer dereference at virtual address 0000000000000004
...
pc : _read_bw+0x8/0x10
lr : _opp_table_find_key+0x9c/0x174
...
Call trace:
  _read_bw+0x8/0x10 (P)
  _opp_table_find_key+0x9c/0x174 (L)
  _find_key+0x98/0x168
  dev_pm_opp_find_bw_ceil+0x50/0x88
...

In order to fix the crash, create an assert function to check
if the bandwidth table were created before trying to get a
bandwidth with _read_bw().

Fixes: add1dc094a74 ("OPP: Use generic key finding helpers for bandwidth key")
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/opp/core.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 8692e8ce05b7c31a725ea3a7928f238c7a1d6f51..178780e294dad49c22d866930efb7b8b13ae2d61 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -114,6 +114,14 @@ static bool assert_clk_index(struct opp_table *opp_table, int index)
 	return opp_table->clk_count > index;
 }
 
+/*
+ * Returns true if bandwidth table is large enough to contain the bandwidth index.
+ */
+static bool assert_bandwidth_index(struct opp_table *opp_table, int index)
+{
+	return opp_table->path_count > index;
+}
+
 /**
  * dev_pm_opp_get_bw() - Gets the bandwidth corresponding to an opp
  * @opp:	opp for which bandwidth has to be returned for
@@ -913,7 +921,8 @@ struct dev_pm_opp *dev_pm_opp_find_bw_ceil(struct device *dev, unsigned int *bw,
 	unsigned long temp = *bw;
 	struct dev_pm_opp *opp;
 
-	opp = _find_key_ceil(dev, &temp, index, true, _read_bw, NULL);
+	opp = _find_key_ceil(dev, &temp, index, true, _read_bw,
+			     assert_bandwidth_index);
 	*bw = temp;
 	return opp;
 }
@@ -944,7 +953,8 @@ struct dev_pm_opp *dev_pm_opp_find_bw_floor(struct device *dev,
 	unsigned long temp = *bw;
 	struct dev_pm_opp *opp;
 
-	opp = _find_key_floor(dev, &temp, index, true, _read_bw, NULL);
+	opp = _find_key_floor(dev, &temp, index, true, _read_bw,
+			      assert_bandwidth_index);
 	*bw = temp;
 	return opp;
 }

-- 
2.34.1


