Return-Path: <linux-pm+bounces-20866-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFFD0A1A36B
	for <lists+linux-pm@lfdr.de>; Thu, 23 Jan 2025 12:45:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E60A616C6F1
	for <lists+linux-pm@lfdr.de>; Thu, 23 Jan 2025 11:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28B27217739;
	Thu, 23 Jan 2025 11:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nSVzSVr9"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADDD621772B
	for <linux-pm@vger.kernel.org>; Thu, 23 Jan 2025 11:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737632385; cv=none; b=Ajcqv4pyae9FvrJWEWk6JQ3TzaxdNQlm0Zq6OWuTPyrShMtWe8UiymReLRu9P3sl6EeECEEAIXdCd+t8gKHNEfalAtX5xD3DBuLSpw7QJVtvjU4uJvkCrbSc6vuti8DzMwrDrpk6rg6nCrpq3Z8fbx06lvavacmTc3UHk8A2eFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737632385; c=relaxed/simple;
	bh=eofYrMAlyFUOfvE8J67A4zVSwYQVPwRTWfHU8IdSj3k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gIWh+i7mUQoISq8NBQe9JV5WEapro3Obr2iLuoY3L9eKo3GoGl0sCzEqMENHXJYjryteXZk+SGuaoIcwIDIj6yqxlmGkH61rgqKbUATuJhNe9jQVE7wukbyPqh2jPExhDg1wSNxRNlanRG48ypUNZEKJh/tr93GqVY2Exxo81PY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nSVzSVr9; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-21649a7bcdcso12449715ad.1
        for <linux-pm@vger.kernel.org>; Thu, 23 Jan 2025 03:39:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737632383; x=1738237183; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rb2rqEJd02k20/AhSog2v3OCrcQN7RS+AjxhMFEwgGo=;
        b=nSVzSVr9LWoRKSUoUvqJC/IxrMNirQbDC17L8GxOxCuv9avTouguHE0jLem4VYFzDu
         LiuJD4yjIwTbdUR6MfeGSgPTUbl3CPpPR+s02cGokrzSzUSUnmosd6sO5gSvCX0QsMUY
         CHhEJjNmEeSRQKRXiuun/IoZPMpfRHZ9+ZAOZ3ozaIQvXrgNDljsFM7wHV7Hf/caxlQv
         tGOdehTCtJs/DczHX/WYa1wDrqU7mMKtF2wFqw0bUjtowY66Vgly4mwVuaZkQ3D0J6KS
         PKhUSBikExEaE2vYNpA5XZ0gItdnesxLxsT31K/xeImB40VWXMpEhL8jyTxk9fozEB65
         ZGFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737632383; x=1738237183;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rb2rqEJd02k20/AhSog2v3OCrcQN7RS+AjxhMFEwgGo=;
        b=vjkj0camddU5bvM5GxuvU8zNol7jpNQM522Nnq0ysmqaiAYtw+2RzAK0rPjXaQeJud
         AwtiUq/WcqrxgA4jt00zUesjmTNrg13SZJoftS37ui/Lia1w5aC98QInKrWEWMBJp3vs
         cbKfbDUs7kWn6VHxjevGqKBKteTepB4Nx0I+IeAwxLtGhqN1wuB786w5k3DJUgO9zkik
         XPad/biSKe3Uv9gNbNurlbQ9psfu2z/sD42lbKqxyk3sAbbMsRVAUETYFPZeHQ/oFStF
         jriZJXmbzs0NtSq58dk6yPAweunbGkf8itchFzPBUJOo0nPHsq3iKqNgoGs8cer5VWJR
         QrTw==
X-Gm-Message-State: AOJu0YzWuK5PFQDhCJub4OvCTtFGv6ujyZ2fFdTow7lTqoDggL7ey+jW
	YXZfrUl0jAhdYvG690a3IndVHRagChFzZmhF2E2GPGNoUmDZJgS6mszA1H0PlV0=
X-Gm-Gg: ASbGncsSyxZDa2EL57wxFzHr6aVt3Xd0gOX2V0I+Rcwq6mnHWTpy6gfNVmG5ZPG8vGY
	Gg5FTlG/VGUd+Vu3u0Dj99qy8oNkg7cU67GjAadagPwMT9RzJCSITagXADsBYE7DN2naCKMzfXa
	05xTvrDLnX3OJU2WIc+DPcdC/TkJgIlIImOC+J++xAo1CHfDsT1Ht3+z7NlVC++1298MMq54KtL
	xxM0bkLnjTC1wqfsRVn/Dk3ojK8ofBEPnT4+f05FLdG2zqYg1s6tyht0xErrBycuaVO/yqFwO7F
	4ZJqvPQ=
X-Google-Smtp-Source: AGHT+IGfdcmFFMWXsL9R37HEeSmVQ+IjPSu61yVqhm5T58o74JeCbGEVeItG8c5Wzh+RQYFtC1lURg==
X-Received: by 2002:a05:6a21:7895:b0:1e8:a13b:3885 with SMTP id adf61e73a8af0-1eb215fb145mr44955603637.35.1737632382985;
        Thu, 23 Jan 2025 03:39:42 -0800 (PST)
Received: from localhost ([122.172.84.139])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-a9bdd4f6e5dsm10604521a12.59.2025.01.23.03.39.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 03:39:42 -0800 (PST)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Sudeep Holla <sudeep.holla@arm.com>
Cc: linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 30/33] cpufreq: vexpress: Stop setting cpufreq_driver->attr field
Date: Thu, 23 Jan 2025 17:06:06 +0530
Message-Id: <62b1f43c0fe1fcedfeaedee9e7d8f18953bfe36c.1737631669.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1737631669.git.viresh.kumar@linaro.org>
References: <cover.1737631669.git.viresh.kumar@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The cpufreq core handles this for basic attributes now, the driver can skip
setting them.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/vexpress-spc-cpufreq.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/cpufreq/vexpress-spc-cpufreq.c b/drivers/cpufreq/vexpress-spc-cpufreq.c
index 0f86cdb7ec8a..65fea47b82e6 100644
--- a/drivers/cpufreq/vexpress-spc-cpufreq.c
+++ b/drivers/cpufreq/vexpress-spc-cpufreq.c
@@ -471,7 +471,6 @@ static struct cpufreq_driver ve_spc_cpufreq_driver = {
 	.init			= ve_spc_cpufreq_init,
 	.exit			= ve_spc_cpufreq_exit,
 	.register_em		= cpufreq_register_em_with_opp,
-	.attr			= cpufreq_generic_attr,
 };
 
 #ifdef CONFIG_BL_SWITCHER
-- 
2.31.1.272.g89b43f80a514


