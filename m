Return-Path: <linux-pm+bounces-43477-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id k0pVEBdkpmnxPAAAu9opvQ
	(envelope-from <linux-pm+bounces-43477-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 03 Mar 2026 05:31:19 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id DB7231E8D97
	for <lists+linux-pm@lfdr.de>; Tue, 03 Mar 2026 05:31:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3191A301F6A9
	for <lists+linux-pm@lfdr.de>; Tue,  3 Mar 2026 04:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3330537CD36;
	Tue,  3 Mar 2026 04:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HfnTcdVP"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18CFA35F5FD
	for <linux-pm@vger.kernel.org>; Tue,  3 Mar 2026 04:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772512274; cv=none; b=l52zXg9et9LtFOL3EW1a27MmVodrfaqeoxyXffgRWF+bhDtLyv6Yap2Pre4xqiu95N4siCnhFOTaOpk+6DGaKArUnj7Z3iuJqp9SxHGbzDxD/4BfrJGQH8X5yvXCU5zvuk7qyVqu1XS4h1s5IxPrqwrISkB51OmkEkaHNhtjC/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772512274; c=relaxed/simple;
	bh=2Kf3LOTcLq111+z10oLFqpqx9K7MD+UA54ioA3mImpc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=POgS/gaeYNXgOVp+EZettkbY8JJgQ3+Y+w0AFKJ5XpPKCayCbfOorD4Plnx4BTMxHyT0jz3e1qbxR9KLtOdOEYIbeSO8HQVuDoFMX/VGA8Sn/8bSF4gSsBtLc4sljxCHLUznqFTiIKhwZ0MtPDryhy79Sg9ouYxs/XOASHALXtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HfnTcdVP; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-824ac5d28f9so5292618b3a.0
        for <linux-pm@vger.kernel.org>; Mon, 02 Mar 2026 20:31:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1772512272; x=1773117072; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XMHu6Y2gYxnqJzkOf4K6uEsNEzJ+7bA4f+5IkVS+SZ0=;
        b=HfnTcdVPPpVe76IRMJWMMRXzZwHTEXJmJ6Wj61JEn4J7C6FOlOf7MkCzIXHnACsAiT
         kZ8gX1yZOpmcwFCo9nGmINf7vZ1w3cOP0+Dr8jBtRzXW90eojTMuebkPC6eQ0fEkY1Zb
         +fnsjXuRe30T8C6s4ZDFPCzifTFPlwNUxyrMqqECDf+u6bW8T2DHpwhdk/3CU7RqIN04
         vb+0zwIgvDkeDU2O6N6Nmbx1pGB933ENyanuKZrdHqel9rTMU4NZtl+4Hbj6zMRUem01
         lLX1q5j3MYI6B2r3QKo3WaRsP7Ji4V4dal4d8caXuS+8XCfjOt4YgSNrGwWbBDctILRE
         kVjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772512272; x=1773117072;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XMHu6Y2gYxnqJzkOf4K6uEsNEzJ+7bA4f+5IkVS+SZ0=;
        b=s2zPdkefj3a/pjPvq8dLKL2ZIOS58MaYDqn5CKUBVXa7Xkqa5Xj5nT1QbENUGxsTN9
         DfKCaoQnUYQ67fD5A0EE+2i8M6Hk4nPjvEWu49kJgy8TnlHg7UcrMHYY/gepd+p2PfK5
         dmo1/FgDdgpUI8B90FDGgV1hbTmbYiWuAPP1/V3R3kpkYHZ8vs8FjAy15v7CeH5mM2uS
         3x1phjbIfJZD8t/i8+HWRMSNDkrcYfWLBc7+6iG9NfVt+yAwuUapr10fTbUzpAx0TqSn
         rIkdUkCjoJPNY38vSdvzzgFQjlbuoypvVJyMlklezsFtIpWRqMpdXhZUDm39ZJPjzWUf
         GAAw==
X-Forwarded-Encrypted: i=1; AJvYcCXbJB9RjYwQ9CDeenFv/ZHZNpVOcuEBmYzAESLQ7tV8yXpxdcYrVwcfAy69PMIaQiigrHKePbusig==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxn2D7X61Oq5EHdC4CQSAv6H0uSFmah9i6wfydAgZ2W7Q8wLpFU
	pm+BKsZWTuzWLAHKW8PJhHxKKNz/p8629jGmYxSSrCfWs4m2VVbqxaqI+OhFXt5K/Ro=
X-Gm-Gg: ATEYQzxgelefW8u7eesbV71zUKAxyWylviUSgXueHjEljc+9NbV3YVfEgfR52LbfQi1
	SQpSon3WwySc5rxROWTdmhYrEyY6viB9peuSQPp0bqQ8h0Dbms/whsP15D9CqCOFBom7XPDZjIw
	v7Xv1ZuWZGDLEvjlVmTmaprKKeC/sBznUJ6vP9dqUBP5l9Z//7m65PsPajII2zzasI5g01fpolB
	YbBwvvprj9o5zMAnbTeP66XqhioQAFh00PBBV01/BAoCeMRl8tAt1UdzbHWWCBlUrMO4PVFvDxq
	c+v6PnN6J3jBhRX5wUCGoEAXnY1qhDPm9Z5w9jcRWR+yTLFQZN6xlpQ6YWk5zy3eGa2KWkX47QD
	jxfwsY17GWnnVyAIiZJ33jRgNy5ejvhoagNcN7DUHIhqv7G99F4MXR6ZHyiv7hnAIOWhBJmMpe3
	PdSx3Xc4HJIwTWl0OAUTgBCBmq
X-Received: by 2002:a05:6a00:9086:b0:81e:a228:f0cb with SMTP id d2e1a72fcca58-8274d9d9b38mr16557258b3a.36.1772512272261;
        Mon, 02 Mar 2026 20:31:12 -0800 (PST)
Received: from localhost ([122.172.81.200])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82739d5689csm18593111b3a.13.2026.03.02.20.31.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 20:31:11 -0800 (PST)
Date: Tue, 3 Mar 2026 10:01:06 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
	Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@kernel.org>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Ilia Lin <ilia.lin@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] of: Add and use of_machine_get_match() helper
Message-ID: <bmwutmbouey22o4zj2a4zdgahuzwdwwwnd3hagbe7ql2zcjckb@d7ytvwbpimsd>
References: <cover.1772468323.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1772468323.git.geert+renesas@glider.be>
X-Rspamd-Queue-Id: DB7231E8D97
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43477-lists,linux-pm=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[oss.qualcomm.com,kernel.org,gmail.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[viresh.kumar@linaro.org,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[linaro.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm,renesas];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,linaro.org:dkim,linaro.org:email]
X-Rspamd-Action: no action

On 02-03-26, 17:29, Geert Uytterhoeven wrote:
> Geert Uytterhoeven (7):
>   cpufreq: airoha: Convert to of_machine_get_match()
>   cpufreq: qcom-nvmem: Convert to of_machine_get_match()
>   cpufreq: ti-cpufreq: Convert to of_machine_get_match()

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

